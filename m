Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCE2C3A5A3
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 21:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350815AbiDDVVP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380573AbiDDUb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 16:31:29 -0400
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9763436E2D
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 13:29:32 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4KXMnk4VtBz5tlF;
        Mon,  4 Apr 2022 22:29:30 +0200 (CEST)
Message-ID: <660d068f-1c8c-7057-0a92-5100791daf80@kdbg.org>
Date:   Mon, 4 Apr 2022 22:29:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [GSoC][PATCH v3] Add a diff driver for JavaScript languages.
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        xing zhi jiang <a97410985new@gmail.com>
Cc:     git@vger.kernel.org, chooglen@google.com
References: <20220304130854.857746-1-a97410985new@gmail.com>
 <20220403132508.28196-1-a97410985new@gmail.com>
 <220404.86lewljovj.gmgdl@evledraar.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <220404.86lewljovj.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.04.22 um 09:12 schrieb Ævar Arnfjörð Bjarmason:
> While we don't use helper macros for these currently there's no reason
> we can't, I thin the above might be more readable with e.g.:
> 
> 	#define JS_AA "[$_[:alpha:]][$_[:alnum:]]"

Please consider including "identifier" somehow in the macro name. And
add the trailing '*', which...

> Which would make this:
> 	
> 	+PATTERNS("javascript",
> 	+	 /* don't match the expression may contain parenthesis, because it is not a function declaration */
> 	+	 "!^[ \t]*(if|do|while|for|with|switch|catch|import|return)\n"
> 	+	 /* don't match statement */
> 	+	 "!;\n"
> 	+	 /* match normal function or named export for function in ECMA2015 */
> 	+	 "^((export[\t ]+)?(async[\t ]+)?function[\t ]*[\t *]*" JS_AA "*[\t ]*\\(.*)\n"
> 	+	 /* match JavaScript variable declaration with a lambda expression at top level */
> 	+	 "^((const|let|var)[\t ]*" JS_AA "*[\t ]*=[\t ]*"
> 	+		"(\\(.*\\)|" JS_AA "*)[\t ]*=>[\t ]*\\{?)\n"
> 	+	 /* match object's property assignment by anonymous function and CommonJS exports for named function */
> 	+	 "^((module\\.)?" JS_AA "*\\." JS_AA "*[\t ]*=[\t ]*(async[\t ]+)?(\\(.*\\)|" JS_AA "*)[\t ]*=>.*)\n"
> 	+	 /* match assign function to LHS with explicit function keyword */
> 	+	 "^(.*=[\t ]*function[\t ]*([$_[:alnum:]]+[\t ]*)?\\(.*)\n"
> 	+	 /* popular unit testing framework test case pattern. Most of framework pattern is match by regex for "function in class" */
> 
> Wry try to stick to wrapping at 80 characters, so some of these comments
> should really be wrapped (see CodingGuidelines for the multi-line
> comment style we use).
> 
> 	+	 "^[\t ]*(QUnit.test\\(.*)\n"
> 	+	 /* don't match the function in class or in object literal, which has more than one ident level */
> 	+	 "!^(\t{2,}|[ ]{5,})\n"
> 	+	 /* match normal function in object literal */
> 	+	 "^[\t ]*(" JS_AA "*[\t ]*:[\t ]*function.*)\n"
> 	+	 /* don't match chained method call */
> 	+	 "!^[\t ]*" JS_AA "[\t ]*\\(.*\\)\\.\n"

... which makes me wonder why it is not present here. If that's an
oversight: nice catch!

> 	+	 /* match function in class and ES5 method shorthand */
> 	+	 "^[\t ]*((static[\t ]+)?((async|get|set)[\t ]+)?" JS_AA "*[\t ]*\\(.*)",
> 	+	 /* word regex */
> 	+	 /* hexIntegerLiteral, octalIntegerLiteral, binaryIntegerLiteral, and its big version */
> 	+	 "0[xXoObB][_0-9a-fA-F]+n?"
> 	+	 /* DecimalLiteral and its big version*/
> 	+	 "|[0-9][_0-9]*(\\.[0-9][_0-9]*|n)?([eE][+-]?[_0-9]+)?"
> 	+	 "|\\.[0-9][_0-9]*([eE][+-]?[_0-9]+)?"
> 	+	 /* punctuations */
> 	+	 "|\\.{3}|<=|>=|==|!=|={3}|!==|\\*{2}|\\+{2}|--|<<|>>"
> 	+	 "|>>>|&&|\\|{2}|\\?{2}|\\+=|-=|\\*=|%=|\\*{2}="
> 	+	 "|<<=|>>=|>>>=|&=|\\|=|\\^=|&&=|\\|{2}=|\\?{2}=|=>"
> 	+	 /* identifiers */
> 	+	 "|" JS_AA "*"),
> 	
> Just a thought, I wonder how much line-noisy we could make this thing in
> general if we defined some common patterns with such helpers.
> 
> Anyway, insted of :alnum:and :alpha: don't you really mean [a-zA-Z0-9]
> and [a-zA-Z]. I.e. do you *really* want to have this different depending
> on the user's locale?

That's worth considering.

> 
> I haven't tested, but see the LC_CTYPE in gettext.c, so I'm fairly sure
> that'll happen...
> 

-- Hannes
