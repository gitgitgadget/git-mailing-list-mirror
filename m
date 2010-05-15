From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 1/6 v2] git-cvsserver: authentication support for pserver
Date: Sat, 15 May 2010 15:06:46 +0000
Message-ID: <1273936006-22357-1-git-send-email-avarab@gmail.com>
References: <1273891564-7523-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 15 17:07:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODIxZ-0002Lj-Fv
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 17:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185Ab0EOPHH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 May 2010 11:07:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:14332 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752Ab0EOPHE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 11:07:04 -0400
Received: by fg-out-1718.google.com with SMTP id d23so2084264fga.1
        for <git@vger.kernel.org>; Sat, 15 May 2010 08:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=hr8jWZw1lmAXxukbcbfv7wKx9GUuvEN7Z51sby/tVlg=;
        b=naaq8ggftUtrEFHEXCcAIZnj9F1oi/0fr9x4BxfawoOXxv0hY9W2B10w/RS/QTwOaD
         HMrmNguEvB4IBeL6K9/zFy7Y7BlZHa6mm/xnfh4aVco7nVjflw/FJZ0yVHSDOcux3gvj
         Y87YpkQ2WGDBkKg4ollPTvx7NpT7tbvsCJ3Dg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=FIP+EVLV+KNlPCGra2e7dC6VGtDIcYwc8ulHGLVMR3oaPHk3I6xKbDsO86sHLhiHw1
         Xq/Lm32FVWgleR5zAyLR/LGCw9m243F+hd+eJKXpXjcjbzllZAyaS0lVs8b41KRdwE+6
         57mkAaGl8NePS45h2wAQSMd3+cNHRcyfa+lzQ=
Received: by 10.87.47.23 with SMTP id z23mr4923300fgj.28.1273936022449;
        Sat, 15 May 2010 08:07:02 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id 2sm4937891fks.12.2010.05.15.08.07.01
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 08:07:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.84.gd92f8
In-Reply-To: <1273891564-7523-2-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147154>

Allow git-cvsserver to use authentication over pserver mode.  The
pserver user/password database is stored in the config file for each
repository.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Worriedly-Acked-by: Martin Langhoff <martin.langhoff@gmail.com>
---
The descramble() method was potentially broken if anyone had fed it a
non-bytestring. Now it uses unpack() instead of regexes.

 Documentation/git-cvsserver.txt |   21 +++++++++--
 git-cvsserver.perl              |   73 +++++++++++++++++++++++++++++++=
+++----
 2 files changed, 82 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsser=
ver.txt
index dbb053e..f4e1339 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -72,9 +72,6 @@ plugin. Most functionality works fine with both of th=
ese clients.
 LIMITATIONS
 -----------
=20
-Currently cvsserver works over SSH connections for read/write clients,=
 and
-over pserver for anonymous CVS access.
-
 CVS clients cannot tag, branch or perform GIT merges.
=20
 'git-cvsserver' maps GIT branches to CVS modules. This is very differe=
nt
@@ -84,7 +81,7 @@ one or more directories.
 INSTALLATION
 ------------
=20
-1. If you are going to offer anonymous CVS access via pserver, add a l=
ine in
+1. If you are going to offer CVS access via pserver, add a line in
    /etc/inetd.conf like
 +
 --
@@ -101,6 +98,22 @@ looks like
    cvspserver stream tcp nowait nobody /usr/bin/git-cvsserver git-cvss=
erver pserver
=20
 ------
+
+Only anonymous access is provided by pserve by default. To commit you
+will have to create pserver accounts, simply add a [gitcvs.users]
+section to the repositories you want to access, for example:
+
+------
+  =20
+   [gitcvs.users]
+        someuser =3D somepassword
+        otheruser =3D otherpassword
+  =20
+------
+Then provide your password via the pserver method, for example:
+------
+   cvs -d:pserver:someuser:somepassword <at> server/path/repo.git co <=
HEAD_name>
+------
 No special setup is needed for SSH access, other than having GIT tools
 in the PATH. If you have clients that do not accept the CVS_SERVER
 environment variable, you can rename 'git-cvsserver' to `cvs`.
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 13751db..7097419 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -183,12 +183,35 @@ if ($state->{method} eq 'pserver') {
        exit 1;
     }
     $line =3D <STDIN>; chomp $line;
-    unless ($line eq 'anonymous') {
-       print "E Only anonymous user allowed via pserver\n";
-       print "I HATE YOU\n";
-       exit 1;
+    my $user =3D $line;
+    $line =3D <STDIN>; chomp $line;
+    my $password =3D $line;
+
+    unless ($user eq 'anonymous') {
+        # Trying to authenticate a user
+        if (not exists $cfg->{gitcvs}->{users}) {
+            print "E the repo config file needs a [gitcvs.users] secti=
on with user/password key-value pairs\n";
+            print "I HATE YOU\n";
+            exit 1;
+        } elsif (exists $cfg->{gitcvs}->{users} and not exists $cfg->{=
gitcvs}->{users}->{$user}) {
+            #print "E the repo config file has a [gitcvs.users] sectio=
n but the user $user is not defined in it\n";
+            print "I HATE YOU\n";
+            exit 1;
+        } else {
+            my $descrambled_password =3D descramble($password);
+            my $cleartext_password =3D $cfg->{gitcvs}->{users}->{$user=
};
+            if ($descrambled_password ne $cleartext_password) {
+                #print "E The password supplied for user $user was inc=
orrect\n";
+                print "I HATE YOU\n";
+                exit 1;
+            }
+            # else fall through to LOVE
+        }
     }
-    $line =3D <STDIN>; chomp $line;    # validate the password?
+
+    # For checking whether the user is anonymous on commit
+    $state->{user} =3D $user;
+
     $line =3D <STDIN>; chomp $line;
     unless ($line eq "END $request REQUEST") {
        die "E Do not understand $line -- expecting END $request REQUES=
T\n";
@@ -314,7 +337,7 @@ sub req_Root
     }
     foreach my $line ( @gitvars )
     {
-        next unless ( $line =3D~ /^(gitcvs)\.(?:(ext|pserver)\.)?([\w-=
]+)=3D(.*)$/ );
+        next unless ( $line =3D~ /^(gitcvs)\.(?:(ext|pserver|users)\.)=
?([\w-]+)=3D(.*)$/ );
         unless ($2) {
             $cfg->{$1}{$3} =3D $4;
         } else {
@@ -1271,9 +1294,9 @@ sub req_ci
=20
     $log->info("req_ci : " . ( defined($data) ? $data : "[NULL]" ));
=20
-    if ( $state->{method} eq 'pserver')
+    if ( $state->{method} eq 'pserver' and $state->{user} eq 'anonymou=
s' )
     {
-        print "error 1 pserver access cannot commit\n";
+        print "error 1 anonymous user cannot commit via pserver\n";
         cleanupWorkTree();
         exit;
     }
@@ -2586,6 +2609,40 @@ sub cvs_author
     $author;
 }
=20
+
+sub descramble
+{
+    # This table is from src/scramble.c in the CVS source
+    my @SHIFTS =3D (
+        0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
+        16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31=
,
+        114,120, 53, 79, 96,109, 72,108, 70, 64, 76, 67,116, 74, 68, 8=
7,
+        111, 52, 75,119, 49, 34, 82, 81, 95, 65,112, 86,118,110,122,10=
5,
+        41, 57, 83, 43, 46,102, 40, 89, 38,103, 45, 50, 42,123, 91, 35=
,
+        125, 55, 54, 66,124,126, 59, 47, 92, 71,115, 78, 88,107,106, 5=
6,
+        36,121,117,104,101,100, 69, 73, 99, 63, 94, 93, 39, 37, 61, 48=
,
+        58,113, 32, 90, 44, 98, 60, 51, 33, 97, 62, 77, 84, 80, 85,223=
,
+        225,216,187,166,229,189,222,188,141,249,148,200,184,136,248,19=
0,
+        199,170,181,204,138,232,218,183,255,234,220,247,213,203,226,19=
3,
+        174,172,228,252,217,201,131,230,197,211,145,238,161,179,160,21=
2,
+        207,221,254,173,202,146,224,151,140,196,205,130,135,133,143,24=
6,
+        192,159,244,239,185,168,215,144,139,165,180,157,147,186,214,17=
6,
+        227,231,219,169,175,156,206,198,129,164,150,210,154,177,134,12=
7,
+        182,128,158,208,162,132,167,209,149,241,153,251,237,236,171,19=
5,
+        243,233,253,240,194,250,191,155,142,137,245,235,163,242,178,15=
2
+    );
+    my ($str) =3D @_;
+
+    # This should never happen, the same password format (A) bas been
+    # used by CVS since the beginning of time
+    die "invalid password format $1" unless substr($str, 0, 1) eq 'A';
+
+    my @str =3D unpack "C*", substr($str, 1);
+    my $ret =3D join '', map { chr $SHIFTS[$_] } @str;
+    return $ret;
+}
+
+
 package GITCVS::log;
=20
 ####
--=20
1.7.1.84.gd92f8
