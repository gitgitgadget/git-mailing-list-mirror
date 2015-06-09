From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH v3 4/7] send-email: refactor address list process
Date: Tue,  9 Jun 2015 19:56:24 +0200
Message-ID: <1433872587-15515-5-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
References: <1433872587-15515-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 19:57:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Nlh-00053x-Lq
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 19:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbbFIR4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 13:56:48 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:47538 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932071AbbFIR4n (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 13:56:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 20F9B48870;
	Tue,  9 Jun 2015 19:56:42 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ao+IM2vh6ZFL; Tue,  9 Jun 2015 19:56:42 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 089B748800;
	Tue,  9 Jun 2015 19:56:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id 033C020E2;
	Tue,  9 Jun 2015 19:56:42 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XptlFSLa2HE9; Tue,  9 Jun 2015 19:56:41 +0200 (CEST)
Received: from Groseille.home (AGrenoble-652-1-286-96.w82-122.abo.wanadoo.fr [82.122.169.96])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 1E8D720DC;
	Tue,  9 Jun 2015 19:56:41 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1433872587-15515-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271212>

Simplify code by creating a funct (comma separated, with aliases ...)
into a simple list of valid email addresses.

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
---
 git-send-email.perl | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 0cac4b0..59dcfe3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -808,12 +808,9 @@ sub expand_one_alias {
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
@@ -1026,6 +1023,13 @@ sub sanitize_address_list {
 	return (map { sanitize_address($_) } @_);
 }
 
+sub process_address_list {
+    my @addr_list = expand_aliases(@_);
+    @addr_list = sanitize_address_list(@addr_list);
+    @addr_list = validate_address_list(@addr_list);
+    return @addr_list;
+}
+
 # Returns the local Fully Qualified Domain Name (FQDN) if available.
 #
 # Tightly configured MTAa require that a caller sends a real DNS
@@ -1535,10 +1539,8 @@ foreach my $t (@files) {
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
1.9.1
