From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC v2 5/5] send-email: refactor address list process
Date: Sat,  6 Jun 2015 18:59:36 +0200
Message-ID: <1433609976-1868-5-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
References: <1433609976-1868-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 19:01:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1HTM-0002wx-3e
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 19:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632AbbFFRBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 13:01:24 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:40596 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752842AbbFFRAS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Jun 2015 13:00:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 91A152629;
	Sat,  6 Jun 2015 19:00:16 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lTvNOygpYfnN; Sat,  6 Jun 2015 19:00:16 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 7F5D625AE;
	Sat,  6 Jun 2015 19:00:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 79D5520E4;
	Sat,  6 Jun 2015 19:00:16 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WbNt3MrQbFOo; Sat,  6 Jun 2015 19:00:16 +0200 (CEST)
Received: from Groseille.home (AGrenoble-652-1-407-223.w90-42.abo.wanadoo.fr [90.42.42.223])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 8F4F820DF;
	Sat,  6 Jun 2015 19:00:15 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1433609976-1868-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270938>

Simplify code by creating a function to transform list of email lists
(comma separated, with aliases ...)  into a simple list of valid email
addresses.

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
---
 I'm not sure about the name of the function...

 git-send-email.perl | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 4bc489d..ea03308 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -794,15 +794,9 @@ sub expand_one_alias {
 	return $aliases{$alias} ? expand_aliases(@{$aliases{$alias}}) : $alias;
 }
 
-@initial_to = split_at_commas(@initial_to);
-@initial_to = expand_aliases(@initial_to);
-@initial_to = validate_address_list(sanitize_address_list(@initial_to));
+@initial_to = process_address_list(@initial_to);
-@initial_cc = split_at_commas(@initial_cc);
-@initial_cc = expand_aliases(@initial_cc);
-@initial_cc = validate_address_list(sanitize_address_list(@initial_cc));
+@initial_cc = process_address_list(@initial_cc);
-@bcclist = split_at_commas(@bcclist);
-@bcclist = expand_aliases(@bcclist);
-@bcclist = validate_address_list(sanitize_address_list(@bcclist));
+@bcclist = process_address_list(@bcclist);
 
 if ($thread && !defined $initial_reply_to && $prompting) {
 	$initial_reply_to = ask(
@@ -1019,6 +1013,14 @@ sub split_at_commas {
 	return (map { split /\s*,\s*/, $_ } @_);
 }
 
+sub process_address_list {
+    my @addr_list = split_at_commas(@_);
+    @addr_list = expand_aliases(@addr_list);
+    @addr_list = sanitize_address_list(@addr_list);
+    @addr_list = validate_address_list(@addr_list);
+    return @addr_list;
+}
+
 # Returns the local Fully Qualified Domain Name (FQDN) if available.
 #
 # Tightly configured MTAa require that a caller sends a real DNS
@@ -1528,12 +1530,8 @@ foreach my $t (@files) {
 		($confirm =~ /^(?:auto|compose)$/ && $compose && $message_num == 1));
 	$needs_confirm = "inform" if ($needs_confirm && $confirm_unconfigured && @cc);
 
-	@to = split_at_commas(@to);
-	@to = expand_aliases(@to);
-	@to = validate_address_list(sanitize_address_list(@to));
+	@to = process_address_list(@to);
-	@cc = split_at_commas(@cc);
-	@cc = expand_aliases(@cc);
-	@cc = validate_address_list(sanitize_address_list(@cc));
+	@cc = process_address_list(@cc);
 
 	@to = (@initial_to, @to);
 	@cc = (@initial_cc, @cc);
-- 
1.9.1
