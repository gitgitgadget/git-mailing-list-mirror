Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D84171F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 23:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfHPXYh (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 19:24:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52552 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbfHPXYg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 19:24:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7ABA8151861;
        Fri, 16 Aug 2019 19:24:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uHTmshOP+MELvVPfTCmYoWCU9K4=; b=cecwcE
        7dtl+GAr6unybF02w66Cr5x39vc9NCoMwZ8jvbYPsBh53dnEW6/liB6ljBESCchs
        iRMszF1nfnbLK85i8ymssautTKRKH0k3Cxo9MVlNaCRSE75cW8HwP7zrfXEcH0po
        WCwFpIRyWR74br8Zsrnrbgpk0HxSyIgy5310U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H1UtJb2jXU5m9M5FzhDPmFOl2FBcZ4Bq
        /Wfv4uYBWfro0TssB4RodSOe5IJaPmDZK/IForIgghPfIX8sbvXqMQMEH+jN4bo2
        30mvsBKLKqMsbnIC/OjifPSgNsrlHR7Glnm31iUpCXvSD0PrK15S9R7qbKeUd3uN
        11Xo67bZB4M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71B8F151860;
        Fri, 16 Aug 2019 19:24:34 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DAC1B15185E;
        Fri, 16 Aug 2019 19:24:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 18/24] merge-recursive: consolidate unnecessary fields in merge_options
References: <20190726155258.28561-1-newren@gmail.com>
        <20190815214053.16594-1-newren@gmail.com>
        <20190815214053.16594-19-newren@gmail.com>
        <xmqqftm0zrjs.fsf@gitster-ct.c.googlers.com>
        <CABPp-BF6LPszUcKEwFGPr2DuFRZGU00uM-ky5YhKWw+het2QRA@mail.gmail.com>
Date:   Fri, 16 Aug 2019 16:24:32 -0700
In-Reply-To: <CABPp-BF6LPszUcKEwFGPr2DuFRZGU00uM-ky5YhKWw+het2QRA@mail.gmail.com>
        (Elijah Newren's message of "Fri, 16 Aug 2019 15:59:12 -0700")
Message-ID: <xmqq36i0zob3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0170590C-C07D-11E9-B2E7-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> At the end of this series, the "merge-recursive: add sanity checks for
> relevant merge_options" commit adds some assertions that would fail if
> someone passed such a value, regardless of whether this patch was
> included or not.  (Are we worried about people having such a config
> value and should we support it?  It goes against the documented
> values, but I guess someone could have set it anyway even if it seems
> odd to set a value that says, "give me whatever the default is.")

I am somewhat worried about changing the rule on the users without
telling them (and without having a good reason to enforce a tighter
version retroactively).

If we are formally forbidding "[diff] renameLimit = -1" and other
out-of-bound values, (1) assert() will most often turn into noop in
non-debug builds, so the last step of this series may not be such a
good sanity check anyway, (2) "if (condition) BUG();" may be better,
but that's for catching programming errors that made the condition
hold and configuration the end-user had should not trigger it.

So if we want to really catch bogus end-user-supplied values (and we
really do---but the definition of "bogus" may be debatable), the
place to do so is not the "sanity-check at the end", but where we
call get_config_int() and friends.

