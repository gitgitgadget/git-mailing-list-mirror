From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] config: display key_delim for config --bool --get-regexp
Date: Mon, 10 Oct 2011 14:54:51 +0200
Message-ID: <1318251291-30297-1-git-send-email-Matthieu.Moy@imag.fr>
References: <201110101220.21890.brian.foster@maxim-ic.com>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 10 14:55:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDFOA-0008Bv-AZ
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 14:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097Ab1JJMzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 08:55:21 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45235 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993Ab1JJMzU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 08:55:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p9ACq4n1009195
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 10 Oct 2011 14:52:04 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1RDFNd-0007EK-T5; Mon, 10 Oct 2011 14:54:53 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1RDFNd-0007tJ-Pk; Mon, 10 Oct 2011 14:54:53 +0200
X-Mailer: git-send-email 1.7.7.140.ge3099
In-Reply-To: <201110101220.21890.brian.foster@maxim-ic.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 10 Oct 2011 14:52:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p9ACq4n1009195
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1318855926.15919@4hjIw/jamJe6kIjW/ZIwHA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183241>

The previous logic in show_config was to print the delimiter when the
value was set, but Boolean variables have an implicit value "true" when
they appear with no value in the config file. As a result, we got:

git_Config        --get-regexp '.*\.Boolean'	#1. Ok: example.boolean
git_Config --bool --get-regexp '.*\.Boolean'	#2. NO: example.booleantrue

Fix this by defering the display of the separator until after the value
to display has been computed.

Reported-by: Brian Foster <brian.foster@maxim-ic.com>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin/config.c       |   20 +++++++++++++-------
 t/t1300-repo-config.sh |    6 ++++++
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 0b4ecac..0315ad7 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -99,6 +99,7 @@ static int show_config(const char *key_, const char *value_, void *cb)
 	const char *vptr = value;
 	int must_free_vptr = 0;
 	int dup_error = 0;
+	int must_print_delim = 0;
 
 	if (!use_key_regexp && strcmp(key_, key))
 		return 0;
@@ -109,10 +110,8 @@ static int show_config(const char *key_, const char *value_, void *cb)
 		return 0;
 
 	if (show_keys) {
-		if (value_)
-			printf("%s%c", key_, key_delim);
-		else
-			printf("%s", key_);
+		printf("%s", key_);
+		must_print_delim = 1;
 	}
 	if (seen && !do_all)
 		dup_error = 1;
@@ -130,16 +129,23 @@ static int show_config(const char *key_, const char *value_, void *cb)
 	} else if (types == TYPE_PATH) {
 		git_config_pathname(&vptr, key_, value_);
 		must_free_vptr = 1;
+	} else if (value_) {
+		vptr = value_;
+	} else {
+		/* Just show the key name */
+		vptr = "";
+		must_print_delim = 0;
 	}
-	else
-		vptr = value_?value_:"";
 	seen++;
 	if (dup_error) {
 		error("More than one value for the key %s: %s",
 				key_, vptr);
 	}
-	else
+	else {
+		if (must_print_delim)
+			printf("%c", key_delim);
 		printf("%s%c", vptr, term);
+	}
 	if (must_free_vptr)
 		/* If vptr must be freed, it's a pointer to a
 		 * dynamically allocated buffer, it's safe to cast to
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 3e140c1..dffccf8 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -333,6 +333,12 @@ test_expect_success 'get-regexp variable with no value' \
 	'git config --get-regexp novalue > output &&
 	 cmp output expect'
 
+echo 'novalue.variable true' > expect
+
+test_expect_success 'get-regexp --bool variable with no value' \
+	'git config --bool --get-regexp novalue > output &&
+	 cmp output expect'
+
 echo 'emptyvalue.variable ' > expect
 
 test_expect_success 'get-regexp variable with empty value' \
-- 
1.7.7.140.ge3099
