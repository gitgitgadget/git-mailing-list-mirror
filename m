From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v7 10/10] send-email: suppress meaningless whitespaces in from field
Date: Tue, 30 Jun 2015 14:16:51 +0200
Message-ID: <1435666611-18429-11-git-send-email-Matthieu.Moy@imag.fr>
References: <1435666611-18429-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 30 14:17:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9uTa-0005aN-Vd
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 14:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845AbbF3MRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 08:17:17 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54654 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752988AbbF3MRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 08:17:09 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5UCH2ZV020588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Jun 2015 14:17:02 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5UCH4cg022769;
	Tue, 30 Jun 2015 14:17:04 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z9uTI-00051w-2o; Tue, 30 Jun 2015 14:17:04 +0200
X-Mailer: git-send-email 2.5.0.rc0.10.g7792c2a
In-Reply-To: <1435666611-18429-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 30 Jun 2015 14:17:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5UCH2ZV020588
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436271422.90067@RFPN9qfWBsYnFOuUpJVUJw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273047>

From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>

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
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 git-send-email.perl   |  1 +
 t/t9001-send-email.sh | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 4a681f5..b660cc2 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -792,6 +792,7 @@ if (!$force) {
 }
 
 if (defined $sender) {
+	$sender =~ s/^\s+|\s+$//g;
 	($sender) = expand_aliases($sender);
 } else {
 	$sender = $repoauthor || $repocommitter || '';
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 733431b..5b4a5ce 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1764,4 +1764,28 @@ test_expect_success $PREREQ 'aliases work with email list' '
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
2.5.0.rc0.10.g7792c2a
