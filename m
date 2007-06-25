From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 2/3] config: Change output of --get-regexp for valueless keys
Date: Mon, 25 Jun 2007 16:03:54 +0200
Message-ID: <11827802363555-git-send-email-frank@lichtenheld.de>
References: <200706220156.01175.jnareb@gmail.com>
Cc: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 25 16:04:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2pAw-0002Oq-0j
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 16:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860AbXFYOEI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 10:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754829AbXFYOEI
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 10:04:08 -0400
Received: from v32413.1blu.de ([88.84.155.73]:55703 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753659AbXFYOEG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 10:04:06 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1I2pAi-00044T-2L; Mon, 25 Jun 2007 16:04:04 +0200
Received: from p54b0ff8c.dip.t-dialin.net ([84.176.255.140] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1I2pAh-0000da-7V; Mon, 25 Jun 2007 16:04:03 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1I2pAb-0004kZ-Vh; Mon, 25 Jun 2007 16:03:57 +0200
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <200706220156.01175.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50897>

Print no space after the name of a key without value.
Otherwise keys without values are printed exactly the
same as keys with empty values.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 builtin-config.c       |    8 ++++++--
 t/t1300-repo-config.sh |    6 ++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

 I hope that nobody depends on this specific behaviour.
 Backwards compatibilty would be a pain here, since the --null
 patch would get really complicated

diff --git a/builtin-config.c b/builtin-config.c
index b2515f7..dbc2339 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -38,8 +38,12 @@ static int show_config(const char* key_, const char* value_)
 			  regexec(regexp, (value_?value_:""), 0, NULL, 0)))
 		return 0;
 
-	if (show_keys)
-		printf("%s ", key_);
+	if (show_keys) {
+		if (value_)
+			printf("%s ", key_);
+		else
+			printf("%s", key_);
+	}
 	if (seen && !do_all)
 		dup_error = 1;
 	if (type == T_INT)
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 7731fa7..8b5e9fc 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -283,6 +283,12 @@ EOF
 test_expect_success 'get variable with no value' \
 	'git-config --get novalue.variable ^$'
 
+echo novalue.variable > expect
+
+test_expect_success 'get-regexp variable with no value' \
+	'git-config --get-regexp novalue > output &&
+	 cmp output expect' 
+
 git-config > output 2>&1
 
 test_expect_success 'no arguments, but no crash' \
-- 
1.5.2.1
