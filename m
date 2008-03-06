From: Sam Vilain <sam@vilain.net>
Subject: Re: Switching to Git
Date: Fri, 07 Mar 2008 11:08:23 +1300
Message-ID: <47D06B57.4090607@vilain.net>
References: <b77c1dce0803060447m12cf2ed9v2dbe17ed59e6073@mail.gmail.com>	 <47D01A57.60701@havurah-software.org>	 <51dd1af80803060858t5cb3d54ek3ee420ea313625ec@mail.gmail.com>	 <47D05229.2070900@vilain.net> <51dd1af80803061300y1a2abcf2n9b9d3184e4ed42b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Peacock <john.peacock@havurah-software.org>,
	Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	Perl 5 Porters <perl5-porters@perl.org>,
	Martin.Langhoff@gmail.com, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 23:53:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXOy6-0005sx-T0
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 23:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634AbYCFWxE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2008 17:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752909AbYCFWxD
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 17:53:03 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:40833 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755596AbYCFWxB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 17:53:01 -0500
X-Greylist: delayed 1698 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Mar 2008 17:53:00 EST
Received: by mail.utsl.gen.nz (Postfix, from userid 1003)
	id 2302F21D0E3; Fri,  7 Mar 2008 11:24:40 +1300 (NZDT)
FCC: imap://sam@localhost/INBOX/Sent
X-Identity-Key: id4
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; uuencode=0
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <51dd1af80803061300y1a2abcf2n9b9d3184e4ed42b2@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76428>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Yes see [1] it works but the list members wanted some tool to manage
> passwords too which I didn't pursue since it worked for me in its
> present form.
>=20
> 1. http://lists-archives.org/git/640574-authentication-support-for-ps=
erver.html

Cool, well done.  Having re-read that thread, I think Martin Langhoff's
response
http://lists-archives.org/git/641074-authentication-support-for-pserver=
=2Ehtml
is the most pertinent.  I didn't see any requests for an actual tool to
be written, just that the password file be separate to the git config
file, and/or use crypt() to store its contents.  Perhaps point them at
"htpasswd" if they want a tool :)

This patch is untested and sits on top of the previous patch by =C3=86v=
ar.
Pullable from git://git.catalyst.net.nz/git.git#cvsserver-auth

Subject: [PATCH] git-cvsserver: use a password file cvsserver pserver

If a git repository is shared via HTTP, the config file is typically
visible.  Use an external file instead.
---
 Documentation/git-cvsserver.txt |   21 ++++++++++++++++-----
 git-cvsserver.perl              |   27 ++++++++++++++-------------
 2 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsser=
ver.txt
index 98183d4..c642f12 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -97,16 +97,27 @@ looks like
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
index 9bc2ff5..e54cbcd 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -156,24 +156,25 @@ if ($state->{method} eq 'pserver') {
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
--=20
1.5.3.5

