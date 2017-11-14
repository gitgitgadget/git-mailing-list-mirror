Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D143201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 03:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753408AbdKNDaO (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 22:30:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58505 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752892AbdKNDaK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 22:30:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A83D1AD270;
        Mon, 13 Nov 2017 22:30:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s7roZtjLFnq1afYK3n6saSc7eaI=; b=pGvZDr
        tosA+4EsjHCQEIjOL2p2Jr1zlEPVQMWSxFllACeqXw6fZw6iLZYOUlvWD6F4jomM
        XaBIFQQ9/7wkSqQxAJgtkmrUsWwAcL/8MaT+zOCW6cVc0A3VJOvYZnF7Pu+ypL43
        +FL6Da3UDSY6RmCKVUnPcpUTExxcYAfSeGuU0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AoxBbGr6Ha6lBIzEidZ61zvnr/DFTU2Y
        hHxFm0xKAYj7dUgAAW3/PnVMQhMxLuhh6oZcyiDwVsvFWdNK4ehXVcffcwhLlNJP
        kWwQPVReiBE7BuUPuwm4UxRLSQTYzijatDCzyeSQi758Ph+Ir0ZmGU3eF+KxDqv+
        3zNAK3DY4lA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A06A0AD26F;
        Mon, 13 Nov 2017 22:30:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 13217AD269;
        Mon, 13 Nov 2017 22:30:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>, Johan Herland <johan@herland.net>
Cc:     git@vger.kernel.org, Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH] t/lib-gpg: fix gpgconf stderr redirect to /dev/null
References: <20171113210745.24638-1-tmz@pobox.com>
        <xmqq60ad7ewx.fsf@gitster.mtv.corp.google.com>
        <20171114030351.GS5144@zaya.teonanacatl.net>
Date:   Tue, 14 Nov 2017 12:30:05 +0900
In-Reply-To: <20171114030351.GS5144@zaya.teonanacatl.net> (Todd Zullinger's
        message of "Mon, 13 Nov 2017 22:03:51 -0500")
Message-ID: <xmqqshdh5ygy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C507DCC-C8EC-11E7-97F6-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

>> I wonder if this line in 3320 is doing what it meant to do:
>>
>>    test_must_fail git notes merge z 2>&1 >out &&    test_i18ngrep
>> "Automatic notes merge failed" out &&    grep -v "A notes merge into
>> refs/notes/x is already in-progress in" out
>
> That's a fine question.  I only grepped for 2>&1 >/dev/null.  Dropping
> /dev/null, as you did only turns up that test as an additional hit.
>
> I think, based on a very cursory reading of the test, that it's
> intending to direct stderr and stdout to the file out.  The test gets
> lucky that the code in builtin/notes.c directs the error message to
> stdout:
>
>        printf(_("Automatic notes merge failed. Fix conflicts in %s and "
>                 "commit the result with 'git notes merge --commit', or "
>                 "abort the merge with 'git notes merge --abort'.\n"),
>               git_path(NOTES_MERGE_WORKTREE));
>
> Perhaps that should be using fprintf(stderr, ...) instead?  (And the
> test redirection corrected as well, of course.)  If that seems
> correct, I can submit the trivial patch for that as well, while I'm on
> the subject.

The message goes to the standard output stream since it was
introduced in 809f38c8 ("git notes merge: Manual conflict
resolution, part 1/2", 2010-11-09) and 6abb3655 ("git notes merge:
Manual conflict resolution, part 2/2", 2010-11-09).  I do think it
makes more sense to send it to the standard error stream, but just
in case if the original author thinks of a reason why it shouldn't,
let's summon Johan and ask his input.

Thanks.


