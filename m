Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D2AC433F5
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 05:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241037AbiD3FDa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 01:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbiD3FD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 01:03:28 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B92B2603
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 22:00:06 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D251518DE5F;
        Sat, 30 Apr 2022 01:00:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EW1X7k6QkSPEdb2IkZcVyn0AJ5CEzX4Al3Ix6+
        utKl0=; b=GdpzECyap/sTFZnbTmZ6zNGeOjcWoT4p97leQUQ+6NdajYE6eYchdq
        04KRE8evqTRJkViCgf+7BdbALjww6F9hWOqzClHTQgfjmmp7++3nTbMg7vWgrSmA
        fexYofYTlBcjdPx8Zshhco9EL+pdb74mhPAeBUcEg5+7QCpJw5d0k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CA87C18DE5C;
        Sat, 30 Apr 2022 01:00:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CBC5618DE3F;
        Sat, 30 Apr 2022 00:59:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Li <dan@danielyli.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: Bug: `git show` honors path filters only for the first commit
References: <CAHVT7hW28jMcphDPhcUG==mycCWDaAt46wWo68=oTcSvebHWwg@mail.gmail.com>
Date:   Fri, 29 Apr 2022 21:59:58 -0700
In-Reply-To: <CAHVT7hW28jMcphDPhcUG==mycCWDaAt46wWo68=oTcSvebHWwg@mail.gmail.com>
        (Daniel Li's message of "Fri, 29 Apr 2022 19:22:06 -0700")
Message-ID: <xmqqzgk388tt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 632686C4-C842-11EC-881F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Li <dan@danielyli.com> writes:

> git version: 2.36.0
> OS: macOS Monterey 12.2.1
> Installed via: homebrew

I think this is the same regression as the recently talked about
"diff-tree --stdin" aka "gitk" regression.

https://lore.kernel.org/git/xmqq7d7bsu2n.fsf@gitster.g/

e900d494 (diff: add an API for deferred freeing, 2021-02-11), broke
cmd_log_walk(), and we started to lose some setting that was parsed
from the command line and stored in the diff_options structure after
cmd_log_walk() runs just once.  But "git show A B" runs the function
once for each commit.   A recent change in 2.36.0 made it worse by
adding <pathspec> to the set of setting that gets lost after
cmd_log_walk() runs once.

Thanks for a report.


