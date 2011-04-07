From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 7/9] sparse: Fix errors due to missing target-specific variables
Date: Thu, 07 Apr 2011 19:48:14 +0100
Message-ID: <4D9E06EE.9090803@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, bebarino@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 21:11:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7ucJ-0000ZQ-2E
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 21:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756705Ab1DGTLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 15:11:38 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:59419 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756695Ab1DGTLh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Apr 2011 15:11:37 -0400
X-Greylist: delayed 1113 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Apr 2011 15:11:37 EDT
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1Q7uKq-0002Xh-hi; Thu, 07 Apr 2011 18:53:41 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171079>


In particular, sparse issues the following errors:

    attr.c:472:43: error: undefined identifier 'ETC_GITATTRIBUTES'
    config.c:821:43: error: undefined identifier 'ETC_GITCONFIG'
    exec_cmd.c:14:37: error: undefined identifier 'PREFIX'
    exec_cmd.c:83:28: error: undefined identifier 'GIT_EXEC_PATH'
    builtin/help.c:328:46: error: undefined identifier 'GIT_MAN_PATH'
    builtin/help.c:374:40: error: undefined identifier 'GIT_INFO_PATH'
    builtin/help.c:382:45: error: undefined identifier 'GIT_HTML_PATH'
    git.c:96:42: error: undefined identifier 'GIT_HTML_PATH'
    git.c:241:35: error: invalid initializer
    http.c:293:43: error: undefined identifier 'GIT_HTTP_USER_AGENT'

which is caused by not passing the target-specific additions to
the EXTRA_CPPFLAGS variable to cgcc.

In order to fix the problem, we define a new sparse target which
depends on an a set of non-existent "sparse object" files (*.sp)
which correspond to the set of C source files. In addition to the
new target, we also provide a new pattern rule for "creating" the
sparse object files from the source files by running cgcc.  This
allows us to add '*.sp' to the rules setting the target-specific
EXTRA_CPPFLAGS variable, which is then included in the new pattern
rule to run cgcc.

Also, we change the 'check' target to re-direct the user to the
new sparse target.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Also, note the use of $(C_OBJ) rather than $(GIT_OBJS) when setting
the $(SP_OBJ) sparse objects; this leads to some additional C source
files being run through sparse. (Namely the files in the xdiff and
vcs-svn directories)

 Makefile |   40 +++++++++++++++++++++++++---------------
 1 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index 2a100b7..4b03b8a 100644
--- a/Makefile
+++ b/Makefile
@@ -1581,6 +1581,7 @@ ifndef V
 	QUIET_LNCP     = @echo '   ' LN/CP $@;
 	QUIET_XGETTEXT = @echo '   ' XGETTEXT $@;
 	QUIET_GCOV     = @echo '   ' GCOV $@;
+	QUIET_SP       = @echo '   ' SP $<;
 	QUIET_SUBDIR0  = +@subdir=
 	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
 			 $(MAKE) $(PRINT_DIR) -C $$subdir
@@ -1676,7 +1677,7 @@ strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
 
 git.o: common-cmds.h
-git.s git.o: EXTRA_CPPFLAGS = -DGIT_VERSION='"$(GIT_VERSION)"' \
+git.sp git.s git.o: EXTRA_CPPFLAGS = -DGIT_VERSION='"$(GIT_VERSION)"' \
 	'-DGIT_HTML_PATH="$(htmldir_SQ)"'
 
 git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
@@ -1686,7 +1687,7 @@ git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
 help.o: common-cmds.h
 
 builtin/help.o: common-cmds.h
-builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
+builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_SQ)"'
@@ -1972,30 +1973,34 @@ $(VCSSVN_OBJS) $(VCSSVN_TEST_OBJS): $(LIB_H) \
 test-svn-fe.o: vcs-svn/svndump.h
 endif
 
-exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
+exec_cmd.sp exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
 	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
 	'-DBINDIR="$(bindir_relative_SQ)"' \
 	'-DPREFIX="$(prefix_SQ)"'
 
-builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS = \
+builtin/init-db.sp builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS = \
 	-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"'
 
-config.s config.o: EXTRA_CPPFLAGS = -DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"'
+config.sp config.s config.o: EXTRA_CPPFLAGS = \
+	-DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"'
 
-attr.s attr.o: EXTRA_CPPFLAGS = -DETC_GITATTRIBUTES='"$(ETC_GITATTRIBUTES_SQ)"'
+attr.sp attr.s attr.o: EXTRA_CPPFLAGS = \
+	-DETC_GITATTRIBUTES='"$(ETC_GITATTRIBUTES_SQ)"'
 
-http.s http.o: EXTRA_CPPFLAGS = -DGIT_HTTP_USER_AGENT='"git/$(GIT_VERSION)"'
+http.sp http.s http.o: EXTRA_CPPFLAGS = \
+	-DGIT_HTTP_USER_AGENT='"git/$(GIT_VERSION)"'
 
 ifdef NO_EXPAT
-http-walker.s http-walker.o: EXTRA_CPPFLAGS = -DNO_EXPAT
+http-walker.sp http-walker.s http-walker.o: EXTRA_CPPFLAGS = -DNO_EXPAT
 endif
 
 ifdef NO_REGEX
-compat/regex/regex.o: EXTRA_CPPFLAGS = -DGAWK -DNO_MBSUPPORT
+compat/regex/regex.sp compat/regex/regex.o: EXTRA_CPPFLAGS = \
+	-DGAWK -DNO_MBSUPPORT
 endif
 
 ifdef USE_NED_ALLOCATOR
-compat/nedmalloc/nedmalloc.o: EXTRA_CPPFLAGS = \
+compat/nedmalloc/nedmalloc.sp compat/nedmalloc/nedmalloc.o: EXTRA_CPPFLAGS = \
 	-DNDEBUG -DOVERRIDE_STRDUP -DREPLACE_SYSTEM_ALLOCATOR
 endif
 
@@ -2160,14 +2165,19 @@ test-%$X: test-%.o $(GITLIBS)
 check-sha1:: test-sha1$X
 	./test-sha1.sh
 
+SP_OBJ = $(patsubst %.o,%.sp,$(C_OBJ))
+
+%.sp: %.c GIT-CFLAGS FORCE
+	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
+		$(SPARSE_FLAGS) $<
+
+sparse: $(SP_OBJ)
+
 check: common-cmds.h
 	@if sparse; \
 	then \
-		for i in $(patsubst %.o, %.c, $(GIT_OBJS)); \
-		do \
-			echo '   ' SP $$i; \
-			cgcc -no-compile $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i || exit; \
-		done; \
+		echo 2>&1 "Use 'make sparse' instead"; \
+		$(MAKE) --no-print-directory sparse; \
 	else \
 		echo 2>&1 "Did you mean 'make test'?"; \
 		exit 1; \
-- 
1.7.4
