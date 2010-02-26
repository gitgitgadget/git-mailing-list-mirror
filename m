From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH v2 1/3] git-svn: Support retrieving passwords with GIT_ASKPASS
Date: Fri, 26 Feb 2010 08:07:25 +0800
Message-ID: <1267142845-3040-1-git-send-email-lznuaa@gmail.com>
References: <3.SQo>
Cc: davvid@gmail.com, Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 01:08:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nknkr-0003P3-8t
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 01:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934670Ab0BZAIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 19:08:17 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48686 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934583Ab0BZAIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 19:08:16 -0500
Received: by gwj16 with SMTP id 16so2088496gwj.19
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 16:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=YUJ/hybCjGwaBksqW8uyV6V9PnPzlgvLVWsTCuQOcHg=;
        b=BUNZJMBMW58A4DvNu5bG0dYgKmfJTt2n0CkEUzBYp0rNdLt/vVpsPEfg3OkBHv2djh
         waTbl99I4pz5HNN9QGUJrlOckOoss8kPF8lrDwsWOuUVPOfdXw+U/qSNnrNDt8NgtNwa
         2WhAMLR70xfArgdA+gRoLreGYm8VoSvAG6VyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Dqgn/SJX1qNKeVqNYusfytydZB64z2UZXlBqTM8fnU6BiPvKGVvoQ8VM7THKbZSnYN
         WFyBzj46ybXJC5mrOjPAxj9PwZW4EwCXp/rObkFAt5oQ7qyVoB7hMdS2bcxP5jD/O6jW
         6CVGYvdH8csgWK9SRSU27k1JrUMgZ8R7sOePY=
Received: by 10.101.131.20 with SMTP id i20mr146418ann.45.1267142893553;
        Thu, 25 Feb 2010 16:08:13 -0800 (PST)
Received: from localhost ([114.93.102.82])
        by mx.google.com with ESMTPS id 14sm460009gxk.11.2010.02.25.16.08.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Feb 2010 16:08:13 -0800 (PST)
X-Mailer: git-send-email 1.6.5.1.1367.gcd48
In-Reply-To: <3.SQo>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141079>

git-svn reads passwords from an interactive terminal.
This behavior cause GUIs to hang waiting for git-svn to
complete

Fix this problem by allowing a password-retrieving command
to be specified in GIT_ASKPASS. SSH_ASKPASS is supported
as a fallback when GIT_ASKPASS is not provided.

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 git-svn.perl |   37 +++++++++++++++++++++++++++----------
 1 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 265852f..cd39792 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -31,6 +31,16 @@ if (! exists $ENV{SVN_SSH}) {
 	}
 }
 
+if (! exists $ENV{GIT_ASKPASS}) {
+	if (exists $ENV{SSH_ASKPASS}) {
+		$ENV{GIT_ASKPASS} = $ENV{SSH_ASKPASS};
+		if ($^O eq 'msys') {
+                        $ENV{GIT_ASKPASS} =~ s/\\/\\\\/g;
+                        $ENV{GIT_ASKPASS} =~ s/(.*)/"$1"/;
+                }
+	}
+}
+
 $Git::SVN::Log::TZ = $ENV{TZ};
 $ENV{TZ} = 'UTC';
 $| = 1; # unbuffer STDOUT
@@ -3966,18 +3976,25 @@ sub username {
 
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
1.7.0.85.g37fda.dirty
