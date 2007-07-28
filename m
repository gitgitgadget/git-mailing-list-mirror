From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Allow for multivalued parameters passed to href subroutine
Date: Sun, 29 Jul 2007 01:04:09 +0200
Message-ID: <1185663849243-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 29 01:04:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEvKb-000650-HL
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 01:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758049AbXG1XEO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 19:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758021AbXG1XEO
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 19:04:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:23625 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757913AbXG1XEN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 19:04:13 -0400
Received: by ug-out-1314.google.com with SMTP id j3so877067ugf
        for <git@vger.kernel.org>; Sat, 28 Jul 2007 16:04:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=aP4tS7TewPzII+a58pbHzy1AOhlOaFkZCIY6Jv7/TrqLeDv0jK/R9zKE2dIhulG6K3oOOTYSK9B9OnZ/8nW53lO6C5dxDFP82+sy0+WRi+QylKO2t3ekf9xfu8H1PYM671LrSNlYl4qUF+LhJGgPk+yKN3hywQrbuWKLUdjkqQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=dG0IX1L4Uiboi0V2B0/bkvbofC239TbhqQynF9SWp9DwZ78IB4Suywzica3E89mK2qXdWI8llz/gWmTyRh7dg/2ChjP91rHt+lZ+6g8ucB6JImajE6d4bdWbD1FkrTZNsOAqrQY+sSjmhatcXTBJLM4d8PuUG7NR/4I1Nn7qqPs=
Received: by 10.66.216.8 with SMTP id o8mr4011690ugg.1185663851621;
        Sat, 28 Jul 2007 16:04:11 -0700 (PDT)
Received: from roke.D-201 ( [89.229.8.65])
        by mx.google.com with ESMTPS id b30sm2582545ika.2007.07.28.16.04.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jul 2007 16:04:10 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l6SN4AGG031747;
	Sun, 29 Jul 2007 01:04:11 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l6SN49f5031746;
	Sun, 29 Jul 2007 01:04:09 +0200
X-Mailer: git-send-email 1.5.3.rc3.14.g0bd7-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54066>

Make it possible to generate URLs with multivalued parameters in the
href() subroutine, via passing reference to array of values.

Example:
  href(action=>"log", extra_options=>["--no-merges", "--first-parent"])

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8a32899..498b936 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -629,7 +629,13 @@ sub href(%) {
 	for (my $i = 0; $i < @mapping; $i += 2) {
 		my ($name, $symbol) = ($mapping[$i], $mapping[$i+1]);
 		if (defined $params{$name}) {
-			push @result, $symbol . "=" . esc_param($params{$name});
+			if (ref($params{$name}) eq "ARRAY") {
+				foreach my $par (@{$params{$name}}) {
+					push @result, $symbol . "=" . esc_param($par);
+				}
+			} else {
+				push @result, $symbol . "=" . esc_param($params{$name});
+			}
 		}
 	}
 	$href .= "?" . join(';', @result) if scalar @result;
-- 
1.5.2.4
