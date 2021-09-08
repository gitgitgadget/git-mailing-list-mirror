Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04680C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 17:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCE5E61131
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 17:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350206AbhIHRZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 13:25:09 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:35319 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231723AbhIHRZE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 13:25:04 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4H4TWX2hgrz5tl9;
        Wed,  8 Sep 2021 19:23:52 +0200 (CEST)
Subject: Re: diff-index --cc no longer permitted, gitk is now broken
 (slightly)
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
 <87h7f4tf0b.fsf@osv.gnss.ru> <xmqqy288b64q.fsf@gitster.g>
 <87pmtjkwsj.fsf@osv.gnss.ru>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <cbd0d173-ef17-576b-ab7a-465d42c82265@kdbg.org>
Date:   Wed, 8 Sep 2021 19:23:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <87pmtjkwsj.fsf@osv.gnss.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.09.21 um 15:43 schrieb Sergey Organov:
> Besides, nobody yet told us why gitk uses --cc option in invocation of
> 'diff-index' in the first place. Does it actually *rely* on particular
> undocumented behavior of "diff-index --cc", or is it just a copy-paste
> *leftover*?

No, it is not a left-over. The thing is,

- there is one point in the code where gitk adds options -p -C --cc (and
more) to the command line (around line 8034),

- and there is a totally different point in the code where it is decided
whether diff-index, diff-tree, or diff-files is invoked (proc diffcmd
around line 7871).

IOW, Gitk expects that these option combinations can always be passed to
all three commands.

Gitk does not want to look at a commit and then decide which incarnation
of the command it wants to use (--cc vs. -p) depending on whether it is
a merge commit or not. This decision is delegated to command that is
invoked. Therefore, silent fall-back from --cc to -p in case of
non-merge commits or non-conflicted index is absolutely necessary.

-- Hannes
