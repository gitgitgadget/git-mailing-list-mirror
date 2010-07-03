From: =?ISO-8859-1?B?wXNoaW4gTOFzemzz?= <ashinlaszlo@gmail.com>
Subject: [PATCH 1/4] git-cvsserver: implement script based pserver 
	authentication
Date: Sat, 3 Jul 2010 23:21:44 +0200
Message-ID: <AANLkTikbPyZ-q8XgTBX1P9HQlFwUhiJSpiOgYG75mtiq@mail.gmail.com>
References: <1058578005711783867@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 03 23:22:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVAA9-0007Vi-4j
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 23:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305Ab0GCVWH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Jul 2010 17:22:07 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53996 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab0GCVWF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jul 2010 17:22:05 -0400
Received: by fxm14 with SMTP id 14so2996914fxm.19
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 14:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=/zD+8XK1Zeyn45JsRCfj80NMH4eXqxq68Nch4GWUR/Q=;
        b=NTiddY3EQ4BJWq55Qlo21/S/LJZFaJonLOFg8DAihHq7N/dXGmxK6RzYWszyTkIUa1
         wWyZ67gatlD19qMX6vrOaNgsE8rT9sBQlVNU7/ZPtMnhijnWUEVr9cfQ0xf3rDwlxB5a
         CntMnYxADv5Opgvfr+Ug4hVk47qrXRTpu7PYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=USML30xWUl/CK+LWQKhlLigSw+Iw32w5kw7rD4jscXekCmxCvNOBUNVPP/OvGS0UNN
         Dmm55gpahPyf5Db7L0yWa1sdU8h2r0CL9OwWwU5WnXH+qn/9ax7gH2ijpN3XU6DGFw1i
         0hR5SdukZyrwZ76BufjIghIq+L/7oY0KJSX9w=
Received: by 10.103.218.4 with SMTP id v4mr61645muq.95.1278192124155; Sat, 03 
	Jul 2010 14:22:04 -0700 (PDT)
Received: by 10.103.225.9 with HTTP; Sat, 3 Jul 2010 14:21:44 -0700 (PDT)
In-Reply-To: <1058578005711783867@unknownmsgid>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150203>

=A0Documentation/git-cvsserver.txt | =A0 46 +++++++++++++++++++++++++++=
++++++++---
=A0git-cvsserver.perl =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 28 +++++++++++++=
++++++++++
=A0t/t9400-git-cvsserver-server.sh | =A0 45 +++++++++++++++++++++++++++=
+++++++++++
=A03 files changed, 115 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsser=
ver.txt
index 7004dd2..b3c3122 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -100,10 +100,48 @@ looks like
=A0------

=A0Only anonymous access is provided by pserve by default. To commit yo=
u
-will have to create pserver accounts, simply add a gitcvs.authdb
-setting in the config file of the repositories you want the cvsserver
-to allow writes to, for example:
+will have to specify an authentication option in the config file.
+Currently there are two options are available for authentication throu=
gh
+pserver in git-cvsserver: one through an authenticator script and an o=
ther
+through a textual authentication database. If both are specified in th=
e config
+file then the script based solution will be used.
+
+ =A0a. To use the authentication script based method, simply add a
+ =A0 =A0 gitcvs.authscript setting in the config file of the repositor=
ies you want
+ =A0 =A0 the cvsserver to allow writes to, for example:
++
+--
+------
+
+ =A0 [gitcvs]
+ =A0 =A0authscript =3D /usr/local/bin/cvsserver-auth.sh
+
+------
+The file specified here must be executable by the user the git-cvsserv=
er runs
+under the name of. This script has to read exactly two lines from its =
standard
+input as long as git-cvsserver passes the username and the password on=
 separate
+lines. After the script did its task by checking the username and pass=
word
+given it has to return zero if the authentication was successful and r=
eturn
+other value if it was not.
+
+Here is an example for an authentication script which checks the users=
 against
+active directory:
+------
+#!/bin/sh
+# /usr/local/bin/cvsserver-auth.sh

+read username
+read password
+
+wbinfo -a "${username}%${password}"
+------
+--
+
+ =A0b. To use the authentication database based method, simply add a
+ =A0 =A0 gitcvs.authdb setting in the config file of the repositories =
you want the
+ =A0 =A0 cvsserver to allow writes to, for example:
++
+--
=A0------

=A0 =A0[gitcvs]
@@ -125,7 +163,7 @@ Alternatively you can produce the password with
perl's crypt() operator:
=A0-----
=A0 =A0perl -e 'my ($user, $pass) =3D @ARGV; printf "%s:%s\n", $user,
crypt($user, $pass)' $USER password
=A0-----
-
+--
=A0Then provide your password via the pserver method, for example:
=A0------
=A0 =A0cvs -d:pserver:someuser:somepassword <at> server/path/repo.git c=
o <HEAD_name>
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index e9f3037..9664e86 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -197,6 +197,34 @@ if ($state->{method} eq 'pserver') {
=A0 =A0 =A0 =A0 }

=A0 =A0 =A0 =A0 # Fall through to LOVE
+ =A0 =A0} elsif (exists $cfg->{gitcvs}->{authscript}) {
+ =A0 =A0 =A0 =A0my $authscript =3D $cfg->{gitcvs}->{authscript};
+
+ =A0 =A0 =A0 =A0unless (-x $authscript) {
+ =A0 =A0 =A0 =A0 =A0 =A0print "E The authentication script specified i=
n ";
+ =A0 =A0 =A0 =A0 =A0 =A0print "[gitcvs.authscript] cannot be executed\=
n";
+ =A0 =A0 =A0 =A0 =A0 =A0print "I HATE YOU\n";
+ =A0 =A0 =A0 =A0 =A0 =A0exit 1;
+ =A0 =A0 =A0 =A0}
+
+ =A0 =A0 =A0 =A0open my $script_fd, '|-', "'$authscript'"
+ =A0 =A0 =A0 =A0 =A0 =A0or die "Couldn't open authentication script '$=
authscript': $!";
+
+ =A0 =A0 =A0 =A0if (length($password) > 0) {
+ =A0 =A0 =A0 =A0 =A0 =A0$password =3D descramble($password);
+ =A0 =A0 =A0 =A0}
+
+ =A0 =A0 =A0 =A0print $script_fd "$user\n";
+ =A0 =A0 =A0 =A0print $script_fd "$password\n";
+ =A0 =A0 =A0 =A0close $script_fd;
+
+ =A0 =A0 =A0 =A0unless ($? =3D=3D 0) {
+ =A0 =A0 =A0 =A0 =A0 =A0print "E External script authentication failed=
=2E\n";
+ =A0 =A0 =A0 =A0 =A0 =A0print "I HATE YOU\n";
+ =A0 =A0 =A0 =A0 =A0 =A0exit 1;
+ =A0 =A0 =A0 =A0}
+
+ =A0 =A0 =A0 =A0# Fall through to LOVE
=A0 =A0 } else {
=A0 =A0 =A0 =A0 # Trying to authenticate a user
=A0 =A0 =A0 =A0 if (not exists $cfg->{gitcvs}->{authdb}) {
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-se=
rver.sh
index 8639506..0743e9a 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -64,6 +64,16 @@ test_expect_success 'basic checkout' \
=A0# PSERVER AUTHENTICATION
=A0#------------------------

+cat >"$SERVERDIR/authscript.sh" <<EOF
+#!/bin/sh
+read username
+read password
+
+test "x\$username" =3D xcvsuser -a "x\$password" =3D xcvspassword
+EOF
+
+chmod a+x "$SERVERDIR/authscript.sh"
+
=A0cat >request-anonymous =A0<<EOF
=A0BEGIN AUTH REQUEST
=A0$SERVERDIR
@@ -134,6 +144,41 @@ test_expect_success 'pserver authentication
failure (login/non-anonymous user)'
=A0 =A0fi &&
=A0 =A0sed -ne \$p log | grep "^I HATE YOU\$"'

+GIT_DIR=3D"$SERVERDIR" git config --unset gitcvs.authdb || exit 1
+GIT_DIR=3D"$SERVERDIR" git config gitcvs.authscript
"$SERVERDIR/authscript.sh" || exit 1
+
+test_expect_success 'pserver authentication (authscript)' \
+ =A0'cat request-anonymous | git-cvsserver pserver >log 2>&1 &&
+ =A0 sed -ne \$p log | grep "^I LOVE YOU\$"'
+
+test_expect_success 'pserver authentication failure (authscript,
non-anonymous user)' \
+ =A0'if cat request-git | git-cvsserver pserver >log 2>&1
+ =A0 then
+ =A0 =A0 =A0 false
+ =A0 else
+ =A0 =A0 =A0 true
+ =A0 fi &&
+ =A0 sed -ne \$p log | grep "^I HATE YOU\$"'
+
+test_expect_success 'pserver authentication success (authscript,
non-anonymous user with password)' \
+ =A0'cat login-git-ok | git-cvsserver pserver >log 2>&1 &&
+ =A0 sed -ne \$p log | grep "^I LOVE YOU\$"'
+
+test_expect_success 'pserver authentication (authscript, login)' \
+ =A0'cat login-anonymous | git-cvsserver pserver >log 2>&1 &&
+ =A0 sed -ne \$p log | grep "^I LOVE YOU\$"'
+
+test_expect_success 'pserver authentication failure (authscript,
login/non-anonymous user)' \
+ =A0'if cat login-git | git-cvsserver pserver >log 2>&1
+ =A0 then
+ =A0 =A0 =A0 false
+ =A0 else
+ =A0 =A0 =A0 true
+ =A0 fi &&
+ =A0 sed -ne \$p log | grep "^I HATE YOU\$"'
+
+GIT_DIR=3D"$SERVERDIR" git config --unset gitcvs.authscript || exit 1
+GIT_DIR=3D"$SERVERDIR" git config gitcvs.authdb "$SERVERDIR/auth.db" |=
| exit 1

=A0# misuse pserver authentication for testing of req_Root

--
1.7.2.rc1.dirty
