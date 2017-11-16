Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38DD0202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 21:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934744AbdKPVtL (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 16:49:11 -0500
Received: from siwi.pair.com ([209.68.5.199]:57413 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934623AbdKPVtK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 16:49:10 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 4BCB2844F8;
        Thu, 16 Nov 2017 16:49:09 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id EF206844EF;
        Thu, 16 Nov 2017 16:49:08 -0500 (EST)
Subject: Re: [PATCH v4 4/6] list-objects: filter objects in
 traverse_commit_list
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171116180743.61353-1-git@jeffhostetler.com>
 <20171116180743.61353-5-git@jeffhostetler.com>
 <20171116122133.4cc718414579c1a5a682174b@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <bdf75d90-570d-8cf0-886a-2c5c9cdba1c1@jeffhostetler.com>
Date:   Thu, 16 Nov 2017 16:49:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171116122133.4cc718414579c1a5a682174b@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/16/2017 3:21 PM, Jonathan Tan wrote:
> On Thu, 16 Nov 2017 18:07:41 +0000
> Jeff Hostetler <git@jeffhostetler.com> wrote:
> 
>> +/*
>> + * Return 1 if the given string needs armoring because of "special"
>> + * characters that may cause injection problems when a command passes
>> + * the argument to a subordinate command (such as when upload-pack
>> + * launches pack-objects).
>> + *
>> + * The usual alphanumeric and key punctuation do not trigger it.
>> + */
>> +static int arg_needs_armor(const char *arg)
> 
> First of all, about the injection problem, replying to your previous e-mail
> [1]:
> 
> https://public-inbox.org/git/61855872-221b-0e97-abaa-24a011ad899e@jeffhostetler.com/
> 
>> I couldn't use quote.[ch] because it is more concerned with
>> quoting pathnames because of LF and CR characters within
>> them -- rather than semicolons and quotes and the like which
>> I was concerned about.
> 
> sq_quote_buf() (or one of the other similarly-named functions) should
> solve this problem, right? The single quotes around the argument takes
> care of LF, CR, and semicolons, and things like backslashes and quotes
> are taken care of as documented.
> 
> I don't think we need to invent another encoding to solve this.

I'll take another look, sq_quote_buf() looks like it might work.
I was looking at quote_c_style() and that didn't seem right for
my needs.  Thanks.


> 
>> +{
>> +	const unsigned char *p;
>> +
>> +	for (p = (const unsigned char *)arg; *p; p++) {
>> +		if (*p >= 'a' && *p <= 'z')
>> +			continue;
>> +		if (*p >= 'A' && *p <= 'Z')
>> +			continue;
>> +		if (*p >= '0' && *p <= '9')
>> +			continue;
>> +		if (*p == '-' || *p == '_' || *p == '.' || *p == '/')
>> +			continue;
> 
> If we do take this approach, can ':' also be included?

Sure.  I just picked the common ones.

> 
>> +	if (skip_prefix(arg, "sparse:oid=", &v0)) {
>> +		struct object_context oc;
>> +		struct object_id sparse_oid;
>> +
>> +		/*
>> +		 * Try to parse <oid-expression> into an OID for the current
>> +		 * command, but DO NOT complain if we don't have the blob or
>> +		 * ref locally.
>> +		 */
>> +		if (!get_oid_with_context(v0, GET_OID_BLOB,
>> +					  &sparse_oid, &oc))
>> +			filter_options->sparse_oid_value = oiddup(&sparse_oid);
>> +		filter_options->choice = LOFC_SPARSE_OID;
>> +		if (arg_needs_armor(v0))
>> +			filter_options->requires_armor = v0 - arg;
>> +		return 0;
>> +	}
> 
> In your previous e-mail, you mentioned:
> 
>> yes.  I always pass filter_options.raw_value over the wire.
>> The code above tries to parse it and put it in an OID for
>> private use by the current process -- just like the size limit
>> value in the blob:limit filter.
> 
> So I think this function should complain if you don't have the blob or
> ref locally. (I envision that if a filter string is to be directly sent
> to a server, it should be stored as a string, not processed by this
> function first.)

The whole point was for clone to be able to ask the server to use
a known sparse-checkout spec, based on a branch name and a pathname
within the tree.  That's more usable.  My expectation was that users
could keep one or more sparse-checkout specs in the tree based upon
the area/subset of the tree they want to work on.  Then do a partial
clone based upon the desired subset.  Granted, we make them publish
OIDs (outside of git) and then make the user request the partial
clone by OID, but that's awkward.

There are 2 uses of the "--filter=..." parser -- one to actually use
the data within the current process (rev-list and pack-objects) and
one to capture the value and pass it on to another process (fetch-pack
and upload-pack).  The former want the fields fully decoded into
actual variables and the latter want the raw string to pass on.
The parser routine provides both values for its callers.  (In an
earlier draft, the parser would replace the raw_value of a sparse
spec with the actual OID when it had it locally, but I took that
out based on your earlier comments.  Now, the raw_value is always
passed by the second type of usages.)

Jeff

