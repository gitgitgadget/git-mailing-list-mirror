Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB0BB20960
	for <e@80x24.org>; Tue, 11 Apr 2017 00:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbdDKAxu (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 20:53:50 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36672 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750761AbdDKAxt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 20:53:49 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 7438120960;
        Tue, 11 Apr 2017 00:53:48 +0000 (UTC)
Date:   Tue, 11 Apr 2017 00:53:48 +0000
From:   Eric Wong <e@80x24.org>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 5/5] run-command: add note about forking and threading
Message-ID: <20170411005348.GA30913@starla>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170410234919.34586-6-bmwill@google.com>
 <20170411002606.GJ8741@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170411002606.GJ8741@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
> 
> Brandon Williams wrote:
> 
> > --- a/run-command.c
> > +++ b/run-command.c
> > @@ -458,6 +458,14 @@ int start_command(struct child_process *cmd)
> >  		argv_array_pushv(&argv, cmd->argv);
> >  	}
> >  
> > +	/*
> > +	 * NOTE: In order to prevent deadlocking when using threads special
> > +	 * care should be taken with the function calls made in between the
> > +	 * fork() and exec() calls.  No calls should be made to functions which
> > +	 * require acquiring a lock (e.g. malloc) as the lock could have been
> > +	 * held by another thread at the time of forking, causing the lock to
> > +	 * never be released in the child process.
> > +	 */
> >  	cmd->pid = fork();
> 
> Why can't git use e.g. posix_spawn to avoid this?

posix_spawn does not support chdir, and it seems we run non-git
commands so no using "git -C" for those.

> fork()-ing in a threaded context is very painful for maintainability.
> Any library function you are using could start taking a lock, and then
> you have a deadlock.  So you have to make use of a very small
> whitelisted list of library functions for this to work.

Completely agreed.

On the other hand, I believe we should make run-command
vfork-compatible (and Brandon's series is a big (but incomplete)
step in the (IMHO) right direction); as anything which is
vfork-safe would also be safe in the presence of threads+(plain) fork.
With vfork; the two processes share heap until execve.

I posted some notes about it last year:

  https://public-inbox.org/git/20160629200142.GA17878@dcvr.yhbt.net/

> The function calls you have to audit are not only between fork() and
> exec() in the normal control flow.  You have to worry about signal
> handlers, too.

Yes, all that auditing is necessary for vfork; too, but totally
doable.  The mainline Ruby implementation has been using vfork
for spawning subprocesses for several years, now; and I think the
ruby-core developers (myself included) have fixed all the
problems with it; even in multi-threaded code which calls malloc.
