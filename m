From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] NO_PERL support
Date: Fri, 3 Apr 2009 16:56:07 -0400
Message-ID: <20090403205607.GA8152@coredump.intra.peff.net>
References: <20090403T065545Z@curie.orbis-terrarum.net> <7vljqhaemm.fsf@gitster.siamese.dyndns.org> <20090403171514.GA11112@coredump.intra.peff.net> <7vocvd8p6s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 22:58:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpqSg-0006GA-A9
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 22:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756598AbZDCU40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 16:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756582AbZDCU40
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 16:56:26 -0400
Received: from peff.net ([208.65.91.99]:46991 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754391AbZDCU4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 16:56:25 -0400
Received: (qmail 1383 invoked by uid 107); 3 Apr 2009 20:56:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 03 Apr 2009 16:56:41 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Apr 2009 16:56:07 -0400
Content-Disposition: inline
In-Reply-To: <7vocvd8p6s.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115560>

On Fri, Apr 03, 2009 at 01:20:11PM -0700, Junio C Hamano wrote:

> Saying "We support building but not testing" is like saying "we don't
> support it", and honestly, we'd be better off leaving this patch out of
> tree if that is what we are going to do.  Even though I am not personally

Well, there are actually multiple levels that are worth considering. The
tasks you might want to accomplish are:

  1. Build the programs
  2. Run the test suite
  3. Run the programs (excepting the perl ones, of course); note
     that being able to build is not necessarily a prerequisite,
     as you might receive git as a binary package.
  4. Build the documentation
  5. View the documentation

Right now, (1), (2), and (4) are broken without perl. (5) works fine
because it doesn't involve perl at all. (3) works the same, except you
get error messages like "not a git command".

I can think of three situations which are helped by my patch series:

  - You are on a system with no perl. You don't care about running the
    test suite, but you do want to use basic git. You can now build and
    run, with the except of the perl scripts.

  - You are on a system with an old or inferior perl. For example, my
    Solaris test box has perl 5.005, and I know Alex has complained
    about Activestate perl on more than one occasion. The inferior perl
    is generally enough to run the little snippets in the test suite and
    the Documentation Makefile. So you can now build and run git (minus
    the perl bits) and the documentation (in theory -- you don't have
    perl but you _do_ have working asciidoc and xmlto?), and you can run
    the test suite without having to manually skip a bunch of tests
    (which is what I do now).

  - You are a package builder distributing binary packages. You have
    perl, but you want to build a noperl variant. Perl works for
    building the package, but you want the _result_ not to use perl. The
    test scripts, of course, must also respect NO_PERL since you have
    built placeholder scripts instead of the real thing.

> very enthused about NO_PERL, the Makefile patch itself does not look too
> bad, and if we can finish this with very limited injury to the overall
> codebase, I wouldn't mind carrying the option in-tree.

I don't think it is. See my 3/4.

>         Side note: by the way, what did you or Robin's patch do to
>         Documentation/cmd-list.perl and other bits of build infrastructure
>         that rely on Perl?

Neither patch does anything. AFAIK, Documentation/Makefile uses perl,
but nothing else does (aside from the test scripts previously
mentioned).

> To solve the second "no" cleanly, I am wondering if we can do something
> clever by defining $PERL to be used in t/t*.sh scripts.  They should be
> using configured PERL_PATH for running the tests _anyway_, even though I
> see many hits from "git grep -e perl t/" right now.

We can redefine them to use $PERL_PATH (which I agree should be done
anyway), but intercepting there is probably too late. You will be in the
middle of a test, and want to say "Oh wait, I was supposed to skip this
test." Certainly possible, but I think it might make the test code
pretty ugly.

  Aside: I think the reason that the lack of PERL_PATH hasn't been a
  problem is that people are generally not picking a _different_ perl,
  but rather need the whole path to go on the #! line. So the full path
  and "whatever is in my PATH" tend to be the same thing.

> But even if there isn't a room for doing something clever there, I think
> the test prerequisite framework J6t did recently should be usable without
> cluttering the test suite too much.  That forces test authors to be aware
> of NO_PERL, which is slightly yucky, but if it cannot be helped, I think
> we can survive.  We do the same for UTF8 and SYMLINKS already.

See my 4/4, which uses J6t's framework to do the first part (disabling
tests for scripts which we didn't actually build).

A 5/4 might be "disable uses of perl in tests when NO_PERL is set". And
that would be much more invasive. In my scenarios above, it buys the "I
don't have perl at all" people the ability to run a subset of the test
suite (but unlike 4/4, it is skipping tests that are actually useful and
important, but just happen to rely on perl for their infrastructure --
4/4 is by definition skipping tests that have no meaning).

I don't have any Gentoo boxen, but my understanding is that pretty much
everything is built from source. So the "you can make binary packages"
fix doesn't help them that much. OTOH, Robin's current patch doesn't
help that either, so I can only assume they're not really running the
test suite on perl-less systems. And I don't see a reason why upstream
git can't do part of the work (my series), and the Gentoo build can't do
the rest (setting GIT_SKIP_TESTS as appropriate).

-Peff
