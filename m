From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Add tests for "Pass graph width to pretty formatting, so
 '%>|' can work properly"
Date: Fri, 11 Sep 2015 15:37:53 -0400
Message-ID: <CAPig+cRkSRSC0eaBencw8cFrd64sUBQE44aSJ0T2WyPg2JTFCw@mail.gmail.com>
References: <xmqq1te428xl.fsf@gitster.mtv.corp.google.com>
	<1441993845-25778-1-git-send-email-josef@kufner.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Josef Kufner <josef@kufner.cz>
X-From: git-owner@vger.kernel.org Fri Sep 11 21:38:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaU91-0007H0-9o
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 21:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbbIKThy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 15:37:54 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:33763 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbbIKThx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 15:37:53 -0400
Received: by ykei199 with SMTP id i199so101720963yke.0
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 12:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7b76JnscVQRWxjHXFBcQEIc18jT4zW5TchykZJ/jCgc=;
        b=w1mPqywJ+x9iO3YrsV6mDGi9GKBVlT4H1QGpP0+G7kBx4YymgbwZbJtR4PjY4qW7AL
         wDIsGyY1qp01E4vAKhuYxjvBNH/DScK0M3GW1t8pwxbURH6S5k2QAdDZ1R6pya2jhLlz
         130n1r+h+vUTI8ttBbmP0364j8xudhBtYKtTiozFrW+yjCJ8hclw9OiSLjRt6P3ngA7D
         4tEyGFNQB6lA85PRfzvWrWyW6lh+pxilJ7BI/lkGHmcng2r3a9Q4+vhjWALrpVfcHHIV
         TGGKkP3/r/4ScPH66aJq3/CA01w115rlCTWVcXx5WiqDQ0BlIPCMegYIz9ZRWO8UPYFG
         brbw==
X-Received: by 10.170.81.5 with SMTP id x5mr616348ykx.82.1442000273153; Fri,
 11 Sep 2015 12:37:53 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Fri, 11 Sep 2015 12:37:53 -0700 (PDT)
In-Reply-To: <1441993845-25778-1-git-send-email-josef@kufner.cz>
X-Google-Sender-Auth: 9kqSy6TZ_aQ2wdHRd6RZH-OeOkQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277692>

On Fri, Sep 11, 2015 at 1:50 PM, Josef Kufner <josef@kufner.cz> wrote:
> ---

Missing sign-off. Or is this intended to be concatenated with the
patch you sent earlier?

> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index 7398605..3358837 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -319,6 +319,18 @@ EOF
>         test_cmp expected actual
>  '
>
> +# Note: Space between 'message' and 'two' should be in the same column as in previous test.
> +test_expect_success 'right alignment formatting at the nth column with --graph. i18n.logOutputEncoding' '
> +       git -c i18n.logOutputEncoding=$test_encoding log --graph --pretty="tformat:%h %>|(40)%s" >actual &&
> +       qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&

You don't seem to be taking advantage of qz_to_tab_space's
transliteration of Q to tab and Z to space, so s/qz_to_tab_space/cat/
would make the code clearer.

> +* $head1                    message two
> +* $head2                    message one
> +* $head3                        add bar
> +* $head4            $(commit_msg)
> +EOF
> +       test_cmp expected actual
> +'
> +
>  test_expect_success 'right alignment formatting with no padding' '
>         git log --pretty="tformat:%>(1)%s" >actual &&
>         cat <<EOF >expected &&
> @@ -330,6 +342,17 @@ EOF
>         test_cmp expected actual
>  '
>
> +test_expect_success 'right alignment formatting with no padding and with --graph' '
> +       git log --graph --pretty="tformat:%>(1)%s" >actual &&
> +       cat <<EOF >expected &&
> +* message two
> +* message one
> +* add bar
> +* $(commit_msg)
> +EOF
> +       test_cmp expected actual
> +'
