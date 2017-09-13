Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69DEE20A21
	for <e@80x24.org>; Wed, 13 Sep 2017 14:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751121AbdIMORm (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 10:17:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:36794 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750999AbdIMORm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 10:17:42 -0400
Received: (qmail 11429 invoked by uid 109); 13 Sep 2017 14:17:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 14:17:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14635 invoked by uid 111); 13 Sep 2017 14:18:16 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 10:18:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2017 10:17:40 -0400
Date:   Wed, 13 Sep 2017 10:17:40 -0400
From:   Jeff King <peff@peff.net>
To:     demerphq <demerphq@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Bug: git branch --unset-upstream command can nuke config when
 disk is full.
Message-ID: <20170913141739.mkmiaud2eemgnbbh@sigill.intra.peff.net>
References: <CANgJU+Wj_sN8Px6rweHMw_iAX8UA3mW9x4NVCctpUCs8_3ytLw@mail.gmail.com>
 <20170913123420.die3thfcpaweakce@sigill.intra.peff.net>
 <CANgJU+U3Vzmmag9fpFGf7sx4Sq4S9qjLc5bnR4e+U0C3aaQXJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANgJU+U3Vzmmag9fpFGf7sx4Sq4S9qjLc5bnR4e+U0C3aaQXJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2017 at 03:38:52PM +0200, demerphq wrote:

> I just double checked the terminal history and this is all i saw:
> 
> $ git status
> On branch yves/xxx
> Your branch is based on 'origin/yves/xxx', but the upstream is gone.
>   (use "git branch --unset-upstream" to fixup)
> 
> nothing to commit, working tree clean
> $ git branch --unset-upstream
> fatal: could not unset 'branch.yves/xxx.merge'
> $ git status
> On branch yves/xxx
> nothing to commit, working tree clean
> $ git fetch
> fatal: No remote repository specified.  Please, specify either a URL or a
> remote name from which new revisions should be fetched.

As a side note, I'm surprised that commands work at all when your
.git/config is empty. I'd expect check_respository_format() to complain
that you are not in a repository.  Looks like it is due to this block:

  452		 /*
  453		  * For historical use of check_repository_format() in git-init,
  454		  * we treat a missing config as a silent "ok", even when nongit_ok
  455		  * is unset.
  456		  */
  457		if (candidate.version < 0)
  458			return 0;

> > No, it writes the new content to "config.lock" and then renames it into
> > place.
> > All of the write() calls to the temporary file are checked.
> 
> I was going to say that perhaps the write was not checked... But if
> you are confident they are then...

You're welcome to read over the function to double-check, but I just
looked it over and couldn't find any unchecked writes.

> > Given that your output is consistent with it failing to find the key,
> > and that the result is an empty file, it sounds like somehow the mmap'd
> > input appeared empty (but neither open nor fstat nor mmap returned an
> > error). You're not on any kind of exotic filesystem, are you?
> 
> I don't think so, but I don't know. Is there a command I can run to check?
> 
> BTW, with a bit of faffing I can probably recreate this problem.
> Should I try? Is there something I could do during recreation that
> would help?

If you think you can reproduce, the output of "strace" on a failing
invocation would be very interesting.

-Peff
