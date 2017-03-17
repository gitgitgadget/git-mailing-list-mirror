Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2ED52095C
	for <e@80x24.org>; Fri, 17 Mar 2017 15:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751645AbdCQP1D (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 11:27:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53427 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751641AbdCQP1B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 11:27:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7066778A1;
        Fri, 17 Mar 2017 11:26:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=of8B/cO2dkjHbSVsUf/PNB0PW7M=; b=fdg9Uj
        wEdCVOaCOHIiCS+OAiJUfX8KubGWozD0XEe+i3CkRD5UBOPUWQJCR7le8GcaSuXT
        tSqOe3dQfjalT+chNeRGqtTkvW04r2Uw/mewdt12tEvtg/YPR8g7OEiSuqdVvG79
        94pjqPAwauswMVl10Nd6Mmoc8hqnE9wiDDnMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hTVX47cndqw/MyKEDffthBM2LKn7wG1C
        8dzDoC1im+ZGnCCLZ8hg9wWK0sxPdhKcWvpoTi0GCcYGJeL7qmDs7dVfR9KCRXCr
        ZWktbEj3iYd+ZvbcX741rSONxYqtV3s96eG58O6WttYJvGc47EuaOKARoVH+vvpe
        +fAdMVgTwow=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C0043778A0;
        Fri, 17 Mar 2017 11:26:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 34B7377898;
        Fri, 17 Mar 2017 11:26:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Joe Rayhawk <jrayhawk@freedesktop.org>, git@vger.kernel.org
Subject: Re: Shared repositories no longer securable against privilege escalation
References: <148971018136.2144.12683278043600094739@richardiv.omgwallhack.org>
        <195b30d7-9ea2-7a9b-79ca-41b7bb890a30@alum.mit.edu>
Date:   Fri, 17 Mar 2017 08:26:39 -0700
In-Reply-To: <195b30d7-9ea2-7a9b-79ca-41b7bb890a30@alum.mit.edu> (Michael
        Haggerty's message of "Fri, 17 Mar 2017 13:07:36 +0100")
Message-ID: <xmqqo9wz9b68.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E40231E-0B26-11E7-9456-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> (I can't resist pointing out that the *real* bug is storing special
> references like `HEAD` in the top level of $GIT_DIR, but that can't be
> changed now.)

If you call that "pointing out", I can't resist pointing out that
you are utterly *wrong* ;-)

For one thing, HEAD.lock being the only reported case does not mean
"special refs" is the only thing, and more importantly, it will stay
to be the only thing, that would want to write directly underneath
$GIT_DIR directory.  We may want to add a feature to store push
certificates whenever a signed push is made, and we are free to
decide that directly underneath $GIT_DIR is the place to do so.

Also, with your same logic, you could also say that the real bug is
not in the refs subsystem but is in the lockfile subsystem.  If it
did not use $GIT_DIR/$thing.lock when locking $GIT_DIR/$thing, and
instead it used $GIT_DIR/lock/$thing to do so, you wouldn't have
needed to be able to create $GIT_DIR/HEAD.lock.

I _think_ the real bug is that somehow a user got a wrong impression
that directly underneath $GIT_DIR/ is somehow different from its
subdirectory and it is OK to make the directory unwritable.  I do
not think we never intended to give such a promise, but there may be
a documentation bug that gives the wrong impression, which we may
have to fix.

We do try to make sure that in a read-only repository $GIT_DIR/ and
everything underneath can be read-only (and if that is not the case,
you found a bug), but even in that case, we do not special case
$GIT_DIR/ itself and its subdirectories.
