Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE92320756
	for <e@80x24.org>; Fri,  6 Jan 2017 07:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162522AbdAFH0S (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 02:26:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:35866 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753609AbdAFH0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 02:26:16 -0500
Received: (qmail 25471 invoked by uid 109); 6 Jan 2017 07:26:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Jan 2017 07:26:04 +0000
Received: (qmail 15142 invoked by uid 111); 6 Jan 2017 07:26:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Jan 2017 02:26:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jan 2017 02:26:02 -0500
Date:   Fri, 6 Jan 2017 02:26:02 -0500
From:   Jeff King <peff@peff.net>
To:     Trygve Aaberge <trygveaa@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: Regression: Ctrl-c from the pager in an alias exits it
Message-ID: <20170106072602.wkbzho5z3osz5hee@sigill.intra.peff.net>
References: <20170105142529.GA15009@aaberge.net>
 <20170106064032.eqxxer5mx5hsh2md@sigill.intra.peff.net>
 <20170106064752.iccrk656c6k2wrfy@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170106064752.iccrk656c6k2wrfy@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 06, 2017 at 01:47:52AM -0500, Jeff King wrote:

> > > To reproduce, create e.g. the alias `l = log` and run `git l`. Then press
> > > Ctrl-c. The expected behavior is that nothing happens. The actual behavior is
> > > that the pager exits.
> > 
> > That's weird. I can't reproduce at all here. But I also can't think of a
> > thing that Git could do that would impact the behavior. For example:
> 
> I take it back. I could not reproduce under my normal config, which sets
> the pager to "diff-highlight | less". But if I drop that config, I can
> reproduce easily. And bisect it to that same commit, 86d26f240f
> (setup.c: re-fix d95138e (setup: set env $GIT_WORK_TREE when ..,
> 2015-12-20).

I made a little progress with strace. Prior to 86d26f240f, we would run
the "log" builtin directly inside the same executable. After it, we exec
a separate process, and the process tree looks like:

  |       `-bash,10123
  |           `-git,10125 l
  |               `-git-log,10127
  |                   `-less,10128

Now if I strace all of those, I see (I've reordered and snipped a bit
for clarity):

  $ strace -p 10125 -p 10127 -p 10128
  strace: Process 10125 attached
  strace: Process 10127 attached
  strace: Process 10128 attached
  [pid 10127] write(1, "\n\33[33mcommit bae73e80d48ace1faa3"..., 1481 <unfinished ...>
  [pid 10128] read(5,  <unfinished ...>
  [pid 10125] wait4(10127,  <unfinished ...>

The main git process is waiting for the child to finish, the child is
blocked writing to the pager, and the pager is waiting for input from
the terminal (fd 5).

So I hit ^C:

  [pid 10128] <... read resumed> 0x7ffd39153b57, 1) = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
  [pid 10127] <... write resumed> )       = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
  [pid 10125] <... wait4 resumed> 0x7ffe88d0a560, 0, NULL) = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
  [pid 10128] --- SIGINT {si_signo=SIGINT, si_code=SI_KERNEL} ---
  [pid 10127] --- SIGINT {si_signo=SIGINT, si_code=SI_KERNEL} ---
  [pid 10125] --- SIGINT {si_signo=SIGINT, si_code=SI_KERNEL} ---

Everybody gets the signal...

  [pid 10127] write(1, "\n\33[33mcommit bae73e80d48ace1faa3"..., 1481 <unfinished ...>

The blocked writer will resume its write() until it returns. This is the
same as it would get under the older code, too (after write() returns it
will handle the signal and die).

  [pid 10125] kill(10127, SIGINT <unfinished ...>
  [pid 10125] <... kill resumed> )        = 0

The parent git process tries to propagate the signal to the child.
Unnecessary in this instance, but helpful when the signal is only
delivered to the parent. This is due to 

  [pid 10128] rt_sigaction(SIGINT, {sa_handler=0x558dd1af0300, sa_mask=[INT], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7f03fc8c2040},  <unfinished ...>
  [pid 10128] <... rt_sigaction resumed> {sa_handler=0x558dd1af0300, sa_mask=[INT], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7f03fc8c2040}, 8) = 0
  [pid 10128] rt_sigprocmask(SIG_SETMASK, [],  <unfinished ...>
  [pid 10128] <... rt_sigprocmask resumed> NULL, 8) = 0
  [pid 10128] write(1, "\7\r\33[K:\33[K", 9 <unfinished ...>
  [pid 10128] <... write resumed> )       = 9
  [pid 10128] read(5,  <unfinished ...>

And here's the pager handling the signal, and going back to waiting for
terminal input.

  [pid 10125] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[INT], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7fbe2b4c1040},  <unfinished ...>
  [pid 10125] <... rt_sigaction resumed> {sa_handler=0x55aec373a6a0, sa_mask=[INT], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7fbe2b4c1040}, 8) = 0
  [pid 10125] rt_sigprocmask(SIG_BLOCK, ~[RTMIN RT_1], [INT], 8) = 0
  [pid 10125] getpid( <unfinished ...>
  [pid 10125] <... getpid resumed> )      = 10125
  [pid 10125] gettid()                    = 10125
  [pid 10125] tgkill(10125, 10125, SIGINT) = 0
  [pid 10125] rt_sigprocmask(SIG_SETMASK, [INT], NULL, 8) = 0
  [pid 10125] rt_sigreturn({mask=[]})     = 61
  [pid 10125] --- SIGINT {si_signo=SIGINT, si_code=SI_TKILL, si_pid=10125, si_uid=1000} ---
  [pid 10125] +++ killed by SIGINT +++

The parent process pops the signal handler and propagates to itself,
dying.

At this point things pause, and nothing happens. But as soon as I hit a
key, the pager dies:

  [pid 10128] <... read resumed> "\r", 1) = 1
  [pid 10128] write(1, "\r\33[K", 4)      = 4
  [pid 10128] write(1, "     \"Another round of MIPS fixe"..., 50) = 50
  [pid 10128] read(5, 0x7ffd39153b57, 1)  = -1 EIO (Input/output error)
  [pid 10128] write(1, "\r\33[K\33[?1l\33>", 11) = 11
  [pid 10128] fsync(5)                    = -1 EINVAL (Invalid argument)
  [pid 10128] ioctl(5, TCGETS, {B38400 opost isig -icanon -echo ...}) = 0
  [pid 10128] ioctl(5, SNDCTL_TMR_STOP or TCSETSW, {B38400 opost isig icanon echo ...}) = -1 EIO (Input/output error)
  [pid 10128] exit_group(1)               = ?
  [pid 10128] +++ exited with 1 +++

The key thing is the EIO we get reading from the terminal. I think
because the head of the process group died, we lost our controlling
terminal.

And then naturally the git-log process gets SIGPIPE and dies:

  <... write resumed> )                   = -1 EPIPE (Broken pipe)
  --- SIGPIPE {si_signo=SIGPIPE, si_code=SI_USER, si_pid=10127, si_uid=1000} ---
  --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=10128, si_uid=1000, si_status=1, si_utime=0, si_stime=0} ---
  write(1, "\n\33[33mcommit bae73e80d48ace1faa3"..., 1481) = -1 EPIPE (Broken pipe)
  close(1)                                = 0
  close(2)                                = 0
  wait4(10128, [{WIFEXITED(s) && WEXITSTATUS(s) == 1}], 0, NULL) = 10128
  rt_sigaction(SIGPIPE, {sa_handler=SIG_DFL, sa_mask=[PIPE], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7fa2d51e2040}, {sa_handler=0x564583689d30, sa_mask=[PIPE], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7fa2d51e2040}, 8) = 0
  rt_sigprocmask(SIG_BLOCK, ~[RTMIN RT_1], [INT PIPE], 8) = 0
  getpid()                                = 10127
  gettid()                                = 10127
  tgkill(10127, 10127, SIGPIPE)           = 0
  rt_sigprocmask(SIG_SETMASK, [INT PIPE], NULL, 8) = 0
  rt_sigreturn({mask=[INT]})              = -1 EPIPE (Broken pipe)
  --- SIGPIPE {si_signo=SIGPIPE, si_code=SI_USER, si_pid=10127, si_uid=1000} ---
  +++ killed by SIGPIPE +++

You'll notice that it actually calls wait() on the pager. That's due to
a3da882120 (pager: do wait_for_pager on signal death, 2009-01-22), which
IIRC was addressing a very similar problem. We want to stop feeding the
pager when we get a signal, but we don't want the main process to
actually exit, or the pager loses the controlling terminal.

In our new scenario we have an extra process, though. The git-log child
will wait on the pager, but the parent process can't. It doesn't know
about it. I think that it in turn needs to wait on the child when it
dies, and then the whole chain will stand still until the pager exits.

-Peff
