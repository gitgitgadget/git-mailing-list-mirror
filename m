From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 3/6] git-cvsserver: indent & clean up authdb code
Date: Sat, 15 May 2010 02:46:01 +0000
Message-ID: <1273891564-7523-4-git-send-email-avarab@gmail.com>
References: <7v3an9tc5w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 15 04:47:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OD7PC-0008Qv-IP
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 04:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756595Ab0EOCqz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 May 2010 22:46:55 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:12952 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756132Ab0EOCqo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 22:46:44 -0400
Received: by fg-out-1718.google.com with SMTP id 19so576986fgg.1
        for <git@vger.kernel.org>; Fri, 14 May 2010 19:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=w7DZIegg4YZAh7OVnWjmnplWED7Z8IdOawSZ2kyupl0=;
        b=wWz2dGjVmG1xuVsfOURwbH1vz7hkEy4eq1iOftXKkvWICjq+U5/QAsGKLBVf1dg3DQ
         quHDhkshv9KvV/MwO3ED7fpVojmCZ0M0bv7jW5gM7eKqDy+HwkGjl9Z8P6gSvlLA+Aw9
         RKXQ6PVhoVks1YuqzbjlrDbPpfTYmHEbXIeBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=EhPZ0mAzBIU2/BzlqS6zYWnQNG2Xk41Bg30dQN9FdLNMsIQcSitFobco/6h3r6RoGO
         RYR8EH5He42ttQ9UbkHuFkUcGL44UiKSTdOZpzhWJLzkrm2fXyQ7XgvQ5CPOmHsFp5ER
         mJOgkEIMqfRTa6EVbfiZ8kP1QQmrAxOjyCPsY=
Received: by 10.87.63.31 with SMTP id q31mr3940428fgk.18.1273891603187;
        Fri, 14 May 2010 19:46:43 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id 22sm4155718fkq.17.2010.05.14.19.46.41
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 19:46:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.84.gd92f8
In-Reply-To: <7v3an9tc5w.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147132>

 - Indent the last commit to fit with the rest of the code.

 - Use lexical filehandles instead of global globs

 - Close the filehandle after the password database has been read.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-cvsserver.perl |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index ca02fba..9f63c56 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -194,16 +194,19 @@ if ($state->{method} eq 'pserver') {
             print "I HATE YOU\n";
             exit 1;
         }
-	my $auth_ok;
-	open PASSWD, "<$cfg->{gitcvs}->{authdb}" or die $!;
-	while(<PASSWD>) {
-	    if (m{^\Q$user\E:(.*)}) {
-		if (crypt($user, $1) eq $1) {
-		    $auth_ok =3D 1;
-		}
-	    };
-	}
-	unless ($auth_ok) {
+
+        my $auth_ok;
+        open my $passwd, "<", $cfg->{gitcvs}->{authdb} or die $!;
+        while (<$passwd>) {
+            if (m{^\Q$user\E:(.*)}) {
+                if (crypt($user, $1) eq $1) {
+                    $auth_ok =3D 1;
+                }
+            };
+        }
+        close $passwd;
+
+        unless ($auth_ok) {
             print "I HATE YOU\n";
             exit 1;
         }
--=20
1.7.1.84.gd92f8
