From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] path_treatment: also ignore $GIT_DIR if it's not .git
Date: Mon, 2 Dec 2013 06:02:32 +0700
Message-ID: <CACsJy8CxR+wj-P+fxF37DU=Tzk=su+V=UudbO7NkqTMS8qTn_w@mail.gmail.com>
References: <1385922611.3240.6.camel@localhost> <20131201190447.GA31367@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, ingy@ingy.net
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Mon Dec 02 00:03:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnG2e-0005Cf-L5
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 00:03:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986Ab3LAXDF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Dec 2013 18:03:05 -0500
Received: from mail-qe0-f49.google.com ([209.85.128.49]:62314 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894Ab3LAXDD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Dec 2013 18:03:03 -0500
Received: by mail-qe0-f49.google.com with SMTP id w7so12327822qeb.22
        for <git@vger.kernel.org>; Sun, 01 Dec 2013 15:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=VKqXDAWJo7puMwaMbUqggCw/A0LGNqhYCsb0UfB90DI=;
        b=0fvGOrhKgZ4dUokOsm0H8RVEib7DdJi9W2GSCrqyJDMjEtTS24owIqL4W288nQK6Qs
         az7LfRr2kWa5xG//Y8XgGXxxH2UEqpZFl6uKxs5UEsxw9fgtalgBPZGHE36z5qtdI2kY
         SKcXn2yyVdzSFGq+XhgwCvsPpCBdw2fNgCObWkDx9WEqQ43Ifw240dlEKqni+3oxg4iz
         a2MQuTjGHIO707L7ej9h26T1YeckemBPECidFzcP8osdAxnLWoVWH4W3Rw7MOAvqeNaq
         rTVqZbXZgOiE+2NY0xuPlJ65+yIkP+9IBdsRjzeld4oxsdm5NHM83MVeHo7eIOCOCVYU
         Ggaw==
X-Received: by 10.49.39.165 with SMTP id q5mr28374197qek.48.1385938982190;
 Sun, 01 Dec 2013 15:03:02 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Sun, 1 Dec 2013 15:02:32 -0800 (PST)
In-Reply-To: <20131201190447.GA31367@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238602>

On Mon, Dec 2, 2013 at 2:04 AM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> We always ignore anything named .git, but we should also ignore the g=
it
> directory if the user overrides it by setting $GIT_DIR
>
> Reported-By: Ingy d=C3=B6t Net <ingy@ingy.net>
> Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
> ---
>  dir.c             | 2 +-
>  t/t7508-status.sh | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/dir.c b/dir.c
> index 23b6de4..884b37d 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1198,7 +1198,7 @@ static enum path_treatment treat_path(struct di=
r_struct *dir,
>                 return path_none;
>         strbuf_setlen(path, baselen);
>         strbuf_addstr(path, de->d_name);
> -       if (simplify_away(path->buf, path->len, simplify))
> +       if (simplify_away(path->buf, path->len, simplify) || is_git_d=
irectory(path->buf))
>                 return path_none;

this adds 2 access, 1 lstat, 1 open, 1 read, 1 close to _every_ path
we check. Is it worth the cost?


>
>         dtype =3D DTYPE(de);
> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
> index c987b5e..2bd7ef1 100755
> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh
> @@ -198,6 +198,13 @@ test_expect_success 'status -s' '
>
>  '
>
> +test_expect_success 'status -s with non-standard $GIT_DIR' '
> +       mv .git .foo &&
> +       GIT_DIR=3D.foo git status -s >output &&
> +       test_cmp expect output &&
> +       mv .foo .git
> +'
> +
>  test_expect_success 'status with gitignore' '
>         {
>                 echo ".gitignore" &&
> --
> 1.8.5-386-gb78cb96
>
>
> --
> Dennis Kaarsemaker <dennis@kaarsemaker.net>
> http://twitter.com/seveas
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Duy
