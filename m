From: Jeff King <peff@peff.net>
Subject: Re: guarding everything with test_expect_success (Re: [PATCH 6/7]
 t1303 (config): style tweaks)
Date: Tue, 7 Sep 2010 01:56:37 -0400
Message-ID: <20100907055636.GA30357@sigill.intra.peff.net>
References: <4C85357A.8090000@web.de>
 <20100906190655.GG25426@burratino>
 <4C854B36.6010606@web.de>
 <20100907014135.GA1182@burratino>
 <20100907015317.GG1182@burratino>
 <20100907043050.GA13291@sigill.intra.peff.net>
 <20100907051218.GO1182@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 07:56:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsrAQ-00084z-Mc
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 07:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756099Ab0IGF4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 01:56:22 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:39803 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752844Ab0IGF4U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 01:56:20 -0400
Received: (qmail 3628 invoked by uid 111); 7 Sep 2010 05:56:19 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 07 Sep 2010 05:56:19 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Sep 2010 01:56:37 -0400
Content-Disposition: inline
In-Reply-To: <20100907051218.GO1182@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155681>

On Tue, Sep 07, 2010 at 12:12:18AM -0500, Jonathan Nieder wrote:

> As you mentioned, it is a big departure from the style of the existing
> tests.  So why push it?  A quick story:
> 
> 1. Long ago, when I first debugged a test script with -v, I was a bit
>    confused because the transcript did not tell the whole story
>    (because some commands are run outside test assertions).  No big
>    deal, but I remembered it.

Yeah, that can be frustrating. However, I have found (as I think you
have, from your point 4 below) that it is not just about seeing the
whole story with "-v", but rather about reaching some state in the test
script which may depend on prior tests. So yes, if everything were in
"-v", you could in theory cut and paste it all into a terminal. But
would you necessarily _want_ to, if it is test 25 in the script?

What I often end up doing is sticking "&& bash" into the test, running
the script, and exploring from that state. Perhaps we could have more
support for that. E.g., something like:

  $ ./t1303-wacky-config.sh --debug=2
  expecting success:
          setup &&
          git config section.key bar &&
          check section.key bar
  ok 1 - modify same key

  entering debug session for test 2; test text is:
        setup &&
        git config section2.key bar &&
        check section.key foo &&
        check section2.key bar

  $ [now try running commands]

The obvious problem is that you're actually in a subshell, not the same
shell. We would probably want to do some behind-the-scenes magic to
import variables and functions from the parent shell (unless you can
think of a clever way to suddenly turn the existing shell interactive).

> 2. Sometimes the setup commands outside of test scripts produce
>    output.  This is annoying, so people silence it.

Yeah, it is annoying. And I am totally in favor of things that might
produce output going into test_expect_success blocks. And...

> 3. Sometimes the setup commands outside of test scripts are broken.
>    Tests do not use "set -e" or check for errors outside of test
>    assertions, so simple typos can go undetected for a long time.

I agree here. And I'm totally in favor of things that might fail going
into test_expect_success blocks. I don't consider running "printf", or
dumping a here-document into a file via cat to be likely to fail.

> 4. What actually provoked me to care about it: when trying to add a
>    test to t9301-fast-import.sh, say, I found myself completely lost.
>    It is really hard to figure out what the state is supposed to be
>    at a particular point in the test script.  Sometimes I am tempted
>    to write a new test script when adding a new behavior, only
>    because I do not understand the existing one on a topic.  All the
>    tests can be well-behaved and follow sane invariants, but that
>    does not matter, because the invariants are not documented anywhere.

To some degree, I addressed this above. But yeah, even with a nice
drop-to-shell debug support, undocumented invariants are going to be a
pain when debugging a test. But I don't think moving them into a
test_expect_success block is going to help that. The problem is subtle
state changes of the test directory.

Things like test_when_finished help with that, and I hope people will
use them. But I fear that tests will always suffer from being somewhat
messier than actual code, and will always be written in a bit of a
procedural fashion. That is, I don't think we will ever achieve a level
of modularity and orthogonality in writing tests that would mean you
could just run some tests in isolation. It's just not worth the effort
most of the time.

Still, I encourage you to try to push in that direction by leading by
example. You obviously have some ideas. My only real complaint about
your patch was that I find the syntax uglier. And your suggestions are
not alone in that. We have tons of ugly quoting because of the need to
double-quote in test_expect_success. Perhaps we could refactor it into a
set of two functions that keep state? E.g., something like:

test_start 'setup'
cat >expect <<EOF
... whatever ...
EOF
test_end success

test_start 'description'
git frob >actual &&
test_cmp expect actual
test_end success

where test_start would set up >&3 and >&4 as usual, and test_end would
check $? and report the status. The biggest problem I see is that we
never have the actual shell script snippet as a string, so we don't have
a way of printing it for "-v" (or on failure). Hmm.

> The result would be:
> 
>  - test commands all shown with "-v", output all suppressed without;
>  - all commands pass at least the sanity check of exiting with 0
>    status;
>  - easy to write a GIT_SKIP_TESTS specification.  Would be possible
>    to add the ability to try a single test (plus all setup tests in
>    that script that precede it);
>  - as long as all the setup tests pass, the list of failed tests
>    from a test failure can be more informative;
>  - state can be tracked by just reading the setup tests.

Again, I think these are great goals. I'm not sure we will ever reach
them, or whether we will find the work that goes into them to be worth
the effort (especially because it is so easy to break these properties
with new tests, and there is not a good test harness for testing how
well you have written your tests).

> I don't know: I think
> 
> 	cat >expect <<-\EOF &&
> 	...
> 	EOF
> 
> is pretty readable.  The problem with sticking to

Yeah, I almost mentioned that, but for some reason in the back of my
mind <<- is not actually portable. Perhaps I am just thinking of the
fact that perl does not support it.

-Peff
