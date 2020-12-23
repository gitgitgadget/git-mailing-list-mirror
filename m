Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE54C433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 10:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6288F22475
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 10:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgLWKFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 05:05:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64536 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgLWKFH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 05:05:07 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10055A6AD5;
        Wed, 23 Dec 2020 05:04:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=JOXs1wyIxPKrQJTFOUjoyG3MFtY=; b=QF/am5GqX8Wfw3iW/cgj
        E2+8Z6nbmn+7+nDOLJtN7HxpLgN4vsk+ZSQM+54sXELG21LRuRtw5yYhELM4j8GU
        DyKlQvriihnk+UznebQotEprASp81dpFv+/K3jVOFZ8UbD3huHyj1azvG2jfmc5C
        ckeWAebaRgRh5oAKHqylPG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=hXplF4VuPDEb58jvcctawSdRtppqOcCH89oJpdG+xRrF+Y
        eTZhrPyYdGIC1qcdRlogFaH50pNoIYoa+bTg+ERmGHofOpvJaBoSBaunOA5wPAJH
        LQoL6qwIMHdIBpBU4Dn8RSfp0t0d6RBeeNTE89gzb+FSQUpr9343OrwsPX6j4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0771DA6AD4;
        Wed, 23 Dec 2020 05:04:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 444E9A6AD3;
        Wed, 23 Dec 2020 05:04:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 0/5] making pull advice not to trigger when unneeded
References: <20201214202647.3340193-1-gitster@pobox.com>
        <5fd85811c3a6_d7c48208aa@natae.notmuch>
        <xmqqmtyf8hfm.fsf@gitster.c.googlers.com>
        <5fd8aa6a52e81_190cd7208c8@natae.notmuch>
        <5fdd154264baf_130e182082b@natae.notmuch>
Date:   Wed, 23 Dec 2020 02:04:23 -0800
Message-ID: <xmqqsg7waleg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BF52D82-4506-11EB-921C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> It's clear --ff doesn't imply a merge, so we shouldn't act as if it was.

Do you specifically mean --ff, or do you talk collectively about
anything that goes in opt_ff in the C code?

The "--ff" option means "we are allowing fast-forward, so please do
not make new commit object unnecessarily, but it is just we are
allowing---we are not limiting ourselves to fast-forard; feel free
to create a merge commit if necessary".  So it does imply that the
user prefers to merge and does not want to rebase.

If you meant what opt_ff can relay, then there are "--no-ff" and
"--ff-only" to consider:

 - "--no-ff" says "we do not allow fast-forward; when the other side
   is pure descendant of ours, create a merge commit to make them
   the second parent, so that our side of the history stays to be
   the first-parent chain that merged them as a side topic."  It may
   not say what should happen when the history does not
   fast-forward, and it _is_ possible to argue, for the sake of
   argument, that it asks to rebase if not fast-forward (so that
   their history becomes the primary and we build on top of them)
   while asking to merge if fast-forward (so that our history stays
   the primary and we absorb their work as a side branch), but that
   is a behavior that does not make much sense.  It is much easier
   to reason about if we accept that the user who says "--no-ff"
   expects a merge to happen, not a rebase.

 - "--ff-only" says "when their history is pure descendant of ours,
   just fast-forward our branch to match their history, and
   otherwise fail."  This one does not have to imply either merge or
   rebase, as both would give us identical result (i.e. merge would
   fast-forward and rebase would replay *no* work of our own on top
   of theirs.  Either case, the result is that our branch tip now
   points at the tip of their history).

   The topic under discussion is based on the "we do not have to
   give advice between merge and rebase if the history
   fast-forwards", and anybody in support of the topic would be in
   agreement with this case.

In any case, I think what we have in 'seen' already is a good
stopping point for this cycle.  We are not erroring out any new case
and simply not showing an advice in a situation that it would not
apply---the question "does --ff imply merge?" does not have to be
answered in order to evaluate the 5-patch series we have.
