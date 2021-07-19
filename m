Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009B2C6377D
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 19:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2BAE6100C
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 19:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357446AbhGSSWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 14:22:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55983 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383631AbhGSSAB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 14:00:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8CFDF148981;
        Mon, 19 Jul 2021 14:40:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=foMD9ardRcKKIGeYv/H+z1CTzCcMpHQBjjlcrj
        g3RkI=; b=QuqsNfC69nha53XCWIKWyqAs51hD1Rzh61D0DbVFa1EXUepkuKr48A
        fAcu2ZMf4n8RlF5Rs9gV6XeSr4Xv/h9EOrvUcWiyeaU/sCPMzQiWYWs+7OITRFtm
        5SoGtzRNFuRVuswk/ud+/8tm0ap0VeTD9jiHIKaIzRzR1Yp/3UATw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 858F1148980;
        Mon, 19 Jul 2021 14:40:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C778114897F;
        Mon, 19 Jul 2021 14:40:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2021, #03; Tue, 13)
References: <xmqqmtqpzosf.fsf@gitster.g> <YPUrSB8+zEur+ZBt@ncase>
        <YPU48uSCxXbsjvGW@coredump.intra.peff.net> <YPVW50Q6oyTxQ4D4@ncase>
Date:   Mon, 19 Jul 2021 11:40:24 -0700
In-Reply-To: <YPVW50Q6oyTxQ4D4@ncase> (Patrick Steinhardt's message of "Mon,
        19 Jul 2021 12:41:43 +0200")
Message-ID: <xmqqtukqkuzr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8649542-E8C0-11EB-BD5C-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Jul 19, 2021 at 04:33:54AM -0400, Jeff King wrote:
>> On Mon, Jul 19, 2021 at 09:35:36AM +0200, Patrick Steinhardt wrote:
>> 
>> > On Tue, Jul 13, 2021 at 06:07:12PM -0700, Junio C Hamano wrote:
>> > [snip]
>> > > * ps/perf-with-separate-output-directory (2021-07-02) 1 commit
>> > >  - perf: fix when running with TEST_OUTPUT_DIRECTORY
>> > > 
>> > >  Test update.
>> > > 
>> > >  What's the status of this one?
>> > 
>> > From my point of view this is ready, but it's still missing reviews so
>> > far. The lack of interest seems to indicate that nobody has hit the
>> > issue so far, and I wonder why that is. Am I the only one who sets
>> > TEST_OUTPUT_DIRECTORY to a tmpfs directory in his config.mak to speed up
>> > tests?
>> 
>> I had marked it to look at, but just hadn't gotten around to it. I just
>> gave it a review (but the upshot is that it looks fine to me).
>> 
>> I don't set TEST_OUTPUT_DIRECTORY myself; instead I do:
>> 
>>   GIT_TEST_OPTS = --root=/path/to/tmpfs
>> 
>> TBH, I had never really considered using TEST_OUTPUT_DIRECTORY for this
>> (--root predates it, and was written explicitly for the tmpfs case). But
>> I also think --root is more convenient:
>> 
>>   - "make test" will run in the tmpfs for speed, but "./t1234-foo.sh -i"
>>     will run locally, which makes it easy to "cd" in to inspect the
>>     result
>> 
>>   - likewise, I find accessing the results in t/test-results/*.out a
>>     little more convenient
>> 
>> But all of that is preference. I don't think you're wrong to use
>> TEST_OUTPUT_DIRECTORY this way, but the above points might be
>> interesting to you.
>
> It is, thanks a lot for the hint. But given your first point about
> direct execution, this in fact makes me want TEST_OUTPUT_DIRECTORY in
> contrast to `--root=/path/to/tmpfs`: especially in the context of perf
> tests, I never run all of them together given that it takes such a long
> time. So I instead either run them directly or via the `./run` script,
> and in both cases I definitely want to have them in tmpfs given that
> there's a lot of disk churn if you're using biggish repos.
>
> Patrick

Thanks, all.  Let me mark the patch for 'next'.

