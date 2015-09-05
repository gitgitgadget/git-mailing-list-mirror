From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] git_connect: clear GIT_* environment for ssh
Date: Sat, 5 Sep 2015 15:50:08 +0200
Message-ID: <CAOxFTcz9dZRQVnVnt+GtzAiu+GBi7CPE17d7rGo3H0v56MMAZQ@mail.gmail.com>
References: <CAOxFTcx9E_FtYD_Jn3+S3j-rwGO+hJSVXUC2S5ZBB6der7dUuw@mail.gmail.com>
 <20150904125448.GA25501@sigill.intra.peff.net> <xmqqpp1yf3qe.fsf@gitster.mtv.corp.google.com>
 <20150904214454.GA18320@sigill.intra.peff.net> <20150904224008.GA11164@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 05 15:50:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYDrX-0001J8-8v
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 15:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbbIENuc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Sep 2015 09:50:32 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34681 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612AbbIENua convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Sep 2015 09:50:30 -0400
Received: by wicfx3 with SMTP id fx3so47014007wic.1
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 06:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=IA1XskZLQ4thaWlbePILmfIcxOkpuR1QWROaxb2cNIc=;
        b=yBm8DkWGn/QeYZt9GzgpJD14iykCRU3sf8VzY/oK7NKAH/o+I8dcj31QERa6C6EyIj
         AseyIEcZIaeqhm+NZJhQAvY9bHV635PGAf9Bns7IIMAO0m/WEcI8AF8HJcLW4FceWjzr
         TztfisFj8PktFJbmY5jR0Zf4iJidhEdLbLMcpbkWbjwaN0syWBs3KlsH4Fimbq9tWbym
         W71n6vZ7JfkXwSUpwcGcDX08buKXmpJxpdsFEfdZkLrKzMB7Lv1Vj/JO7+l7SdXqlM08
         DTksUGN4JIV9qGZV78KJJ55KEjFh5n534Q/LPII5/k4VX9l0u6H7HJk1VUnFtRNcHUeq
         3/eg==
X-Received: by 10.194.110.132 with SMTP id ia4mr17779425wjb.103.1441461028305;
 Sat, 05 Sep 2015 06:50:28 -0700 (PDT)
Received: by 10.194.101.100 with HTTP; Sat, 5 Sep 2015 06:50:08 -0700 (PDT)
In-Reply-To: <20150904224008.GA11164@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277379>

On Sat, Sep 5, 2015 at 12:40 AM, Jeff King <peff@peff.net> wrote:
> So here is the patch I would propose. I'm fairly certain it will solv=
e
> Giuseppe's problem, though I think there is something else odd going =
on
> here that I don't understand. I'm worried that we're papering over
> another regression. Giuseppe, if you can still find time to do that
> bisect, it would be helpful.

So, as it happens I was able to script the check in a
not-too-convoluted way using the same pair of machines where I came
across the problem,, and it turns out that the culprit is as obvious
as one would expect:

d95138e695d99d32dcad528a2a7974f434c51e79 is the first bad commit
commit d95138e695d99d32dcad528a2a7974f434c51e79
Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Date:   Fri Jun 26 17:37:35 2015 +0700

    setup: set env $GIT_WORK_TREE when work tree is set, like $GIT_DIR

which matches my previous findings in that the problem was
GIT_WORK_TREE being leaked. Since setting GIT_WORK_TREE when setting
GIT_DIR is correct, the solution is indeed to clear GIT_* environment
variables for ssh, as you propose. I tested your patch and indeed it
fixes my problem.

I still don't understand why you cannot replicate the issue on your
side. One thing that is _extremely_ important in reproducing the
problem is that the leaked GIT_WORK_TREE point to a non-existent (or
otherwise inaccessible) directory in the server machine. For example,
on my first attempt to reproduce I was trying to use my clone of the
git repo, and it wouldn't work because I _did_ have a ~/src/git on
both machines, even though I was pushing to a
remote.machine:/tmp/test.git

Would it be worth looking at the issue server-side too, as this looks
like something that might have exploit potential? (At the very least,
it could be used to test if/which directories the remote user has
access to.)

> -- >8 --
> Subject: git_connect: clear GIT_* environment for ssh
>
> When we "switch" to another local repository to run the server
> side of a fetch or push, we must clear the variables in
> local_repo_env so that our local $GIT_DIR, etc, do not
> pollute the upload-pack or receive-pack that is executing in
> the "remote" repository.

I think we might want to mention GIT_WORK_TREE explicitly here, since
this seems to be the one causing issues.

> We have never done so for ssh connections. For the most
> part, nobody has noticed because ssh will not pass unknown
> environment variables by default. However, it is not out of
> the question for a user to configure ssh to pass along GIT_*
> variables using SendEnv/AcceptEnv.
>
> We can demonstrate the problem by using "git -c" on a local
> command and seeing its impact on a remote repository.  This
> config ends up in $GIT_CONFIG_PARAMETERS. In the local case,
> the config has no impact, but in the ssh transport, it does
> (our test script has a fake ssh that passes through all
> environment variables; this isn't normal, but does simulate
> one possible setup).
>
> Signed-off-by: Jeff King <peff@peff.net>

The patch works for me, so aside from the suggested commit message
change, I'm all for it.

Reviewed-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

> ---
>  connect.c                     |  4 ++--
>  t/t5507-remote-environment.sh | 34 +++++++++++++++++++++++++++++++++=
+
>  2 files changed, 36 insertions(+), 2 deletions(-)
>  create mode 100755 t/t5507-remote-environment.sh
>
> diff --git a/connect.c b/connect.c
> index c0144d8..962f990 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -721,6 +721,8 @@ struct child_process *git_connect(int fd[2], cons=
t char *url,
>                 strbuf_addch(&cmd, ' ');
>                 sq_quote_buf(&cmd, path);
>
> +               /* remove repo-local variables from the environment *=
/
> +               conn->env =3D local_repo_env;

A posteriori, this makes a lot of sense too: why single out a single
protocol in the environment cleanup?

>                 conn->in =3D conn->out =3D -1;
>                 if (protocol =3D=3D PROTO_SSH) {
>                         const char *ssh;
> @@ -778,8 +780,6 @@ struct child_process *git_connect(int fd[2], cons=
t char *url,
>                         }
>                         argv_array_push(&conn->args, ssh_host);
>                 } else {
> -                       /* remove repo-local variables from the envir=
onment */
> -                       conn->env =3D local_repo_env;
>                         conn->use_shell =3D 1;

Of course we're now left with just conn->use_shell =3D 1 in the non-ssh
case. This could be moved in front of the if, and replaced with
something like conn>use_shell =3D !(procol =3D=3D PROTO_SSH), but maybe=
 this
would kill legibility. It's just  that a single line i the else clause
of a large if looks odd.


--=20
Giuseppe "Oblomov" Bilotta
