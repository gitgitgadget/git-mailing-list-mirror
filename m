From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] git-help: fix looking up html install dir when browsing.
Date: Fri, 7 Dec 2007 06:29:23 +0100
Message-ID: <20071207062923.6663a7d1.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Dec 07 06:23:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0VgN-0000jZ-PD
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 06:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbXLGFXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 00:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbXLGFXG
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 00:23:06 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:43404 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784AbXLGFXF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 00:23:05 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id A566D1AB2EF;
	Fri,  7 Dec 2007 06:22:58 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 675661AB2AB;
	Fri,  7 Dec 2007 06:22:58 +0100 (CET)
X-Mailer: Sylpheed 2.4.7 (GTK+ 2.12.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67379>

We used to search for the following directories:

	- $PREFIX/share/doc/git-doc
	- $PREFIX/share/doc/git-core-$GIT_VERSION

This was wrong because "htmldir" could be defined in the
Makefiles to something completely different.

So we now look for the $htlmdir directory first. But if
it fails we still fall back to the two above directories,
in case the script install and the html doc install have
been done with different $htmldir.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile           |    5 ++++-
 git-browse-help.sh |    4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

	Junio wrote:
	> People can set htmldir to somewhere other than
	> $(prefix)/share/doc/git-doc while building and
	> installing, but you are not telling the munged
	> script where it is.

	This should fix it.
	Thanks.

diff --git a/Makefile b/Makefile
index e9a119a..1e31f02 100644
--- a/Makefile
+++ b/Makefile
@@ -157,6 +157,7 @@ bindir = $(prefix)/bin
 gitexecdir = $(bindir)
 sharedir = $(prefix)/share
 template_dir = $(sharedir)/git-core/templates
+htmldir=$(sharedir)/doc/git-doc
 ifeq ($(prefix),/usr)
 sysconfdir = /etc
 else
@@ -183,7 +184,7 @@ GITWEB_FAVICON = git-favicon.png
 GITWEB_SITE_HEADER =
 GITWEB_SITE_FOOTER =
 
-export prefix bindir gitexecdir sharedir template_dir sysconfdir
+export prefix bindir gitexecdir sharedir template_dir htmldir sysconfdir
 
 CC = gcc
 AR = ar
@@ -747,6 +748,7 @@ DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 bindir_SQ = $(subst ','\'',$(bindir))
 gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
 template_dir_SQ = $(subst ','\'',$(template_dir))
+htmldir_SQ = $(subst ','\'',$(htmldir))
 prefix_SQ = $(subst ','\'',$(prefix))
 
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
@@ -811,6 +813,7 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
 	    -e 's|@@PREFIX@@|$(prefix_SQ)|g' \
+	    -e 's|@@HTMLDIR@@|$(htmldir_SQ)|g' \
 	    $@.sh >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
diff --git a/git-browse-help.sh b/git-browse-help.sh
index 11f8bfa..12d313a 100755
--- a/git-browse-help.sh
+++ b/git-browse-help.sh
@@ -21,6 +21,8 @@ SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
 . git-sh-setup
 
+# Install data.
+special_html_dir="@@HTMLDIR@@"
 PREFIX="@@PREFIX@@"
 GIT_VERSION="@@GIT_VERSION@@"
 
@@ -30,7 +32,7 @@ rpm_dir="$PREFIX/share/doc/git-core-$GIT_VERSION"
 
 # Look for the directory that really contains html documentation.
 html_dir=''
-for dir in "$install_html_dir" "$rpm_dir"
+for dir in "$special_html_dir" "$install_html_dir" "$rpm_dir"
 do
 	test -d "$dir" && { html_dir="$dir" ; break ; }
 done
-- 
1.5.3.6.1993.g154f-dirty
