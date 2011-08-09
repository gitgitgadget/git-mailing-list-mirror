From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] test: cope better with use of return for errors
Date: Tue, 9 Aug 2011 09:36:39 -0600
Message-ID: <20110809153638.GA15687@sigill.intra.peff.net>
References: <20110321105628.GC16334@sigill.intra.peff.net>
 <cover.1300872923.git.git@drmicha.warpmail.net>
 <20110324082108.GA30196@elie>
 <20110808011341.GA19551@elie.gateway.2wire.net>
 <20110808011709.GC19551@elie.gateway.2wire.net>
 <4E40F3EA.8020406@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Aug 09 17:36:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqoMO-0000bU-C7
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 17:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464Ab1HIPgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Aug 2011 11:36:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59459
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006Ab1HIPgp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2011 11:36:45 -0400
Received: (qmail 6062 invoked by uid 107); 9 Aug 2011 15:37:20 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Aug 2011 11:37:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Aug 2011 09:36:39 -0600
Content-Disposition: inline
In-Reply-To: <4E40F3EA.8020406@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179033>

On Tue, Aug 09, 2011 at 10:46:34AM +0200, Johannes Sixt wrote:

> Am 8/8/2011 3:17, schrieb Jonathan Nieder:
> > +test_eval_ () {
> > +	# This is a separate function because some tests use
> > +	# "return" to end a test_expect_success block early.
> > +	eval >&3 2>&4 "$*"
> > +}
> > +
> >  test_run_ () {
> >  	test_cleanup=:
> >  	expecting_failure=$2
> > -	eval >&3 2>&4 "$1"
> > +	test_eval_ "$1"
> >  	eval_ret=$?
> >  
> >  	if test -z "$immediate" || test $eval_ret = 0 || test -n "$expecting_failure"
> >  	then
> > -		eval >&3 2>&4 "$test_cleanup"
> > +		test_eval_ "$test_cleanup"
> >  	fi
> >  	if test "$verbose" = "t" && test -n "$HARNESS_ACTIVE"; then
> >  		echo ""
> 
> This invalidates at least t3900.29, which accesses an unexpanded $3
> from the test script. The patch below fixes this case.

Hmm. Isn't t3900 already broken, even without this patch? It does
something like this:

  foo() {
    test_expect_success 'bar' 'echo $3'
  }

That can't possibly access the third positional parameter of foo, as we
are already inside the test_expect_success function, no matter what
functions we call after that.

If there is any regression here, it would be that we used to get the
positional parameters of test_run_, and now we get them from test_eval_.
So accessing "$2" used to get us $expecting_failure, but now gets
nothing. I doubt it matters, and tests would be insane to rely on
something internal like that. If it did, the right fix would be:

  -       test_eval_ "$1"
  +       test_eval_ "$@"

in test_run_.

So I don't see a problem in Jonathan's patches. But clearly t3900 is
poorly written and should be fixed.

But:

> diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
> index c06a5ee..3265fac 100755
> --- a/t/t3900-i18n-commit.sh
> +++ b/t/t3900-i18n-commit.sh
> @@ -136,6 +136,7 @@ done
>  test_commit_autosquash_flags () {
>  	H=$1
>  	flag=$2
> +	mopt=$3
>  	test_expect_success "commit --$flag with $H encoding" '
>  		git config i18n.commitencoding $H &&
>  		git checkout -b $H-$flag C0 &&
> @@ -147,7 +148,7 @@ test_commit_autosquash_flags () {
>  		git commit -a -m "intermediate commit" &&
>  		test_tick &&
>  		echo $H $flag >>F &&
> -		git commit -a --$flag HEAD~1 $3 &&
> +		git commit -a --$flag HEAD~1 $mopt &&
>  		E=$(git cat-file commit '$H-$flag' |
>  			sed -ne "s/^encoding //p") &&
>  		test "z$E" = "z$H" &&
> @@ -160,6 +161,6 @@ test_commit_autosquash_flags () {
>  
>  test_commit_autosquash_flags eucJP fixup
>  
> -test_commit_autosquash_flags ISO-2022-JP squash '-m "squash message"'
> +test_commit_autosquash_flags ISO-2022-JP squash '-m squash_message'

Can't we just drop $3 here? I don't see how it's actually doing
anything. It makes us call:

  git commit --squash HEAD~1 -m squash_message

instead of just:

  git commit --squash HEAD~1

but then we never actually check to see that the included message
becomes part of the squashed commit, anyway.

Also, a side note. These tests put their shell snippet inside single
quotes. And then access the variables sometimes directly (assuming they
are left unchanged inside the test functions), and sometimes using
single quotes. Which actually places them outside the snippet's single
quotes, and expands them in place. Which happens to be OK because they
don't contain any spaces, but would otherwise pass extra arguments to
test_expect_success.

So it's not a bug, but it does look unintentional and poor style.

Anyway. Your patch is fine and sufficient to solve the problem. Those
were all just thoughtst I had while trying to figure out what the test
was actually trying to do.

-Peff
