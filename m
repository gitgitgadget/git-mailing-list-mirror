Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B4091F731
	for <e@80x24.org>; Fri,  9 Aug 2019 17:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405964AbfHIRN3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 13:13:29 -0400
Received: from siwi.pair.com ([209.68.5.199]:43490 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbfHIRN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 13:13:29 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 235493F40E6;
        Fri,  9 Aug 2019 13:13:27 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:41b9:ba9c:6c99:96cc] (unknown [IPv6:2001:4898:a800:1012:f2ec:ba9c:6c99:96cc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C29093F40D3;
        Fri,  9 Aug 2019 13:13:26 -0400 (EDT)
Subject: Re: [PATCH v2 5/7] quote: add sq_quote_argv_pretty_ltrim
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.298.git.gitgitgadget@gmail.com>
 <pull.298.v2.git.gitgitgadget@gmail.com>
 <5059776248b6686faaff37c97aa63d0212579cd8.1565273938.git.gitgitgadget@gmail.com>
 <xmqqh86rfs70.fsf@gitster-ct.c.googlers.com>
 <7dbee619-2495-6426-b02b-49fd59e4f028@jeffhostetler.com>
 <60c7b26c-e598-182b-421e-bdf5c0a8ac9f@web.de>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <5651286b-cd28-68ba-4743-98d546dfa3b0@jeffhostetler.com>
Date:   Fri, 9 Aug 2019 13:13:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <60c7b26c-e598-182b-421e-bdf5c0a8ac9f@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/8/2019 6:49 PM, René Scharfe wrote:
> Am 08.08.19 um 21:04 schrieb Jeff Hostetler:
>> On 8/8/2019 2:05 PM, Junio C Hamano wrote:
>>> Having made the primary purpose of the helper clearer leads me to
>>> wonder if "do not add SP before the first element, i.e. argv[0]", is
>>> really what we want.  If we always clear the *dst strbuf before
>>> starting to serialize argv[] into it, then the behaviour would make
>>> sense, but we do not---we are "appending".
>>>
>>> As long as we are appending, would we be better off doing something
>>> sillily magical like this instead, I have to wonder?
>>>
>>>      void sq_append_strings_quoted(struct strbuf *buf, const char **av)
>>>      {
>>>          int i;
>>>
>>>          for (i = 0; av[i]; i++) {
>>>              if (buf->len)
>>>                  strbuf_addch(buf, ' ');
>>>              sq_quote_buf_pretty(buf, argv[0]);
>>>          }
>>>      }
>>>
>>> That is, "if we are appending to an existing string, have SP to
>>> separate the first element from that existing string; treat the
>>> remaining elements the same way (if the buffer is empty, there is no
>>> point adding SP at the beginning)".
>>
>> I don't think that would do what we want.  We don't know what the
>> caller's expectations are.  In my uses in commits 6/7 and 7/7 I
>> already added the leading chars I wanted in the strbuf before calling
>> sq_quote_argv_pretty_ltrim() and assumed the output would be a true
>> append.  For example:
>>
>> +    strbuf_addf(&buf_payload, "alias:%s argv:[", alias);
>> +    sq_quote_argv_pretty_ltrim(&buf_payload, argv);
>> +    strbuf_addch(&buf_payload, ']');
>>
>> I like your suggestion of putting my new function in the _append_
>> category.  I think I'll add the 3rd arg to this and then it will
>> be completely specified and I can get rid of the _ltrim suffix.
> 
> Two observations:
> 
> If callers want to add something before a joined delimited list, they
> already can with a strbuf_add* call.  No need to add that feature to
> a function that joins lists.
> 
> And repetitions of repetitions (loops) are boring.
> 
> Apologies in advance for any coffee stains on your monitor, but
> here's how I would start, probably followed by attempts to inline the
> functions that become trivial wrappers:


Um, yeah, I must say that I didn't expect the conversation to turn to
map-style functions and a change in design styles.  I think it would be
better to have that conversation in a different patch series and not mix
it with my trace2 janitoring.

I'm going to push a V3 that does just the minimum to have a sq_ function
that joins the args with a space delimiter (and without the leading
space) and re-write the existing function to call it after adding the
legacy leading space.  This will let existing callers continue to work
as is.  And they can be converted if/when anyone wants to dig into them.


> 
> ---
>   quote.c  | 18 ++++--------------
>   strbuf.c | 20 +++++++++++++-------
>   strbuf.h |  8 ++++++++
>   3 files changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/quote.c b/quote.c
> index 7f2aa6faa4..f422188852 100644
> --- a/quote.c
> +++ b/quote.c
> @@ -74,24 +74,14 @@ void sq_quotef(struct strbuf *dst, const char *fmt, ...)
> 
>   void sq_quote_argv(struct strbuf *dst, const char **argv)
>   {
> -	int i;
> -
> -	/* Copy into destination buffer. */
> -	strbuf_grow(dst, 255);
> -	for (i = 0; argv[i]; ++i) {
> -		strbuf_addch(dst, ' ');
> -		sq_quote_buf(dst, argv[i]);
> -	}
> +	strbuf_addch(dst, ' ');
> +	strbuf_map_join_argv(dst, argv, sq_quote_buf, " ");
>   }
> 
>   void sq_quote_argv_pretty(struct strbuf *dst, const char **argv)
>   {
> -	int i;
> -
> -	for (i = 0; argv[i]; i++) {
> -		strbuf_addch(dst, ' ');
> -		sq_quote_buf_pretty(dst, argv[i]);
> -	}
> +	strbuf_addch(dst, ' ');

If I'm reading this correctly, this has slightly different behavior
than the original version.  Perhaps:

	if (argv[0])
		strbuf_addch(dst, ' ');

> +	strbuf_map_join_argv(dst, argv, sq_quote_buf_pretty, " ");
>   }
> 
>   static char *sq_dequote_step(char *arg, char **next)
> diff --git a/strbuf.c b/strbuf.c
> index d30f916858..d337853b53 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -304,17 +304,23 @@ void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2)
>   	strbuf_setlen(sb, sb->len + sb2->len);
>   }
> 
> +void strbuf_map_join_argv(struct strbuf *sb, const char **argv,
> +			  void (*fn)(struct strbuf *, const char *),
> +			  const char *separator)
> +{
> +	while (*argv) {
> +		fn(sb, *argv++);
> +		if (*argv)
> +			strbuf_addstr(sb, separator);
> +	}
> +}
> +
>   const char *strbuf_join_argv(struct strbuf *buf,
>   			     int argc, const char **argv, char delim)
>   {
> -	if (!argc)
> -		return buf->buf;
> +	char separator[] = { delim, '\0' };
> 
> -	strbuf_addstr(buf, *argv);
> -	while (--argc) {
> -		strbuf_addch(buf, delim);
> -		strbuf_addstr(buf, *(++argv));
> -	}
> +	strbuf_map_join_argv(buf, argv, strbuf_addstr, separator);
> 
>   	return buf->buf;
>   }
> diff --git a/strbuf.h b/strbuf.h
> index f62278a0be..7adeff94a7 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -297,6 +297,14 @@ static inline void strbuf_addstr(struct strbuf *sb, const char *s)
>    */
>   void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2);
> 
> +/**
> + * Apply `fn` to `sb` and each element of the NULL-terminated array
> + * `argv`. Add `separator` between these invocations.
> + */
> +void strbuf_map_join_argv(struct strbuf *sb, const char **argv,
> +			  void (*fn)(struct strbuf *, const char *),
> +			  const char *separator);
> +
>   /**
>    * Join the arguments into a buffer. `delim` is put between every
>    * two arguments.
> --
> 2.22.0
> 
