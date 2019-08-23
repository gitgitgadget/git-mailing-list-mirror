Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D66641F461
	for <e@80x24.org>; Fri, 23 Aug 2019 17:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfHWRDe (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 13:03:34 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:53187 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbfHWRDd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 13:03:33 -0400
X-Originating-IP: 1.186.12.26
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id E2C6840009;
        Fri, 23 Aug 2019 17:03:30 +0000 (UTC)
Date:   Fri, 23 Aug 2019 22:33:27 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 2/3] git-gui: Add the ability to revert selected lines
Message-ID: <20190823170327.7msmc5khsstejkoh@localhost.localdomain>
References: <20190819214110.26461-1-me@yadavpratyush.com>
 <20190819214110.26461-3-me@yadavpratyush.com>
 <73e63382-4f79-cfd0-47f4-812f9cd4f88b@kdbg.org>
 <20190820192944.gzfwnm52fvb5refq@localhost.localdomain>
 <93095b5a-6e15-ce4a-eb9b-22f9528312e1@kdbg.org>
 <20190821214829.2dzat2quo3h2s3z2@localhost.localdomain>
 <nycvar.QRO.7.76.6.1908231500030.46@tvgsbejvaqbjf.bet>
 <xmqqk1b3n8vv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk1b3n8vv.fsf@gitster-ct.c.googlers.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+Cc Bert. This has the suggestion I was talking about in one of my 
previous replies.

On 23/08/19 09:28AM, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Maybe the direction taken by this discussion merely suggests that the
> > design is a bit unfortunate. Why "revert"? Why not "stash" instead? Then
> > you don't need to have that annoying confirmation dialog.
> 
> Interesting, but it would need a bit more tweak than a simple
> "stash" for it to be truly helpful, I would imagine.
> 
> The primary purpose of stashing from end user's point of view is to
> save some changes, that are not immediately usable in the context of
> the corrent work, away, so that they can be retrieved later, with a
> side effect of wiping the stashed changes from the working tree. The
> command could be (re|ab)used to wipe local changes you have in the
> working tree, but that would accumulate cruft that you most of the
> time (unless you make a mistake) wanted to discard and wanted to
> never look at again in the stash. If done using the same 'stash' ref
> that is used by the normal "git stash", the stash entries created by
> "git stash" because the user really wanted to keep them for later
> use would be drowned among these "kept just in case" stash entries
> that were created as a side effect of (ab)using stash in place of
> "restore".

Thank you. I was just about to write exactly this.

> But "git stash" can be told to use a different ref, so perhaps by
> using a separate one for this "just in case" purpose, with the
> expectation that the entries are almost always safe to discard
> unless the user made a mistake and take it back immediately
> (i.e. "undo"), it would not hurt the normal use of "git stash" *and*
> give the "revert" necessary safety valve at the same time.

I propose a simpler solution. Essentially how the revert works is it 
generates a diff and stores that in a variable. It then calls git-apply 
with --reverse passed in case of reverts and unstages, and without the 
--reverse in case of staging, and then feeds git-apply the generated 
diff.

So how about we keep a copy of the diff in another variable. This allows 
us to enable undoing of reverts. The obvious limitations are that 
firstly, unless we use a stack/deque that means only one undo is 
allowed. I'm not sure if using an undo stack would be worth the added 
complexity. Secondly, if the working tree is changed between the revert 
and the undo, there are chances of a merge conflict.

If people are okay with these limitations, we can be rid of the 
confirmation dialog while providing a safety net. Sounds like a good 
idea?

-- 
Regards,
Pratyush Yadav
