From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fsck: return non-zero status on missing ref tips
Date: Fri, 12 Sep 2014 00:29:39 -0400
Message-ID: <20140912042939.GA5968@peff.net>
References: <1409177412.15185.3.camel@leckie>
 <20140829185325.GC29456@peff.net>
 <xmqqha0v5cgn.fsf@gitster.dls.corp.google.com>
 <1409343480.19256.2.camel@leckie>
 <20140829203145.GA510@peff.net>
 <xmqq4mwgjvt6.fsf_-_@gitster.dls.corp.google.com>
 <20140909220709.GA14029@peff.net>
 <20140912033830.GA5507@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 06:29:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSIUU-0004mW-Fc
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 06:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbaILE3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 00:29:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:47310 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750863AbaILE3m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 00:29:42 -0400
Received: (qmail 31520 invoked by uid 102); 12 Sep 2014 04:29:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Sep 2014 23:29:42 -0500
Received: (qmail 31677 invoked by uid 107); 12 Sep 2014 04:30:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Sep 2014 00:30:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Sep 2014 00:29:39 -0400
Content-Disposition: inline
In-Reply-To: <20140912033830.GA5507@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256896>

[+cc mhagger for packed-refs wisdom]

On Thu, Sep 11, 2014 at 11:38:30PM -0400, Jeff King wrote:

> Fsck tries hard to detect missing objects, and will complain
> (and exit non-zero) about any inter-object links that are
> missing. However, it will not exit non-zero for any missing
> ref tips, meaning that a severely broken repository may
> still pass "git fsck && echo ok".
> 
> The problem is that we use for_each_ref to iterate over the
> ref tips, which hides broken tips. It does at least print an
> error from the refs.c code, but fsck does not ever see the
> ref and cannot note the problem in its exit code. We can solve
> this by using for_each_rawref and noting the error ourselves.

There's a possibly related problem with packed-refs that I noticed while
looking at this.

When we call pack-refs, it will refuse to pack any broken loose refs,
and leave them loose. Which is sane. But when we delete a ref, we need
to rewrite the packed-refs file, and we omit any broken packed refs. We
wouldn't have written a broken entry, but we may get broken later (i.e.,
the tip object may go missing after the packed-refs file is written).

If we only have a packed copy of "refs/heads/master" and it is broken,
then deleting any _other_ unrelated ref will cause refs/heads/master to
be dropped from the packed-refs file entirely. We get an error message,
but that's easy to miss, and the pointer to master's sha1 is lost
forever.

This test (on top of the patch I just sent) demonstrates:

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index b52397a..b0f4545 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -317,6 +317,7 @@ create_repo_missing () {
 		git commit -m two &&
 		unrelated=$(echo unrelated | git hash-object --stdin -w) &&
 		git tag -m foo tag $unrelated &&
+		git pack-refs --all --prune &&
 		sha1=$(git rev-parse --verify "$1") &&
 		path=$(echo $sha1 | sed 's|..|&/|') &&
 		rm .git/objects/$path
@@ -358,4 +359,10 @@ test_expect_success 'fsck notices ref pointing to missing tag' '
 	test_must_fail git -C missing fsck
 '
 
+test_expect_success 'ref deletion does not eat broken refs' '
+	create_repo_missing HEAD &&
+	git -C missing update-ref -d refs/tags/tag &&
+	test_must_fail git -C missing fsck
+'
+
 test_done


The fsck will succeed even though "master" should be broken, because
we appear to have no refs at all.

The fault is in curate_packed_ref_fn, which drops crufty from
packed-refs as we repack. That in turn is representing an older:

         if (!ref_resolves_to_object(entry))
                 return 0; /* Skip broken refs */

which comes from 624cac3 (refs: change the internal reference-iteration
API, 2013-04-22). But that was just maintaining the existing behavior,
which was using a do_for_each_ref iteration without INCLUDE_BROKEN. So I
think this problem has a similar root, though the fix is now slightly
different.

I am tempted to say that we do not need to do curate_each_ref_fn at all.
Any entry with a broken sha1 is either:

  1. A truly broken ref, in which case we should make sure to keep it
     (i.e., it is not cruft at all).

  2. A crufty entry that has been replaced by a loose reference that has
     not yet been packed. Such a crufty entry may point to broken
     objects, and that is OK.

In case 2, we _could_ delete the cruft. But I do not think we need to.
The loose ref will take precedence to anybody who actually does a ref
lookup, so the cruft is not hurting anybody.

Dropping curate_packed_ref_fn (as below) fixes the test above. And
miraculously does not even seem to conflict with ref patches in pu. :)

Am I missing any case that it is actually helping?

diff --git a/refs.c b/refs.c
index a7853cc..83c2bf7 100644
--- a/refs.c
+++ b/refs.c
@@ -2484,70 +2484,11 @@ int pack_refs(unsigned int flags)
 }
 
 /*
- * If entry is no longer needed in packed-refs, add it to the string
- * list pointed to by cb_data.  Reasons for deleting entries:
- *
- * - Entry is broken.
- * - Entry is overridden by a loose ref.
- * - Entry does not point at a valid object.
- *
- * In the first and third cases, also emit an error message because these
- * are indications of repository corruption.
- */
-static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
-{
-	struct string_list *refs_to_delete = cb_data;
-
-	if (entry->flag & REF_ISBROKEN) {
-		/* This shouldn't happen to packed refs. */
-		error("%s is broken!", entry->name);
-		string_list_append(refs_to_delete, entry->name);
-		return 0;
-	}
-	if (!has_sha1_file(entry->u.value.sha1)) {
-		unsigned char sha1[20];
-		int flags;
-
-		if (read_ref_full(entry->name, sha1, 0, &flags))
-			/* We should at least have found the packed ref. */
-			die("Internal error");
-		if ((flags & REF_ISSYMREF) || !(flags & REF_ISPACKED)) {
-			/*
-			 * This packed reference is overridden by a
-			 * loose reference, so it is OK that its value
-			 * is no longer valid; for example, it might
-			 * refer to an object that has been garbage
-			 * collected.  For this purpose we don't even
-			 * care whether the loose reference itself is
-			 * invalid, broken, symbolic, etc.  Silently
-			 * remove the packed reference.
-			 */
-			string_list_append(refs_to_delete, entry->name);
-			return 0;
-		}
-		/*
-		 * There is no overriding loose reference, so the fact
-		 * that this reference doesn't refer to a valid object
-		 * indicates some kind of repository corruption.
-		 * Report the problem, then omit the reference from
-		 * the output.
-		 */
-		error("%s does not point to a valid object!", entry->name);
-		string_list_append(refs_to_delete, entry->name);
-		return 0;
-	}
-
-	return 0;
-}
-
-/*
  * Must be called with packed refs already locked (and sorted)
  */
 static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 {
 	struct ref_dir *packed;
-	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
-	struct string_list_item *ref_to_delete;
 	int i, ret;
 
 	/* Look for a packed ref */
@@ -2561,15 +2502,6 @@ static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	for (i = 0; i < n; i++)
 		remove_entry(packed, refnames[i]);
 
-	/* Remove any other accumulated cruft */
-	do_for_each_entry_in_dir(packed, 0, curate_packed_ref_fn, &refs_to_delete);
-	for_each_string_list_item(ref_to_delete, &refs_to_delete) {
-		if (remove_entry(packed, ref_to_delete->string) == -1) {
-			rollback_packed_refs();
-			die("internal error");
-		}
-	}
-
 	/* Write what remains */
 	ret = commit_packed_refs();
 	if (ret && err)
