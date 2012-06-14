From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH js/submodule-relative] t7400: avoid path mangling issues
Date: Thu, 14 Jun 2012 23:11:45 +1000
Message-ID: <CAH3AnrpCJwXNBOL75mBkfF69RK_TVUsnPx7m8reShR2g75bAWQ@mail.gmail.com>
References: <4FD9D4B3.9060805@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jun 14 15:12:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf9q7-0001p3-HR
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 15:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978Ab2FNNLv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jun 2012 09:11:51 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:44500 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755893Ab2FNNLv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jun 2012 09:11:51 -0400
Received: by wibhn6 with SMTP id hn6so1922133wib.1
        for <git@vger.kernel.org>; Thu, 14 Jun 2012 06:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=FDSU31wf/JVvBlMlPhyoP1SQknRVn2q8lBHCZSuO6iU=;
        b=NBcmOTLpDattsR0ZCIcmueaFFWehXv18QW/9fph/4eTcbNTwkxOn5BeR/7pZr/5QE2
         4Rz04ippVw2wJ36sNObLe1UJCBDTkcGU11OQE1fRh6N4aKppmpnTgKZcNzoXGZk0NiA5
         AOhWwON96N1D7imbgwgWuUCZxZtk7aEkq+uAKQ+p27njvwB2pQEL95j6s+8GdXYRhZxP
         36ikcpLY3y4pwxaxHg+0NKgfJTUdEIglwADTDjz+PG9CspKkJvM+F/Ky8I93LKtJGRI5
         BUUf/sVCnnUhZv3zd1PWnqNSM307BsyerkWIGUq6e1iOMiPFxXh2zAtjp87b+cVAh+YU
         pJhw==
Received: by 10.180.98.231 with SMTP id el7mr4305917wib.21.1339679505983; Thu,
 14 Jun 2012 06:11:45 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Thu, 14 Jun 2012 06:11:45 -0700 (PDT)
In-Reply-To: <4FD9D4B3.9060805@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200005>

On Thu, Jun 14, 2012 at 10:10 PM, Johannes Sixt <j.sixt@viscovery.net> =
wrote:
> From: Johannes Sixt <j6t@kdbg.org>
>
> A recently introduced test uses an absolute path. But when run on Win=
dows
> using the MSYS bash, such a path is mangled into a Windows style path=
 when
> it is passed to 'git config'. The subsequent 'test' then compares the
> mangled path to the unmangled version and reports a failure.
>
> A path beginning with two slashes denotes a network directory
> (//server/share path) and is not mangled. Use that trick to side-step=
 the
> issue. Just in case that 'git submodule init' regresses in such a way=
 that
> it accesses the URL, use a path name that is unlikely to exist on POS=
IX
> systems, and that cannot be a server name on Windows.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> =C2=A0Sorry, Jon, Junio, for the resend. Forgot to Cc the list.
>
> =C2=A0t/t7400-submodule-basic.sh | 11 ++++++++---
> =C2=A01 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index a899e6d..c73bec9 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -510,14 +510,19 @@ test_expect_success '../subrepo works with port=
-qualified URL - ssh://hostname:2
> =C2=A0 =C2=A0 =C2=A0 =C2=A0)
> =C2=A0'
>
> -test_expect_success '../subrepo path works with local path - /foo/re=
po' '
> +# About the choice of the path in the next test:
> +# - double-slash side-steps path mangling issues on Windows
> +# - it is still an absolute local path
> +# - there cannot be a server with a blank in its name just in case t=
he
> +# =C2=A0 path is used erroneously to access a //server/share style p=
ath
> +test_expect_success '../subrepo path works with local path - //somew=
here else/repo' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cd reltest &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cp pristine-.g=
it-config .git/config &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cp pristine-.g=
itmodules .gitmodules &&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git config remote.=
origin.url /foo/repo &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git config remote.=
origin.url "//somewhere else/repo" &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git submodule =
init &&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test "$(git config=
 submodule.sub.url)" =3D /foo/subrepo
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test "$(git config=
 submodule.sub.url)" =3D "//somewhere else/subrepo"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0)
> =C2=A0'
>
> --
> 1.7.11.rc3.1188.ga03e3fc

Thank you for the report and the test case.

jon.
