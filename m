From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH v3 1/3] git-svn: Support retrieving passwords with GIT_ASKPASS
Date: Tue,  2 Mar 2010 19:47:52 +0800
Message-ID: <1267530472-2308-1-git-send-email-lznuaa@gmail.com>
Cc: davvid@gmail.com, Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 02 12:55:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmQgy-0001vt-Ph
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 12:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618Ab0CBLzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 06:55:05 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:52400 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab0CBLzD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 06:55:03 -0500
Received: by pva4 with SMTP id 4so43902pva.19
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 03:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=1hCiR7vLxZ7Xt3JD34dju12FiC/vtum94z4bkSL5dcg=;
        b=KKaOSwSvEk+VwK1mMMa5d3XX17Jk0XhINY/dlBuGukDkY7Zu4+dtDZfJP/MNt6oMIt
         KuQc5Il3Z1QlQzipWDYDo+HkUE6ym2c9r03ejKpw9n/DC788yFUrdgq/NE3yciCFvaA3
         sLmUSLi9/pe7o9JXuNTMHISLxX7IEtJuEbEDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=dyD1DTooPe2lo9wgaeBg6t6PA4IzQv9XUKTNlx1nX6l2ZNn/kAOYx+q4sZRjvWGmUO
         dys/xDUKmGjItdBVzgGHvVFYPMpyFbg+qBho3i/tbEmcxsnxB2qYAppEYJVQc7YSYX57
         mdr9kT40NLoBCuOssMdGBWRlc6fD/GvsnZRX0=
Received: by 10.142.121.10 with SMTP id t10mr3394667wfc.152.1267530485967;
        Tue, 02 Mar 2010 03:48:05 -0800 (PST)
Received: from localhost ([114.93.102.82])
        by mx.google.com with ESMTPS id 22sm4590938pzk.1.2010.03.02.03.48.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Mar 2010 03:48:05 -0800 (PST)
X-Mailer: git-send-email 1.6.5.1.1367.gcd48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141390>

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
1.7.0.86.g45191
