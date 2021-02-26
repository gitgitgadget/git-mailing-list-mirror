Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA9DC433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 07:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DEE164EE1
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 07:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhBZH7W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 02:59:22 -0500
Received: from [93.83.142.38] ([93.83.142.38]:44794 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S229541AbhBZH7W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 02:59:22 -0500
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by localhost (Postfix) with ESMTP id 12A5C2C639;
        Fri, 26 Feb 2021 08:59:00 +0100 (CET)
Subject: Re: [PATCH v3 31/35] userdiff golang: don't over-match intented
 constructs
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
 <20210224195129.4004-32-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <fb6b3681-314c-eda9-aab3-2a85ebca92ca@kdbg.org>
Date:   Fri, 26 Feb 2021 08:59:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210224195129.4004-32-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.02.21 um 20:51 schrieb Ævar Arnfjörð Bjarmason:
> Fix a bug introduced when the "golang" driver was added in
> 1dbf0c0ad6c (userdiff: add built-in pattern for golang, 2018-03-01).
> 
> Unlike the default def_ff() driver in xemit.c it would match "type"
> declarations inside functions. Let's make it mandatory that a "func"
> or "type" must be at the beginning of the line with no whitespace to
> get around this.
> 
> Go is such a regularly formatted language that I think this can be
> counted on. I think the whitespace matching was probably copy/pasted
> from an earlier userdiff.c pattern.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t4018/golang | 20 ++++++++++++++++++++
>  userdiff.c     |  4 ++--
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t4018/golang b/t/t4018/golang
> index 72a35d66008..252b6049da4 100644
> --- a/t/t4018/golang
> +++ b/t/t4018/golang
> @@ -51,3 +51,23 @@ type some struct { // comment
>  	a Type
>  	b ChangeMe
>  }
> +
> +t4018 description: func combined with type
> +t4018 header: func myfunc() {
> +func myfunc() {
> +	type mystruct struct {
> +		a Foo
> +		b Bar
> +	}
> +	ChangeMe
> +
> +t4018 description: anonymous indented func()
> +t4018 header: func SomeThing() bool {
> +func SomeThing() bool {
> +	func() {

Wait! With the unmodified pattern, this indented "func()" cannot match
because it is not followed by a space. So, this test case does not
demonstrate that the modified pattern makes a difference. In the commit
message of 30/35 you say that "we should always get whitespace after
'func'", but here you show a case where that is not true. Did you forget
to write a name after "func"?

> +		defer func() {
> +			fmt.Println("hello")
> +		}()
> +	}()
> +
> +	ChangeMe
> diff --git a/userdiff.c b/userdiff.c
> index 698eca5ad35..704af241e44 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -129,9 +129,9 @@ IPATTERN("fountain",
>  	 "[^ \t-]+"),
>  PATTERNS("golang",
>  	 /* Functions */
> -	 "^[ \t]*(func[ \t].*)\n"
> +	 "^(func[ \t].*)\n"
>  	 /* Structs and interfaces */
> -	 "^[ \t]*(type[ \t].*(struct|interface)[ \t].*)",
> +	 "^(type[ \t].*[ \t](struct|interface)[ \t].*)",
>  	 /* -- */
>  	 "[a-zA-Z_][a-zA-Z0-9_]*"
>  	 "|[-+0-9.eE]+i?|0[xX]?[0-9a-fA-F]+i?"
> 

