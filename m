From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/4] git-cvsserver: implement script based pserver 
	authentication
Date: Sat, 3 Jul 2010 22:14:53 +0000
Message-ID: <AANLkTil4C_oF972J5iRApUGXpwoFNqcYTgkzvorCseZZ@mail.gmail.com>
References: <1058578005711783867@unknownmsgid>
	<AANLkTikbPyZ-q8XgTBX1P9HQlFwUhiJSpiOgYG75mtiq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?w4FzaGluIEzDoXN6bMOz?= <ashinlaszlo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 04 00:15:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVAzK-0000tl-FS
	for gcvg-git-2@lo.gmane.org; Sun, 04 Jul 2010 00:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755804Ab0GCWO5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Jul 2010 18:14:57 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59980 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755665Ab0GCWOy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jul 2010 18:14:54 -0400
Received: by fxm14 with SMTP id 14so3006309fxm.19
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 15:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aS7V7AslkVgw32/Xzb6orHp787zP82U4lu8QxXjmoWg=;
        b=THoQCWHHZR9ByIsfoiFh3oJ5aGLXiLIGeAvCTPQj/CgYiZsNVgMIlku4sOIP32Atb9
         o9ePUXOBkrBqh0ZK15HgKr0tHz0n8SLQHioHUksMq7Rk3k6afQZx9XEf45v6pJrUYa7o
         nzh+4FAGfpJBvWbPmLin0NXxrej2YOyS6C4Dk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eiDcGudNkZyqURRqkyUY+LNM/SULlHiNWAGG3K/5VBv+dynfFYwgrTHMCYmtmfEM+a
         vnEUFuH/AM/HOBWb6mzZBaM8VlFHnORj5l8zR2/ZHL03yOs1b10lw5B8vlieAXNcZpIu
         jJCyksLgXU/4e46G9pl/epqTZnc1hEUiXL514=
Received: by 10.223.103.197 with SMTP id l5mr634008fao.53.1278195293202; Sat, 
	03 Jul 2010 15:14:53 -0700 (PDT)
Received: by 10.223.103.84 with HTTP; Sat, 3 Jul 2010 15:14:53 -0700 (PDT)
In-Reply-To: <AANLkTikbPyZ-q8XgTBX1P9HQlFwUhiJSpiOgYG75mtiq@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150208>

On Sat, Jul 3, 2010 at 21:21, =C3=81shin L=C3=A1szl=C3=B3 <ashinlaszlo@=
gmail.com> wrote:
> =C2=A0Documentation/git-cvsserver.txt | =C2=A0 46 +++++++++++++++++++=
++++++++++++++++---
> =C2=A0git-cvsserver.perl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 28 +++++++++++++++++++++++
> =C2=A0t/t9400-git-cvsserver-server.sh | =C2=A0 45 +++++++++++++++++++=
+++++++++++++++++++
> =C2=A03 files changed, 115 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvss=
erver.txt
> index 7004dd2..b3c3122 100644
> --- a/Documentation/git-cvsserver.txt
> +++ b/Documentation/git-cvsserver.txt
> @@ -100,10 +100,48 @@ looks like
> =C2=A0------
>
> =C2=A0Only anonymous access is provided by pserve by default. To comm=
it you

I think it's always called "pserver" with an -r.

> -will have to create pserver accounts, simply add a gitcvs.authdb
> -setting in the config file of the repositories you want the cvsserve=
r
> -to allow writes to, for example:
> +will have to specify an authentication option in the config file.
> +Currently there are two options are available for authentication thr=
ough
> +pserver in git-cvsserver: one through an authenticator script and an=
 other
> +through a textual authentication database. If both are specified in =
the config
> +file then the script based solution will be used.

If both are specified shouldn't we throw an error?

> + =C2=A0a. To use the authentication script based method, simply add =
a
> + =C2=A0 =C2=A0 gitcvs.authscript setting in the config file of the r=
epositories you want
> + =C2=A0 =C2=A0 the cvsserver to allow writes to, for example:
> ++
> +--
> +------
> +
> + =C2=A0 [gitcvs]
> + =C2=A0 =C2=A0authscript =3D /usr/local/bin/cvsserver-auth.sh
> +
> +------
> +The file specified here must be executable by the user the git-cvsse=
rver runs
> +under the name of. This script has to read exactly two lines from it=
s standard

"the name of" is redundant here.

> +input as long as git-cvsserver passes the username and the password =
on separate
> +lines. After the script did its task by checking the username and pa=
ssword
> +given it has to return zero if the authentication was successful and=
 return
> +other value if it was not.

Better as: "The script will receive two lines on standard input, the
first is the username and the second is the password. It should return
0 if the user was successfully authenticated, and a non-zero value if
not".

> +
> +Here is an example for an authentication script which checks the use=
rs against
> +active directory:
> +------
> +#!/bin/sh
> +# /usr/local/bin/cvsserver-auth.sh
>
> +read username
> +read password
> +
> +wbinfo -a "${username}%${password}"

Do all POSIX shells implicitly exit with the return value of the last
statement they evaluate. I don't know.

> +------
> +--
> +
> + =C2=A0b. To use the authentication database based method, simply ad=
d a
> + =C2=A0 =C2=A0 gitcvs.authdb setting in the config file of the repos=
itories you want the
> + =C2=A0 =C2=A0 cvsserver to allow writes to, for example:
> ++
> +--
> =C2=A0------
>
> =C2=A0 =C2=A0[gitcvs]
> @@ -125,7 +163,7 @@ Alternatively you can produce the password with
> perl's crypt() operator:
> =C2=A0-----
> =C2=A0 =C2=A0perl -e 'my ($user, $pass) =3D @ARGV; printf "%s:%s\n", =
$user,
> crypt($user, $pass)' $USER password
> =C2=A0-----
> -
> +--
> =C2=A0Then provide your password via the pserver method, for example:
> =C2=A0------
> =C2=A0 =C2=A0cvs -d:pserver:someuser:somepassword <at> server/path/re=
po.git co <HEAD_name>
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index e9f3037..9664e86 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -197,6 +197,34 @@ if ($state->{method} eq 'pserver') {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Fall through to LOVE
> + =C2=A0 =C2=A0} elsif (exists $cfg->{gitcvs}->{authscript}) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0my $authscript =3D $cfg->{gitcvs}->{auth=
script};
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unless (-x $authscript) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print "E The authenticatio=
n script specified in ";
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print "[gitcvs.authscript]=
 cannot be executed\n";

I *think* you have to prefix anything that's not "I (HATE|LOVE) YOU"
with "E " if it's an error. I.e. this should probably be:

    print "E The authentication script specified in";
    print "E [gitcvs.authscript] cannot be executed\n";

But that's just my hazy memory. Maybe CVS clients will report the
error anyway.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print "I HATE YOU\n";
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0open my $script_fd, '|-', "'$authscript'=
"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0or die "Couldn't open auth=
entication script '$authscript': $!";
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (length($password) > 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$password =3D descramble($=
password);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0print $script_fd "$user\n";
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0print $script_fd "$password\n";
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0close $script_fd;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unless ($? =3D=3D 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print "E External script a=
uthentication failed.\n";
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print "I HATE YOU\n";
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0# Fall through to LOVE
> =C2=A0 =C2=A0 } else {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Trying to authenticate a user
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (not exists $cfg->{gitcvs}->{authdb}) =
{
> diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-=
server.sh
> index 8639506..0743e9a 100755
> --- a/t/t9400-git-cvsserver-server.sh
> +++ b/t/t9400-git-cvsserver-server.sh
> @@ -64,6 +64,16 @@ test_expect_success 'basic checkout' \
> =C2=A0# PSERVER AUTHENTICATION
> =C2=A0#------------------------
>
> +cat >"$SERVERDIR/authscript.sh" <<EOF
> +#!/bin/sh
> +read username
> +read password
> +
> +test "x\$username" =3D xcvsuser -a "x\$password" =3D xcvspassword

This is offtopic. But I've never figured out why you need to do

    test "x$foo" =3D "xbar"

As opposed to:

    test "$foo" =3D "bar"

In shellscript. Are there really some shells that get equality tests
where one term is "" wrong?

> +EOF
> +
> +chmod a+x "$SERVERDIR/authscript.sh"
> +
> =C2=A0cat >request-anonymous =C2=A0<<EOF
> =C2=A0BEGIN AUTH REQUEST
> =C2=A0$SERVERDIR
> @@ -134,6 +144,41 @@ test_expect_success 'pserver authentication
> failure (login/non-anonymous user)'
> =C2=A0 =C2=A0fi &&
> =C2=A0 =C2=A0sed -ne \$p log | grep "^I HATE YOU\$"'
>
> +GIT_DIR=3D"$SERVERDIR" git config --unset gitcvs.authdb || exit 1
> +GIT_DIR=3D"$SERVERDIR" git config gitcvs.authscript
> "$SERVERDIR/authscript.sh" || exit 1
> +
> +test_expect_success 'pserver authentication (authscript)' \
> + =C2=A0'cat request-anonymous | git-cvsserver pserver >log 2>&1 &&
> + =C2=A0 sed -ne \$p log | grep "^I LOVE YOU\$"'
> +
> +test_expect_success 'pserver authentication failure (authscript,
> non-anonymous user)' \
> + =C2=A0'if cat request-git | git-cvsserver pserver >log 2>&1
> + =C2=A0 then
> + =C2=A0 =C2=A0 =C2=A0 false
> + =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 true
> + =C2=A0 fi &&

This should probably be (untested):

    test_must_fail cat request-git git-cvsserver pserver >log 2>&1 &&

> + =C2=A0 sed -ne \$p log | grep "^I HATE YOU\$"'
> +
> +test_expect_success 'pserver authentication success (authscript,
> non-anonymous user with password)' \
> + =C2=A0'cat login-git-ok | git-cvsserver pserver >log 2>&1 &&
> + =C2=A0 sed -ne \$p log | grep "^I LOVE YOU\$"'
> +
> +test_expect_success 'pserver authentication (authscript, login)' \
> + =C2=A0'cat login-anonymous | git-cvsserver pserver >log 2>&1 &&
> + =C2=A0 sed -ne \$p log | grep "^I LOVE YOU\$"'
> +
> +test_expect_success 'pserver authentication failure (authscript,
> login/non-anonymous user)' \
> + =C2=A0'if cat login-git | git-cvsserver pserver >log 2>&1
> + =C2=A0 then
> + =C2=A0 =C2=A0 =C2=A0 false
> + =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 true
> + =C2=A0 fi &&
> + =C2=A0 sed -ne \$p log | grep "^I HATE YOU\$"'
> +
> +GIT_DIR=3D"$SERVERDIR" git config --unset gitcvs.authscript || exit =
1
> +GIT_DIR=3D"$SERVERDIR" git config gitcvs.authdb "$SERVERDIR/auth.db"=
 || exit 1
>
> =C2=A0# misuse pserver authentication for testing of req_Root

Otherwise looking good.
