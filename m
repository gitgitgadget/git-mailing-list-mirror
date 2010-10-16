From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] merge-file: correctly find files when called in subdir
Date: Sat, 16 Oct 2010 15:30:48 +0200
Message-ID: <AANLkTimzuF3Ku_Jjnq0qKFtrDfAfz8YxChomZr8+Shm1@mail.gmail.com>
References: <33ab2f03ed522e1a9be202017b7bbfe35e6d7a99.1287228637.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Oct 16 15:30:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P76qd-0007gP-Br
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 15:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756291Ab0JPNau convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Oct 2010 09:30:50 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43489 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754335Ab0JPNat convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Oct 2010 09:30:49 -0400
Received: by fxm4 with SMTP id 4so1142020fxm.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 06:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uCp9kLBDb+dGQMwFDNeA7KjKRxFQDzG4l7QdzGNC2Rs=;
        b=x4lqgGjUN1u0Yq3eF/GroFBRfaDLkv1r2A6tbBzrFoO1ETsYV6DKmoTV2qfCjPR72q
         nHLqjhHE97/7withTx0BQ273IsFv1qOeJUmEd4T2HxRbtj+TFlxZb0vBWBg3tBGwme04
         NzwS1mi/xLXSroJF5piTK+QYTYeNq+vlZz04I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Pb0a+nHDxGV2g2L3xcNqkQMbua5U8zWIToEG0QJcaRsTjGHCBcIjCTFyNa3AkOtH9O
         8n0zMpVmKgJ0v8CV+uMeX1ekDorYz8vFWgukGmtNs0uvc2j9tWiUPYXv7DQYLv4jWlxD
         WjwAq3HX31F5ofNlsYNJ0I1pnsRPUJt8eF19k=
Received: by 10.103.192.20 with SMTP id u20mr1041777mup.46.1287235848415; Sat,
 16 Oct 2010 06:30:48 -0700 (PDT)
Received: by 10.223.113.10 with HTTP; Sat, 16 Oct 2010 06:30:48 -0700 (PDT)
In-Reply-To: <33ab2f03ed522e1a9be202017b7bbfe35e6d7a99.1287228637.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159163>

On Sat, Oct 16, 2010 at 13:33, Thomas Rast <trast@student.ethz.ch> wrot=
e:
> Since b541248 (merge.conflictstyle: choose between "merge" and "diff3
> -m" styles, 2008-08-29), git-merge-file uses setup_directory_gently()=
,
> thus cd'ing around to find any possible config files to use.
>
> This broke merge-file when it is called from within a subdirectory of
> a repository, and the arguments are all relative paths.
>
> Fix by prepending the prefix, as passed down from the main git
> executable, if there is any.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
> =C2=A0builtin/merge-file.c =C2=A0| =C2=A0 11 ++++++++++-
> =C2=A0t/t6023-merge-file.sh | =C2=A0 =C2=A08 ++++++++
> =C2=A02 files changed, 18 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/merge-file.c b/builtin/merge-file.c
> index b6664d4..b873fee 100644
> --- a/builtin/merge-file.c
> +++ b/builtin/merge-file.c
> @@ -65,10 +66,18 @@ int cmd_merge_file(int argc, const char **argv, c=
onst char *prefix)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "%s\n", strerr=
or(errno));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> + =C2=A0 =C2=A0 =C2=A0 if (prefix)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prefixlen =3D strl=
en(prefix);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < 3; i++) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *name;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prefix)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 name =3D prefix_filename(prefix, prefixlen, argv[i]);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 name =3D argv[i];

I think you can safe this condition, if you set prefixlen to 0.

Bert
