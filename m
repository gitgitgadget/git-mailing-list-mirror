From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH v6 08/10] send-email: consider quote as delimiter instead of character
Date: Tue, 23 Jun 2015 22:40:01 +0200
Message-ID: <1435092001-9923-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
References: <1435091416-9394-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 23 22:40:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7UzN-0006Kt-49
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 22:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881AbbFWUkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 16:40:09 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:43095 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754766AbbFWUkI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jun 2015 16:40:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id D28822701;
	Tue, 23 Jun 2015 22:40:06 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CP0Jfs8GFvIj; Tue, 23 Jun 2015 22:40:06 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id B9C222656;
	Tue, 23 Jun 2015 22:40:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id B0F1520DC;
	Tue, 23 Jun 2015 22:40:06 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bePBSKh58kq5; Tue, 23 Jun 2015 22:40:06 +0200 (CEST)
Received: from localhost.localdomain (cor91-7-83-156-199-91.fbx.proxad.net [83.156.199.91])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 4711C20DA;
	Tue, 23 Jun 2015 22:40:06 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1435091416-9394-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272511>

Do not consider quote inside a recipient name as character when
they are not escaped. This interprets:

  "Jane" "Doe" <jdoe@example.com>

as:

  "Jane Doe" <jdoe@example.com>

instead of:

  "Jane\" \"Doe" <jdoe@example.com>

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
---
 git-send-email.perl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index bced78e..a03392c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1028,15 +1028,17 @@ sub sanitize_address {
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
