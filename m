From: Arnaud Lacombe <lacombar@gmail.com>
Subject: Re: [PATCH] Try harder to find a remote when on a detached HEAD or
 non-tracking branch.
Date: Mon, 18 Jun 2012 13:53:15 -0400
Message-ID: <CACqU3MXgb1f7MU0m-yCp48UZrnfqBztBToZoibAFraYvT+TpEg@mail.gmail.com>
References: <1340038866-24552-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Mon Jun 18 19:53:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sgg8e-0002pH-Td
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 19:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499Ab2FRRxR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jun 2012 13:53:17 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:44959 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700Ab2FRRxQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jun 2012 13:53:16 -0400
Received: by wibhj8 with SMTP id hj8so2352727wib.1
        for <git@vger.kernel.org>; Mon, 18 Jun 2012 10:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=CbAG+f8MTuSJYmq56e3Sw8i0ai8mR5lrvVde7eUEFNo=;
        b=vTAnIiy1AYR9EIkWDsaOMKM/M1RSt2Z1HAqbWGzeF99C3UN1y0ITu6zLSfGJ2ombl4
         4CiGGQmTwutveyL/EeSwxlbF5zjnJtuxR49jOMS0/03EbnCP9xYPOmOBYyYbOytp8GIx
         0u8jDFm9XjxMbEF6nPkO9zFpex7lo5sI9d0KKJ1RfsCLgvx5+crK8Ha+Iydqbu13QtWg
         vz/HSxcqcAJy8bIiT5kWIA4myma6ArmpiDZ6yyZ33Hv3TxbjH87AeMYtqWevFEyL8kUR
         XahYWHzTe6zjAya33ajvP3krStZDJG4lvTt+QBX1VrFfbC/x+EcPZffF+ORqPfUa5+hL
         a8QQ==
Received: by 10.180.79.166 with SMTP id k6mr25927466wix.8.1340041995414; Mon,
 18 Jun 2012 10:53:15 -0700 (PDT)
Received: by 10.216.214.101 with HTTP; Mon, 18 Jun 2012 10:53:15 -0700 (PDT)
In-Reply-To: <1340038866-24552-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200152>

Hi,

On Mon, Jun 18, 2012 at 1:01 PM,  <marcnarc@xiplink.com> wrote:
> From: Marc Branchaud <marcnarc@xiplink.com>
>
> get_default_remote() tries to use the checked-out branch's 'remote' c=
onfig
> value to figure out the remote's name. =A0This fails if there is no c=
urrently
> checked-out branch (i.e. HEAD is detached) or if the checked-out bran=
ch
> doesn't track a remote. =A0In these cases and the function would just=
 fall
> back to "origin".
>
> Instead, let's use the first remote listed in the configuration, and =
fall
> back to "origin" only if we don't find any configured remotes.
>
> Prior to this change, git would fail to initialize a relative-path
> submodule if the super-repo was on a detached HEAD and it had no remo=
te
> named "origin".
>
Marc, could you explain the problem you were trying to solve ? You are
only giving hints about the change made, not the reason behind it.

Thanks,
 - Arnaud

> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
> ---
>
> Our build system likes to use detached HEADs, so we got tripped up wh=
en we
> started using relative submodule URLs.
>
> (I'm not sure about the portability of my change, or if I should wrap=
 it
> to 80 columns...)
>
> =A0git-parse-remote.sh =A0 =A0 =A0 =A0| =A01 +
> =A0t/t7400-submodule-basic.sh | 22 ++++++++++++++++++++++
> =A02 files changed, 23 insertions(+)
>
> diff --git a/git-parse-remote.sh b/git-parse-remote.sh
> index 484b2e6..225ad94 100644
> --- a/git-parse-remote.sh
> +++ b/git-parse-remote.sh
> @@ -8,6 +8,7 @@ get_default_remote () {
> =A0 =A0 =A0 =A0curr_branch=3D$(git symbolic-ref -q HEAD)
> =A0 =A0 =A0 =A0curr_branch=3D"${curr_branch#refs/heads/}"
> =A0 =A0 =A0 =A0origin=3D$(git config --get "branch.$curr_branch.remot=
e")
> + =A0 =A0 =A0 test -z "$origin" && origin=3D$(git config --list | gre=
p '^remote\.' | head -1 | awk -F . '{print $2}')
> =A0 =A0 =A0 =A0echo ${origin:-origin}
> =A0}
>
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 81827e6..8f1ff4f 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -507,6 +507,28 @@ test_expect_success 'relative path works with us=
er@host:path' '
> =A0 =A0 =A0 =A0)
> =A0'
>
> +test_expect_success 'relative path works on detached HEAD and remote=
 is not named "origin"' '
> + =A0 =A0 =A0 mkdir detachtest &&
> + =A0 =A0 =A0 (
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cd detachtest &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 git init &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mkdir sub &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cd sub &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 git init &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 test_commit foo
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 git add sub &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 git commit -m "added sub" &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 git checkout HEAD@{0} &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 git config -f .gitmodules submodule.sub=
=2Epath sub &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 git config -f .gitmodules submodule.sub=
=2Eurl ../subrepo &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 git remote add awkward ssh://awkward/re=
po &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 git submodule init sub &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 test "$(git config submodule.sub.url)" =
=3D ssh://awkward/subrepo
> + =A0 =A0 =A0 )
> +'
> +
> =A0test_expect_success 'moving the superproject does not break submod=
ules' '
> =A0 =A0 =A0 =A0(
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cd addtest &&
> --
> 1.7.11.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
