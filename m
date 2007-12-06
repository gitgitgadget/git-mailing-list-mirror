From: Sergei Organov <osv@javad.com>
Subject: [PATCH] Let git-help prefer man-pages installed with this version of git
Date: Thu, 6 Dec 2007 21:33:01 +0300
Message-ID: <87hciv7jkt.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 06 19:41:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Leg-0000fi-VA
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 19:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbXLFSkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 13:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbXLFSkm
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 13:40:42 -0500
Received: from javad.com ([216.122.176.236]:1465 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751415AbXLFSkl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 13:40:41 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lB6IeeU12275;
	Thu, 6 Dec 2007 18:40:40 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1J0LeE-0000vC-A7; Thu, 06 Dec 2007 21:40:34 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67317>

Prepend $(prefix)/share/man to the MANPATH environment variable
before invoking 'man' from help.c:show_man_page().

Signed-off-by: Sergei Organov <osv@javad.com>
---
 Makefile |    5 ++++-
 help.c   |   21 +++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 999391e..3030d31 100644
--- a/Makefile
+++ b/Makefile
@@ -154,6 +154,7 @@ STRIP ?= strip
 
 prefix = $(HOME)
 bindir = $(prefix)/bin
+mandir = $(prefix)/share/man
 gitexecdir = $(bindir)
 sharedir = $(prefix)/share
 template_dir = $(sharedir)/git-core/templates
@@ -744,6 +745,7 @@ ETC_GITCONFIG_SQ = $(subst ','\'',$(ETC_GITCONFIG))
 
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 bindir_SQ = $(subst ','\'',$(bindir))
+mandir_SQ = $(subst ','\'',$(mandir))
 gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
 template_dir_SQ = $(subst ','\'',$(template_dir))
 prefix_SQ = $(subst ','\'',$(prefix))
@@ -790,7 +792,8 @@ git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
-help.o: common-cmds.h
+help.o: help.c common-cmds.h GIT-CFLAGS
+	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) '-DGIT_MAN_PATH="$(mandir_SQ)"' $<
 
 git-merge-subtree$X: git-merge-recursive$X
 	$(QUIET_BUILT_IN)$(RM) $@ && ln git-merge-recursive$X $@
diff --git a/help.c b/help.c
index 37a9c25..9f843c9 100644
--- a/help.c
+++ b/help.c
@@ -8,6 +8,8 @@
 #include "exec_cmd.h"
 #include "common-cmds.h"
 
+static const char *builtin_man_path = GIT_MAN_PATH;
+
 /* most GUI terminals set COLUMNS (although some don't export it) */
 static int term_columns(void)
 {
@@ -239,6 +241,24 @@ void list_common_cmds_help(void)
 	}
 }
 
+static void setup_man_path(void)
+{
+	const char *old_path = getenv("MANPATH");
+	struct strbuf new_path;
+
+	strbuf_init(&new_path, 0);
+
+	strbuf_addstr(&new_path, builtin_man_path);
+	if (old_path) {
+		strbuf_addch(&new_path, ':');
+		strbuf_addstr(&new_path, old_path);
+	}
+
+	setenv("MANPATH", new_path.buf, 1);
+
+	strbuf_release(&new_path);
+}
+
 static void show_man_page(const char *git_cmd)
 {
 	const char *page;
@@ -254,6 +274,7 @@ static void show_man_page(const char *git_cmd)
 		page = p;
 	}
 
+	setup_man_path();
 	execlp("man", "man", page, NULL);
 }
 
-- 
1.5.3.4
