Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66E8C54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 18:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A95A420767
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 18:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgDWSRp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:17:45 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:57968 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730042AbgDWSRp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 14:17:45 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 497QWn6xhQz5tlC;
        Thu, 23 Apr 2020 20:17:41 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 37CC32817;
        Thu, 23 Apr 2020 20:17:41 +0200 (CEST)
Subject: Re: [PATCH] userdiff: support Markdown
To:     Ash Holland <ash@sorrel.sh>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Boxuan Li <liboxuan@connect.hku.hk>,
        Alban Gruin <alban.gruin@gmail.com>
References: <20200421010035.13915-1-ash@sorrel.sh>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <33f037a9-d3d5-042a-d3ba-7e4b8364663a@kdbg.org>
Date:   Thu, 23 Apr 2020 20:17:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421010035.13915-1-ash@sorrel.sh>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.04.20 um 03:00 schrieb Ash Holland:
> It's typical to find Markdown documentation alongside source code, and
> having better context for documentation changes is useful; see also
> commit 69f9c87d4 (userdiff: add support for Fountain documents,
> 2015-07-21).
> 
> The pattern is based on the CommonMark specification 0.29, section 4.2:
> https://spec.commonmark.org/
> 
> Only ATX headings are supported, as detecting setext headings would
> require printing the line before a pattern matches, or matching a
> multiline pattern.

The patch looks good. I have one question about the patthern, though
(see below).

> Signed-off-by: Ash Holland <ash@sorrel.sh>
> ---
> 
> If it is indeed possible to match multiline patterns, let me know! I
> would love to support setext (underlined) headings with this.

We don't have multi-line matching, unfortunately.

> I would also appreciate feedback on the word-diff pattern here, I have
> no real idea what should constitute a word in a Markdown document, apart
> from that it should probably be similar to the definition given for
> Fountain, given that Fountain appears to have somewhat similar inline
> syntax to Markdown.
> 
>  Documentation/gitattributes.txt       |  2 ++
>  t/t4018-diff-funcname.sh              |  1 +
>  t/t4018/markdown-heading-indented     |  6 ++++++
>  t/t4018/markdown-heading-non-headings | 17 +++++++++++++++++
>  userdiff.c                            |  3 +++
>  5 files changed, 29 insertions(+)
>  create mode 100644 t/t4018/markdown-heading-indented
>  create mode 100644 t/t4018/markdown-heading-non-headings
> 
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 508fe713c..2d0a03715 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -824,6 +824,8 @@ patterns are available:
>  
>  - `java` suitable for source code in the Java language.
>  
> +- `markdown` suitable for Markdown documents.
> +
>  - `matlab` suitable for source code in the MATLAB and Octave languages.
>  
>  - `objc` suitable for source code in the Objective-C language.
> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
> index 02255a08b..9d0779757 100755
> --- a/t/t4018-diff-funcname.sh
> +++ b/t/t4018-diff-funcname.sh
> @@ -38,6 +38,7 @@ diffpatterns="
>  	golang
>  	html
>  	java
> +	markdown
>  	matlab
>  	objc
>  	pascal
> diff --git a/t/t4018/markdown-heading-indented b/t/t4018/markdown-heading-indented
> new file mode 100644
> index 000000000..1991c2bd4
> --- /dev/null
> +++ b/t/t4018/markdown-heading-indented
> @@ -0,0 +1,6 @@
> +Indented headings are allowed, as long as the indent is no more than 3 spaces.
> +
> +   ### RIGHT
> +
> +- something
> +- ChangeMe
> diff --git a/t/t4018/markdown-heading-non-headings b/t/t4018/markdown-heading-non-headings
> new file mode 100644
> index 000000000..1f19b91d6
> --- /dev/null
> +++ b/t/t4018/markdown-heading-non-headings
> @@ -0,0 +1,17 @@
> +Headings can be right next to other lines of the file:
> +# RIGHT
> +Indents of more than four spaces make a code block:
> +
> +    # code comment, not heading
> +
> +If there's no space after the final hash, it's not a heading:
> +
> +#hashtag
> +
> +Sequences of more than 6 hashes don't make a heading:
> +
> +####### over-enthusiastic heading
> +
> +So the detected heading should be right up at the start of this file.
> +
> +ChangeMe

Nicely done!

> diff --git a/userdiff.c b/userdiff.c
> index efbe05e5a..f79adb3a3 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -79,6 +79,9 @@ PATTERNS("java",
>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>  	 "|[-+*/<>%&^|=!]="
>  	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
> +PATTERNS("markdown",
> +	 "^ {0,3}#{1,6}( .*)?$",

What is the purpose of making the heading text optional? Why would you
want to match a sequence of hash marks without any text following it?

> +	 "[^ \t-]+"),
>  PATTERNS("matlab",
>  	 /*
>  	  * Octave pattern is mostly the same as matlab, except that '%%%' and
> 

-- Hannes
