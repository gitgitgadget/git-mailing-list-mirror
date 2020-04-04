Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34620C4332B
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 17:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A382206F5
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 17:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgDDRlW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Apr 2020 13:41:22 -0400
Received: from mx.sdf.org ([205.166.94.20]:52760 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgDDRlW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Apr 2020 13:41:22 -0400
Received: from sdf.org (IDENT:lkml@faeroes.freeshell.org [205.166.94.9])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 034HfG5s026936
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 4 Apr 2020 17:41:16 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 034HfGBF004360;
        Sat, 4 Apr 2020 17:41:16 GMT
Date:   Sat, 4 Apr 2020 17:41:16 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        lkml@sdf.org
Subject: Re: Feature request: rebase -i inside of rebase -i
Message-ID: <20200404174116.GB11944@SDF.ORG>
References: <20200320223015.GA19579@SDF.ORG>
 <xmqq36a2bpxz.fsf@gitster.c.googlers.com>
 <20200320233528.GB19579@SDF.ORG>
 <nycvar.QRO.7.76.6.2003211135380.46@tvgsbejvaqbjf.bet>
 <20200321175612.GC19579@SDF.ORG>
 <nycvar.QRO.7.76.6.2003252008490.46@tvgsbejvaqbjf.bet>
 <20200326001821.GB8865@SDF.ORG>
 <nycvar.QRO.7.76.6.2003281510260.46@tvgsbejvaqbjf.bet>
 <20200328163024.GA26885@SDF.ORG>
 <nycvar.QRO.7.76.6.2004041417420.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2004041417420.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm just trying to make the point that guardrails on "git rebase
--nested" which don't exist on the more powerful and dangerous "git
rebase --edit-todo" are a case of installing a high-security lock on a
screen door.

If you can come up with something that works for both, then great. But 
going to significant trouble (especially in terms of design complexity and 
legacy burden; I'm not worrying about SMOP) for a special-case solution 
that only works for one is a waste of effort.

Both, or neither.  Just one is bad design.

Regarding the semantics, consider the following case:

* Initial branch history is O-A-B-C-D
* I initially "git rebase A"
* Then realize that I made a mistake and "git rebase --nested A^"
* I reverse the order of the commits to D-C-B-A
* The rebase continues, and I successfully pick D and C.
   (remaining commands are "pick B" and "pick A"
* Then I "git rebase --abort".

What state should I expect to be returned to?

(Without separately abortable nested rebases, the state after the nested
rebase is exactly the same as if I'd used "git rebase A^" in the first
place, which doesn't seem like a terribly bad thing.)

