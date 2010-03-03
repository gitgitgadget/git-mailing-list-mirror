From: lznuaa@gmail.com
Subject: [PATCH v4 1/3] git-svn: Support retrieving passwords with GIT_ASKPASS
Date: Wed,  3 Mar 2010 19:35:41 +0800
Message-ID: <4b8e4999.9413f30a.0502.ffff8c81@mx.google.com>
Cc: davvid@gmail.com, Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 03 12:36:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmms0-0006tr-SF
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 12:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253Ab0CCLf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 06:35:56 -0500
Received: from mail-pz0-f201.google.com ([209.85.222.201]:34106 "EHLO
	mail-pz0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713Ab0CCLfz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 06:35:55 -0500
Received: by pzk39 with SMTP id 39so643993pzk.15
        for <git@vger.kernel.org>; Wed, 03 Mar 2010 03:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=oKJ300MIIMZQf0fgrBzMfP+wBuQ8mEQjneCiCpcMcLo=;
        b=joGujcYjy4DeNcUhRYSP/zFGjdj7eB007cGQgICjn+uOS6VK52fDzA7TuDp2swmESh
         PL70BSJ2yMzQ/xPDCvhtUaZhK2n3rmrGXac3quvWq5BflbWMbRAgI+aTe4TmjJ+IOQsi
         hwgBDJ3v8kva2q+OhrMQRa7exsRYom4lBpQ4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=xGlZy04Zp120L48jf/IIj/x8k3DxxdCMJVc40I+eAX7xJAVF00p1a3RPtquKB1f/B5
         O+01cRwcUTEIfrarHVrkleM82fRzKxt7DueOtlFZpLR4p1bow0WU0IhHwdBt1fWIC4u4
         dOxp+eFmecoztTrkvhMD3Nf7V+hwsSrhaqTsI=
Received: by 10.115.39.40 with SMTP id r40mr4243387waj.148.1267616154578;
        Wed, 03 Mar 2010 03:35:54 -0800 (PST)
Received: from localhost ([114.93.102.82])
        by mx.google.com with ESMTPS id 20sm5723349pzk.15.2010.03.03.03.35.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Mar 2010 03:35:53 -0800 (PST)
X-Mailer: git-send-email 1.6.5.1.1367.gcd48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141443>

From: Frank Li <lznuaa@gmail.com>

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
1.7.0.86.g013a4.dirty
