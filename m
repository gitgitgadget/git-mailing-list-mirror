From: Fredrik Kuivinen <frekui@gmail.com>
Subject: [PATCH v2] Makefile: Track changes to LDFLAGS and relink when necessary
Date: Wed, 22 Jun 2011 12:50:56 +0200
Message-ID: <1308739856-2726-1-git-send-email-frekui@gmail.com>
Cc: Fredrik Kuivinen <frekui@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 22 12:51:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZL1d-0000S2-Tq
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 12:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756602Ab1FVKvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 06:51:08 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54817 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755972Ab1FVKvG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 06:51:06 -0400
Received: by bwz15 with SMTP id 15so610237bwz.19
        for <git@vger.kernel.org>; Wed, 22 Jun 2011 03:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=P9cqEyBgRJx6icsWJ+b74RbP17ScHrHf6RmciWLZXy0=;
        b=u3qz69hnK2gF1A4MH8Hyvau69Bbc6cisDZytWkzwqkD0IKq0/QXYDacohsj1qRKF0I
         fLE2iWr4G9gJ8hRpUyOIA81dWtsOD0nvv1SgnhH/Ue0jH53+eEsmZEGR+dgLm3QE1S1Y
         bgSkdxIba4ekAPu1A1OHMjvB4v3XcFX8pL+MM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=U6YXCzsZjilTxg83FwxJ9gBOndcuMOYE91jLdbE2Qd5kEnKuBasPxkAnSfa7AScIlM
         Nn9ytBzaAfTqlBbzIKbqDob4M1/F7YYK6Pkdf6sRA7o7ZQvqbtyYB0SeL8rYxozXVoGw
         UUFUVUcb7mU4BVBxTC2TO77LQFEkFbxzQG7kM=
Received: by 10.204.33.138 with SMTP id h10mr253bkd.159.1308739865403;
        Wed, 22 Jun 2011 03:51:05 -0700 (PDT)
Received: from localhost.localdomain (c83-250-151-53.bredband.comhem.se [83.250.151.53])
        by mx.google.com with ESMTPS id r19sm69234bkr.14.2011.06.22.03.51.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Jun 2011 03:51:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.3.368.g8b1b7.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176234>

Some profiling tools (e.g., google-perftools and mutrace) work by
linking in a new library into the executables. When using these tools
it is convenient to only relink instead of doing a full make clean;
make cycle.

This change complements the auto-detection of changes to CFLAGS that
we already have. Tracking of more variables that affect the build can
be added when the need arise.

Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>
---
 .gitignore |    1 +
 Makefile   |   25 +++++++++++++++++--------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/.gitignore b/.gitignore
index acffdfa..8572c8c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,5 +1,6 @@
 /GIT-BUILD-OPTIONS
 /GIT-CFLAGS
+/GIT-LDFLAGS
 /GIT-GUI-VARS
 /GIT-VERSION-FILE
 /bin-wrappers/
diff --git a/Makefile b/Makefile
index e40ac0c..75b407c 100644
--- a/Makefile
+++ b/Makefile
@@ -1706,7 +1706,7 @@ git.sp git.s git.o: EXTRA_CPPFLAGS = -DGIT_VERSION='"$(GIT_VERSION)"' \
 	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_SQ)"'
 
-git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
+git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
@@ -2004,17 +2004,17 @@ compat/nedmalloc/nedmalloc.sp compat/nedmalloc/nedmalloc.o: EXTRA_CPPFLAGS = \
 	-DNDEBUG -DOVERRIDE_STRDUP -DREPLACE_SYSTEM_ALLOCATOR
 endif
 
-git-%$X: %.o $(GITLIBS)
+git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
-git-imap-send$X: imap-send.o $(GITLIBS)
+git-imap-send$X: imap-send.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
 
-git-http-fetch$X: revision.o http.o http-walker.o http-fetch.o $(GITLIBS)
+git-http-fetch$X: revision.o http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL)
-git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
+git-http-push$X: revision.o http.o http-push.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
@@ -2024,7 +2024,7 @@ $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	ln -s $< $@ 2>/dev/null || \
 	cp $< $@
 
-$(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o $(GITLIBS)
+$(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
@@ -2094,6 +2094,15 @@ GIT-CFLAGS: FORCE
 		echo "$$FLAGS" >GIT-CFLAGS; \
             fi
 
+TRACK_LDFLAGS = $(subst ','\'',$(ALL_LDFLAGS))
+
+GIT-LDFLAGS: FORCE
+	@FLAGS='$(TRACK_LDFLAGS)'; \
+	    if test x"$$FLAGS" != x"`cat GIT-LDFLAGS 2>/dev/null`" ; then \
+		echo 1>&2 "    * new link flags"; \
+		echo "$$FLAGS" >GIT-LDFLAGS; \
+            fi
+
 # We need to apply sq twice, once to protect from the shell
 # that runs GIT-BUILD-OPTIONS, and then again to protect it
 # and the first level quoting from the shell that runs "echo".
@@ -2165,7 +2174,7 @@ test-svn-fe$X: vcs-svn/lib.a
 
 .PRECIOUS: $(TEST_OBJS)
 
-test-%$X: test-%.o $(GITLIBS)
+test-%$X: test-%.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
 check-sha1:: test-sha1$X
@@ -2375,7 +2384,7 @@ ifndef NO_TCLTK
 	$(MAKE) -C gitk-git clean
 	$(MAKE) -C git-gui clean
 endif
-	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-GUI-VARS GIT-BUILD-OPTIONS
+	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-LDFLAGS GIT-GUI-VARS GIT-BUILD-OPTIONS
 
 .PHONY: all install clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
-- 
1.7.5.3.368.g8b1b7.dirty
