From: Jeff King <peff@peff.net>
Subject: [PATCH v3 4/4] pack-refs: add fully-peeled trait
Date: Mon, 18 Mar 2013 07:37:32 -0400
Message-ID: <20130318113732.GA14789@sigill.intra.peff.net>
References: <20130317082139.GA29505@sigill.intra.peff.net>
 <20130317082829.GD29550@sigill.intra.peff.net>
 <7vli9lre1j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 12:38:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHYOF-0000Y3-RA
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 12:38:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581Ab3CRLhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 07:37:40 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55924 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899Ab3CRLhj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 07:37:39 -0400
Received: (qmail 15652 invoked by uid 107); 18 Mar 2013 11:39:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Mar 2013 07:39:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2013 07:37:32 -0400
Content-Disposition: inline
In-Reply-To: <7vli9lre1j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218403>

On Sun, Mar 17, 2013 at 01:01:44PM -0700, Junio C Hamano wrote:

> > + *      All references in the file that can be peeled are peeled.
> > + *      Inversely (and this is more important, any references in the
> 
> A missing closing paren after "more important".  Also the e-mail
> quote reveals there is some inconsistent indentation (HTs vs runs of
> SPs) here.

Thanks, will fix (the whitespace damage is due to me cutting and pasting
from Michael's commit).

> 
> > + *      file for which no peeled value is recorded is not peelable. This
> > + *      trait should typically be written alongside "fully-peeled" for
> 
> Alongside "peeled", no?

Urgh, yes. Will fix.

> [...]
> I am not sure why you find this any more readable.

I was trying to avoid the "set PEELED globally, but sometimes unset it
for specific refs" pattern which I think is confusing to the reader. But
I think what you wrote is even better. I used an enum rather than two
variables to make it clear that only ones takes effect. I had wanted to
use a switch, also, but you end up either repeating yourself, or doing
this gross fall-through:

  switch (peeled) {
  case PEELED_TAGS:
          if (prefixcmp(refname, "refs/tags/"))
                  break;
          /* fall-through */
  case PEELED_FULLY:
          last->ref |= REF_KNOWS_PEELED;
          break;
  default:
          /* we know nothing */
  }

So I just stuck with the conditional.

Here's the re-roll.

-- >8 --
From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] pack-refs: add fully-peeled trait

Older versions of pack-refs did not write peel lines for
refs outside of refs/tags. This meant that on reading the
pack-refs file, we might set the REF_KNOWS_PEELED flag for
such a ref, even though we do not know anything about its
peeled value.

The previous commit updated the writer to always peel, no
matter what the ref is. That means that packed-refs files
written by newer versions of git are fine to be read by both
old and new versions of git. However, we still have the
problem of reading packed-refs files written by older
versions of git, or by other implementations which have not
yet learned the same trick.

The simplest fix would be to always unset the
REF_KNOWS_PEELED flag for refs outside of refs/tags that do
not have a peel line (if it has a peel line, we know it is
valid, but we cannot assume a missing peel line means
anything). But that loses an important optimization, as
upload-pack should not need to load the object pointed to by
refs/heads/foo to determine that it is not a tag.

Instead, we add a "fully-peeled" trait to the packed-refs
file. If it is set, we know that we can trust a missing peel
line to mean that a ref cannot be peeled. Otherwise, we fall
back to assuming nothing.

[commit message and tests by Jeff King <peff@peff.net>]

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jeff King <peff@peff.net>
---
 pack-refs.c         |  2 +-
 refs.c              | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
 t/t3211-peel-ref.sh | 22 ++++++++++++++++++++++
 3 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/pack-refs.c b/pack-refs.c
index ebde785..4461f71 100644
--- a/pack-refs.c
+++ b/pack-refs.c
@@ -128,7 +128,7 @@ int pack_refs(unsigned int flags)
 		die_errno("unable to create ref-pack file structure");
 
 	/* perhaps other traits later as well */
-	fprintf(cbdata.refs_file, "# pack-refs with: peeled \n");
+	fprintf(cbdata.refs_file, "# pack-refs with: peeled fully-peeled \n");
 
 	for_each_ref(handle_one_ref, &cbdata);
 	if (ferror(cbdata.refs_file))
diff --git a/refs.c b/refs.c
index 175b9fc..e2b760d 100644
--- a/refs.c
+++ b/refs.c
@@ -803,11 +803,38 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 	return line;
 }
 
+/*
+ * Read f, which is a packed-refs file, into dir.
+ *
+ * A comment line of the form "# pack-refs with: " may contain zero or
+ * more traits. We interpret the traits as follows:
+ *
+ *   No traits:
+ *
+ *      Probably no references are peeled. But if the file contains a
+ *      peeled value for a reference, we will use it.
+ *
+ *   peeled:
+ *
+ *      References under "refs/tags/", if they *can* be peeled, *are*
+ *      peeled in this file. References outside of "refs/tags/" are
+ *      probably not peeled even if they could have been, but if we find
+ *      a peeled value for such a reference we will use it.
+ *
+ *   fully-peeled:
+ *
+ *      All references in the file that can be peeled are peeled.
+ *      Inversely (and this is more important), any references in the
+ *      file for which no peeled value is recorded is not peelable. This
+ *      trait should typically be written alongside "peeled" for
+ *      compatibility with older clients, but we do not require it
+ *      (i.e., "peeled" is a no-op if "fully-peeled" is set).
+ */
 static void read_packed_refs(FILE *f, struct ref_dir *dir)
 {
 	struct ref_entry *last = NULL;
 	char refline[PATH_MAX];
-	int flag = REF_ISPACKED;
+	enum { PEELED_NONE, PEELED_TAGS, PEELED_FULLY } peeled = PEELED_NONE;
 
 	while (fgets(refline, sizeof(refline), f)) {
 		unsigned char sha1[20];
@@ -816,15 +843,20 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 
 		if (!strncmp(refline, header, sizeof(header)-1)) {
 			const char *traits = refline + sizeof(header) - 1;
-			if (strstr(traits, " peeled "))
-				flag |= REF_KNOWS_PEELED;
+			if (strstr(traits, " fully-peeled "))
+				peeled = PEELED_FULLY;
+			else if (strstr(traits, " peeled "))
+				peeled = PEELED_TAGS;
 			/* perhaps other traits later as well */
 			continue;
 		}
 
 		refname = parse_ref_line(refline, sha1);
 		if (refname) {
-			last = create_ref_entry(refname, sha1, flag, 1);
+			last = create_ref_entry(refname, sha1, REF_ISPACKED, 1);
+			if (peeled == PEELED_FULLY ||
+			    (peeled == PEELED_TAGS && !prefixcmp(refname, "refs/tags/")))
+				last->flag |= REF_KNOWS_PEELED;
 			add_ref(dir, last);
 			continue;
 		}
@@ -832,8 +864,15 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 		    refline[0] == '^' &&
 		    strlen(refline) == 42 &&
 		    refline[41] == '\n' &&
-		    !get_sha1_hex(refline + 1, sha1))
+		    !get_sha1_hex(refline + 1, sha1)) {
 			hashcpy(last->u.value.peeled, sha1);
+			/*
+			 * Regardless of what the file header said,
+			 * we definitely know the value of *this*
+			 * reference:
+			 */
+			last->flag |= REF_KNOWS_PEELED;
+		}
 	}
 }
 
diff --git a/t/t3211-peel-ref.sh b/t/t3211-peel-ref.sh
index 85f09be..d4d7792 100755
--- a/t/t3211-peel-ref.sh
+++ b/t/t3211-peel-ref.sh
@@ -39,4 +39,26 @@ test_expect_success 'refs are peeled outside of refs/tags (packed)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'create old-style pack-refs without fully-peeled' '
+	# Git no longer writes without fully-peeled, so we just write our own
+	# from scratch; we could also munge the existing file to remove the
+	# fully-peeled bits, but that seems even more prone to failure,
+	# especially if the format ever changes again. At least this way we
+	# know we are emulating exactly what an older git would have written.
+	{
+		echo "# pack-refs with: peeled " &&
+		print_ref "refs/heads/master" &&
+		print_ref "refs/outside/foo" &&
+		print_ref "refs/tags/base" &&
+		print_ref "refs/tags/foo" &&
+		echo "^$(git rev-parse "refs/tags/foo^{}")"
+	} >tmp &&
+	mv tmp .git/packed-refs
+'
+
+test_expect_success 'refs are peeled outside of refs/tags (old packed)' '
+	git show-ref -d >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.2.rc2.7.gef06216
