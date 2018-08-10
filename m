Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 087851F404
	for <e@80x24.org>; Fri, 10 Aug 2018 18:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbeHJV10 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 17:27:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:50212 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726162AbeHJV1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 17:27:25 -0400
Received: (qmail 18889 invoked by uid 109); 10 Aug 2018 18:56:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Aug 2018 18:56:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22453 invoked by uid 111); 10 Aug 2018 18:56:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 10 Aug 2018 14:56:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2018 14:56:18 -0400
Date:   Fri, 10 Aug 2018 14:56:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] t5552: fix flakiness by introducing proper locking
 for GIT_TRACE
Message-ID: <20180810185618.GA9749@sigill.intra.peff.net>
References: <pull.17.git.gitgitgadget@gmail.com>
 <811ded48-6f33-c46e-7bae-b9f7c7e8764c@kdbg.org>
 <xmqqin4i83zg.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqin4i83zg.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 10, 2018 at 11:34:59AM -0700, Junio C Hamano wrote:

> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > As this buglet looks like a recurring theme, and a proper fix is
> > preferable over repeated work-arounds. To me it looks like we need
> > some sort of locking on Windows. Unless your friends at Microsoft have
> > an ace in their sleeves that lets us have atomic O_APPEND the POSIX
> > way...
> 
> Just to put the severity of the issue in context, we use O_APPEND in
> a few codepaths, and the trace thing for debugging is the only thing
> that could have multiple writers.  Other users of O_APPEND are:
> 
>  * refs/files-backend.c uses it so that a reflog entry can be
>    appended at the end, but because update to each ref is protected
>    from racing at a lot higher layer with a lock, no two people
>    would try to append to the same reflog file, so atomicity of
>    O_APPEND does not matter here.

Just an interesting side note, but I think one of the reasons we use
dot-locks and not flock() is that the former generally works on network
filesystems. I think O_APPEND also is not reliable for non-local files,
though, so short of actually dot-locking trace files (yuck) I don't
think there's a great solution there.

> It may make sense to allow GIT_TRACE to have a placeholder
> (e.g. "/tmp/traceout.$$") to help debuggers arrange to give
> different processes their own trace output file, which perhaps may
> be a simpler and less impactful to the performance solution than
> having to make locks at an application layer.

Heh, I actually wrote that patch several years ago, as part of an
abandoned effort to have config-triggered tracing (e.g., on the server
side where you're getting hundreds of requests and you want to enable
tracing on a repo for a slice of time).

One annoying thing for a case like the test in question is that you
don't actually know the pid of the process you're interested in. So we'd
generate two trace files, and then you'd have to figure out which one is
which. In my earlier work, I coupled it with some magic to allow
per-command config, like:

  [trace "fetch"]
  packet = /tmp/trace.%p

but you could also imagine a "%n" which uses the command name.

I don't remember why I abandoned it, but I think a lot had to do with
violating the "don't look at config" rules for our repo startup code. A
lot of that has been fixed since then, but I haven't really needed it.
If anybody is really interested, the patches are at:

  https://github.com/peff/git jk/trace-stdin

(my ultimate goal was to record stdin for pack-objects to replay slow
fetches, but I ended up hacking together a patch to pack-objects
instead).

-Peff
