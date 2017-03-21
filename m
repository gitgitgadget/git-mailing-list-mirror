Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9990320323
	for <e@80x24.org>; Tue, 21 Mar 2017 06:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756327AbdCUG6G (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 02:58:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51223 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752325AbdCUG6G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 02:58:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BEE486A9C;
        Tue, 21 Mar 2017 02:54:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vYPfhtEsuFZdtSWirm+vfO9zgd0=; b=LUZ2Jh
        YdtwS9F8pIx7d0VJrUCJqKn/lcdq3xQvvZfNYcVflv0JHvlBG5/srdE1rsWCKziz
        sa10zQmlSK9eZginEAEn30T0+3qoEW27ik2dbaredYc/rXyBDPKIMzVx8NEjpDau
        SHCSvixf6leNUzYKUFcO8NYfw5JzSCi+OurFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hbxyfqv0pFAMuQ1KiapvnPnayQpqkdEa
        COmMUdnkJ9rmRnYaVKnSI+xVs2zYS0EeElfW00VU/Q/Chz9MN2MaDeyhOJeXJPdW
        EAMbSYDngNoHPQNjUuNpWVzN0di/Eep1u1PmnauUPrrdmwicsLkli8OIWM6NGpCP
        8F4MI57ToQs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 232BF86A9B;
        Tue, 21 Mar 2017 02:54:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 80E2786A98;
        Tue, 21 Mar 2017 02:54:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     jrnieder@gmail.com, git@vger.kernel.org, mfick@codeaurora.org
Subject: Re: [PATCH 0/3] git-describe deals gracefully with broken submodules
References: <20170321001156.21915-1-sbeller@google.com>
        <xmqq7f3jta7o.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 20 Mar 2017 23:54:37 -0700
In-Reply-To: <xmqq7f3jta7o.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 20 Mar 2017 23:28:27 -0700")
Message-ID: <xmqq37e7t902.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 405A07E6-0E03-11E7-A9B1-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I do not have a strong preference for or against the "treat a broken
> repository as if nothing is wrong with the revision, but just mark
> it as dirty" idea.  I would be more receptive if it substituted the
> "-dirty" marker with something else, e.g. "-broken", though.
> ...
> But it is possible there may be a reason why submodules are special.
> I do not think the third paragraph quoted above is a good
> justification.  A repository with broken submodule is just as broken
> and untrustworthy as a broken repository without a submodule, and if
> you want to allow such a checkout with broken submodule to call
> itself v2.0-dirty, you would also want to allow a broken checkout
> without any submodule to do so, too.

Having said all that, if I thought it were a good idea to optionally
allow people to treat "repository is corrupt in some ways to make it
impossible for us if the checkout is dirty or not, even though we
are fairly certain what commit .git/HEAD points at is" as a state
that is describable, I probably would

 - introduce a new "git describe --possibly-broken" option;

 - instead of running "diff-index" internally to decide the "-dirty"
   state, spawn "diff-index" as a separate process;

 - observe the exit status from "diff-index" and add "-dirty" suffix
   when it is _known_ to be dirty, add "-broken" suffix when it
   died, and leave out the suffix when we know that the checkout is
   clean.

That way, we wouldn't have to contaminate the generic codepath with
a "treat broken and modified states as if they are the same" logic,
only to support such a niche feature that we wouldn't want to use
anywhere else.
