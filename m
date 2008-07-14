From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 1/5] Makefile: Normalize $(bindir) and $(gitexecdir) before comparing
Date: Mon, 14 Jul 2008 23:41:25 +0200
Message-ID: <1216071689-14823-2-git-send-email-johannes.sixt@telecom.at>
References: <1216025226.487b128a031fd@webmail.eunet.at>
 <1216071689-14823-1-git-send-email-johannes.sixt@telecom.at>
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 23:42:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIVoY-0002Di-D2
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 23:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756962AbYGNVld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 17:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756927AbYGNVlc
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 17:41:32 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:40584 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756283AbYGNVlc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 17:41:32 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 8E58C13AB8E;
	Mon, 14 Jul 2008 23:41:30 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.3.323.g1e58
In-Reply-To: <1216071689-14823-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88466>

The install target needs to check whether the user has opted to make
$(gitexecdir) equal to $(bindir). It did so by a straight string
comparison. Since we are going to allow a relative $(gitexecdir), we have
to normalize paths before comparison, which we do with $(cd there && pwd).

The normalized paths are stored in shell variables. These we can now
reuse in the subsequent install statements, which conveniently shortens
the lines a bit.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Makefile |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 4796565..4de9271 100644
--- a/Makefile
+++ b/Makefile
@@ -1318,18 +1318,18 @@ ifndef NO_TCLTK
 	$(MAKE) -C gitk-git install
 	$(MAKE) -C git-gui install
 endif
-	if test 'z$(bindir_SQ)' != 'z$(gitexecdir_SQ)'; \
-	then \
-		ln -f '$(DESTDIR_SQ)$(bindir_SQ)/git$X' \
-			'$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X' || \
-		cp '$(DESTDIR_SQ)$(bindir_SQ)/git$X' \
-			'$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X'; \
-	fi
-	$(foreach p,$(BUILT_INS), $(RM) '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
 ifneq (,$X)
 	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), $(RM) '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p';)
 endif
-	./check_bindir 'z$(bindir_SQ)' 'z$(gitexecdir_SQ)' '$(DESTDIR_SQ)$(bindir_SQ)/git-shell$X'
+	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
+	execdir=$$(cd '$(DESTDIR_SQ)$(gitexecdir_SQ)' && pwd) && \
+	if test "z$$bindir" != "z$$execdir"; \
+	then \
+		ln -f "$$bindir/git$X" "$$execdir/git$X" || \
+		cp "$$bindir/git$X" "$$execdir/git$X"; \
+	fi && \
+	{ $(foreach p,$(BUILT_INS), $(RM) "$$execdir/$p" && ln "$$execdir/git$X" "$$execdir/$p" ;) } && \
+	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-shell$X"
 
 install-doc:
 	$(MAKE) -C Documentation install
-- 
1.5.6.3.323.g1e58
