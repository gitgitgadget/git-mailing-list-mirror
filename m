From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] Modify tr expression so that xpg4/tr handles it on Solaris
Date: Sat, 18 Jul 2015 23:31:53 -0400
Message-ID: <CAPig+cQYROsp4nsEj1cJ=W+BtxO5iQ0_UHUaJHScpN7iQBpi6A@mail.gmail.com>
References: <1437232877-27897-1-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 05:31:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGfKZ-0003Zn-58
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 05:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845AbbGSDbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 23:31:55 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:34712 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610AbbGSDby (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 23:31:54 -0400
Received: by ykax123 with SMTP id x123so117507948yka.1
        for <git@vger.kernel.org>; Sat, 18 Jul 2015 20:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=umeoaVgzGAOfohl2VxRnUwdSqQr/kBjmn4AsVrdRluk=;
        b=q1k9UCAbDb1EisnEbaJyQYbWTxnXfj8VqSGoO2hmdEbsyXUpJQw5vWqCotwmrMAjw9
         Myt2K/n/RgrvY0rmAXkrMjd+8nnlcZuCuXpFoMp3GPjbj0B2PMeof94OoqCd3/igwZKA
         sMJrXX8/AzCpvc2jsuzwCdU0Qlfs+uJtLQ8i5MILxfnFeV+BtSWOFJVKBalKV/58eJL/
         j1nE1DdY2gFtTme5lhsshxCpOzkElvOUZFwWK/kEUsada/RGCSZfTp9/PxTQov9/dFyt
         dmLoTIUV7JBNXb+pmFVnbJVwi0YxhSEf/EGeSX9RZCkLJFP8FAjAZhNsSd92SyF1AmqZ
         5seA==
X-Received: by 10.170.138.134 with SMTP id f128mr22478125ykc.90.1437276713822;
 Sat, 18 Jul 2015 20:31:53 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 18 Jul 2015 20:31:53 -0700 (PDT)
In-Reply-To: <1437232877-27897-1-git-send-email-bdwalton@gmail.com>
X-Google-Sender-Auth: kk006bUJpYYwLzrIpUyNxKXarO4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274199>

On Sat, Jul 18, 2015 at 11:21 AM, Ben Walton <bdwalton@gmail.com> wrote:
> It seems that xpg4/tr mishandles some strings involving [ not followed
> by a character class:
> % echo '[::1]' | /usr/xpg4/bin/tr -d '[]'
> [::1
>
> % echo '[::1]' | /usr/xpg4/bin/tr -d '['
> usr/xpg4/bin/tr: Bad string.

I suppose that "tr -d ']['" also gives a "Bad string." error?

> This was breaking two tests. To fix the issue, use the octal
> representations of [ and ] instead.
>
> Signed-off-by: Ben Walton <bdwalton@gmail.com>
> ---
>  t/t5500-fetch-pack.sh |    2 +-
>  t/t5601-clone.sh      |    8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 3a9b775..5bc4da9 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -547,7 +547,7 @@ check_prot_host_port_path () {
>                 *ssh*)
>                 pp=ssh
>                 uah=userandhost
> -               ehost=$(echo $3 | tr -d "[]")
> +               ehost=$(echo $3 | tr -d "\133\135")

These octal values are somewhat opaque. To make this more
self-documenting, would it make sense instead to define a global
variable named 'brackets' or 'squarebrackets' (or something) and then
reference that variable in each of the 'tr' commands?

    brackets='\133\135'
    ...
    ehost=$(echo $3 | tr -d $brackets)

>                 diagport="Diag: port=$4"
>                 ;;
>                 *)
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index bfdaf75..fa6be3c 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -445,7 +445,7 @@ test_expect_success 'clone ssh://host.xz:22/~repo' '
>  #IPv6
>  for tuah in ::1 [::1] [::1]: user@::1 user@[::1] user@[::1]: [user@::1] [user@::1]:
>  do
> -       ehost=$(echo $tuah | sed -e "s/1]:/1]/ "| tr -d "[]")
> +       ehost=$(echo $tuah | sed -e "s/1]:/1]/ " | tr -d "\133\135")
>         test_expect_success "clone ssh://$tuah/home/user/repo" "
>           test_clone_url ssh://$tuah/home/user/repo $ehost /home/user/repo
>         "
> @@ -454,7 +454,7 @@ done
>  #IPv6 from home directory
>  for tuah in ::1 [::1] user@::1 user@[::1] [user@::1]
>  do
> -       euah=$(echo $tuah | tr -d "[]")
> +       euah=$(echo $tuah | tr -d "\133\135")
>         test_expect_success "clone ssh://$tuah/~repo" "
>           test_clone_url ssh://$tuah/~repo $euah '~repo'
>         "
> @@ -463,7 +463,7 @@ done
>  #IPv6 with port number
>  for tuah in [::1] user@[::1] [user@::1]
>  do
> -       euah=$(echo $tuah | tr -d "[]")
> +       euah=$(echo $tuah | tr -d "\133\135")
>         test_expect_success "clone ssh://$tuah:22/home/user/repo" "
>           test_clone_url ssh://$tuah:22/home/user/repo '-p 22' $euah /home/user/repo
>         "
> @@ -472,7 +472,7 @@ done
>  #IPv6 from home directory with port number
>  for tuah in [::1] user@[::1] [user@::1]
>  do
> -       euah=$(echo $tuah | tr -d "[]")
> +       euah=$(echo $tuah | tr -d "\133\135")
>         test_expect_success "clone ssh://$tuah:22/~repo" "
>           test_clone_url ssh://$tuah:22/~repo '-p 22' $euah '~repo'
>         "
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
