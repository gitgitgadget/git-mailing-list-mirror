Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C86220323
	for <e@80x24.org>; Tue, 21 Mar 2017 06:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756384AbdCUG2n (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 02:28:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61944 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756141AbdCUG2a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 02:28:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE53D86618;
        Tue, 21 Mar 2017 02:28:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6BtB97thkGQ9AWrsCqHbbG/Im2k=; b=v+s/b1
        RWVzPHR7pM+tY57fWeAtoUfEOq8r9Jv7D1TSoPdlBdIsplrBV3DKpnQDwhIpiif5
        KoM6NSr6Zid8VpsP+/+etYK3iAcFn1RilPQSapoHopSH5+OJRcD6xR4OwYi+Kqxq
        qZTn5xatdHnhUUeBhoC2F1cwOmxowV/YqGcTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yM2QdAADfyJaoKTkIuDemrwuWp7dmsgE
        FWhp8XnA5MbvJ5HDxkAJPiUNIYefxaJnPUhrydf2+gEVqKUXpeDkCVnNahpIWAoz
        eEtlx30IMgJlRR8tijszEduSdJbntTqBZXcMZ48w6nOEZWZYfQTcyiipi1Iw9RfO
        DsWPLILtbIg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A713B86617;
        Tue, 21 Mar 2017 02:28:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 220A186616;
        Tue, 21 Mar 2017 02:28:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     jrnieder@gmail.com, git@vger.kernel.org, mfick@codeaurora.org
Subject: Re: [PATCH 0/3] git-describe deals gracefully with broken submodules
References: <20170321001156.21915-1-sbeller@google.com>
Date:   Mon, 20 Mar 2017 23:28:27 -0700
In-Reply-To: <20170321001156.21915-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 20 Mar 2017 17:11:53 -0700")
Message-ID: <xmqq7f3jta7o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9853995C-0DFF-11E7-B9FB-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Our own version generation in GIT-VERSION-GEN is somewhat sane by testing
> if we have a .git dir, and use that as a signal whether the obtained
> copy of git was obtained using git (clone/fetch) or if it is just a
> downloaded tar ball.
>
> Other scripts to generate a version are not as cautious and just run
> "git describe". An error from git-describe is treated as a sufficient
> signal to assume it is not a git repository.
>
> When submodules come into play, this is not true, as a submodule
> may be damaged instead, such that we're still in a git repository
> but error out for the sake of reporting a severly broken submodule.
>
> Add a flag to git-describe that instructs it to treat severe submodule
> errors as "dirty" instead of erroring out.

I do not have a strong preference for or against the "treat a broken
repository as if nothing is wrong with the revision, but just mark
it as dirty" idea.  I would be more receptive if it substituted the
"-dirty" marker with something else, e.g. "-broken", though.

My knee-jerk reaction to the code change is that treating submodule
as something very special is probably not a good idea.  Even if you
do not use submodules, if some of the objects referenced from your
index and/or HEAD are damaged or otherwise causes some error while
accessing, the diff machinery would die, wouldn't it?

I saw that some new symbolic constants in the code to tell the
machinery to "gracefully die" (or "hide the breakage under the rug")
are named with SUBMODULE in them, which is probably a bad sign that
the design is being too centric to submodules.  The implementation
that covers only breakages in submodule as its first step may be OK
(you have to start somewhere, after all), but I think the aspiration
should be to cover all kinds of breakages in the end and turn them
to be "graceful", and if you had that goal in mind, you wouldn't be
naming these constants with SUBMODULE in them.

If "treat a broken repository as just being 'dirty'" were a good
idea, I'd suspect that we would want to see all breakages, not just
ones related to submodules, to be treated the same way.  

But it is possible there may be a reason why submodules are special.
I do not think the third paragraph quoted above is a good
justification.  A repository with broken submodule is just as broken
and untrustworthy as a broken repository without a submodule, and if
you want to allow such a checkout with broken submodule to call
itself v2.0-dirty, you would also want to allow a broken checkout
without any submodule to do so, too.

