From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix generation of perl/perl.mak
Date: Thu, 25 Oct 2007 22:17:24 +0200
Message-ID: <20071025201724.GA11308@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 22:18:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il99M-0000qQ-SR
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 22:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbXJYUR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 16:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbXJYUR3
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 16:17:29 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:41068 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbXJYUR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 16:17:28 -0400
Received: from tigra.home (Fadec.f.strato-dslnet.de [195.4.173.236])
	by post.webmailer.de (mrclete mo33) (RZmta 14.0)
	with ESMTP id c01b90j9PIOIoH ; Thu, 25 Oct 2007 22:17:25 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 74C0E277AE;
	Thu, 25 Oct 2007 22:17:25 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id D807456D22; Thu, 25 Oct 2007 22:17:24 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClJ2mEU=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62365>

The code generating perl/Makefile from Makefile.PL was causing trouble
because it didn't considered NO_PERL_MAKEMAKER and ran makemaker
unconditionally, rewriting perl.mak. Makemaker is FUBAR in ActiveState Perl,
and perl/Makefile has a replacement for it.

Besides, a changed Git.pm is *NOT* a reason to rebuild all the perl scripts,
so remove the dependency too.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 Makefile |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index b728920..72f5ef4 100644
--- a/Makefile
+++ b/Makefile
@@ -812,7 +812,7 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 
 $(patsubst %.perl,%,$(SCRIPT_PERL)): perl/perl.mak
 
-perl/perl.mak: GIT-CFLAGS
+perl/perl.mak: GIT-CFLAGS perl/Makefile perl/Makefile.PL
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
 
 $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
@@ -931,10 +931,6 @@ $(XDIFF_LIB): $(XDIFF_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(XDIFF_OBJS)
 
 
-perl/Makefile: perl/Git.pm perl/Makefile.PL GIT-CFLAGS
-	(cd perl && $(PERL_PATH) Makefile.PL \
-		PREFIX='$(prefix_SQ)')
-
 doc:
 	$(MAKE) -C Documentation all
 
-- 
1.5.3.4.403.g401f6
