From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] format-patch: remove existing output-directory
Date: Fri, 14 Jun 2013 18:13:33 +0530
Message-ID: <1371213813-7925-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 14 14:45:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnTNj-00062J-Nf
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 14:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143Ab3FNMp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 08:45:28 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:33744 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab3FNMp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 08:45:27 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so540951pdj.31
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 05:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=RZbtUrM063GLtk8rfMPMWEdpG0VEr8Mso1aEaOYT+2Y=;
        b=YdxXvPrMyYTece5VDqKrI6v2RrrMqrt4g5eqjQ7HNneT3TnsIEoN4pRNxq7AsoJQhy
         12R1nqzA6+iimSfF725lQBXEzlIk1Gi8IhWBt0dceN/QJZSGN8Cy8Ts+F7pvoMj5lAaW
         LcM/JOAlYyumzTeBAg0IaY9mgMuBBl9ZiiTEfB7KogRQxZr4/C+/nbVfRnLKUvmRQBDz
         aVpDo/lbfVgAGEDQu5N5hsJDEiv3qAsVpd/66exylDUfFrVTox5UgNLA0N+n7TrKTg3v
         /BeZKht0e36nws6DmaxAyzDoRDs7QuqT4s9nH6UgO4xnH/p+ajmQ69ctwRBfg1RncHQi
         WT3g==
X-Received: by 10.66.216.198 with SMTP id os6mr2354552pac.145.1371213926934;
        Fri, 14 Jun 2013 05:45:26 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id vb8sm2215055pbc.11.2013.06.14.05.45.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 05:45:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.379.g74a2e74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227819>

The following command

  $ git format-patch -o outgoing master

does not ensure that the output-directory outgoing doesn't already
exist.  As a result, it's possible for patches from two different series
to get mixed up if the user is not careful.  Fix the problem by
unconditionally removing the output-directory before writing to it.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/log.c           | 5 +++++
 t/t4014-format-patch.sh | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index 9e21232..babcfb7 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -25,6 +25,7 @@
 #include "version.h"
 #include "mailmap.h"
 #include "gpg-interface.h"
+#include "dir.h"
 
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
@@ -1312,8 +1313,12 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		setup_pager();
 
 	if (output_directory) {
+		struct strbuf buf = STRBUF_INIT;
+
 		if (use_stdout)
 			die(_("standard output, or directory, which one?"));
+		strbuf_addstr(&buf, output_directory);
+		remove_dir_recursively(&buf, 0);
 		if (mkdir(output_directory, 0777) < 0 && errno != EEXIST)
 			die_errno(_("Could not create directory '%s'"),
 				  output_directory);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 58d4180..7ba0e66 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -271,6 +271,15 @@ test_expect_success 'multiple files' '
 	ls patches/0001-Side-changes-1.patch patches/0002-Side-changes-2.patch patches/0003-Side-changes-3-with-n-backslash-n-in-it.patch
 '
 
+test_expect_success 'multiple files; unclean output-directory' '
+	mkdir -p patches &&
+	: >patches/fuzzle &&
+	git checkout side &&
+	git format-patch -o patches/ master &&
+	ls patches/0001-Side-changes-1.patch patches/0002-Side-changes-2.patch patches/0003-Side-changes-3-with-n-backslash-n-in-it.patch &&
+	test_path_is_missing patches/fuzzle
+'
+
 test_expect_success 'reroll count' '
 	rm -fr patches &&
 	git format-patch -o patches --cover-letter --reroll-count 4 master..side >list &&
-- 
1.8.3.1.379.g74a2e74
