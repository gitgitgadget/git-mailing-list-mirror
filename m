Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0428AEB64DA
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 17:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjGTR7r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 13:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjGTR7p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 13:59:45 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFFF2709
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 10:59:44 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 47A321AE6A0;
        Thu, 20 Jul 2023 13:59:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=emNfW8zskeGMkCvbrrSFs7G1aUwiDFW1DM5uji
        KZ8K4=; b=oWSBZU2qdVG7boFVxYtsFpG+jPRzgcR3eZPuA5gho4ArxkxiBnwFgE
        exI7PzjKVl4wCOkvET3qyAmsPi6SPjsRAeRLq6rULVF258O+A6FSlPltYmFgKehz
        iOBw7suxBLgRVEYO4amZzUtGFGdeHx3rOARrcXPpevSJ8+/3ApIp4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3FC711AE69F;
        Thu, 20 Jul 2023 13:59:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A888F1AE69E;
        Thu, 20 Jul 2023 13:59:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Siddharth Singh <siddhartth@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3 1/2] ref-filter: add multiple-option parsing functions
References: <20230714194249.66862-1-five231003@gmail.com>
        <20230719162424.70781-1-five231003@gmail.com>
        <20230719162424.70781-2-five231003@gmail.com>
        <xmqqjzuv5vvg.fsf@gitster.g> <ZLlmXNt2crTEIXLg@five231003>
Date:   Thu, 20 Jul 2023 10:59:39 -0700
In-Reply-To: <ZLlmXNt2crTEIXLg@five231003> (Kousik Sanagavarapu's message of
        "Thu, 20 Jul 2023 22:22:44 +0530")
Message-ID: <xmqq351i4g6s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32F31388-2727-11EE-8378-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:

> Going off in a tangent here---In yesterday's review club which discussed
> the %(decorate:<options>) patch[1], Glen suggested the possibility of
> having a single kind of a framework (used this word very loosely here)
> for parsing these multiple options since we are beginning to see them so
> often (might also help new formats which maybe added in the future). The
> fact that this wasn't done already says something about its difficulty
> as Jacob mentioned yesterday. The difficulty being we don't exactly know
> which options to parse as they differ from format to format.

Yes, while writing the sample in-code documentation for the
match_atom_arg_value() function, I found its interface to force the
callers to do "parse if it is 'tags'; else parse if it is 'abbrev';
and so on" hard to use.  I wondered if the primitive to parse these
should be modeled after config.c:parse_config_key(), i.e. the helper
function takes the input and returns the split point and lengths of
the components it finds in the return parameter.

As the contract between the caller and the callee is that the caller
passes the beginning of "key1[=val1],key2[=val2],...", the interface
may look like

	int parse_cskv(const char *to_parse,
		       const char **key, size_t *keylen,
		       const char **val, size_t *vallen,
		       const char **end);

and would be used like so:

	const char *cskv = "key1,key2=val2";
	const char *key, *val;
	size_t keylen, vallen;

	while (parse_cskv(cskv, &key, &keylen, &val, &vallen, &cskv) {
		if (!val)
			printf("valueless key '%.*s'\n",
			       (int)keylen, key);
		else
			printf("key-value pair '%.*s=%.*s'\n",
			       (int)keylen, key, (int)vallen, val);
	}
	if (*cskv)
		fprintf(stderr, "error - trailing garbage seen '%s'\n",
			cskv);

The helper's contract to the caller may look like this:

 - It expects the string to be "key" or "key=val" followed by ',' or
   '\0' (the latter ends the input, i.e. the last element of comma
   separated list).  The out variables key, val, keylen, vallen are
   used to convey to the caller where key and val are found and how
   long they are.

 - If it is a valueless "key", the out variable val is set to NULL.

 - The out variable end is updated to point at one byte after the
   element that has just been parsed.

The need for the caller to check against the list of keys it knows
about in the loop still exists, but the parser may become simpler
that way.  I dunno.

