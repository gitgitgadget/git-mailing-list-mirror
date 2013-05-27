From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v2] commit: don't use-editor when allow-empty-message
Date: Mon, 27 May 2013 16:53:01 +0200
Message-ID: <CALWbr2zW7BKwkNd5gU8vyE8KvMkzUMf1zTOr5X0cxsO7_4KA=Q@mail.gmail.com>
References: <1369663431-2405-1-git-send-email-artagnon@gmail.com>
	<1369664419-16440-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Mislav_Marohni=C4=87?= <mislav.marohnic@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 27 16:53:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgynY-0006EI-RR
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 16:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758131Ab3E0OxE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 May 2013 10:53:04 -0400
Received: from mail-qe0-f50.google.com ([209.85.128.50]:34466 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756230Ab3E0OxD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 May 2013 10:53:03 -0400
Received: by mail-qe0-f50.google.com with SMTP id x7so3731528qeu.23
        for <git@vger.kernel.org>; Mon, 27 May 2013 07:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=fHI3gvSnCHmsgwvZ9H0gBzh3PdrRD2iqQo24Q4JIPUQ=;
        b=vbj5cbf73J+8XRtL5Z56QcmOQoZbfMHLdPszHLSoz9Jt85HH3g2M6fuKrbScyFN+4Z
         I1lP0B9DxQF9wxRb3CwSuOp97JhGmbDtOdFTeloathePqQom7xPySwi00abL0P2POeEk
         wrscGmFSx0uQk09IiCiFFRAwnma/sc5M3iPsmFfDjA5WrGrAmA3Ow2Ywfu2arNbCqza5
         sclZh6P5g12bQRhFcXvwuJdwK2UlrW3CIxRhCI47OC+6RNOrVqQVlGbqFc3hlnr3YceO
         edP9i8oVox6U+8bgbvaMKPfAmtygaPPBwDc1eFnfpmNpKzMF+vnQPB/87eLtxK/G9VbQ
         UNiQ==
X-Received: by 10.224.68.10 with SMTP id t10mr18448443qai.24.1369666382032;
 Mon, 27 May 2013 07:53:02 -0700 (PDT)
Received: by 10.49.81.99 with HTTP; Mon, 27 May 2013 07:53:01 -0700 (PDT)
In-Reply-To: <1369664419-16440-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225595>

So now we have two fixes for the same issue, don't we ?
You probably missed $gmane/225534.

On Mon, May 27, 2013 at 4:20 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Commit a24a41e (git-commit: only append a newline to -m mesg if
> necessary, 2013-02-18) introduced a regression: when
> --allow-empty-message is used and an empty message is explicitly
> specified with -m "", git commit still launches $EDITOR unnecessarily=
=2E
> The commit (correctly) fixes opt_parse_m() to not fill in two newline=
s
> into the message buffer unconditionally.  The real problem is that
> launching $EDITOR only depends on use_editor and whether message is
> empty.  Fix the problem by setting explicit_message in the codepath
> where an explicit string is passed via -m, and then checking it befor=
e
> launching $EDITOR.
>
> Reported-by: Mislav Marohni=C4=87 <mislav.marohnic@gmail.com>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Works?
>
>  builtin/commit.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index d2f30d9..7d72ba7 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -108,6 +108,7 @@ static const char *cleanup_arg;
>  static enum commit_whence whence;
>  static int use_editor =3D 1, include_status =3D 1;
>  static int show_ignored_in_status;
> +static int explicit_message =3D 0;
>  static const char *only_include_assumed;
>  static struct strbuf message =3D STRBUF_INIT;
>
> @@ -128,6 +129,7 @@ static int opt_parse_m(const struct option *opt, =
const char *arg, int unset)
>                         strbuf_addch(buf, '\n');
>                 strbuf_addstr(buf, arg);
>                 strbuf_complete_line(buf);
> +               explicit_message =3D 1;
>         }
>         return 0;
>  }
> @@ -824,7 +826,7 @@ static int prepare_to_commit(const char *index_fi=
le, const char *prefix,
>                      git_path(commit_editmsg), hook_arg1, hook_arg2, =
NULL))
>                 return 0;
>
> -       if (use_editor) {
> +       if (use_editor && !explicit_message) {
>                 char index[PATH_MAX];
>                 const char *env[2] =3D { NULL };
>                 env[0] =3D  index;
> --
> 1.8.3.1.g33669de.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
