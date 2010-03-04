From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH v5 1/3] git-svn: Support retrieving passwords with GIT_ASKPASS
Date: Thu,  4 Mar 2010 22:31:13 +0800
Message-ID: <1267713074-4316-1-git-send-email-lznuaa@gmail.com>
Cc: davvid@gmail.com, Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 04 15:31:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnC5f-0008Nd-6e
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 15:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841Ab0CDObh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 09:31:37 -0500
Received: from mail-ew0-f220.google.com ([209.85.219.220]:61456 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725Ab0CDObg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 09:31:36 -0500
Received: by ewy20 with SMTP id 20so1728219ewy.21
        for <git@vger.kernel.org>; Thu, 04 Mar 2010 06:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=eXGmJmwwLcPMFUjy3vMkT9TID8ikJ/JVXw602JIvnHw=;
        b=suewqgQrUSJxupZokq2HN6Cr4nRSfL3lIx5xXqsnokCYZ3fuxrBIQ3MKeLWKygsILT
         6QYBV0+urR2c5WB5TMddHRK2MW53286g9rSVIOdxjLtEpfb61y2guOfIFYHu1GzFTTIE
         yKs6tQzRFregMtGegv1NvOLZ0Zg7NWTHdpkv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=O5W8RCWJlaH83f4/WsW8xsk/wlLNidbYnS0s6r64at+PNhjv9FndUlgD1p4UvqtKsC
         6x7REBLsYGSouCm8cSw6TNoNsvybxGFl8cwuBTgCFvXwnl9UBD+930emk69MiLZONaT+
         H/lxB2n2A114GtyeJnMp/Ipc4vPzAqDZ79obE=
Received: by 10.213.1.143 with SMTP id 15mr924810ebf.55.1267713095248;
        Thu, 04 Mar 2010 06:31:35 -0800 (PST)
Received: from localhost ([114.93.102.82])
        by mx.google.com with ESMTPS id 5sm1566718eyf.27.2010.03.04.06.31.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Mar 2010 06:31:34 -0800 (PST)
X-Mailer: git-send-email 1.6.5.1.1367.gcd48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141524>

git-svn reads passwords from an interactive terminal.
This behavior cause GUIs to hang waiting for git-svn to
complete

Fix this problem by allowing a password-retrieving command
to be specified in GIT_ASKPASS. SSH_ASKPASS is supported
as a fallback when GIT_ASKPASS is not provided.

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 git-svn.perl |   33 +++++++++++++++++++++++----------
 1 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 265852f..308d0df 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -31,6 +31,12 @@ if (! exists $ENV{SVN_SSH}) {
 	}
 }
 
+if (! exists $ENV{GIT_ASKPASS}) {
+	if (exists $ENV{SSH_ASKPASS}) {
+		$ENV{GIT_ASKPASS} = $ENV{SSH_ASKPASS};
+	}
+}
+
 $Git::SVN::Log::TZ = $ENV{TZ};
 $ENV{TZ} = 'UTC';
 $| = 1; # unbuffer STDOUT
@@ -3966,18 +3972,25 @@ sub username {
 
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
+		open(PH, "-|", $ENV{GIT_ASKPASS}, $prompt);
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
1.7.0.86.g84fa0
