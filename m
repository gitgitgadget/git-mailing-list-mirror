From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2] Better tests for error cases
Date: Fri, 11 Jul 2014 16:27:13 +0200
Message-ID: <1405088833-5817-2-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqwqbk0y8n.fsf@anie.imag.fr>
 <1405088833-5817-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: tanayabh@gmail.com, artagnon@gmail.com,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 11 16:35:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5bvU-0005pI-W5
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 16:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097AbaGKOfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 10:35:48 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47234 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753008AbaGKOfs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 10:35:48 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6BEYfk8019115
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Jul 2014 16:34:41 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6BEYhrX024274;
	Fri, 11 Jul 2014 16:34:43 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1X5buM-0002Gn-W9; Fri, 11 Jul 2014 16:34:43 +0200
X-Mailer: git-send-email 2.0.0.262.gdafc651
In-Reply-To: <1405088833-5817-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 11 Jul 2014 16:34:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6BEYfk8019115
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1405694082.36207@doqUEuNeGnTfVPZJjZvbsA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253279>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Consider squashing this into PATCH 2/2

Probably not sufficient.

 t/t1308-config-set.sh | 22 ++++++++++++++++++++++
 test-config.c         |  8 ++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 87a29f1..f1e9e76 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -167,4 +167,26 @@ test_expect_success 'find value_list for a key from a configset' '
 	test_cmp expect actual
 '
 
+test_expect_success 'proper error on non-existant files' '
+	echo "Error reading configuration file non-existant-file." >expect &&
+	test_must_fail test-config configset_get_value foo.bar non-existant-file 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'proper error on error in default config files' '
+	cp .git/config .git/config.old &&
+	test_when_finished "mv .git/config.old .git/config" &&
+	echo "[" >> .git/config &&
+	echo "fatal: bad config file line 35 in .git/config" >expect &&
+	test_must_fail test-config get_value foo.bar 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'proper error on error in custom config files' '
+	echo "[" >> syntax-error &&
+	echo "fatal: bad config file line 1 in syntax-error" >expect &&
+	test_must_fail test-config configset_get_value foo.bar syntax-error 2>actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/test-config.c b/test-config.c
index 07b61ef..49f8cd7 100644
--- a/test-config.c
+++ b/test-config.c
@@ -86,8 +86,10 @@ int main(int argc, char **argv)
 		}
 	} else if (!strcmp(argv[1], "configset_get_value")) {
 		for (i = 3; i < argc; i++) {
-			if (git_configset_add_file(&cs, argv[i]))
+			if (git_configset_add_file(&cs, argv[i])) {
+				fprintf(stderr, "Error reading configuration file %s.\n", argv[i]);
 				goto exit2;
+			}
 		}
 		if (!git_configset_get_value(&cs, argv[2], &v)) {
 			if (!v)
@@ -101,8 +103,10 @@ int main(int argc, char **argv)
 		}
 	} else if (!strcmp(argv[1], "configset_get_value_multi")) {
 		for (i = 3; i < argc; i++) {
-			if (git_configset_add_file(&cs, argv[i]))
+			if (git_configset_add_file(&cs, argv[i])) {
+				fprintf(stderr, "Error reading configuration file %s.\n", argv[i]);
 				goto exit2;
+			}
 		}
 		strptr = git_configset_get_value_multi(&cs, argv[2]);
 		if (strptr) {
-- 
2.0.0.262.gdafc651
