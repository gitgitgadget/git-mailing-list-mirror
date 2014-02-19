From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 23/25] checkout: detach if the branch is already
 checked out elsewhere
Date: Wed, 19 Feb 2014 16:52:58 -0500
Message-ID: <CAPig+cRUBZ9SE8DHymnFGK5EtZpa_U4bpaB87vSrKwHNfLQ9+w@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-24-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 19 22:53:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGF4j-0005XC-Rb
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 22:53:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060AbaBSVxA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Feb 2014 16:53:00 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:56247 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbaBSVw7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Feb 2014 16:52:59 -0500
Received: by mail-qa0-f46.google.com with SMTP id k15so1625083qaq.33
        for <git@vger.kernel.org>; Wed, 19 Feb 2014 13:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=r9FOW8JfFwkW3avS++s9Cxzbbv11Ts6LDTy32fDaLA4=;
        b=mXgg3kF7i5pLBVDwlP9B1Awjtd6Q3Wz80D+PvEoqWOWGhlvcEyet8qtQPEdkWFtUiX
         r1v0XA0p6l4Mvu/LVmwqTpsmacShuZ4BvHrinRtBpcKZEU7TiCtRI74pHu/8/vHXJC4S
         ps0tKtpY0eOhQ1uEMlfs5ZK83ZznnWx3ErSSC05CHGB3idD5tMxbKelXm18SOgOMOxCM
         w+/kiPSGWtOQsQ5ZzwH8MP8gUbhVA0vHxoqukvFPYfS5E3H4oTkmYgi6HWO5Fz0Z0Cy9
         A/87oDT6CLTNYkl2mZ3xQPLINzvRvB6BehphgYTSQdfxxCTrue+H8eUJwQdjQerbZbuq
         p0LA==
X-Received: by 10.236.126.81 with SMTP id a57mr35020163yhi.95.1392846779154;
 Wed, 19 Feb 2014 13:52:59 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Wed, 19 Feb 2014 13:52:58 -0800 (PST)
In-Reply-To: <1392730814-19656-24-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: DWLKXXVQWmQxTxPLuDih7Z1-p0Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242413>

On Tue, Feb 18, 2014 at 8:40 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> The normal rule is anything outside refs/heads/ is detached. This
> strictens the rule a bit more: if the branch is checked out (either i=
n

s/strictens/increases strictness of/

> $GIT_COMMON_DIR/HEAD or any $GIT_DIR/repos/.../HEAD) then it's
> detached as well.
>
> A hint is given so the user knows where to go and do something there
> if they still want to checkout undetached here.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index f961604..7b86f2b 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -433,6 +433,11 @@ struct branch_info {
>         const char *name; /* The short name used */
>         const char *path; /* The full name of a real branch */
>         struct commit *commit; /* The named commit */
> +       /*
> +        * if not null the branch is detached because it's alrady

s/alrady/already/

> +        * checked out in this checkout
> +        */
> +       char *checkout;
>  };
>
> +static void check_linked_checkouts(struct branch_info *new)
> +{
> +       struct strbuf path =3D STRBUF_INIT;
> +       DIR *dir;
> +       struct dirent *d;
> +
> +       strbuf_addf(&path, "%s/repos", get_git_common_dir());
> +       if ((dir =3D opendir(path.buf)) =3D=3D NULL)

strbuf_release(&path);

> +               return;
> +
> +       strbuf_reset(&path);
> +       strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
> +       /*
> +        * $GIT_COMMON_DIR/HEAD is practically outside
> +        * $GIT_DIR so resolve_ref_unsafe() won't work (it
> +        * uses git_path). Parse the ref ourselves.
> +        */
> +       if (check_linked_checkout(new, "", path.buf)) {
> +               strbuf_release(&path);
> +               closedir(dir);
> +               return;
> +       }
> +
> +       while ((d =3D readdir(dir)) !=3D NULL) {
> +               if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, "..=
"))
> +                       continue;
> +               strbuf_reset(&path);
> +               strbuf_addf(&path, "%s/repos/%s/HEAD",
> +                           get_git_common_dir(), d->d_name);
> +               if (check_linked_checkout(new, d->d_name, path.buf))
> +                       break;
> +       }
> +       strbuf_release(&path);
> +       closedir(dir);
> +}
