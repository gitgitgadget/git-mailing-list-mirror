From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2 6/6] Add tests for `git_config_get_string()`
Date: Fri, 25 Jul 2014 05:58:15 -0700
Message-ID: <1406293095-15920-7-git-send-email-tanayabh@gmail.com>
References: <1406293095-15920-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 14:59:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAf6D-0003S3-Qq
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 14:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760430AbaGYM7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 08:59:45 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:59091 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbaGYM7p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 08:59:45 -0400
Received: by mail-pa0-f50.google.com with SMTP id et14so5997828pad.23
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 05:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M02zOdoIgO6ppbkQQN1cyy9+qTV0cmNWxsOGevgnQxI=;
        b=U3DCnFYK7+mU7qvC4qQ+WpoKY2AXtNHdY/IfNLDi5tcvWshgF3Tk9OYycAUfY/YSW+
         2GPWXmAhFC+Z6b7LTI3S25QTdsrU4mH99Fc6JOK3hn4jI+NNiY3fFvVwKm+g9VcQlHVv
         Lntb4oEbNsZ16FqnFP4es0Wr0rIOXDXzdeVQBXf1c7/+YcziGMzZwI5Hjws2w8GY7phB
         eJodn4CYuLGke2VXnZwBrebsDeIx/JqXhEbCZET3E9BqU6swP0xhQLPv8u66CO9T1WsK
         ZEv7/XnK0Ers2aV8kRBD9B+Kh+g68XoqRakw8cUVPQSVpoOCVwBDtoKyJf9zhaTMCb+h
         lcig==
X-Received: by 10.66.102.39 with SMTP id fl7mr18944661pab.28.1406293184561;
        Fri, 25 Jul 2014 05:59:44 -0700 (PDT)
Received: from localhost.localdomain ([223.176.246.45])
        by mx.google.com with ESMTPSA id tg9sm8798900pbc.29.2014.07.25.05.59.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Jul 2014 05:59:42 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406293095-15920-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254217>

Add tests for `git_config_get_string()`, check whether it
dies printing the line number and the file name if a NULL
value is retrieved for the given key.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 t/t1308-config-set.sh |  9 +++++++++
 test-config.c         | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 35c6ee2..d7cdc6e 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -119,6 +119,15 @@ test_expect_success 'find integer value for a key' '
 	check_config get_int lamb.chop 65
 '
 
+test_expect_success 'find string value for a key' '
+	check_config get_string case.baz hask
+'
+
+test_expect_success 'check line error when NULL string is queried' '
+	test_expect_code 128 test-config get_string case.foo 2>result &&
+	grep "fatal: bad config file line 7 in .git/config" result
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
