From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/4] strbuf.c: keep errno in strbuf_read_file()
Date: Fri, 25 Jul 2014 11:41:53 -0400
Message-ID: <CAPig+cS4CV+1nsab2yZCYbYsRfKJoE60Gh5KxjE-0qE-3ZuRtQ@mail.gmail.com>
References: <1406285039-22469-1-git-send-email-pclouds@gmail.com>
	<1406285039-22469-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 17:42:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAhdm-0001Th-Ll
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 17:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417AbaGYPlz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2014 11:41:55 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:50184 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239AbaGYPly convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jul 2014 11:41:54 -0400
Received: by mail-yh0-f53.google.com with SMTP id c41so3039112yho.12
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 08:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=er+idfYJzA+P/LfgjB7tpFkCVrELNmu9OAdXc4Hm+cA=;
        b=F82niCsLkWvw0mtbqeewhokgfXlkG02HBM0u93N/xJCNuXKHdD7Uvyjw5DxK8ilrRb
         nZ6NYvygCT7A2jdMW7UjUq3vkP3TojtxjwsKsNyMjVpEsqwfdAEF9WhZZr8nm/ZeXe92
         4Eu+WadQF1lT5W2J6SDBJithvp+7L99yEFXL7+Wm/NsAIrS1o9C/66QuwiLyvC9aqS1I
         IyS0a5k3uxvz1oLP2F6d3NXEII3zrpvqoLCJHXTb6opsavO821tBgGIb90YFG3edMlMZ
         7UDvJ55cqHnm4OGXlWakooLTctZrwp1MB/R+WatoNLobBZ2O83kJQavS6v/r6S23YLFd
         Dknw==
X-Received: by 10.236.112.167 with SMTP id y27mr23440982yhg.60.1406302913575;
 Fri, 25 Jul 2014 08:41:53 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Fri, 25 Jul 2014 08:41:53 -0700 (PDT)
In-Reply-To: <1406285039-22469-2-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 7HL1lpjpHpj1q5aJJIzw_xq143M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254228>

On Fri, Jul 25, 2014 at 6:43 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> This function is used to replaced some code in the next patch that

s/replaced/replace/

> does this (i.e. keep the errno when read() fails)
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  strbuf.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/strbuf.c b/strbuf.c
> index 33018d8..61d685d 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -454,15 +454,18 @@ int strbuf_getwholeline_fd(struct strbuf *sb, i=
nt fd, int term)
>
>  int strbuf_read_file(struct strbuf *sb, const char *path, size_t hin=
t)
>  {
> -       int fd, len;
> +       int fd, len, saved_errno;
>
>         fd =3D open(path, O_RDONLY);
>         if (fd < 0)
>                 return -1;
>         len =3D strbuf_read(sb, fd, hint);
> +       saved_errno =3D errno;
>         close(fd);
> -       if (len < 0)
> +       if (len < 0) {
> +               errno =3D saved_errno;
>                 return -1;
> +       }
>
>         return len;
>  }
> --
> 1.9.1.346.ga2b5940
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
