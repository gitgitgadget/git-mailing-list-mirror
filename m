From: Jeff King <peff@peff.net>
Subject: [PATCHv2 0/8] makefile cleanups
Date: Tue, 19 Jun 2012 19:22:31 -0400
Message-ID: <20120619232231.GA6328@sigill.intra.peff.net>
References: <20120619195229.GA14692@sigill.intra.peff.net>
 <20120619200354.GC14714@sigill.intra.peff.net>
 <7vmx3zyqil.fsf@alter.siamese.dyndns.org>
 <20120619210426.GA21838@sigill.intra.peff.net>
 <20120619214308.GA22166@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 01:22:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh7kr-0003hB-Mq
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 01:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753799Ab2FSXWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 19:22:34 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:33128
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814Ab2FSXWd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 19:22:33 -0400
Received: (qmail 15672 invoked by uid 107); 19 Jun 2012 23:22:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Jun 2012 19:22:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jun 2012 19:22:31 -0400
Content-Disposition: inline
In-Reply-To: <20120619214308.GA22166@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200265>

On Tue, Jun 19, 2012 at 05:43:08PM -0400, Jeff King wrote:

> Some of the existing locations did not do a great job of that, and
> instead it like this:
> 
>   version.o git.spec \
>           $(patsubst %.sh,%,$(SCRIPT_SH)) \
>           $(patsubst %.perl,%,$(SCRIPT_PERL)) \
>           : GIT-VERSION-FILE
> 
>   [... 500 lines later ...]
> 
>   git.spec: git.spec.in
>           sed -e 's/@@VERSION@@/$(GIT_VERSION)/g' <$< >$@+
> 
> If you read the latter hunk and wanted to emulate it, there is nothing
> to indicate that you must also modify the earlier hunk. I think putting
> them together makes more sense (even though it technically takes more
> lines).

Hmm. The deeper I dig into the Makefile, the more problems I find. I
think I'm ready to come out of the rabbit hole for today, and I ended up
with the series below. Some of it is cleanup and some of it fixes real
problems.

My philosophy in doing the series was:

  1. Dependencies should be inclusive. That is, re-running "make" in an
     already-built tree with different parameters should produce the
     same result as running in a clean tree.

  2. Dependencies do not have to be precise. That is, it's OK to re-run
     a build step even if it will produce the same output. Of course,
     it's nice to be more precise because it saves time, but for the
     sake of simplicity, we compartmentalize groups of changes (e.g.,
     GIT-CFLAGS depends on SHELL_PATH even though only run-command.c
     needs it; that's OK because SHELL_PATH doesn't get changed often).

  3. Dependencies on variables that change regularly _should_ be
     precise. GIT_VERSION (and anything that depends on it) is a good
     example, because you don't want to rebuild every time you check out
     a new version.

  [1/8]: Makefile: apply dependencies consistently to sparse/asm targets
  [2/8]: Makefile: do not replace @@GIT_USER_AGENT@@ in scripts
  [3/8]: Makefile: split GIT_USER_AGENT from GIT-CFLAGS
  [4/8]: Makefile: split prefix flags from GIT-CFLAGS
  [5/8]: Makefile: do not replace @@GIT_VERSION@@ in shell scripts
  [6/8]: Makefile: update scripts when build-time parameters change
  [7/8]: Makefile: build instaweb similar to other scripts
  [8/8]: Makefile: move GIT-VERSION-FILE dependencies closer to use

This replaces the series I sent earlier today, and goes on top of
jk/version-string.  A lot of it could be a separate topic, but it's
textually pretty tangled. If jk/version-string is soon to graduate, then
I'd just as soon leave it as-is rather than go to the work of
disentangling it. Even though there are fixes here, none of them is so
critical that they can't be held hostage for a few days or a week.

-Peff
