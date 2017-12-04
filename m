Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4739020C13
	for <e@80x24.org>; Mon,  4 Dec 2017 13:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753634AbdLDNfL (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 08:35:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52557 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751980AbdLDNfK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 08:35:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 767F1CB764;
        Mon,  4 Dec 2017 08:35:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CRqOkKxzviVBLCRA+he2/BzDlhk=; b=C0AscL
        f+ZxIb2FFX0puUKmsVkvgiJDf/LiUfjQxWj7+T/0DOWUF6mavkmbdmCuctAbhc/q
        ZhFE362FhzvhVYtYQw7JpCeRhkv3/cqy3e2pfreh9aF1eJlkuW0qPHz38RqMqMQ4
        YlZt/mtY/pfTh2gy633La7uMZzZee0cdHSmes=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KY2sTKSnnZnpvYIONH6eJuzTTDqfbl5A
        A6hoJjqtwjkOFKWIYwFpmCsuhAoooXt1Vrj1NDnKQF2WbyTrjwBqmT9p0RVPiLLI
        yMu13dLaAa6OBJvQArDooQHHqlwIEUPShd7DluZITGuwcPE7Ve86O2cobyV9tmAQ
        8aefW1U3Fho=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E8EDCB763;
        Mon,  4 Dec 2017 08:35:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E28FBCB762;
        Mon,  4 Dec 2017 08:35:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/3] git-compat-util: introduce skip_to_opt_val()
References: <20171203170415.15939-1-chriscool@tuxfamily.org>
        <xmqqk1y3ira9.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD2OSsqzhyAL-QG1TOowB-xgbf=kC9wHre+FLc+0J1Xy+Q@mail.gmail.com>
        <xmqqfu8rig10.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD0UH62fyLLAx8QP37L22if9zGjX=7f_c23asOFiKEEB7Q@mail.gmail.com>
Date:   Mon, 04 Dec 2017 05:35:07 -0800
In-Reply-To: <CAP8UFD0UH62fyLLAx8QP37L22if9zGjX=7f_c23asOFiKEEB7Q@mail.gmail.com>
        (Christian Couder's message of "Mon, 4 Dec 2017 08:59:12 +0100")
Message-ID: <xmqqpo7uobuc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F229D9B4-D8F7-11E7-8BE4-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> In the few cases where do_something() accepts NULL and does something
> different with it, the former can be changed to:
>
>         if (skip_to_optional_val(arg, "--key", &arg, NULL) /* the last
> argument is the default value */
>                 do_something(arg);

That's the thing.  If do_something() that takes "" and NULL and
behaves differently is rare, that indicates that the existing code
may not be committed to treat "--key" and "--key=''" the same in the
first place, and I am not 100% convinced that I want to see us
committed to force that design throughout the system by introducing
a helper that hardcodes the equivalence and encourages to use it.

Imagine a command that takes "--do-something" option and does that
"something" unconditionally.  We may later extend it to take an
optional argument, i.e. "--do-something=c1,c2,...", to tell the
command to do that "something" under some but not all conditions.
The values c1,c2 would tell that we want that something done only
under either conditions c1 or c2 holds true.

It would be natural to expect that "--do-something=" to do that
"something" under no condition (i.e. as if no such option was
given); that would help scripts that accumulate the set of
conditions in a variable and say "--do-something=$when", by making
it a no-op when the variable $when turns out to be an empty string.
"--do-something" without "=" would not want to mean the same thing.

The above observation makes me suspect that it depends on the "key"
what "--key=$value" we want to be equivalent to "--key".  In the
"--do-something" case, we do not want to pretend as if we got an
empty string; instead we'd pretend as if we got "always" or
something like that.

And your "default" would work well for this "default is tied to what
the key is" paradigm, i.e.

	skip_to_optional_arg(arg, "--do-something", &arg, "always")

would make us treat "--do-something" and "--do-something=always" the
same way.

If it turns out that the default arg almost always is an empty
string, I do not mind 

	#define skip_to_opt_arg(s,k,v) skip_to_optional_arg(s,k,v,"")

of course.
