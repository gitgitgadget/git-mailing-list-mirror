From: Jeff King <peff@peff.net>
Subject: [PATCH v2 4/4] pack-refs: add fully-peeled trait
Date: Sun, 17 Mar 2013 04:28:29 -0400
Message-ID: <20130317082829.GD29550@sigill.intra.peff.net>
References: <20130317082139.GA29505@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 17 09:29:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH8xj-0005GU-Un
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 09:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755782Ab3CQI2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 04:28:36 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54185 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754612Ab3CQI2c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 04:28:32 -0400
Received: (qmail 7794 invoked by uid 107); 17 Mar 2013 08:30:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Mar 2013 04:30:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Mar 2013 04:28:29 -0400
Content-Disposition: inline
In-Reply-To: <20130317082139.GA29505@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218349>

From: Michael Haggerty <mhagger@alum.mit.edu>

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

Signed-off-by: Jeff King <peff@peff.net>
---
This uses Michael's approach for managing the flags within
read_packed_refs, which is more readable. As I picked up his
code and comments, I realized that there was basically
nothing of mine left, so I switched the authorship. But do
note:

  1. It should have Michael's signoff, which was not present
     in the commit I lifted the code from.

  2. I tweaked the big comment above read_packed_refs to
     reduce some ambiguities. Please double-check that I am
     not putting inaccurate words in your mouth. :)

 pack-refs.c         |  2 +-
 refs.c              | 43 +++++++++++++++++++++++++++++++++++++++++--
 t/t3211-peel-ref.sh | 22 ++++++++++++++++++++++
 3 files changed, 64 insertions(+), 3 deletions(-)

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
index 175b9fc..bdeac28 100644
--- a/refs.c
+++ b/refs.c
@@ -803,11 +803,39 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
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
+ *	Probably no references are peeled. But if the file contains a
+ *	peeled value for a reference, we will use it.
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
+ *      Inversely (and this is more important, any references in the
+ *      file for which no peeled value is recorded is not peelable. This
+ *      trait should typically be written alongside "fully-peeled" for
+ *      compatibility with older clients, but we do not require it
+ *      (i.e., "peeled" is a no-op if "fully-peeled" is set).
+ */
 static void read_packed_refs(FILE *f, struct ref_dir *dir)
 {
 	struct ref_entry *last = NULL;
 	char refline[PATH_MAX];
 	int flag = REF_ISPACKED;
+	int refs_tags_peeled = 0;
 
 	while (fgets(refline, sizeof(refline), f)) {
 		unsigned char sha1[20];
@@ -816,8 +844,10 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 
 		if (!strncmp(refline, header, sizeof(header)-1)) {
 			const char *traits = refline + sizeof(header) - 1;
-			if (strstr(traits, " peeled "))
+			if (strstr(traits, " fully-peeled "))
 				flag |= REF_KNOWS_PEELED;
+			else if (strstr(traits, " peeled "))
+				refs_tags_peeled = 1;
 			/* perhaps other traits later as well */
 			continue;
 		}
@@ -825,6 +855,8 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 		refname = parse_ref_line(refline, sha1);
 		if (refname) {
 			last = create_ref_entry(refname, sha1, flag, 1);
+			if (refs_tags_peeled && !prefixcmp(refname, "refs/tags/"))
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
