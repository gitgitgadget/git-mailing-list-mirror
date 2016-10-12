Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCA2A1F4F8
	for <e@80x24.org>; Wed, 12 Oct 2016 06:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753624AbcJLGNH (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 02:13:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51742 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752026AbcJLGMw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 02:12:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E8483E620;
        Wed, 12 Oct 2016 02:12:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dAJf8LUPWgI4h12EIRN36i2PKEY=; b=VwPV7j
        y58sySPQdMTus6wjerqAY77JsT9tju9Ns3Qtw/wc01X1QXzWwKAfKvh5LfTw8Lm/
        9PpqhL6xRcSLO0D+qWiwLj2+zRKaGL9BdK8KVljZdoN/KkDOKgoSNfbAfrNEB5rK
        dOqXeXVD+K2tbnk6qhAyN4dZw4hkMdHdt3IG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DiRHTumiSyBVfnu6vVOkyGZgc8mPOfOM
        qzarmSTCmJn33bHcLCSs0fWhYx/p5cyPbBLPOysAM02O6X/DSR04c2KjSCUrV6Cv
        1lgiNKV0i/Inyr63HlGa/k5xVrWUCJz5nJSDU1tiSy2X9/49kgklErGYTeWTePWJ
        MqiqCtdqyuk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 462DC3E61D;
        Wed, 12 Oct 2016 02:12:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BA14A3E61C;
        Wed, 12 Oct 2016 02:12:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com
Subject: Re: [PATCHv2] attr: convert to new threadsafe API
References: <20161011235951.8358-1-sbeller@google.com>
Date:   Tue, 11 Oct 2016 23:12:45 -0700
In-Reply-To: <20161011235951.8358-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 11 Oct 2016 16:59:51 -0700")
Message-ID: <xmqqvawy5c4i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5BA0F04-9042-11E6-9306-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I think this patch is the most interesting patch, so I'll refrain from
> resending the other 27 patches, though I have adressed the review comments
> locally. I'll resend everything once we are in agreement for this one.

What is the primary purpose of this patch?  Is it to prepare callers
so that the way they interact with the attr subsystem will not have to
change when they become threaded and the attr subsystem becomes
thread ready?

I am not sure if the updates to the callers fulfill that purpose.
For example, look at this hunk.

> @@ -111,6 +111,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
>  	struct archiver_args *args = c->args;
>  	write_archive_entry_fn_t write_entry = c->write_entry;
>  	static struct git_attr_check *check;
> +	static struct git_attr_result result;

As we discussed, this caller, even when threaded, will always want
to ask for a fixed two attributes, so "check" being static and
shared across threads is perfectly fine.  But we do not want to see
"result" shared, do we?

>  	const char *path_without_prefix;
>  	int err;
>  
> @@ -124,12 +125,15 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
>  		strbuf_addch(&path, '/');
>  	path_without_prefix = path.buf + args->baselen;
>  
> -	if (!check)
> -		check = git_attr_check_initl("export-ignore", "export-subst", NULL);
> -	if (!git_check_attr(path_without_prefix, check)) {
> -		if (ATTR_TRUE(check->check[0].value))
> +	if (!check) {
> +		git_attr_check_initl(&check, "export-ignore", "export-subst", NULL);
> +		git_attr_result_init(&result, check);
> +	}

Are we assuming that storing and checking of a single pointer is
atomic?  I would not expose that assumption to the callers.  On a
platform where that assumption holds, "if check is not NULL,
somebody must have done it already, so return without doing nothing"
can be the first thing git_attr_check_initl()'s implementation does,
though.  Or it may not hold anywhere without some barriers.  All
that implementation details should be hidden inside _initl()'s
implementation.  So this caller should instead just do an
unconditional:

	git_attr_check_initl(&check, "export-ignore", "export-subst", NULL);
	
Also, as "result" should be per running thread, hence non-static,
and because we do not want repeated heap allocations and releases
but luckily most callers _know_ not just how many but what exact
attributes they are interested in (I think there are only two
callers that do not know it; check-all-attrs one, and your pathspec
magic one that does not exist at this point in the series), I would
think it is much more preferrable to allow the caller to prepare an
on-stack array and call it "initialized already".  

In other words, ideally, I think this part of the patch should
rather read like this:

	static struct git_attr_check *check;
	struct git_attr_result result[2];

	...
	git_attr_check_initl(&check, "export-ignore", "export-subst", NULL);
	if (!git_check_attr(path_without_prefix, check, result)) {
		... use result[0] and result[1] ...

For sanity checking, it is OK to add ARRAY_SIZE(result) as the final
and extra parameter to git_check_attr() so that the function can
make sure it matches (or exceeds) check->nr.
