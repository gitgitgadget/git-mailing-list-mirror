Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51534C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 12:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2478A6103B
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 12:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244801AbhIXMGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 08:06:12 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:47001 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239965AbhIXMGL (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Sep 2021 08:06:11 -0400
Received: from MTA-08-3.privateemail.com (mta-08-1.privateemail.com [68.65.122.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 6558F80514
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 08:04:37 -0400 (EDT)
Received: from mta-08.privateemail.com (localhost [127.0.0.1])
        by mta-08.privateemail.com (Postfix) with ESMTP id 8FA3C18000A5;
        Fri, 24 Sep 2021 08:04:36 -0400 (EDT)
Received: from [192.168.0.46] (unknown [10.20.151.233])
        by mta-08.privateemail.com (Postfix) with ESMTPA id C25BF18000A4;
        Fri, 24 Sep 2021 08:04:35 -0400 (EDT)
Date:   Fri, 24 Sep 2021 08:04:29 -0400
From:   Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH v7 1/2] grep: refactor next_match() and
 match_one_pattern() for external use
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Message-Id: <HJTXZQ.ONLOCDR1B7O51@effective-light.com>
In-Reply-To: <xmqq8rzn2ohj.fsf@gitster.g>
References: <20210921211324.1426938-1-someguy@effective-light.com>
        <Hamza
        Mahfooz's message of "Tue, 21 Sep 2021 17:13:23 -0400">
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 23 2021 at 10:25:28 AM -0700, Junio C Hamano 
<gitster@pobox.com> wrote:
> But how would the new caller that points "bol" at middle of a line
> make sure that we are looking at the right kind of header?  If the
> pattern p is set to match only for an author line, the first call
> with "bol" set to the true beginning of the line will correctly
> reject a "committer" header, but because you lost the sanity check
> above, the second and subsequent one will go ahead and scan for the
> pattern p on the line, even if p->field asks for author line and the
> line records the committer.  You'd end up finding a commit object
> that is committed by (but not authored by) the person when you are
> looking for a commit that was authored by somebody, no?
> 
> If you ask for commits by somebody (e.g. "--author=Hazma") with an
> output format that shows both the author and the committer
> (e.g. "log --pretty=fuller"), wouldn't your "hit coloring" code
> show Hazma on the committer name as a grep hit, too?

Actually, this issue doesn't arise because I filter away the irrelevant
(header) patterns in grep_next_match(). However, maybe it's a better 
idea
to handle that in match_one_pattern().


