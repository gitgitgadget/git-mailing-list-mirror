From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] clean: improve performance when removing lots of directories
Date: Mon, 6 Apr 2015 18:10:17 -0400
Message-ID: <CAPig+cQOLJcy-QuACrvd+XrCpP74k0SXxj0rBkNneG5Ovnf47Q@mail.gmail.com>
References: <1428320904-12366-1-git-send-email-erik.elfstrom@gmail.com>
	<1428320904-12366-4-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Erik_Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 00:10:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfFDs-0003jp-2B
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 00:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbbDFWKU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 18:10:20 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:34488 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbbDFWKT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2015 18:10:19 -0400
Received: by lboc7 with SMTP id c7so29300882lbo.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 15:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=46Sc6qKL02ze8zVwkzyWTMT3BhADmB7aNjjG9HhmqWY=;
        b=ISAh+OTagXn414KTHGCh0C7ZcAVYLRMzEqLvov0Y4Hf58ZnE6pMUAnw28qrrvMj0dW
         haszUXQ04QbH5EF5tqZuTd2aKSk1BgrPj1rz8oGqVXFtIfVmgs6ch5I07E4dxXm/cku7
         U8YzN0b5Wjb/QGaJ1LXB1RChDtCESeoVTfV7MfUYO3IerYJ2BqEchFcwLOr+4pt17WzD
         f/viiUz3Gwa3Q/bWG3I0izlHTRnyCIQiBMhfPkJskM5n5/sQqQR33Qpy5+TwVHC/SXRr
         A9jO7MIYiy9uRa1DxOFFvi0rwZa6p62mF0hvYy37c3EnI1METhspRF2A3S3Ep8JOmJ3Z
         p9JA==
X-Received: by 10.152.170.199 with SMTP id ao7mr15086304lac.27.1428358217639;
 Mon, 06 Apr 2015 15:10:17 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Mon, 6 Apr 2015 15:10:17 -0700 (PDT)
In-Reply-To: <1428320904-12366-4-git-send-email-erik.elfstrom@gmail.com>
X-Google-Sender-Auth: -PM0C3_0Qn6o3K_xOiYx9SlV1gg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266892>

On Mon, Apr 6, 2015 at 7:48 AM, Erik Elfstr=C3=B6m <erik.elfstrom@gmail=
=2Ecom> wrote:
> Before this change, clean used resolve_gitlink_ref to check for the
> presence of nested git repositories. This had the drawback of creatin=
g
> a ref_cache entry for every directory that should potentially be
> cleaned. The linear search through the ref_cache list caused a massiv=
e
> performance hit for large number of directories.
>
> Teach clean.c:remove_dirs to use setup.c:is_git_directory
> instead. is_git_directory will actually open HEAD and parse the HEAD
> ref but this implies a nested git repository and should be rare when
> cleaning.
>
> Using is_git_directory should give a more standardized check for what
> is and what isn't a git repository but also gives a slight behavioral
> change. We will now detect and respect bare and empty nested git
> repositories (only init run). Update t7300 to reflect this.
>
> The time to clean an untracked directory containing 100000 sub
> directories went from 61s to 1.7s after this change.

Impressive.

> Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
> Helped-by: Jeff King <peff@peff.net>

It is customary for your sign-off to be last.

More below...

> ---
> diff --git a/builtin/clean.c b/builtin/clean.c
> index 98c103f..e951bd9 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -148,6 +147,24 @@ static int exclude_cb(const struct option *opt, =
const char *arg, int unset)
>         return 0;
>  }
>
> +static int is_git_repository(struct strbuf *path)
> +{
> +       int ret =3D 0;
> +       if (is_git_directory(path->buf))
> +               ret =3D 1;
> +       else {
> +               int orig_path_len =3D path->len;
> +               if (path->buf[orig_path_len - 1] !=3D '/')

Minor: I don't know how others feel about it, but I always find it a
bit disturbing to see a potential negative array access without a
safety check that orig_path_len is not 0, either directly in the
conditional or as a documenting assert().

> +                       strbuf_addch(path, '/');
> +               strbuf_addstr(path, ".git");
> +               if (is_git_directory(path->buf))
> +                       ret =3D 1;
> +               strbuf_setlen(path, orig_path_len);
> +       }
> +
> +       return ret;
> +}
> +
>  static int remove_dirs(struct strbuf *path, const char *prefix, int =
force_flag,
>                 int dry_run, int quiet, int *dir_gone)
>  {
