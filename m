From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] introduce "format" date-mode
Date: Tue, 30 Jun 2015 13:05:37 -0400
Message-ID: <CAPig+cTbOkDJDwhKEbboCQkeossBzvPmw=goag01Sbsw2pisSA@mail.gmail.com>
References: <20150625165341.GA21949@peff.net>
	<20150625165545.GC23503@peff.net>
	<20150629222247.GA31607@flurp.local>
	<20150630132653.GA25742@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 30 19:05:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9yyg-0008Pb-PE
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 19:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbbF3RFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 13:05:40 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:36117 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbbF3RFi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 13:05:38 -0400
Received: by ykdr198 with SMTP id r198so14809649ykd.3
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 10:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=OevmoXgnFhGXKD6Z+WM1PpwdcddN7YBGVD37GFjNz/w=;
        b=ijBqLl0XsCESRldB+H5ttOGqbosz4YPrI3POMpXo17LMbVIbeRm/3js38PMoUzB1jT
         xM9Cw16HK9ODP8nidk7aO0seV0s9dSkUv+NfjAmzLNr3kmVFvS3Z8qIEUmGJVd5rHkBi
         k/ibnLiXh8PlFsmSdNfarwJx7bqWTEEul5d43luNpPStanem0y9M/lO1KdLYNO/KFW2C
         8qtQzXGjU7HcpyQaq0SgT7qVSfh+lH4fXGEUMoAHJXuelH4t8Bao5GEvHUmZFPoS7Ho8
         TMi4wgr6d54L4bONjqOHdDvwSgSdchSkw5Dg53Ik/0MWcn3lgpvF14G/vNKhFnqXWrti
         7YFw==
X-Received: by 10.13.207.1 with SMTP id r1mr26917233ywd.166.1435683937863;
 Tue, 30 Jun 2015 10:05:37 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 30 Jun 2015 10:05:37 -0700 (PDT)
In-Reply-To: <20150630132653.GA25742@peff.net>
X-Google-Sender-Auth: 1YqnQSEk9vuOvr-jRMH0IKDuy6U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273085>

On Tue, Jun 30, 2015 at 9:26 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 29, 2015 at 06:22:47PM -0400, Eric Sunshine wrote:
>
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

As a logical change in itself, I could also see introduction of
strbuf_addftime() split out into its own patch (with this patch
squashed in). Either way, it's a welcome improvement over the
original.

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
