From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 2/9] Makefile: Normalize $(bindir) and $(gitexecdir) before comparing
Date: Mon, 21 Jul 2008 21:19:51 +0200
Message-ID: <1216667998-8879-3-git-send-email-johannes.sixt@telecom.at>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-2-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 21:21:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL0wU-0001rx-48
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 21:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541AbYGUTUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 15:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754473AbYGUTUF
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 15:20:05 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:39816 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560AbYGUTUD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 15:20:03 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id 2BCF333D3A;
	Mon, 21 Jul 2008 21:20:01 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.18.g6aef2
In-Reply-To: <1216667998-8879-2-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89385>

The install target needs to check whether the user has opted to make
$(gitexecdir) equal to $(bindir). It did so by a straight string
comparison. Since we are going to allow a relative $(gitexecdir), we have
to normalize paths before comparison, which we do with $(cd there && pwd).

The normalized paths are stored in shell variables. These we can now
reuse in the subsequent install statements, which conveniently shortens
the lines a bit.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Makefile |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index cbab4f9..226dd03 100644
--- a/Makefile
+++ b/Makefile
@@ -1327,19 +1327,19 @@ ifndef NO_TCLTK
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
-	$(RM) '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X'
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
+	$(RM) "$$execdir/git$X" && \
+	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-shell$X"
 
 install-doc:
 	$(MAKE) -C Documentation install
-- 
1.6.0.rc0.18.g6aef2
