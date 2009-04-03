From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] NO_PERL support
Date: Fri, 3 Apr 2009 09:20:29 -0400
Message-ID: <20090403132029.GC21153@coredump.intra.peff.net>
References: <20090403T065545Z@curie.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Fri Apr 03 15:22:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpjLf-0007ex-25
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 15:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655AbZDCNUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 09:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753488AbZDCNUq
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 09:20:46 -0400
Received: from peff.net ([208.65.91.99]:34164 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbZDCNUp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 09:20:45 -0400
Received: (qmail 31655 invoked by uid 107); 3 Apr 2009 13:21:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 03 Apr 2009 09:21:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Apr 2009 09:20:29 -0400
Content-Disposition: inline
In-Reply-To: <20090403T065545Z@curie.orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115529>

[cc'ing Johannes because of some possibly related work in the test
scripts; see below]

On Fri, Apr 03, 2009 at 12:03:50AM -0700, Robin H. Johnson wrote:

> The attached patch adds NO_PERL to the build system, in the same fashion
> as NO_TCLTK.

I think this is a good change. One of my less-abled test platforms has a
broken perl, and I end up having to manually skip a lot of tests. Being
able to set NO_PERL and have the tests themselves realize they must be
skipped will be much cleaner.

> Effects:
> - No perl-based scripts or code are installed:
> 	$SCRIPT_PERL
> 	git-instaweb
> 	gitweb
> 	git-cvsserver
> 	git-svn
> - git-add does NOT have interactive support.
> - None of the tests for the disabled stuff gets run.

Hmm. With this patch, a user with a NO_PERL build will just get:

  $ git svn
  git: 'svn' is not a git-command. See 'git --help'.
  $ git add -i
  error: unknown switch `i'
  usage: ...

I wonder if we should be a little nicer and say "we know about this
command or option, but we did not build support for it". OTOH, what you
have mirrors what NO_TCLTK does, so perhaps it is not a big deal.

> @@ -1067,6 +1079,11 @@ endif
>  ifeq ($(TCLTK_PATH),)
>  NO_TCLTK=NoThanks
>  endif
> +ifeq ($(PERL_PATH),)
> +NO_PERL=NoThanks
> +export NO_PERL
> +export NO_PERL_MAKEMAKER
> +endif

Do we have to actually export here? NO_TCLTK doesn't. If it's for the
test scripts, then should it be part of GIT-BUILD-OPTIONS?

> +if test -n "$NO_PERL"
> +then
> +	test_expect_success 'skipping git-svn tests, NO_PERL defined' :
> +	test_done
> +	exit
> +fi

This probably got copied from an older example, but I think the
recommended way to skip tests these days is to use 'say' instead of
test_expect_success (since we have statistics on passing/failing tests
now).

Also, it may make sense to integrate this with Johannes Sixt's
test_have_prereq work (which is still in next), but I haven't looked too
closely at that.

> -test_expect_success \
> +[ -z "$NO_PERL" ] && test_expect_success \

I think it is nicer to actually say "skipping test" as the other spots
do instead of just not running it.

-Peff
