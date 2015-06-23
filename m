From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH v6 04/10] send-email: refactor address list process
Date: Tue, 23 Jun 2015 22:30:10 +0200
Message-ID: <1435091416-9394-4-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
References: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
 <1435091416-9394-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 23 22:30:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7Uq7-0000hK-Uv
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 22:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933278AbbFWUah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 16:30:37 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:56624 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933042AbbFWUac (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jun 2015 16:30:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 20FB92945;
	Tue, 23 Jun 2015 22:30:31 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AR5dSnHJdLuf; Tue, 23 Jun 2015 22:30:31 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 07A492941;
	Tue, 23 Jun 2015 22:30:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 02B5C20DC;
	Tue, 23 Jun 2015 22:30:31 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y-Mg24BVmHQH; Tue, 23 Jun 2015 22:30:30 +0200 (CEST)
Received: from localhost.localdomain (cor91-7-83-156-199-91.fbx.proxad.net [83.156.199.91])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 8DD2520DA;
	Tue, 23 Jun 2015 22:30:30 +0200 (CEST)
X-Mailer: git-send-email 2.4.4.418.ga60dbe1
In-Reply-To: <1435091416-9394-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272502>

Simplify code by creating a function which transform a list of strings
containing email addresses (separated by commas, comporting aliases)
into a clean list of valid email addresses.

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
---
 git-send-email.perl | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 8bf38ee..2d5c530 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -833,12 +833,9 @@ sub expand_one_alias {
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
@@ -1051,6 +1048,13 @@ sub sanitize_address_list {
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
@@ -1560,10 +1564,8 @@ foreach my $t (@files) {
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
