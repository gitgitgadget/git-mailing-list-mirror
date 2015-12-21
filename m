From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] hooks/update: Add a hooks.denyunsignedtags option
Date: Mon, 21 Dec 2015 14:29:26 -0500
Message-ID: <CAPig+cT=VGoKEwPCGMYRLneFerapSRT7g6FUq7hU+YLdC5rTdQ@mail.gmail.com>
References: <1450719124-10558-1-git-send-email-jak@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "gitster@pobox.com" <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Julian Andres Klode <jak@debian.org>
X-From: git-owner@vger.kernel.org Mon Dec 21 20:29:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB69D-0006w2-Qt
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 20:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbbLUT32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 14:29:28 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:34650 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbbLUT31 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 14:29:27 -0500
Received: by mail-vk0-f51.google.com with SMTP id j66so106153541vkg.1
        for <git@vger.kernel.org>; Mon, 21 Dec 2015 11:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gwrLqt5FxBpuF/o3LYvqxAJgiACe3v/xH+BhYVhXoU8=;
        b=QkfPyKK/NBYZh4JKy+uyM98/XImstAsPe6BpefOZyq2vUSZ7uYI8o0nyA4xlJYUiiI
         E0v0i2QuGGE4W8yeWmJIDXAp+teaq2nDlbQz+x1/97WDzYjVOoCJVh4O+gb8qNAWcsew
         ugPsxYpgTbYuNoyBrnixBVJSaF6ZzKhkOydluCwkOOX0XYRaiGe7EZU6hbSvYvLj7oWg
         vpiXHYubX9IDjjY4wqDl0DbAnMwm9yve+oGKkArgDuQ3VipRpZrrtuVlOf6T3vn52ylK
         2q1OjHX7m1G2b8CAr8Y5k5vxYuoYx7vywzct6Vn1GClOjfuHFIdiElBc63iQ19+yMmnp
         UQyg==
X-Received: by 10.31.47.130 with SMTP id v124mr13277863vkv.117.1450726166438;
 Mon, 21 Dec 2015 11:29:26 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 21 Dec 2015 11:29:26 -0800 (PST)
In-Reply-To: <1450719124-10558-1-git-send-email-jak@debian.org>
X-Google-Sender-Auth: wyzMX2WBFAyr95LdWgElcTZgMRc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282811>

On Monday, December 21, 2015, Julian Andres Klode <jak@debian.org> wrote:
> Introduce an option to deny unsigned tags from entering
> a repository. This is useful in teams where members forget
> to sign their release tags.
>
> It does not actually check whether the signature is actually
> complete or valid, it just checks for the beginning of a
> signature, as further checks would be too involved.
>
> This effectively also denies un-annotated tags, as those
> are unsigned by definition.
>
> Signed-off-by: Julian Andres Klode <jak@debian.org>
> ---
> diff --git a/templates/hooks--update.sample b/templates/hooks--update.sample
> @@ -71,7 +75,7 @@ case "$refname","$newrev_type" in
>         refs/tags/*,commit)
>                 # un-annotated tag
>                 short_refname=${refname##refs/tags/}
> -               if [ "$allowunannotated" != "true" ]; then
> +               if [ "$allowunannotated" != "true" ] || [ "$denyunsignedtag" = "true" ]; then
>                         echo "*** The un-annotated tag, $short_refname, is not allowed in this repository" >&2
>                         echo "*** Use 'git tag [ -a | -s ]' for tags you want to propagate." >&2

Hmm. Is this diagnostic sufficient to help the person resolve the
issue? Isn't it actively misleading to advise using '-a'? Perhaps a
distinct message is warranted?

(Alternately, if you follow Junio's advice and disallow this
combination of options, then this issue becomes moot.)

>                         exit 1
> @@ -86,6 +90,14 @@ case "$refname","$newrev_type" in
>                 ;;
>         refs/tags/*,tag)
>                 # annotated tag
> +               if [ "$denyunsignedtag" != "true" ] || git cat-file -p $newrev | grep -q 'BEGIN PGP SIGNATURE'; then
> +                       :
> +               else
> +                       echo "*** Tag '$refname' is unsigned"
> +                       echo "*** Unsigned tags are not allowed in this repository." >&2

The diagnostic for $allowunannotated gives helpful advice about how to
resolve the problem. Should this one follow suit?

Also consistency might suggest patterning this message after the one
for $allowunannotated. Perhaps something like this:

    The unsigned tag $short_refname is not allowed in this repository.
    Use 'git tag -s' for tags you want to propagate.

or something.

> +                       exit 1
> +               fi
> +
>                 if [ "$allowmodifytag" != "true" ] && git rev-parse $refname > /dev/null 2>&1
>                 then
>                         echo "*** Tag '$refname' already exists." >&2
> --
> 2.6.4
