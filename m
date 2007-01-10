From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Makefile: add clean-obsolete-scripts target
Date: Wed, 10 Jan 2007 12:22:57 -0800
Message-ID: <7vhcuyaaxq.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0701101319480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 21:23:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4jyf-0001Hd-FL
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 21:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbXAJUXO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 15:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbXAJUXO
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 15:23:14 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:34956 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965079AbXAJUXN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 15:23:13 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070110202313.RMEC7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Wed, 10 Jan 2007 15:23:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9YNN1W00B1kojtg0000000; Wed, 10 Jan 2007 15:22:22 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701101319480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 10 Jan 2007 13:20:19 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36529>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Cygwin, newly builtins are not recognized, because there exist both
> the executable binaries (with .exe extension) _and_ the now-obsolete
> scripts (without extension), but the script is executed.
>
> "make clean-obsolete-scripts" removes these ambiguities by removing the
> older of these file pairs.

I would prefer it to be rather automatic -- how about this instead?

-- >8 --
diff --git a/Makefile b/Makefile
index e4f520a..9077941 100644
--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,5 @@
 # The default target of this Makefile is...
-all:
+all::
 
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
 # This also implies MOZILLA_SHA1.
@@ -605,9 +605,12 @@ export prefix TAR INSTALL DESTDIR SHELL_PATH template_dir
 
 ### Build rules
 
-all: $(ALL_PROGRAMS) $(BUILT_INS) git$X gitk gitweb/gitweb.cgi
+all:: $(ALL_PROGRAMS) $(BUILT_INS) git$X gitk gitweb/gitweb.cgi
+ifneq (,$X)
+	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), echo rm -f '$p';) 
+endif
 
-all:
+all::
 	$(MAKE) -C perl PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' all
 	$(MAKE) -C templates
 
@@ -849,6 +852,9 @@ install: all
 			'$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X'; \
 	fi
 	$(foreach p,$(BUILT_INS), rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
+ifneq (,$X)
+	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), echo rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p';) 
+endif
 
 install-doc:
 	$(MAKE) -C Documentation install
