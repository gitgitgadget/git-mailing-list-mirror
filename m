Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6B8C203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 22:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057AbcGYWAW (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 18:00:22 -0400
Received: from mta01.prd.rdg.aluminati.org ([94.76.243.214]:55265 "EHLO
	mta01.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756009AbcGYWAT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2016 18:00:19 -0400
Received: from mta01.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id 3B805C041B;
	Mon, 25 Jul 2016 23:00:16 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta01.prd.rdg.aluminati.org (Postfix) with ESMTP id 3643220B69;
	Mon, 25 Jul 2016 23:00:16 +0100 (BST)
X-Quarantine-ID: <oyxeJBLbXo8T>
X-Virus-Scanned: Debian amavisd-new at mta01.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta01.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oyxeJBLbXo8T; Mon, 25 Jul 2016 23:00:14 +0100 (BST)
Received: from river.lan (unknown [10.2.0.10])
	by mta01.prd.rdg.aluminati.org (Postfix) with ESMTPSA id 2A48B6210E;
	Mon, 25 Jul 2016 23:00:11 +0100 (BST)
From:	John Keeping <john@keeping.me.uk>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 0/3] push: allow pushing new branches with --force-with-lease
Date:	Mon, 25 Jul 2016 22:59:54 +0100
Message-Id: <cover.1469483499.git.john@keeping.me.uk>
X-Mailer: git-send-email 2.9.2.639.g855ae9f
In-Reply-To: <xmqq4m7d7hlq.fsf@gitster.mtv.corp.google.com>
References: <xmqq4m7d7hlq.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 25, 2016 at 10:28:01AM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > If there is no upstream information for a branch, it is likely that it
> > is newly created and can safely be pushed under the normal fast-forward
> > rules.  Relax the --force-with-lease check so that we do not reject
> > these branches immediately but rather attempt to push them as new
> > branches, using the null SHA-1 as the expected value.
> >
> > In fact, it is already possible to push new branches using the explicit
> > --force-with-lease=<branch>:<expect> syntax, so all we do here is make
> > this behaviour the default if no explicit "expect" value is specified.
> 
> I like the loss of an extra field from "struct ref".
> 
> I suspect that the if/else cascade in the loop in apply_cas() can
> also be taught that ':' followed by an empty string asks to check
> that the target ref does not exist, in order to make it a bit more
> useful for folks who do not rely on the "use the last observed
> status of the tracking branch".
> 
> That would make the "explicit" test much less cumbersome to read.

Yes, that's nicer and it mirrors the syntax for deleting a remote
branch.

I've pulled it out as a preparatory step because I like the fact that
the "explicit" test passes even before the patch that is the main point
of the series.

> > +test_expect_success 'new branch covered by force-with-lease (explicit)' '
> > +   setup_srcdst_basic &&
> > +   (
> > +           cd dst &&
> > +           git branch branch master &&
> > +           git push --force-with-lease=branch:0000000000000000000000000000000000000000 origin branch
> > +   ) &&

John Keeping (3):
  Documentation/git-push: fix placeholder formatting
  push: add shorthand for --force-with-lease branch creation
  push: allow pushing new branches with --force-with-lease

 Documentation/git-push.txt |  5 +++--
 remote.c                   |  9 +++++----
 remote.h                   |  1 -
 t/t5533-push-cas.sh        | 38 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 7 deletions(-)

-- 
2.9.2.639.g855ae9f

