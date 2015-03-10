From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 07/16] list-files: show directories as well as files
Date: Tue, 10 Mar 2015 02:23:48 -0400
Message-ID: <CAPig+cSCTJH-otgWAQxwjwkw0SbP4OFXyDhUZs=0bzoL7B32ig@mail.gmail.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
	<1425896314-10941-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"git@drmicha.warpmail.net" <git@drmicha.warpmail.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 07:23:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVDa6-0001tl-IX
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 07:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbbCJGXt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2015 02:23:49 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:34434 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbbCJGXs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2015 02:23:48 -0400
Received: by ykr200 with SMTP id 200so11281206ykr.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 23:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=eLznS6DXuxrCzHMxdbnxZ7KJyi4VQLj8blgUidz+Y7c=;
        b=I53IdmhEyl7beDegpYNoNejJSRYu+vOQHrRAW5TNxS6Gnt4NuSMlnSyc/FLEt4a2ja
         8d1WRpxq4CahU7ZBRH1POrbJ4K5hT90dklj7+dJ7nXmFZXRKPC8QO7kGI8D+TAb557He
         QyYaEoFo8Reid75qicvj6tHWLluD5cozToDGaa9isxtUywrfdwYjIXLI2YT8Ws3+7EUk
         8Lk/T5vLOgQTsN8CMZol69M7pLQcL3nSZc+tXzNTzoKVgq8TDW0kp0MWCfRT2BhjsDMi
         P2eOiOSx8FLNJid6q+DDmOcBeMCarAu9U2VJJ23UYwc1/IQrOSA3oc0KoJ4ObE/T070h
         D6cg==
X-Received: by 10.236.63.6 with SMTP id z6mr30596461yhc.65.1425968628274; Mon,
 09 Mar 2015 23:23:48 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Mon, 9 Mar 2015 23:23:48 -0700 (PDT)
In-Reply-To: <1425896314-10941-8-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: s4elvC_MKxQAJyK7nwemRiI1p54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265210>

On Monday, March 9, 2015, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pc=
louds@gmail.com> wrote:
> The index does not store directories explicitly (except submodules) s=
o
> we have to figure them out from file list when output lis depth-limit=
ed.

s/lis/is/

> The function add_directory() can generate duplicate entries, which is
> cleaned up before displaying.
> ---
> diff --git a/builtin/list-files.c b/builtin/list-files.c
> index 9a55ea6..dc865a1 100644
> --- a/builtin/list-files.c
> +++ b/builtin/list-files.c
> @@ -43,6 +45,51 @@ static void add_one(struct string_list *result, co=
nst char *name,
>         item->util =3D (char *)name;
>  }
>
> +static int add_directory(struct string_list *result,
> +                        const char *name)
> +{
> +       struct strbuf sb =3D STRBUF_INIT;
> +       const char *p;
> +
> +       strbuf_add(&sb, name, strlen(name));

strbuf_addstr() perhaps?

> +       while (sb.len && (p =3D strrchr(sb.buf, '/')) !=3D NULL) {
> +               strbuf_setlen(&sb, p - sb.buf);
> +               if (!match_pathspec(&pathspec, sb.buf, sb.len, 0, NUL=
L, 1))
> +                       continue;
> +               add_one(result, sb.buf, "  ");
> +               /*
> +                * sb.buf is leaked, but because this command is
> +                * short-lived anyway so it does not matter much
> +                */
> +               return 1;
> +       }
> +       strbuf_release(&sb);
> +       return 0;
> +}
