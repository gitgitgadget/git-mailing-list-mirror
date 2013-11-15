From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] Makefile: add PERLLIB_EXTRA variable that adds to
 default perl path
Date: Fri, 15 Nov 2013 13:10:28 -0800
Message-ID: <20131115211028.GE27781@google.com>
References: <20131115210604.GC27781@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 15 22:10:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhQey-0004cD-6u
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 22:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112Ab3KOVKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 16:10:33 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:57934 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab3KOVKb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Nov 2013 16:10:31 -0500
Received: by mail-yh0-f49.google.com with SMTP id b6so571956yha.36
        for <git@vger.kernel.org>; Fri, 15 Nov 2013 13:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zsAWOYhPkUJ2adoqWmyXf0fTKerUL236RCLbUGGr1gg=;
        b=XPO2KXWp/suYuOo1gGpzkR5FcgmbBRplA/ctMyeCWIitF1V7QO4NjsTlAIQOqMaXG8
         IjjFBv0tbgCUsnyz4wM6IC9DQivktkqveT/xmA8/I+IsieECEsJuH+prhs/P94TE4DrB
         k4KK2i1hI0+JraOlJJIpjkCTe8d88P8Ud+F+F6ifXEOeFynQlh0QlwT5S+0cEFe9PJZI
         U5jiu0S4OnauyJvOtBiw/47EyFV3v9qe6ZAv4761k+CnVt4e16QKGTMG6RpNFcdvPYex
         PcwxIcwBonotAuFs78g5Hfp9m+RC51YxRiloPxluy++yLDskHHjF0P6tjC59KZVlSR9B
         krvA==
X-Received: by 10.236.66.198 with SMTP id h46mr1158263yhd.227.1384549831289;
        Fri, 15 Nov 2013 13:10:31 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id v22sm7398872yhn.12.2013.11.15.13.10.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 15 Nov 2013 13:10:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131115210604.GC27781@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237917>

Some platforms ship Perl modules used by git scripts outside the
default perl path (e.g., on Mac OS X, Subversion's perl bindings live
in a separate xcode perl path).  Add an PERLLIB_EXTRA variable to hold
a colon-separated list of extra directories to add to the perl path in
git's scripts, as a convenience for packagers.

Requested-by: Dave Borowitz <dborowitz@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for reading.

 Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e5e7868..67f1754 100644
--- a/Makefile
+++ b/Makefile
@@ -1588,6 +1588,7 @@ PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 PYTHON_PATH_SQ = $(subst ','\'',$(PYTHON_PATH))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 DIFF_SQ = $(subst ','\'',$(DIFF))
+PERLLIB_EXTRA_SQ = $(subst ','\'',$(PERLLIB_EXTRA))
 
 LIBS = $(GITLIBS) $(EXTLIBS)
 
@@ -1792,10 +1793,12 @@ perl/PM.stamp: FORCE
 perl/perl.mak: GIT-CFLAGS GIT-PREFIX perl/Makefile perl/Makefile.PL
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
 
-PERL_DEFINES = $(PERL_PATH_SQ)
+PERL_DEFINES = $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ)
 $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl perl/perl.mak GIT-PERL-DEFINES GIT-VERSION-FILE
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
+	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
+	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
 	sed -e '1{' \
 	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
 	    -e '	h' \
-- 
1.8.4.1
