Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449E5C433E0
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 07:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 017DC61601
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 07:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhB0Haa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Feb 2021 02:30:30 -0500
Received: from [93.83.142.38] ([93.83.142.38]:38188 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S229751AbhB0Haa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Feb 2021 02:30:30 -0500
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by localhost (Postfix) with ESMTP id 9DD912E46D;
        Sat, 27 Feb 2021 08:30:08 +0100 (CET)
Subject: Re: [PATCH v3 35/35] userdiff tests: add basic test for ruby
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
 <20210224195129.4004-36-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <6d4bde46-029b-b36b-a58a-a877a4a3d14c@kdbg.org>
Date:   Sat, 27 Feb 2021 08:30:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210224195129.4004-36-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.02.21 um 20:51 schrieb Ævar Arnfjörð Bjarmason:
> Add a test for the Ruby pattern added way back in ad8c1d9260 (diff:
> add ruby funcname pattern, 2008-07-31).
> 
> The "One/Two" picking demonstrates existing behavior, and a general
> case where we may not do what the user expects since we're not aware
> of the indentation level.
> 
> The code is modified from the Ruby code we have in-tree at
> Documentation/asciidoctor-extensions.rb.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t4018-diff-funcname.sh |  1 -
>  t/t4018/ruby.sh          | 58 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+), 1 deletion(-)
>  create mode 100755 t/t4018/ruby.sh
> 
> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
> index b0c2782d067..7793d7652d5 100755
> --- a/t/t4018-diff-funcname.sh
> +++ b/t/t4018-diff-funcname.sh
> @@ -23,7 +23,6 @@ test_expect_success 'setup' '
>  	html
>  	objc
>  	pascal
> -	ruby
>  	tex
>  	EOF
>  
> diff --git a/t/t4018/ruby.sh b/t/t4018/ruby.sh
> new file mode 100755
> index 00000000000..ef8a154421a
> --- /dev/null
> +++ b/t/t4018/ruby.sh
> @@ -0,0 +1,58 @@
> +#!/bin/sh
> +#
> +# See ../t4018-diff-funcname.sh's test_diff_funcname()
> +#
> +
> +test_diff_funcname 'ruby: "def" over "class/module"' \
> +	8<<\EOF_HUNK 9<<\EOF_TEST
> +def process(parent)
> +EOF_HUNK
> +require 'asciidoctor'
> +
> +module Git
> +  module Documentation
> +    class SomeClass
> +      use_some
> +
> +      def process(parent)
> +        puts("hello")
> +	puts(ChangeMe)
> +      end
> +    end
> +  end
> +end
> +EOF_TEST
> +
> +test_diff_funcname 'ruby: "class" over "class/module"' \
> +	8<<\EOF_HUNK 9<<\EOF_TEST
> +class Two
> +EOF_HUNK
> +module Git
> +  module Documentation
> +    class One
> +    end
> +
> +    class Two
> +      # Spacing for -U1

Again: -U0 is the default by now.

> +      ChangeMe
> +    end
> +  end
> +end
> +EOF_TEST
> +
> +test_diff_funcname 'ruby: picks first "class/module/def" before changed context' \
> +	'-U1' \
> +	8<<\EOF_HUNK 9<<\EOF_TEST
> +class One
> +EOF_HUNK
> +module Git
> +  module Documentation
> +    class One
> +    end
> +
> +    class Two
> +      ChangeMe
> +    end
> +  end
> +end
> +EOF_TEST

Why does this test need -U1? Wouldn't it be sufficient to change the
expected text to "class Two"? And if the answer is "yes", I again do not
see the need for a shell script test here; the simplified version would do.

-- Hannes
