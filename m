From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix usability of $prevent_xss
Date: Sat,  4 Jun 2011 10:43:35 +0200
Message-ID: <1307177015-880-1-git-send-email-jnareb@gmail.com>
Cc: Matt McCutchen <matt@mattmccutchen.net>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 10:44:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSmTJ-00027A-DE
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 10:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754436Ab1FDIog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jun 2011 04:44:36 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44187 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970Ab1FDIof (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2011 04:44:35 -0400
Received: by bwz15 with SMTP id 15so2288577bwz.19
        for <git@vger.kernel.org>; Sat, 04 Jun 2011 01:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=BI8Rl9rBRecp9HaFEQqG7lbV7A74QTEpUVx0hjwAmRs=;
        b=YWDYclDxSXBWDrX9J2dmHd6ChIZxJNiWWZ8LF8YClA608QIbBp/mw/7rLI/F1grGnZ
         724afQRlTqcnBgVlYC5qogRZ/Q/XievhYQcBlI/aaNKCGMGXThM6XBice+BSoMX/nlZL
         4cF2JECUwave7ETLafhgHRA4Q4M2k9e1kKX3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=dBEbXoCZ8KSjC2aw47G4NyVLm2oQ2Xug+o8l/oytUc7SySLI8GGVy8cCG8WZklmUVw
         EkCwjcF0kYrr0uDkW4jSzazkfQBWXGlkLg0g4eHs2RqbBU5HV0gyNXE2EPS/4h2jvDkg
         Yvs9IWnDRN14IBPZPNs1uAQoj/7OKgFEqu5Y4=
Received: by 10.204.41.206 with SMTP id p14mr2599272bke.53.1307177073976;
        Sat, 04 Jun 2011 01:44:33 -0700 (PDT)
Received: from localhost.localdomain (abwc24.neoplus.adsl.tpnet.pl [83.8.226.24])
        by mx.google.com with ESMTPS id af13sm1815920bkc.19.2011.06.04.01.44.32
        (version=SSLv3 cipher=OTHER);
        Sat, 04 Jun 2011 01:44:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175057>

With XSS prevention on (enabled using $prevent_xss), blobs
('blob_plain') of all types except a few known safe ones are served
with "Content-Disposition: attachment".  However the check was too
strict; it didn't take into account optional parameter attributes,

  media-type     = type "/" subtype *( ";" parameter )

as described in RFC 2616

  http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.17
  http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html#sec3.7

This fixes that, and it for example treats following as safe MIME
media type:

  text/plain; charset=utf-8

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The fact that it this buglet was present for so long, since its
introduction by Matt McCutchen in 7e1100e (gitweb: add $prevent_xss
option to prevent XSS by repository content, 2009-02-07) without
complaint shows that not many people are using this feature...

That, and that we don't have automated tests for that.

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index dc3f37d..85acbed 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6139,7 +6139,7 @@ sub git_blob_plain {
 	# want to be sure not to break that by serving the image as an
 	# attachment (though Firefox 3 doesn't seem to care).
 	my $sandbox = $prevent_xss &&
-		$type !~ m!^(?:text/plain|image/(?:gif|png|jpeg))$!;
+		$type !~ m!^(?:text/plain|image/(?:gif|png|jpeg))(?:[ ;]|$)!;
 
 	print $cgi->header(
 		-type => $type,
-- 
1.7.5
