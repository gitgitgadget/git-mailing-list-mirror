Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B30C3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 13:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB5AE21974
	for <git@archiver.kernel.org>; Sat,  2 May 2020 13:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgEBN6o (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 09:58:44 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:31914 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728070AbgEBN6o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 09:58:44 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 49DrLm0nSqz5tl9;
        Sat,  2 May 2020 15:58:39 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 14B40418C;
        Sat,  2 May 2020 15:58:39 +0200 (CEST)
Subject: Re: [PATCH v3] userdiff: support Markdown
To:     Ash Holland <ash@sorrel.sh>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Boxuan Li <liboxuan@connect.hku.hk>,
        Alban Gruin <alban.gruin@gmail.com>
Newsgroups: gmane.comp.version-control.git
References: <20200421010035.13915-1-ash@sorrel.sh>
 <20200502131544.30878-1-ash@sorrel.sh>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <40a1d950-d887-2518-f546-a2c2dc96e555@kdbg.org>
Date:   Sat, 2 May 2020 15:58:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200502131544.30878-1-ash@sorrel.sh>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.05.20 um 15:15 schrieb Ash Holland:
> It's typical to find Markdown documentation alongside source code, and
> having better context for documentation changes is useful; see also
> commit 69f9c87d4 (userdiff: add support for Fountain documents,
> 2015-07-21).
> 
> The pattern is based on the CommonMark specification 0.29, section 4.2
> <https://spec.commonmark.org/> but doesn't match empty headings, as
> seeing them in a hunk header is unlikely to be useful.
> 
> Only ATX headings are supported, as detecting setext headings would
> require printing the line before a pattern matches, or matching a
> multiline pattern. The word-diff pattern is the same as the pattern for
> HTML, because many Markdown parsers accept inline HTML.
> 
> Signed-off-by: Ash Holland <ash@sorrel.sh>
> ---
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
> index 000000000..c479c1a3f
> --- /dev/null
> +++ b/t/t4018/markdown-heading-non-headings
> @@ -0,0 +1,17 @@
> +Headings can be right next to other lines of the file:
> +# RIGHT
> +Indents of four or more spaces make a code block:
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
> diff --git a/userdiff.c b/userdiff.c
> index efbe05e5a..069a8284c 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -79,6 +79,9 @@ PATTERNS("java",
>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>  	 "|[-+*/<>%&^|=!]="
>  	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
> +PATTERNS("markdown",
> +	 "^ {0,3}#{1,6}[ \t].*",
> +	 "[^<>= \t]+"),
>  PATTERNS("matlab",
>  	 /*
>  	  * Octave pattern is mostly the same as matlab, except that '%%%' and
> 

I tested this patch, and it looks good:

Acked-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes
