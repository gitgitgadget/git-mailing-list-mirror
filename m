Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1498BC19F2C
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 16:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbiHAQew (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 12:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbiHAQeu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 12:34:50 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF35A3AB19
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 09:34:48 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DE13B138F02;
        Mon,  1 Aug 2022 12:34:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=meEtoxh7+lK8
        AeYJBWLxayJ9s5FXUVf3rN+aZbl/N2w=; b=gshqLWCrzpHV9rM8JUkbOO70jt0x
        5mhzrrqPBojRxq1kXLHpPLax7sbCPP2yLkC+/1ayy2ymelxCaCbL91K9Uxp4iHpL
        SFmp4cdbyFRtvYe08jOtOWdE9l74ipjWslk8PKbmZx3vjlZVNDqlNl0HXev+Xg5M
        h6Z2y/UhseXbqm4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D42B2138F00;
        Mon,  1 Aug 2022 12:34:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 37D02138EFF;
        Mon,  1 Aug 2022 12:34:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ignat Insarov <kindaro@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Reveal by history that several commits are independent from
 each other?
References: <CAB-2Q0_WmRue1gtaJGDGFoPwKdyyHf7dpuLoyZMDCXouxyP+BA@mail.gmail.com>
Date:   Mon, 01 Aug 2022 09:34:45 -0700
In-Reply-To: <CAB-2Q0_WmRue1gtaJGDGFoPwKdyyHf7dpuLoyZMDCXouxyP+BA@mail.gmail.com>
        (Ignat Insarov's message of "Mon, 1 Aug 2022 17:03:58 +0300")
Message-ID: <xmqqh72vzzve.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DA982D20-11B7-11ED-83A4-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ignat Insarov <kindaro@gmail.com> writes:

> Is this a reasonable practice?=E2=80=82Is there any prior art?=E2=80=82=
What are the troubles to
> look forward to?

You can maintain such a history structure if you really wanted to,
and rebase with "git rebase --rebase-merges" while keeping the merge
structure, but I am not sure if this is worth the effort.

For example, you mentioned "rebase", but consider the reason why why
are you rebasing in the first place.

You made a diamond structure because 3 depends on both 1 and 2,
*AND* both 1 and 2 needed whatever was in their ancestor.

	      1---3
             /   /
	----O---2

Now do 1 and 2 need a lot more than their original ancestor offers
(hence you are rebasing forward), or do they depend on less (hence
you are rebasing backward, porting the change to older codebase)?

It is likely that you are rebasing not for these reasons.  You are
"rebasing to a newer upstream", aren't you?  But why?  You developed
these three commits on O and whatever the others did in the upstream
you weren't even aware of, hence there is no way your work depend on
them.  Even then, perhaps for some other reasons, you are somehow
expected to rebase on a newer upstream.

What does that mean in the overall picture?  The diamond structure
you created does capture some local inter-commit dependency, but in
the larger history, there are ancestry relationships that have
nothing to do with such dependency (e.g. where in the global picture
your diamond sits on by rebasing).  It is unclear how you tell which
parent-child relationship encodes the dependency and which ones are
just "this commit happened to have seen by whoever maintains the
primary history before the other ones".  And unless you can maintain
the entire history and enforce the property that you can pick any
random parent-child pair and they are always "child depends on what
the parent has", it is dubious how much value you can extract from
the history by only doing so very locally.

And that is where my "I am not sure if this is worth" comes from.

Another non-essential detail is that Git and other tools tend to
give special meaning to the first parent chain.  In your diamond
structure, parents 1 and 2 of commit 3 have equal standing and it is
not like one is more important than the other.  So things like "git
log --first-parent" and GUI tools written around the idea that
first-parent chain is more special may not work very well for some
parts of your history (i.e. the part that employs your "topology
shows the minimum dependency" convention).

Just my random thoughts.
