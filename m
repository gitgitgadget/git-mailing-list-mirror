From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule helper list: Respect correct path prefix
Date: Wed, 24 Feb 2016 13:15:02 -0800
Message-ID: <1456348502-4529-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, Stefan Beller <sbeller@google.com>
To: cjorden@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 22:15:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYgmD-0003lj-6h
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 22:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485AbcBXVPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 16:15:10 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35497 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbcBXVPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 16:15:09 -0500
Received: by mail-pa0-f46.google.com with SMTP id ho8so19705607pac.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 13:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=fWcqO7E/cbvuzRRHI2q0WkTOyvXHim6o+lOE4e2apuI=;
        b=id+rPR1l/oD8zXT1YRN0fl8kvQMPw/QkPOBpRWee29o4L8HR0t8eIgJoqIbipxGd0q
         QK9drFib7rLCg1IMK2G5sMxEfsf8jZ9qKbk8ZakluCkMrzuhi6pLtFRo01CDCVgy/yOa
         9yQlVqfl65atDyJJT0NpRVvShOdLPEQ2nio4sfZdqE6mEwoxjtukOmyN1aQrS5Dk8Ce9
         TuR3Z8/efPFCdVzi2yPjO6beGFKixVFlXW7HUqlTG8C7p8sbdqA7cRSgRNt+mZenP0YM
         NGx12IYzTBQeo5Kk+l49XPsalV6ZY8mY4nVOVMD134oV6Ngx7cZZ8a3OYfyewpqGqN9q
         tgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fWcqO7E/cbvuzRRHI2q0WkTOyvXHim6o+lOE4e2apuI=;
        b=ZWZzQwYqupp+hQlmodcHv7tr71XInjulZDe6LrrOq5a5C/RBy0I28Sjfge0JfIXc8/
         d3l5mHrcid+H/CVN1KU9ZKaoao2VhQfemU8QUYRBQ14dBcRKuIw/Ia6fDJh2YEOGpJgu
         ZebX/KO+M6lHe14/x6LDscj9HD98dUVpVcsfaqmwKAbA8DHC+YznFeFY/d6YuaObnLl2
         yk8AxNY1nxRKZ+ZQu+8xNHyGeb8iH2K53Wwfoioh12CyIEOV9VqiArkw0oZqXM5wNVdI
         ux/0PThbMHGW4srZZ/eu3VyPZfKMnHegXVdJmIEHGWPm8UxF3HbmMzfbXg9e0zTpsCCI
         24ng==
X-Gm-Message-State: AG10YOTt+a9Ak27tipiYIzmrMjgXYdt3RUe1Ig4e6TgoaCzMj5ev5xF+DNbdbmH3YLefGQvV
X-Received: by 10.66.142.226 with SMTP id rz2mr57635602pab.104.1456348508706;
        Wed, 24 Feb 2016 13:15:08 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:74de:af7a:dfba:15a4])
        by smtp.gmail.com with ESMTPSA id p9sm7102104pfa.11.2016.02.24.13.15.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 13:15:07 -0800 (PST)
X-Mailer: git-send-email 2.7.2.335.g3f96d05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287228>

This is a regression introduced by 74703a1e4d (submodule: rewrite
`module_list` shell function in C, 2015-09-02).

Add a test to ensure we list the right submodule when giving a specific
path spec.

Reported-By: Caleb Jorden <cjorden@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

 I developed this on top of current origin/master, though I can backport it
 to 2.7 as well if desired.
 
 I do not remember the cause why we started to ignore a common prefix.
 
 Thanks,
 Stefan
  
 builtin/submodule--helper.c | 10 ++--------
 t/t7400-submodule-basic.sh  | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f4c3eff..ed764c9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -22,17 +22,12 @@ static int module_list_compute(int argc, const char **argv,
 			       struct module_list *list)
 {
 	int i, result = 0;
-	char *max_prefix, *ps_matched = NULL;
-	int max_prefix_len;
+	char *ps_matched = NULL;
 	parse_pathspec(pathspec, 0,
 		       PATHSPEC_PREFER_FULL |
 		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
 		       prefix, argv);
 
-	/* Find common prefix for all pathspec's */
-	max_prefix = common_prefix(pathspec);
-	max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
-
 	if (pathspec->nr)
 		ps_matched = xcalloc(pathspec->nr, 1);
 
@@ -44,7 +39,7 @@ static int module_list_compute(int argc, const char **argv,
 
 		if (!S_ISGITLINK(ce->ce_mode) ||
 		    !match_pathspec(pathspec, ce->name, ce_namelen(ce),
-				    max_prefix_len, ps_matched, 1))
+				    0, ps_matched, 1))
 			continue;
 
 		ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
@@ -57,7 +52,6 @@ static int module_list_compute(int argc, const char **argv,
 			 */
 			i++;
 	}
-	free(max_prefix);
 
 	if (ps_matched && report_path_error(ps_matched, pathspec, prefix))
 		result = -1;
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 540771c..be82a75 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -999,5 +999,30 @@ test_expect_success 'submodule add clone shallow submodule' '
 	)
 '
 
+test_expect_success 'submodule helper list is not confused by common prefixes' '
+	mkdir -p dir1/b &&
+	(
+		cd dir1/b &&
+		git init &&
+		echo hi >testfile2 &&
+		git add . &&
+		git commit -m "test1"
+	) &&
+	mkdir -p dir2/b &&
+	(
+		cd dir2/b &&
+		git init &&
+		echo hello >testfile1 &&
+		git add .  &&
+		git commit -m "test2"
+	) &&
+	git submodule add /dir1/b dir1/b &&
+	git submodule add /dir2/b dir2/b &&
+	git commit -m "first submodule commit" &&
+	git submodule--helper list dir1/b |cut -c51- >actual &&
+	echo "dir1/b" >expect &&
+	test_cmp expect actual
+'
+
 
 test_done
-- 
2.7.2.334.g7c0da37.dirty
