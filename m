From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [v2 PATCH 1/2] reset: add '-' shorthand for '@{-1}'
Date: Tue, 10 Mar 2015 13:25:30 -0400
Message-ID: <CAPig+cS9t6gWdf+2A1MX7tfkS_Eb+MAdNn_Zgo6+oG4PCjP77w@mail.gmail.com>
References: <1426001883-6423-1-git-send-email-dyoucme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Sundararajan R <dyoucme@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 18:27:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVNvf-0003ME-MJ
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 18:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646AbbCJR0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 13:26:14 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:40705 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500AbbCJRZb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 13:25:31 -0400
Received: by yhot59 with SMTP id t59so1589838yho.7
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 10:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=o3yuibvClsnubGQPL2qPmp9ZoAkXwmdejgKZYWyKYus=;
        b=L/kilvkfw3uXor7M4YQJvIdHOzy+CgZl6VNlCn6sHD82bH46qiikO0vGJ62g2z6zCt
         +AwjPdnkCi+Ps1FG4rYFBIGNK76iKOx0xM8OPTVGi+MBQay7oyJckUwSKbHAR6UfbodV
         Adr3ml4xGZLujQrD1H+9KIkjDed8DCLGFhQM0aQg8M/8X6yT0QbKBcPTXb8uUYzeSOFi
         S0wFaTnIh/qgS19gVLG061c+wby2juzWVE0f17kXSL13lNGl5qkpYNG1lZZU/MIypWx9
         xJ9TgwDDejjfuSSyPb8F7Pj1NRz9zkKDXnOEgA5chkgKZa3i6LavAaEuvyrHH3LhCVzY
         tgDg==
X-Received: by 10.170.134.198 with SMTP id a189mr25336955ykc.103.1426008330129;
 Tue, 10 Mar 2015 10:25:30 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Tue, 10 Mar 2015 10:25:30 -0700 (PDT)
In-Reply-To: <1426001883-6423-1-git-send-email-dyoucme@gmail.com>
X-Google-Sender-Auth: 8IFAT_N7hH9eCU3V-IwxMlVQlFA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265246>

On Tue, Mar 10, 2015 at 11:38 AM, Sundararajan R <dyoucme@gmail.com> wrote:
> Teaching reset the - shorthand involves checking if any file named '-' exists
> because it then becomes ambiguous as to whether the user wants to reset the
> file '-' or if he wants to reset the working tree to the previous branch.

For clarity, I'd probably mention that the ambiguity arises only in
the absence of explicit '--' disambiguation.

> check_filename() is used to perform this check. A similar ambiguity occurs
> when the file @{-1} exits. Therefore, when the files '-' or '@{-1}' exist
> then the program dies with a message about the ambiguous argument.

Why single out @{-1} as a potential file name? Has @{-1} ever been
considered a filename rather than a treeish? Is this patch changing
the treatment of @{-1} so that it might be interpreted as a filename?

> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Sundararajan R <dyoucme@gmail.com>
> ---
> Have made the modifications suggest by you, Eric.
> Removed the part where the user is told that he can use ./- instead.
>
>  builtin/reset.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 4c08ddc..88ce0c5 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -192,6 +192,7 @@ static void parse_args(struct pathspec *pathspec,
>  {
>         const char *rev = "HEAD";
>         unsigned char unused[20];
> +       int file_named_minus = 0;
>         /*
>          * Possible arguments are:
>          *
> @@ -205,6 +206,12 @@ static void parse_args(struct pathspec *pathspec,
>          */
>
>         if (argv[0]) {
> +               if (!strcmp(argv[0], "-") && !argv[1]) {
> +                       if (!check_filename(prefix, "-"))
> +                               argv[0] = "@{-1}";
> +                       else
> +                               file_named_minus = 1;
> +               }
>                 if (!strcmp(argv[0], "--")) {
>                         argv++; /* reset to HEAD, possibly with paths */
>                 } else if (argv[1] && !strcmp(argv[1], "--")) {
> @@ -226,7 +233,13 @@ static void parse_args(struct pathspec *pathspec,
>                         rev = *argv++;
>                 } else {
>                         /* Otherwise we treat this as a filename */
> -                       verify_filename(prefix, argv[0], 1);
> +                       if (file_named_minus) {
> +                               die(_("ambiguous argument '-': both revision and filename\n"
> +                                       "Use '--' to separate paths from revisions, like this:\n"
> +                                       "'git <command> [<revision>...] -- [<file>...]'"));
> +                       }
> +                       else
> +                               verify_filename(prefix, argv[0], 1);
>                 }
>         }
>         *rev_ret = rev;
> --
> 2.1.0
