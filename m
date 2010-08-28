From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] core.attributesfile: a fix, a simplification, and a test
Date: Sat, 28 Aug 2010 20:41:10 +0200
Message-ID: <1283020870-24888-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqy6bqr3ep.fsf@bauges.imag.fr>
Cc: Petr Onderka <gsvick@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 28 20:41:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpQLP-0004S8-TT
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 20:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413Ab0H1Slb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 14:41:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44271 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753143Ab0H1Sla (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 14:41:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o7SIc3XM018773
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 28 Aug 2010 20:38:03 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OpQLF-0008AC-J4; Sat, 28 Aug 2010 20:41:25 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OpQLF-0006Tz-Ho; Sat, 28 Aug 2010 20:41:25 +0200
X-Mailer: git-send-email 1.7.2.2.175.ga619d.dirty
In-Reply-To: <vpqy6bqr3ep.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 28 Aug 2010 20:38:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7SIc3XM018773
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1283625486.50658@9ZR1vgk6b8eZd76yaHne0w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154656>

Patch meant to be squashed into the core.attributesfile.

* attributes_file won't be set unless one calls git_config before => do
  this.

* There was a useless xstrdup/free in the code.

* This really deserves a test, so I added one in t0003-attributes.sh.
  (I've been too lazy to check the system-wide attributes file, though)

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 attr.c                |    6 ++----
 t/t0003-attributes.sh |   14 ++++++++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/attr.c b/attr.c
index 068e13b..342791a 100644
--- a/attr.c
+++ b/attr.c
@@ -500,11 +500,9 @@ static void bootstrap_attr_stack(void)
 			}
 		}
 
+		git_config(git_default_config, NULL);
 		if (git_attr_global() && attributes_file) {
-			char *user_attr = xstrdup(attributes_file);
-
-			elem = read_attr_from_file(user_attr, 1);
-			free(user_attr);
+			elem = read_attr_from_file(attributes_file, 1);
 			if (elem) {
 				elem->origin = NULL;
 				elem->prev = attr_stack;
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index de38c7f..24286e5 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -15,6 +15,7 @@ attr_check () {
 
 }
 
+HOME=$(pwd)
 
 test_expect_success 'setup' '
 
@@ -36,6 +37,9 @@ test_expect_success 'setup' '
 		echo "d/* test=a/b/d/*"
 		echo "d/yes notest"
 	) >a/b/.gitattributes
+	(
+		echo "global test=global"
+	) >$HOME/global-gitattributes
 
 '
 
@@ -57,6 +61,16 @@ test_expect_success 'attribute test' '
 
 '
 
+test_expect_success 'core.attributesfile' '
+	attr_check global unspecified &&
+	git config core.attributesfile "$HOME/global-gitattributes" &&
+	attr_check global global &&
+	git config core.attributesfile "~/global-gitattributes" &&
+	attr_check global global &&
+	echo "global test=precedence" >> .gitattributes &&
+	attr_check global precedence
+'
+
 test_expect_success 'attribute test: read paths from stdin' '
 
 	cat <<EOF > expect
-- 
1.7.2.2.175.ga619d.dirty
