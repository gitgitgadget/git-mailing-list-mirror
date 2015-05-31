From: Quentin Neill <quentin.neill@gmail.com>
Subject: [PATCH v3] blame: add blame.showEmail configuration
Date: Sun, 31 May 2015 14:27:37 -0500
Message-ID: <1433100457-18828-1-git-send-email-quentin.neill@gmail.com>
References: <xmqq617bcgva.fsf@gitster.dls.corp.google.com>
Cc: Quentin Neill <quentin.neill@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 31 21:27:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yz8tE-0003IO-7g
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 21:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758441AbbEaT1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 15:27:16 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34277 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbbEaT1O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 15:27:14 -0400
Received: by oifu123 with SMTP id u123so88180093oif.1
        for <git@vger.kernel.org>; Sun, 31 May 2015 12:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0wn1VhJX2oUtsWde693xJh/7ewnb9WFnG9UsWgYppSY=;
        b=oRNZtb0uC4NCMRHXlN1CLfR5vOpPDiszbNsBvWd6fHLO8hHrz3lY/2umw8/wbNPnyQ
         UJmWoKr+xgPwmq7D3Tyi/R1v26YCR7dkUpE88FHKbQalumIchW1AUmY7QWTPFZNhpm2h
         mfmtXq9FeL34RaxLc/ICCD9T4kB2Bs7RO5tAEDkd8Z7I3B8qIXNeDJ+L19RISBVBw2aL
         U5Z2Hyckf5fjaSFGYBBmrW6HRnxjssgdBnWaEptoePQvjVhY51Rd905iN65dPqJLl4R1
         fKNG6FEupTsrrc+m4ZpYNMbfBUk14Rap7h7xx+tUE1B4cBOQqdQJFeoR9x6EAYiAcFuo
         Q8Zg==
X-Received: by 10.202.219.195 with SMTP id s186mr14462808oig.25.1433100434235;
        Sun, 31 May 2015 12:27:14 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-250-106.austin.res.rr.com. [70.114.250.106])
        by mx.google.com with ESMTPSA id c9sm6479554oih.11.2015.05.31.12.27.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 May 2015 12:27:13 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.340.g5ecd853
In-Reply-To: <xmqq617bcgva.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270347>

Complement existing --show-email option with fallback
configuration variable, with tests.

Signed-off-by: Quentin Neill <quentin.neill@gmail.com>
---
 Documentation/git-blame.txt |  2 ++
 builtin/blame.c             | 10 +++++++-
 t/t8002-blame.sh            | 62 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 9f23a86..e6e947c 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -76,6 +76,8 @@ include::blame-options.txt[]
 -e::
 --show-email::
 	Show the author email instead of author name (Default: off).
+	This can also be controlled via the `blame.showEmail` config
+	option.
 
 -w::
 	Ignore whitespace when comparing the parent's version and
diff --git a/builtin/blame.c b/builtin/blame.c
index 8d70623..60039d3 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2185,6 +2185,14 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 		blank_boundary = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "blame.showemail")) {
+		int *output_option = cb;
+		if (git_config_bool(var, value))
+			*output_option |= OUTPUT_SHOW_EMAIL;
+		else
+			*output_option &= ~OUTPUT_SHOW_EMAIL;
+		return 0;
+	}
 	if (!strcmp(var, "blame.date")) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -2529,7 +2537,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	unsigned int range_i;
 	long anchor;
 
-	git_config(git_blame_config, NULL);
+	git_config(git_blame_config, &output_option);
 	init_revisions(&revs, NULL);
 	revs.date_mode = blame_date_mode;
 	DIFF_OPT_SET(&revs.diffopt, ALLOW_TEXTCONV);
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index 5cdf3f1..ff09ace 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -19,4 +19,66 @@ test_expect_success 'blame --show-email' '
 		"<E at test dot git>" 1
 '
 
+test_expect_success 'setup showEmail tests' '
+	echo "bin: test number 1" >one &&
+	git add one &&
+	GIT_AUTHOR_NAME=name1 \
+	GIT_AUTHOR_EMAIL=email1@test.git \
+	git commit -m First --date="2010-01-01 01:00:00" &&
+	cat >expected_n <<-\EOF &&
+	(name1 2010-01-01 01:00:00 +0000 1) bin: test number 1
+	EOF
+	cat >expected_e <<-\EOF
+	(<email1@test.git> 2010-01-01 01:00:00 +0000 1) bin: test number 1
+	EOF
+'
+
+find_blame () {
+	sed -e 's/^[^(]*//'
+}
+
+test_expect_success 'blame with no options and no config' '
+	git blame one >blame &&
+	find_blame <blame >result &&
+	test_cmp expected_n result
+'
+
+test_expect_success 'blame with showemail options' '
+	git blame --show-email one >blame1 &&
+	find_blame <blame1 >result &&
+	test_cmp expected_e result &&
+	git blame -e one >blame2 &&
+	find_blame <blame2 >result &&
+	test_cmp expected_e result &&
+	git blame --no-show-email one >blame3 &&
+	find_blame <blame3 >result &&
+	test_cmp expected_n result
+'
+
+test_expect_success 'blame with showEmail config false' '
+	git config blame.showEmail false &&
+	git blame one >blame1 &&
+	find_blame <blame1 >result &&
+	test_cmp expected_n result &&
+	git blame --show-email one >blame2 &&
+	find_blame <blame2 >result &&
+	test_cmp expected_e result &&
+	git blame -e one >blame3 &&
+	find_blame <blame3 >result &&
+	test_cmp expected_e result &&
+	git blame --no-show-email one >blame4 &&
+	find_blame <blame4 >result &&
+	test_cmp expected_n result
+'
+
+test_expect_success 'blame with showEmail config true' '
+	git config blame.showEmail true &&
+	git blame one >blame1 &&
+	find_blame <blame1 >result &&
+	test_cmp expected_e result &&
+	git blame --no-show-email one >blame2 &&
+	find_blame <blame2 >result &&
+	test_cmp expected_n result
+'
+
 test_done
-- 
2.4.2.340.g5ecd853
