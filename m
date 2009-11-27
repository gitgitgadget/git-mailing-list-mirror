From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 1/2] Makefile: use target-specific variable to pass
 flags to cc
Date: Fri, 27 Nov 2009 11:49:33 -0600
Message-ID: <20091127174932.GB3461@progeny.tock>
References: <4B0F8825.3040107@viscovery.net>
 <alpine.DEB.1.00.0911271033460.4521@intel-tinevez-2-302>
 <20091127174558.GA3461@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 27 18:37:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE4lB-0008Lz-Jh
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 18:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbZK0RhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 12:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbZK0RhW
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 12:37:22 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:40705 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbZK0RhV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 12:37:21 -0500
Received: by ywh12 with SMTP id 12so1848763ywh.21
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 09:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=fTBGp5pgSd3qpM0CMK961nyyj6+BQcADyEhxiU75F6k=;
        b=nhW5eBfIWRQW1snnmfQP7hXaNfYkmJDC3QttQry9aBRqLMAA4mQhYnxyq1PZqVBbJg
         ZwaKTGC0NUZFMvcivTEzZjFo4tPQd+hXrfP7dkSdk2lT2b58SHf13CLYAM3Z3jzV9tFg
         WlVYuiO/+mkmSWMRmKabcIu0nKnNxisfF1LV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Le/Ah1u2JtsBrWDE/wnnly1RDWVKUq+S2oE90JArjYOwEDhjbg26nNqkyMK7qzU2mc
         vjjkBfJ3zLF1SJfYSyYkeTgLGcrz2qTr5+dKTCVbZghkodWAzfH8e2rWs143QdlQwAgP
         axPlbp/4KZ7UaKf+cu1JVZR2wwK3YM2ACCSxA=
Received: by 10.150.65.21 with SMTP id n21mr2191837yba.89.1259343446447;
        Fri, 27 Nov 2009 09:37:26 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 15sm743982gxk.0.2009.11.27.09.37.25
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 27 Nov 2009 09:37:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091127174558.GA3461@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133912>

Remove some duplicated Makefile code by reusing the %.o: %.c rule
even for objects that need to be built with special flags.  This
makes the relevant -D parameters more prominent on the command
line and means any changes to the rules for compilation only have
to happen in one place.

Target-specific variables have been supported in GNU make since
version 3.77 from 1998.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile |   31 +++++++++++++++----------------
 1 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/Makefile b/Makefile
index 5a0b3d4..ed0f461 100644
--- a/Makefile
+++ b/Makefile
@@ -1440,19 +1440,18 @@ strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
 
 git.o: git.c common-cmds.h GIT-CFLAGS
-	$(QUIET_CC)$(CC) -DGIT_VERSION='"$(GIT_VERSION)"' \
-		'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
-		$(ALL_CFLAGS) -o $@ -c $(filter %.c,$^)
+git.o: ALL_CFLAGS += -DGIT_VERSION='"$(GIT_VERSION)"' \
+	'-DGIT_HTML_PATH="$(htmldir_SQ)"'
 
 git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
 builtin-help.o: builtin-help.c common-cmds.h GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) \
-		'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
-		'-DGIT_MAN_PATH="$(mandir_SQ)"' \
-		'-DGIT_INFO_PATH="$(infodir_SQ)"' $<
+builtin-help.o: ALL_CFLAGS += \
+	'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
+	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
+	'-DGIT_INFO_PATH="$(infodir_SQ)"'
 
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && \
@@ -1568,24 +1567,24 @@ git.o git.spec \
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
 exec_cmd.o: exec_cmd.c GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) \
-		'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
-		'-DBINDIR="$(bindir_relative_SQ)"' \
-		'-DPREFIX="$(prefix_SQ)"' \
-		$<
+exec_cmd.o: ALL_CFLAGS += \
+	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
+	'-DBINDIR="$(bindir_relative_SQ)"' \
+	'-DPREFIX="$(prefix_SQ)"'
 
 builtin-init-db.o: builtin-init-db.c GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"' $<
+builtin-init-db.o: ALL_CFLAGS += \
+	-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"'
 
 config.o: config.c GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"' $<
+config.o: ALL_CFLAGS += -DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"'
 
 http.o: http.c GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DGIT_USER_AGENT='"git/$(GIT_VERSION)"' $<
+http.o: ALL_CFLAGS += -DGIT_USER_AGENT='"git/$(GIT_VERSION)"'
 
 ifdef NO_EXPAT
 http-walker.o: http-walker.c http.h GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DNO_EXPAT $<
+http-walker.o: ALL_CFLAGS += -DNO_EXPAT
 endif
 
 git-%$X: %.o $(GITLIBS)
-- 
1.6.5.3
