From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH] Makefile: Check for perl script errors with perl -c
Date: Fri, 16 Apr 2010 20:29:40 -0600
Message-ID: <1271471380-17701-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Apr 17 04:35:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2xsr-0005SU-6K
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 04:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758348Ab0DQCfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 22:35:43 -0400
Received: from qmta13.emeryville.ca.mail.comcast.net ([76.96.27.243]:58865
	"EHLO qmta13.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758096Ab0DQCfm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Apr 2010 22:35:42 -0400
X-Greylist: delayed 349 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Apr 2010 22:35:42 EDT
Received: from omta05.emeryville.ca.mail.comcast.net ([76.96.30.43])
	by qmta13.emeryville.ca.mail.comcast.net with comcast
	id 6QMz1e0040vp7WLADSVu5U; Sat, 17 Apr 2010 02:29:54 +0000
Received: from mmogilvi.homeip.net ([67.190.99.184])
	by omta05.emeryville.ca.mail.comcast.net with comcast
	id 6SVs1e00M3yhxvF8RSVtvo; Sat, 17 Apr 2010 02:29:53 +0000
Received: from localhost.localdomain (rand.mmogilvi.local [192.168.30.68])
	by mmogilvi.homeip.net (Postfix) with ESMTP id A1BE51E9625C;
	Fri, 16 Apr 2010 20:29:51 -0600 (MDT)
X-Mailer: git-send-email 1.7.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145109>

This allows you to notice trivial syntax errors in perl scripts earlier,
for example before running t/* tests that generate a lot of
separate errors.

You have to set USE_PERL_CHECK to enable this, because it uses
the non-standard PIPESTATUS bashism to grep out "{script} syntax OK"
useless noise.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---

I'm not sure anyone will think this is worth including, but I'm
used to "make" (and the compiler) detecting trivial errors
in compiled langauges, and was getting annoyed that it wasn't
doing something similar for perl scripts (especially since in git you
are really expected to "make" the scripts anyway).

The whole tradeoff between noise ("{script} syntax OK"), portability
(PIPESTATUS is a bashism), or really ugly contortions with redirecting
extra file descriptors (to avoid PIPESTATUS) seems to be the biggest
downside of the idea behind this patch.

--
Matthew Ogilvie   [mmogilvi_git@miniinfo.net]

 Makefile |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 910f471..1e827bb 100644
--- a/Makefile
+++ b/Makefile
@@ -168,6 +168,10 @@ all::
 #
 # Define NO_PERL if you do not want Perl scripts or libraries at all.
 #
+# Define USE_PERL_CHECK if you want the makefile to run "perl -cw" to
+# check perl scripts for basic errors.  This requires that your
+# $SHELL_PATH supports the ${PIPESTATUS[0]} variable, like bash.
+#
 # Define NO_PYTHON if you do not want Python scripts or libraries at all.
 #
 # Define NO_TCLTK if you do not want Tcl/Tk GUI.
@@ -1553,6 +1557,14 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    $@.perl >$@+ && \
 	chmod +x $@+ && \
+	if test x"$(USE_PERL_CHECK)" != x"" ; then \
+	    '$(PERL_PATH_SQ)' -cw $@+ 2>&1 | grep -v '^$@+ syntax OK$$' 1>&2 ; \
+	    perlStat="$${PIPESTATUS[0]}" && \
+	    if test x"$$perlStat" != x"0" ; then \
+	        echo '"$(PERL_PATH_SQ) -c $@+" failed' 1>&2 ; \
+	        exit "$$perlStat" ; \
+	    fi ; \
+	fi && \
 	mv $@+ $@
 
 
-- 
1.7.0.GIT
