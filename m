From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/6 v2] git-cvsserver: use a password file cvsserver pserver
Date: Sat, 15 May 2010 15:07:54 +0000
Message-ID: <1273936074-22401-1-git-send-email-avarab@gmail.com>
References: <1273891564-7523-3-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 15 17:08:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODIyI-0002eS-RZ
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 17:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559Ab0EOPIG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 May 2010 11:08:06 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:14649 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334Ab0EOPID (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 11:08:03 -0400
Received: by fg-out-1718.google.com with SMTP id d23so2084496fga.1
        for <git@vger.kernel.org>; Sat, 15 May 2010 08:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=u/ovO1Vg/1zb+gHTN61WfGbefOAmS+WIUus4frgHBqM=;
        b=ACxXuvKS7i6SV3x1qiF8dtsLLCA+BSB/kYNl81oDiETkfarHkxmb2rpdxvTo4YIs1W
         yNl6XawRg+GLGiq7z/l9qbs1thxjTq20YIzVG5XaQYGMI4aztjRMQOfyrMQZXxdFBHV3
         +Egj57yTEBH9zksQ8S5OyDcwPE+mEHdFpuGLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=WVxzGj3QAiZdmnjMAt6OmCXZ2i4dB9jHpfZxgn4VfARwfTzyqd/ibeEwuJKni9ny4E
         bloaaHORaPceNBciQwwCqv7+riFdBQHgQnT66ocNAtrx2Svwj1gtADAt+1dCNdhkZNHE
         SRAQuy6g12tF1+bEDO2ira/qoDoGycb+56GgU=
Received: by 10.87.38.3 with SMTP id q3mr4916504fgj.26.1273936081552;
        Sat, 15 May 2010 08:08:01 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id p9sm4908718fkb.33.2010.05.15.08.08.00
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 08:08:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.84.gd92f8
In-Reply-To: <1273891564-7523-3-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147155>

=46rom: Sam Vilain <sam.vilain@catalyst.net.nz>

If a git repository is shared via HTTP, the config file is typically
visible.  Use an external file instead.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
This patch was missing a removal of the gitcvs.users config key
introduced in the last patch.

 Documentation/git-cvsserver.txt |   21 ++++++++++++++++-----
 git-cvsserver.perl              |   29 +++++++++++++++--------------
 2 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsser=
ver.txt
index f4e1339..bc2da8c 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -100,16 +100,27 @@ looks like
 ------
=20
 Only anonymous access is provided by pserve by default. To commit you
-will have to create pserver accounts, simply add a [gitcvs.users]
-section to the repositories you want to access, for example:
+will have to create pserver accounts, simply add a gitcvs.authdb
+setting in the config file of the repositories you want the cvsserver
+to allow writes to, for example:
=20
 ------
   =20
-   [gitcvs.users]
-        someuser =3D somepassword
-        otheruser =3D otherpassword
+   [gitcvs]
+        authdb =3D /etc/cvsserver/passwd
   =20
 ------
+The format of these files is username followed by the crypted password=
,
+for example:
+
+------
+   myuser:$1Oyx5r9mdGZ2
+   myuser:$1$BA)@$vbnMJMDym7tA32AamXrm./
+------
+You can use the 'htpasswd' facility that comes with Apache to make the=
se
+files, but Apache's MD5 crypt method differs from the one used by most=
 C
+library's crypt() function, so don't use the -m option.
+
 Then provide your password via the pserver method, for example:
 ------
    cvs -d:pserver:someuser:somepassword <at> server/path/repo.git co <=
HEAD_name>
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 7097419..8b97fb8 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -189,24 +189,25 @@ if ($state->{method} eq 'pserver') {
=20
     unless ($user eq 'anonymous') {
         # Trying to authenticate a user
-        if (not exists $cfg->{gitcvs}->{users}) {
-            print "E the repo config file needs a [gitcvs.users] secti=
on with user/password key-value pairs\n";
+        if (not exists $cfg->{gitcvs}->{authdb}) {
+            print "E the repo config file needs a [gitcvs.authdb] sect=
ion with a filename\n";
             print "I HATE YOU\n";
             exit 1;
-        } elsif (exists $cfg->{gitcvs}->{users} and not exists $cfg->{=
gitcvs}->{users}->{$user}) {
-            #print "E the repo config file has a [gitcvs.users] sectio=
n but the user $user is not defined in it\n";
+        }
+	my $auth_ok;
+	open PASSWD, "<$cfg->{gitcvs}->{authdb}" or die $!;
+	while(<PASSWD>) {
+	    if (m{^\Q$user\E:(.*)}) {
+		if (crypt($user, $1) eq $1) {
+		    $auth_ok =3D 1;
+		}
+	    };
+	}
+	unless ($auth_ok) {
             print "I HATE YOU\n";
             exit 1;
-        } else {
-            my $descrambled_password =3D descramble($password);
-            my $cleartext_password =3D $cfg->{gitcvs}->{users}->{$user=
};
-            if ($descrambled_password ne $cleartext_password) {
-                #print "E The password supplied for user $user was inc=
orrect\n";
-                print "I HATE YOU\n";
-                exit 1;
-            }
-            # else fall through to LOVE
         }
+        # else fall through to LOVE
     }
=20
     # For checking whether the user is anonymous on commit
@@ -337,7 +338,7 @@ sub req_Root
     }
     foreach my $line ( @gitvars )
     {
-        next unless ( $line =3D~ /^(gitcvs)\.(?:(ext|pserver|users)\.)=
?([\w-]+)=3D(.*)$/ );
+        next unless ( $line =3D~ /^(gitcvs)\.(?:(ext|pserver)\.)?([\w-=
]+)=3D(.*)$/ );
         unless ($2) {
             $cfg->{$1}{$3} =3D $4;
         } else {
--=20
1.7.1.84.gd92f8
