From: Jeff King <peff@peff.net>
Subject: [PATCH 8/4] check-docs: get documented command list from Makefile
Date: Wed, 8 Aug 2012 16:57:52 -0400
Message-ID: <20120808205752.GD12838@sigill.intra.peff.net>
References: <20120808205456.GB29528@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 22:58:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzDKO-0006lj-Rw
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 22:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030776Ab2HHU57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 16:57:59 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57694 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030766Ab2HHU56 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 16:57:58 -0400
Received: (qmail 11751 invoked by uid 107); 8 Aug 2012 20:58:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Aug 2012 16:58:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Aug 2012 16:57:52 -0400
Content-Disposition: inline
In-Reply-To: <20120808205456.GB29528@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203131>

The current code tries to get a list of documented commands
by doing "ls Documentation/git*txt" and culling a bunch of
special cases from the result. Looking for "git-*.txt" would
be more accurate, but would miss a few commands like
"gitweb" and "gitk".

Fortunately, Documentation/Makefile already knows what this
list is, so we can just ask it. Annoyingly, we still have to
post-process its output a little, since make will print
extra cruft like "GIT-VERSION-FILE is up to date" to stdout.

Now that our list is accurate, we can remove all of the ugly
special-cases.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/Makefile |  3 +++
 Makefile               | 26 ++------------------------
 2 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 063fa69..cf5916f 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -344,4 +344,7 @@ require-htmlrepo::
 quick-install-html: require-htmlrepo
 	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(HTML_REPO) $(DESTDIR)$(htmldir)
 
+print-man1:
+	@for i in $(MAN1_TXT); do echo $$i; done
+
 .PHONY: FORCE
diff --git a/Makefile b/Makefile
index b9da511..51b3c6f 100644
--- a/Makefile
+++ b/Makefile
@@ -2832,34 +2832,12 @@ check-docs::
 		sed -e '/^#/d' \
 		    -e 's/[ 	].*//' \
 		    -e 's/^/listed /' command-list.txt; \
-		ls -1 Documentation/git*txt | \
+		$(MAKE) -C Documentation print-man1 | \
+		grep '\.txt$$' | \
 		sed -e 's|Documentation/|documented |' \
 		    -e 's/\.txt//'; \
 	) | while read how cmd; \
 	do \
-		case "$$how,$$cmd" in \
-		documented,gitattributes | \
-		documented,gitignore | \
-		documented,gitmodules | \
-		documented,gitcli | \
-		documented,git-tools | \
-		documented,gitcore-tutorial | \
-		documented,gitcvs-migration | \
-		documented,gitdiffcore | \
-		documented,gitglossary | \
-		documented,githooks | \
-		documented,gitrepository-layout | \
-		documented,gitrevisions | \
-		documented,gittutorial | \
-		documented,gittutorial-2 | \
-		documented,git-bisect-lk2009 | \
-		documented,git-remote-helpers | \
-		documented,gitworkflows | \
-		documented,gitcredentials | \
-		documented,gitnamespaces | \
-		documented,gitweb.conf | \
-		sentinel,not,matching,is,ok ) continue ;; \
-		esac; \
 		case " $(ALL_COMMANDS) " in \
 		*" $$cmd "*)	;; \
 		*) echo "removed but $$how: $$cmd" ;; \
-- 
1.7.12.rc2.36.gb1dc81b
