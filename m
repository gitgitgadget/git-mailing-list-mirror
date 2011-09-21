From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 1/5] git-p4 tests: refactor, split out common functions
Date: Tue, 20 Sep 2011 21:29:17 -0400
Message-ID: <20110921012917.GA27256@arf.padd.com>
References: <20110918012634.GA4578@arf.padd.com>
 <20110918012713.GA4619@arf.padd.com>
 <7v7h55cyis.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>, Chris Li <git@chrisli.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 03:29:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6Bcy-0002ET-Dn
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 03:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035Ab1IUB3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 21:29:24 -0400
Received: from honk.padd.com ([74.3.171.149]:33246 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835Ab1IUB3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 21:29:24 -0400
Received: from arf.padd.com (unknown [50.55.131.180])
	by honk.padd.com (Postfix) with ESMTPSA id A445ABFC;
	Tue, 20 Sep 2011 18:29:22 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id E09C931448; Tue, 20 Sep 2011 21:29:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v7h55cyis.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181809>

gitster@pobox.com wrote on Sun, 18 Sep 2011 14:48 -0700:
> Pete Wyckoff <pw@padd.com> writes:
> 
> > Introduce a library for functions that are common to
> > multiple git-p4 test files.
> >
> > Separate the tests related to detecting p4 branches
> > into their own file, and add a few more.
> >
> > Signed-off-by: Pete Wyckoff <pw@padd.com>
> > ---
> >  t/lib-git-p4.sh          |   55 ++++++++++++
> >  t/t9800-git-p4.sh        |  108 ++---------------------
> >  t/t9801-git-p4-branch.sh |  221 ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 283 insertions(+), 101 deletions(-)
> >  create mode 100644 t/lib-git-p4.sh
> >  create mode 100755 t/t9801-git-p4-branch.sh
> 
> I take that you meant "coding style" by "generic test beauty" in the cover
> letter, so here are some minor nitpicks.

Definitely appreciated.

> > diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> > new file mode 100644
> > index 0000000..dbc1499
> > --- /dev/null
> > +++ b/t/lib-git-p4.sh
> > @@ -0,0 +1,55 @@
> > +#
> > +# Library code for git-p4 tests
> > +#
> > +
> > +. ./test-lib.sh
> > +
> > +( p4 -h && p4d -h ) >/dev/null 2>&1 || {
> > +	skip_all='skipping git-p4 tests; no p4 or p4d'
> > +	test_done
> > +}
> > +
> > +GITP4=$GIT_BUILD_DIR/contrib/fast-import/git-p4
> > +P4DPORT=10669
> 
> What happens when tests are run in parallel (make -j or prove --jobs) and
> 9800 and 9801 are run at the same time?

Hard... part of the p4d pain below.

> > +export P4PORT=localhost:$P4DPORT
> > +export P4CLIENT=client
> > +
> > +db="$TRASH_DIRECTORY/db"
> > +cli="$TRASH_DIRECTORY/cli"
> > +git="$TRASH_DIRECTORY/git"
> > +
> > +start_p4d()
> > +{
> 
> Prevalent style in t/ and scripted part of Git in general is to begin a
> shell function like this, with SP on both sides of () and opening brace
> on the same line.

Thanks, fixed.

> 	start_p4d () {
> 
> > +	mkdir -p "$db" &&
> > +	p4d -q -d -r "$db" -p $P4DPORT &&
> > +	mkdir -p "$cli" &&
> > +	mkdir -p "$git" &&
> > +	cd "$cli" &&
> > +	p4 client -i <<-EOF
> > +	Client: client
> > +	Description: client
> > +	Root: $cli
> > +	View: //depot/... //client/...
> > +	EOF
> > +}
> > +
> > +kill_p4d()
> > +{
> > +	pid=`pgrep -f p4d` &&
> > +	test -n "$pid" &&
> 
> It is unfortunate that you have to use pgrep. I am unfamiliar with p4, but
> do you have any control how p4d is started during this test? If the first
> use of client automagically starts p4d without your control, that would be
> harder to arrange, but the point I am getting at is that if you know when
> you start p4d yourself and that is the only p4d process you use, you
> should be keep its pid in $TRASH_DIRECTORY somewhere and replace these
> with
> 
> 	pid=$(cat "$TRASH_DIRECTORY/p4d_pid") &&
>         kill -0 "$pid"
> 
> to see if that daemon is still alive. 
> 
> You call kill_p4d at the very beginning of t9800; what instance of p4d are
> you trying to kill? Who could have started it? For you to be able to kill
> (and nobody sane would be running the test suite as "root", I hope), it
> would be your process, but would it be possible that you are doing some
> other important thing using p4 that is not related to git-p4 development
> or testing at all, perhaps listening to a port different from 10669? Would
> it be necessary to kill that other p4d to run these tests in a predicatable
> and reproducible environment?
> 
> I would very much more prefer if at the very beginning you started p4d at
> the port assigned for the test and fail the test if it cannot start for
> whatever reason. Perhaps the reason you cannot start a p4d is because a
> stale p4d instance is hanging around from previous round of test, and if
> that is the case, then that is the bug we need to fix in the _previous_
> test, not something we want to sweep under the rug by killing it during
> this round of test.

Yes, this is all very shoddy, and I suspect that I don't need the
initial kill_p4d as long as the other tests fail nicely.

But your point about killing the _wrong_ p4d is good.  But p4d
isn't friendly like other daemons that will drop a pid file for
help in future cleanup.  I can run it without the "-d", in which
case it does not daemonize.  Then I should be able to use shell
job control to kill off the one I started, hopefully.

Finding an unused port is also a pain.  I'll see if p4d produces
parseable error messages that can indicate a taken port.
Otherwise, hardcoding a port per test is a good idea, and will
fix the parallel-run problem.  Hopefully no "production" p4d
also happens to be running at the same random port with this
approach.

> > +	for i in {1..5} ; do
> 
> That {1..5} does not pass POSIX shells, such as /bin/dash.
> 
> 	for i in 1 2 3 4 5
> 	do
> 		...

Ah.  Or `seq`, but not sure its existence can be counted on.
Fixed as you suggest for this teensy list.

> > +	    test_debug "ps wl `echo $pid`" &&
> > +	    kill $pid 2>/dev/null &&
> > +	    pgrep -f p4d >/dev/null || break &&
> 
> You are saying "all of these things would hold true if we attempt to kill
> it and it still is alive" with the chain of "&&" up to that last pgrep,
> and then with "||", you say "otherwise we do not have to keep sending the
> signal to it anymore". But the extra "&&" after "break" is unneeded and
> misleading.

Yes, that is icky.  I'll send this instead, next time (unless I
can fix the p4d issues):

	kill $pid 2>/dev/null &&
	if pgrep -f p4d >/dev/null ; then
	    break
	fi &&

> > +	    sleep 0.2
> 
> That 0.2 does not look like a non-negative decimal interger like POSIX
> wants to have.

Switched to 1.  Optimization of 0.2 isn't important.

> > +test_expect_success 'start p4d' '
> > +	kill_p4d || : &&
> > +	start_p4d &&
> > +	cd "$TRASH_DIRECTORY"
> >  '
> 
> Don't "chdir" around in the test, and worse yet hide some "cd" in helper
> functions. The seemingly unnecessary "cd $TRASH_DIRECTORY" at the end,
> which may not even happen if start_p4d fails, is because start_p4d has a
> hidden "cd" somewhere (which in turn may or may not run depending on where
> in the && chain you have a failure).
> 
> One way to keep the test cleaner is to do the helper functions like the
> following, so that the callers do not have to worry about where they end
> up with:
> 
> 	start_p4d () {
> 		mkdir -p "$db" "$cli" "$git" &&
>                 p4d -q -d -r "$db" -p "$P4DPORT" &&
> 		(
> 			cd "$cli" &&
> 			p4 client -i <<-EOF
> 			...
> 			EOF
> 		)
> 	}

I see; chdir in a subshell.  Will rework these to remove the
silly post-test cd, and put other cds inside shells.

> >  test_expect_success 'add p4 files' '
> >  	cd "$cli" &&
> >  	echo file1 >file1 &&
> >  	p4 add file1 &&
> >  	p4 submit -d "file1" &&
> >  ...
> >  	cd "$TRASH_DIRECTORY"
> >  '
> 
> The same issue here.
> 
> 	test_expect_success 'add p4 files' '
> 		(
> 			cd "$cli" &&
> 			echo file1 >file1 &&
> 			...
> 		)
> 	'

Thanks for the useful critique.  I'll think through the difficult
issues with p4d, and resubmit the whole series post-release.

		-- Pete
