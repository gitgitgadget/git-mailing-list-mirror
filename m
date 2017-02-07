Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E4FC1FAFC
	for <e@80x24.org>; Tue,  7 Feb 2017 00:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbdBGA1I (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 19:27:08 -0500
Received: from havoc.proulx.com ([96.88.95.61]:42948 "EHLO havoc.proulx.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751164AbdBGA1H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 19:27:07 -0500
Received: from joseki.proulx.com (localhost [127.0.0.1])
        by havoc.proulx.com (Postfix) with ESMTP id 7BA6272F
        for <git@vger.kernel.org>; Mon,  6 Feb 2017 17:27:06 -0700 (MST)
Received: from hysteria.proulx.com (hysteria.proulx.com [192.168.230.119])
        by joseki.proulx.com (Postfix) with ESMTP id 4560321243
        for <git@vger.kernel.org>; Mon,  6 Feb 2017 17:27:06 -0700 (MST)
Received: by hysteria.proulx.com (Postfix, from userid 1000)
        id 224722DC5F; Mon,  6 Feb 2017 17:27:06 -0700 (MST)
Date:   Mon, 6 Feb 2017 17:27:05 -0700
From:   Bob Proulx <bob@proulx.com>
To:     git@vger.kernel.org
Subject: Re: git-daemon shallow checkout fail
Message-ID: <20170206170428232901985@bob.proulx.com>
Mail-Followup-To: git@vger.kernel.org
References: <20170129002932.GA19359@dismay.proulx.com>
 <alpine.DEB.2.20.1701301719590.3469@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1701301719590.3469@virtualbox>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

Thank you very much for the good hints here.  They are very helpful.

Johannes Schindelin wrote:
> Assuming that you can rebuild your Git with debug symbols and without
> optimization (simply remove the -O2 from CFLAGS in the Makefile, I never
> had any luck with single-stepping in gdb when compiled with -O2), you

I always debug with -g and without -O because otherwise it leads to a
lot of confusion.  But git-daemon is a forking daemon which makes
debugging it with the debugger somewhere more default and requiring
more setup to debug past the fork points.  As you note and hint with
later setting up an attach point for gdb.

> - that error message comes from shallow.c's setup_temporary_shallow()
>   function

Yes.  I find that too.

> - that function is only called from fetch-pack and receive-pack, neither
>   of which should be called by upload-pack, so it is a puzzle

The choice of directionality for upload and download might be
confusing me here too.  Since from the client side of things it is a
download.  But on the server side it is an upload.

> - adding a test case to t5570-git-daemon.sh that tests specifically your
>   described scenario seems *not* to fail:

I have seen some of the patches that seems like should have fixed this
problem.  It is perplexing.  But see my next mail on this too.

> - I even modified t/lib-git-daemon.sh to start the daemon as `nobody` and
>   kill it as `root`, and I won't share that patch because it is as
>   ugly, but *even then* the test succeeded.

It succeeds for me on other systems.  It is only the one (where I need
it) that it is failing.

> So my suspicion is that the repository you try to serve may already be
> shallow, or something else funky is going on that has not been included in
> your report.

It happens to any repository.  I picked a small repository and copied
it verbatim using rsync to my working environment.  The identical bits
of a repository copied by rsync work okay on one system but fail on
the other.

> The most direct way to get to the bottom of this may be to do something
> like this:
...
>  	if (write_shallow_commits(&sb, 0, extra)) {
> +error("About to create shallow_XXXXXX: pid = %d", getpid());
> +while (!debug_me) {
> +	sleep(1);
> +}
>  		fd = xmks_tempfile(&temporary_shallow, git_path("shallow_XXXXXX"));
>  
>  		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
> -- snap --
> 
> Then let it run, wait for the error message "About to create
> shallow_XXXXXX" and then attach with a gdb started as nobody via `attach
> <pid>` to see the stack trace.
> 
> That should give you an idea where that code path is hit (unexpectedly).

That is a good hint.  I will give that a try.  However see my next
email for more (confusing) information.

Bob
