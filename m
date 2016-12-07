Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4C3D1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 18:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753012AbcLGSVe (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 13:21:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63775 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752142AbcLGSVd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 13:21:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3108D546B9;
        Wed,  7 Dec 2016 13:21:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=biBh0IV46nJQrnP0svEt5AUPz70=; b=c9aEYA
        /9UzBamZx0a5stfLtpxtOspMuE0fQ1lHUGD1rM3N4uafoUyVTv64DBmIeR394FLF
        ZhojtHHgNgcmzYS4MdZSN0c2ZFBN9Sg/fyAfG0UnY4SH7fT6bavOTV+xo1vb+qmh
        rXHn+7YD81Wu52Ezmftkxsb6QOCOkpDkp+WqE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TQulESQxAt5vewrhoAIcH1iD8uD4RNZ5
        IEilZZrBh2YXFJ0nZgrL7DXCggOcuTeB1axSj7uqChtST2pRw/s65In0EhJMvWSJ
        1xnegzHj8akzi0Le3WXYse+tJaIz250uVB5wnZbmoLqEjlufoRo7cxe7/Zjemr5p
        dfvG902qLAs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 25F41546B8;
        Wed,  7 Dec 2016 13:21:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8CAF1546B7;
        Wed,  7 Dec 2016 13:21:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robbie Iannucci <iannucci@google.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Re* [BUG] Index.lock error message regression in git 2.11.0
References: <CA+q_oBdHytoeSD-hmLx_N473M8XinjqckvE35Re3eNpQRWYjHQ@mail.gmail.com>
        <xmqqbmwozppx.fsf@gitster.mtv.corp.google.com>
        <xmqq4m2gzotn.fsf_-_@gitster.mtv.corp.google.com>
Date:   Wed, 07 Dec 2016 10:21:29 -0800
In-Reply-To: <xmqq4m2gzotn.fsf_-_@gitster.mtv.corp.google.com> (Junio
        C. Hamano's message of "Tue, 06 Dec 2016 14:15:48 -0800")
Message-ID: <xmqqd1h3y506.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9AF6034-BCA9-11E6-8058-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...
> I would not be surprised if some existing calls to hold_lock*()
> functions that pass die_on_error=0 need to be updated to pass
> LOCK_SILENT_ON_ERROR, and when this fix is taken alone, it may look
> like a regression, but we are better off starting louder and squelch
> the ones that we find safe to make silent than the other way around.

I actually take this part back, for two reasons.

 * Before the recent js/sequencer-wo-die topic that made this
   failure mode of 'git merge' more dangerous by accident, there
   were already callers that passed die_on_error=0 to hold_lock*
   family of functions, and we can trust these callers.  They either
   have been silent upon lock failure sensibly (e.g. a caller that
   tries to acquire the lock to opportunistically update the index
   can safely choose not to do anything and be silent) or they have
   had their own way of reporting the errors to the users.  The "you
   need to ask to be totally quiet" approach in my rerolled patch
   (the one I am responding to) will introduce new regressions to
   these codepaths.

 * Among the ones that stopped passing die_on_error=1 when the topic
   was merged, there are
   ones that give sensible error messages.  Again, they do not need
   extra message with the "you need to ask to be totally quiet"
   approach [*1*].

We need to instead go through the latter, i.e. the ones that appear
in "git show --first-parent 2a4062a4a8", with fine-toothed comb to
see which 0 made an error totally silent (like the one Robbie
spotted in merge.c) and fix them to ask hold_lock*() functions not
to die but still report an error.

