From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 25/28] prune: strategies for linked checkouts
Date: Sun, 9 Mar 2014 04:20:28 -0400
Message-ID: <CAPig+cRcyP7=g61MDkZeEQnkoNop-Qs64UW8qnPaPCjti8B_tw@mail.gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
	<1394246900-31535-1-git-send-email-pclouds@gmail.com>
	<1394246900-31535-26-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 09:20:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMYyK-0001gO-Jo
	for gcvg-git-2@plane.gmane.org; Sun, 09 Mar 2014 09:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbaCIIUb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Mar 2014 04:20:31 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:46480 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbaCIIU3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Mar 2014 04:20:29 -0400
Received: by mail-yh0-f43.google.com with SMTP id b6so5917279yha.2
        for <git@vger.kernel.org>; Sun, 09 Mar 2014 00:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=X4iotsKPnvh2nXndNUiB81m+ZcSoKAPSEjxRjLlDfCo=;
        b=v1yHkNJfbgMeaH6tb89nuKAJYzOpzgta3lpMEKaf+7ou12ygD7xYXWegMMoE4q+FWP
         YqfWHsXTFs/L5NXTowlmJVNj3M6nTXrqZSXgMmrIQl7gR1GZLmqIETsbQrUFJfSCJcpb
         jzHP/VZHcfZTpScxOF7n0vPHANpzkIIqDYsHVimAmdj9qeD23sJwbSwh11MR9zNNQrMu
         G+uJfF97VPtd7mDePc1JLuywsADBypU0Hg/W3NRRe6uPh1tydWJRbrc3HpxTdQsrt4BC
         oUuW+IeKVKLCbVoeG7JVFQZ0ath1RzksABYmGTnsHNGve0rXf4w3B85JUjVjhUfxnE/m
         KA6w==
X-Received: by 10.236.92.115 with SMTP id i79mr35229597yhf.62.1394353229033;
 Sun, 09 Mar 2014 00:20:29 -0800 (PST)
Received: by 10.170.180.134 with HTTP; Sun, 9 Mar 2014 00:20:28 -0800 (PST)
In-Reply-To: <1394246900-31535-26-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: EgVCkYryuzLW0QWO_oOG7DIzRsI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243693>

On Fri, Mar 7, 2014 at 9:48 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> (alias R=3D$GIT_COMMON_DIR/repos/<id>)
>
>  - linked checkouts are supposed to keep its location in $R/gitdir up
>    to date. The use case is auto fixup after a manual checkout move.
>
>  - linked checkouts are supposed to update mtime of $R/gitdir. If
>    $R/gitdir's mtime is older than a limit, and it points to nowhere,
>    repos/<id> is to be pruned.
>
>  - If $R/locked exists, repos/<id> is not supposed to be pruned. If
>    $R/locked exists and $R/gitdir's mtime is older than a really long
>    limit, warn about old unused repo.
>
>  - "git checkout --to" is supposed to make a hard link named $R/link
>    pointing to the .git file on supported file systems to help detect
>    the user manually deleting the checkout. If $R/link exists and its
>    link count is greated than 1, the repo is kept.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 598b43d..9dc80f1 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -899,12 +899,22 @@ static int prepare_linked_checkout(const struct=
 checkout_opts *opts,
>         junk_git_dir =3D sb_repo.buf;
>         is_junk =3D 1;
>
> +       /*
> +        * lock the incomplete repo so prunt won't delete it, unlock

s/prunt/prune/

> +        * after the preparation is over.
> +        */
> +       strbuf_addf(&sb, "%s/locked", sb_repo.buf);
> +       write_file(sb.buf, 1, "initializing\n");
> +
>         strbuf_addf(&sb_git, "%s/.git", path);
>         if (safe_create_leading_directories_const(sb_git.buf))
>                 die_errno(_("could not create leading directories of =
'%s'"),
>                           sb_git.buf);
>         junk_work_tree =3D path;
>
> +       strbuf_reset(&sb);
> +       strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
> +       write_file(sb.buf, 1, "%s\n", real_path(sb_git.buf));
>         write_file(sb_git.buf, 1, "gitdir: %s/repos/%s\n",
>                    real_path(get_git_common_dir()), name);
>         /*
