From: Jeff King <peff@peff.net>
Subject: Re: [BUG] Infinite make recursion when configure.ac changes
Date: Thu, 21 Feb 2013 01:26:14 -0500
Message-ID: <20130221062614.GA8827@sigill.intra.peff.net>
References: <51248D0A.50603@gmail.com>
 <20130221060401.GC25943@sigill.intra.peff.net>
 <7vk3q2w61p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 07:26:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8PcA-0005Nn-O7
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 07:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023Ab3BUG0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 01:26:17 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55222 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982Ab3BUG0R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 01:26:17 -0500
Received: (qmail 24678 invoked by uid 107); 21 Feb 2013 06:27:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Feb 2013 01:27:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Feb 2013 01:26:14 -0500
Content-Disposition: inline
In-Reply-To: <7vk3q2w61p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216757>

On Wed, Feb 20, 2013 at 10:10:42PM -0800, Junio C Hamano wrote:

> I noticed this while looking at the other autoconf patch yesterday,
> but I was otherwise occupied in the evening and did not pursue it
> further.  Thanks for looking into it.

Here's the patch with a commit message. I'm pretty sure this is the
right thing to do. I was tempted to find a way of telling make "no,
don't include config.mak.autogen, but that actually _isn't_ right. It
might be defining $(RM) or some other variable that we use in the
recipe. By including it inline, we will use whatever is in the current
config.mak.autogen (that we read when we started this make invocation),
which is better than nothing.

> This may be an unrelated issue, but I've always thought that it was
> strange and extremely unintuitive that running "make configure" once
> only creates config.mak.autogen, while running it once again after
> that (i.e. while having config.mak.autogen in the tree) seems to run
> the resulting "./configure" as well. Maybe it is just me.

It's not the "configure" target that causes it to run. It's the fact
that we include config.mak.autogen, which we then tell make can be
rebuilt by running ./configure. _But_ we only tell it so if one already
exists (since otherwise everybody would get automake cruft). This is the
"ifdef AUTOCONFIGURED" you see.

So I think the rule makes sense. Once you have told the Makefile that
you are interested in autoconf (by running configure once), then it
rebuilds it as necessary, and it should be consistent. You can opt back
out of it be removing config.mak.autogen.

Anyway, here is the patch to fix the loop.

-- >8 --
Subject: [PATCH] Makefile: avoid infinite loop on configure.ac change

If you are using autoconf and change the configure.ac, the
Makefile will notice that config.status is older than
configure.ac, and will attempt to rebuild and re-run the
configure script to pick up your changes. The first step in
doing so is to run "make configure". Unfortunately, this
tries to include config.mak.autogen, which depends on
config.status, which depends on configure.ac; so we must
rebuild config.status. Which leads to us running "make
configure", and so on.

It's easy to demonstrate with:

  make configure
  ./configure
  touch configure.ac
  make

We can break this cycle by not re-invoking make to build
"configure", and instead just putting its rules inline into
our config.status rebuild procedure.  We can avoid a copy by
factoring the rules into a make variable.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 3b2c92c..ee1c0b0 100644
--- a/Makefile
+++ b/Makefile
@@ -1871,12 +1871,14 @@ configure: configure.ac GIT-VERSION-FILE
 	mv $@+ $@
 endif # NO_PYTHON
 
+CONFIGURE_RECIPE = $(RM) configure configure.ac+ && \
+		   sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
+			configure.ac >configure.ac+ && \
+		   autoconf -o configure configure.ac+ && \
+		   $(RM) configure.ac+
+
 configure: configure.ac GIT-VERSION-FILE
-	$(QUIET_GEN)$(RM) $@ $<+ && \
-	sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-	    $< > $<+ && \
-	autoconf -o $@ $<+ && \
-	$(RM) $<+
+	$(QUIET_GEN)$(CONFIGURE_RECIPE)
 
 ifdef AUTOCONFIGURED
 # We avoid depending on 'configure' here, because it gets rebuilt
@@ -1885,7 +1887,7 @@ config.status: configure.ac
 # do want to recheck when the platform/environment detection logic
 # changes, hence this depends on configure.ac.
 config.status: configure.ac
-	$(QUIET_GEN)$(MAKE) configure && \
+	$(QUIET_GEN)$(CONFIGURE_RECIPE) && \
 	if test -f config.status; then \
 	  ./config.status --recheck; \
 	else \
-- 
1.8.1.4.4.g265d2fa
