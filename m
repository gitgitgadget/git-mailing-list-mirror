From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC v4 08/10] send-email: consider quote as delimiter instead of character
Date: Wed, 17 Jun 2015 16:30:33 +0200
Message-ID: <1434551433-24614-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
References: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 16:31:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5EMp-0008Ge-V1
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 16:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754447AbbFQOa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 10:30:58 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:36635 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756928AbbFQOa4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jun 2015 10:30:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id ADEAC488EB;
	Wed, 17 Jun 2015 16:30:54 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ruBvxKedWv5w; Wed, 17 Jun 2015 16:30:54 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 96DD348898;
	Wed, 17 Jun 2015 16:30:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 8BD5820DD;
	Wed, 17 Jun 2015 16:30:54 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CoqxUuzsRj0z; Wed, 17 Jun 2015 16:30:54 +0200 (CEST)
Received: from Groseille.home (AGrenoble-652-1-475-169.w90-52.abo.wanadoo.fr [90.52.146.169])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 9968320D1;
	Wed, 17 Jun 2015 16:30:53 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271847>

Do not consider quote inside a recipient name as character when
they are not escaped. This interprets:

  "Jane" "Doe" <jdoe@example.com>

as:

  "Jane Doe" <jdoe@example.com>

instead of:

  "Jane\" \"Doe" <jdoe@example.com>

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
---

I don't know if it's an argument for this change, but rfc2822 says:

   Semantically, neither the optional CFWS outside of the quote
   characters nor the quote characters themselves are part of the
   quoted-string...

 git-send-email.perl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index a1f6c18..8594ab9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1078,15 +1078,17 @@ sub sanitize_address {
 		return $recipient;
 	}
 
+	# remove non-escaped quotes
+	$recipient_name =~ s/(^|[^\\])"/$1/g;
+
 	# rfc2047 is needed if a non-ascii char is included
 	if ($recipient_name =~ /[^[:ascii:]]/) {
-		$recipient_name =~ s/^"(.*)"$/$1/;
 		$recipient_name = quote_rfc2047($recipient_name);
 	}
 
 	# double quotes are needed if specials or CTLs are included
 	elsif ($recipient_name =~ /[][()<>@,;:\\".\000-\037\177]/) {
-		$recipient_name =~ s/(["\\\r])/\\$1/g;
+		$recipient_name =~ s/([\\\r])/\\$1/g;
 		$recipient_name = qq["$recipient_name"];
 	}
 
-- 
1.9.1
