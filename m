Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3418420193
	for <e@80x24.org>; Mon, 24 Oct 2016 19:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941342AbcJXTKR (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 15:10:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51929 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S941009AbcJXTKL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 15:10:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7017C48D19;
        Mon, 24 Oct 2016 15:07:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CKaeUu5fYJ05CnOpExPdwFDH3Dg=; b=fWveIo
        ZR9wfr1Me9Ne+7reJGAKL4Oqh1sZseDGySU779pD1755JXSQEkHsQRokCtNYl8Du
        jxXZWT60RIZkIRRo5m3T9VDVcd/pE7C1Ukg1Y0zbDwD6PJ5vH0e5h6IQTs/ftwlw
        8STFnfZQnmaDzDWp6KvhM4p2IsVSJsw3on4nY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gsUaqc/C0n489NgRHdLgOOMwdKMSO3w8
        WoGmXa0jvbYUcvwyenGGdCnf6rw9t/JFreqLgQEA0CST02a3jvbdkv1VfsFIPZd/
        X0uOmpVnZZOtacxPEhYTuYLKdexrWc1afZBiFYu1tenpWOpbNGBsdJ/Z3uIo9RNH
        mFBxjwFn2tg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 64A8F48D18;
        Mon, 24 Oct 2016 15:07:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C7D5548D17;
        Mon, 24 Oct 2016 15:07:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com
Subject: Re: [PATCH 28/36] attr: keep attr stack for each check
References: <20161022233225.8883-1-sbeller@google.com>
        <20161022233225.8883-29-sbeller@google.com>
Date:   Mon, 24 Oct 2016 12:07:26 -0700
In-Reply-To: <20161022233225.8883-29-sbeller@google.com> (Stefan Beller's
        message of "Sat, 22 Oct 2016 16:32:17 -0700")
Message-ID: <xmqqmvht5zwx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B8E311C-9A1D-11E6-8284-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Instead of having a global attr stack, attach the stack to each check.

Two threads may be working on "git checkout", one "git_attr_check"
in convert.c may be used by them to learn the EOL conversion for
each path, and these threads are working in different parts of
worktree in parallel.  The set of .gitattributes files each of these
threads wants to be cached at one time is tied to where in the
directory hierarchy the thread is working in.

The view by API users would not have to change from the point on
since 27/36 or so, but I think attr_stack needs to become per
<check, thread> tuple when we are fully thread-ready for the above
reason.

But we need to start somewhere to move away from the current "one
single attr stack" to "there are multiple attr stacks", and this
"two checks may and do use different attr stacks" is probably a
reasonable first step.  It may give a single-threaded API users
immediate benefit if the "read and keep only the entries relevant
to the query" optimization is done with this step alone, without
making the cache per <check, thread> pair.

> This allows to use the attr in a multithreaded way.

With manipulation of attr stack protected with a single Big
Attributes Lock, this should be safe.  It may not perform very well
when used by multiple threads, though ;-)

