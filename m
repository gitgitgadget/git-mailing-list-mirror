Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_NUMERIC_HELO,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9249E1FE4E
	for <e@80x24.org>; Thu, 30 Jun 2016 23:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667AbcF3XzC (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 19:55:02 -0400
Received: from plane.gmane.org ([80.91.229.3]:53333 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752661AbcF3XzB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 19:55:01 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bIlnM-0003Wr-Aq
	for git@vger.kernel.org; Fri, 01 Jul 2016 01:54:57 +0200
Received: from 65.222.173.206 ([65.222.173.206])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 01:54:56 +0200
Received: from peartben by 65.222.173.206 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 01:54:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH v13 11/20] index-helper: use watchman to avoid refreshing index with lstat()
Date:	Thu, 30 Jun 2016 23:54:50 +0000 (UTC)
Message-ID: <loom.20160701T013515-311@post.gmane.org>
References: <1466914464-10358-1-git-send-email-novalis@novalis.org> <1466914464-10358-11-git-send-email-novalis@novalis.org> <loom.20160630T192750-125@post.gmane.org> <CACsJy8DjYLQCBRc9CzFSWNqkVnhbAfnxd1mnQh4oEfJwKjPd1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 65.222.173.206 (Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Duy Nguyen <pclouds <at> gmail.com> writes:

> 
> On Thu, Jun 30, 2016 at 7:55 PM, Ben Peart <peartben <at> gmail.com> wrote:
> > David Turner <novalis <at> novalis.org> writes:
> >
> >>
> >> Hiding watchman behind index-helper means you need both daemons. You
> >> can't run watchman alone. Not so good. But on the other hand, 'git'
> >> binary is not linked to watchman/json libraries, which is good for
> >> packaging. Core git package will run fine without watchman-related
> >> packages. If they need watchman, they can install git-index-helper and
> >> dependencies.
> >>
> >
> > Have you considered splitting index-helper and watchman apart?  Using
> > Watchman to not lstat unchanged entries is a huge perf win with very
> > large repos.
> 
> On large repos (i.e. lots of files/dirs on worktree), the cost of
> reading index will increase proportionally. Yes lstat costs, but I
> suspect index reading (integrity verification actually) may cost more,
> especially on platforms with cheap lstat like linux. On these repos
> you really want to enable all four: index-helper (with watchman),
> split-index (I still need to work out pruning on split-index) and
> untracked cache. There's still a lot more to make git run fast on
> large repos though.
> 

I've found (at least on Windows) that as the repo size gets larger, the
time to read the index becomes a much smaller percentage of the overall
time.  I just captured some perf traces of git status on a large repo we
have.  Of that, 92.5% was spent in git!read_directory and only 4.0% was 
spent in git!read_index.  Of that 4%, 2.6% was git!glk_SHA1_Update.

Given there were no dirty files, Watchman would have made a huge 
improvement in the overall time but index helper would have had
relatively little impact.  We've noticed this same pattern in all our
repos which is what is driving our interest in the Watchman model and
also shows why index-helper is of less interest.

> > It would also be interesting to make the Watchman backend replaceable by
> > using an extensible API.  This has the benefit of not having to link the
> > 'git' binary to the watchman/json libraries.
> 
> 'git' binary is not linked to watchman libraries. git-index-helper is
> a separate binary, by design. In theory you can create a
> 'git-index-helper' replacement binary with something other than
> watchman. I think David documented the protocol well (it may change in
> the future though and we are not prepared for capability progression)
> 
> > Is there any pattern already in git for accomplishing this?

While the current design hides watchman behind index-helper, if we were
to change that model so they were independent, we would be interested
in doing it in such a way that provided some abstraction so that it 
could be replaced with another file watching daemon.

