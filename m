From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v7 08/10] send-email: consider quote as delimiter instead of character
Date: Tue, 30 Jun 2015 14:16:49 +0200
Message-ID: <1435666611-18429-9-git-send-email-Matthieu.Moy@imag.fr>
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
	id 1Z9uTj-0005eb-5w
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 14:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbbF3MR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 08:17:26 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54659 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752531AbbF3MRK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 08:17:10 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5UCH0Ga020575
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Jun 2015 14:17:00 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5UCH2s8022757;
	Tue, 30 Jun 2015 14:17:02 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z9uTG-00051c-85; Tue, 30 Jun 2015 14:17:02 +0200
X-Mailer: git-send-email 2.5.0.rc0.10.g7792c2a
In-Reply-To: <1435666611-18429-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 30 Jun 2015 14:17:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5UCH0Ga020575
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436271421.14651@iemfq+ZSL8+Zqm3TIvosaA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273049>

From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>

Do not consider quote inside a recipient name as character when
they are not escaped. This interprets:

  "Jane" "Doe" <jdoe@example.com>

as:

  "Jane Doe" <jdoe@example.com>

instead of:

  "Jane\" \"Doe" <jdoe@example.com>

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 git-send-email.perl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 4268ed9..df9d3f6 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1034,15 +1034,17 @@ sub sanitize_address {
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
2.5.0.rc0.10.g7792c2a
