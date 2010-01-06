From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/5] Makefile: use target-specific variable to pass flags
 to cc
Date: Wed, 6 Jan 2010 02:05:04 -0600
Message-ID: <20100106080504.GC7298@progeny.tock>
References: <20091128112546.GA10059@progeny.tock>
 <20091128113709.GD10059@progeny.tock>
 <20100106080216.GA7298@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 09:05:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSQtC-0002T3-UI
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 09:05:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858Ab0AFIFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 03:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754607Ab0AFIFF
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 03:05:05 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:55513 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754172Ab0AFIFC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 03:05:02 -0500
Received: by iwn32 with SMTP id 32so1438531iwn.33
        for <git@vger.kernel.org>; Wed, 06 Jan 2010 00:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Bt6gScPWPpM9Ec53raX+0EuiRqMCVqTwrHFzRra4gx8=;
        b=NkIZjJxaPc7CVrTYHSlNcR54ZuIe+7q5o4LYAcU/MfIQqaH7wGQVdIhL8rBFlH92vI
         /ZS9x+TgdkOA63XETkFjNsdBUXOzCPSuwCM6UcP6FPOvn67w+iXtRS3NVADzyESDxaBc
         W3RbzstjMuzLejJmyNx8zFOFNyrltJzLotbT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pJhxx+24XjkjdNPqOyyz9V8lvFbAryVIL8INzX9nppKBl20zLrUNAPmRXzHilZ3FYe
         GT1EqreswTuJdTuBn/BCBNHTOxMBuKRzu0+LCjZxDo/1EzzhxZDk7SQ7/YnGQw5/oTxz
         SOYmHu+lE+er8XkBzfGGBMLpcwnu8gVhQr8sY=
Received: by 10.231.5.23 with SMTP id 23mr1904328ibt.45.1262765102341;
        Wed, 06 Jan 2010 00:05:02 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm19378233iwn.1.2010.01.06.00.05.01
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Jan 2010 00:05:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100106080216.GA7298@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows reusing the standard %.o: %.c pattern rule even for
targets that require special flags to be set.  Thus after this
change, any changes in the command for compilation only have to
be performed in one place.

Target-specific variables have been supported in GNU make since
version 3.77, which has been available since 1998.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile |   41 ++++++++++++++++++-----------------------
 1 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/Makefile b/Makefile
index ba4d071..81190a6 100644
--- a/Makefile
+++ b/Makefile
@@ -1467,20 +1467,19 @@ shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
 strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
 
-git.o: git.c common-cmds.h GIT-CFLAGS
-	$(QUIET_CC)$(CC) -DGIT_VERSION='"$(GIT_VERSION)"' \
-		'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
-		$(ALL_CFLAGS) -o $@ -c $(filter %.c,$^)
+git.o: common-cmds.h
+git.o: ALL_CFLAGS += -DGIT_VERSION='"$(GIT_VERSION)"' \
+	'-DGIT_HTML_PATH="$(htmldir_SQ)"'
 
 git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
-builtin-help.o: builtin-help.c common-cmds.h GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) \
-		'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
-		'-DGIT_MAN_PATH="$(mandir_SQ)"' \
-		'-DGIT_INFO_PATH="$(infodir_SQ)"' $<
+builtin-help.o: common-cmds.h
+builtin-help.o: ALL_CFLAGS += \
+	'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
+	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
+	'-DGIT_INFO_PATH="$(infodir_SQ)"'
 
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && \
@@ -1638,25 +1637,21 @@ git.o git.spec \
 %.o: %.S
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
-exec_cmd.o: exec_cmd.c GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) \
-		'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
-		'-DBINDIR="$(bindir_relative_SQ)"' \
-		'-DPREFIX="$(prefix_SQ)"' \
-		$<
+exec_cmd.o: ALL_CFLAGS += \
+	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
+	'-DBINDIR="$(bindir_relative_SQ)"' \
+	'-DPREFIX="$(prefix_SQ)"'
 
-builtin-init-db.o: builtin-init-db.c GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"' $<
+builtin-init-db.o: ALL_CFLAGS += \
+	-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"'
 
-config.o: config.c GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"' $<
+config.o: ALL_CFLAGS += -DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"'
 
-http.o: http.c GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DGIT_USER_AGENT='"git/$(GIT_VERSION)"' $<
+http.o: ALL_CFLAGS += -DGIT_USER_AGENT='"git/$(GIT_VERSION)"'
 
 ifdef NO_EXPAT
-http-walker.o: http-walker.c http.h GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DNO_EXPAT $<
+http-walker.o: http.h
+http-walker.o: ALL_CFLAGS += -DNO_EXPAT
 endif
 
 git-%$X: %.o $(GITLIBS)
-- 
1.6.6.rc2
