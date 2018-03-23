Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 459611F404
	for <e@80x24.org>; Fri, 23 Mar 2018 19:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbeCWTzP (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 15:55:15 -0400
Received: from siwi.pair.com ([209.68.5.199]:40579 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752171AbeCWTzP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 15:55:15 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A0ADA3F400E;
        Fri, 23 Mar 2018 15:55:14 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5FC993F4000;
        Fri, 23 Mar 2018 15:55:14 -0400 (EDT)
Subject: Re: [PATCH v2] json_writer: new routines to create data in JSON
 format
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, avarab@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180321192827.44330-1-git@jeffhostetler.com>
 <20180321192827.44330-2-git@jeffhostetler.com>
 <524c47a6-7c9f-5519-250a-4722081a0f32@web.de>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <14bbf223-a4d1-3c11-cd2e-dff044e01fef@jeffhostetler.com>
Date:   Fri, 23 Mar 2018 15:55:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <524c47a6-7c9f-5519-250a-4722081a0f32@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/23/2018 2:01 PM, René Scharfe wrote:
> Am 21.03.2018 um 20:28 schrieb git@jeffhostetler.com:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Add basic routines to generate data in JSON format.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>>    Makefile                    |   2 +
>>    json-writer.c               | 321 +++++++++++++++++++++++++++++++++
>>    json-writer.h               |  86 +++++++++
>>    t/helper/test-json-writer.c | 420 ++++++++++++++++++++++++++++++++++++++++++++
>>    t/t0019-json-writer.sh      | 102 +++++++++++
>>    5 files changed, 931 insertions(+)
>>    create mode 100644 json-writer.c
>>    create mode 100644 json-writer.h
>>    create mode 100644 t/helper/test-json-writer.c
>>    create mode 100755 t/t0019-json-writer.sh
>>
>> diff --git a/Makefile b/Makefile
>> index 1a9b23b..57f58e6 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -662,6 +662,7 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
>>    TEST_PROGRAMS_NEED_X += test-genrandom
>>    TEST_PROGRAMS_NEED_X += test-hashmap
>>    TEST_PROGRAMS_NEED_X += test-index-version
>> +TEST_PROGRAMS_NEED_X += test-json-writer
>>    TEST_PROGRAMS_NEED_X += test-lazy-init-name-hash
>>    TEST_PROGRAMS_NEED_X += test-line-buffer
>>    TEST_PROGRAMS_NEED_X += test-match-trees
>> @@ -815,6 +816,7 @@ LIB_OBJS += hashmap.o
>>    LIB_OBJS += help.o
>>    LIB_OBJS += hex.o
>>    LIB_OBJS += ident.o
>> +LIB_OBJS += json-writer.o
>>    LIB_OBJS += kwset.o
>>    LIB_OBJS += levenshtein.o
>>    LIB_OBJS += line-log.o
>> diff --git a/json-writer.c b/json-writer.c
>> new file mode 100644
>> index 0000000..89a6abb
>> --- /dev/null
>> +++ b/json-writer.c
>> @@ -0,0 +1,321 @@
>> +#include "cache.h"
>> +#include "json-writer.h"
>> +
>> +static char g_ch_open[2]  = { '{', '[' };
>> +static char g_ch_close[2] = { '}', ']' };
>> +
>> +/*
>> + * Append JSON-quoted version of the given string to 'out'.
>> + */
>> +static void append_quoted_string(struct strbuf *out, const char *in)
>> +{
>> +	strbuf_addch(out, '"');
>> +	for (/**/; *in; in++) {
>> +		unsigned char c = (unsigned char)*in;
>> +		if (c == '"')
>> +			strbuf_add(out, "\\\"", 2);
>> +		else if (c == '\\')
>> +			strbuf_add(out, "\\\\", 2);
>> +		else if (c == '\n')
>> +			strbuf_add(out, "\\n", 2);
>> +		else if (c == '\r')
>> +			strbuf_add(out, "\\r", 2);
>> +		else if (c == '\t')
>> +			strbuf_add(out, "\\t", 2);
>> +		else if (c == '\f')
>> +			strbuf_add(out, "\\f", 2);
>> +		else if (c == '\b')
>> +			strbuf_add(out, "\\b", 2);
> 
> Using strbuf_addstr() here would result in the same object code (its
> strlen() call is inlined for constants) and avoid having to specify
> the redundant length 2.

sure. thanks.


>> +		else if (c < 0x20)
>> +			strbuf_addf(out, "\\u%04x", c);
>> +		else
>> +			strbuf_addch(out, c);
>> +	}
>> +	strbuf_addch(out, '"');
>> +}
>> +
[...]
>> +
>> +void jw_object_double(struct json_writer *jw, const char *fmt,
>> +		      const char *key, double value)
>> +{
>> +	assert_in_object(jw, key);
>> +	maybe_add_comma(jw);
>> +
>> +	if (!fmt || !*fmt)
>> +		fmt = "%f";
>> +
>> +	append_quoted_string(&jw->json, key);
>> +	strbuf_addch(&jw->json, ':');
>> +	strbuf_addf(&jw->json, fmt, value);
> 
> Hmm.  Can compilers check such a caller-supplied format matches the
> value's type?  (I don't know how to specify a format attribute for
> GCC and Clang for this function.)

I'll look into this.  thanks.


>> +}
[...]
>> +
>> +void jw_object_sub(struct json_writer *jw, const char *key,
>> +		   const struct json_writer *value)
>> +{
>> +	assert_is_terminated(value);
>> +
>> +	assert_in_object(jw, key);
>> +	maybe_add_comma(jw);
>> +
>> +	append_quoted_string(&jw->json, key);
>> +	strbuf_addch(&jw->json, ':');
>> +	strbuf_addstr(&jw->json, value->json.buf);
> 
> strbuf_addbuf() would be a better fit here -- it avoids a strlen() call
> and NUL handling issues.

sure. thanks. i always forget about _addbuf().


>> +}
>> +
>> +void jw_object_inline_begin_array(struct json_writer *jw, const char *key)
>> +{
>> +	assert_in_object(jw, key);
>> +	maybe_add_comma(jw);
>> +
>> +	append_quoted_string(&jw->json, key);
>> +	strbuf_addch(&jw->json, ':');
>> +
>> +	jw_array_begin(jw);
>> +}
> 
> Those duplicate calls in the last ten functions feel mind-numbing.  A
> helper function for adding comma, key and colon might be a good idea.

I'll see if I can add another macro to do the dirty work here.

[...]

>> diff --git a/json-writer.h b/json-writer.h
>> new file mode 100644
>> index 0000000..ad38c95
>> --- /dev/null
>> +++ b/json-writer.h
>> @@ -0,0 +1,86 @@
>> +#ifndef JSON_WRITER_H
>> +#define JSON_WRITER_H
>> +
>> +/*
>> + * JSON data structures are defined at:
>> + *      http://json.org/
>> + *      http://www.ietf.org/rfc/rfc7159.txt
>> + *
>> + * The JSON-writer API allows one to build JSON data structures using a
>> + * simple wrapper around a "struct strbuf" buffer.  It is intended as a
>> + * simple API to build output strings; it is not intended to be a general
>> + * object model for JSON data.  In particular, it does not re-order keys
>> + * in an object (dictionary), it does not de-dup keys in an object, and
>> + * it does not allow lookup or parsing of JSON data.
>> + *
>> + * All string values (both keys and string r-values) are properly quoted
>> + * and escaped if they contain special characters.
>> + *
>> + * These routines create compact JSON data (with no unnecessary whitespace,
>> + * newlines, or indenting).  If you get an unexpected response, verify
>> + * that you're not expecting a pretty JSON string.
>> + *
>> + * Both "JSON objects" (aka sets of k/v pairs) and "JSON array" can be
>> + * constructed using a 'begin append* end' model.
>> + *
>> + * Nested objects and arrays can either be constructed bottom up (by
>> + * creating sub object/arrays first and appending them to the super
>> + * object/array) -or- by building them inline in one pass.  This is a
>> + * personal style and/or data shape choice.
>> + *
>> + * See t/helper/test-json-writer.c for various usage examples.
>> + */
>> +
>> +struct json_writer_level
>> +{
>> +	unsigned level_is_array : 1;
>> +	unsigned level_is_empty : 1;
>> +};
>> +
>> +struct json_writer
>> +{
>> +	struct json_writer_level *levels;
>> +	int nr, alloc;
>> +	struct strbuf json;
>> +};
> 
> A simpler and probably more compact representation of is_array would
> be a strbuf with one char per level, e.g. '[' for an array and '{'
> for an object (or ']' and '}').
> 
> I don't understand the need to track emptiness per level.  Only the
> top level array/object can ever be empty, can it?

My expectation was that any sub-object or sub-array could be empty.
That is, this should be valid (and the JSON parser in Python allows):

     {"a":{}, "b":[], "c":[[]], "d":[{}]}

Jeff
