From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/6] t5000: factor out check_tar
Date: Mon, 20 May 2013 15:54:36 -0400
Message-ID: <CAPig+cSPV08=LcQ4vziE5+HmN3LtBVp7F4mb83--Mub_e2A7qw@mail.gmail.com>
References: <1369043909-59207-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
	<1369043909-59207-4-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon May 20 21:54:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeWAM-0000xa-58
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 21:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757967Ab3ETTyi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 May 2013 15:54:38 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:43018 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756899Ab3ETTyh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 May 2013 15:54:37 -0400
Received: by mail-la0-f41.google.com with SMTP id ee20so5453061lab.28
        for <git@vger.kernel.org>; Mon, 20 May 2013 12:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W7E9PB2N8cjkfAYFkrDhdHG5gmnaGdqiz1TFjNTiJkU=;
        b=KmD4DruE1k9aEyx3Jtnz1S6PrLQ1IBpLIjitz8pHtFEmTTxSqClJ7rp4Zg7/e+vybZ
         qIAUcbs9gxRrVZ48Dj/bzm5BjLJdSe8pO079BhfnXIP+WVqUrGvPqoSAaqWCJmstXatq
         +MuCJ4Pa6oriFjwrjkGPNpG4gbdl07+iRD/YTX8oPPHmaFF6fSp3uJ+J9XhCeY/PYIdD
         dC3Cwvl5QpwjXXW2j+EqZaQolt8/4Ylpd0/CwzzYmIIqevUPMQutJfr7mvNcBi2kwFt+
         MI0bzz4AGyQAdTV0qpZymYV1girJz+25jxxelKjrBAVpYpGBmJbgZTxq+AxHhNZKHZoc
         MnSw==
X-Received: by 10.152.2.233 with SMTP id 9mr12478457lax.34.1369079676203; Mon,
 20 May 2013 12:54:36 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Mon, 20 May 2013 12:54:36 -0700 (PDT)
In-Reply-To: <1369043909-59207-4-git-send-email-rene.scharfe@lsrfire.ath.cx>
X-Google-Sender-Auth: dhfZCG-cQl9zmK_tJsDhx21kVc4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224976>

On Mon, May 20, 2013 at 5:58 AM, Ren=E9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Create a helper function that extracts a tar archive and checks its
> contents, modelled after check_zip in t5003.
>
> Signed-off-by: Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---
>  t/t5000-tar-tree.sh | 35 ++++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 13 deletions(-)
>
> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index 41cd609..8337a1f 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -30,6 +30,26 @@ GUNZIP=3D${GUNZIP:-gzip -d}
>
>  SUBSTFORMAT=3D%H%n
>
> +check_tar() {
> +       tarfile=3D$1.tar
> +       listfile=3D$1.lst
> +       dir=3D$1
> +       dir_with_prefix=3D$dir/$2
> +
> +       test_expect_success ' extract tar archive' '

s/' extract/'extract/

> +               (mkdir $dir && cd $dir && "$TAR" xf -) <$tarfile
> +       '
> +
> +       test_expect_success ' validate filenames' '

s/' validate/'validate/

> +               (cd ${dir_with_prefix}a && find .) | sort >$listfile =
&&
> +               test_cmp a.lst $listfile
> +       '
> +
> +       test_expect_success ' validate file contents' '

s/' validate/'validate/

> +               diff -r a ${dir_with_prefix}a
> +       '
> +}
> +
>  test_expect_success \
>      'populate workdir' \
>      'mkdir a &&
> @@ -81,6 +101,8 @@ test_expect_success \
>      'git archive' \
>      'git archive HEAD >b.tar'
>
> +check_tar b
> +
>  test_expect_success \
>      'git tar-tree' \
>      'git tar-tree HEAD >b2.tar'
> @@ -125,19 +147,6 @@ test_expect_success \
>       test_cmp .git/$(git symbolic-ref HEAD) b.commitid'
>
>  test_expect_success \
> -    'extract tar archive' \
> -    '(mkdir b && cd b && "$TAR" xf -) <b.tar'
> -
> -test_expect_success \
> -    'validate filenames' \
> -    '(cd b/a && find .) | sort >b.lst &&
> -     test_cmp a.lst b.lst'
> -
> -test_expect_success \
> -    'validate file contents' \
> -    'diff -r a b/a'
> -
> -test_expect_success \
>      'git tar-tree with prefix' \
>      'git tar-tree HEAD prefix >c.tar'
>
> --
> 1.8.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
