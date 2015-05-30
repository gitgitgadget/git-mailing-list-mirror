From: Quentin Neill <quentin.neill@gmail.com>
Subject: [PATCH v2] blame: add blame.showEmail configuration
Date: Sat, 30 May 2015 16:38:46 -0500
Message-ID: <1433021926-17762-1-git-send-email-qneill@quicinc.com>
References: <xmqq617bcgva.fsf@gitster.dls.corp.google.com>
Cc: Quentin Neill <quentin.neill@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 30 23:38:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyoSe-0005qH-Sg
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 23:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755745AbbE3Vi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 17:38:28 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36066 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026AbbE3Vi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 17:38:26 -0400
Received: by oihb142 with SMTP id b142so78665296oih.3
        for <git@vger.kernel.org>; Sat, 30 May 2015 14:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g/pTnJ4TXYdaYYnb7baCD3yiuRv02g6ih+Fw6nAattA=;
        b=WIo7wMmaIRYuBiYBc31lhU9jpQBburfSxlsAyjiAIS/vIPaZCQyfBxgJGXENqoZzOl
         R9hdkJnM8Mlby07PoS5e/EtccgjrpU7YfloFl2+VxOTFlelYEvv2a0arwFolwpJOYpvp
         FkA2ip93GEjv9S4sdT1PDpzPdN07oNsNZq+8XX7SULNFEOMJpZqgzpE0eiFkKcZLAKnr
         ayHUIcCoE8+LWuWqd4UVsorNweZLbCRIvVE8B4/vFAD0Jteq40u+Lf4A6N0yPaQnRO9i
         clP6skJ0fFcVGRcyiRclWhrCKhMCDB7JXo42UszYFOD3mUWo9IerIGd/Bl0ZJDUh9BGI
         wNyQ==
X-Received: by 10.202.85.16 with SMTP id j16mr11657464oib.127.1433021906341;
        Sat, 30 May 2015 14:38:26 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-250-106.austin.res.rr.com. [70.114.250.106])
        by mx.google.com with ESMTPSA id h195sm5153890oig.1.2015.05.30.14.38.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 May 2015 14:38:25 -0700 (PDT)
X-Google-Original-From: Quentin Neill <qneill@quicinc.com>
X-Mailer: git-send-email 2.4.2.340.g5ecd853
In-Reply-To: <xmqq617bcgva.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270308>

From: Quentin Neill <quentin.neill@gmail.com>

Complement existing --show-email option with fallback
configuration variable, with tests.
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
index 5cdf3f1..faf1660 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -19,4 +19,66 @@ test_expect_success 'blame --show-email' '
 		"<E at test dot git>" 1
 '
 
+test_expect_success 'setup showEmail tests' '
+	echo "bin: test number 1" >one &&
+	git add . &&
+	GIT_AUTHOR_NAME=name1 GIT_AUTHOR_EMAIL=email1@test.git git commit -a -m First --date="2010-01-01 01:00:00"
+'
+
+cat >expected_n <<\EOF &&
+(name1 2010-01-01 01:00:00 +0000 1) bin: test number 1
+EOF
+
+cat >expected_e <<\EOF &&
+(<email1@test.git> 2010-01-01 01:00:00 +0000 1) bin: test number 1
+EOF
+
+find_blame() {
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
