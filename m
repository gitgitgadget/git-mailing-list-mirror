From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 1/2] Teach '--cached' option to check-attr
Date: Thu, 22 Sep 2011 17:44:20 -0400
Message-ID: <1316727861-90460-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 23:44:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6r4P-00036D-PW
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 23:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013Ab1IVVoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 17:44:32 -0400
Received: from mail-gw0-f42.google.com ([74.125.83.42]:56952 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653Ab1IVVoc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 17:44:32 -0400
Received: by gwj16 with SMTP id 16so2191717gwj.1
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 14:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=tcVQdKxoefE9HLgIOeSTygBl/tUPyASWrflGgAlzQig=;
        b=NagOMR/q/nqri8IQ0bmLIjj2Qhh3FcNCFcLamLxVFSH/TF2rGbZYtSQ/tIm+r1crb0
         W74i54P7ZZKN+hvYi3HoO8by9wCM8CqUW140+X0TclC/j0uJwQpe8T7bOEVtwNnXv4I9
         HQzBQ6PFT0qty9KHcoZ0A3QZ9XY3qI422dgVc=
Received: by 10.151.20.12 with SMTP id x12mr2702311ybi.367.1316727871375;
        Thu, 22 Sep 2011 14:44:31 -0700 (PDT)
Received: from localhost (cpe-174-097-218-168.nc.res.rr.com. [174.97.218.168])
        by mx.google.com with ESMTPS id l18sm4521145ybg.22.2011.09.22.14.44.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Sep 2011 14:44:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc2.5.g12a2f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181920>

This option causes check-attr to consider .gitattributes from the index
only, ignoring .gitattributes from the working tree. This allows it to
be used in situations where a working tree does not exist.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
This doesn't seem too controversial to me, and allows server-side
reading of .gitattributes, albeit with the need to setup an index.
Still that's better than having to setup an entire working tree.

 Documentation/git-check-attr.txt |    3 +++
 builtin/check-attr.c             |    5 +++++
 t/t0003-attributes.sh            |   28 ++++++++++++++++++++++++----
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 1f7312a189..22537fea23 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -24,6 +24,9 @@ OPTIONS
 	paths.  If this option is used, then 'unspecified' attributes
 	will not be included in the output.
 
+--cached::
+	Consider .gitattributes in the index only, ignoring the working tree.
+
 --stdin::
 	Read file names from stdin instead of from the command-line.
 
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 708988a0e1..5682f6d2c7 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -5,6 +5,7 @@
 #include "parse-options.h"
 
 static int all_attrs;
+static int cached_attrs;
 static int stdin_paths;
 static const char * const check_attr_usage[] = {
 "git check-attr [-a | --all | attr...] [--] pathname...",
@@ -16,6 +17,7 @@ static int null_term_line;
 
 static const struct option check_attr_options[] = {
 	OPT_BOOLEAN('a', "all", &all_attrs, "report all attributes set on file"),
+	OPT_BOOLEAN(0,  "cached", &cached_attrs, "use cached .gitattributes"),
 	OPT_BOOLEAN(0 , "stdin", &stdin_paths, "read file names from stdin"),
 	OPT_BOOLEAN('z', NULL, &null_term_line,
 		"input paths are terminated by a null character"),
@@ -99,6 +101,9 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 		die("invalid cache");
 	}
 
+	if (cached_attrs)
+		git_attr_set_direction(GIT_ATTR_INDEX, NULL);
+
 	doubledash = -1;
 	for (i = 0; doubledash < 0 && i < argc; i++) {
 		if (!strcmp(argv[i], "--"))
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index ae2f1da28f..2e1b4a7f75 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -134,10 +134,20 @@ test_expect_success 'attribute test: read paths from stdin' '
 
 test_expect_success 'attribute test: --all option' '
 
-	grep -v unspecified < expect-all | sort > expect &&
-	sed -e "s/:.*//" < expect-all | uniq |
-		git check-attr --stdin --all | sort > actual &&
-	test_cmp expect actual
+	grep -v unspecified < expect-all | sort > specified-all &&
+	sed -e "s/:.*//" < expect-all | uniq > stdin-all &&
+	git check-attr --stdin --all < stdin-all | sort > actual &&
+	test_cmp specified-all actual
+'
+
+test_expect_success 'attribute test: --cached option' '
+
+	:> empty &&
+	git check-attr --cached --stdin --all < stdin-all | sort > actual &&
+	test_cmp empty actual &&
+	git add .gitattributes a/.gitattributes a/b/.gitattributes &&
+	git check-attr --cached --stdin --all < stdin-all | sort > actual &&
+	test_cmp specified-all actual
 '
 
 test_expect_success 'root subdir attribute test' '
@@ -168,6 +178,16 @@ test_expect_success 'bare repository: check that .gitattribute is ignored' '
 
 '
 
+test_expect_success 'bare repository: check that --cached honors index' '
+
+	export GIT_INDEX_FILE=../.git/index &&
+	git check-attr --cached --stdin --all < ../stdin-all |
+		sort > actual &&
+	test_cmp ../specified-all actual
+
+'
+
+
 test_expect_success 'bare repository: test info/attributes' '
 
 	(
-- 
1.7.7.rc2.5.g12a2f
