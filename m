From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 7/7] add tests for `git_config_get_string_const()`
Date: Thu, 31 Jul 2014 02:44:17 -0700
Message-ID: <1406799857-28048-8-git-send-email-tanayabh@gmail.com>
References: <1406799857-28048-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 11:46:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCmw2-0004xN-2v
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 11:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbaGaJp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 05:45:59 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:44347 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265AbaGaJp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 05:45:58 -0400
Received: by mail-pa0-f45.google.com with SMTP id eu11so3299034pac.18
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 02:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2TZrK2oE5rxDt6EjjvXA5hdR+Vjp91Cx4Gwp83AIQYw=;
        b=FfYqZ4Thl8+/5rrv3pS2iubBs1oMDjqQA7uqydPvyVtJ0kZNsaCna6PW3NV8IgeUEX
         03pPSC4aNTDJBfMbqXb/9Rm2FhddZJhC5hEhtu6FEx2tQZYWyRfK5blY9+RShDidUI8n
         cGI1TLnavmDWLDlgcgJA0g5eVm8KLIAMRin9Xomza4Ek0SQfndwGj/zYe9GecV0h11/H
         lrAt1SKvUhe+X48sYV/duftUp6bWndEs3v3MT+7lkJTMJZfHcAl2aBkG4U4jeDTs0jQN
         JsC0uH2a4pvzHHaFSQOb4n5AmH4hRjj2aodtJNfSJi+LoxigRrVV/y4q8FiZB6GTDS3/
         5EXg==
X-Received: by 10.68.239.201 with SMTP id vu9mr2944588pbc.35.1406799958254;
        Thu, 31 Jul 2014 02:45:58 -0700 (PDT)
Received: from localhost.localdomain ([106.201.156.106])
        by mx.google.com with ESMTPSA id zq5sm4933551pbb.37.2014.07.31.02.45.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jul 2014 02:45:57 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406799857-28048-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254547>

Add tests for `git_config_get_string_const()`, check whether it
dies printing the line number and the file name if a NULL
value is retrieved for the given key.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 t/t1308-config-set.sh | 10 ++++++++++
 test-config.c         | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index e2f9d0b..f012dd6 100755
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
+	grep "fatal: bad config variable '\''case.foo'\'' at file line 7 in .git/config" result
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
