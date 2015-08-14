From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Correctly close config file handle in case of error
Date: Fri, 14 Aug 2015 15:54:50 -0400
Message-ID: <CAPig+cStMdZUwDgSfzT_DgBpF-OMQe-PqTKbSLkzXFHQW8ca=Q@mail.gmail.com>
References: <55CE3F23.7040702@cs-ware.de>
	<CAPig+cQMng-bPjO3WLYb1z7aghYhhHqewSr+EGFgV6Gs6_JZRQ@mail.gmail.com>
	<55CE4511.6050704@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Sven Strickroth <sven@cs-ware.de>
X-From: git-owner@vger.kernel.org Fri Aug 14 21:55:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQL48-0006Ow-OR
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 21:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbbHNTyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 15:54:51 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:35047 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbbHNTyu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 15:54:50 -0400
Received: by ykbi184 with SMTP id i184so13839278ykb.2
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 12:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=51CdKX1ESKrlYwrOqWL7rsD/BdxXF2QMJXSd0hYn6eA=;
        b=EE02yAcIBPPRvQrQ19lrBFyaxIO8GEpfwf/1Ysf8VNdTHJHdggqjotKzpqKanO23F0
         vM4z7S5X4Lw9ZbU6cl6yYTzXWF7QSJXOqJezUmzgmWDXnQ1Tib9qfbqii1A/HANhLm9d
         DRHNDMOcLjtVUJKPjGcZfhsR4NBUvD/Fa/oAUBV8AluQVleCnUf1by9GdEDwgypf7GmB
         tJlL+o5E06icHFw5mORBAQeptH6OME3cb2lyB0irF3MhAKdLBnDA32p2Pi1pPxQI7IcQ
         ltn5LfnNrfEgBI71KIupkPToQMQRK6rhX7EiLpHEhQix1Ma2dv79BXkNHR80pXtXY6+b
         5+9w==
X-Received: by 10.170.55.70 with SMTP id 67mr30314821ykx.82.1439582090389;
 Fri, 14 Aug 2015 12:54:50 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Fri, 14 Aug 2015 12:54:50 -0700 (PDT)
In-Reply-To: <55CE4511.6050704@cs-ware.de>
X-Google-Sender-Auth: 1MLBW_AUZjmwa2QqT8TB6njOKuI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275931>

On Fri, Aug 14, 2015 at 3:44 PM, Sven Strickroth <sven@cs-ware.de> wrote:
> Without this patch there might be open file handle leaks.

Thanks, this looks better. One comment below...

> Signed-off-by: Sven Strickroth <email@cs-ware.de>
> Signed-off-by: Sup Yut Sum <ch3cooli@gmail.com>
> ---
> diff --git a/config.c b/config.c
> index 9fd275f..c06dc2f 100644
> --- a/config.c
> +++ b/config.c
> @@ -2010,6 +2010,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
>                                 error("invalid pattern: %s", value_regex);
>                                 free(store.value_regex);
>                                 ret = CONFIG_INVALID_PATTERN;
> +                               close(in_fd);
>                                 goto out_free;
>                         }
>                 }
> @@ -2034,6 +2035,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
>                                 free(store.value_regex);
>                         }
>                         ret = CONFIG_INVALID_FILE;
> +                       close(in_fd);
>                         goto out_free;
>                 }
>
> @@ -2048,6 +2050,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
>                 if ((store.seen == 0 && value == NULL) ||
>                                 (store.seen > 1 && multi_replace == 0)) {
>                         ret = CONFIG_NOTHING_SET;
> +                       close(in_fd);
>                         goto out_free;
>                 }
>
> @@ -2062,6 +2065,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
>                               config_filename, strerror(errno));
>                         ret = CONFIG_INVALID_FILE;
>                         contents = NULL;
> +                       close(in_fd);
>                         goto out_free;

Each of these cases flows through 'out_free', so an alternate approach
would be to close 'in_fd' there instead. Doing so has the benefit that
it is less likely for future code changes to make the same mistake of
failing to close the file descriptor.

Of course, you'd need to initialize 'in_fd' to some "invalid" value
(such as -1) which 'out_free' can check, as well as setting 'in_fd' to
that invalid value after the legitimate existing close().

    int in_fd = -1;
    ...
    if (whatever_error)
    goto out_free;
    ...
    close(in_fd);
    in_fd = -1;
    ...
    out_free:
    if (in_fd >= 0)
        close(in_fd);
    ...

or something...

>                 }
>                 close(in_fd);
