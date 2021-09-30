Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF67C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 20:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E936617E5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 20:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhI3UV0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 16:21:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60353 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhI3UVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 16:21:25 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 523AD149DCD;
        Thu, 30 Sep 2021 16:19:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tAzDgz9n3QNM3rIluP3Gk2bVjTH1ueyH45NhZC
        d2E38=; b=Vg602DjEk+1qI0nv1bZLljjimCAupG936P3OE+GEK9dsQVL74Fwsp+
        FV5vcp2buxf17peKH7Z7bfp1n1Fl35CslxaRVlEE8gqUMH+Y06Hu5wjmwSIdNEFM
        F8XSDn8g4ewFZWvdGrY/0ac9QZmDe9x0bj3DmVTbt238rZu7CB1O4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4AE0F149DCB;
        Thu, 30 Sep 2021 16:19:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A968D149DC9;
        Thu, 30 Sep 2021 16:19:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH 5/7] tmp-objdir: new API for creating and removing
 primary object dirs
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
        <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
        <YVOiggCWAdZcxAb6@coredump.intra.peff.net>
        <CABPp-BFuj3W20J-aKU4BL9cqgA-GPZ2prEbAebY_kR0adaGzHw@mail.gmail.com>
        <YVVmssXlaFM6yD5W@coredump.intra.peff.net>
        <20210930192537.GA4151@neerajsi-x1.localdomain>
Date:   Thu, 30 Sep 2021 13:19:38 -0700
In-Reply-To: <20210930192537.GA4151@neerajsi-x1.localdomain> (Neeraj Singh's
        message of "Thu, 30 Sep 2021 12:25:37 -0700")
Message-ID: <xmqq5yuhbyud.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD560DF8-222B-11EC-9287-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

> Is there state we care about besides objects and refs? Maybe we need to
> introduce a transactional system for the entire repository like we have
> for the refs-db.  In-process code that cares about oids that might be
> only transactionally present can register a callback for when the transaction
> commits or rollsback.  I'm not volunteering to write this, btw :).

I take it to mean by "objects and refs" that we care only about
objects that are reachable from the refs?  The index (the primary
index array plus extensions that record object names) also has
anchoring points we care about (ask "git fsck" what they are).

> We can make the tmp object directory stuff more prevalent by using it in
> git-apply and the merge stategy, and by using bulk-checkin while writing out
> the cached tree and commits. This should flush out any issues and keep other
> parts of the codebase honest.

I wonder what's so wrong about cruft objects in the main object
store that may be gc-ed away laster, though.  IOW, I wonder if it is
simpler to treat the quarantine while accepting dubious foreign data
via "git push" in receive-pack as an exception, not a norm.

