From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 07/25] list-files: add tag to each entry, filter duplicate tags
Date: Mon, 6 Apr 2015 17:32:48 -0400
Message-ID: <CAPig+cS=41Y+c-vz7h8=jWEw_9ZKWT4JJ-boERCMyRzq=x_p+g@mail.gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
	<1428328354-14897-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	1425896314-10941-1-git-send-email-pclouds@gmail.com
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 23:32:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfEdb-0004XS-1c
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 23:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851AbbDFVcu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 17:32:50 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33897 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbbDFVcu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2015 17:32:50 -0400
Received: by lboc7 with SMTP id c7so28782088lbo.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 14:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=w8lxEHzeVXtSc0Rjlz3Yd12WHno4U2C8vwdyQXZJiXg=;
        b=WI+CVq3C/1y7dmOirc+QzLlqkdWnC5wFmXCpIGtGS2wHiUSzAdbAhGb+bhGAyioI+A
         hQ3T/25h13msxDAwqUtaHKs+HpvtLd5n+PLZL6DU1BeJbfg0WArwTP5ddBAmbE4ybmyS
         m+FRlX1B1rQzxkFSQZZBDpGdQ1dzcawBGOOB+O4O+4YBbJ0H7+xg4Bi0bpOWd+25FLu4
         /VxncDLNFlCtcmCv7XcAjDZfzDclxorQQpNkiiVNDgfRpc+CrwXzRPO2ZlCWnxxDeDgz
         XaAba+WHH6BYsMuSBePHKSJ3lsESxuqS1V6YyubLfJuuDhPMdkzmcbGeUplJpf04OgBc
         +KPw==
X-Received: by 10.112.171.65 with SMTP id as1mr15245362lbc.45.1428355968840;
 Mon, 06 Apr 2015 14:32:48 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Mon, 6 Apr 2015 14:32:48 -0700 (PDT)
In-Reply-To: <1428328354-14897-8-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 5yrw_q0Zvm3ZJBR7Mo8uC6-LopA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266881>

On Mon, Apr 6, 2015 at 9:52 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> All entries have a two-letter tag. If all entries have the same tags,
> tags are not displayed.
>
> The outcome before and after this patch is the same. But it will be
> useful in future when there are more than one type of entry.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/builtin/list-files.c b/builtin/list-files.c
> index 51ff19d..ec9ca17 100644
> --- a/builtin/list-files.c
> +++ b/builtin/list-files.c
> @@ -52,10 +56,61 @@ static void populate_cached_entries(struct item_l=
ist *result,
> +static void cleanup_tags(struct item_list *result)
> +{
> +       int i, same_1 =3D 1, same_2 =3D 1;
> +
> +       if (!show_tag) {
> +               result->tag_pos =3D 0;
> +               result->tag_len =3D 0;
> +               return;
> +       }
> [...]
> +}
> +
> +/* this is similar to quote_path_relative() except it does not clear=
 sb */

This comment is a bit confusing since it talks about 'sb', which is a
local variable, rather than the intended 'out'. Perhaps rephrase:

    /* similar to quote_path_relative() but does not clear 'out' */

> +static void quote_item(struct strbuf *out, const struct item *item)
> +{
> +       static struct strbuf sb =3D STRBUF_INIT;
> +       const char *rel;
> +
> +       strbuf_reset(&sb);
> +       rel =3D relative_path(item->path, prefix, &sb);
> +       quote_c_style(rel, out, NULL, 0);
> +}
> +
>  static void display(const struct item_list *result)
>  {
>         struct strbuf quoted =3D STRBUF_INIT;
