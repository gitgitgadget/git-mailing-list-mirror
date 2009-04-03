From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] NO_PERL support
Date: Fri, 3 Apr 2009 11:16:01 -0400
Message-ID: <20090403151601.GA27034@coredump.intra.peff.net>
References: <20090403T065545Z@curie.orbis-terrarum.net> <20090403132029.GC21153@coredump.intra.peff.net> <alpine.DEB.1.00.0904031649400.10279@pacific.mpi-cbg.de> <20090403145329.GA25967@coredump.intra.peff.net> <alpine.DEB.1.00.0904031701430.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 03 17:18:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LplAC-0001gS-K1
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 17:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934734AbZDCPQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 11:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934478AbZDCPQT
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 11:16:19 -0400
Received: from peff.net ([208.65.91.99]:59338 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934713AbZDCPQS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 11:16:18 -0400
Received: (qmail 32270 invoked by uid 107); 3 Apr 2009 15:16:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 03 Apr 2009 11:16:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Apr 2009 11:16:01 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0904031701430.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115537>

On Fri, Apr 03, 2009 at 05:02:16PM +0200, Johannes Schindelin wrote:

> > Yes, there are really two cases here:
> > 
> >   1. options to programs that will be disabled
> > 
> >   2. whole programs that will not be installed
> > 
> > Are you proposing to print "sorry, perl support not compiled in" (or
> > whatever) for case 1, but ignore case 2? (And I am not sure if that is a
> > bad idea, but I am trying to be clear on what you mean).
> 
> 1) as it is all too easy, but not 2) as that would require too much work, 
> which would be overkill.

I don't think 2 is that hard. See the patch below (on top of Robin's).
The question is whether it is more confusing for these programs to show
up in completion and then turn out to be totally broken, or for them to
simply be missing altogether. That is, as a git user who is accustomed
to the regular build, will I be more confused by:

  $ git svn
  Sorry, git was built without support for git-svn (NO_PERL).

or

  $ git svn
  git: 'svn' is not a git-command. See 'git --help'.

---
diff --git a/Makefile b/Makefile
index c4eb1ad..41abadb 100644
--- a/Makefile
+++ b/Makefile
@@ -298,7 +298,6 @@ SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH))
-ifndef NO_PERL
 SCRIPT_PERL += git-add--interactive.perl
 SCRIPT_PERL += git-archimport.perl
 SCRIPT_PERL += git-cvsexportcommit.perl
@@ -309,9 +308,6 @@ SCRIPT_PERL += git-send-email.perl
 SCRIPT_PERL += git-svn.perl
 SCRIPTS += $(patsubst %.perl,%,$(SCRIPT_PERL)) \
 			git-instaweb
-else
-SCRIPT_PERL =
-endif
 
 # Empty...
 EXTRA_PROGRAMS =
@@ -1304,6 +1300,13 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css
 	    $@.sh > $@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
+else # NO_PERL
+$(patsubst %.perl,%,$(SCRIPT_PERL)) git-instaweb: % : missing-perl.sh
+	$(QUIET_GEN)$(RM) $@ $@+ && \
+	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	    missing-perl.sh >$@+ && \
+	chmod +x $@+ && \
+	mv $@+ $@
 endif # NO_PERL
 
 configure: configure.ac
diff --git a/missing-perl.sh b/missing-perl.sh
new file mode 100644
index 0000000..d277be9
--- /dev/null
+++ b/missing-perl.sh
@@ -0,0 +1,4 @@
+#!/bin/sh
+
+echo "Sorry, git was built without support for `basename $0` (NO_PERL)."
+exit 128
