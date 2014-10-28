From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 18/19] update-index: test the system before enabling
 untracked cache
Date: Tue, 28 Oct 2014 19:25:19 -0400
Message-ID: <CAPig+cS9C9m-wqMO3up+BRHBN1a0FB-eDO7UUPv7NLx1JCC3PQ@mail.gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
	<1414411846-4450-19-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 00:25:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjG8i-0003ui-Vn
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 00:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223AbaJ1XZV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Oct 2014 19:25:21 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:53963 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbaJ1XZU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Oct 2014 19:25:20 -0400
Received: by mail-yh0-f45.google.com with SMTP id f73so73436yha.18
        for <git@vger.kernel.org>; Tue, 28 Oct 2014 16:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=nihkU17Xq0h6TmAmWc+8dlKxwtn7XepQkS+cIHhLBMg=;
        b=pHyZxNoscQO8C5ciEMTFsa9QsIRdiEccDyvRYabx5d5xgNg+uK20d5YdSLQatS5EoD
         CjueUC1ISF62nBWV5q2YY6nZ2gcCMPvjMlepSByzKMQ73cRO2zRV7R+B+XbnxZL3JjJp
         TB0hBkWVFTgpGJvF7SR7VE1pA89F7uhl0RPiETdZazIHUXG9SjoFi73pdqXUqSAiziV2
         USk7nJmIbir7UlzuBOxg5OV5bjr53S1DFjebttTUxb4gj8xGALGGvl1al2gOcCnRK1dK
         1FqUy8b7f6QKu8j6VFedsPjAvCItsxTkP5ZmhbmCh53oV+xvY+80dPonSUf6FkC0v4VH
         bt8g==
X-Received: by 10.170.128.145 with SMTP id u139mr6956712ykb.51.1414538719897;
 Tue, 28 Oct 2014 16:25:19 -0700 (PDT)
Received: by 10.170.68.68 with HTTP; Tue, 28 Oct 2014 16:25:19 -0700 (PDT)
In-Reply-To: <1414411846-4450-19-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: z7MV9Io_rUam8Ant3xnpks_BV6s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 27, 2014 at 8:10 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index e57e2d7..471c0b4 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -48,6 +48,145 @@ static void report(const char *fmt, ...)
>         va_end(vp);
>  }
>
> +static int test_if_untracked_cache_is_supported(void)
> +{
> +       struct stat st;
> +       struct stat_data base;
> +       int fd;
> +
> +       fprintf(stderr, _("Testing "));
> +       xmkdir("dir-mtime-test");
> +       atexit(remove_test_directory);
> +       xstat("dir-mtime-test", &st);
> +       fill_stat_data(&base, &st);
> +       fputc('.', stderr);
> +
> +       avoid_racy();
> +       fd =3D create_file("dir-mtime-test/newfile");
> +       xstat("dir-mtime-test", &st);
> +       if (!match_stat_data(&base, &st)) {

close(fd);

> +               fputc('\n', stderr);
> +               fprintf_ln(stderr,_("directory stat info does not "
> +                                   "change after adding a new file")=
);
> +               return 0;
> +       }
> +       fill_stat_data(&base, &st);
> +       fputc('.', stderr);
> +
> +       avoid_racy();
> +       xmkdir("dir-mtime-test/new-dir");
> +       xstat("dir-mtime-test", &st);
> +       if (!match_stat_data(&base, &st)) {

close(fd);

> +               fputc('\n', stderr);
> +               fprintf_ln(stderr, _("directory stat info does not ch=
ange "
> +                                    "after adding a new directory"))=
;
> +               return 0;
> +       }
> +       fill_stat_data(&base, &st);
> +       fputc('.', stderr);
> +
> +       avoid_racy();
> +       write_or_die(fd, "data", 4);
> +       close(fd);
> +       xstat("dir-mtime-test", &st);
> +       if (match_stat_data(&base, &st)) {
> +               fputc('\n', stderr);
> +               fprintf_ln(stderr, _("directory stat info changes "
> +                                    "after updating a file"));
> +               return 0;
> +       }
> +       fputc('.', stderr);
> +
> +       avoid_racy();
> +       close(create_file("dir-mtime-test/new-dir/new"));
> +       xstat("dir-mtime-test", &st);
> +       if (match_stat_data(&base, &st)) {
> +               fputc('\n', stderr);
> +               fprintf_ln(stderr, _("directory stat info changes aft=
er "
> +                                    "adding a file inside subdirecto=
ry"));
> +               return 0;
> +       }
> +       fputc('.', stderr);
> +
> +       avoid_racy();
> +       xunlink("dir-mtime-test/newfile");
> +       xstat("dir-mtime-test", &st);
> +       if (!match_stat_data(&base, &st)) {
> +               fputc('\n', stderr);
> +               fprintf_ln(stderr, _("directory stat info does not "
> +                                    "change after deleting a file"))=
;
> +               return 0;
> +       }
> +       fill_stat_data(&base, &st);
> +       fputc('.', stderr);
> +
> +       avoid_racy();
> +       xunlink("dir-mtime-test/new-dir/new");
> +       xrmdir("dir-mtime-test/new-dir");
> +       xstat("dir-mtime-test", &st);
> +       if (!match_stat_data(&base, &st)) {
> +               fputc('\n', stderr);
> +               fprintf_ln(stderr, _("directory stat info does not "
> +                                    "change after deleting a directo=
ry"));
> +               return 0;
> +       }
> +
> +       xrmdir("dir-mtime-test");
> +       fprintf_ln(stderr, _(" OK"));
> +       return 1;
> +}
