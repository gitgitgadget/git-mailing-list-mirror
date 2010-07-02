From: =?UTF-8?B?TMOhc3psw7Mgw4FTSElO?= <laszlo.ashin@neti.hu>
Subject: [PATCH] git-cvsserver: pserver-auth-script
Date: Fri, 2 Jul 2010 09:54:06 +0200
Organization: NETI Kft.
Message-ID: <20100702095406.7af15d20@ashinlaszlo.pta.neti.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 02 10:19:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUbSu-0008DG-21
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 10:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755701Ab0GBITI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 04:19:08 -0400
Received: from main.neti.hu ([195.228.2.1]:26007 "EHLO main.neti.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752202Ab0GBITG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jul 2010 04:19:06 -0400
X-Greylist: delayed 1446 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Jul 2010 04:19:06 EDT
Received: from ashinlaszlo.pta.neti.hu ([132.132.132.151])
          by lotus.neti.hu (Lotus Domino Release 7.0.1)
          with ESMTP id 2010070209544703-2697 ;
          Fri, 2 Jul 2010 09:54:47 +0200 
X-MIMETrack: Itemize by SMTP Server on lotus/NETI/HU(Release 7.0.1|January 17, 2006) at
 2010.07.02 09:54:47,
	Serialize by Router on lotus/NETI/HU(Release 7.0.1|January 17, 2006) at
 2010.07.02 09:54:48,
	Serialize complete at 2010.07.02 09:54:48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150115>

Hi,

The following patch makes git-cvsserver capable of authenticating users=
 through an external executable script using pserver method.
The script can be specified in the gitcvs section of the config file:
[gitcvs]
	enabled =3D 1
	authscript =3D /some/where/script.sh

The script, itself will get username and password on its standard input=
, so it can look like something like this:

#!/bin/sh
read username
read password

wbinfo -a "$username%$password"

--
Only a return value of zero means a successful authentication.

Please comment and keep me on cc.

--=20
Regards,
L=C3=A1szl=C3=B3 =C3=81shin

diff -ruN a/git-cvsserver b/git-cvsserver
--- a/git-cvsserver	2010-07-01 15:31:18.000000000 +0200
+++ b/git-cvsserver	2010-07-01 15:35:41.000000000 +0200
@@ -200,35 +200,54 @@
         # Fall through to LOVE
     } else {
         # Trying to authenticate a user
-        if (not exists $cfg->{gitcvs}->{authdb}) {
-            print "E the repo config file needs a [gitcvs] section wit=
h an 'authdb' parameter set to the filename of the authentication datab=
ase\n";
-            print "I HATE YOU\n";
-            exit 1;
-        }
-
-        my $authdb =3D $cfg->{gitcvs}->{authdb};
-
-        unless (-e $authdb) {
-            print "E The authentication database specified in [gitcvs.=
authdb] does not exist\n";
-            print "I HATE YOU\n";
-            exit 1;
-        }
-
-        my $auth_ok;
-        open my $passwd, "<", $authdb or die $!;
-        while (<$passwd>) {
-            if (m{^\Q$user\E:(.*)}) {
-                if (crypt($user, descramble($password)) eq $1) {
-                    $auth_ok =3D 1;
-                }
-            };
-        }
-        close $passwd;
+        if (exists $cfg->{gitcvs}->{authscript}) {
+            my $authscript =3D $cfg->{gitcvs}->{authscript};
+            unless (-x $authscript) {
+                print "E The authentication script specified in [gitcv=
s.authscript] cannot be executed\n";
+                print "I HATE YOU\n";
+                exit 1;
+            }
+
+            open SCRIPTIN, '|' . $authscript or die $!;
+            print SCRIPTIN $user . "\n";
+            print SCRIPTIN descramble($password) . "\n";
+            close SCRIPTIN;
+            if ($? !=3D 0) {
+                print "E External script authentication failed.\n";
+                print "I HATE YOU\n";
+                exit 1;
+            }
+        } else {
+            if (not exists $cfg->{gitcvs}->{authdb}) {
+                print "E the repo config file needs a [gitcvs] section=
 with an 'authdb' parameter set to the filename of the authentication d=
atabase\n";
+                print "I HATE YOU\n";
+                exit 1;
+            }
+
+            my $authdb =3D $cfg->{gitcvs}->{authdb};
+
+            unless (-e $authdb) {
+                print "E The authentication database specified in [git=
cvs.authdb] does not exist\n";
+                print "I HATE YOU\n";
+                exit 1;
+            }
+
+            my $auth_ok;
+            open my $passwd, "<", $authdb or die $!;
+            while (<$passwd>) {
+                if (m{^\Q$user\E:(.*)}) {
+                    if (crypt($user, descramble($password)) eq $1) {
+                        $auth_ok =3D 1;
+                    }
+                };
+            }
+            close $passwd;
=20
-        unless ($auth_ok) {
-            print "I HATE YOU\n";
-            exit 1;
-        }
+            unless ($auth_ok) {
+                print "I HATE YOU\n";
+                exit 1;
+            }
+	}
=20
         # Fall through to LOVE
     }
