From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 24/25] prune: strategies for linked checkouts
Date: Wed, 19 Feb 2014 17:08:02 -0500
Message-ID: <CAPig+cQgphSBA6iAYqLJ7RnEwSzBA1dApcLWAydZEXarQRcTKQ@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-25-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 19 23:08:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGFJM-0007Kf-Bp
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 23:08:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588AbaBSWIG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Feb 2014 17:08:06 -0500
Received: from mail-qc0-f180.google.com ([209.85.216.180]:63984 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526AbaBSWID convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Feb 2014 17:08:03 -0500
Received: by mail-qc0-f180.google.com with SMTP id i17so1793044qcy.25
        for <git@vger.kernel.org>; Wed, 19 Feb 2014 14:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=2Swog0LVzlvtgLLW8KQt1eXCeJaGbKd+vYEW9F3cX+Q=;
        b=eqgkyRbNSZtYfblLk2/SPD0H1vUkbbIQH9n7Gq+zboDj4CS04nQ7EeE5MIxGUqx8dX
         s53AbAu73jN+M1oYiNA1NiGWs+2U5Ktns7FYYwRIU8GTxNnEyo5yQKsig6VA3JCHI9kW
         2TZawkIWDfPSbw28vGIBmX/p4dRIrHbAtGFc1VrnKC3e4nTgPjf4TXrFzIi8a28QLK1q
         MNEHkfDzFCS3/POI3TuWTmgDGbPz8aR97Bnx9aJTXqWNUI6sknBGalDJISWP8McIcncb
         GIO+lb3SdYwvYAjHS+WYxXchFArC7Vq3ZQ1tP++sW55ixdSwokjBU4l+HLKDUwShMjsF
         6BEA==
X-Received: by 10.236.120.17 with SMTP id o17mr14087643yhh.121.1392847682085;
 Wed, 19 Feb 2014 14:08:02 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Wed, 19 Feb 2014 14:08:02 -0800 (PST)
In-Reply-To: <1392730814-19656-25-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 3lJTZThhB3yQapdQpOt470CF1tE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242414>

On Tue, Feb 18, 2014 at 8:40 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> The pruning rules are:
>
>  - if $REPO/locked exists, repos/<id> is not supposed to be pruned.
>
>  - if $REPO/locked exists and $REPO/gitdir's mtimer is older than a

s/mtimer/mtime/

>    really long limit, warn about old unused repo.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 7b86f2b..c501e9c 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -854,6 +854,17 @@ static void remove_junk_on_signal(int signo)
>         raise(signo);
>  }
>
> +static dev_t get_device_or_die(const char *path)
> +{
> +       struct stat buf;
> +       if (stat(path, &buf))
> +               die_errno("failed to stat '%s'", path);
> +       /* Ah Windows! Make different drives different "partitions" *=
/
> +       if (buf.st_dev =3D=3D 0 && has_dos_drive_prefix("c:\\"))
> +               buf.st_dev =3D toupper(real_path(path)[0]);

This invocation of has_dos_drive_prefix() with hardcoded "c:\\" at
first looks like an error until the reader realizes that it's an
#ifdef-less check if the platforms is Windows. Would it make more
sense to encapsulate this anomaly and abstract it away by fixing
compat/mingw.c:do_lstat() to instead set 'st_dev' automatically like
you do here? In particular, this line in mingw.c:

    buf->st_dev =3D buf->st_rdev =3D 0; /* not used by Git */

> +       return buf.st_dev;
> +}
