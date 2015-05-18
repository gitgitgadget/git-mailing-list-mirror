From: Jeff King <peff@peff.net>
Subject: debugging git tests, was: Re: [PATCH v4 2/8] t5520: test no merge
 candidates cases
Date: Mon, 18 May 2015 14:55:54 -0400
Message-ID: <20150518185554.GB11463@peff.net>
References: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
 <1431955978-17890-3-git-send-email-pyokagan@gmail.com>
 <e89b333476cbb1e546371a07b357cd42@www.dscho.org>
 <xmqqoalhdbhx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 18 20:56:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuQCo-0007eI-B3
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 20:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522AbbERSz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 14:55:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:60317 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754502AbbERSz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 14:55:57 -0400
Received: (qmail 1641 invoked by uid 102); 18 May 2015 18:55:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 May 2015 13:55:56 -0500
Received: (qmail 26864 invoked by uid 107); 18 May 2015 18:55:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 May 2015 14:55:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 May 2015 14:55:54 -0400
Content-Disposition: inline
In-Reply-To: <xmqqoalhdbhx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269298>

On Mon, May 18, 2015 at 10:46:50AM -0700, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> >> +test_expect_success 'fail if wildcard spec does not match any refs' '
> >> +	git checkout -b test copy^ &&
> >> +	test_when_finished "git checkout -f copy && git branch -D test" &&
> >
> > When I read this line, I immediately asked myself whether the
> > branch would be deleted even if the test case failed. I then
> > tested this theory by editing the first test case ("setup") like
> > this:
> > ...
> > and indeed, the file "file" was gone, even if the test case
> > failed. I therefore believe that this "test_when_finished" cleanup
> > might make debugging substantially harder. Maybe we can drop these
> > lines from this patch?
> 
> The test framework is aware of the fact that it needs to help the
> people who are debugging the scripts.  The support is limited to the
> case in which you run it under the -i option, i.e.
> 
> 	$ cd t
>         $ sh ./t5520-pull.sh -i -v
> 
> will refrain from running test_when_finished scripts when the test
> piece fails.  Even though this is only limited to -i, I found it
> often sufficient for debugging.

If you don't use "-i", you are pretty much screwed anyway, because the
subsequent tests will stomp all over the state of the test directory.
Many a head-scratching session has been caused by looking at the wrong
state, and these days my go-to options for debugging a test are "-v -i".
But since we are talking about it in a related thread, I will advertise
the new "-x" here, too.  :)

As a side note, I've also considered better support for running the
debugger on git commands inside a test (right now, I usually stick a
"gdb --args" in the pipeline, but you have to remember to run with "-v",
and to redirect stdin appropriately). Do other people have this
annoyance, too?

I'm vaguely thinking of something like putting debug support into
bin-wrappers/git, but activating it only for certain tests (so you could
say "t5520-pull.sh --gdb=10", and git would start under the debugger
only for test 10). I think we'd also have to use gdbserver for I/O
sanity, and maybe provide short script to do:

   gdb -ex "target remote localhost:$some_port" "$TEST_DIRECTORY"/../git

That still doesn't cover all cases (when git spawns an external command,
you probably want to run the debugger on that; likewise, I have a
git-remote-debug hack for debugging remote-curl). I suspect with clever
use of gdb options that you could convince the original gdb invocation
to end up tracing the process you care about, though.

-Peff
