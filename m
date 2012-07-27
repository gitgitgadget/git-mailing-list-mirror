From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 4/4] Move initialization of Git::SVN variables into
 Git::SVN.
Date: Fri, 27 Jul 2012 20:07:03 +0000
Message-ID: <20120727200703.GA2034@dcvr.yhbt.net>
References: <1343344945-3717-1-git-send-email-schwern@pobox.com>
 <1343344945-3717-5-git-send-email-schwern@pobox.com>
 <7vhast3hpb.fsf@alter.siamese.dyndns.org>
 <20120727053800.GC4685@burratino>
 <7v394d3ffc.fsf@alter.siamese.dyndns.org>
 <7vpq7h1z1q.fsf@alter.siamese.dyndns.org>
 <7vlii51xz4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Michael G. Schwern" <schwern@pobox.com>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 22:07:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Suqoa-0007Lw-QC
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 22:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627Ab2G0UHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 16:07:06 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60104 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752603Ab2G0UHE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 16:07:04 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 886061F5B3;
	Fri, 27 Jul 2012 20:07:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vlii51xz4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202374>

Junio C Hamano <gitster@pobox.com> wrote:
> What was happening was that originally, pu had ms/makefile-pl but
> not ms/git-svn-pm.  Hence, perl/Git/SVN.pm did not exist.  I ran
> "make" and it created perl/perl.mak that does not know about
> Git/SVN.pm;
> 
> Then ms/git-svn-pm is merged to pu and now we have perl/Git/SVN.pm.
> But there is nothing in ms/makefile-pl that says on what files
> perl.mak depends on.
> 
> I think there needs to be a dependency in to recreate perl/perl.mak
> when any of the *.pm files are changed, perhaps like this.
> 
> I am not sure why perl/perl.mak is built by the top-level Makefile,
> instead of just using "$(MAKE) -C perl/", though...

I'm not sure why perl/perl.mak is built by the top-level Makefile,
either.

I'll put the following after ms/makefile-pl but before ms/git-svn-pm:

>From a6ea2301d1bb6fd7c7415fed3aa7673542a563bd Mon Sep 17 00:00:00 2001
From: Junio C Hamano <gitster@pobox.com>
Date: Fri, 27 Jul 2012 20:04:20 +0000
Subject: [PATCH] perl: detect new files in MakeMaker builds

While Makefile.PL now finds .pm files on its own, it does not
detect new files after it generates perl/perl.mak.

[ew: commit message]

ref: http://mid.gmane.org/7vlii51xz4.fsf@alter.siamese.dyndns.org

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Makefile      | 7 +++++++
 perl/Makefile | 1 +
 2 files changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index b0b3493..e2a4ac7 100644
--- a/Makefile
+++ b/Makefile
@@ -2090,6 +2090,13 @@ $(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
 ifndef NO_PERL
 $(patsubst %.perl,%,$(SCRIPT_PERL)): perl/perl.mak
 
+perl/perl.mak: perl/PM.stamp
+
+perl/PM.stamp: FORCE
+	$(QUIET_GEN)find perl -type f -name '*.pm' | sort >$@+ && \
+	{ cmp $@+ $@ >/dev/null 2>/dev/null || mv $@+ $@; } && \
+	$(RM) $@+
+
 perl/perl.mak: GIT-CFLAGS GIT-PREFIX perl/Makefile perl/Makefile.PL
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
 
diff --git a/perl/Makefile b/perl/Makefile
index 8493d76..4969ef8 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -20,6 +20,7 @@ clean:
 	$(RM) ppport.h
 	$(RM) $(makfile)
 	$(RM) $(makfile).old
+	$(RM) PM.stamp
 
 ifdef NO_PERL_MAKEMAKER
 instdir_SQ = $(subst ','\'',$(prefix)/lib)
-- 
Eric Wong
