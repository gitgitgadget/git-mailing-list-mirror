From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 01/19] add strbuf_set operations
Date: Wed, 11 Jun 2014 04:42:56 -0400
Message-ID: <CAPig+cTY22Or8vtZQpP5aahJzBs3wKmdX0tuxEpt0sswfp94bA@mail.gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
	<6fe33498512fc2ca1678517e51dc2e94a4260ff4.1402348696.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 10:43:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wue7d-0004nc-PI
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 10:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbaFKIm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 04:42:59 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:40229 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbaFKIm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 04:42:57 -0400
Received: by mail-yk0-f174.google.com with SMTP id 19so3150745ykq.5
        for <git@vger.kernel.org>; Wed, 11 Jun 2014 01:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8uvYhDr5XqcW5PzpUejrheRlNWKsgSZh3MwMAfdJxjg=;
        b=oJaHEvZ/g7aooUSLx5q/9iIPQhwy3rqxqLWV2+Msh1sP3ZF2cAU+tjcpRLIRoTQawQ
         i6QUetuKmqB2Sk2oQMbTMbS1QJP7VzTgkDq/YJAjwxEPKaljOZbyxF4xDyTe1GF2eX+o
         Dr4DRQnKdMQrptEWeMaG4N2OC/6/w5zunOsrfSEV/tPSorDQqt8yEqOtGlXJTMgu33DR
         XLuGyVpjmy0odzMuSqzeNryBtxRG/e/cZUf9UWbE47CSr0+7SvjmTNTv9l7b4hyFibvf
         PMoyJ1laPF3LdVTvPntCBoFa7yhsAfa6JKKJ1AyKR+LsrDb/OHnlLq0i0ub73+eBDD1E
         r6rQ==
X-Received: by 10.236.141.80 with SMTP id f56mr636184yhj.149.1402476176366;
 Wed, 11 Jun 2014 01:42:56 -0700 (PDT)
Received: by 10.170.36.19 with HTTP; Wed, 11 Jun 2014 01:42:56 -0700 (PDT)
In-Reply-To: <6fe33498512fc2ca1678517e51dc2e94a4260ff4.1402348696.git.jmmahler@gmail.com>
X-Google-Sender-Auth: S9Bm2l46ZEq4FQG_NSTkofI-BbM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251344>

On Mon, Jun 9, 2014 at 6:19 PM, Jeremiah Mahler <jmmahler@gmail.com> wrote:
> Currently, the data in a strbuf is modified using add operations.  To
> set the buffer to some data a reset must be performed before an add.
>
>   strbuf_reset(buf);
>   strbuf_add(buf, cb.buf.buf, cb.buf.len);
>
> And this is a common sequence of operations with 70 occurrences found in
> the current source code.  This includes all the different variations
> (add, addf, addstr, addbuf, addch).
>
>   FILES=`find ./ -name '*.c'`
>   CNT=$(pcregrep -M "strbuf_reset.*\n.*strbuf_add" $FILES | wc -l)
>   CNT=$(echo "$CNT / 2" | bc)
>   echo $CNT
>   70
>
> These patches add strbuf_set operations which allow this common sequence
> to be performed in one line instead of two.
>
>   strbuf_set(buf, cb.buf.buf, cb.buf.len);

This commit message is effectively the cover letter for the entire
patch series; it doesn't say specifically what _this_ patch is doing.

Justification for the change could be stronger. Rather than merely
pointing out that a sequence of operations occurs N times in the
project, explain why strbuf_set() is superior. For instance, you might
say something about how strbuf_set() conveys the operation being
performed more concisely and clearly than strbuf_reset() +
strbuf_add() (and thus may reduce cognitive load, though that's
subjective). The bit about performing the operation in one line
instead of two is minor, at best, and may not be worth mentioning at
all (since it's implied).

It's also redundant to say "this patch" in the commit message, thus
should be avoided.

More below.

> Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
> ---
>  Documentation/technical/api-strbuf.txt | 18 ++++++++++++++++++
>  strbuf.c                               | 21 +++++++++++++++++++++
>  strbuf.h                               | 14 ++++++++++++++
>  3 files changed, 53 insertions(+)
>
> diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
> index 077a709..b7e23da 100644
> --- a/Documentation/technical/api-strbuf.txt
> +++ b/Documentation/technical/api-strbuf.txt
> @@ -149,6 +149,24 @@ Functions
>         than zero if the first buffer is found, respectively, to be less than,
>         to match, or be greater than the second buffer.
>
> +* Setting the buffer
> +
> +`strbuf_set`::
> +
> +       Replace the buffer content with data of a given length.

I know that you copied the wording I suggested in my v1 review, but
now that I see it in context, I find the redundancy level rather high.
The header already says "Setting the buffer", so repeating "the
buffer" in each function description doesn't add much. It might make
sense to reword as:

    Replace content with [...].

More below.

> +`strbuf_setstr`::
> +
> +       Replace the buffer content with data from a NUL-terminated string.
> +
> +`strbuf_setf`::
> +
> +       Replace the buffer content with a formatted string.
> +
> +`strbuf_setbuf`::
> +
> +       Replace the buffer content with data from another buffer.
> +
>  * Adding data to the buffer
>
>  NOTE: All of the functions in this section will grow the buffer as necessary.
> diff --git a/strbuf.c b/strbuf.c
> index ac62982..9d64b00 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -189,6 +189,27 @@ void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
>         strbuf_setlen(sb, sb->len + dlen - len);
>  }
>
> +void strbuf_set(struct strbuf *sb, const void *data, size_t len)
> +{
> +       strbuf_reset(sb);
> +       strbuf_add(sb, data, len);
> +}
> +
> +void strbuf_setf(struct strbuf *sb, const char *fmt, ...)
> +{
> +       va_list ap;
> +       strbuf_reset(sb);
> +       va_start(ap, fmt);
> +       strbuf_vaddf(sb, fmt, ap);
> +       va_end(ap);
> +}
> +
> +void strbuf_setbuf(struct strbuf *sb, const struct strbuf *sb2)
> +{
> +       strbuf_reset(sb);
> +       strbuf_add(sb, sb2->buf, sb2->len);
> +}
> +
>  void strbuf_insert(struct strbuf *sb, size_t pos, const void *data, size_t len)
>  {
>         strbuf_splice(sb, pos, 0, data, len);
> diff --git a/strbuf.h b/strbuf.h
> index e9ad03e..b339f08 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -101,6 +101,20 @@ static inline struct strbuf **strbuf_split(const struct strbuf *sb,
>   */
>  extern void strbuf_list_free(struct strbuf **);
>
> +/*----- set buffer to data -----*/
> +

Minor: Existing divider lines in this header are not followed by a blank line.

> +extern void strbuf_set(struct strbuf *sb, const void *data, size_t len);
> +
> +static inline void strbuf_setstr(struct strbuf *sb, const char *s)
> +{
> +       strbuf_set(sb, s, strlen(s));
> +}
> +
> +__attribute__((format (printf,2,3)))
> +extern void strbuf_setf(struct strbuf *sb, const char *fmt, ...);
> +
> +extern void strbuf_setbuf(struct strbuf *sb, const struct strbuf *sb2);
> +
>  /*----- add data in your buffer -----*/
>  static inline void strbuf_addch(struct strbuf *sb, int c)
>  {
> --
> 2.0.0.592.gf55b190

Final word: The comments in this review do not necessarily require a
re-roll. Junio may or may not want to pick up the series as is. If he
doesn't, or if you want to polish it further, then perhaps take the
review comments into consideration when rerolling.
