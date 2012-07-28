From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] fsck: detect null sha1 in tree entries
Date: Sat, 28 Jul 2012 11:06:29 -0400
Message-ID: <20120728150629.GC25269@sigill.intra.peff.net>
References: <20120728150132.GA25042@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 17:06:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv8bG-0003Gt-FA
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 17:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686Ab2G1PGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 11:06:33 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40026 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752449Ab2G1PGd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 11:06:33 -0400
Received: (qmail 31368 invoked by uid 107); 28 Jul 2012 15:06:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 28 Jul 2012 11:06:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Jul 2012 11:06:29 -0400
Content-Disposition: inline
In-Reply-To: <20120728150132.GA25042@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202443>

Short of somebody happening to beat the 1 in 2^160 odds of
actually generating content that hashes to the null sha1, we
should never see this value in a tree entry. So let's have
fsck warn if it it seen.

As in the previous commit, we test both blob and submodule
entries to future-proof the test suite against the
implementation depending on connectivity to notice the
error.

Signed-off-by: Jeff King <peff@peff.net>
---
I left this as a warning, because git can still mostly handle such
trees, which may aid in debugging or salvaging data.

 fsck.c          |  8 +++++++-
 t/t1450-fsck.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index 4c63b2c..7395ef6 100644
--- a/fsck.c
+++ b/fsck.c
@@ -139,6 +139,7 @@ static int verify_ordered(unsigned mode1, const char *name1, unsigned mode2, con
 static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 {
 	int retval;
+	int has_null_sha1 = 0;
 	int has_full_path = 0;
 	int has_empty_name = 0;
 	int has_zero_pad = 0;
@@ -157,9 +158,12 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 	while (desc.size) {
 		unsigned mode;
 		const char *name;
+		const unsigned char *sha1;
 
-		tree_entry_extract(&desc, &name, &mode);
+		sha1 = tree_entry_extract(&desc, &name, &mode);
 
+		if (is_null_sha1(sha1))
+			has_null_sha1 = 1;
 		if (strchr(name, '/'))
 			has_full_path = 1;
 		if (!*name)
@@ -207,6 +211,8 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 	}
 
 	retval = 0;
+	if (has_null_sha1)
+		retval += error_func(&item->object, FSCK_WARN, "contains entries pointing to null sha1");
 	if (has_full_path)
 		retval += error_func(&item->object, FSCK_WARN, "contains full pathnames");
 	if (has_empty_name)
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 5b79c51..bf7a2cd 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -213,4 +213,30 @@ test_expect_success 'rev-list --verify-objects with bad sha1' '
 	grep -q "error: sha1 mismatch 63ffffffffffffffffffffffffffffffffffffff" out
 '
 
+_bz='\0'
+_bz5="$_bz$_bz$_bz$_bz$_bz"
+_bz20="$_bz5$_bz5$_bz5$_bz5"
+
+test_expect_success 'fsck notices blob entry pointing to null sha1' '
+	(git init null-blob &&
+	 cd null-blob &&
+	 sha=$(printf "100644 file$_bz$_bz20" |
+	       git hash-object -w --stdin -t tree) &&
+	  git fsck 2>out &&
+	  cat out &&
+	  grep "warning.*null sha1" out
+	)
+'
+
+test_expect_success 'fsck notices submodule entry pointing to null sha1' '
+	(git init null-commit &&
+	 cd null-commit &&
+	 sha=$(printf "160000 submodule$_bz$_bz20" |
+	       git hash-object -w --stdin -t tree) &&
+	  git fsck 2>out &&
+	  cat out &&
+	  grep "warning.*null sha1" out
+	)
+'
+
 test_done
-- 
1.7.11.3.42.g90758bf
