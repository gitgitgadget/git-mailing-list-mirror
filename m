From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/9] ref-filter: support printing N lines from tag annotation
Date: Sun, 19 Jul 2015 20:02:54 -0400
Message-ID: <CAPig+cSXuJ7ohR=afzRbmfLtEuzhGYYTznc2J_qxwgBKwyYu9Q@mail.gmail.com>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
	<1437246749-14423-4-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 02:03:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGyXr-0005nU-Fz
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 02:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbbGTACz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 20:02:55 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:32911 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754585AbbGTACz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 20:02:55 -0400
Received: by ykfw194 with SMTP id w194so47769546ykf.0
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 17:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=xOoaPuPEddX0lNfcA0AToS4C4ZMG6PlMvQG7LkzJKpU=;
        b=KuqqYgmgRg2XXYQqVhNVwxGHSgEL7w9M+ltcFTAo/yujXO6+fi12IdzXgTfJIzihb5
         1ZgPbbhKok0uKgPtbqkEbwVVg5jYfhFQrxc2LZCD8TsGLmHtIt1XTLunYwccIfELVgTz
         orgFiKK9wmXF2PDqSmcctq/lccE6LxtriDIH1ZcUPIE44cS0i/9aR1/5zSAcMFsHIYab
         Xm2M0mbz5TmtO6xVxCYNeDYuE95HZhnvvO2KC42YWJ0Yzc964gzOSe5MyzJstl7YSpiB
         fu3iFYZymWyXushn3RxpurtbXj5tjngYD17f21OS44OMxo+GFO2l1uI+SCgu8RpFuDd4
         QUBg==
X-Received: by 10.129.91.87 with SMTP id p84mr26345052ywb.95.1437350574507;
 Sun, 19 Jul 2015 17:02:54 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sun, 19 Jul 2015 17:02:54 -0700 (PDT)
In-Reply-To: <1437246749-14423-4-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: M-2Qy9E1qL0loe4p64h0wK0vQBM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274300>

On Sat, Jul 18, 2015 at 3:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> In 'tag.c' we can print N lines from the annotation of the tag using
> the '-n<num>' option. Copy code from 'tag.c' to 'ref-filter' and
> modify 'ref-filter' to support printing of N lines from the annotation
> of tags.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> index 771c48d..82731ac 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1288,7 +1288,48 @@ static void assign_formating(struct ref_array_item *ref, int parsed_atom, struct
>         }
>  }
>
> -void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
> +/* Print 'lines' no of lines of a given oid */

This is difficult to read and understand. I presume you meant "no." as
shorthand for "number" but dropped the period. Even with the period,
it's still hard to read. Perhaps rewrite it as:

    If 'lines' is greater than 0, print that may lines of...

or something.

> diff --git a/ref-filter.h b/ref-filter.h
> index c18781b..7dfdea0 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -87,8 +88,11 @@ int parse_ref_filter_atom(const char *atom, const char *ep);
>  int verify_ref_format(const char *format);
>  /*  Sort the given ref_array as per the ref_sorting provided */
>  void ref_array_sort(struct ref_sorting *sort, struct ref_array *array);
> -/*  Print the ref using the given format and quote_style */
> -void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style);
> +/*
> + * Print the ref using the given format and quote_style. If lines > 0,
> + * prints the "lines" no of lines of the objected pointed to.
> + */

Same problem. This literal "no" is quite confusing. Perhaps rewrite as above:

    If lines > 0, print that many lines of...

> +void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style, unsigned int lines);

ref-filter.h seems to be setting a precedent for overlong lines.
Wrapping this manually could improve readability.

>  /*  Callback function for parsing the sort option */
>  int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset);
>  /*  Default sort option based on refname */
> --
> 2.4.6
