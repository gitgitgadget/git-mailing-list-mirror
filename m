Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954C6C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 21:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D2C3206D9
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 21:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="a6KFrmW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgD2VRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 17:17:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51385 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgD2VRs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 17:17:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37A8C478CF;
        Wed, 29 Apr 2020 17:17:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oEOuLwu+a2X+c+w3+wC1iOGuSCM=; b=a6KFrm
        W2pVqM8m/f5rJKYsKfxUhrOkvjhM/0RL2V08cLRggbR7+K3jtOCprrYxNxd8tYQt
        ipT8x+fZ1ZNFYD3AKmcGvivSqlAMA/IDaFNQB5GOzav0efhUuSeUFm9lqAD83R3s
        cyLCrMbBcqeetj7WSvgyYaxY3UXY48uAVlwjY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sEcx6wUi0/zkaSw60sV01YKjupvITPzT
        3w6pDLwHR8GNLQCbh/mA8766cBXup0hy55wCvhkBJkD15Xe19mxMjTJD0oGHKjXq
        A57NAFet633ii0sukSyumTD/kpGaiLqQWIxG5ylBRIuzXKmSmVN6LBHAa5f5W8vd
        rmvT72reOlw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2FC80478CE;
        Wed, 29 Apr 2020 17:17:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AF67B478CC;
        Wed, 29 Apr 2020 17:17:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        peff@peff.net, jrnieder@gmail.com
Subject: Re: [RFC PATCH v6 1/2] credential-store: warn instead of fatal for bogus lines from store
References: <20200429003303.93583-1-carenas@gmail.com>
        <20200429203546.56753-1-carenas@gmail.com>
        <20200429203546.56753-2-carenas@gmail.com>
        <xmqqo8rauhoh.fsf@gitster.c.googlers.com>
Date:   Wed, 29 Apr 2020 14:17:45 -0700
In-Reply-To: <xmqqo8rauhoh.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 29 Apr 2020 14:05:02 -0700")
Message-ID: <xmqqftcmuh3a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DEC73748-8A5E-11EA-A017-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>  	while (strbuf_getline_lf(&line, fh) != EOF) {
>> +		lineno++;
>> +		if (!credential_from_url_gently(&entry, line.buf, 1)) {
>> +			if (entry.username && entry.password &&
>> +				credential_match(c, &entry)) {
>> +				found_credential = 1;
>> +				if (match_cb) {
>> +					match_cb(&entry);
>> +					break;
>> +				}
>>  			}
>>  		}
>> +		else
>> +			warning(_("ignoring invalid credential in %s:%d"),
>> +				fn, lineno);
>> +		if (!found_credential && other_cb)
>>  			other_cb(&line);
>>  	}
>
> The above is harder to follow than necessary.
>
> 	while (... != EOF) {
> 		lineno++;
> 		if (credential is not well formed) {

After reading your [2/2], I think this part deserves a bit of
explanation.  By "is not well formed", what I mean is not just
credential_from_url_gently() returns non-zero, but also user/pass
are specified.  And your step [2/2] may make the condition for a
line to be "well formed" even stricter by requiring at least one of
host or path, and that would also belong to this test.

> 			warning(_("ignoring..."));
> 		} else if (the entry matches) {

And the "entry matches" test here would only be "what does
credential_match() say?"

> 			found_credential = 1;
> 			if (match_cb) {
> 				match_cb(&entry);
> 				break; /* stop at the first match */
> 			}
> 			continue;
> 		}
>
>                 if (other_cb)
> 			other_cb(&line);
> 	}
>
> may make the intention a bit clearer, with the loud "continue" inside.
>
>  (1) we give warning for malformed one; and
>  (2) we do not let other_cb touch a matching entry.
