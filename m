Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE01C433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 08:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDB2E64EDB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 08:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhBZIES (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 03:04:18 -0500
Received: from [93.83.142.38] ([93.83.142.38]:44810 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S229550AbhBZIEL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 03:04:11 -0500
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by localhost (Postfix) with ESMTP id 6B2342C63A;
        Fri, 26 Feb 2021 09:03:45 +0100 (CET)
Subject: Re: [PATCH v3 32/35] userdiff golang: add a rule to match "package"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
 <20210224195129.4004-33-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <6905d873-2cba-638b-bbfe-e652a16cd65c@kdbg.org>
Date:   Fri, 26 Feb 2021 09:03:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210224195129.4004-33-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.02.21 um 20:51 schrieb Ævar Arnfjörð Bjarmason:
> Improve the "golang" built-in pattern to match "package" lines, as
> they weren't matched before changing e.g. the imports would commonly
> result in an empty hunk header, now we'll instead show the package
> name.
> 
> I used https://blog.golang.org/package-names as a guide here, but
> e.g. "foo_bar" is still valid syntax, so let's let it pass but veer on
> the side of not having false positives.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t4018/golang | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  userdiff.c     |  2 ++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/t/t4018/golang b/t/t4018/golang
> index 252b6049da4..38f254cd269 100644
> --- a/t/t4018/golang
> +++ b/t/t4018/golang
> @@ -1,3 +1,52 @@
> +t4018 description: package
> +t4018 header: package main
> +package main
> +
> +import "fmt"
> +// ChangeMe
> +
> +t4018 description: package regex is selective -- ALLCAPS
> +t4018 header: package main
> +package ALLCAPS
> +
> +import "fmt"
> +// ChangeMe
> +
> +t4018 description: package regex is selective -- CamelCase
> +t4018 header: package main
> +package CamelCase
> +
> +import "fmt"
> +// ChangeMe
> +
> +t4018 description: package regex is selective -- 123
> +t4018 header: package main
> +package 123
> +
> +import "fmt"
> +// ChangeMe
> +
> +t4018 description: package regex is not overly selective -- x509
> +t4018 header: package x509
> +package x509
> +
> +import "fmt"
> +// ChangeMe
> +
> +t4018 description: package regex is not overly selective -- underbars
> +t4018 header: package not_conventional
> +package not_conventional
> +
> +import "fmt"
> +// ChangeMe
> +
> +t4018 description: package regex is not overly selective -- camelCase
> +t4018 header: package camelCase
> +package camelCase
> +
> +import "fmt"
> +// ChangeMe
> +
>  t4018 description: complex function
>  t4018 header: func (t *Test) RIGHT(a Type) (Type, error) {
>  type Test struct {
> diff --git a/userdiff.c b/userdiff.c
> index 704af241e44..bbbbfa33e0a 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -128,6 +128,8 @@ IPATTERN("fountain",
>  	 /* -- */
>  	 "[^ \t-]+"),
>  PATTERNS("golang",
> +	 /* Packages */
> +	 "^(package[ \t][a-z][A-Za-z0-9_]+)[ \t]*\n"

Just a single whitespace character is permitted between the keyword and
the name?

>  	 /* Functions */
>  	 "^(func[ \t].*)\n"
>  	 /* Structs and interfaces */
> 

