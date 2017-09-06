Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02E66208E3
	for <e@80x24.org>; Wed,  6 Sep 2017 01:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753893AbdIFB5c (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 21:57:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58010 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753841AbdIFB5b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 21:57:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 665C795C6D;
        Tue,  5 Sep 2017 21:57:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FBhD/3OvfVv0NWrxkWAmElvMuUc=; b=PGm+5U
        fegM91eTB2e11wH6jqhcYFhZ5QmQnsabUx0+UOyddUJUf1P9xfHHYdQa0EIM+AvI
        tN/obalRy8ZbNRZTopatE2RMhIpmoS7eAHFXQ2OMv3BqRP1EWKYv7gcGqgdrK6Rh
        pzBsYVFiSurwcS7n2WyG5x4ypa2g7LGZAQ0vs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rVOGs8zK9vNMpvR6/QBgHOWANZkJ22cZ
        2+wojA88s1euVQHLG6vm4bikDM1FT0RklEOT1tsxMkkcJVaRaXUZsa60fvgalFaT
        aXJ8axfxA+tunUtLCDIrcb/cH4ufO5z2nTtw9/dESHSTQcdSpa/60VCvjsG9Ub2E
        28bRb0Y/Jdw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D5F395C6C;
        Tue,  5 Sep 2017 21:57:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C5FE195C6B;
        Tue,  5 Sep 2017 21:57:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCHv2] builtin/merge: honor commit-msg hook for merges
References: <xmqqd174bzco.fsf@gitster.mtv.corp.google.com>
        <20170905232953.22330-1-sbeller@google.com>
Date:   Wed, 06 Sep 2017 10:57:28 +0900
In-Reply-To: <20170905232953.22330-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 5 Sep 2017 16:29:53 -0700")
Message-ID: <xmqq4lsga8s7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD6B3DAE-92A6-11E7-BA8B-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Junio writes:
>> I didn't check how "merge --continue" is implemented, but we need to
>> behave exactly the same way over there, too.  Making sure that it is
>> a case in t7504 may be a good idea, in addition to the test you
>> added.
>
> After inspection of the code I do not think it is a good idea, because
> (a) it clutters the test suite with something "obvious" for now,
>     the call to cmd_commit will be the same as git-commit on the
>     command line and
> (b) piping through --[no-]verify would either introduce irregularities
>     ("Why do we pipe through --no-verify, when --sign-off is more important?")
>     or miss important options to pipe through: 
>
> 	static int continue_current_merge;
> ...
> 	OPT_BOOL(0, "continue", &continue_current_merge,
> 		N_("continue the current in-progress merge")),
> ...
> 	if (continue_current_merge) {
> 		int nargc = 1;
> 		const char *nargv[] = {"commit", NULL};
>
> 		if (orig_argc != 2)
> 			usage_msg_opt(_("--continue expects no arguments"),
> 			      builtin_merge_usage, builtin_merge_options);
>
> 		/* Invoke 'git commit' */
> 		ret = cmd_commit(nargc, nargv, prefix);
> 		goto done;
> 	}

That line of thought is backwards.  'something "obvious" for now'
talks about the present.  tests are all about future-proofing.

I also thought that we were hunting calls of cmd_foo() from outside
the git.c command dispatcher as grave errors and want to clean up
the codebase to get rid of them.  So the above is the worst example
to use when you are trying to convince why it needs no test---the
above is a good example of the code that would need to change soon
when we have enough volunteers willing to keep the codebase clean
and healthy, and we would benefit from future-proofing tests.
