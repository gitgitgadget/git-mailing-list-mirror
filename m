From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 03/28] clone: prevent --reference to a shallow repository
Date: Tue, 26 Nov 2013 00:52:14 -0500
Message-ID: <CAPig+cRVXvBwWDC2Rp8M9hDCKexCJCEGeKLOa__aMX3q9X8S1w@mail.gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
	<1385351754-9954-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 26 06:52:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlBZM-0008HR-BN
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 06:52:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983Ab3KZFwQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Nov 2013 00:52:16 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:54005 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692Ab3KZFwP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Nov 2013 00:52:15 -0500
Received: by mail-lb0-f178.google.com with SMTP id c11so4116442lbj.9
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 21:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=05rw01zZ1nnZjaS1ctK7KTedrbx73HOIzNnbob9uwFc=;
        b=ze1IlNmNkcOlh0BwCSC4mrOYImho1qeQaXZJjBa4EDgGG8/yp3iKQamIAW+AFzDj/O
         snx21JUtsi4wJWn1/+zcOV6bQxQCwoxUWnDokvMf36tWHJv7HrXLFmCT1zqDM4Pmri36
         uioJizFOiCNcP7Qlc4PtVq4kzjbvlnyddqr8df9QgNGulVqEF4jegubJ9ErTCyoohIsl
         x//w+wX6pWqoQKETpyyC+i9AQOBv2YKBxyoyPeZdccfyeziFEEDf3+TSu9gwWofyuCDv
         sfzJnfAn/kX6t+SQLwvN/mkwsEsJLs6FVMhWpDyQU4AvTmAVxxrjgF8wgAPKdXtMbNLU
         3BlA==
X-Received: by 10.112.126.164 with SMTP id mz4mr183798lbb.52.1385445134422;
 Mon, 25 Nov 2013 21:52:14 -0800 (PST)
Received: by 10.114.175.130 with HTTP; Mon, 25 Nov 2013 21:52:14 -0800 (PST)
In-Reply-To: <1385351754-9954-4-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: hpv9qV8_wHR6WIE598i8RakrsXA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238372>

On Sun, Nov 24, 2013 at 10:55 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
<pclouds@gmail.com> wrote:
> If we borrow objects from another repository, we should also pay
> attention to their $GIT_DIR/shallow (and even info/grafts). But
> current alternates code does not.
>
> Reject alternate repos that are shallow because we do not do it
> right. In future we alternate code may be updated to check

s/we/the/

> $GIT_DIR/shallow properly so that this restriction could be lifted.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/clone.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 874e0fd..900f564 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -252,6 +252,12 @@ static int add_one_reference(struct string_list_=
item *item, void *cb_data)
>                 die(_("reference repository '%s' is not a local repos=
itory."),
>                     item->string);
>
> +       if (!access(mkpath("%s/shallow", ref_git), F_OK))
> +               die(_("reference repository '%s' is shallow"), item->=
string);
> +
> +       if (!access(mkpath("%s/info/grafts", ref_git), F_OK))
> +               die(_("reference repository '%s' is grafted"), item->=
string);
> +
>         strbuf_addf(&alternate, "%s/objects", ref_git);
>         add_to_alternates_file(alternate.buf);
>         strbuf_release(&alternate);
> --
> 1.8.2.83.gc99314b
