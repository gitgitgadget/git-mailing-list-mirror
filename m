From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 01/11] ref-filter: print output to strbuf for formatting
Date: Thu, 6 Aug 2015 18:21:22 -0400
Message-ID: <CAPig+cT6uu3DqUB+5gR35JS2eigPBizo_Y48rAzFYkbyCm+=OQ@mail.gmail.com>
References: <CAOLa=ZSBMk9y1VGTVKSVsGMdYuPtjhPADciVUaEVwESRdSvWZg@mail.gmail.com>
	<1438692188-14367-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 00:21:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNTXX-0007jl-B1
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 00:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756478AbbHFWVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 18:21:25 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:35745 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756471AbbHFWVX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 18:21:23 -0400
Received: by ykcq64 with SMTP id q64so69926054ykc.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 15:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=C8MOSSv74nfm6QPdsAyjbNsGyFSwi2HDI12J+WJfQAg=;
        b=UamB6ykvXUzk6Agc4YpGqPW6P1wZKG5j/kvghIriSVtFgLygEdHhI6iFM1OaevKHph
         2v0U+BIVe1qcWneYJ38XsuNlzZwJFmJDoAiW16kO5ISi0DNIpZq+iCI/fBUDWicjz6ex
         GMcJQn1BCGZ5TGAzFsYHdzAhr1JAy/krXRkWRQTucbKtZ0MTKYdqiyxHy1JGtIFIyz4u
         oecqY4Mn1S7qyvu4UqKHWJmLXtLhcc+W2BZO149ZXQrOnptBR3MrXqcz7Ysgqmkl1OW3
         w4I8NLV4jiLjf70fNP2pGobIaY/5PzU/h3TSwNOEoN2HeD0MIzDoY1YGiKBdg6RZ10Cs
         DnrQ==
X-Received: by 10.13.221.213 with SMTP id g204mr4504914ywe.48.1438899682356;
 Thu, 06 Aug 2015 15:21:22 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Thu, 6 Aug 2015 15:21:22 -0700 (PDT)
In-Reply-To: <1438692188-14367-1-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: z29kd9VCu5pWdSvO9jQJ1-x4SvA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275449>

On Tue, Aug 4, 2015 at 8:42 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce a strbuf `output` which will act as a substitute rather than
> printing directly to stdout. This will be used for formatting
> eventually.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> index 46963a5..91482c9 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1278,9 +1275,12 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
>                 if (color_parse("reset", color) < 0)
>                         die("BUG: couldn't parse 'reset' as a color");
>                 resetv.s = color;
> -               print_value(&resetv, quote_style);
> +               print_value(&resetv, quote_style, &output);
>         }
> +       for (i = 0; i < output.len; i++)
> +               printf("%c", output.buf[i]);

Everything up to this point seems straightforward, however, it's not
clear why you need to emit 'output' one character at a time. Is it
because it might contain a NUL '\0' character and therefore you can't
use the simpler printf("%s", output.buf)?

If that's the case, then why not just use fwrite() to emit it all at once?

    fwrite(output.buf, output.len, 1, stdout);

>         putchar('\n');
> +       strbuf_release(&output);
>  }
>
>  /*  If no sorting option is given, use refname to sort as default */
> --
> 2.5.0
