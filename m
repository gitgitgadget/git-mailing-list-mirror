From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/3] fixup for patch 2: actually check the return value
Date: Wed, 16 Jul 2014 18:09:11 +0200
Message-ID: <1405526952-25019-2-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqha2h9tjw.fsf@anie.imag.fr>
 <1405526952-25019-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: artagnon@gmail.com, tanayabh@gmail.com,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 16 18:11:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7RnK-0001uV-BA
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 18:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965374AbaGPQK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 12:10:59 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42328 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934625AbaGPQKn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 12:10:43 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6GG9ob9028918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Jul 2014 18:09:50 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6GG9qou027189;
	Wed, 16 Jul 2014 18:09:52 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1X7RmB-0006h0-RU; Wed, 16 Jul 2014 18:09:51 +0200
X-Mailer: git-send-email 2.0.0.262.gdafc651
In-Reply-To: <1405526952-25019-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 16 Jul 2014 18:09:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6GG9ob9028918
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1406131794.30512@CKwH59USa7cFWvv/DAI8yw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253673>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
I won't fight for this, but I think it makes sense.

 t/t1308-config-set.sh |  4 ++--
 test-config.c         | 10 ++++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index ea031bf..f0307b7 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -168,7 +168,7 @@ test_expect_success 'find value_list for a key from a configset' '
 '
 
 test_expect_success 'proper error on non-existant files' '
-	echo "Error reading configuration file non-existant-file." >expect &&
+	echo "Error (-1) reading configuration file non-existant-file." >expect &&
 	test_expect_code 2 test-config configset_get_value foo.bar non-existant-file 2>actual &&
 	test_cmp expect actual
 '
@@ -176,7 +176,7 @@ test_expect_success 'proper error on non-existant files' '
 test_expect_success 'proper error on non-accessible files' '
 	chmod -r .git/config &&
 	test_when_finished "chmod +r .git/config" &&
-	echo "Error reading configuration file .git/config." >expect &&
+	echo "Error (-1) reading configuration file .git/config." >expect &&
 	test_expect_code 2 test-config configset_get_value foo.bar .git/config 2>actual &&
 	test_cmp expect actual
 '
diff --git a/test-config.c b/test-config.c
index cad35f4..9dd1b22 100644
--- a/test-config.c
+++ b/test-config.c
@@ -86,8 +86,9 @@ int main(int argc, char **argv)
 		}
 	} else if (!strcmp(argv[1], "configset_get_value")) {
 		for (i = 3; i < argc; i++) {
-			if (git_configset_add_file(&cs, argv[i])) {
-				fprintf(stderr, "Error reading configuration file %s.\n", argv[i]);
+			int err;
+			if ((err = git_configset_add_file(&cs, argv[i]))) {
+				fprintf(stderr, "Error (%d) reading configuration file %s.\n", err, argv[i]);
 				goto exit2;
 			}
 		}
@@ -103,8 +104,9 @@ int main(int argc, char **argv)
 		}
 	} else if (!strcmp(argv[1], "configset_get_value_multi")) {
 		for (i = 3; i < argc; i++) {
-			if (git_configset_add_file(&cs, argv[i])) {
-				fprintf(stderr, "Error reading configuration file %s.\n", argv[i]);
+			int err;
+			if ((err = git_configset_add_file(&cs, argv[i]))) {
+				fprintf(stderr, "Error (%d) reading configuration file %s.\n", err, argv[i]);
 				goto exit2;
 			}
 		}
-- 
2.0.0.262.gdafc651
