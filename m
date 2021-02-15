Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC18C433E6
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 17:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29B2F64E51
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 17:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhBOR0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 12:26:11 -0500
Received: from [93.83.142.38] ([93.83.142.38]:47220 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S230003AbhBORYO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 12:24:14 -0500
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by localhost (Postfix) with ESMTP id CBE5A1B27A;
        Mon, 15 Feb 2021 18:23:49 +0100 (CET)
Subject: Re: [PATCH v2 11/27] blame tests: simplify userdiff driver test
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
 <20210215154427.32693-12-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <c1e637d5-ad69-1726-2b38-476d0192ca02@kdbg.org>
Date:   Mon, 15 Feb 2021 18:23:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210215154427.32693-12-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.02.21 um 16:44 schrieb Ævar Arnfjörð Bjarmason:
> Simplify the test added in 9466e3809d (blame: enable funcname blaming
> with userdiff driver, 2020-11-01) to use the --author support recently
> added in 999cfc4f45 (test-lib functions: add --author support to
> test_commit, 2021-01-12).
> 
> We also did not need the full fortran-external-function content, let's
> cut it down to just the important parts, and further modify it to
> demonstrate that the fortran-specific userdiff function is in effect
> by adding "WRONG" lines surrounding the "RIGHT" one.
> 
> The test also left behind a .gitattributes files, let's clean it up
> with "test_when_finished".
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   t/annotate-tests.sh | 36 +++++++++++++++---------------------
>   1 file changed, 15 insertions(+), 21 deletions(-)
> 
> diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
> index 04a2c58594..4a86e0f349 100644
> --- a/t/annotate-tests.sh
> +++ b/t/annotate-tests.sh
> @@ -479,32 +479,26 @@ test_expect_success 'blame -L ^:RE (absolute: end-of-file)' '
>   	check_count -f hello.c -L$n -L^:ma.. F 4 G 1 H 1
>   '
>   
> -test_expect_success 'setup -L :funcname with userdiff driver' '
> -	echo "fortran-* diff=fortran" >.gitattributes &&
> -	fortran_file=fortran-external-function &&
> -	cat >$fortran_file <<-\EOF &&
> +test_expect_success 'blame -L :funcname with userdiff driver' '
> +	cat >file.template <<-\EOF &&
> +	def WRONG begin end
>   	function RIGHT(a, b) result(c)
> +	int WRONG(void) {}
>   
>   	integer, intent(in) :: ChangeMe
> -	integer, intent(in) :: b
> -	integer, intent(out) :: c
> -
> -	c = a+b
> -
> -	end function RIGHT
>   	EOF
> -	git add "$fortran_file" &&
> -	GIT_AUTHOR_NAME="A" GIT_AUTHOR_EMAIL="A@test.git" \
> -	git commit -m "add fortran file" &&
> -	sed -e "s/ChangeMe/IWasChanged/" <"$fortran_file" >"$fortran_file".tmp &&
> -	mv "$fortran_file".tmp "$fortran_file" &&
> -	git add "$fortran_file" &&
> -	GIT_AUTHOR_NAME="B" GIT_AUTHOR_EMAIL="B@test.git" \
> -	git commit -m "change fortran file"
> -'
>   
> -test_expect_success 'blame -L :funcname with userdiff driver' '
> -	check_count -f fortran-external-function -L:RIGHT A 7 B 1
> +	fortran_file=file.f03 &&
> +	test_when_finished "rm .gitattributes" &&
> +	echo "$fortran_file diff=fortran" >.gitattributes &&
> +
> +	test_commit --author "A <A@test.git>" \
> +		"add" $fortran_file \
> +		"$(cat file.template)" &&
> +	test_commit --author "B <B@test.git>" \
> +		"change" $fortran_file \
> +		"$(cat file.template | sed -e s/ChangeMe/IWasChanged/)" &&
> +	check_count -f $fortran_file -L:RIGHT A 3 B 1
>   '
>   
>   test_expect_success 'setup incremental' '
> 

I don't get the point. What do you need the tokens "WRONG" for when they 
are not checked anywhere? Instead of adding unrelated lines (that do not 
even look like Fortran), couldn't you just not remove some of the 
others? In particular, the last one that contains "RIGHT" as well may be 
useful to keep in order to show that the code is not confused by it.

Please place "$fortran_file" in dquotes on the check_count line.

-- Hannes
