From: Brodie Rao <brodie@sf.io>
Subject: [PATCH] archive: fix archive generation for empty trees
Date: Wed,  7 Mar 2012 16:09:22 -0800
Message-ID: <1331165362-78065-1-git-send-email-brodie@sf.io>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 01:09:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5QvE-0007Ek-Jw
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 01:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759315Ab2CHAJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 19:09:28 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42379 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756993Ab2CHAJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 19:09:27 -0500
Received: by iagz16 with SMTP id z16so9342953iag.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 16:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitheap.org; s=google;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=yr4ub1Dtcpl6qMTzKv4QNLa9dqRDbG5BDIQiTRxF+hc=;
        b=U/M7M3w/VQLHifcb++kIykbCq1x6gUo32u4BCJIeBki5HkY+3vzvnnd+fIAJT+gRH1
         sw+gCJevyXuAyPV9I3ixlYAexYd424zpK6H2X3K0WP261c+ekFgT4dIEoHBo0JulY1LW
         opv0SCl7Kbcucab6/c3SQi+zFSsqGU1f3/HYw=
Received: by 10.42.157.6 with SMTP id b6mr2527600icx.23.1331165367121;
        Wed, 07 Mar 2012 16:09:27 -0800 (PST)
Received: from kapp.staff.sf.atlassian.com (70-35-42-138.static.wiline.com. [70.35.42.138])
        by mx.google.com with ESMTPS id dl10sm18965148igb.9.2012.03.07.16.09.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Mar 2012 16:09:26 -0800 (PST)
X-Mailer: git-send-email 1.7.9.2
X-Gm-Message-State: ALoCoQmX3Qk2a1yOLA/Qm4ZLRngtX7+ce4PM/Y/LUDwH14OY2j8czUjAPolaQrcbL3RZddHmqCUw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192509>

Prior to this change, git-archive would try to verify path arguments -
even if none were provided. It used get_pathspec("", pathspec), which
would return a pathspec of "" instead of NULL.

Then it would try to verify if the tree contained any paths matching
"". This is fine in the normal case where the tree contains anything
(every entry would match), but for an empty tree, it wouldn't match,
and you'd get this error:

  fatal: path not found:

Now, instead of "", we use a pathspec prefix of NULL. If no path
arguments were provided, get_pathspec() will return NULL, and we won't
try to verify the existence of any paths in the tree.

Signed-off-by: Brodie Rao <brodie@sf.io>
---
 archive.c           |    2 +-
 t/t5000-tar-tree.sh |   16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/archive.c b/archive.c
index 1ee837d..6e23896 100644
--- a/archive.c
+++ b/archive.c
@@ -236,7 +236,7 @@ static int path_exists(struct tree *tree, const char *path)
 static void parse_pathspec_arg(const char **pathspec,
 		struct archiver_args *ar_args)
 {
-	ar_args->pathspec = pathspec = get_pathspec("", pathspec);
+	ar_args->pathspec = pathspec = get_pathspec(NULL, pathspec);
 	if (pathspec) {
 		while (*pathspec) {
 			if (!path_exists(ar_args->tree, *pathspec))
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 527c9e7..404786f 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -360,4 +360,20 @@ test_expect_success GZIP 'remote tar.gz can be disabled' '
 		>remote.tar.gz
 '
 
+test_expect_success \
+    'git archive with an empty tree and a prefix' \
+    'git rm -r . &&
+     git commit -m empty &&
+     git archive --format=tar --prefix=empty/ HEAD > e1.tar &&
+     "$TAR" tf e1.tar'
+
+test_expect_success \
+    'git archive with an empty tree and no prefix' \
+    'git archive --format=tar HEAD > e2.tar &&
+     test_must_fail "$TAR" tf e2.tar'
+
+test_expect_success \
+    'git archive on specific paths with an empty tree' \
+    'test_must_fail git archive --format=tar --prefix=empty/ HEAD foo'
+
 test_done
-- 
1.7.9.2
