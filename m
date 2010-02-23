From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH 1/1] Use GIT_ASKPASS environment to launch thirdpart UI app to get password
Date: Tue, 23 Feb 2010 19:11:03 +0800
Message-ID: <1266923463-2828-1-git-send-email-lznuaa@gmail.com>
Cc: Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 12:18:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njsmh-000228-7y
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 12:18:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310Ab0BWLS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 06:18:29 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43174 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863Ab0BWLS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 06:18:28 -0500
Received: by pwj8 with SMTP id 8so3717702pwj.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 03:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=OQHxiG5jwWonYMYCUXgWgsq0/FT13uXqz+0bvMfohvA=;
        b=o6+J8+yRubmW79pJuf3IO9YoBOJjDHlslGNBEa/JSB19ZdL1HeYgAuugSamfcJXvyq
         VsW2bj0nS9aQ9jU7caoc0re2+hgo0QJAGUcLU5Nkc2NhBqc9oO2FL7UvpKZ2bnoHEC0d
         mdt0rNefPGNK65XPJq1igE35te3FJy5jVboQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=wTo4tJcpp4GzC8Q0JiXnjvdGyXPFD4a/D/QbA+Ow+dmTPPBfukKhj5PDL29jNlJFia
         7XcPhuwU4Kum/1kTyA4oiTacW14RCrMXC64d69nNX77DgVqFJDBJlUUyceXYJwGJIY1Z
         Xib6rYx3F/MX8iD6eYM8kqRc8lySPEWKKGmBE=
Received: by 10.114.187.7 with SMTP id k7mr1877306waf.153.1266923482471;
        Tue, 23 Feb 2010 03:11:22 -0800 (PST)
Received: from localhost ([222.67.191.196])
        by mx.google.com with ESMTPS id 23sm608467pzk.10.2010.02.23.03.11.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 03:11:22 -0800 (PST)
X-Mailer: git-send-email 1.6.5.1.1367.gcd48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140787>

Default git-svn read charactor from terminal to get password. GUI will
wait forever because don't know password need input.

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 git-svn.perl |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 265852f..f9f104e 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3966,18 +3966,25 @@ sub username {
 
 sub _read_password {
 	my ($prompt, $realm) = @_;
-	print STDERR $prompt;
-	STDERR->flush;
-	require Term::ReadKey;
-	Term::ReadKey::ReadMode('noecho');
 	my $password = '';
-	while (defined(my $key = Term::ReadKey::ReadKey(0))) {
-		last if $key =~ /[\012\015]/; # \n\r
-		$password .= $key;
+	if (exists $ENV{GIT_ASKPASS}) {
+		open(PH, "$ENV{GIT_ASKPASS} \"$prompt\" |");
+		$password = <PH>;
+		$password =~ s/[\012\015]//; # \n\r
+		close(PH);
+	} else {
+		print STDERR $prompt;
+		STDERR->flush;
+		require Term::ReadKey;
+		Term::ReadKey::ReadMode('noecho');
+		while (defined(my $key = Term::ReadKey::ReadKey(0))) {
+			last if $key =~ /[\012\015]/; # \n\r
+			$password .= $key;
+		}
+		Term::ReadKey::ReadMode('restore');
+		print STDERR "\n";
+		STDERR->flush;
 	}
-	Term::ReadKey::ReadMode('restore');
-	print STDERR "\n";
-	STDERR->flush;
 	$password;
 }
 
-- 
1.7.0.83.g241b9.dirty
