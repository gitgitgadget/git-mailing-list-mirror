Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8556D1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 07:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeKNRzK (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 12:55:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63403 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeKNRzK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 12:55:10 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D165A11DA2D;
        Wed, 14 Nov 2018 02:53:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=czggJOpIND6hfZSWtUrd9GdBY1o=; b=MzkMOS
        O8HstoWcvxirfrinid9sFu8MUO6Hr+09Vy4zpNRcHjhOfpT59fLpCQAkoIstb552
        O2IpjYpPZ+felVb/ZnNkO7vwVxxYGEv/eDWs2rsyjLt79saS0/weQtkGuiY5N8FI
        8728yYZajCdAk7kISJSvcU2DS9UTbmBV3M6GM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JtzfCTNjmarvGAfJZTyuGQl0U2CUkIif
        P7VxfyCGpgJ+SJFkUZ2lfQBWLg+UCEe7r1eDk55l26L6XweWiHvuFRW7Q5o5jTeU
        qr0JEkcm3PpNr8cBZFAVRWOHEBjIOWnjBdmnGqQoVWwRh0XBisa8vp5vT+5+rjEn
        IFG9rlz62f0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2DC011DA2C;
        Wed, 14 Nov 2018 02:53:02 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2DE4D11DA29;
        Wed, 14 Nov 2018 02:53:00 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Fix scissors bug during merge conflict
References: <cover.1542172724.git.liu.denton@gmail.com>
Date:   Wed, 14 Nov 2018 16:52:59 +0900
In-Reply-To: <cover.1542172724.git.liu.denton@gmail.com> (Denton Liu's message
        of "Wed, 14 Nov 2018 00:24:45 -0500")
Message-ID: <xmqq1s7onlic.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E987594-E7E2-11E8-8BDF-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> With this fix, the message becomes the following:
>
> 	Merge branch 'master' into new
>
> 	# ------------------------ >8 ------------------------
> 	# Do not modify or remove the line above.
> 	# Everything below it will be ignored.
> 	#
> 	# Conflicts:
> 	#	a

I have a mixed feeling about this change and I certainly would not
call it a "fix".

The reason why we give the list of conflicted paths that is
commented out is to remind the user of them in order to help them
describe what area of the codebase had overlapping changes, why, and
how the overlap was resolved, which is relevant information when
somebody else later needs to dig into the history to understand how
the code came into today's shape and why.  For that reason, if a
careless user left conflicts list behind without describing these
details about the merge, it might be better to have the unexplained
list in the merge than nothing.

In theory, the above argument applies the same way for the paths to
be committed, but the list is fairly trivial to recreate with "git
diff $it^!", unlike "which paths had conflict", which can only be
found out by recreating the auto-merge.  So in practice, the paths
that had conflicts is more worth showing than the paths that were
modified.

So, I dunno.  If we value the "more expensive list to reproduce",
the fix might be not to place it (and possibly the comments and
everything under the scissors line) behind a "# " comment char on
the line, without moving its position.

.


