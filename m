Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2FAB20899
	for <e@80x24.org>; Thu, 27 Jul 2017 18:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751606AbdG0S25 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 14:28:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:50840 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751595AbdG0S25 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 14:28:57 -0400
Received: (qmail 14070 invoked by uid 109); 27 Jul 2017 18:28:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Jul 2017 18:28:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3729 invoked by uid 111); 27 Jul 2017 18:29:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Jul 2017 14:29:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Jul 2017 14:28:54 -0400
Date:   Thu, 27 Jul 2017 14:28:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] packed_ref_store: handle a packed-refs file that is a
 symlink
Message-ID: <20170727182854.wxjvjs2x746n3x2t@sigill.intra.peff.net>
References: <20170720232040.GA159617@aiede.mtv.corp.google.com>
 <d0da02a8b6f0272fa70ae3b1dc80fee6c6ee8d18.1501111803.git.mhagger@alum.mit.edu>
 <xmqq8tj9okzv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8tj9okzv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 27, 2017 at 10:19:48AM -0700, Junio C Hamano wrote:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
> > Change `commit_packed_refs()` to use `get_locked_file_path()` to find
> > the path of the file that it should overwrite. Since that path was
> > properly resolved when the lockfile was created, this restores the
> > pre-42dfa7ecef behavior.
> 
> Because when we take a lock hold_lock_file() eventually calls into
> lock_file() which by default takes the lock on the target of the
> symbolic link (which is the sensible default, which is triggered in
> this codepath), so this change to use the name of that file is all
> that is needed.
> 
> Makes sense.  Makes me wonder why we need a separate .new file
> (instead of writing into the .lock instead), but that is a different
> issue.

It comes from 42dfa7ece (commit_packed_refs(): use a staging file
separate from the lockfile, 2017-06-23). That commit explains that we
want to be able to put the new contents into service before we release
the lock. But it doesn't say why that's useful.

I recall from past discussions that this will help close some races,
and e5cc7d7d2 (repack_without_refs(): don't lock or unlock the packed
refs, 2017-07-01) alludes to this. I think the races in question have to
do with holding the packed-refs lock while pruning the just-packed
files, but I'm having trouble digging up specifics in the archive.

-Peff
