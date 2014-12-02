From: Jeff King <peff@peff.net>
Subject: Re: tests do not work with gpg 2.1
Date: Tue, 2 Dec 2014 16:21:34 -0500
Message-ID: <20141202212133.GE23461@peff.net>
References: <xmqqr3wpo8yl.fsf@gitster.dls.corp.google.com>
 <20141127213224.GA27443@dispater.uplinklabs.net>
 <54784503.80108@drmicha.warpmail.net>
 <20141128165009.GA4728@peff.net>
 <547DB6C3.5010704@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Noonan <steven@uplinklabs.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 22:21:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvut8-0006sO-1I
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 22:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933045AbaLBVVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 16:21:34 -0500
Received: from cloud.peff.net ([50.56.180.127]:47395 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754007AbaLBVVd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 16:21:33 -0500
Received: (qmail 30951 invoked by uid 102); 2 Dec 2014 21:21:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Dec 2014 15:21:33 -0600
Received: (qmail 18912 invoked by uid 107); 2 Dec 2014 21:21:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Dec 2014 16:21:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Dec 2014 16:21:34 -0500
Content-Disposition: inline
In-Reply-To: <547DB6C3.5010704@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260595>

On Tue, Dec 02, 2014 at 01:55:31PM +0100, Michael J Gruber wrote:

> That private-keys directory is from the first run of gpg2.1 on a pre-2.1
> GPGHOME. It converts the old secring db to that new dir of entries and
> uses that instead.

Thanks for untangling this. As I mentioned elsewhere in the thread, it
was just that I had munged my parent lib-gpg directory. Cleaning that up
fixed the problem I was seeing, and I could proceed with experimenting.

> I think if you unset GPG_AGENT_INFO, gpg2.1 thinks there is no agent,
> starts it's own and talks to it via a socket directly (no env variable).
> Now that one seems come with different options (regarding pinentry) so
> that it can't even ask you for a passphrase.

If I unset GPG_AGENT_INFO, I still get the original behavior; a pop-up
dialog that asks for the passphrase (and feeding it the empty passphrase
works). My differing behavior from Steven may just be quirks in our
setup, or maybe it is the fact that I still have gpg1 installed.

I think the fundamental problem, though, is just that gpg2.1 cannot
seamlessly handle the case of a keyring with no passphrase. I am sure
this is not a well-tested case, since GPG devs likely would say "you're
doing it wrong". But obviously it makes sense here for testing purposes.

I'm not sure if the most expedient path is trying to convince gpg
developers that it's a bug, or if there is some workaround (like
"--passphrase-file /dev/null" or something).

I've been using the patch below to test, and am tempted to offer it for
inclusion. But if we need to hack up the gpg command-line just for the
tests, then lib-gpg.sh would end up setting gpg.program, and that would
override what my patch is doing anyway.

-- >8 --
Subject: Makefile: provide build-time config of "gpg" program

If the user hasn't configured gpg.program, we fallback to
running just "gpg". Since it _can_ be overridden by
run-time config, this is sufficient for most people who have
some specific "gpg" they want to run. However, there are two
reasons we might want a build-time configuration, too:

  1. A binary package may want to hard-code a matching gpg
     without requiring that the user set up their PATH or
     config explicitly.

  2. When running the test scripts, it's hard to debug tests
     using an alternate GPG, as it would involve tweaking
     each individual test script to set the gpg path.

Let's provide a Makefile knob for tweaking this.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile        | 6 ++++++
 gpg-interface.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 827006b..e3c1ec1 100644
--- a/Makefile
+++ b/Makefile
@@ -400,6 +400,7 @@ INSTALL = install
 RPMBUILD = rpmbuild
 TCL_PATH = tclsh
 TCLTK_PATH = wish
+GPG_PATH = gpg
 XGETTEXT = xgettext
 MSGFMT = msgfmt
 PTHREAD_LIBS = -lpthread
@@ -1503,6 +1504,10 @@ SHELL_PATH_CQ_SQ = $(subst ','\'',$(SHELL_PATH_CQ))
 BASIC_CFLAGS += -DSHELL_PATH='$(SHELL_PATH_CQ_SQ)'
 endif
 
+GPG_PATH_CQ = "$(subst ",\",$(subst \,\\,$(GPG_PATH)))"
+GPG_PATH_CQ_SQ = $(subst ','\'',$(GPG_PATH_CQ))
+BASIC_CFLAGS += -DGPG_PATH='$(GPG_PATH_CQ_SQ)'
+
 GIT_USER_AGENT_SQ = $(subst ','\'',$(GIT_USER_AGENT))
 GIT_USER_AGENT_CQ = "$(subst ",\",$(subst \,\\,$(GIT_USER_AGENT)))"
 GIT_USER_AGENT_CQ_SQ = $(subst ','\'',$(GIT_USER_AGENT_CQ))
@@ -2038,6 +2043,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo SHELL_PATH=\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@
 	@echo PERL_PATH=\''$(subst ','\'',$(PERL_PATH_SQ))'\' >>$@
 	@echo DIFF=\''$(subst ','\'',$(subst ','\'',$(DIFF)))'\' >>$@
+	@echo GPG_PATH=\''$(subst ','\'',$(subst ','\'',$(GPG_PATH)))'\' >>$@
 	@echo PYTHON_PATH=\''$(subst ','\'',$(PYTHON_PATH_SQ))'\' >>$@
 	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@
 	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@
diff --git a/gpg-interface.c b/gpg-interface.c
index 68b0c81..67c6e35 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -5,7 +5,7 @@
 #include "sigchain.h"
 
 static char *configured_signing_key;
-static const char *gpg_program = "gpg";
+static const char *gpg_program = GPG_PATH;
 
 #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
 #define PGP_MESSAGE "-----BEGIN PGP MESSAGE-----"
-- 
2.2.0.390.gf60752d
