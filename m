From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH v5 10/10] send-email: suppress meaningless whitespaces in from field
Date: Sun, 21 Jun 2015 14:45:56 +0200
Message-ID: <1434890756-5059-3-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
References: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
 <1434890756-5059-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 14:46:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6edf-0003Lq-Ga
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 14:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbbFUMqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 08:46:06 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:37696 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751630AbbFUMqB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Jun 2015 08:46:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 7FF872980;
	Sun, 21 Jun 2015 14:45:59 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vXooJzDY6oAv; Sun, 21 Jun 2015 14:45:59 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 6629B290D;
	Sun, 21 Jun 2015 14:45:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id 61B8620D3;
	Sun, 21 Jun 2015 14:45:59 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id at59HbGDOrVg; Sun, 21 Jun 2015 14:45:59 +0200 (CEST)
Received: from localhost.localdomain (cor91-7-83-156-199-91.fbx.proxad.net [83.156.199.91])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id DE9A820D9;
	Sun, 21 Jun 2015 14:45:58 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1434890756-5059-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272257>

Remove leading and trailing whitespaces in from field before
interepreting it to improve consistency with other options.  The
split_addrs function already take care of trailing and leading
whitespaces for to, cc and bcc fields.
The from option now:

 - has the same behavior when passing arguments like
   "  jdoe@example.com ", "\t jdoe@example.com " or
   "jdoe@example.com".

 - interprets aliases in string containing leading and trailing
   whitespaces such as " alias" or "alias\t" like other options.

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
---
 git-send-email.perl   |  1 +
 t/t9001-send-email.sh | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 8bf6656..749d809 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -786,6 +786,7 @@ if (!$force) {
 }
 
 if (defined $sender) {
+	$sender =~ s/^\s+|\s+$//g;
 	($sender) = expand_aliases($sender);
 } else {
 	$sender = $repoauthor || $repocommitter || '';
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 3c5b853..8e21fb0 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1719,4 +1719,28 @@ test_expect_success $PREREQ 'aliases work with email list' '
 	test_cmp expected-list actual-list
 '
 
+test_expect_success $PREREQ 'leading and trailing whitespaces are removed' '
+	echo "alias to2 to2@example.com" >.mutt &&
+	echo "alias cc1 Cc 1 <cc1@example.com>" >>.mutt &&
+	test_config sendemail.aliasesfile ".mutt" &&
+	test_config sendemail.aliasfiletype mutt &&
+	TO1=$(echo "QTo 1 <to1@example.com>" | q_to_tab) &&
+	TO2=$(echo "QZto2" | qz_to_tab_space) &&
+	CC1=$(echo "cc1" | append_cr) &&
+	BCC1=$(echo "Q bcc1@example.com Q" | q_to_nul) &&
+	git send-email \
+	--dry-run \
+	--from="	Example <from@example.com>" \
+	--to="$TO1" \
+	--to="$TO2" \
+	--to="  to3@example.com   " \
+	--cc="$CC1" \
+	--cc="Cc2 <cc2@example.com>" \
+	--bcc="$BCC1" \
+	--bcc="bcc2@example.com" \
+	0001-add-master.patch | replace_variable_fields \
+	>actual-list &&
+	test_cmp expected-list actual-list
+'
+
 test_done
-- 
1.9.1
