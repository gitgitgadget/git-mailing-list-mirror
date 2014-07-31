From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v6 7/7] add tests for `git_config_get_string_const()`
Date: Thu, 31 Jul 2014 08:47:42 -0700
Message-ID: <1406821662-1570-8-git-send-email-tanayabh@gmail.com>
References: <1406821662-1570-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 17:49:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCsbX-0000Cm-Hd
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 17:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbaGaPtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 11:49:04 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36699 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbaGaPtD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 11:49:03 -0400
Received: by mail-pa0-f44.google.com with SMTP id eu11so3839132pac.17
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 08:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2TZrK2oE5rxDt6EjjvXA5hdR+Vjp91Cx4Gwp83AIQYw=;
        b=AivczfJwbL/2N6eYZlnSZ/BCJrEWW8CD6deD1ugaXeAxWFZdTM4Yk4J/QvsmNDUu6q
         4xeLdfdOgo4syL25PA34QHDaScGJC16Gh3n/MKWcKx4EHRNYlhs2PvfgeAeQhKQLOJil
         nXvwUDyizauRyMCBigZ4iMNag17Cw8YnFOAyDBWQXvgXVrNtLiNyWbTf3n8Dvb2B1i6H
         ZTJMBWh4+J2zmpheDI6w1mRQp9upUyiGhEhfqs8tNYBzpDg7its73YdiQjns7tbPBUxw
         7gsxH9cGmmF8C7LhGGbChjygbB/N2XtYDps4hm3NFUJfxNlPVhAlwo74Qj7CdjtLrMLW
         Rf4w==
X-Received: by 10.70.131.129 with SMTP id om1mr4766110pdb.149.1406821737266;
        Thu, 31 Jul 2014 08:48:57 -0700 (PDT)
Received: from localhost.localdomain ([223.229.21.143])
        by mx.google.com with ESMTPSA id n16sm8837555pdj.41.2014.07.31.08.48.54
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jul 2014 08:48:56 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406821662-1570-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254586>

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
