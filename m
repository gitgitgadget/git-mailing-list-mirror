Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BA181FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 20:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbdFSUUb (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 16:20:31 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:49653 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbdFSUUa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 16:20:30 -0400
Received: from [129.170.31.151] (helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1dN39u-00017c-Lx; Mon, 19 Jun 2017 16:20:27 -0400
Date:   Mon, 19 Jun 2017 16:20:21 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Prathamesh Chavan <pc44800@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <20170619202021.dmomy5ztwoeat3eg@hopa.kiewit.dartmouth.edu>
References: <20170619155924.7ra2vwvaelr2yj2v@hopa.kiewit.dartmouth.edu>
 <CAGZ79kZhj31eBYnboyxDLuFp1ceeqk8kj0nrnQaCmpRJCVFU4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZhj31eBYnboyxDLuFp1ceeqk8kj0nrnQaCmpRJCVFU4w@mail.gmail.com>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 129.170.31.151
X-SA-Exim-Rcpt-To: sbeller@google.com, pc44800@gmail.com, git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: in case you want a use-case with lots of submodules
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, 19 Jun 2017, Stefan Beller wrote:

> On Mon, Jun 19, 2017 at 8:59 AM, Yaroslav Halchenko <yoh@onerussian.com> wrote:
> > Hi All,

> > On a recent trip I've listened to the git minutes podcast episode and
> > got excited to hear  Stefan Beller (CCed just in case) describing
> > ongoing work on submodules mechanism.  I got excited, since e.g.
> > performance improvements would be of great benefit to us too.

> If you're mostly interested in performance improvements of the status
> quo (i.e. "make git-submodule fast"), then the work of Prathamesh
> Chavan (cc'd) might be more interesting to you than what I do.
> He is porting git-submodule (which is mostly a shell script nowadays)
> to C, such that we can save a lot of process invocations and can do
> processing within one process.

ah -- cool.  I would be eager to test it out, thanks!  would be
interesting to see if it positively affects our overall performance.
Pointers to that development would be welcome!

> > http://datasets.datalad.org ATM provides quite a sizeable (ATM 370
> > repositories, up to 4 levels deep) hierarchy of git/git-annex
> > repositories all tied together via git submodules mechanism.  And as the
> > collection grows, interactions with it become slower, so additional
> > options (such as --ignore-submodules=dirty  to status) become our
> > friends.

> I am not as much concerned about the 370 number than about the
> 4 layers of nesting. In my experience the nested submodule case
> is a little bit error prone and the bug reports are not as frequent as
> there are not as many users of nesting, yet(?)

well -- part of the story here is that we are forced to use/have full
blown .git/ directories (for git-annex symlinks to content files to
work) within submodules instead of .git file with a reference under
parent's .git/modules.   So we can 'slice' at any level and I
guess that is why may be avoiding some possibly issues due to nesting
and the "parent has all .git/modules" approach.

> In a neighboring thread on the mailing list we have a discussion
> on the usefulness of being on branches than in detached HEAD
> in the submodules.
> https://public-inbox.org/git/0092CDD27C5F9D418B0F3E9B5D05BE08010287DF@SBS2011.opfingen.plc2.de/

> This would not break non-ambiguously, rather it would add
> ease of use.

that is indeed a common caveat... I am not sure if any heuristic
approach would provide a 'bullet proof' solution.  I might even prefer a
hardcoded 'branch-name' to be listed/associated with each submodule
within .gitmodules.  In the datalad case, detached HEAD is common
whenever someone installs "outdated" (branch of which progressed
forward) submodule.  In this case we just check if the branch after "git
clone"  (but before git submodule update) includes the pointed by
Subproject commit, and if so -- we announce that it must be the branch
(so far it is always "master" branch anyways ;) )

> > So I thought to share this as a use-case happen you need more
> > motivation or just a real-case test-bed for your work.  And thank
> > you again for making Git even Greater.

> Thanks for the motivation. :)

the least I could do ;)

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
