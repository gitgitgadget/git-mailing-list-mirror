Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD8AC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 20:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F4D86101D
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 20:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhHJU6R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 16:58:17 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:44217 "EHLO bsmtp5.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231894AbhHJU6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 16:58:16 -0400
Received: from bsmtp2.bon.at (unknown [192.168.181.106])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 4Gkldr19TGz5tnZ
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 22:57:52 +0200 (CEST)
Received: from [192.168.1.103] (213-225-4-214.nat.highway.a1.net [213.225.4.214])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4Gkldm4Vmtz5tlB;
        Tue, 10 Aug 2021 22:57:47 +0200 (CEST)
Subject: Re: [PATCH v4] userdiff: improve java hunk header regex
To:     Tassilo Horn <tsdh@gnu.org>
References: <20210810190937.305765-1-tsdh@gnu.org>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Message-ID: <d3484278-8413-0d10-e6cd-59a7ff04564b@kdbg.org>
Date:   Tue, 10 Aug 2021 22:57:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210810190937.305765-1-tsdh@gnu.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.08.21 um 21:09 schrieb Tassilo Horn:
> Currently, the git diff hunk headers show the wrong method signature if the
> method has a qualified return type, an array return type, or a generic return
> type because the regex doesn't allow dots (.), [], or < and > in the return
> type.  Also, type parameter declarations couldn't be matched.
> 
> Add several t4018 tests asserting the right hunk headers for increasingly
> complex method signatures:
> 
>   public String[] myMethod(String[] RIGHT)
>   public List<String> myMethod(String[] RIGHT)
>   public <T> List<T> myMethod(T[] RIGHT)
>   public <AType, B> Map<AType, B> myMethod(String[] RIGHT)
>   public <AType, B> java.util.Map<AType, Map<B, B[]>> myMethod(String[] RIGHT)
>   public List<? extends Comparable> myMethod(String[] RIGHT)
>   public <T extends Serializable & Comparable<T>> List<T> myMethod(String[] RIGHT)
> 
> Signed-off-by: Tassilo Horn <tsdh@gnu.org>
> ---
>  t/t4018/java-constructor             |  6 ++++++
>  t/t4018/java-enum-constant           |  6 ++++++
>  t/t4018/java-nested-field            |  6 ++++++
>  t/t4018/java-return-array            |  6 ++++++
>  t/t4018/java-return-generic          |  6 ++++++
>  t/t4018/java-return-generic-bounded  |  6 ++++++
>  t/t4018/java-return-generic-wildcart |  6 ++++++
>  t/t4018/java-return-generic2         |  6 ++++++
>  t/t4018/java-return-generic3         |  6 ++++++
>  t/t4018/java-return-generic4         |  6 ++++++
>  userdiff.c                           | 23 ++++++++++++++++++++++-
>  11 files changed, 82 insertions(+), 1 deletion(-)
>  create mode 100644 t/t4018/java-constructor
>  create mode 100644 t/t4018/java-enum-constant
>  create mode 100644 t/t4018/java-nested-field
>  create mode 100644 t/t4018/java-return-array
>  create mode 100644 t/t4018/java-return-generic
>  create mode 100644 t/t4018/java-return-generic-bounded
>  create mode 100644 t/t4018/java-return-generic-wildcart
>  create mode 100644 t/t4018/java-return-generic2
>  create mode 100644 t/t4018/java-return-generic3
>  create mode 100644 t/t4018/java-return-generic4
> 

These new tests are very much appreciated. You do not have to go wild
with that many return type tests; IMO, the simple one and the most
complicated one should do it. (And btw, s/cart/card/)

> diff --git a/t/t4018/java-return-array b/t/t4018/java-return-array
> new file mode 100644
> index 0000000000..747638b9a8
> --- /dev/null
> +++ b/t/t4018/java-return-array
> @@ -0,0 +1,6 @@
> +class MyExample {
> +    public String[] myMethod(String[] RIGHT) {
> +        // Whatever...
> +        return new; // ChangeMe
> +    }
> +}
> diff --git a/userdiff.c b/userdiff.c
> index 3c3bbe38b0..9bd751b7d2 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -142,7 +142,28 @@ PATTERNS("html",
>  	 "[^<>= \t]+"),
>  PATTERNS("java",
>  	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
> -	 "^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
> +         "^[ \t]*("
> +         /* Class, enum, and interface declarations: */
> +         /*   optional modifiers: public */
> +         "(([a-z]+[ \t]+)*"
> +         /*   the kind of declaration */
> +         "(class|enum|interface)[ \t]+"
> +         /*   the name */
> +         "[A-Za-z][A-Za-z0-9_$]*[ \t]+.*)"
> +         /* Method & constructor signatures: */
> +         /*   optional modifiers: public static */
> +         "|(([a-z]+[ \t]+)*"
> +         /*   type params and return types for methods but not constructors */
> +         "("
> +         /*     optional type parameters: <A, B extends Comparable<B>> */
> +         "(<[A-Za-z0-9_,.&<> \t]+>[ \t]+)?"
> +         /*     return type: java.util.Map<A, B[]> or List<?> */
> +         "([A-Za-z_]([A-Za-z_0-9<>,.?]|\\[[ \t]*\\])*[ \t]+)+"
> +         /*   end of type params and return type */
> +         ")?"
> +         /*   the method name followed by the parameter list: myMethod(...) */
> +         "[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)"
> +         ")$",

I don't see the point in this complicated regex. Please recall that it
will be applied only to syntactically correct Java text. Therefore, you
do not have to implement all syntactical corner cases, just be
sufficiently permissive.

What is wrong with

	"^[ \t]*(([A-Za-z_][][?&<>.,A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[
\t]*\\([^;]*)$",

i.e. take every "token" until an identifier followed by an opening
parenthesis is found. Can types in Java contain parentheses? That would
make my suggested simplified regex too permissive, but otherwise it
would do its job, I would think.

-- Hannes
