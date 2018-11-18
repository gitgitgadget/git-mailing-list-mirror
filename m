Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0F261F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 06:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbeKRRNl (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 12:13:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50634 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbeKRRNl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 12:13:41 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 910E0115087;
        Sun, 18 Nov 2018 01:54:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6tXaTaVqk27vWx60u40OyG0K3yU=; b=xnHNFV
        MY8NofV8CXQxAidrzTQ1mNZ4J88aG5a+RgE8zQlZW5+NkaF7qv9qFiQVL/SRz0h0
        PiKpEbwDzsms5vojMrhHC96XeD8Aazfc28wpdQ5Jy1t5jcProLFvmx5TMAoM52GZ
        eOqU57O35smGJm01896BBz6KgL7ouUw+zx3KA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XSvgBJDLBOvQbn29D2mzrtY9KKrKgZJG
        EHIYWa1oFEGZKohzqwT0qhQe/tYjEQtIjuE+67r/uundPvlzxPOMBNoZmWKpTGXM
        oIJC/WCMa3wQD2tH05BVuWrIkVVHb2wefdcYIHUjU5VsesNV5cu2wWMfXIlXQA8x
        vXpSdQ971fY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A679115086;
        Sun, 18 Nov 2018 01:54:14 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 03C6F115084;
        Sun, 18 Nov 2018 01:54:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/1] Fix scissors bug during merge conflict
References: <cover.1542380929.git.liu.denton@gmail.com>
        <cover.1542496915.git.liu.denton@gmail.com>
Date:   Sun, 18 Nov 2018 15:54:12 +0900
In-Reply-To: <cover.1542496915.git.liu.denton@gmail.com> (Denton Liu's message
        of "Sat, 17 Nov 2018 18:32:17 -0500")
Message-ID: <xmqqwopag9kb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C27B7AD2-EAFE-11E8-B067-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>> I wonder if this is what you really meant to have instead:
>> 
>> >  		else if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
>> > -			 whence == FROM_COMMIT)
>> > - 			wt_status_add_cut_line(s->fp);
>> > +			 whence == FROM_COMMIT) {
>> > +			 if (!merge_contains_scissors)
>> > +				wt_status_add_cut_line(s->fp);
>> > +		}
>> >  		else /* COMMIT_MSG_CLEANUP_SPACE, that is. */
>> >  			status_printf(s, GIT_COLOR_NORMAL,
>> 
>> That is, the only behaviour change in "merge contains scissors"
>> mode is to omit the cut line and nothing else.
>
> Thanks for catching this. I noticed that the originally behaviour is
> buggy too: in the case where we're merging a commit and scissors are
> printed from the `if (whence != FROM_COMMIT)` block, the original
> behaviour would drop us into the else (COMMIT_MSG_CLEANUP_SPACE)
> statement, which is undesired.

The original calls add-cut-line in the "whence != FROM_COMMIT" when
cleanup_mode is CLEANUP_SCISSORS (and then in that block it also adds
the message about committing a merge or cherry-pick).  After that,
the original does the three-arm if/else if/else cascade and we end
up showing the "lines starting with # will be kept" message.

Yeah, you read the original correctly and I agree that in that block
the right thing to do is not to say anything in CLEANUP_SCISSORS
mode.

Thanks for carefully reading the code again.


