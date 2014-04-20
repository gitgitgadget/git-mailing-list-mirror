From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/2] bugfix: fix broken time_buf paddings for git-blame
Date: Sun, 20 Apr 2014 16:28:12 -0400
Message-ID: <CAPig+cSf8RcUBdeACSLTTNcF7hqCXX-jjxx7RDZt52u3BKJxDA@mail.gmail.com>
References: <CACsJy8BTBwqFZUU3i3cuv40B6AHw5SRY9DZN2PoKL4XzgEL2eA@mail.gmail.com>
	<cover.1398010052.git.worldhello.net@gmail.com>
	<2742234ee9199b26e646f30b6ae20a1c9bfe48f7.1398010052.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Brian Gesiak <modocache@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 22:28:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbyLa-0008Op-2I
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 22:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755529AbaDTU2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 16:28:14 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:60543 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755407AbaDTU2N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 16:28:13 -0400
Received: by mail-yk0-f175.google.com with SMTP id 131so2821480ykp.20
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 13:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ng0F03v+23yb97lfypgF7xz5YLDef7qnVmnX2dtMJxk=;
        b=oX+qjhlKzFfdVrCPWrlhHK2DbhGSpNU8tXi56tHUkjWawDBBqRxeeh6CwzUmWl38az
         QSTOLug33KQMGA+IPWMguHk+bbu9KoF61EjBwqjCq6KxyuP08DOZL04mZS0FNASH7csG
         w97ARel/o26z4fR7WuwRG/q9J0sgUWgOTB9QpKMg/tHkH5XUhXRLzdcky7pbXaYLMVyL
         URjQSq5xhlo5JTdStITOP6zvLPvqxqo6TfAl6RmrEefZBHdrd6E7pGCMozN6ZJm2wsbw
         mviIHkstPCASYrqBOxu/mCdOueGjzdjqYKB/JKt2I0vcxzywQZqDK7BvnkNAWcdWwbbH
         UWDQ==
X-Received: by 10.236.216.73 with SMTP id f69mr46455442yhp.37.1398025692416;
 Sun, 20 Apr 2014 13:28:12 -0700 (PDT)
Received: by 10.170.163.66 with HTTP; Sun, 20 Apr 2014 13:28:12 -0700 (PDT)
In-Reply-To: <2742234ee9199b26e646f30b6ae20a1c9bfe48f7.1398010052.git.worldhello.net@gmail.com>
X-Google-Sender-Auth: 6PJkaVIeh4IbDB6I3NZY0YL79pI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246579>

On Sun, Apr 20, 2014 at 12:13 PM, Jiang Xin <worldhello.net@gmail.com> wrote:
> When `git blame` shows date field in a fixed width (as long as

s/fixed width/fixed-width/

s/long/wide/ would read a bit better.

> blame_date_width characters), if time_str shorter than that, add spaces

s/shorter/is shorter/
s/add/it adds/

> for padding.  But there are two bugs in the following codes:
>
>         memcpy(time_buf, time_str, time_len);
>         memset(time_buf + time_len, ' ', blame_date_width - time_len);
>
> 1. The type of blame_date_width is size_t (unsigned int).  If time_len

s/(unsigned int)/, which is unsigned/

>    is greater than blame_ate_width, "blame_date_width - time_len" will

s/_ate/_date/

>    never be a negative number, but a really big positive number, and
>    will cause memory overwrite.
>
>    This bug can be triggered if either l10n message for function
>    show_date_relative() in date.c is longer then 30 charcters, then

s/then 30/than 30/
s/charcters/characters/

>    `git blame --date relative` may fail.
>
> 2. When show blame information with relative time, the UTF-8 characters
>    in time_str will break the alignment of columns after the date field.
>    This is because the time_buf padding with spaces should have a
>    constant display width, not a fixed strlen size.  So we should call
>    utf8_strwidth() instead of strlen() for calibration.
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  builtin/blame.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 88cb799..0a0a858 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1556,22 +1556,31 @@ static void assign_blame(struct scoreboard *sb, int opt)
>  static const char *format_time(unsigned long time, const char *tz_str,
>                                int show_raw_time)
>  {
> -       static char time_buf[128];
> +       static struct strbuf time_buf = STRBUF_INIT;
>
> +       strbuf_reset(&time_buf);
>         if (show_raw_time) {
> -               snprintf(time_buf, sizeof(time_buf), "%lu %s", time, tz_str);
> +               strbuf_addf(&time_buf, "%lu %s", time, tz_str);
>         }
>         else {
>                 const char *time_str;
> +               size_t time_width;
>                 int time_len;
>                 int tz;
>                 tz = atoi(tz_str);
>                 time_str = show_date(time, tz, blame_date_mode);
>                 time_len = strlen(time_str);
> -               memcpy(time_buf, time_str, time_len);
> -               memset(time_buf + time_len, ' ', blame_date_width - time_len);
> +               strbuf_add(&time_buf, time_str, time_len);
> +               /*
> +                * Add space paddings to time_buf to display a fixed width
> +                * string, and use time_width for display width calibration.
> +                */
> +               for (time_width = utf8_strwidth(time_str);
> +                    time_width < blame_date_width;
> +                    time_width++)
> +                       strbuf_addch(&time_buf, ' ');
>         }
> -       return time_buf;
> +       return time_buf.buf;
>  }
>
>  #define OUTPUT_ANNOTATE_COMPAT 001
> --
> 2.0.0.rc0.3.g444188f.dirty
