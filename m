Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC59F1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 18:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319AbcHCSaU (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 14:30:20 -0400
Received: from atl4mhfb04.myregisteredsite.com ([209.17.115.120]:47750 "EHLO
	atl4mhfb04.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752795AbcHCSaS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 14:30:18 -0400
Received: from atl4mhob07.myregisteredsite.com (atl4mhob07.myregisteredsite.com [209.17.115.45])
	by atl4mhfb04.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id u73IQP0L028848
	for <git@vger.kernel.org>; Wed, 3 Aug 2016 14:26:26 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.205])
	by atl4mhob07.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id u73IPNPW021712
	for <git@vger.kernel.org>; Wed, 3 Aug 2016 14:25:23 -0400
Received: (qmail 14085 invoked by uid 0); 3 Aug 2016 18:25:23 -0000
X-TCPREMOTEIP: 69.47.70.101
X-Authenticated-UID: andrew@kellerfarm.com
Received: from unknown (HELO ?192.168.0.195?) (andrew@kellerfarm.com@69.47.70.101)
  by 0 with ESMTPA; 3 Aug 2016 18:25:23 -0000
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: obsolete index in wt_status_print after pre-commit hook runs
From:	Andrew Keller <andrew@kellerfarm.com>
In-Reply-To: <xmqqh9bqlfto.fsf@gitster.mtv.corp.google.com>
Date:	Wed, 3 Aug 2016 14:25:22 -0400
Cc:	Git List <git@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <CDE30958-C112-4C26-A0EA-499BFCD4E07F@kellerfarm.com>
References: <5988D847-25A2-4997-9601-083772689879@covenanteyes.com> <2ED67396-2530-4D1C-8F21-1C30983DB9DC@kellerfarm.com> <CAPc5daWZofdZnE0VQyFX2sBQyEDvAPmU+4rmHe5rvh7eH001ZA@mail.gmail.com> <xmqqh9bqlfto.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.2104)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 15.07.2016 um 6:03 nachm. schrieb Junio C Hamano <gitster@pobox.com>:
> 
> Ahh, I misremembered.  2888605c (builtin-commit: fix partial-commit
> support, 2007-11-18) does consider the possibility that pre-commit
> may have modified the index contents after we take control back from
> that hook, so that is probably a good place to enumerate what got
> changed.  Getting the list before running the hook can give an
> out-of-date list, as you said.

I’ve been experimenting with two different workflows recently:

    (1) Identify problem files during the pre-commit hook;
        when found, fix them automatically in the index and let the commit continue.
    (2) Identify problem files during the pre-commit hook;
        when found, provide instructions to fix the problem (and possibly set a helpful
        Git alias to do it in one command), and abort the commit.  Require that the user fixup
        the index and try the commit again.

And here are my thoughts:

#1 seems to be quick and simple for the user, and it plays (mostly) nice with scripts
and IDEs that do commits autonomously, but I’m having trouble trusting that my
pre-commit hook made the *correct* changes (even though it’s worked nicely so far)
(i.e., I keep looking at the new HEAD commit to make sure it looks right, where
normally I just look at the index and make sure it looks right).

#2 is slightly more difficult to implement just because it has more moving parts,
however I’m finding that because I can interrogate the index after I manually run
the command to make the required changes to the index, and *before* I commit
again, I feel much more confident that I know what is going to be in my commit.
However, this approach doesn’t play well with automated scripts that assume that
a commit operation will always work.

In summary, I think I prefer #2 from a usability point of view, however I’m having
trouble proving that #1 is actually *bad* and should be disallowed.

Any thoughts?  Would it be better for the pre-commit hook to be officially allowed to
edit the index [1], or would it be better for the pre-commit hook to explicitly *not* be
allowed to edit the index [2], or would it be yet even better to simply leave it as it is?

[1] and possibly create a patch that teaches builtin/commit.c to reread the index
    after the pre-commit hook runs and before rendering the commit message template
[2] and possibly create a patch that teaches builtin/commit.c to detect changes to the
    index after the pre-commit hook runs

Thanks,
 - Andrew Keller

