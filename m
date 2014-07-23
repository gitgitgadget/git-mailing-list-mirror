From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 7/7] Add tests for `git_config_get_string()`
Date: Wed, 23 Jul 2014 11:42:58 -0700
Message-ID: <1406140978-9472-8-git-send-email-tanayabh@gmail.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 20:44:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA1WT-0006n7-Kt
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 20:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933259AbaGWSoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 14:44:13 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:58874 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932867AbaGWSoL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 14:44:11 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq14so2252454pab.40
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 11:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cVvVFEeCJYBxWfULi49wFkyrnVR5hTTZ9/vDRJMdBmU=;
        b=xl8j4pMteVo8jeVLi++Ds9JsnN4vs+wzye1xaLL/IApT7sLoPoQtpTmrUGhYz4zD3R
         cdmi5CPiKH7bZ7l73RM44GglRZmwVmoCaBt0RY82iGR4Vd0529BIC5sK8Sn0H+K+Y/x+
         8e4TFo+Adrt95BL3/Ui2Z2v8ta164kvexdtVlndlgaTLFwiW+/9+wPAJJwYmN7pRoJTn
         SxIn0ZmJ6XZiyiEIrwt970Ys1SXJ06mXEFQs7XWhAxoBKKUZjzMxOQ0Tv2OQ950pBmAr
         p0e9vtBiok8/Uahrbdzhn56iUl0h3yqIyNFCkN0mYmayTAF2dVZLTK6BxBtAG7N0r/Fc
         SlEA==
X-Received: by 10.69.31.65 with SMTP id kk1mr4432629pbd.162.1406141051487;
        Wed, 23 Jul 2014 11:44:11 -0700 (PDT)
Received: from localhost.localdomain ([27.56.89.40])
        by mx.google.com with ESMTPSA id z10sm1067820pdo.14.2014.07.23.11.44.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jul 2014 11:44:11 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254106>

Add tests for `git_config_get_string()`, check whether it
dies printing the line number and the file name if an NULL
value is retrieved for the given key.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 t/t1308-config-set.sh |  9 +++++++++
 test-config.c         | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index bd033df..1cb453b 100755
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
index 9dd1b22..994741a 100644
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
+		if (!git_config_get_string(argv[2], &v)) {
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
