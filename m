Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFFB61F461
	for <e@80x24.org>; Mon, 19 Aug 2019 18:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfHSSkw (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 14:40:52 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:60034 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbfHSSkw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 14:40:52 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 46C2mw6CB1z5tlG;
        Mon, 19 Aug 2019 20:40:48 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C3B622146;
        Mon, 19 Aug 2019 20:40:47 +0200 (CEST)
Subject: Re: [PATCH v2] userdiff: Add a builtin pattern for dts files
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     git@vger.kernel.org, Adrian Johnson <ajohnson@redneon.com>,
        William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
        Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
        devicetree@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <20190816225658.8946-1-sboyd@kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <98f9cdc2-fa9b-b639-b906-44b17f0efd76@kdbg.org>
Date:   Mon, 19 Aug 2019 20:40:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816225658.8946-1-sboyd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.08.19 um 00:56 schrieb Stephen Boyd:
> The Linux kernel receives many patches to the devicetree files each
> release. The hunk header for those patches typically show nothing,
> making it difficult to figure out what node is being modified without
> applying the patch or opening the file and seeking to the context. Let's
> add a builtin 'dts' pattern to git so that users can get better diff
> output on dts files when they use the diff=dts driver.
> 
> The regex has been constructed based on the spec at devicetree.org[1]
> 
> [1] https://github.com/devicetree-org/devicetree-specification/releases/latest
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
> 
> Sending this again after getting feedback and it getting stuck in
> review[1]. I'm not sure what happened with the meta question from Junio
> to add a way for various projects to introduce their own patterns, but
> I'd still prefer to have this in git proper because the kernel uses git
> extensively and we rely on git formatted patches in our workflow. I
> recently reviewed a dts change and remembered this never got accepted.
> 
> Changes from v1:
>  * Updated regex to handle anything after node names instead of
>    requiring a '{'
>  * Updated test for boolean relation operators
>  * Sent out a patch to devicetree spec to document % operator
> 
> [1] Feedback was in 16335abe-5e7e-fd7a-25f4-373f94e176e1@gmail.com

Thanks. I've a few suggestions below.

> diff --git a/t/t4018/dts-labels b/t/t4018/dts-labels
> new file mode 100644
> index 000000000000..27cd4921cfb6
> --- /dev/null
> +++ b/t/t4018/dts-labels
> @@ -0,0 +1,8 @@
> +/ {
> +	label_1: node1@ff00 {
> +		label2: RIGHT {
> +			vendor,some-property;
> +			ChangeMe = <0x45-30>;

In these tests, it would be worthwhile to leave another (possibly blank)
line before the ChangeMe line in order to demonstrate that lines
beginning with a word, such as the 'vendor,some-property;' line, are
_not_ picked up when they are not in the hunk context.

> +		};
> +	};
> +};
> diff --git a/t/t4018/dts-node-unitless b/t/t4018/dts-node-unitless
> new file mode 100644
> index 000000000000..c5287d91416e
> --- /dev/null
> +++ b/t/t4018/dts-node-unitless
> @@ -0,0 +1,8 @@
> +/ {
> +	label_1: node1 {
> +		RIGHT {
> +			prop-array = <1>, <4>;
> +			ChangeMe = <0xffeedd00>;
> +		};
> +	};
> +};
> diff --git a/t/t4018/dts-nodes b/t/t4018/dts-nodes
> new file mode 100644
> index 000000000000..5a4334bb1645
> --- /dev/null
> +++ b/t/t4018/dts-nodes
> @@ -0,0 +1,8 @@
> +/ {
> +	label_1: node1@ff00 {
> +		RIGHT@deadf00,4000 {
> +			#size-cells = <1>;
> +			ChangeMe = <0xffeedd00>;
> +		};
> +	};
> +};
> diff --git a/t/t4018/dts-reference b/t/t4018/dts-reference
> new file mode 100644
> index 000000000000..f115d4291d25
> --- /dev/null
> +++ b/t/t4018/dts-reference
> @@ -0,0 +1,8 @@
> +&label_1 {
> +	TEST = <455>;
> +};
> +
> +&RIGHT {
> +	vendor,some-property;
> +	ChangeMe = <0x45-30>;
> +};
> diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
> index 912df91226f2..9a93c2a3e0dd 100755
> --- a/t/t4034-diff-words.sh
> +++ b/t/t4034-diff-words.sh
> @@ -303,6 +303,7 @@ test_language_driver bibtex
>  test_language_driver cpp
>  test_language_driver csharp
>  test_language_driver css
> +test_language_driver dts
>  test_language_driver fortran
>  test_language_driver html
>  test_language_driver java
> diff --git a/t/t4034/dts/expect b/t/t4034/dts/expect
> new file mode 100644
> index 000000000000..560fc9918476
> --- /dev/null
> +++ b/t/t4034/dts/expect
> @@ -0,0 +1,37 @@
> +<BOLD>diff --git a/pre b/post<RESET>
> +<BOLD>index b6a9051..7803aee 100644<RESET>
> +<BOLD>--- a/pre<RESET>
> +<BOLD>+++ b/post<RESET>
> +<CYAN>@@ -1,32 +1,32 @@<RESET>
> +/ {<RESET>
> +	<RED>this_handle<RESET><GREEN>HANDLE_2<RESET>: <RED>node<RESET><GREEN>new-node<RESET>@<RED>f00<RESET><GREEN>eeda<RESET> {
> +		compatible = "<RED>mydev<RESET><GREEN>vendor,compat<RESET>";
> +		string-prop = <RED>start<RESET><GREEN>end<RESET>: "hello <RED>world!<RESET><GREEN>world?<RESET>" <RED>end<RESET><GREEN>start<RESET>: ;
> +		<RED>#size-cells<RESET><GREEN>#address-cells<RESET> = <<RED>0+0<RESET><GREEN>0+40<RESET>>;
> +		reg = <<RED>0xf00<RESET><GREEN>0xeeda<RESET>>;
> +		prop = <<GREEN>(<RESET>1<GREEN>)<RESET>>;
> +		prop = <<GREEN>(<RESET>-1e10<GREEN>)<RESET>>;
> +		prop = <(!<RED>3<RESET><GREEN>1<RESET>)>;
> +		prop = <(~<RED>3<RESET><GREEN>1<RESET>)>;
> +		prop = <(<RED>3<RESET><GREEN>1<RESET>*<RED>4<RESET><GREEN>2<RESET>)>;
> +		prop = <(<RED>3<RESET><GREEN>1<RESET>&<RED>4<RESET><GREEN>2<RESET>)>;
> +		prop = <(<RED>3<RESET><GREEN>1<RESET>*<RED>4<RESET><GREEN>2<RESET>)>;
> +		prop = <(<RED>3<RESET><GREEN>1<RESET>/<RED>4<RESET><GREEN>2<RESET>)>;
> +		prop = <(<RED>3<RESET><GREEN>1<RESET>%<RED>4<RESET><GREEN>2<RESET>)>;
> +		prop = <(<RED>3+4<RESET><GREEN>1+2<RESET>)>;
> +		prop = <(<RED>3-4<RESET><GREEN>1-2<RESET>)>;
> +		prop = /bits/ <RED>64<RESET><GREEN>32<RESET> <(<RED>3<RESET><GREEN>1<RESET><<<RED>4<RESET><GREEN>2<RESET>)>;
> +		prop = <(<RED>3<RESET><GREEN>1<RESET>>><RED>4<RESET><GREEN>2<RESET>)>;
> +		prop = <(<RED>3<RESET><GREEN>1<RESET>&<RED>4<RESET><GREEN>2<RESET>)>;
> +		prop = <(<RED>3<RESET><GREEN>1<RESET>^<RED>4<RESET><GREEN>2<RESET>)>;
> +		prop = <(<RED>3<RESET><GREEN>1<RESET>|<RED>4<RESET><GREEN>2<RESET>)>;
> +		prop = <(<RED>3<RESET><GREEN>1<RESET>&&<RED>4<RESET><GREEN>2<RESET>)>;
> +		prop = <(<RED>3<RESET><GREEN>1<RESET>||<RED>4<RESET><GREEN>2<RESET>)>;
> +		prop = <(<RED>4?5<RESET><GREEN>1?2<RESET>:3)>;
> +		list = <&<RED>this_handle<RESET><GREEN>HANDLE_2<RESET>>, <0 0 0 <RED>0<RESET><GREEN>1<RESET>>;
> +	};<RESET>
> +
> +	&<RED>phandle<RESET><GREEN>phandle2<RESET> {
> +		<RED>pre-phandle<RESET><GREEN>prop_handle<RESET> = <&<RED>this_handle<RESET><GREEN>HANDLE_2<RESET>>;
> +	};<RESET>
> +};<RESET>
> diff --git a/t/t4034/dts/post b/t/t4034/dts/post
> new file mode 100644
> index 000000000000..7803aee28093
> --- /dev/null
> +++ b/t/t4034/dts/post
> @@ -0,0 +1,32 @@
> +/ {
> +	HANDLE_2: new-node@eeda {
> +		compatible = "vendor,compat";
> +		string-prop = end: "hello world?" start: ;
> +		#address-cells = <0+40>;
> +		reg = <0xeeda>;
> +		prop = <(1)>;
> +		prop = <(-1e10)>;
> +		prop = <(!1)>;
> +		prop = <(~1)>;
> +		prop = <(1*2)>;
> +		prop = <(1&2)>;
> +		prop = <(1*2)>;
> +		prop = <(1/2)>;
> +		prop = <(1%2)>;
> +		prop = <(1+2)>;
> +		prop = <(1-2)>;
> +		prop = /bits/ 32 <(1<<2)>;
> +		prop = <(1>>2)>;
> +		prop = <(1&2)>;
> +		prop = <(1^2)>;
> +		prop = <(1|2)>;
> +		prop = <(1&&2)>;
> +		prop = <(1||2)>;
> +		prop = <(1?2:3)>;
> +		list = <&HANDLE_2>, <0 0 0 1>;
> +	};
> +
> +	&phandle2 {
> +		prop_handle = <&HANDLE_2>;
> +	};
> +};
> diff --git a/t/t4034/dts/pre b/t/t4034/dts/pre
> new file mode 100644
> index 000000000000..b6a905113c22
> --- /dev/null
> +++ b/t/t4034/dts/pre
> @@ -0,0 +1,32 @@
> +/ {
> +	this_handle: node@f00 {
> +		compatible = "mydev";
> +		string-prop = start: "hello world!" end: ;
> +		#size-cells = <0+0>;
> +		reg = <0xf00>;
> +		prop = <1>;
> +		prop = <-1e10>;
> +		prop = <(!3)>;
> +		prop = <(~3)>;
> +		prop = <(3*4)>;
> +		prop = <(3&4)>;
> +		prop = <(3*4)>;
> +		prop = <(3/4)>;
> +		prop = <(3%4)>;
> +		prop = <(3+4)>;
> +		prop = <(3-4)>;
> +		prop = /bits/ 64 <(3<<4)>;
> +		prop = <(3>>4)>;
> +		prop = <(3&4)>;
> +		prop = <(3^4)>;
> +		prop = <(3|4)>;
> +		prop = <(3&&4)>;
> +		prop = <(3||4)>;
> +		prop = <(4?5:3)>;
> +		list = <&this_handle>, <0 0 0 0>;
> +	};
> +
> +	&phandle {
> +		pre-phandle = <&this_handle>;
> +	};
> +};
> diff --git a/userdiff.c b/userdiff.c
> index e74a6d402255..1db5d30aaebe 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -23,6 +23,15 @@ IPATTERN("ada",
>  	 "[a-zA-Z][a-zA-Z0-9_]*"
>  	 "|[-+]?[0-9][0-9#_.aAbBcCdDeEfF]*([eE][+-]?[0-9_]+)?"
>  	 "|=>|\\.\\.|\\*\\*|:=|/=|>=|<=|<<|>>|<>"),
> +PATTERNS("dts",
> +	 /* Node name with optional label and unit address */
> +	 "^[ \t]*((([a-zA-Z_][a-zA-Z0-9_]*:[ \t]*)?[a-zA-Z][a-zA-Z0-9,._+-]*(@[a-zA-Z0-9,._+-]+)?"

From the examples I see in this patch, it looks like lines ending in a
';' are not candidates, everything that begins with 'word' or '&word'
is. Wouldn't that greatly simplify these patterns?

	"!;\n"
	/* lines beginning with a word optionally preceded by '&' */
	"^[ \t]*(&?([a-zA-Z_].*)"

> +	 /* Reference */
> +	 "|&[a-zA-Z_][a-zA-Z0-9_]*)[ \t]*[^;]*)$",

Note that you don't have to replicate the syntax faithfully in the
patterns because you can assume that files adhere to the correct syntax.
You could merge this into the former pattern by just matching "&?" after
the initial whitespace.

> +	 /* -- */
> +	 /* Property names and math operators */
> +	 "[a-zA-Z0-9,._+?#-]+"
> +	 "|[-+*/%&^|!~]|>>|<<|&&|\\|\\|"),
>  IPATTERN("fortran",
>  	 "!^([C*]|[ \t]*!)\n"
>  	 "!^[ \t]*MODULE[ \t]+PROCEDURE[ \t]\n"
> 

-- Hannes
