From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v7 04/10] send-email: refactor address list process
Date: Tue, 30 Jun 2015 14:16:45 +0200
Message-ID: <1435666611-18429-5-git-send-email-Matthieu.Moy@imag.fr>
References: <1435666611-18429-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 30 14:17:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9uTi-0005eb-Ie
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 14:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949AbbF3MRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 08:17:23 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39694 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753032AbbF3MRK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 08:17:10 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5UCGvjV015321
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Jun 2015 14:16:57 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5UCGwwd022745;
	Tue, 30 Jun 2015 14:16:58 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z9uTC-00050x-CO; Tue, 30 Jun 2015 14:16:58 +0200
X-Mailer: git-send-email 2.5.0.rc0.10.g7792c2a
In-Reply-To: <1435666611-18429-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 30 Jun 2015 14:16:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5UCGvjV015321
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436271419.08499@/yh8HwAM4OxwLY+L9GMAEg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273050>

From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>

Simplify code by creating a function which transform a list of strings
containing email addresses (separated by commas, comporting aliases)
into a clean list of valid email addresses.

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 git-send-email.perl | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 3cbdb1a..994697e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -839,12 +839,9 @@ sub expand_one_alias {
 	return $aliases{$alias} ? expand_aliases(@{$aliases{$alias}}) : $alias;
 }
 
-@initial_to = expand_aliases(@initial_to);
-@initial_to = validate_address_list(sanitize_address_list(@initial_to));
-@initial_cc = expand_aliases(@initial_cc);
-@initial_cc = validate_address_list(sanitize_address_list(@initial_cc));
-@bcclist = expand_aliases(@bcclist);
-@bcclist = validate_address_list(sanitize_address_list(@bcclist));
+@initial_to = process_address_list(@initial_to);
+@initial_cc = process_address_list(@initial_cc);
+@bcclist = process_address_list(@bcclist);
 
 if ($thread && !defined $initial_reply_to && $prompting) {
 	$initial_reply_to = ask(
@@ -1057,6 +1054,13 @@ sub sanitize_address_list {
 	return (map { sanitize_address($_) } @_);
 }
 
+sub process_address_list {
+	my @addr_list = expand_aliases(@_);
+	@addr_list = sanitize_address_list(@addr_list);
+	@addr_list = validate_address_list(@addr_list);
+	return @addr_list;
+}
+
 # Returns the local Fully Qualified Domain Name (FQDN) if available.
 #
 # Tightly configured MTAa require that a caller sends a real DNS
@@ -1566,10 +1570,8 @@ foreach my $t (@files) {
 		($confirm =~ /^(?:auto|compose)$/ && $compose && $message_num == 1));
 	$needs_confirm = "inform" if ($needs_confirm && $confirm_unconfigured && @cc);
 
-	@to = expand_aliases(@to);
-	@to = validate_address_list(sanitize_address_list(@to));
-	@cc = expand_aliases(@cc);
-	@cc = validate_address_list(sanitize_address_list(@cc));
+	@to = process_address_list(@to);
+	@cc = process_address_list(@cc);
 
 	@to = (@initial_to, @to);
 	@cc = (@initial_cc, @cc);
-- 
2.5.0.rc0.10.g7792c2a
