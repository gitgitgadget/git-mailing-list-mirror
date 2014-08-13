From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/6] sha1_file.c: do not die failing to malloc in unpack_compressed_entry
Date: Wed, 13 Aug 2014 14:13:39 -0700
Message-ID: <CAPc5daX3WNsSQ1epor+K7T8ePjhthGdTivecaD9GeeDnQRJCAg@mail.gmail.com>
References: <1403610336-27761-1-git-send-email-pclouds@gmail.com>
 <1407927454-9268-1-git-send-email-pclouds@gmail.com> <1407927454-9268-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	"Dale R. Worley" <worley@alum.mit.edu>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 23:14:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHfs0-0008H5-3H
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 23:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679AbaHMVOD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Aug 2014 17:14:03 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64907 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412AbaHMVOB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Aug 2014 17:14:01 -0400
Received: by mail-lb0-f174.google.com with SMTP id c11so267774lbj.33
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 14:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=CjAtIlNnk9zSMyfJLPoCUx7NWGIbTA+VPbMcuHbFlAE=;
        b=ntbeTey2xA+4qE+DuRlqkf4v6EkNP4CAzHj/4ss1dNgdTB4IJ9jeTOfa5bwTYRSL21
         WeJClF5EwCHdcdy0STakKT50OlyYf4XxWWlOKAosVDMFVbRDJEDAGDxYR45NO0GgZLZP
         q7AWPgb4AKTmJQWJrFYF/l9gjjCC+SO6o5AxAsJueWtRXru1SfsIstSrFK842BjgHt1q
         zJ5clNZk+GUbDNLhL0rOH7RqjmaxcXmc5+dfWjtH5iI7DohciXXKMefhNUDSbHKssW6Y
         b3i/qhl+fcRDk3gusFCG/3o85PMBuvu/WdJxIJdfugRtIbB6ibZer1aBqy1z6+YgcG++
         KJdg==
X-Received: by 10.112.160.38 with SMTP id xh6mr509035lbb.21.1407964440045;
 Wed, 13 Aug 2014 14:14:00 -0700 (PDT)
Received: by 10.112.199.74 with HTTP; Wed, 13 Aug 2014 14:13:39 -0700 (PDT)
In-Reply-To: <1407927454-9268-3-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: i_WmgbsrURrcm96bYc0ud5CBDEM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255252>

Looks very sensible. Thanks.

On Wed, Aug 13, 2014 at 3:57 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Fewer die() gives better control to the caller, provided that the
> caller _can_ handle it. And in unpack_compressed_entry() case, it can=
,
> because unpack_compressed_entry() already returns NULL if it fails to
> inflate data.
>
> A side effect from this is fsck continues to run when very large blob=
s
> are present (and do not fit in memory).
>
> Noticed-by: Dale R. Worley <worley@alum.mit.edu>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  sha1_file.c      | 4 +++-
>  t/t1050-large.sh | 6 ++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 3f70b1d..330862b 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1923,7 +1923,9 @@ static void *unpack_compressed_entry(struct pac=
ked_git *p,
>         git_zstream stream;
>         unsigned char *buffer, *in;
>
> -       buffer =3D xmallocz(size);
> +       buffer =3D xmallocz_gentle(size);
> +       if (!buffer)
> +               return NULL;
>         memset(&stream, 0, sizeof(stream));
>         stream.next_out =3D buffer;
>         stream.avail_out =3D size + 1;
> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
> index aea4936..5642f84 100755
> --- a/t/t1050-large.sh
> +++ b/t/t1050-large.sh
> @@ -163,4 +163,10 @@ test_expect_success 'zip achiving, deflate' '
>         git archive --format=3Dzip HEAD >/dev/null
>  '
>
> +test_expect_success 'fsck' '
> +       test_must_fail git fsck 2>err &&
> +       n=3D$(grep "error: attempting to allocate .* over limit" err =
| wc -l) &&
> +       test "$n" -gt 1
> +'
> +
>  test_done
> --
> 2.1.0.rc0.78.gc0d8480
>
