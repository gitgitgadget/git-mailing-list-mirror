Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 449611F45F
	for <e@80x24.org>; Tue,  7 May 2019 15:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfEGPFv (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 11:05:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61051 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfEGPFu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 11:05:50 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1E8A1496E2;
        Tue,  7 May 2019 11:05:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QOjyl6WYZmsmyujoNhpkO/TLpMs=; b=XclpMX
        VW3BWkfUtqxZUemb6PaleRZeakHjOuboroh3Wi3pi3U1I6Rn3pO9Qbp8TpaS+GiK
        a7jqXs1OBefw0juryuIfoRT0jX7BOuk0PxhGqdPCVwo2pAKMwEZlPp8P3khBOrwg
        uiXSEmS2cdog/OWRgedGagUForY4CHCaTfEQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eVrS5zueuWmJUd/U+CS0bYwJZAqBIrjQ
        DlRCoTOVNggLQ7GNuUcUxscbkDuKHsCzGIBzvTLhP1wTnFgvNzrUJ8X8Y6vh+0bO
        QIWCfqICshaa6UkKx7/7pd3mT51p7c++lF20n7fDKFNOvlMkFZWCHkeFRwLkPMBx
        5ntnbBV5CWM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B94C31496E1;
        Tue,  7 May 2019 11:05:45 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D20D1496E0;
        Tue,  7 May 2019 11:05:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/7] teach branch-specific options for format-patch
References: <cover.1557072929.git.liu.denton@gmail.com>
        <xmqq4l66myn3.fsf@gitster-ct.c.googlers.com>
        <20190507141942.GA359@archbookpro.localdomain>
Date:   Wed, 08 May 2019 00:05:43 +0900
In-Reply-To: <20190507141942.GA359@archbookpro.localdomain> (Denton Liu's
        message of "Tue, 7 May 2019 10:19:42 -0400")
Message-ID: <xmqq36lql2yg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96C6DB82-70D9-11E9-8E75-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> The reason why I chose to use branch.<name>.* is because format-patch
> currently reads from branch.<name>.description and I wanted to build on
> top of that. In addition, I didn't want to scatter branch-specific
> configs in two different place (i.e. have a branch.<branchName>.description
> alongside a format.<branchName>.coverSubject).

The "branch.<name>.description" variable lives at a lot higher level
of abstraction than "use this for the default value of option X of
the command Y".  It gives a place for the user to state what the
branch is about.  It makes 100% sense not to have it under format.*
hierarchy, because it is designed to be agnostic to what individual
command uses it for.  It is there to talk about what the branch is
for, and what the variable says about the branch to its users,
i.e. various tools, does not change depending on who is listening to
it.

The format-patch command may use it as a hint for writing the cover
letter message.  Repository browsers may use it while listing the
branches when more descriptive text than the branch name is desired.
Request-pull tool may use it when preparing the branch summary.

The point is that "description" is about "what that *branch* is",
not "what that branch means for the format-patch user".

You cannot compare that with something like "when format-patch
prepares an e-mail, add CC: header to this address", which is very
specific to the single command, i.e. "how command X uses it".  I
think that is the gist of the new variables you are adding.

>> In any case, it smells to me that branch.<branch>.cc does not hint
>> strongly enough that they are meant to affect format-patch.
>
> Would you suggest moving to a format.<branchname>.* approach or would it
> make sense to rename the configs to something like
> branch.<name>.{emailCoverSubject,emailTo,emailCc}?

So if I have to pick between the two, I would probably vote for the
former from the philosophical ground, but operationally, I suspect
that the latter would be much simpler to use.  You could even have
"git branch -d <name>" to get rid of them at the same time.

But as I may have hinted in the message you are responding to, I am
not quite convinced we want these configuration variables in the
first place.  Why should both description and coverSubject need to
exist?  Perhaps we should add a heuristic like "If the branch
description looks like a single line, optionally followed by 'a
blank line and more paragraphs', use the first line as the subject
of the cover letter (and the remainder as the body of the cover
letter) or something?

