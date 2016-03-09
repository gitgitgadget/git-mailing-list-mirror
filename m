From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH 04/48] builtin/apply: extract line_by_line_fuzzy_match()
 from match_fragment()
Date: Wed, 9 Mar 2016 14:55:19 -0800
Message-ID: <CAGZ79kbKCZGrBw8OOJzMES0BpMm1V8KQ6Xh2oS5ARB9KNMo+dA@mail.gmail.com>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
	<1457545756-20616-5-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 23:55:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adn0n-0007bj-ST
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 23:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208AbcCIWzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 17:55:21 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38688 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693AbcCIWzU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 17:55:20 -0500
Received: by mail-ig0-f170.google.com with SMTP id ig19so4208546igb.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 14:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=3g2/6mx4XEgl9aK3LHjESiVyAwPR0pFbEGBe0Ct9Jtk=;
        b=L6jTKMmInpJZV1HdqkO+8zRZbARVw3x1BtTYmg9ezu/DRzVR/kSh1V0YY8F18YTu7B
         iMzg6wgeIJLzyjPRpARoqHLsPjgqcFx03Anbsk1aKOistkNrwo5uU+Eqkqldf5hXxqhc
         /IJZonCvUyx/SPRw+kM1/8KU+5nDh6KmegmCCOiEVGaz/wijGsY313cGmclC0S9vE6Fu
         Dd2vtogN8Df7s0Y5ym3ED0tquBhFcfREQRAA3Swab/EkkiHbkZbI0gLeX5KVe2Bu/PCE
         KmoG7SqIe8nyWSaaRvgXCWlFTLDKJRVO7NEQ2oA7oE7oLPCHZbL2O669P+U8DOotfE+N
         OJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=3g2/6mx4XEgl9aK3LHjESiVyAwPR0pFbEGBe0Ct9Jtk=;
        b=DnZsWkbbWMWf4NEvHoXoovvjU47MiGfuo+H6am/0O35z7y7SmjyPTd3YnCB+qxmppz
         VrHpel7Q38w0ErlAToPQ08SspwhuD50rxisqqq/SXjYhEw6JzbOXwv5EO4sHhqV0OnkN
         EvSfp80Uibsv1EzOk8WffGtnNyGQxTwLczszR8wVNev60FIDjf+lBZsTpeSZ/PhFECIW
         3izuZ2gPLdRoY/v5pARBCxmohhWUYPKSsTcUUWTw3cIJ4NaqvO7WpXPSMuWTKGZCC5jG
         vyBkhv0aR2r7Z4ZbAIVg5CNRzorsOk6ygc5Ze3KTH4uFxMgs6nlCJtZ1njuf3ds74IR7
         Qqng==
X-Gm-Message-State: AD7BkJLmhq4RuvcZVPwtqJFQlzYlxTkyYXE4lBc5BMabcxhOeCa+hQDf/+5TpIuCzuMA/KvqWfFmhz0wZgLeqiP6
X-Received: by 10.50.112.10 with SMTP id im10mr209501igb.93.1457564119353;
 Wed, 09 Mar 2016 14:55:19 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Wed, 9 Mar 2016 14:55:19 -0800 (PST)
In-Reply-To: <1457545756-20616-5-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288578>

On Wed, Mar 9, 2016 at 9:48 AM, Christian Couder
<christian.couder@gmail.com> wrote:

Some words in the commit message would be nice here as this is one of
the patches,
which isn't "obviously" a good thing to to. This comment also applies
to "builtin/apply:
introduce 'struct apply_state' to start libifying" where you lay out
the plan for the next
~40 patches.

I have only skimmed quickly over the other patches.


> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/apply.c | 125 ++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 71 insertions(+), 54 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index c99c859..7d7a8ab 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -2244,6 +2244,74 @@ static void update_pre_post_images(struct image *preimage,
>         postimage->nr -= reduced;
>  }
>
> +static int line_by_line_fuzzy_match(struct image *img,
> +                                   struct image *preimage,
> +                                   struct image *postimage,
> +                                   unsigned long try,
> +                                   int try_lno,
> +                                   int preimage_limit)
> +{
> +       int i;
> +       size_t imgoff = 0;
> +       size_t preoff = 0;
> +       size_t postlen = postimage->len;
> +       size_t extra_chars;
> +       char *buf;
> +       char *preimage_eof;
> +       char *preimage_end;
> +       struct strbuf fixed;
> +       char *fixed_buf;
> +       size_t fixed_len;
> +
> +       for (i = 0; i < preimage_limit; i++) {
> +               size_t prelen = preimage->line[i].len;
> +               size_t imglen = img->line[try_lno+i].len;
> +
> +               if (!fuzzy_matchlines(img->buf + try + imgoff, imglen,
> +                                     preimage->buf + preoff, prelen))
> +                       return 0;
> +               if (preimage->line[i].flag & LINE_COMMON)
> +                       postlen += imglen - prelen;
> +               imgoff += imglen;
> +               preoff += prelen;
> +       }
> +
> +       /*
> +        * Ok, the preimage matches with whitespace fuzz.
> +        *
> +        * imgoff now holds the true length of the target that
> +        * matches the preimage before the end of the file.
> +        *
> +        * Count the number of characters in the preimage that fall
> +        * beyond the end of the file and make sure that all of them
> +        * are whitespace characters. (This can only happen if
> +        * we are removing blank lines at the end of the file.)
> +        */
> +       buf = preimage_eof = preimage->buf + preoff;
> +       for ( ; i < preimage->nr; i++)
> +               preoff += preimage->line[i].len;
> +       preimage_end = preimage->buf + preoff;
> +       for ( ; buf < preimage_end; buf++)
> +               if (!isspace(*buf))
> +                       return 0;
> +
> +       /*
> +        * Update the preimage and the common postimage context
> +        * lines to use the same whitespace as the target.
> +        * If whitespace is missing in the target (i.e.
> +        * if the preimage extends beyond the end of the file),
> +        * use the whitespace from the preimage.
> +        */
> +       extra_chars = preimage_end - preimage_eof;
> +       strbuf_init(&fixed, imgoff + extra_chars);
> +       strbuf_add(&fixed, img->buf + try, imgoff);
> +       strbuf_add(&fixed, preimage_eof, extra_chars);
> +       fixed_buf = strbuf_detach(&fixed, &fixed_len);
> +       update_pre_post_images(preimage, postimage,
> +                              fixed_buf, fixed_len, postlen);
> +       return 1;
> +}
> +
>  static int match_fragment(struct image *img,
>                           struct image *preimage,
>                           struct image *postimage,
> @@ -2253,7 +2321,7 @@ static int match_fragment(struct image *img,
>                           int match_beginning, int match_end)
>  {
>         int i;
> -       char *fixed_buf, *buf, *orig, *target;
> +       char *fixed_buf, *orig, *target;
>         struct strbuf fixed;
>         size_t fixed_len, postlen;
>         int preimage_limit;
> @@ -2314,6 +2382,7 @@ static int match_fragment(struct image *img,
>                  * There must be one non-blank context line that match
>                  * a line before the end of img.
>                  */
> +               char *buf;
>                 char *buf_end;
>
>                 buf = preimage->buf;
> @@ -2334,59 +2403,7 @@ static int match_fragment(struct image *img,
>          * we need it to adjust whitespace if we match.
>          */
>         if (ws_ignore_action == ignore_ws_change) {
> -               size_t imgoff = 0;
> -               size_t preoff = 0;
> -               size_t postlen = postimage->len;
> -               size_t extra_chars;
> -               char *preimage_eof;
> -               char *preimage_end;
> -               for (i = 0; i < preimage_limit; i++) {
> -                       size_t prelen = preimage->line[i].len;
> -                       size_t imglen = img->line[try_lno+i].len;
> -
> -                       if (!fuzzy_matchlines(img->buf + try + imgoff, imglen,
> -                                             preimage->buf + preoff, prelen))
> -                               return 0;
> -                       if (preimage->line[i].flag & LINE_COMMON)
> -                               postlen += imglen - prelen;
> -                       imgoff += imglen;
> -                       preoff += prelen;
> -               }
> -
> -               /*
> -                * Ok, the preimage matches with whitespace fuzz.
> -                *
> -                * imgoff now holds the true length of the target that
> -                * matches the preimage before the end of the file.
> -                *
> -                * Count the number of characters in the preimage that fall
> -                * beyond the end of the file and make sure that all of them
> -                * are whitespace characters. (This can only happen if
> -                * we are removing blank lines at the end of the file.)
> -                */
> -               buf = preimage_eof = preimage->buf + preoff;
> -               for ( ; i < preimage->nr; i++)
> -                       preoff += preimage->line[i].len;
> -               preimage_end = preimage->buf + preoff;
> -               for ( ; buf < preimage_end; buf++)
> -                       if (!isspace(*buf))
> -                               return 0;
> -
> -               /*
> -                * Update the preimage and the common postimage context
> -                * lines to use the same whitespace as the target.
> -                * If whitespace is missing in the target (i.e.
> -                * if the preimage extends beyond the end of the file),
> -                * use the whitespace from the preimage.
> -                */
> -               extra_chars = preimage_end - preimage_eof;
> -               strbuf_init(&fixed, imgoff + extra_chars);
> -               strbuf_add(&fixed, img->buf + try, imgoff);
> -               strbuf_add(&fixed, preimage_eof, extra_chars);
> -               fixed_buf = strbuf_detach(&fixed, &fixed_len);
> -               update_pre_post_images(preimage, postimage,
> -                               fixed_buf, fixed_len, postlen);
> -               return 1;
> +               return line_by_line_fuzzy_match(img, preimage, postimage, try, try_lno, preimage_limit);
>         }
>
>         if (ws_error_action != correct_ws_error)
> --
> 2.8.0.rc1.49.gca61272
>
