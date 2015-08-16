From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v11 04/13] utf8: add function to align a string into given strbuf
Date: Sun, 16 Aug 2015 19:48:04 -0400
Message-ID: <CAPig+cSV_cfF8y0HVKSU1yBgOxJ0qrejc-7bQPvt-UkUNAtxKw@mail.gmail.com>
References: <1439661643-16094-5-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 01:48:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZR7fB-0001b1-7x
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 01:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbbHPXsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2015 19:48:07 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:35185 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbbHPXsG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2015 19:48:06 -0400
Received: by ykbi184 with SMTP id i184so47716388ykb.2
        for <git@vger.kernel.org>; Sun, 16 Aug 2015 16:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=B+WNbsHylOMFvaIAVBndyafUuSkhjbPdMwTZSfY6y8o=;
        b=AWEjH9NnSoXFMMD645QWP4yhiASOz+/6A9gfFNnxXW7NwfV900mKNshawrPaQMw1y2
         hQyfg2o1U4MZWZFJ+amKa6DJfHiAMAQ18eU8wk6ksoqrCNXjp/tGugaJWchyKOe7owy3
         +R3vNEUdFtoc7vdzA0VPzChLrRuFtx/olpawoiAS/O9yoqoWf8WB4WBiIRWjZpVZPZTw
         bSfSfD1ISfP/yU6OtF51kJB3fUl7jMznCPKrwaFay11WZ/MU7liDi6n0kWtMxXQ0zlzy
         UNVkejR7DklV2qutjBHCTqd6v7ai/y4n68HTkR8JAk2hEfSjDznJoA3wTy/EQG2Y2VMG
         FN0A==
X-Received: by 10.13.220.132 with SMTP id f126mr56437167ywe.39.1439768884951;
 Sun, 16 Aug 2015 16:48:04 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Sun, 16 Aug 2015 16:48:04 -0700 (PDT)
In-Reply-To: <1439661643-16094-5-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: I2430iWnNXBiXcD_t5ViUXFVRkw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276026>

On Sat, Aug 15, 2015 at 2:00 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Add strbuf_utf8_align() which will align a given string into a strbuf
> as per given align_type and width. If the width is greater than the
> string length then no alignment is performed.

A couple minor comments below...

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/utf8.c b/utf8.c
> index 28e6d76..0fb8e9d 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -644,3 +644,24 @@ int skip_utf8_bom(char **text, size_t len)
>         *text += strlen(utf8_bom);
>         return 1;
>  }
> +
> +void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int width,
> +                      const char *s)
> +{
> +       int slen = strlen(s);
> +       int display_len = utf8_strnwidth(s, slen, 0);
> +       int utf8_compensation = slen - display_len;

Based upon the previous round review, I think you had intended to name
this merely 'compensation'.

> +       if (display_len >= width) {
> +               strbuf_addstr(buf, s);
> +               return;
> +       }
> +
> +       if (position == ALIGN_LEFT)
> +               strbuf_addf(buf, "%-*s", width + utf8_compensation, s);
> +       else if (position == ALIGN_MIDDLE) {
> +               int left = (width - display_len)/2;

Style: spaces around '/'

> +               strbuf_addf(buf, "%*s%-*s", left, "", width - left + utf8_compensation, s);
> +       } else if (position == ALIGN_RIGHT)
> +               strbuf_addf(buf, "%*s", width + utf8_compensation, s);
> +}
> diff --git a/utf8.h b/utf8.h
> index 5a9e94b..7930b44 100644
> --- a/utf8.h
> +++ b/utf8.h
> @@ -55,4 +55,19 @@ int mbs_chrlen(const char **text, size_t *remainder_p, const char *encoding);
>   */
>  int is_hfs_dotgit(const char *path);
>
> +typedef enum {
> +       ALIGN_LEFT,
> +       ALIGN_MIDDLE,
> +       ALIGN_RIGHT
> +} align_type;
> +
> +/*
> + * Align the string given and store it into a strbuf as per the
> + * 'position' and 'width'. If the given string length is larger than
> + * 'width' than then the input string is not truncated and no
> + * alignment is done.
> + */
> +void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int width,
> +                      const char *s);
> +
>  #endif
> --
> 2.5.0
