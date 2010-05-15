From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 4/6] git-cvsserver: Improved error handling for pserver
Date: Sat, 15 May 2010 02:46:02 +0000
Message-ID: <1273891564-7523-5-git-send-email-avarab@gmail.com>
References: <7v3an9tc5w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 15 04:47:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OD7PC-0008Qv-1j
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 04:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756510Ab0EOCqx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 May 2010 22:46:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:48640 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab0EOCqp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 22:46:45 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1937174fga.1
        for <git@vger.kernel.org>; Fri, 14 May 2010 19:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=CRapzwxCR7r73UWmKcY2Ha64RJ7zJPqKViDvaqWskN0=;
        b=coQu0D9xM5djMO9FSb8NZ8JTqRS5J6Bj0s2s/jTZLcI/e25qjmkoxjECbHeHKwmu9e
         u4C/ni8k7I7mvYNzivcTY/tSBk7W9G91thpI2ViMRVGgNOApKaWTg0VXuMqAyMQ6TGOo
         iYjnyhLgHyhsqOFXp7PbWjOeJ9ic8RqHUV5NY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=YrCD3uJ9Jwpinw7GUG9L3Tcx1Qg39z2L/vdKGtTZR4u5p44EnTShoL/c5Ur86xqGDu
         0KhLSNaANwC58BuyeAlQRYgmZnY3s0H1vjSBHP9FLBysvkpYtM/XAjnYg+dTkX3zx81Q
         OkM5lZ2qSe293p18urn9T1wOkYx+8Wubft5FA=
Received: by 10.87.38.3 with SMTP id q3mr3918313fgj.26.1273891604307;
        Fri, 14 May 2010 19:46:44 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id 22sm4155718fkq.17.2010.05.14.19.46.43
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 19:46:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.84.gd92f8
In-Reply-To: <7v3an9tc5w.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147133>

  - Produce an error if the user tries to supply a password for anonymo=
us

  - Clarify the error message produced when there's no [gitcvs.authdb]

  - Produce an E error if the authdb doesn't exist instead of spewing
    $! to the user

  - do crypt($user, descramble($pass)) eq $hash; crypt($user, $hash)
    eq $hash would accept any password

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-cvsserver.perl |   29 ++++++++++++++++++++++++-----
 1 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 9f63c56..813df76 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -187,19 +187,37 @@ if ($state->{method} eq 'pserver') {
     $line =3D <STDIN>; chomp $line;
     my $password =3D $line;
=20
-    unless ($user eq 'anonymous') {
+    if ($user eq 'anonymous') {
+        # "A" will be 1 byte, use length instead in case the
+        # encryption method ever changes (yeah, right!)
+        if (length($password) > 1 ) {
+            print "E Don't supply a password for the `anonymous' user\=
n";
+            print "I HATE YOU\n";
+            exit 1;
+        }
+
+        # Fall through to LOVE
+    } else {
         # Trying to authenticate a user
         if (not exists $cfg->{gitcvs}->{authdb}) {
-            print "E the repo config file needs a [gitcvs.authdb] sect=
ion with a filename\n";
+            print "E the repo config file needs a [gitcvs] section wit=
h an 'authdb' parameter set to the filename of the authentication datab=
ase\n";
+            print "I HATE YOU\n";
+            exit 1;
+        }
+
+        my $authdb =3D $cfg->{gitcvs}->{authdb};
+
+        unless (-e $authdb) {
+            print "E The authentication database specified in [gitcvs.=
authdb] does not exist\n";
             print "I HATE YOU\n";
             exit 1;
         }
=20
         my $auth_ok;
-        open my $passwd, "<", $cfg->{gitcvs}->{authdb} or die $!;
+        open my $passwd, "<", $authdb or die $!;
         while (<$passwd>) {
             if (m{^\Q$user\E:(.*)}) {
-                if (crypt($user, $1) eq $1) {
+                if (crypt($user, descramble($password)) eq $1) {
                     $auth_ok =3D 1;
                 }
             };
@@ -210,7 +228,8 @@ if ($state->{method} eq 'pserver') {
             print "I HATE YOU\n";
             exit 1;
         }
-        # else fall through to LOVE
+
+        # Fall through to LOVE
     }
=20
     # For checking whether the user is anonymous on commit
--=20
1.7.1.84.gd92f8
