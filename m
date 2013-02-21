From: Jeff King <peff@peff.net>
Subject: Re: [BUG] Infinite make recursion when configure.ac changes
Date: Thu, 21 Feb 2013 01:04:02 -0500
Message-ID: <20130221060401.GC25943@sigill.intra.peff.net>
References: <51248D0A.50603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 07:04:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8PGo-0000pN-ED
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 07:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957Ab3BUGEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 01:04:06 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55200 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716Ab3BUGEE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 01:04:04 -0500
Received: (qmail 24504 invoked by uid 107); 21 Feb 2013 06:05:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Feb 2013 01:05:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Feb 2013 01:04:02 -0500
Content-Disposition: inline
In-Reply-To: <51248D0A.50603@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216755>

On Wed, Feb 20, 2013 at 09:44:58AM +0100, Stefano Lattarini wrote:

> From a pristine master checkout:
> 
>   $ make configure && ./configure make
>   ... # All successfull
>   $ touch configure.ac
>   $ make
>     GEN config.status
>   make[1]: Entering directory `/storage/home/stefano/git/src'
>     GEN config.status
>   make[2]: Entering directory `/storage/home/stefano/git/src'
>     GEN config.status
>   make[3]: Entering directory `/storage/home/stefano/git/src'
>     GEN config.status
>   make[4]: Entering directory `/storage/home/stefano/git/src'
>     GEN config.status
>   make[5]: Entering directory `/storage/home/stefano/git/src'
>     GEN config.status
>   ...
> 
> and I have to hit ^C to interrupt that recursion.

I can easily replicate it here.

> This seems due to the change in commit v1.7.12.4-1-g1226504: the
> issue is still present there, but no longer is in the preceding
> commit 7e201053 (a.k.a. v1.7.12.4).
> 
> I haven't investigated this any further for the moment.

Hmm. It looks like config.status depends on configure.ac. So make
rebuilds config.status, which runs "make configure", which includes
"config.mak.autogen", leading "make" to think that it should rebuild the
include file to make sure it is up to date. The include file depends on
"config.status", which needs to be rebuilt due to configure.ac, which
entails running "make configure", and so on.

So the real problem is that make things that "make configure" depends on
"config.mak.autogen" being up to date, which isn't true at all; the
whole point is to make a new configure script so we can write a new
config.mak.autogen. The simplest thing is to just avoid re-running
"make" to get the configure script; the only thing we are gaining is
that we don't have to repeat the build recipe, but we can sneak around
that by sticking it in a variable. Something like this seems to work:

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

-Peff
