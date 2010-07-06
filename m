From: =?ISO-8859-1?B?wXNoaW4gTOFzemzz?= <ashinlaszlo@gmail.com>
Subject: [PATCH 1/5] git-cvsserver: implement script based pserver auth
Date: Tue, 6 Jul 2010 19:34:43 +0200
Message-ID: <AANLkTilguZZVVstmJvEDudhRP5Ko6m-ajtn9d7nIl3UR@mail.gmail.com>
References: <449772932078145114@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?B?TOFzemzzIMFTSElO?= <laszlo.ashin@neti.hu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 06 19:35:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWC3B-0002DO-8Y
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 19:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532Ab0GFRfJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 13:35:09 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46897 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab0GFRfI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jul 2010 13:35:08 -0400
Received: by bwz1 with SMTP id 1so3684757bwz.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 10:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=XOsj6o2FUyOpQ8vuur/2mK4OKeF/PKcR29ETuDfGpbc=;
        b=J0dBVOHZutx25i/2EWKgQp9h4k5JtDSH1Tgoltxm6AzcAF54vFKKnpWHZiFguSwz4O
         +ucqiFeLMtINSskSxxsi/BNqF+HXO1ESUZwUHe01uWBR001lSCG/kX7XUAlV0Wy2z1M3
         8XNL6oX7xRY0yHPhRo4RFS6h2kZg1+5SaVqZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=j4n3xXmu/uihXQ4COoDborIWgbkrGkPqJXk4o2PIgQOUPK7B3tUwD3Y5OnZ90i1RHI
         FV6Fa0k8XCQKOpKvVQx30Kob3XHiL86GjH8pV5kaQf1v/VmgCnHGnZB+Kmh+UpEDsJSm
         e1kkSSSUdUjZX/eiehcyBNsCImzm9+sDplPtg=
Received: by 10.204.162.204 with SMTP id w12mr4049986bkx.135.1278437704474; 
	Tue, 06 Jul 2010 10:35:04 -0700 (PDT)
Received: by 10.204.79.19 with HTTP; Tue, 6 Jul 2010 10:34:43 -0700 (PDT)
In-Reply-To: <449772932078145114@unknownmsgid>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150374>

---
=A0Documentation/git-cvsserver.txt | =A0 42 +++++++++++++++++++++++++++=
---
=A0git-cvsserver.perl =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 34 +++++++++++++=
+++++++++++
=A0t/t9400-git-cvsserver-server.sh | =A0 55 +++++++++++++++++++++++++++=
++++++++++++
=A03 files changed, 127 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsser=
ver.txt
index 7004dd2..59c8e5d 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -100,10 +100,44 @@ looks like
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
+through a textual authentication database.
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
+under. The script will receive two lines on standard input, the first =
is the
+username and the second is the password. It should return 0 if the use=
r was
+successfully authenticated, and a non-zero value if not.
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
@@ -125,7 +159,7 @@ Alternatively you can produce the password with
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
index e9f3037..c89d999 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -197,6 +197,40 @@ if ($state->{method} eq 'pserver') {
=A0 =A0 =A0 =A0 }

=A0 =A0 =A0 =A0 # Fall through to LOVE
+ =A0 =A0} elsif (exists $cfg->{gitcvs}->{authscript} and
+ =A0 =A0 =A0 =A0 =A0 =A0 exists $cfg->{gitcvs}->{authdb}) {
+ =A0 =A0 =A0 =A0print "E Ambiguous configuration of authentication met=
hods. " .
+ =A0 =A0 =A0 =A0 =A0 =A0"Only one authentication method can be enabled=
 at once\n";
+ =A0 =A0 =A0 =A0print "I HATE YOU\n";
+ =A0 =A0 =A0 =A0exit 1;
+ =A0 =A0} elsif (exists $cfg->{gitcvs}->{authscript}) {
+ =A0 =A0 =A0 =A0my $authscript =3D $cfg->{gitcvs}->{authscript};
+
+ =A0 =A0 =A0 =A0unless (-x $authscript) {
+ =A0 =A0 =A0 =A0 =A0 =A0print "E The authentication script specified i=
n " .
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"[gitcvs.authscript] cannot be execute=
d\n";
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
index 8639506..ab5cb26 100755
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
+test "\$username" =3D cvsuser -a "\$password" =3D cvspassword
+EOF
+
+chmod a+x "$SERVERDIR/authscript.sh"
+
=A0cat >request-anonymous =A0<<EOF
=A0BEGIN AUTH REQUEST
=A0$SERVERDIR
@@ -134,6 +144,51 @@ test_expect_success 'pserver authentication
failure (login/non-anonymous user)'
=A0 =A0fi &&
=A0 =A0sed -ne \$p log | grep "^I HATE YOU\$"'

+GIT_DIR=3D"$SERVERDIR" git config gitcvs.authscript
"$SERVERDIR/authscript.sh" || exit 1
+
+test_expect_success 'pserver authentication failure (both
authentication methods)' \
+ =A0'if cat request-git | git-cvsserver pserver >log 2>&1
+ =A0 then
+ =A0 =A0 =A0 false
+ =A0 else
+ =A0 =A0 =A0 true
+ =A0 fi &&
+ =A0 sed -ne \$p log | grep "^I HATE YOU\$"'
+
+GIT_DIR=3D"$SERVERDIR" git config --unset gitcvs.authdb || exit 1
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
1.7.0.4
