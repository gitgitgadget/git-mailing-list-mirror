Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBBDC4727E
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 15:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC83D208B6
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 15:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732591AbgJAP7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 11:59:38 -0400
Received: from siwi.pair.com ([209.68.5.199]:23862 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732119AbgJAP7h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 11:59:37 -0400
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Oct 2020 11:59:36 EDT
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 2DA133F4129;
        Thu,  1 Oct 2020 11:59:36 -0400 (EDT)
Received: from Web02.contoso.com.tw (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D19553F4126;
        Thu,  1 Oct 2020 11:59:35 -0400 (EDT)
Subject: Re: [PATCH v2 08/19] entry: move conv_attrs lookup up to
 checkout_entry()
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
Cc:     jeffhost@microsoft.com, chriscool@tuxfamily.org, peff@peff.net,
        t.gummerer@gmail.com, newren@gmail.com
References: <cover.1600814153.git.matheus.bernardino@usp.br>
 <667ad0dea70cb7f0bbf8f52467f15129b3ae1325.1600814153.git.matheus.bernardino@usp.br>
 <0b7d7704-159f-c186-9551-1989af8f572d@jeffhostetler.com>
Message-ID: <3eec6883-d9b4-33d9-5a0d-45e82fba29d2@jeffhostetler.com>
Date:   Thu, 1 Oct 2020 11:59:34 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <0b7d7704-159f-c186-9551-1989af8f572d@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/1/20 11:53 AM, Jeff Hostetler wrote:
> 
> 
> On 9/22/20 6:49 PM, Matheus Tavares wrote:
>> In a following patch, checkout_entry() will use conv_attrs to decide
>> whether an entry should be enqueued for parallel checkout or not. But
>> the attributes lookup only happens lower in this call stack. To avoid
>> the unnecessary work of loading the attributes twice, let's move it up
>> to checkout_entry(), and pass the loaded struct down to write_entry().
>>
>> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
>> ---
>>   entry.c | 38 +++++++++++++++++++++++++++-----------
>>   1 file changed, 27 insertions(+), 11 deletions(-)
>>
>> diff --git a/entry.c b/entry.c
>> index 1d2df188e5..8237859b12 100644
>> --- a/entry.c
>> +++ b/entry.c
>> @@ -263,8 +263,9 @@ void update_ce_after_write(const struct checkout 
>> *state, struct cache_entry *ce,
>>       }
>>   }
>> -static int write_entry(struct cache_entry *ce,
>> -               char *path, const struct checkout *state, int 
>> to_tempfile)
>> +/* Note: ca is used (and required) iff the entry refers to a regular 
>> file. */
>> +static int write_entry(struct cache_entry *ce, char *path, struct 
>> conv_attrs *ca,
>> +               const struct checkout *state, int to_tempfile)
>>   {
>>       unsigned int ce_mode_s_ifmt = ce->ce_mode & S_IFMT;
>>       struct delayed_checkout *dco = state->delayed_checkout;
>> @@ -281,8 +282,7 @@ static int write_entry(struct cache_entry *ce,
>>       clone_checkout_metadata(&meta, &state->meta, &ce->oid);
>>       if (ce_mode_s_ifmt == S_IFREG) {
>> -        struct stream_filter *filter = 
>> get_stream_filter(state->istate, ce->name,
>> -                                 &ce->oid);
>> +        struct stream_filter *filter = get_stream_filter_ca(ca, 
>> &ce->oid);
>>           if (filter &&
>>               !streaming_write_entry(ce, path, filter,
>>                          state, to_tempfile,
>> @@ -329,14 +329,17 @@ static int write_entry(struct cache_entry *ce,
>>            * Convert from git internal format to working tree format
>>            */
>>           if (dco && dco->state != CE_NO_DELAY) {
>> -            ret = async_convert_to_working_tree(state->istate, 
>> ce->name, new_blob,
>> -                                size, &buf, &meta, dco);
>> +            ret = async_convert_to_working_tree_ca(ca, ce->name,
>> +                                   new_blob, size,
>> +                                   &buf, &meta, dco);
>>               if (ret && string_list_has_string(&dco->paths, ce->name)) {
>>                   free(new_blob);
>>                   goto delayed;
>>               }
>> -        } else
>> -            ret = convert_to_working_tree(state->istate, ce->name, 
>> new_blob, size, &buf, &meta);
>> +        } else {
>> +            ret = convert_to_working_tree_ca(ca, ce->name, new_blob,
>> +                             size, &buf, &meta);
>> +        }
>>           if (ret) {
>>               free(new_blob);
>> @@ -442,6 +445,7 @@ int checkout_entry(struct cache_entry *ce, const 
>> struct checkout *state,
>>   {
>>       static struct strbuf path = STRBUF_INIT;
>>       struct stat st;
>> +    struct conv_attrs ca;
> 
> I have to wonder if it would be clearer to move this declaration of `ca`
> into the two `if { ... }` blocks where it is used -- to indicate that it
> is only defined in two cases where we call `convert_attrs()`.
> 
> There are several other calls to `write_entry()` that pass NULL and it
> could cause confusion.


Nevermind, I see what you did in step 9 and this makes sense.

> 
> 
>>       if (ce->ce_flags & CE_WT_REMOVE) {
>>           if (topath)
>> @@ -454,8 +458,13 @@ int checkout_entry(struct cache_entry *ce, const 
>> struct checkout *state,
>>           return 0;
>>       }
>> -    if (topath)
>> -        return write_entry(ce, topath, state, 1);
>> +    if (topath) {
>> +        if (S_ISREG(ce->ce_mode)) {
>> +            convert_attrs(state->istate, &ca, ce->name);
>> +            return write_entry(ce, topath, &ca, state, 1);
>> +        }
>> +        return write_entry(ce, topath, NULL, state, 1);
>> +    }
>>       strbuf_reset(&path);
>>       strbuf_add(&path, state->base_dir, state->base_dir_len);
>> @@ -517,9 +526,16 @@ int checkout_entry(struct cache_entry *ce, const 
>> struct checkout *state,
>>           return 0;
>>       create_directories(path.buf, path.len, state);
>> +
>>       if (nr_checkouts)
>>           (*nr_checkouts)++;
>> -    return write_entry(ce, path.buf, state, 0);
>> +
>> +    if (S_ISREG(ce->ce_mode)) {
>> +        convert_attrs(state->istate, &ca, ce->name);
>> +        return write_entry(ce, path.buf, &ca, state, 0);
>> +    }
>> +
>> +    return write_entry(ce, path.buf, NULL, state, 0);
>>   }
>>   void unlink_entry(const struct cache_entry *ce)
>>
