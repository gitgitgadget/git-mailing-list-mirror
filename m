From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] pack-refs: add fully-peeled trait
Date: Sat, 16 Mar 2013 05:01:16 -0400
Message-ID: <20130316090116.GB26855@sigill.intra.peff.net>
References: <20130316090018.GA26708@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 16 10:01:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGmzr-0004Nn-M4
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 10:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091Ab3CPJBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 05:01:21 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53390 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751948Ab3CPJBU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 05:01:20 -0400
Received: (qmail 32736 invoked by uid 107); 16 Mar 2013 09:03:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 16 Mar 2013 05:03:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Mar 2013 05:01:16 -0400
Content-Disposition: inline
In-Reply-To: <20130316090018.GA26708@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218290>

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

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-refs.c         |  2 +-
 refs.c              | 16 +++++++++++++++-
 t/t3211-peel-ref.sh | 22 ++++++++++++++++++++++
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/pack-refs.c b/pack-refs.c
index 10832d7..87ca04d 100644
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
index 175b9fc..6a38c41 100644
--- a/refs.c
+++ b/refs.c
@@ -808,6 +808,7 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 	struct ref_entry *last = NULL;
 	char refline[PATH_MAX];
 	int flag = REF_ISPACKED;
+	int fully_peeled = 0;
 
 	while (fgets(refline, sizeof(refline), f)) {
 		unsigned char sha1[20];
@@ -818,13 +819,26 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 			const char *traits = refline + sizeof(header) - 1;
 			if (strstr(traits, " peeled "))
 				flag |= REF_KNOWS_PEELED;
+			if (strstr(traits, " fully-peeled "))
+				fully_peeled = 1;
 			/* perhaps other traits later as well */
 			continue;
 		}
 
 		refname = parse_ref_line(refline, sha1);
 		if (refname) {
-			last = create_ref_entry(refname, sha1, flag, 1);
+			/*
+			 * Older git did not write peel lines for anything
+			 * outside of refs/tags/; if the fully-peeled trait
+			 * is not set, we are dealing with such an older
+			 * git and cannot assume an omitted peel value
+			 * means the ref is not a tag object.
+			 */
+			int this_flag = flag;
+			if (!fully_peeled && prefixcmp(refname, "refs/tags/"))
+				this_flag &= ~REF_KNOWS_PEELED;
+
+			last = create_ref_entry(refname, sha1, this_flag, 1);
 			add_ref(dir, last);
 			continue;
 		}
diff --git a/t/t3211-peel-ref.sh b/t/t3211-peel-ref.sh
index dd5b48b..a8eb1aa 100755
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
