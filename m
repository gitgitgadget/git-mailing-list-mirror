Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B53861F462
	for <e@80x24.org>; Mon, 20 May 2019 19:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfETTwW (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 15:52:22 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:56266 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfETTwW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 15:52:22 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 4578gT0xDGz5tlG;
        Mon, 20 May 2019 21:52:21 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id B8B7D20E7;
        Mon, 20 May 2019 21:52:20 +0200 (CEST)
Subject: Re: [PATCH v3] userdiff: add built-in pattern for rust
To:     marcandre.lureau@redhat.com
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <mlureau@redhat.com>
References: <20190520170403.16672-1-marcandre.lureau@redhat.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <e1c4c2ab-927d-fff9-b9e7-13943cba2273@kdbg.org>
Date:   Mon, 20 May 2019 21:52:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520170403.16672-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.05.19 um 19:04 schrieb marcandre.lureau@redhat.com:
> From: Marc-André Lureau <mlureau@redhat.com>
> 
> This adds xfuncname and word_regex patterns for Rust, a quite
> popular programming language. It also includes test cases for the
> xfuncname regex (t4018) and updated documentation.
> 
> The word_regex pattern finds identifiers, integers, floats and
> operators, according to the Rust Reference Book.

This looks very good. I have a few questions regarding the hunk header
regex.

> diff --git a/userdiff.c b/userdiff.c
> index 3a78fbf504..e45b5920c6 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -130,6 +130,12 @@ PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
>  	 "(@|@@|\\$)?[a-zA-Z_][a-zA-Z0-9_]*"
>  	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
>  	 "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"),
> +PATTERNS("rust",
> +	 "^[\t ]*((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl(<.+>)?)[ \t]+[^;]*)$",

This pattern matches only if there is no semicolon behind the signal
words on the line. Is that important? Can you show a (test) case where a
line with a semicolon would be picked incorrectly if '[^;]*' were
simplified to '.*'?

You permit whitespace at the beginning of an anchor line. I guess that
is to catch nested definitions. Or is it common style to write indented
code? Can you show a test case where this makes sense?

Would it be sufficient to simplify

    (struct|enum|union|mod|trait|fn|impl(<.+>)?)[ \t]+
to
    (struct|enum|union|mod|trait|fn|impl)[< \t]+

as it is only important to exclude identifiers that start with these
keywords.

> +	 /* -- */
> +	 "[a-zA-Z_][a-zA-Z0-9_]*"
> +	 "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"
> +	 "|[-+*\\/<>%&^|=!:]=|<<=?|>>=?|&&|\\|\\||->|=>|\\.{2}=|\\.{3}|::"),
>  PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
>  	 "[={}\"]|[^={}\" \t]+"),
>  PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
> 
> base-commit: aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6

-- Hannes
