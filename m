Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE8A020958
	for <e@80x24.org>; Fri, 24 Mar 2017 02:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933463AbdCXCpU (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 22:45:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63847 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932687AbdCXCpU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 22:45:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 53B366CC00;
        Thu, 23 Mar 2017 22:45:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KWpN1R4IxboCQguYldhe8R/V4ho=; b=pikTBm
        ZF8XHxzNjdUbAGB82Z5JkR1f5WupY2DC3SARnUPv9GDLwyyDFCyziXgAZVplcYSW
        ptZ4rz+wW+wZ0JQZRHZjDz+Zf4Rh7D9o7suVdWPBEw/XqjhLy0kNcqhtnLjNk+Ms
        CEtGk7vYbLGcTkCY+FGYqvyQ1zS6EwTCns+Yk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U21kxBMt6pMfMC1+Xl7W5rNkYRq6gVhy
        Z/64tpcS7pRuPghuV+iWxQ9B62Tz3OD0V+3AgCAtkUIrI8+1vQiACqMQUbZr6xw3
        y1w2DNEPlHhElMbkEH50yy7HjTRM6eCTp6OjfceWEkbzfI4GjHVGEqr4wJCMchBN
        xwTY5OaJa1U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 49FE96CBFF;
        Thu, 23 Mar 2017 22:45:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B16DE6CBFE;
        Thu, 23 Mar 2017 22:45:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] tests: lint for run-away here-doc
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
        <20170322200805.23837-1-gitster@pobox.com>
        <xmqq7f3ghhc7.fsf_-_@gitster.mtv.corp.google.com>
        <xmqqshm4fszt.fsf_-_@gitster.mtv.corp.google.com>
        <20170324012912.GH20794@aiede.mtv.corp.google.com>
Date:   Thu, 23 Mar 2017 19:45:16 -0700
In-Reply-To: <20170324012912.GH20794@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Thu, 23 Mar 2017 18:29:12 -0700")
Message-ID: <xmqq37e39yv7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA41C016-103B-11E7-8942-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> without failure (e.g. "cat" in the above example), which makes the
>> command appear to work, without eve executing the remainder of the
>
> s/eve/ever/

Oops.

>> +		if test "OK-117" != "$(test_eval_ "(exit 117) && $1${LF}${LF}echo OK-\$?" 3>&1)"
>> +		then
>> +			error "bug in the test script: broken &&-chain or run-away HERE-DOC: $1"
>>  		fi
>
> Neat.  Why the double-LF?

The main part of "Neat" was your invention ;-).

Imagining how the string passed to eval looked, having two LFs was
the easiest way to ensure that there is a blank line before the new
"echo" (not just the last line in $1 and "echo" are on different
lines), which was more visually pleasing.  There was no any real
functional requirement.

> In some shells, the 3>&1 will last past the function call.
> Fortunately, the $() substitution creates a subshell so this doesn't
> affect anything later on.

Yes, a subshell solves quite lot of problems (while possibly
introducing others, though ;-).

> test_eval_inner_ contains a warning not to append anything after the
> commands to be evaluated, since whatever you append would pollute -x
> tracing output.  Fortunately, in this context we have already set
> trace= so the warning does not apply.
>
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
