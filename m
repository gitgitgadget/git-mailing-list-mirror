From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] Makefile: make mandir, htmldir and infodir absolute
Date: Sun, 24 Feb 2013 19:55:01 +0000
Message-ID: <20130224195500.GA27578@serenity.lan>
References: <cover.1360700102.git.john@keeping.me.uk>
 <20130212222508.GG12240@google.com>
 <7vmwv9ducx.fsf@alter.siamese.dyndns.org>
 <7vip5xdtt6.fsf@alter.siamese.dyndns.org>
 <7vehgldt8e.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 20:55:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9hft-0006AQ-9o
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 20:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758602Ab3BXTz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 14:55:29 -0500
Received: from pichi.aluminati.org ([72.9.246.58]:52947 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757127Ab3BXTz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 14:55:28 -0500
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 96501161E3A7;
	Sun, 24 Feb 2013 19:55:27 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V-Pt9VLOBNMf; Sun, 24 Feb 2013 19:55:15 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id DCC15161E11D;
	Sun, 24 Feb 2013 19:55:07 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vehgldt8e.fsf_-_@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217000>

This matches the use of the variables with the same names in autotools,
reducing the potential for user surprise.

Using relative paths in these variables also causes issues if they are
exported from the Makefile, as discussed in commit c09d62f (Makefile: do
not export mandir/htmldir/infodir, 2013-02-12).

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: John Keeping <john@keeping.me.uk>
---
On Tue, Feb 12, 2013 at 03:09:53PM -0800, Junio C Hamano wrote:
> A longer term fix is to introduce runtime_{man,html,info}dir variables
> to hold these funny values, and make {man,html,info}dir variables
> to have real paths whose default values begin with $(prefix), but
> as a first step, stop exporting them from the top-level Makefile.

Here's an attempt at doing that.

If this is sensible, should bindir_relative be calculated in the same
way?

 Makefile | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index 7c75e3b..087eec4 100644
--- a/Makefile
+++ b/Makefile
@@ -360,33 +360,39 @@ STRIP ?= strip
 # Among the variables below, these:
 #   gitexecdir
 #   template_dir
-#   mandir
-#   infodir
-#   htmldir
 #   sysconfdir
 # can be specified as a relative path some/where/else;
 # this is interpreted as relative to $(prefix) and "git" at
 # runtime figures out where they are based on the path to the executable.
+# Additionally, the following will be treated as relative by "git" if they
+# begin with "$(prefix)/":
+#   mandir
+#   infodir
+#   htmldir
 # This can help installing the suite in a relocatable way.
 
 prefix = $(HOME)
 bindir_relative = bin
 bindir = $(prefix)/$(bindir_relative)
-mandir = share/man
-infodir = share/info
+mandir = $(prefix)/share/man
+infodir = $(prefix)/share/info
 gitexecdir = libexec/git-core
 mergetoolsdir = $(gitexecdir)/mergetools
 sharedir = $(prefix)/share
 gitwebdir = $(sharedir)/gitweb
 localedir = $(sharedir)/locale
 template_dir = share/git-core/templates
-htmldir = share/doc/git-doc
+htmldir = $(prefix)/share/doc/git-doc
 ETC_GITCONFIG = $(sysconfdir)/gitconfig
 ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
 lib = lib
 # DESTDIR =
 pathsep = :
 
+mandir_relative = $(patsubst $(prefix)/%,%,$(mandir))
+infodir_relative = $(patsubst $(prefix)/%,%,$(infodir))
+htmldir_relative = $(patsubst $(prefix)/%,%,$(htmldir))
+
 export prefix bindir sharedir sysconfdir gitwebdir localedir
 
 CC = cc
@@ -1548,12 +1554,12 @@ ETC_GITATTRIBUTES_SQ = $(subst ','\'',$(ETC_GITATTRIBUTES))
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 bindir_SQ = $(subst ','\'',$(bindir))
 bindir_relative_SQ = $(subst ','\'',$(bindir_relative))
-mandir_SQ = $(subst ','\'',$(mandir))
-infodir_SQ = $(subst ','\'',$(infodir))
+mandir_relative_SQ = $(subst ','\'',$(mandir_relative))
+infodir_relative_SQ = $(subst ','\'',$(infodir_relative))
 localedir_SQ = $(subst ','\'',$(localedir))
 gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
 template_dir_SQ = $(subst ','\'',$(template_dir))
-htmldir_SQ = $(subst ','\'',$(htmldir))
+htmldir_relative_SQ = $(subst ','\'',$(htmldir_relative))
 prefix_SQ = $(subst ','\'',$(prefix))
 gitwebdir_SQ = $(subst ','\'',$(gitwebdir))
 
@@ -1685,9 +1691,9 @@ strip: $(PROGRAMS) git$X
 
 git.sp git.s git.o: GIT-PREFIX
 git.sp git.s git.o: EXTRA_CPPFLAGS = \
-	'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
-	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
-	'-DGIT_INFO_PATH="$(infodir_SQ)"'
+	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
+	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
+	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
 
 git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
@@ -1697,9 +1703,9 @@ help.sp help.s help.o: common-cmds.h
 
 builtin/help.sp builtin/help.s builtin/help.o: common-cmds.h GIT-PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
-	'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
-	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
-	'-DGIT_INFO_PATH="$(infodir_SQ)"'
+	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
+	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
+	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
 
 version.sp version.s version.o: GIT-VERSION-FILE GIT-USER-AGENT
 version.sp version.s version.o: EXTRA_CPPFLAGS = \
-- 
1.8.2.rc0.248.g2dab8ff
