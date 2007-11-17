From: Junio C Hamano <junio@pobox.com>
Subject: [Advance Warning PATCH] Move gitk to its own subdirectory
Date: Sat, 17 Nov 2007 11:15:20 -0800
Message-ID: <7vsl34u1iv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 17 20:15:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItT8p-0006Q4-Dl
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 20:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758857AbXKQTP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 14:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757611AbXKQTP0
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 14:15:26 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:48793 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756530AbXKQTPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 14:15:25 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 0D8902EF;
	Sat, 17 Nov 2007 14:15:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 5336696C86;
	Sat, 17 Nov 2007 14:15:44 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65296>

As some people may be aware, i18n effort for gitk has been
discussed and one requirement for that is to have separate
Makefile, or at least separate Makefile entries, to manage
message source files and rules to build and install them.

The plan is to stop merging gitk.git as a single file project
into git.git but instead use the subtree merge strategy into its
own subdirectory of git.git.  We can use subproject support in
the future, but once _a_ subproject is used that means the
project's history is not pullable with subproject unaware
versions of git anymore, so I'd avoid it for now.

This patch is just a preview to see reations from the list when
such a transtion should be made.  Earlier I mumbled "Let's slow
down for 1.5.4 freeze" on the list, but it seems that we do not
see -rc0 near the horizon yet.  I think transitions like this
should better be done sooner rather than later.

The mock gitk-git/Makefile entries in the following patch is
very minimum, and will need to be replaced with the real one
that we pull from Paul's gitk.git repository, along with the
i18n and any other goodies gitk.git will have.

-- >8 --
This is to prepare for gitk i18n effort that makes gitk not a single file
project anymore.  We may use subproject to bind git.git and gitk.git more
loosely in the future, but we do not want to require everybody to have
subproject aware git to be able to pull from git.git yet.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile              |   14 +++-----------
 gitk-git/Makefile     |   29 +++++++++++++++++++++++++++++
 gitk => gitk-git/gitk |    0 
 3 files changed, 32 insertions(+), 11 deletions(-)
 create mode 100644 gitk-git/Makefile
 rename gitk => gitk-git/gitk (100%)
 mode change 100755 => 100644

diff --git a/Makefile b/Makefile
index e830bc7..8110d36 100644
--- a/Makefile
+++ b/Makefile
@@ -270,9 +270,6 @@ ALL_PROGRAMS += git-merge-subtree$X
 
 # what 'all' will build but not install in gitexecdir
 OTHER_PROGRAMS = git$X gitweb/gitweb.cgi
-ifndef NO_TCLTK
-OTHER_PROGRAMS += gitk-wish
-endif
 
 # Set paths to tools early so that they can be used for version tests.
 ifndef SHELL_PATH
@@ -773,6 +770,7 @@ endif
 all::
 ifndef NO_TCLTK
 	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) all
+	$(QUIET_SUBDIR0)gitk-git $(QUIET_SUBDIR1) all
 endif
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' all
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1)
@@ -780,12 +778,6 @@ endif
 strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
 
-gitk-wish: gitk GIT-GUI-VARS
-	$(QUIET_GEN)$(RM) $@ $@+ && \
-	sed -e '1,3s|^exec .* "$$0"|exec $(subst |,'\|',$(TCLTK_PATH_SQ)) "$$0"|' <gitk >$@+ && \
-	chmod +x $@+ && \
-	mv -f $@+ $@
-
 git.o: git.c common-cmds.h GIT-CFLAGS
 	$(QUIET_CC)$(CC) -DGIT_VERSION='"$(GIT_VERSION)"' \
 		$(ALL_CFLAGS) -c $(filter %.c,$^)
@@ -1026,7 +1018,7 @@ install: all
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 	$(MAKE) -C perl prefix='$(prefix_SQ)' install
 ifndef NO_TCLTK
-	$(INSTALL) gitk-wish '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
+	$(MAKE) -C gitk-git install
 	$(MAKE) -C git-gui install
 endif
 	if test 'z$(bindir_SQ)' != 'z$(gitexecdir_SQ)'; \
@@ -1119,7 +1111,7 @@ clean:
 	$(MAKE) -C templates/ clean
 	$(MAKE) -C t/ clean
 ifndef NO_TCLTK
-	$(RM) gitk-wish
+	$(MAKE) -C gitk-git clean
 	$(MAKE) -C git-gui clean
 endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-GUI-VARS
diff --git a/gitk-git/Makefile b/gitk-git/Makefile
new file mode 100644
index 0000000..9bc1e24
--- /dev/null
+++ b/gitk-git/Makefile
@@ -0,0 +1,29 @@
+# The default target of this Makefile is...
+all::
+
+prefix ?= $(HOME)
+bindir ?= $(prefix)/bin
+TCLTK_PATH ?= wish
+INSTALL ?= install
+RM ?= rm -f
+
+DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
+bindir_SQ = $(subst ','\'',$(bindir))
+TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
+
+ifndef V
+	QUIET          = @
+	QUIET_GEN      = $(QUIET)echo '   ' GEN $@ &&
+endif
+
+all:: gitk-wish
+install:: all
+	$(INSTALL) gitk-wish '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
+clean::
+	$(RM) gitk-wish
+
+gitk-wish: gitk
+	$(QUIET_GEN)$(RM) $@ $@+ && \
+	sed -e '1,3s|^exec .* "$$0"|exec $(subst |,'\|',$(TCLTK_PATH_SQ)) "$$0"|' <gitk >$@+ && \
+	chmod +x $@+ && \
+	mv -f $@+ $@
diff --git a/gitk b/gitk-git/gitk
old mode 100755
new mode 100644
similarity index 100%
rename from gitk
rename to gitk-git/gitk
-- 
1.5.3.5.1806.g3e393
