From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] introduce "format" date-mode
Date: Mon, 20 Jul 2015 20:41:08 -0400
Message-ID: <CAPig+cT_3pFH6XKBO1F2rbNyiGz5NgLMMiA_T+NWBroW5Sj7cg@mail.gmail.com>
References: <20150625165341.GA21949@peff.net>
	<20150625165545.GC23503@peff.net>
	<20150629222247.GA31607@flurp.local>
	<20150630132653.GA25742@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 21 02:41:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHLcS-0006Fl-2V
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 02:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757235AbbGUAlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 20:41:10 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33205 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373AbbGUAlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 20:41:09 -0400
Received: by ykfw194 with SMTP id w194so72620657ykf.0
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 17:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=EevBuJc+HjDq10/Km4sik4gsK1SDCHBv7RC4Mx7ZZAE=;
        b=UckTBeKQZjLdH/I+mdXOi0mszOnFilYVBfrq+yU2HtkPaLhsa61kYz3rkwS+3SpQSD
         jAXPSkxQ6vbxur12mgxjs/2J9+YPW7QI9Rq6sznqr9uIXG3f3tAib94JeAEBw2TyPadZ
         +UxBjrkgKZ0uJe07lObEnr68+O+ETADhjuGjJC2eTI9hrKsXTMgxIL53aaLY0fU3rtbm
         xLlsdZAm0qCiKGpZGToU/oi5fM6qnRx8GflbJDNfzxxoYCtfjKNYEjTBQMvohpZEhJfi
         ryP5DQus+e6EsMga7qly4NBIpuvMPGB7F9WFKTmFJTW5dDxNjSP/DGPgAk1CBIL5B9si
         U7qg==
X-Received: by 10.170.97.9 with SMTP id o9mr30943739yka.84.1437439268229; Mon,
 20 Jul 2015 17:41:08 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Mon, 20 Jul 2015 17:41:08 -0700 (PDT)
In-Reply-To: <20150630132653.GA25742@peff.net>
X-Google-Sender-Auth: IezC9kFvgrDMbGAfAvZZsTdwBNQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274364>

On Tue, Jun 30, 2015 at 9:26 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 29, 2015 at 06:22:47PM -0400, Eric Sunshine wrote:
>> Clients of strbuf rightly expect the buffer to grow as needed in
>> order to complete the requested operation. It is, therefore, both
>> weird and expectation-breaking for strbuf_addftime() to lack this
>> behavior. Worse, it doesn't even signal when the format has failed
>> due to insufficient buffer space.
>>
>> How about taking this approach (or something similar), instead, which
>> grows the strbuf as needed?
>
> Here's a patch, on top of jk/date-mode-format (I think it would also be
> fine to just squash into the tip commit; the explanation in the commit
> message is sufficiently mirrored in the code comment).

While cleaning up old local branches, I noticed that, although the
jk/date-mode-format topic[1] made it into 'next' (and will be merged
to 'master' according to "What's cooking"[2]), the below follow-on
patch[3] which improves strbuf_addftime() never got picked up. Was
this omission intentional? Based upon the discussion[4], I was under
the impression that the patch was considered reasonably acceptable
(and did not worsen problems with bogus format strings -- which are
bogus anyway).

[1]: http://thread.gmane.org/gmane.comp.version-control.git/272658/focus=272695
[2]: http://news.gmane.org/gmane.comp.version-control.git
[3]: http://article.gmane.org/gmane.comp.version-control.git/273061
[4]: http://thread.gmane.org/gmane.comp.version-control.git/272658/focus=273026

> -- >8 --
> Subject: [PATCH] strbuf: make strbuf_addftime more robust
>
> The return value of strftime is poorly designed; when it
> returns 0, the caller cannot tell if the buffer was not
> large enough, or if the output was actually 0 bytes. In the
> original implementation of strbuf_addftime, we simply punted
> and guessed that our 128-byte hint would be large enough.
>
> We can do better, though, if we're willing to treat strftime
> like less of a black box. We can munge the incoming format
> to make sure that it never produces 0-length output, and
> then "fix" the resulting output.  That lets us reliably grow
> the buffer based on strftime's return value.
>
> Clever-idea-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  strbuf.c                | 38 +++++++++++++++++++++-----------------
>  t/t6300-for-each-ref.sh | 10 ++++++++++
>  2 files changed, 31 insertions(+), 17 deletions(-)
>
> diff --git a/strbuf.c b/strbuf.c
> index a7ba028..e5e7370 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -712,29 +712,33 @@ char *xstrfmt(const char *fmt, ...)
>
>  void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm)
>  {
> +       size_t hint = 128;
>         size_t len;
>
> -       /*
> -        * strftime reports "0" if it could not fit the result in the buffer.
> -        * Unfortunately, it also reports "0" if the requested time string
> -        * takes 0 bytes. So if we were to probe and grow, we have to choose
> -        * some arbitrary cap beyond which we guess that the format probably
> -        * just results in a 0-length output. Since we have to choose some
> -        * reasonable cap anyway, and since it is not that big, we may
> -        * as well just grow to their in the first place.
> -        */
> -       strbuf_grow(sb, 128);
> +       if (!*fmt)
> +               return;
> +
> +       strbuf_grow(sb, hint);
>         len = strftime(sb->buf + sb->len, sb->alloc - sb->len, fmt, tm);
>
>         if (!len) {
>                 /*
> -                * Either we failed, or the format actually produces a 0-length
> -                * output. There's not much we can do, so we leave it blank.
> -                * However, the output array is left in an undefined state, so
> -                * we must re-assert our NUL terminator.
> +                * strftime reports "0" if it could not fit the result in the buffer.
> +                * Unfortunately, it also reports "0" if the requested time string
> +                * takes 0 bytes. So our strategy is to munge the format so that the
> +                * output contains at least one character, and then drop the extra
> +                * character before returning.
>                  */
> -               sb->buf[sb->len] = '\0';
> -       } else {
> -               sb->len += len;
> +               struct strbuf munged_fmt = STRBUF_INIT;
> +               strbuf_addf(&munged_fmt, "%s ", fmt);
> +               while (!len) {
> +                       hint *= 2;
> +                       strbuf_grow(sb, hint);
> +                       len = strftime(sb->buf + sb->len, sb->alloc - sb->len,
> +                                      munged_fmt.buf, tm);
> +               }
> +               strbuf_release(&munged_fmt);
> +               len--; /* drop munged space */
>         }
> +       strbuf_setlen(sb, sb->len + len);
>  }
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index c7f368c..7c9bec7 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -235,6 +235,16 @@ test_expect_success 'Check format of strftime date fields' '
>         test_cmp expected actual
>  '
>
> +test_expect_success 'exercise strftime with odd fields' '
> +       echo >expected &&
> +       git for-each-ref --format="%(authordate:format:)" refs/heads >actual &&
> +       test_cmp expected actual &&
> +       long="long format -- $_z40$_z40$_z40$_z40$_z40$_z40$_z40" &&
> +       echo $long >expected &&
> +       git for-each-ref --format="%(authordate:format:$long)" refs/heads >actual &&
> +       test_cmp expected actual
> +'
> +
>  cat >expected <<\EOF
>  refs/heads/master
>  refs/remotes/origin/master
> --
> 2.5.0.rc0.336.g8460790
>
