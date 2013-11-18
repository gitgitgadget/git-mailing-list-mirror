From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2 v2] Makefile: rebuild perl scripts when perl paths change
Date: Mon, 18 Nov 2013 14:23:11 -0800
Message-ID: <20131118222311.GL27781@google.com>
References: <20131115210604.GC27781@google.com>
 <20131115210949.GD27781@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 18 23:23:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViXE1-0002xI-V5
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 23:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424Ab3KRWXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 17:23:17 -0500
Received: from mail-gg0-f172.google.com ([209.85.161.172]:63287 "EHLO
	mail-gg0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343Ab3KRWXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 17:23:16 -0500
Received: by mail-gg0-f172.google.com with SMTP id q6so949541ggc.3
        for <git@vger.kernel.org>; Mon, 18 Nov 2013 14:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BM+IZHMEriPjdIWu9b9CvH5niCp4IHAXkLwFiSVqMBQ=;
        b=k407obXsT6/rDt3uTB54K5ubuI5lrdL4K1Z3AlyWybTbMp3c3cUkf5KNBzCTN4uoyI
         sI/XId7oAt0un9M8ROes58iVR4fWJGXqiM9rRpUhk44yNJtVjJrU5RH9FrlLPuwH8K8P
         KuIgd5TGF/OzIPwEhcf48BikDH25qodxlrMWSRb3oVxXjpiSVXDKQmOlc+3ObdolEcQD
         cXmIkKOv1Yz7Eq2hPDbF5JTpyPHmrMHBBbBQOSjvIlquI6/LiGIIpu27Weo1O0B/Y8ty
         2cIonp8tR7c2aevC0nDVnGhpQscahqwycHG/i1HvquR6ZHykLGB2GFaeOEBWoWwSmk4H
         0Fyw==
X-Received: by 10.236.124.133 with SMTP id x5mr11394062yhh.59.1384813394601;
        Mon, 18 Nov 2013 14:23:14 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id d26sm30571453yhj.25.2013.11.18.14.23.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 Nov 2013 14:23:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131115210949.GD27781@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238019>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Change since v1:
- add GIT-PERL-DEFINES to .gitignore so it doesn't clutter up
  "git status" output

 .gitignore |  1 +
 Makefile   | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index 66199ed..a78367c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -2,6 +2,7 @@
 /GIT-CFLAGS
 /GIT-LDFLAGS
 /GIT-PREFIX
+/GIT-PERL-DEFINES
 /GIT-PYTHON-VARS
 /GIT-SCRIPT-DEFINES
 /GIT-USER-AGENT
diff --git a/Makefile b/Makefile
index af847f8..e5e7868 100644
--- a/Makefile
+++ b/Makefile
@@ -1792,7 +1792,8 @@ perl/PM.stamp: FORCE
 perl/perl.mak: GIT-CFLAGS GIT-PREFIX perl/Makefile perl/Makefile.PL
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
 
-$(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl GIT-VERSION-FILE
+PERL_DEFINES = $(PERL_PATH_SQ)
+$(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl perl/perl.mak GIT-PERL-DEFINES GIT-VERSION-FILE
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
 	sed -e '1{' \
@@ -1807,6 +1808,13 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl GIT-VERSION-FILE
 	chmod +x $@+ && \
 	mv $@+ $@
 
+GIT-PERL-DEFINES: FORCE
+	@FLAGS='$(PERL_DEFINES)'; \
+	    if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
+		echo >&2 "    * new perl-specific parameters"; \
+		echo "$$FLAGS" >$@; \
+	    fi
+
 
 .PHONY: gitweb
 gitweb:
@@ -2494,7 +2502,8 @@ ifndef NO_TCLTK
 	$(MAKE) -C git-gui clean
 endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-LDFLAGS GIT-BUILD-OPTIONS
-	$(RM) GIT-USER-AGENT GIT-PREFIX GIT-SCRIPT-DEFINES GIT-PYTHON-VARS
+	$(RM) GIT-USER-AGENT GIT-PREFIX
+	$(RM) GIT-SCRIPT-DEFINES GIT-PERL-DEFINES GIT-PYTHON-VARS
 
 .PHONY: all install profile-clean clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
-- 
1.8.4.1
