From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 33/40] When installing, be prepared that template_dir may be relative.
Date: Wed, 27 Feb 2008 19:54:56 +0100
Message-ID: <1204138503-6126-34-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVT-00022R-KH
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756376AbYB0Sz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755656AbYB0Sz5
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:55:57 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40442 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755679AbYB0SzM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:12 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 51B159771D;
	Wed, 27 Feb 2008 19:55:10 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75273>

Since the Makefile in the template/ subdirectory is only used to install
the templates, we do not simply pass down the setting of template_dir
when it is relative, but construct the intended destination in a new
variable: A relative template_dir is relative to gitexecdir.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Makefile           |    9 ++++++++-
 templates/Makefile |    8 ++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 15b13c0..53a4e2a 100644
--- a/Makefile
+++ b/Makefile
@@ -197,7 +197,7 @@ GITWEB_FAVICON = git-favicon.png
 GITWEB_SITE_HEADER =
 GITWEB_SITE_FOOTER =
 
-export prefix bindir gitexecdir sharedir template_dir htmldir sysconfdir
+export prefix bindir gitexecdir sharedir htmldir sysconfdir
 
 CC = gcc
 AR = ar
@@ -1094,6 +1094,13 @@ remove-dashes:
 
 ### Installation rules
 
+ifeq ($(firstword $(subst /, ,$(template_dir))),..)
+template_instdir = $(gitexecdir)/$(template_dir)
+else
+template_instdir = $template_dir
+endif
+export template_instdir
+
 install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
diff --git a/templates/Makefile b/templates/Makefile
index b341105..eb08702 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -8,14 +8,14 @@ INSTALL ?= install
 TAR ?= tar
 RM ?= rm -f
 prefix ?= $(HOME)
-template_dir ?= $(prefix)/share/git-core/templates
+template_instdir ?= $(prefix)/share/git-core/templates
 # DESTDIR=
 # set NOEXECTEMPL to non-empty to change the names of hook scripts
 # so that the tools will not find them
 
 # Shell quote (do not use $(call) to accommodate ancient setups);
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
-template_dir_SQ = $(subst ','\'',$(template_dir))
+template_instdir_SQ = $(subst ','\'',$(template_instdir))
 
 all: boilerplates.made custom
 
@@ -52,6 +52,6 @@ clean:
 	$(RM) -r blt boilerplates.made
 
 install: all
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(template_dir_SQ)'
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(template_instdir_SQ)'
 	(cd blt && $(TAR) cf - .) | \
-	(cd '$(DESTDIR_SQ)$(template_dir_SQ)' && $(TAR) xf -)
+	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && $(TAR) xf -)
-- 
1.5.4.1.126.ge5a7d
