Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F13E22047F
	for <e@80x24.org>; Fri,  4 Aug 2017 19:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbdHDT0i (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 15:26:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52328 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751963AbdHDT0h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 15:26:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2E449CDE8;
        Fri,  4 Aug 2017 15:26:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/SmlZTJLmlK8N7/lnWwNfggregI=; b=UEoMZs
        LP2m+urJGJNBzyoGlNa6E+jAD1t2HMlhL4EuSWxGh8KSlvzLo4jXAW7tLt5WwqUW
        f2WkBf+qS5GB44MZa01h0AtTW8+dZu/yw+dnwDKxYIIu0q9+8sNGZhtNcRDJroue
        JVspuXiCfJYK0YVgEVxn/kywqqCNXDkT4RsHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ivpUbbfaApVPlA70ksgxOwDp+1/JNzad
        KpAtRj5I/OO3LW7wENKx7dZxMdbagBdaqoHZ7d9IFpTzE7w7Nn2vq8pm7kKGqZYV
        w6ySBMKNlom9qJHCxZBeRTQHq0FQ/tz8ep82kBKv/rpncpreA8PsDq4SewRXnoMJ
        r2MoyU0qO+4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB2859CDE7;
        Fri,  4 Aug 2017 15:26:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 083BA9CDE6;
        Fri,  4 Aug 2017 15:26:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org, asottile@umich.edu
Subject: Re: [PATCH v1 1/1] correct apply for files commited with CRLF
References: <cceaf377-73e0-e733-20ba-c4e547226382@web.de>
        <20170802204203.29484-1-tboegi@web.de>
        <xmqqwp6lr7u0.fsf@gitster.mtv.corp.google.com>
        <191dc9ea-6ad3-f754-59da-2075a6fd581e@web.de>
        <xmqqini3tdur.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 04 Aug 2017 12:26:34 -0700
In-Reply-To: <xmqqini3tdur.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 04 Aug 2017 10:57:48 -0700")
Message-ID: <xmqq7eyjt9qt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4A9985A-794A-11E7-AF06-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The "previous" in the context of running "git apply" (which does not
> look at the index) is _not_ what is in the index, on the other hand.
> Instead of "struct index_state *", convert_to_git() needs to be
> fixed to take something else that can be queried for the "previous"
> version to use as a hint, if "safe CRLF" wants to work correctly.

I left it unsaid by mistake, but I think the right thing to use as
the "previous" to take hint from in the context of "git apply" is
what is in the working tree, i.e. the result of applying patch in
step (4) to create a file F in the sample scenario.  

While applying patch in step (5), convert_to_git() should "imagine"
adding the file F currently in the working tree (i.e. the result of
step (4)) to the index---if the resulting object in the index would
have CR, then the safe CRLF logic should refrain from doing CRLF->LF
conversion.  And it should do so without actually adding neither the
preimage or the postimage to the index, of course.

When we are doing "git apply --index", then we _require_ that the
indexed contents and what is in the working tree matches before
applying the patch, so it is perfectly fine to let convert_to_git()
to look at the current index---that is the "previous" one we want to
take hint from while using the safe CRLF logic.

