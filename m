From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v2 2/2] attr.c: respect core.ignorecase when matching attribute patterns
Date: Wed,  5 Oct 2011 23:00:14 -0500
Message-ID: <1317873614-3057-3-git-send-email-drafnel@gmail.com>
References: <1317873614-3057-1-git-send-email-drafnel@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 06 06:01:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBf8o-0006cw-73
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 06:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247Ab1JFEAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 00:00:53 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40691 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab1JFEAw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 00:00:52 -0400
Received: by mail-yx0-f174.google.com with SMTP id 31so2240401yxl.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 21:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=PBXyEl8IgFnwZ9cE/XS+EQG/lrMLmjILiJJwIOZG1zQ=;
        b=Vnv+oCNvw8gHb1x4pC8H0aOLvExEuG86tnr2AQMSlbinPS37N17Z9dz4CJY7xINRCf
         ShuH976tTU1MXM94xi88VDGjuh0jDQ5forVimiAJF4GL+lAfv3hpQlDUZiO94PwlErs1
         vL+aSJ0Ua6bT/7yDlgZm1ujZ8riQh3feMX1JQ=
Received: by 10.150.143.16 with SMTP id q16mr213712ybd.6.1317873652199;
        Wed, 05 Oct 2011 21:00:52 -0700 (PDT)
Received: from localhost.localdomain ([96.19.140.155])
        by mx.google.com with ESMTPS id h20sm11169124ani.16.2011.10.05.21.00.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Oct 2011 21:00:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.1.ge3b6f
In-Reply-To: <1317873614-3057-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182925>

When core.ignorecase is true, the file globs configured in the
.gitattributes file should be matched case-insensitively against the paths
in the working directory.  Let's do so.

Plus, add some tests.

The last set of tests is performed only on a case-insensitive filesystem.
Those tests make sure that git handles the case where the .gitignore file
resides in a subdirectory and the user supplies a path that does not match
the case in the filesystem.  In that case^H^H^H^Hsituation, part of the
path supplied by the user is effectively interpreted case-insensitively,
and part of it is dependent on the setting of core.ignorecase.  git should
only match the portion of the path below the directory holding the
.gitignore file according to the setting of core.ignorecase.

This is also partly future-proofing.  Currently, git builds the attr stack
based on the path supplied by the user, so we don't have to do anything
special (like use strcmp_icase) to handle the parts of that path that don't
match the filesystem with respect to case.  If git instead built the attr
stack by scanning the repository, then the paths in the origin field would
not necessarily match the paths supplied by the user.  If someone makes a
change like that in the future, these tests will notice.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 attr.c                |    5 ++-
 t/t0003-attributes.sh |   60 ++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index 124337d..76b079f 100644
--- a/attr.c
+++ b/attr.c
@@ -11,6 +11,7 @@
 #include "cache.h"
 #include "exec_cmd.h"
 #include "attr.h"
+#include "dir.h"
 
 const char git_attr__true[] = "(builtin)true";
 const char git_attr__false[] = "\0(builtin)false";
@@ -631,7 +632,7 @@ static int path_matches(const char *pathname, int pathlen,
 		/* match basename */
 		const char *basename = strrchr(pathname, '/');
 		basename = basename ? basename + 1 : pathname;
-		return (fnmatch(pattern, basename, 0) == 0);
+		return (fnmatch_icase(pattern, basename, 0) == 0);
 	}
 	/*
 	 * match with FNM_PATHNAME; the pattern has base implicitly
@@ -645,7 +646,7 @@ static int path_matches(const char *pathname, int pathlen,
 		return 0;
 	if (baselen != 0)
 		baselen++;
-	return fnmatch(pattern, pathname + baselen, FNM_PATHNAME) == 0;
+	return fnmatch_icase(pattern, pathname + baselen, FNM_PATHNAME) == 0;
 }
 
 static int macroexpand_one(int attr_nr, int rem);
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index ae2f1da..47a70c4 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -9,7 +9,7 @@ attr_check () {
 	path="$1"
 	expect="$2"
 
-	git check-attr test -- "$path" >actual 2>err &&
+	git $3 check-attr test -- "$path" >actual 2>err &&
 	echo "$path: test: $2" >expect &&
 	test_cmp expect actual &&
 	test_line_count = 0 err
@@ -27,6 +27,7 @@ test_expect_success 'setup' '
 		echo "onoff test -test"
 		echo "offon -test test"
 		echo "no notest"
+		echo "A/e/F test=A/e/F"
 	) >.gitattributes &&
 	(
 		echo "g test=a/g" &&
@@ -93,6 +94,63 @@ test_expect_success 'attribute test' '
 
 '
 
+test_expect_success 'attribute matching is case sensitive when core.ignorecase=0' '
+
+	test_must_fail attr_check F f "-c core.ignorecase=0" &&
+	test_must_fail attr_check a/F f "-c core.ignorecase=0" &&
+	test_must_fail attr_check a/c/F f "-c core.ignorecase=0" &&
+	test_must_fail attr_check a/G a/g "-c core.ignorecase=0" &&
+	test_must_fail attr_check a/B/g a/b/g "-c core.ignorecase=0" &&
+	test_must_fail attr_check a/b/G a/b/g "-c core.ignorecase=0" &&
+	test_must_fail attr_check a/b/H a/b/h "-c core.ignorecase=0" &&
+	test_must_fail attr_check a/b/D/g "a/b/d/*" "-c core.ignorecase=0" &&
+	test_must_fail attr_check oNoFf unset "-c core.ignorecase=0" &&
+	test_must_fail attr_check oFfOn set "-c core.ignorecase=0" &&
+	attr_check NO unspecified "-c core.ignorecase=0" &&
+	test_must_fail attr_check a/b/D/NO "a/b/d/*" "-c core.ignorecase=0" &&
+	attr_check a/b/d/YES a/b/d/* "-c core.ignorecase=0" &&
+	test_must_fail attr_check a/E/f "A/e/F" "-c core.ignorecase=0"
+
+'
+
+test_expect_success 'attribute matching is case insensitive when core.ignorecase=1' '
+
+	attr_check F f "-c core.ignorecase=1" &&
+	attr_check a/F f "-c core.ignorecase=1" &&
+	attr_check a/c/F f "-c core.ignorecase=1" &&
+	attr_check a/G a/g "-c core.ignorecase=1" &&
+	attr_check a/B/g a/b/g "-c core.ignorecase=1" &&
+	attr_check a/b/G a/b/g "-c core.ignorecase=1" &&
+	attr_check a/b/H a/b/h "-c core.ignorecase=1" &&
+	attr_check a/b/D/g "a/b/d/*" "-c core.ignorecase=1" &&
+	attr_check oNoFf unset "-c core.ignorecase=1" &&
+	attr_check oFfOn set "-c core.ignorecase=1" &&
+	attr_check NO unspecified "-c core.ignorecase=1" &&
+	attr_check a/b/D/NO "a/b/d/*" "-c core.ignorecase=1" &&
+	attr_check a/b/d/YES unspecified "-c core.ignorecase=1" &&
+	attr_check a/E/f "A/e/F" "-c core.ignorecase=1"
+
+'
+
+test_expect_success 'check whether FS is case-insensitive' '
+	mkdir junk &&
+	echo good >junk/CamelCase &&
+	echo bad >junk/camelcase &&
+	if test "$(cat junk/CamelCase)" != good
+	then
+		test_set_prereq CASE_INSENSITIVE_FS
+	fi
+'
+
+test_expect_success CASE_INSENSITIVE_FS 'additional case insensitivity tests' '
+	test_must_fail attr_check a/B/D/g "a/b/d/*" "-c core.ignorecase=0" &&
+	test_must_fail attr_check A/B/D/NO "a/b/d/*" "-c core.ignorecase=0" &&
+	attr_check A/b/h a/b/h "-c core.ignorecase=0" &&
+	attr_check A/b/h a/b/h "-c core.ignorecase=1" &&
+	attr_check a/B/D/g "a/b/d/*" "-c core.ignorecase=1" &&
+	attr_check A/B/D/NO "a/b/d/*" "-c core.ignorecase=1"
+'
+
 test_expect_success 'unnormalized paths' '
 
 	attr_check ./f f &&
-- 
1.7.7.1.ge3b6f
