Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610D5C433F5
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 14:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244969AbiDCOmV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 10:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiDCOmV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 10:42:21 -0400
Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073AB205E1
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 07:40:25 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4KWc5L0rWmz5tlC;
        Sun,  3 Apr 2022 16:40:22 +0200 (CEST)
Message-ID: <595d535d-3d3e-9994-0b80-4521a753c74c@kdbg.org>
Date:   Sun, 3 Apr 2022 16:40:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [GSoC][PATCH v3] Add a diff driver for JavaScript languages.
Content-Language: en-US
To:     xing zhi jiang <a97410985new@gmail.com>
Cc:     chooglen@google.com, git@vger.kernel.org
References: <20220304130854.857746-1-a97410985new@gmail.com>
 <20220403132508.28196-1-a97410985new@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20220403132508.28196-1-a97410985new@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.04.22 um 15:25 schrieb xing zhi jiang:
> In the xfunction part that matches normal functions,
> a variable declaration with an assignment of function, the function declaration
> in the class, named export for function in ECMA2015, CommonJS exports for
> named function, and also the function is object literal's property[1].
> The special match is this would match the popular framework test case
> pattern(most is same as regex for matching function in class).
> 
> And in the word regex part, that matches numbers, punctuations, and also the
> JavaScript identifier.
> This part reference the formal ECMA specification[2].
> 
> [1]https://github.com/jquery/jquery/blob/de5398a6ad088dc006b46c6a870a2a053f4cd663/src/core.js#L201
> [2]https://262.ecma-international.org/12.0/#sec-ecmascript-language-lexical-grammar
> 
> Signed-off-by: xing zhi jiang <a97410985new@gmail.com>
> ---
> I write a simple python script to help me observe the diff's results easier. 
> And the result is in https://github.com/a97410985/user_diff_observe_tool.
> I observe the six popular JavaScript projects - Jquery, NodeJS, React, TensorflowJS, 
> Vue, and Webpack. The result is not perfect but acceptable.
> Most of the mismatch is related to the function in class. Ex:
> https://github.com/a97410985/user_diff_observe_tool/blob/092bd14c849b9a3f61bb872d730e38b58cc9c303/diff_result/jquery_result.diff#L1094.
> But this is inevitable.
> And besides, apply the code reviews suggestions. I add some new regex.
> 1. "!^[\t ]*[$_[:alpha:]][$_[:alnum:]][\t ]*\\(.*\\)\\.\n"
>    this is for the case below
>    `
>     function RIGHT(a, b) {
> 
>         WRONG(spy.calls.count()).toBe(1)
>         return a + b; // ChangeMe
>     }
>    `
>    if we don't skip chained function call. This would happen mismatch.

OK, but see below.

> 2. "^[\t ]*(QUnit.test\\(.*)\n"
>    I oberve there are many test case pattern in JavaScript. And most of popular JavaScript
>    unit test framework's test case pattern is function call can be matched by the regex, which
>    match "function in class". So it is no problem. But `QUnit framework` don't matched by that.
>    Then add this regex into JavaScript userdiff.
>    And the reason includes test case pattern has two
>    1. This is inevitable. Because we can't distinguish that with function in class.
>    2. This can help the user understand what change is happening in which test case. And if 
>       don't match the test case, it has the large possibility to match no related function.

Good. I consider this like matching a language keyword. If additional
patterns of this kind occur, they can be added later, but we must make
sure that this does not proliferate.

>       
> And I move the regex, which match normal function in object literal, under the regex 
> ""!^(\t{2,}|[ ]{5,})\n".
> Because I found it would many mismatch if function in object literal has too many indent level(
> the function body usually just few lines of code, and the below has large of code. If has change
> on below, it would happen mismatch).
> And there are two example for hunk header that match test case pattern.

OK.

> diff --git a/t/t4018/javascript-skip-chained-function b/t/t4018/javascript-skip-chained-function
> new file mode 100644
> index 0000000000..4ce23901cf
> --- /dev/null
> +++ b/t/t4018/javascript-skip-chained-function
> @@ -0,0 +1,5 @@
> +function RIGHT(a, b) {
> +
> +  expect(spy.calls.count()).toBe(1)
> +  return a + b; // ChangeMe
> +}

This is the test case that attempts to make sure that the chained
function calls are not matched. But since there is no line between
ChangeMe and the not-to-be-matched line, this test case would not detect
such an incorrect match. You have to insert a line between expect... and
return...ChangeMe

> diff --git a/userdiff.c b/userdiff.c
> index 8578cb0d12..306286df35 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -168,6 +168,43 @@ PATTERNS("java",
>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>  	 "|[-+*/<>%&^|=!]="
>  	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
> +
> +PATTERNS("javascript",
> +	 /* don't match the expression may contain parenthesis, because it is not a function declaration */
> +	 "!^[ \t]*(if|do|while|for|with|switch|catch|import|return)\n"
> +	 /* don't match statement */
> +	 "!;\n"
> +	 /* match normal function or named export for function in ECMA2015 */
> +	 "^((export[\t ]+)?(async[\t ]+)?function[\t ]*[\t *]*[$_[:alpha:]][$_[:alnum:]]*[\t ]*\\(.*)\n"
> +	 /* match JavaScript variable declaration with a lambda expression at top level */
> +	 "^((const|let|var)[\t ]*[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*"
> +		"(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>[\t ]*\\{?)\n"
> +	 /* match object's property assignment by anonymous function and CommonJS exports for named function */
> +	 "^((module\\.)?[$_[:alpha:]][$_[:alnum:]]*\\.[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*(async[\t ]+)?(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>.*)\n"
> +	 /* match assign function to LHS with explicit function keyword */
> +	 "^(.*=[\t ]*function[\t ]*([$_[:alnum:]]+[\t ]*)?\\(.*)\n"
> +	 /* popular unit testing framework test case pattern. Most of framework pattern is match by regex for "function in class" */
> +	 "^[\t ]*(QUnit.test\\(.*)\n"
> +	 /* don't match the function in class or in object literal, which has more than one ident level */
> +	 "!^(\t{2,}|[ ]{5,})\n"
> +	 /* match normal function in object literal */
> +	 "^[\t ]*([$_[:alpha:]][$_[:alnum:]]*[\t ]*:[\t ]*function.*)\n"
> +	 /* don't match chained method call */
> +	 "!^[\t ]*[$_[:alpha:]][$_[:alnum:]][\t ]*\\(.*\\)\\.\n"
> +	 /* match function in class and ES5 method shorthand */
> +	 "^[\t ]*((static[\t ]+)?((async|get|set)[\t ]+)?[$_[:alpha:]][$_[:alnum:]]*[\t ]*\\(.*)",

No objections to these expressions.

> +	 /* word regex */
> +	 /* hexIntegerLiteral, octalIntegerLiteral, binaryIntegerLiteral, and its big version */
> +	 "0[xXoObB][_0-9a-fA-F]+n?"
> +	 /* DecimalLiteral and its big version*/
> +	 "|[0-9][_0-9]*(\\.[0-9][_0-9]*|n)?([eE][+-]?[_0-9]+)?"
> +	 "|\\.[0-9][_0-9]*([eE][+-]?[_0-9]+)?"
> +	 /* punctuations */
> +	 "|\\.{3}|<=|>=|==|!=|={3}|!==|\\*{2}|\\+{2}|--|<<|>>"
> +	 "|>>>|&&|\\|{2}|\\?{2}|\\+=|-=|\\*=|%=|\\*{2}="
> +	 "|<<=|>>=|>>>=|&=|\\|=|\\^=|&&=|\\|{2}=|\\?{2}=|=>"
> +	 /* identifiers */
> +	 "|[$_[:alpha:]][$_[:alnum:]]*"),

These word-regexs look good.

>  PATTERNS("markdown",
>  	 "^ {0,3}#{1,6}[ \t].*",
>  	 /* -- */

This round looks quite good. With the one issue I noted above fixed,
this should be good to go, IMO.

-- Hannes
