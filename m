From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: Re: [PATCH 3/4] build dashless "test-bin" directory similar to installed bindir
Date: Sat, 28 Nov 2009 19:52:51 -0700
Message-ID: <20091129025251.GA1771@comcast.net>
References: <1259433537-3963-1-git-send-email-mmogilvi_git@miniinfo.net> <1259433537-3963-2-git-send-email-mmogilvi_git@miniinfo.net> <1259433537-3963-3-git-send-email-mmogilvi_git@miniinfo.net> <1259433537-3963-4-git-send-email-mmogilvi_git@miniinfo.net> <7vtywefn88.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 29 03:53:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEZuG-0000Em-DU
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 03:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753811AbZK2Cws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 21:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753768AbZK2Cws
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 21:52:48 -0500
Received: from qmta11.emeryville.ca.mail.comcast.net ([76.96.27.211]:48555
	"EHLO QMTA11.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753673AbZK2Cwr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Nov 2009 21:52:47 -0500
Received: from OMTA01.emeryville.ca.mail.comcast.net ([76.96.30.11])
	by QMTA11.emeryville.ca.mail.comcast.net with comcast
	id AqNk1d0030EPchoABqqA5V; Sun, 29 Nov 2009 02:50:10 +0000
Received: from mmogilvi.homeip.net ([24.8.125.243])
	by OMTA01.emeryville.ca.mail.comcast.net with comcast
	id Aqst1d0085FCJCg8MqsuHJ; Sun, 29 Nov 2009 02:52:54 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id BC00D89115; Sat, 28 Nov 2009 19:52:51 -0700 (MST)
Content-Disposition: inline
In-Reply-To: <7vtywefn88.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.4i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133986>

On Sat, Nov 28, 2009 at 11:44:39AM -0800, Junio C Hamano wrote:
>  - Patch #1 and #2 are good and are independent from the later patches, as
>    without them running tests with GIT_TEST_INSTALLED would not work.
> 
>    By the way, 6720721 (test-lib.sh: Allow running the test suite against
>    installed git, 2009-03-16) failed to document the feature in t/README.
>    Could you please fix this while you are at it?

Sure, I'll include another patch for this when I re-roll the
series.  It will probably mention something about still needing
a build so that it can access the test-* support executables.

>  - It certainly is _possible_ to add $(pwd)/test-bin to $PATH instead of
>    the established practice of using GIT_EXEC_PATH for every day/permanent
>    use without installation, but I doubt we should _encourage_ it for a
>    few reasons:
> 
>    . The set-up will force one extra exec due to the wrapper; this is good
>      for the purpose of running tests, but unnecessary for a set-up for
>      every day/permanent use by people, compared with the already working
>      approach.  The user needs to change an environment variable _anyway_
>      (either GIT_EXEC_PATH with the traditional approach, or PATH with
>      your patch).
> 
>    . The new component to be added to $PATH shouldn't be named "test-bin/"
>      if it is meant for every day/permanent use.
> 
>    . Advertising this forces the Makefile build test-bin/ contents from
>      "all" target.  I think test-bin/ should only depend on "test" (iow,
>      after "make all && make install" there shouldn't have to be "test-bin"
>      directory.
> 
>    I would rather treat it an unintended side-effect that you can add that
>    directory to the $PATH.  It is designed to work in such an environment
>    (otherwise the tests won't exercise the version of git they are meant
>    to test), but I do not think it is _meant_ to be _used_  by end users
>    that way.  And an unintended side-effect does not have to be mentioned
>    in INSTALL (especially with the directory name with "test" in it).

I personally like the idea of being able to use an uninstalled
build without touching environment variables at all.  Just specify
the full path to the the version you want to run on the
command line, as in: ~/SANDBOX/test-bin/git WHATEVER
Especially handy for trying "ssh MACHINE /PATH/SANDBOX/...".

FYI: There are already a number of test suite support executables
built by "make all" (test-*).  It might be hard to eliminate them
from "all" without risking stale executables.  As Jeff
King <peff@peff.net> pointed out in a separate email, some people
(including me) often don't use the top-level "make test" target
to run tests.

I'm still thinking about this.  I've noted some possible changes
to the patch series below, some of which are mutually exclusive.
Any opinions?

Options geared towards isolating/hiding test-bin:

  1. Scrap the part of the patch that modifies INSTALL.

  2. Perhaps use hardlinks, symlinks, and/or copies within test-bin,
     instead of wrapper scripts, to eliminate the extra exec.  Since
     test-lib.sh already sets up necessary environment variables,
     they don't strictly need to be set in the wrappers as
     well.  On the other hand, hardlinks and copies are potentially
     vulnerable to stale executable issues, and symlinks typically
     don't work on Windows.  

  3. Scrap pre-built test-bin completely, and switch to a solution
     that more closely resembles the valgrind option (have test-lib.sh
     build the directory).  This can't use the same makefile variables
     to define the contents of the directory, though.

Options geared towards making something like test-bin an official way
to run an uninstalled build:

  4. Rename test-bin.  Perhaps "bin-wrappers", "bin-dashless",
     "bin-install", "bin", or "bindir".  Any preferences?

  5. The current patch doesn't quite handle the simple
     "~/SANDBOX/test-bin/gitSOMETHING WHATEVER" idiom perfectly
     if the executable (gitSOMETHING) tries to run additional
     git commands without adjusting the PATH first.  I could enhance
     the wrapper to prefix test-bin onto the PATH just in case it
     isn't there already.

Other cleanup options:

  6. There is a stale script issue if someone does something like:
       make
       cp -a . /some/other/path
       cd /some/other/path
       [optional modifications, without a "make clean"]
       make
       [run tests; uses wrong executables...]
     Including GIT-CFLAGS as a makefile dependency for the
     wrappers was intended to address this, but looking
     closer, I don't think it works.  Perhaps I should
     include $(shell pwd) in GIT-CFLAGS, or make a new GIT-PWD target
     that works similarly to GIT-CFLAGS.  Without this, a workaround
     (and probably best option overall) is to do a "make clean" after
     copying a sandbox.

  7. Enable similar dashless environment when
     GIT_TEST_INSTALLED and/or valgrind are enabled?

  8. Include wrappers for other dashed-commands in test-bin, which
     would always fail, in case someone runs tests with an installed
     GIT_EXEC_PATH already in their PATH.  This might catch a new test
     using dashes in such an environment.  I don't really think this
     is worth it, though.  Most people don't have GIT_EXEC_PATH in their
     PATH, and some such person would notice any problems soon.

  9. This may be outside the scope of this patch series, but perhaps
     git executables could try to find argv[0] in the PATH
     (if argv[0] is not absolute), and see if they can find various other
     executables (GIT_EXEC_PATH) and data files (perl, templates,
     etc) using paths relative to itself.  This may include
     manually dereferencing argv[0] if it is a symlink.  GIT_EXEC_PATH
     and friends still takes precedence, but only fallback on
     compile-time defaults if "find relative to argv[0]" fails.
     It looks like Makefile RUNTIME_PREFIX enables something like
     this, but it is currently disabled by default on most platforms.

--
Matthew Ogilvie   [mmogilvi_git@miniinfo.net]
