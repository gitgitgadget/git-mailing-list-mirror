From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: More detailed error messages for snapshot format
Date: Tue, 24 Jul 2007 23:00:37 +0200
Message-ID: <11853108372532-git-send-email-jnareb@gmail.com>
Cc: Matt McCutchen <hashproduct@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 24 23:00:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDRUu-0003oe-Vp
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 23:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760308AbXGXVAp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 17:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757114AbXGXVAo
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 17:00:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:28927 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760148AbXGXVAn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 17:00:43 -0400
Received: by ug-out-1314.google.com with SMTP id j3so226340ugf
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 14:00:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=maoS4PG0SWLaMKADtwPssEfIYhVgxpTKgOjm0ZgJgiMuZ95To/AK/Nn4TP1cRhtGzKBW+mpAgLMZbftECTByxZ7dMkSSbOd5UdKYMMAnMGaEBQRjQNfKbox/5NIZ1qcZnuOtLOaOpefyUPJplXrikI2a3Jg/Tojze1tBvwtvD6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=oy2Y0uQdkYlElYAhcxX3ZD/LoJRGSlrhNthxYlalSPa+QLV7k6bcKAMWB1vVGe2WmVbz2KYDZZiDEzcsbAHwbwbUDLghcWUa9BtpmabkluhETFf2v1zeSw1cUpweD0Q38rfGlMAcHDh4kP1mZciFKaiwro6kooeJ9foWZo6bvgw=
Received: by 10.67.19.11 with SMTP id w11mr849521ugi.1185310841844;
        Tue, 24 Jul 2007 14:00:41 -0700 (PDT)
Received: from roke.D-201 ( [89.229.8.65])
        by mx.google.com with ESMTPS id b36sm15314231ika.2007.07.24.14.00.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jul 2007 14:00:40 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l6OL0cD5027321;
	Tue, 24 Jul 2007 23:00:40 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l6OL0cJN027320;
	Tue, 24 Jul 2007 23:00:38 +0200
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53646>

Improve error messages for snapshot format in git_snapshot:
distinguish between situation where snapshots are turned off, where
snapshot format ('sf') parameter is invalid, where given snapshot
format does not exist in %known_snapshot_formats hash, and where
gitweb was given unsupported snapshot format.

While at it, use first from all supported snapshots format as default,
if no snapshot format was provided.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index fdfce31..708448c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4317,9 +4317,16 @@ sub git_snapshot {
 	@supported_fmts = filter_snapshot_fmts(@supported_fmts);
 
 	my $format = $cgi->param('sf');
-	unless ($format =~ m/[a-z0-9]+/
-	        && exists($known_snapshot_formats{$format})
-	        && grep($_ eq $format, @supported_fmts)) {
+	if (!@supported_fmts) {
+		die_error('403 Permission denied', "Permission denied");
+	}
+	# default to first supported snapshot format
+	$format ||= $supported_fmts[0];
+	if ($format !~ m/[a-z0-9]+/) {
+		die_error(undef, "Invalid snapshot format parameter");
+	} elsif (!exists($known_snapshot_formats{$format})) {
+		die_error(undef, "Unknown snapshot format");
+	} elsif (!grep($_ eq $format, @supported_fmts)) {
 		die_error(undef, "Unsupported snapshot format");
 	}
 
-- 
1.5.2.4
