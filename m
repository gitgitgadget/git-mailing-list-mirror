From: Jeff King <peff@peff.net>
Subject: [PATCH v2 5/5] refs.c: drop curate_packed_refs
Date: Fri, 20 Mar 2015 14:43:17 -0400
Message-ID: <20150320184317.GE23849@peff.net>
References: <20150320184215.GA26368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 19:44:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ1uU-0003dF-M6
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 19:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbbCTSoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 14:44:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:36038 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751597AbbCTSnT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 14:43:19 -0400
Received: (qmail 29050 invoked by uid 102); 20 Mar 2015 18:43:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 13:43:19 -0500
Received: (qmail 26957 invoked by uid 107); 20 Mar 2015 18:43:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 14:43:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 14:43:17 -0400
Content-Disposition: inline
In-Reply-To: <20150320184215.GA26368@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265932>

When we delete a ref, we have to rewrite the entire
packed-refs file. We take this opportunity to "curate" the
packed-refs file and drop any entries that are crufty or
broken.

Dropping broken entries (e.g., with bogus names, or ones
that point to missing objects) is actively a bad idea, as it
means that we lose any notion that the data was there in the
first place. Aside from the general hackiness that we might
lose any information about ref "foo" while deleting an
unrelated ref "bar", this may seriously hamper any attempts
by the user at recovering from the corruption in "foo".

They will lose the sha1 and name of "foo"; the exact pointer
may still be useful even if they recover missing objects
from a different copy of the repository. But worse, once the
ref is gone, there is no trace of the corruption. A
follow-up "git prune" may delete objects, even though it
would otherwise bail when seeing corruption.

We could just drop the "broken" bits from
curate_packed_refs, and continue to drop the "crufty" bits:
refs whose loose counterpart exists in the filesystem. This
is not wrong to do, and it does have the advantage that we
may write out a slightly smaller packed-refs file. But it
has two disadvantages:

  1. It is a potential source of races or mistakes with
     respect to these refs that are otherwise unrelated to
     the operation. To my knowledge, there aren't any active
     problems in this area, but it seems like an unnecessary
     risk.

  2. We have to spend time looking up the matching loose
     refs for every item in the packed-refs file. If you
     have a large number of packed refs that do not change,
     that outweighs the benefit from writing out a smaller
     packed-refs file (it doesn't get smaller, and you do a
     bunch of directory traversal to find that out).

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c                      | 67 +--------------------------------------------
 t/t5312-prune-corruption.sh |  2 +-
 2 files changed, 2 insertions(+), 67 deletions(-)

diff --git a/refs.c b/refs.c
index 7f0e7be..47e4e53 100644
--- a/refs.c
+++ b/refs.c
@@ -2621,68 +2621,10 @@ int pack_refs(unsigned int flags)
 	return 0;
 }
 
-/*
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
-		if (read_ref_full(entry->name, 0, sha1, &flags))
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
 int repack_without_refs(struct string_list *refnames, struct strbuf *err)
 {
 	struct ref_dir *packed;
-	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
-	struct string_list_item *refname, *ref_to_delete;
+	struct string_list_item *refname;
 	int ret, needs_repacking = 0, removed = 0;
 
 	assert(err);
@@ -2718,13 +2660,6 @@ int repack_without_refs(struct string_list *refnames, struct strbuf *err)
 		return 0;
 	}
 
-	/* Remove any other accumulated cruft */
-	do_for_each_entry_in_dir(packed, 0, curate_packed_ref_fn, &refs_to_delete);
-	for_each_string_list_item(ref_to_delete, &refs_to_delete) {
-		if (remove_entry(packed, ref_to_delete->string) == -1)
-			die("internal error");
-	}
-
 	/* Write what remains */
 	ret = commit_packed_refs();
 	if (ret)
diff --git a/t/t5312-prune-corruption.sh b/t/t5312-prune-corruption.sh
index e8d04ef..8e98b44 100755
--- a/t/t5312-prune-corruption.sh
+++ b/t/t5312-prune-corruption.sh
@@ -105,7 +105,7 @@ test_expect_success 'pack-refs does not silently delete broken packed ref' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'pack-refs does not drop broken refs during deletion' '
+test_expect_success 'pack-refs does not drop broken refs during deletion' '
 	git update-ref -d refs/heads/other &&
 	git rev-parse refs/heads/master >actual &&
 	test_cmp expect actual
-- 
2.3.3.520.g3cfbb5d
