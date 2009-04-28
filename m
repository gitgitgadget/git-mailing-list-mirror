From: Jeff King <peff@peff.net>
Subject: [PATCH] Makefile: fix NO_PERL bug with gitweb
Date: Mon, 27 Apr 2009 23:34:24 -0400
Message-ID: <20090428033423.GA7704@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 05:34:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lye5f-0000xs-VQ
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 05:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508AbZD1De2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 23:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754216AbZD1De2
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 23:34:28 -0400
Received: from peff.net ([208.65.91.99]:39913 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753476AbZD1De2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 23:34:28 -0400
Received: (qmail 23977 invoked by uid 107); 28 Apr 2009 03:34:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 27 Apr 2009 23:34:39 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Apr 2009 23:34:24 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117744>

When the user has defined NO_PERL, we want to skip building
gitweb entirely.  However, the conditional to add
gitweb/gitweb.cgi to OTHER_PROGRAMS was evaluated before we
actually parsed the user's config.mak. This meant that "make
NO_PERL=NoThanks" worked fine, but putting "NO_PERL=NoThanks"
into your config.mak broke the build (it wanted gitweb.cgi
to satisfy "all", but the rule to build it was conditionally
ignored, so it complained).

Signed-off-by: Jeff King <peff@peff.net>
---
Robin, I believe your original patch has this problem, too. I'm assuming
it never came up because the Gentoo build specifies the options on the
make command-line instead of through config.mak (which is also why my
earlier testing didn't catch it). So you may or may not want to modify
your patch.

I moved the offending code close to the gitweb.cgi rule definition (it
was originally near the OTHER_PROGRAMS definition). I tried to find a
spot that would make some sense, rather than just plopping it randomly
somewhere after config.mak has been read. But if something else would
make more sense, Junio, feel free to tweak the patch.

 Makefile |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 49f36f5..0292b4f 100644
--- a/Makefile
+++ b/Makefile
@@ -361,9 +361,6 @@ ALL_PROGRAMS = $(PROGRAMS) $(SCRIPTS)
 
 # what 'all' will build but not install in gitexecdir
 OTHER_PROGRAMS = git$X
-ifndef NO_PERL
-OTHER_PROGRAMS += gitweb/gitweb.cgi
-endif
 
 # Set paths to tools early so that they can be used for version tests.
 ifndef SHELL_PATH
@@ -1271,6 +1268,7 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	chmod +x $@+ && \
 	mv $@+ $@
 
+OTHER_PROGRAMS += gitweb/gitweb.cgi
 gitweb/gitweb.cgi: gitweb/gitweb.perl
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
-- 
1.6.3.rc1.226.ga8d61c
