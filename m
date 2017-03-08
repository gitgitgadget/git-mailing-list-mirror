Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B488B202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 19:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753886AbdCHTJb (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 14:09:31 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52111 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752986AbdCHTJa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 14:09:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA7F96C2B7;
        Wed,  8 Mar 2017 13:55:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pHfAm5jcl4E7WrvKH+w0HPJx8KA=; b=a5NIxV
        wslT+Qc/iQXVbjYRLYM3gpJzGtTouA9o13mRSQQRiTGxGdv7Mo8jPuru4qTavYxh
        vEHGMD7IVewE7UuvgNa3zYc3YgX9rIPHZ7SXgra1UpQcqoLW3vfoenWcPdLOQNNm
        DowtRq4uN6AkAfRTkqApkGv3AkMbCExLfC9Gk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YJRpTNskSLx7w5cbRTOcwpQwPGVyYNM/
        Zo2HuBOvnjUlMKvLB188j7VY64zOQemtO+uH3j0ICFqTfa2Mmu2V/5NCsGEgBz03
        Lkz6EFUdy1x2hIAe914gsBzsZue++fyAoXqK61H8H1h+zfig57dAFY35wgiJIuul
        pZquoqKEyAk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C1EF06C2B6;
        Wed,  8 Mar 2017 13:55:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 29B826C2B5;
        Wed,  8 Mar 2017 13:55:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <jeffhost@microsoft.com>
Cc:     git@vger.kernel.org, peff@peff.net, markbt@efaref.net,
        benpeart@microsoft.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH 06/10] rev-list: add --allow-partial option to relax connectivity checks
References: <1488994685-37403-1-git-send-email-jeffhost@microsoft.com>
        <1488994685-37403-7-git-send-email-jeffhost@microsoft.com>
Date:   Wed, 08 Mar 2017 10:55:31 -0800
In-Reply-To: <1488994685-37403-7-git-send-email-jeffhost@microsoft.com> (Jeff
        Hostetler's message of "Wed, 8 Mar 2017 17:38:01 +0000")
Message-ID: <xmqqd1dr38f0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE32A4A6-0430-11E7-BD55-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <jeffhost@microsoft.com> writes:

> From: Jeff Hostetler <git@jeffhostetler.com>
>
> Teach rev-list to optionally not complain when there are missing
> blobs.  This is for use following a partial clone or fetch when
> the server omitted certain blobs.

This makes it impossible to tell from objects missing by design
(because we did an --partial-by-size clone earlier, expecting we can
later fetch from elsewhere when necessary) and objects inaccessible
by accident (because you have a repository corruption), no?

Even though I do very much like the basic "high level" premise to
omit often useless large blobs that are buried deep in the history
we would not necessarily need from the initial cloning and
subsequent fetches, I find it somewhat disturbing that the code
"Assume"s that any missing blob is due to an previous partial clone.
Adding this option smells like telling the users that they are not
supposed to run "git fsck" because a partially cloned repository is
inherently a corrupt repository.

Can't we do a bit better?  If we want to make the world safer again,
what additional complexity is required to allow us to tell the
"missing by design" and "corrupt repository" apart?

Thanks.
