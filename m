From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 6/7] t5541: move run_with_cmdline_limit to test-lib.sh
Date: Fri, 13 Mar 2015 02:45:59 -0400
Message-ID: <CAPig+cQg8yhSAVi5w1w967iyTxYEgXBnSYw7wFoV0GqTk9KP+A@mail.gmail.com>
References: <20150313044101.GA18476@peff.net>
	<20150313045307.GF18532@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 13 07:46:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWJMK-0002bc-1y
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 07:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbbCMGqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 02:46:00 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:40289 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbbCMGqA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 02:46:00 -0400
Received: by ykq142 with SMTP id 142so9639898ykq.7
        for <git@vger.kernel.org>; Thu, 12 Mar 2015 23:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=AdPD21UbeEbqyeu7K7/o2tM0mFnw3YcqDS1vvOFBCIU=;
        b=yxjjLL3OSivVL7v+71DNcnl72j8P/R3UbNY9n6LytPDghODMJfffVI8tHJfAp8iv0p
         VU7MXQNYuGdXMrX8O/3J2JR0AIydYI0ySncjrARE4Z8Ubv1HXD1e882mao8Sh9GGUaOu
         rpG1R9+tZpxIo4ILc6qQhxTIKxRJYbtajtOzUSyKwZqr+MxY/1U7yBKKvrES3D1TbKYh
         i2hZrtepKvlWPx+mYQAQv0CUVuvVJpflJW3x5nwjKfgkCHrM2w05OI1ez/xjH15T4fbK
         FPcZn2oFGfLkYXYQDFLkGhw54LDpUTUXuLTzTILkMhOb2mNhvTcrG8A8CD9gTTvGrXGR
         GmVA==
X-Received: by 10.236.63.6 with SMTP id z6mr46257549yhc.65.1426229159590; Thu,
 12 Mar 2015 23:45:59 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Thu, 12 Mar 2015 23:45:59 -0700 (PDT)
In-Reply-To: <20150313045307.GF18532@peff.net>
X-Google-Sender-Auth: -JzAiG3Jfn0jgxWmvUXL9ywVULs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265406>

On Fri, Mar 13, 2015 at 12:53 AM, Jeff King <peff@peff.net> wrote:
> We use this to test http pushing with a restricted
> commandline. Other scripts (like t5551, which does http
> fetching) will want to use it, too.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> As we discussed a while ago, this is the exact same code that
> run_with_limited_stack uses in t7004. However, I think they are
> conceptually two different things, and I could imagine a platform where
> they have distinct implementations. So I did not refactor t7004 to make
> use of this.

Perhaps this commentary should be moved to the commit message so that
the next person who notices that run_with_limited_stack() is the same
will understand why it was left alone.

>  t/t5541-http-push-smart.sh | 6 ------
>  t/test-lib.sh              | 6 ++++++
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
> index d2c681e..1ecb588 100755
> --- a/t/t5541-http-push-smart.sh
> +++ b/t/t5541-http-push-smart.sh
> @@ -324,12 +324,6 @@ test_expect_success 'push into half-auth-complete requires password' '
>         test_cmp expect actual
>  '
>
> -run_with_limited_cmdline () {
> -       (ulimit -s 128 && "$@")
> -}
> -
> -test_lazy_prereq CMDLINE_LIMIT 'run_with_limited_cmdline true'
> -
>  test_expect_success CMDLINE_LIMIT 'push 2000 tags over http' '
>         sha1=$(git rev-parse HEAD) &&
>         test_seq 2000 |
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 7dd4b4d..9914d3e 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1062,3 +1062,9 @@ test_lazy_prereq UNZIP '
>         "$GIT_UNZIP" -v
>         test $? -ne 127
>  '
> +
> +run_with_limited_cmdline () {
> +       (ulimit -s 128 && "$@")
> +}
> +
> +test_lazy_prereq CMDLINE_LIMIT 'run_with_limited_cmdline true'
> --
> 2.3.2.472.geadab3c
