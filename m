Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C67C1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 19:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbeCWTgt (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 15:36:49 -0400
Received: from siwi.pair.com ([209.68.5.199]:36453 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751997AbeCWTgs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 15:36:48 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 233863F4017;
        Fri, 23 Mar 2018 15:36:48 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E78403F400E;
        Fri, 23 Mar 2018 15:36:47 -0400 (EDT)
Subject: Re: [PATCH v3] routines to generate JSON data
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, avarab@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180323162952.81443-1-git@jeffhostetler.com>
 <9234314d-6fb5-13b3-919f-f5a36c6ab688@ramsayjones.plus.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <49fbcdd2-c486-7660-1304-736607352c9c@jeffhostetler.com>
Date:   Fri, 23 Mar 2018 15:36:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <9234314d-6fb5-13b3-919f-f5a36c6ab688@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/23/2018 2:14 PM, Ramsay Jones wrote:
> 
> 
> On 23/03/18 16:29, git@jeffhostetler.com wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> This is version 3 of my JSON data format routines.
> 
> I have not looked at v3 yet - the patch below is against
> the version in 'pu' @3284f940c (presumably that would be v2).
> 

I built my v3 on Linux and didn't see any warnings.  I'll add
your extra CFLAGS and fix anything that I find and send up a v4
shortly.

Thanks.
Jeff

> The version in 'pu' broke my build on Linux, but not on
> cygwin - which was a bit of a surprise. That is, until I
> saw the warnings and remembered that I have this in my
> config.mak on Linux, but not on cygwin:
> 
>    ifneq ($(CC),clang)
>    CFLAGS += -Wold-style-declaration
>    CFLAGS += -Wno-pointer-to-int-cast
>    CFLAGS += -Wsystem-headers
>    endif
> 
> ... and the warnings were:
> 
>    $ diff nout pout
>    1c1
>    < GIT_VERSION = 2.17.0.rc1.317.g4a561d2cc
>    ---
>    > GIT_VERSION = 2.17.0.rc1.445.g3284f940c
>    29a30
>    >     CC commit-graph.o
>    73a75,87
>    >     CC json-writer.o
>    > json-writer.c:53:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
>    >  static void inline assert_in_object(const struct json_writer *jw, const char *key)
>    >  ^
>    > json-writer.c:64:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
>    >  static void inline assert_in_array(const struct json_writer *jw)
>    >  ^
>    > json-writer.c:75:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
>    >  static void inline maybe_add_comma(struct json_writer *jw)
>    >  ^
>    > json-writer.c:87:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
>    >  static void inline assert_is_terminated(const struct json_writer *jw)
>    >  ^
>    83a98
>    >     CC ls-refs.o
> 
>    ...
>    $
> 
> The '-Wold-style-declaration' gcc warning flag is not a standard
> project flag, and I can't quite remember why I have it set, so I
> guess you could just ignore it. However, all other 'static inline'
> functions in the project have the inline keyword before the return
> type, so ... ;-)
> 
> Also, sparse spewed 40 warnings for t/helper/test-json-writer.c,
> which were mainly about file-local symbols, but had a couple of
> 'constant is so large ...', like so:
> 
>    $ grep warning psp-out | head -8
>    t/helper/test-json-writer.c:45:46: warning: constant 0xffffffffffffffff is so big it is unsigned long
>    t/helper/test-json-writer.c:108:40: warning: constant 0xffffffffffffffff is so big it is unsigned long
>    t/helper/test-json-writer.c:4:12: warning: symbol 'expect_obj1' was not declared. Should it be static?
>    t/helper/test-json-writer.c:5:12: warning: symbol 'expect_obj2' was not declared. Should it be static?
>    t/helper/test-json-writer.c:6:12: warning: symbol 'expect_obj3' was not declared. Should it be static?
>    t/helper/test-json-writer.c:7:12: warning: symbol 'expect_obj4' was not declared. Should it be static?
>    t/helper/test-json-writer.c:8:12: warning: symbol 'expect_obj5' was not declared. Should it be static?
>    t/helper/test-json-writer.c:10:20: warning: symbol 'obj1' was not declared. Should it be static?
>    $
> 
> I decided to use the UINT64_C(v) macro from <stdint.h>, which is
> a C99 feature, and will (hopefully) not be a problem.
> 
> ATB,
> Ramsay Jones
> 
> -- >8 --
> Subject: [PATCH] json-writer: fix up gcc and sparse warnings
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>   json-writer.c               |  8 ++---
>   t/helper/test-json-writer.c | 80 ++++++++++++++++++++++-----------------------
>   2 files changed, 44 insertions(+), 44 deletions(-)
> 
> diff --git a/json-writer.c b/json-writer.c
> index 89a6abb57..ba0365d20 100644
> --- a/json-writer.c
> +++ b/json-writer.c
> @@ -50,7 +50,7 @@ static inline void begin(struct json_writer *jw, int is_array)
>   /*
>    * Assert that we have an open object at this level.
>    */
> -static void inline assert_in_object(const struct json_writer *jw, const char *key)
> +static inline void assert_in_object(const struct json_writer *jw, const char *key)
>   {
>   	if (!jw->nr)
>   		BUG("object: missing jw_object_begin(): '%s'", key);
> @@ -61,7 +61,7 @@ static void inline assert_in_object(const struct json_writer *jw, const char *ke
>   /*
>    * Assert that we have an open array at this level.
>    */
> -static void inline assert_in_array(const struct json_writer *jw)
> +static inline void assert_in_array(const struct json_writer *jw)
>   {
>   	if (!jw->nr)
>   		BUG("array: missing jw_begin()");
> @@ -72,7 +72,7 @@ static void inline assert_in_array(const struct json_writer *jw)
>   /*
>    * Add comma if we have already seen a member at this level.
>    */
> -static void inline maybe_add_comma(struct json_writer *jw)
> +static inline void maybe_add_comma(struct json_writer *jw)
>   {
>   	if (jw->levels[jw->nr - 1].level_is_empty)
>   		jw->levels[jw->nr - 1].level_is_empty = 0;
> @@ -84,7 +84,7 @@ static void inline maybe_add_comma(struct json_writer *jw)
>    * Assert that the given JSON object or JSON array has been properly
>    * terminated.  (Has closing bracket.)
>    */
> -static void inline assert_is_terminated(const struct json_writer *jw)
> +static inline void assert_is_terminated(const struct json_writer *jw)
>   {
>   	if (jw->nr)
>   		BUG("object: missing jw_end(): '%s'", jw->json.buf);
> diff --git a/t/helper/test-json-writer.c b/t/helper/test-json-writer.c
> index 4bf815c2d..9218ee9df 100644
> --- a/t/helper/test-json-writer.c
> +++ b/t/helper/test-json-writer.c
> @@ -1,20 +1,20 @@
>   #include "cache.h"
>   #include "json-writer.h"
>   
> -const char *expect_obj1 = "{\"a\":\"abc\",\"b\":42,\"c\":true}";
> -const char *expect_obj2 = "{\"a\":-1,\"b\":2147483647,\"c\":0}";
> -const char *expect_obj3 = "{\"a\":0,\"b\":4294967295,\"c\":18446744073709551615}";
> -const char *expect_obj4 = "{\"t\":true,\"f\":false,\"n\":null}";
> -const char *expect_obj5 = "{\"abc\\tdef\":\"abc\\\\def\"}";
> +static const char *expect_obj1 = "{\"a\":\"abc\",\"b\":42,\"c\":true}";
> +static const char *expect_obj2 = "{\"a\":-1,\"b\":2147483647,\"c\":0}";
> +static const char *expect_obj3 = "{\"a\":0,\"b\":4294967295,\"c\":18446744073709551615}";
> +static const char *expect_obj4 = "{\"t\":true,\"f\":false,\"n\":null}";
> +static const char *expect_obj5 = "{\"abc\\tdef\":\"abc\\\\def\"}";
>   
> -struct json_writer obj1 = JSON_WRITER_INIT;
> -struct json_writer obj2 = JSON_WRITER_INIT;
> -struct json_writer obj3 = JSON_WRITER_INIT;
> -struct json_writer obj4 = JSON_WRITER_INIT;
> -struct json_writer obj5 = JSON_WRITER_INIT;
> +static struct json_writer obj1 = JSON_WRITER_INIT;
> +static struct json_writer obj2 = JSON_WRITER_INIT;
> +static struct json_writer obj3 = JSON_WRITER_INIT;
> +static struct json_writer obj4 = JSON_WRITER_INIT;
> +static struct json_writer obj5 = JSON_WRITER_INIT;
>   
>   
> -void make_obj1(void)
> +static void make_obj1(void)
>   {
>   	jw_object_begin(&obj1);
>   	{
> @@ -25,7 +25,7 @@ void make_obj1(void)
>   	jw_end(&obj1);
>   }
>   
> -void make_obj2(void)
> +static void make_obj2(void)
>   {
>   	jw_object_begin(&obj2);
>   	{
> @@ -36,18 +36,18 @@ void make_obj2(void)
>   	jw_end(&obj2);
>   }
>   
> -void make_obj3(void)
> +static void make_obj3(void)
>   {
>   	jw_object_begin(&obj3);
>   	{
>   		jw_object_uint64(&obj3, "a", 0);
>   		jw_object_uint64(&obj3, "b", 0xffffffff);
> -		jw_object_uint64(&obj3, "c", 0xffffffffffffffff);
> +		jw_object_uint64(&obj3, "c", UINT64_C(0xffffffffffffffff));
>   	}
>   	jw_end(&obj3);
>   }
>   
> -void make_obj4(void)
> +static void make_obj4(void)
>   {
>   	jw_object_begin(&obj4);
>   	{
> @@ -58,7 +58,7 @@ void make_obj4(void)
>   	jw_end(&obj4);
>   }
>   
> -void make_obj5(void)
> +static void make_obj5(void)
>   {
>   	jw_object_begin(&obj5);
>   	{
> @@ -67,17 +67,17 @@ void make_obj5(void)
>   	jw_end(&obj5);
>   }
>   
> -const char *expect_arr1 = "[\"abc\",42,true]";
> -const char *expect_arr2 = "[-1,2147483647,0]";
> -const char *expect_arr3 = "[0,4294967295,18446744073709551615]";
> -const char *expect_arr4 = "[true,false,null]";
> +static const char *expect_arr1 = "[\"abc\",42,true]";
> +static const char *expect_arr2 = "[-1,2147483647,0]";
> +static const char *expect_arr3 = "[0,4294967295,18446744073709551615]";
> +static const char *expect_arr4 = "[true,false,null]";
>   
> -struct json_writer arr1 = JSON_WRITER_INIT;
> -struct json_writer arr2 = JSON_WRITER_INIT;
> -struct json_writer arr3 = JSON_WRITER_INIT;
> -struct json_writer arr4 = JSON_WRITER_INIT;
> +static struct json_writer arr1 = JSON_WRITER_INIT;
> +static struct json_writer arr2 = JSON_WRITER_INIT;
> +static struct json_writer arr3 = JSON_WRITER_INIT;
> +static struct json_writer arr4 = JSON_WRITER_INIT;
>   
> -void make_arr1(void)
> +static void make_arr1(void)
>   {
>   	jw_array_begin(&arr1);
>   	{
> @@ -88,7 +88,7 @@ void make_arr1(void)
>   	jw_end(&arr1);
>   }
>   
> -void make_arr2(void)
> +static void make_arr2(void)
>   {
>   	jw_array_begin(&arr2);
>   	{
> @@ -99,18 +99,18 @@ void make_arr2(void)
>   	jw_end(&arr2);
>   }
>   
> -void make_arr3(void)
> +static void make_arr3(void)
>   {
>   	jw_array_begin(&arr3);
>   	{
>   		jw_array_uint64(&arr3, 0);
>   		jw_array_uint64(&arr3, 0xffffffff);
> -		jw_array_uint64(&arr3, 0xffffffffffffffff);
> +		jw_array_uint64(&arr3, UINT64_C(0xffffffffffffffff));
>   	}
>   	jw_end(&arr3);
>   }
>   
> -void make_arr4(void)
> +static void make_arr4(void)
>   {
>   	jw_array_begin(&arr4);
>   	{
> @@ -121,12 +121,12 @@ void make_arr4(void)
>   	jw_end(&arr4);
>   }
>   
> -char *expect_nest1 =
> +static char *expect_nest1 =
>   	"{\"obj1\":{\"a\":\"abc\",\"b\":42,\"c\":true},\"arr1\":[\"abc\",42,true]}";
>   
> -struct json_writer nest1 = JSON_WRITER_INIT;
> +static struct json_writer nest1 = JSON_WRITER_INIT;
>   
> -void make_nest1(void)
> +static void make_nest1(void)
>   {
>   	jw_object_begin(&nest1);
>   	{
> @@ -136,12 +136,12 @@ void make_nest1(void)
>   	jw_end(&nest1);
>   }
>   
> -char *expect_inline1 =
> +static char *expect_inline1 =
>   	"{\"obj1\":{\"a\":\"abc\",\"b\":42,\"c\":true},\"arr1\":[\"abc\",42,true]}";
> -struct json_writer inline1 = JSON_WRITER_INIT;
> +static struct json_writer inline1 = JSON_WRITER_INIT;
>   
>   
> -void make_inline1(void)
> +static void make_inline1(void)
>   {
>   	jw_object_begin(&inline1);
>   	{
> @@ -163,11 +163,11 @@ void make_inline1(void)
>   	jw_end(&inline1);
>   }
>   
> -char *expect_inline2 =
> +static char *expect_inline2 =
>   	"[[1,2],[3,4],{\"a\":\"abc\"}]";
> -struct json_writer inline2 = JSON_WRITER_INIT;
> +static struct json_writer inline2 = JSON_WRITER_INIT;
>   
> -void make_inline2(void)
> +static void make_inline2(void)
>   {
>   	jw_array_begin(&inline2);
>   	{
> @@ -193,7 +193,7 @@ void make_inline2(void)
>   }
>   
>   
> -void cmp(const char *test, const struct json_writer *jw, const char *exp)
> +static void cmp(const char *test, const struct json_writer *jw, const char *exp)
>   {
>   	if (!strcmp(jw->json.buf, exp))
>   		return;
> @@ -209,7 +209,7 @@ void cmp(const char *test, const struct json_writer *jw, const char *exp)
>    * Run some basic regression tests with some known patterns.
>    * These tests also demonstrate how to use the jw_ API.
>    */
> -int unit_tests(void)
> +static int unit_tests(void)
>   {
>   	t(obj1);
>   	t(obj2);
> 
