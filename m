From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 2/2] Makefile: automatically compute header dependencies
Date: Fri, 27 Nov 2009 11:50:43 -0600
Message-ID: <20091127175043.GC3461@progeny.tock>
References: <4B0F8825.3040107@viscovery.net>
 <alpine.DEB.1.00.0911271033460.4521@intel-tinevez-2-302>
 <20091127174558.GA3461@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 27 18:38:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE4mX-0000VJ-4O
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 18:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374AbZK0Ric (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 12:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752280AbZK0Ric
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 12:38:32 -0500
Received: from mail-gx0-f212.google.com ([209.85.217.212]:58317 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbZK0Rib (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 12:38:31 -0500
Received: by gxk4 with SMTP id 4so92132gxk.8
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 09:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=szPp6xY9W+DYTObxu3YR0lhMfu1mMlQRsnRCJWoX9GE=;
        b=rDwKl8xiBADf0pNC0SpF1bGihCGvdbLELuyuhNAjS4Qfu+qvMFcQLfQyBwERcifTqT
         1HmSR5wT0NMiZVRxVxXgSI/PwJHfi/52LlYWBviaWcGkwcsHnyZsGR2phJ3gLSzew0Tb
         JpdoUMmE4y9ysmKsg3OPnfC7glarmloUbyCSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BFY5Z0rwbvwH9vqDwMR6csSNzlYfs4EZ1xx1EyxMVE5DyQoRqJNaIV+wPkHi3Y8tcj
         TesJjdIVK0FpJwOMtOzfijHz+CxTvabOTBiQoo8OslVKOn7xcggC0Z4VhDTgyV6NZWaP
         vFVeqrdxjX0VN0XBsFO6LwnuLnAPD2o0g/ivQ=
Received: by 10.101.170.11 with SMTP id x11mr604002ano.109.1259343517833;
        Fri, 27 Nov 2009 09:38:37 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 8sm898825yxg.24.2009.11.27.09.38.36
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 27 Nov 2009 09:38:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091127174558.GA3461@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133913>

Use the gcc -MMD -MP -MF options to generate dependency rules as a
byproduct when building .o files.

A bit remains to be done:

 - add the same support to the .c.s rule
 - make this optional (not all compilers support this, and not all
   developers necessarily want to litter the directory with .*.o.d
   files)
 - document what gcc version introduced these options
 - find equivalent options for other compilers (e.g., Intel C,
   SunWSPro, MSVC)

but this should give the idea.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Good idea?  Bad idea?

Good night,
Jonathan

 .gitignore |    1 +
 Makefile   |   15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/.gitignore b/.gitignore
index ac02a58..c7b2736 100644
--- a/.gitignore
+++ b/.gitignore
@@ -170,6 +170,7 @@
 *.exe
 *.[aos]
 *.py[co]
+.*.o.d
 *+
 /config.mak
 /autom4te.cache
diff --git a/Makefile b/Makefile
index ed0f461..af3f874 100644
--- a/Makefile
+++ b/Makefile
@@ -488,6 +488,7 @@ LIB_H += unpack-trees.h
 LIB_H += userdiff.h
 LIB_H += utf8.h
 LIB_H += wt-status.h
+LIB_H :=
 
 LIB_OBJS += abspath.o
 LIB_OBJS += advice.o
@@ -1559,13 +1560,23 @@ git.o git.spec \
 	$(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	: GIT-VERSION-FILE
 
+dep_file = $(dir $@).$(notdir $@).d
+dep_args = -MF $(dep_file) -MMD -MP
+
 %.o: %.c GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
+	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(ALL_CFLAGS) $<
 %.s: %.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $<
 %.o: %.S
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
+objects := $(wildcard *.o block-sha1/*.o arm/*.o ppc/*.o \
+		compat/*.o compat/*/*.o xdiff/*.o)
+dep_files := $(wildcard $(foreach f,$(objects),$(dir $f).$(notdir $f).d))
+ifneq ($(dep_files),)
+include $(dep_files)
+endif
+
 exec_cmd.o: exec_cmd.c GIT-CFLAGS
 exec_cmd.o: ALL_CFLAGS += \
 	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
@@ -1875,6 +1886,8 @@ distclean: clean
 clean:
 	$(RM) *.o block-sha1/*.o arm/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o \
 		$(LIB_FILE) $(XDIFF_LIB)
+	$(RM) .*.o.d block-sha1/.*.o.d arm/.*.o.d ppc/.*.o.d compat/.*.o.d \
+		compat/*/.*.o.d xdiff/.*.o.d
 	$(RM) $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags cscope*
-- 
1.6.5.3
