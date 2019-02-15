Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B39701F453
	for <e@80x24.org>; Fri, 15 Feb 2019 18:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390781AbfBOS6A convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 15 Feb 2019 13:58:00 -0500
Received: from elephants.elehost.com ([216.66.27.132]:62078 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387768AbfBOS6A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 13:58:00 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1FIvpWw008434
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 13:57:51 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        "'Max Kirillov'" <max@max630.net>
Subject: More on t5562 Hang (was RE: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results))
Date:   Fri, 15 Feb 2019 13:57:46 -0500
Message-ID: <002201d4c560$5a319c40$0e94d4c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdTFYFAge+c/+fGPSmGP3qGqipcgOg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 15, 2019 8:50, I wrote:
> On February 15, 2019 8:02, SZEDER Gábor wrote:
> > To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Cc: Randall S. Becker <rsbecker@nexbridge.com>; 'Junio C Hamano'
> > <gitster@pobox.com>; git@vger.kernel.org; 'Max Kirillov'
> > <max@max630.net>
> > Subject: Re: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results)
> >
> > On Thu, Feb 14, 2019 at 10:36:42PM +0100, Johannes Schindelin wrote:
> > > On Thu, 14 Feb 2019, Randall S. Becker wrote:
> > >
> > > > t5562 still hangs (blocking) - this breaks our CI pipeline since
> > > > the test hangs and we have no explanation of whether the hang is
> > > > in git or the tests.
> > >
> > > I have "good" news: it now also hangs on Ubuntu 16.04 in Azure
> Pipelines'
> > > Linux agents.
> >
> > I haven't yet seen that hang in the wild and couldn't reproduce it on
> > purpose, but there is definitely something fishy with t5562 even on
> > Linux and even without that perl generate_zero_bytes helper.
> >
> >   $ git checkout cc95bc2025^
> >   Previous HEAD position was cc95bc2025 t5562: replace /dev/zero with
> > a pipe from generate_zero_bytes
> >   HEAD is now at 24b451e77c t5318: replace use of /dev/zero with
> > generate_zero_bytes
> >   $ make
> >   <snip>
> >   $ cd t
> >   # take note of the shell's PID
> >   $ echo $$
> >   15522
> >   $ ./t5562-http-backend-content-length.sh --stress |tee LOG
> >   OK    3.0
> >   OK    1.0
> >   OK    6.0
> >   OK    0.0
> >   <snap>
> >
> > And then in another terminal run this:
> >
> >   $ pstree -a -p 15522
> >
> > or, to make it easier noticable what changed and what stayed the same:
> >
> >   $ watch -d pstree -a -p 15522
> >
> > The output will sooner or later will look like this:
> >
> >   bash,15522
> >     └─t5562-http-back,21082 ./t5562-http-backend-content-length.sh --
> stress
> >         ├─t5562-http-back,21089 ./t5562-http-backend-content-length.sh
> > -- stress
> >         │   └─sh,24906 ./t5562-http-backend-content-length.sh --stress
> >         ├─t5562-http-back,21090 ./t5562-http-backend-content-length.sh
> > -- stress
> >         │   └─sh,26660 ./t5562-http-backend-content-length.sh --stress
> >         ├─t5562-http-back,21092 ./t5562-http-backend-content-length.sh
> > -- stress
> >         │   └─sh,4202 ./t5562-http-backend-content-length.sh --stress
> >         │       └─sh,5696 ./t5562-http-backend-content-length.sh --stress
> >         │           └─perl,5697 /home/szeder/src/git/t/t5562/invoke-with-
> content-
> > length.pl push_body.gz.trunc git http-backend
> >         │               └─(git,5722)
> >         ├─t5562-http-back,21093 ./t5562-http-backend-content-length.sh
> > -- stress
> >         │   └─sh,25572 ./t5562-http-backend-content-length.sh --stress
> >   <snip>
> >
> > It won't show most of the processes run in the tests, because they are
> > just too fast and short-lived.  However, occasionally it does show a
> > stuck git process, which is shown as <defunct> in regular 'ps aux'
> > output:
> >
> >   szeder   5722  0.0  0.0      0     0 pts/16   Z+   13:36   0:00 [git] <defunct>
> >
> > Note that this is not a "proper" hang, in the sense that this process
> > is not stuck forever, but only for about 1 minute, after which it
> > disappears, and the test continues and eventually finishes with
> > success.  I've looked into the logs of a couple of such stuck jobs,
> > and it seems that it varies in which test that git process happened to get
> stuck.
> 
> We see something similar. The 60 seconds is in the support script in the
> t/t5562 directory. If a SIGCHLD is received, the sleep is interrupted and perl
> terminates (no hang). If the sleep is not interrupted, NonStop hangs in the
> close() after coming out of sleep because perl still has output to send
> somewhere. We are hung in the close call - which is really perplexing
> considering a close on NonStop in any other product is immediate and rather
> harsh, but perl's semantics for close() are: "Closing a pipe also waits for the
> process executing on the pipe to complete" (from the Perl spec), which
> seems to apply on NonStop because the git (5722) is reading but not
> receiving any data and not terminating - based on your tree above. Or, in
> other words, perl closing the pipe will not cause git (5722) to terminate
> because perl is waiting on git (5722) to terminate before completing the
> close. The only time it would not hang is if git (5722) terminates on its own
> so that sleep is interrupted without going back for more data to read. I am
> making a semi-educated guess. From my experience with the NS perl team,
> they are going to point at that spec and say that perl is exhibiting the correct
> behaviour and that the hang is expected.
> 
> Another weird observation is that the test generates up to three hangs
> (subtests 6,8,13) at worst, and one (subtest 13) at best, depending on some
> unknown factor that might be system load. This is hinting at a race condition.
> Sadly, we don't have the above cool watch or pstree utilities on platform.
> What we do have is something called ptrace, which can look at the stack and
> I/O conditions of all open files and whether there are outstanding I/Os (and
> how many) on each FD, memory use.

More weirdness. If GIT_TRACE=true prior to running t5562, out of four test runs, three runs worked without hanging or even sleeping for any noticeable time. One run hung on subtest 14, which is new. Are we missing a flush somewhere? On NonStop, buffering is the default. 

Successful run (subtests 13,14):

expecting success:
        test_env HTTP_CONTENT_ENCODING="gzip" test_http_env receive push_body.gz.trunc &&
        ! verify_http_result "200 OK"

trace: exec: git-http-backend
trace: run_command: git-http-backend
trace: run_command: git receive-pack --stateless-rpc .
trace: built-in: git receive-pack --stateless-rpc .
fatal: request ended in the middle of the gzip stream
ok 13 - push gzipped truncated

expecting success:
        test_env HTTP_CONTENT_ENCODING="gzip" test_http_env receive empty_body &&
        ! verify_http_result "200 OK"

trace: exec: git-http-backend
trace: run_command: git-http-backend
trace: run_command: git receive-pack --stateless-rpc .
fatal: request ended in the middle of the gzip stream
ok 14 - push gzipped empty

But the one that hung... The fatal was never reported.

expecting success:
        test_env HTTP_CONTENT_ENCODING="gzip" test_http_env receive empty_body &&
        ! verify_http_result "200 OK"

trace: exec: git-http-backend
trace: run_command: git-http-backend
trace: run_command: git receive-pack --stateless-rpc .
trace: built-in: git receive-pack --stateless-rpc .
<< Control-C used here>

