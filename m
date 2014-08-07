From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v9 8/8] add tests for `git_config_get_string_const()`
Date: Thu,  7 Aug 2014 04:59:19 -0700
Message-ID: <1407412759-13833-9-git-send-email-tanayabh@gmail.com>
References: <1407412759-13833-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 14:00:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFMN8-0005AQ-TL
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 14:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757424AbaHGMAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 08:00:37 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:46669 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932184AbaHGMAd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 08:00:33 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so5113875pdj.14
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 05:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gRhzzJX27uZ2DoCYaBC8Ka0x8PYMB3OIMQIMlFTCyZQ=;
        b=O7/pEgkl5hS/eQKAmJA/gkHonUiyCDWVTRu2R6ZH5PeCywJak6qske+j93bcpj7zmN
         ACVxpFqMt19nWo56R16qAU7QM5tsB8/gfX9J1lP6gcAC9WwjVNIH7sf+4/M9R2A7tB4B
         mmxDRjmXySZ9c93phqbaxi0X4OGdxNtaNItXAz0LCfwrCXpRSTtHap41R1OCG8RBXDyU
         n/bFAP7NnM+fWGcbVta38S5d1gIpSHLhn+S6seitSQnPTxds4rjvwqQioVePORmmEDtg
         xCzkjJkWBvyEeRQsU6Ek3FCzl/x5hY5Iv0JOV0DNX/3/Ftvydx9nFf76FwYui0kdtXd7
         oTFg==
X-Received: by 10.70.103.106 with SMTP id fv10mr17394413pdb.63.1407412833030;
        Thu, 07 Aug 2014 05:00:33 -0700 (PDT)
Received: from localhost.localdomain ([223.176.226.83])
        by mx.google.com with ESMTPSA id cb8sm13997212pad.8.2014.08.07.05.00.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 05:00:32 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407412759-13833-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254956>

Add tests for `git_config_get_string_const()`, check whether it
dies printing the line number and the file name if a NULL
value is retrieved for the given key.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 t/t1308-config-set.sh | 10 ++++++++++
 test-config.c         | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 9cc678d..ea0bce2 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -119,6 +119,16 @@ test_expect_success 'find integer value for a key' '
 	check_config get_int lamb.chop 65
 '
 
+test_expect_success 'find string value for a key' '
+	check_config get_string case.baz hask &&
+	check_config expect_code 1 get_string case.ba "Value not found for \"case.ba\""
+'
+
+test_expect_success 'check line error when NULL string is queried' '
+	test_expect_code 128 test-config get_string case.foo 2>result &&
+	test_i18ngrep "fatal: .*case\.foo.*\.git/config.*line 7" result
+'
+
 test_expect_success 'find integer if value is non parse-able' '
 	check_config expect_code 128 get_int lamb.head
 '
diff --git a/test-config.c b/test-config.c
index 9dd1b22..6a77552 100644
--- a/test-config.c
+++ b/test-config.c
@@ -16,6 +16,8 @@
  *
  * get_bool -> print bool value for the entered key or die
  *
+ * get_string -> print string value for the entered key or die
+ *
  * configset_get_value -> returns value with the highest priority for the entered key
  * 			from a config_set constructed from files entered as arguments.
  *
@@ -84,6 +86,14 @@ int main(int argc, char **argv)
 			printf("Value not found for \"%s\"\n", argv[2]);
 			goto exit1;
 		}
+	} else if (argc == 3 && !strcmp(argv[1], "get_string")) {
+		if (!git_config_get_string_const(argv[2], &v)) {
+			printf("%s\n", v);
+			goto exit0;
+		} else {
+			printf("Value not found for \"%s\"\n", argv[2]);
+			goto exit1;
+		}
 	} else if (!strcmp(argv[1], "configset_get_value")) {
 		for (i = 3; i < argc; i++) {
 			int err;
-- 
1.9.0.GIT
