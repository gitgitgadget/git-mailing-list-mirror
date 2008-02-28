From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] templates/Makefile: don't depend on local umask setting
Date: Thu, 28 Feb 2008 18:44:42 +0000
Message-ID: <20080228184442.13993.qmail@c0e6a439c34263.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 19:46:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUnlP-0000BI-44
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 19:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761433AbYB1SoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 13:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761425AbYB1SoZ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 13:44:25 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:41825 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755346AbYB1SoX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 13:44:23 -0500
Received: (qmail 13994 invoked by uid 1000); 28 Feb 2008 18:44:42 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75434>

Don't take the local umask setting into account when installing the
templates/* files and directories, running 'make install' with umask set
to 077 resulted in template/* installed with permissions 700 and 600.

The problem was discovered by Florian Zumbiehl, reported through
 http://bugs.debian.org/467518

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 templates/Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/templates/Makefile b/templates/Makefile
index ebd3a62..bda9d13 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -29,10 +29,10 @@ boilerplates.made : $(bpsrc)
 		case "$$boilerplate" in *~) continue ;; esac && \
 		dst=`echo "$$boilerplate" | sed -e 's|^this|.|;s|--|/|g'` && \
 		dir=`expr "$$dst" : '\(.*\)/'` && \
-		mkdir -p blt/$$dir && \
+		$(INSTALL) -d -m 755 blt/$$dir && \
 		case "$$boilerplate" in \
 		*--) ;; \
-		*) cp $$boilerplate blt/$$dst ;; \
+		*) cp -p $$boilerplate blt/$$dst ;; \
 		esac || exit; \
 	done && \
 	date >$@
@@ -48,4 +48,4 @@ clean:
 install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(template_dir_SQ)'
 	(cd blt && $(TAR) cf - .) | \
-	(cd '$(DESTDIR_SQ)$(template_dir_SQ)' && $(TAR) xf -)
+	(cd '$(DESTDIR_SQ)$(template_dir_SQ)' && umask 022 && $(TAR) xf -)
-- 
1.5.4.3

