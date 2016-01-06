From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] interpret-trailers: add option for in-place editing
Date: Wed, 6 Jan 2016 14:02:23 -0500
Message-ID: <CAPig+cSvD-TAd6365wxycUcTBehL-81a0WWosz4mVr1-HKCqGQ@mail.gmail.com>
References: <1452087258-3893-1-git-send-email-tobias.klauser@zhinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>,
	Tobias Klauser <tklauser@distanz.ch>
To: Tobias Klauser <tobias.klauser@zhinst.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 20:02:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGtLo-0005yy-OE
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 20:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbcAFTCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 14:02:25 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35849 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863AbcAFTCY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 14:02:24 -0500
Received: by mail-vk0-f67.google.com with SMTP id a185so21078972vkb.3
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 11:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=PjS5/qCIPjCReFKmPPYJXOl9eDCyvlta/72qBM7utQM=;
        b=WHYInxJfqTC9P5h67P27bIX2aJ2NpeVKM/JiTwWfScifHtmtR3pQ2b2qkJxTQi0qvk
         b56lGyvUhtlFaTXLKX+qR+rDVkR6ioozmVL3W06v5xjHBqYS+7SQg33L9Is4k+J7a7Bx
         WodcpBKlaLs8WOlmOb4RIJm6v7HpF8f5P1zxrGFnI9KctE0TxImqcBYl2bwvDgVJdRTs
         aS2ssIgDpJjH43s5dZx4OxrJa0hnRa1O6ut7Mdmk47nr+lXpFr0EkOTQKm/HCW/YeNrp
         vY8DidQvSjsrHFSAQIugr2CJQAFOvBvfzc0xGjW+9SAeR7Wvnl10JlPGPoXWRHVxOUfl
         VbuQ==
X-Received: by 10.31.58.74 with SMTP id h71mr70994627vka.151.1452106943535;
 Wed, 06 Jan 2016 11:02:23 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 6 Jan 2016 11:02:23 -0800 (PST)
In-Reply-To: <1452087258-3893-1-git-send-email-tobias.klauser@zhinst.com>
X-Google-Sender-Auth: YsEiOyqpBOJSvSSpq1P2ueBw9x0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283452>

On Wed, Jan 6, 2016 at 8:34 AM, Tobias Klauser
<tobias.klauser@zhinst.com> wrote:
> Add a command line option --in-place to support in-place editing akin to
> sed -i.  This allows to write commands like the following:
>
>   git interpret-trailers --trailer "X: Y" a.txt > b.txt && mv b.txt a.txt
>
> in a more concise way:
>
>   git interpret-trailers --trailer "X: Y" --in-place a.txt
>
> Also add the corresponding documentation and tests.

In addition to Matthieu's comments...

> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
> diff --git a/trailer.c b/trailer.c
> @@ -856,19 +858,28 @@ void process_trailers(const char *file, int trim_empty, struct string_list *trai
>
>         lines = read_input_file(file);
>
> +       if (in_place) {
> +               fp = fopen(file, "w");
> +               if (!fp)
> +                       die_errno(_("could not open file '%s' for writing"), file);
> +       }

The input file should be considered precious, but this implementation
plays too loosely with it. If the user interrupts the program or a
die() somewhere within the "trailers" code aborts the program before
the output file is written, then the original file will be
irrecoverably lost. Users won't be happy about that.

Instead, this code should go through the standard dance of writing the
output to a new file (with some unique temporary name) and then, only
once the output has been successfully written in full, rename the new
file atop the old.

>         /* Print the lines before the trailers */
> -       trailer_end = process_input_file(lines, &in_tok_first, &in_tok_last);
> +       trailer_end = process_input_file(fp, lines, &in_tok_first, &in_tok_last);
>
>         arg_tok_first = process_command_line_args(trailers);
>
>         process_trailers_lists(&in_tok_first, &in_tok_last, &arg_tok_first);
>
> -       print_all(in_tok_first, trim_empty);
> +       print_all(fp, in_tok_first, trim_empty);
>
>         free_all(&in_tok_first);
>
>         /* Print the lines after the trailers as is */
> -       print_lines(lines, trailer_end, INT_MAX);
> +       print_lines(fp, lines, trailer_end, INT_MAX);
> +
> +       if (in_place)
> +               fclose(fp);
>
>         strbuf_list_free(lines);
>  }
