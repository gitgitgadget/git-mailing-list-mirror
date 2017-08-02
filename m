Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4675320899
	for <e@80x24.org>; Wed,  2 Aug 2017 16:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751933AbdHBQUq (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 12:20:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51444 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751172AbdHBQUp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 12:20:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C71749B1D8;
        Wed,  2 Aug 2017 12:20:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2ucwfe3pVxIkBEPMRTjTo4LG1t8=; b=AuaEr1
        9mWqgQy74K4teNDcL92KOCErH1v1GeUV54nrD87ycQWf8439W5SXb4uoqjLV+0L3
        Zqnn/Pj5CG6do1AM9016AfWjTx/Eb8Ehlv3oTgTWYnktydyHaeTo3oRCSQvefzzH
        Zw1TK0ctj6BZuiT+tWVxEWS748oJkbK4N3dM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LEZsV1CIS5F3aUiVm/nNTD7w9FXHs+0E
        npKg9ZBR9QfKP0njLknw6HKg1/l94z3ATfxXV4XX/pXRFL21Av/bXcTaWjFuFnSy
        omhb5xARELG8U+e++Cs186IEWFlOkYCzaQJxqwm5ENOvYt7TPT4EqJkGHDTOpDNA
        eX8aul75rZ4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BDE419B1D7;
        Wed,  2 Aug 2017 12:20:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 07EB19B1D6;
        Wed,  2 Aug 2017 12:20:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peartben@gmail.com, christian.couder@gmail.com
Subject: Re: [PATCH v2 0/5] Fsck for lazy objects, and (now) actual invocation of loader
References: <cover.1501111615.git.jonathantanmy@google.com>
        <cover.1501532294.git.jonathantanmy@google.com>
        <xmqq4ltsi9or.fsf@gitster.mtv.corp.google.com>
        <20170731160533.0a446244@twelve2.svl.corp.google.com>
        <xmqq379bgqlx.fsf@gitster.mtv.corp.google.com>
        <20170801171944.7690a63f@twelve2.svl.corp.google.com>
Date:   Wed, 02 Aug 2017 09:20:35 -0700
In-Reply-To: <20170801171944.7690a63f@twelve2.svl.corp.google.com> (Jonathan
        Tan's message of "Tue, 1 Aug 2017 17:19:44 -0700")
Message-ID: <xmqqefsudjqk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 848E3F9A-779E-11E7-ADC5-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> One possibility to conceptually have the same thing without the overhead
> of the list is to put the obtained-from-elsewhere objects into its own
> alternate object store, so that we can distinguish the two.

Now you are talking.  Either a separate object store, or a packfile
that is specially marked as such, would work.  "Maintaining a list
of object names in a flat file is too costly" is not a valid excuse
to discard the integrity of locally created objects, without which
Git will no longer be a version control system, and your "We have to
trust the sender of objects on the other side anyway when operating
in lazy-objects mode, so devise a way that we can use to tell which
objects we _know_ the other side has" that leads to the above idea
is a good line of thought.

> I mentioned
> this in my e-mail but rejected it, but after some more thought, this
> might be sufficient - we might still need to iterate through every
> object to know exactly what we can assume the remote to have, but the
> "frontier" solution also needs this iteration, so we are no worse off.

Most importantly, this is allowed to be costly---we are doing this
not at runtime all the time, but when the user says "make sure that
I haven't lost objects and it is safe for me to build further on
what I created locally so far" by running "git fsck".
