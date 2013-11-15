From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] Makefile: rebuild perl scripts when perl paths change
Date: Fri, 15 Nov 2013 13:09:49 -0800
Message-ID: <20131115210949.GD27781@google.com>
References: <20131115210604.GC27781@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 15 22:10:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhQeM-0004ED-ND
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 22:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407Ab3KOVJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 16:09:55 -0500
Received: from mail-yh0-f53.google.com ([209.85.213.53]:65315 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab3KOVJy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Nov 2013 16:09:54 -0500
Received: by mail-yh0-f53.google.com with SMTP id b20so275069yha.12
        for <git@vger.kernel.org>; Fri, 15 Nov 2013 13:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7kkgRzSNCmocPnH3gjQ24v8bCcjkIwjN3xe6qlRlypg=;
        b=i+SJneDQoj9AU4DGQmBKY9E/fEtyU+yPfalxhGvg7r14DYvMZ1/LFc2+A7JGAGPKjM
         38YYvJ8n5I3cFev9eZNJU10RnwW3KBdhIz9T2bf501aChQ6Wb90FqU3bwnaB5lCNkqkl
         DaR6wAWtrV5+Gc9m1OamTjrVGEl1Pjvpwk6vlREaZIWEo+avFHa/9O/6hLR9BdUajhXv
         YRrgh3ebeCJOEkstYlFNsW+IMVZ877mrPrk2K9kLRh0wSi1m35gpiuVYtbiTC57lyfR7
         QahEnaxA7Sus85h6da0Os2ppLdH9d6eoOVHArVSQ5WlHWZlScqot5W7JUTtC/cTcOQzt
         V+yg==
X-Received: by 10.236.0.193 with SMTP id 41mr2246142yhb.82.1384549793380;
        Fri, 15 Nov 2013 13:09:53 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id w8sm7407114yhg.8.2013.11.15.13.09.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 15 Nov 2013 13:09:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131115210604.GC27781@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237916>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

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
