From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH v3 7/7] send-email: suppress leading and trailing whitespaces before alias expansion
Date: Tue,  9 Jun 2015 20:50:04 +0200
Message-ID: <1433875804-16007-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
References: <1433875804-16007-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 20:50:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2ObU-0001BB-N5
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 20:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933185AbbFISuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 14:50:21 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:48233 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933186AbbFISuR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 14:50:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 294C748866;
	Tue,  9 Jun 2015 20:50:15 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6EMZT7McVOh0; Tue,  9 Jun 2015 20:50:15 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 0F44048800;
	Tue,  9 Jun 2015 20:50:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id 09DA120E2;
	Tue,  9 Jun 2015 20:50:15 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QLNoTWu0by9K; Tue,  9 Jun 2015 20:50:14 +0200 (CEST)
Received: from Groseille.home (AGrenoble-652-1-286-96.w82-122.abo.wanadoo.fr [82.122.169.96])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 23A7320DC;
	Tue,  9 Jun 2015 20:50:14 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1433875804-16007-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271226>

As alias file formats supported by git send-email doesn't take
whitespace into account, it is useless to consider whitespaces in
alias name. remove leading and trailing whitespace before expanding
allow to recognize strings like " alias" or "alias\t" passed by --to,
--cc, --bcc options or by the git send-email prompt.

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
---
 git-send-email.perl   |  1 +
 t/t9001-send-email.sh | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 3d144bd..34c8b8b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -787,6 +787,7 @@ sub expand_aliases {
 my %EXPANDED_ALIASES;
 sub expand_one_alias {
 	my $alias = shift;
+	$alias =~ s/^\s+|\s+$//g;
 	if ($EXPANDED_ALIASES{$alias}) {
 		die "fatal: alias '$alias' expands to itself\n";
 	}
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 9aee474..bbfed56 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1692,4 +1692,28 @@ test_expect_success $PREREQ 'aliases work with email list' '
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
