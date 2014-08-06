From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v8 8/8] add tests for `git_config_get_string_const()`
Date: Wed,  6 Aug 2014 07:53:12 -0700
Message-ID: <1407336792-16962-9-git-send-email-tanayabh@gmail.com>
References: <1407336792-16962-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 06 17:01:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF2iN-0000Os-5m
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 17:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169AbaHFPBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 11:01:15 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:51975 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839AbaHFPBN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 11:01:13 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so3567822pad.7
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 08:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EG8a/9/L+4YiL7jBhSDDscGofvyP3bhWcmW7JMrMADs=;
        b=1F+qHhfc4GITa/8iJQENd2TUAMAsnahWpR6cAZFdg8w4C2HcFPLhKUZ8JdhXtVPt6k
         TJGY+rMgYAEiyy0jvSzZhveWpm6YQPXReQnsHhZRzv8AfzdIKWzVtdEgKOJahtixqO0S
         IqJ2R79dUBTQkwZtjn+qJrgC3rqjl5YXPwL7v28c9XayVUXaZtpRYjDPGRL2/Fj7HzS4
         bZIfa+F1Pizdm7RJPNw6O9aijRJLwADGary/dLf/kaGjhPDMwob9/yXvYrI0Z/tC06UE
         yD61RXV3MuYv3w/Ezmv15MqsFlS6lofFfPkE82Q7xLVhULK+osP8bc2/V2Qv5pAEMCNU
         /zlg==
X-Received: by 10.66.158.130 with SMTP id wu2mr11759985pab.59.1407337272869;
        Wed, 06 Aug 2014 08:01:12 -0700 (PDT)
Received: from localhost.localdomain ([223.176.214.188])
        by mx.google.com with ESMTPSA id u2sm1547305pbs.42.2014.08.06.08.01.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Aug 2014 08:01:12 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407336792-16962-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254859>

Add tests for `git_config_get_string_const()`, check whether it
dies printing the line number and the file name if a NULL
value is retrieved for the given key.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 t/t1308-config-set.sh | 10 ++++++++++
 test-config.c         | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 5ea0aa4..ecc757a 100755
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
+	grep "line 7.*.git/config\|.git/config.*line 7" result
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
