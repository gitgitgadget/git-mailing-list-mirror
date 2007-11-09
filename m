From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] Make check-docs target detect removed commands
Date: Thu, 08 Nov 2007 18:38:27 -0800
Message-ID: <7vtznww3bw.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711072253580.4362@racer.site>
	<7vlk998u6r.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711080041120.4362@racer.site>
	<20071108145435.GA18727@diku.dk> <4733249B.9020504@op5.se>
	<20071108160114.GB20988@diku.dk>
	<7vzlxo1mga.fsf@gitster.siamese.dyndns.org>
	<20071109002001.GB5082@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Nov 09 03:38:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqJlm-0000Hr-Om
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 03:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758986AbXKICik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 21:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbXKICik
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 21:38:40 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:52599 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbXKICij (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 21:38:39 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 1D1BB2FA;
	Thu,  8 Nov 2007 21:39:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 696B993817;
	Thu,  8 Nov 2007 21:38:56 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64119>

The maintainer should remember running "make check-docs" from
time to time.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile |   30 +++++++++++++++++++++++++++---
 1 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 0d5590f..d5445ea 100644
--- a/Makefile
+++ b/Makefile
@@ -1125,12 +1125,13 @@ endif
 ### Check documentation
 #
 check-docs::
-	@for v in $(ALL_PROGRAMS) $(BUILT_INS) git$X gitk; \
+	@(for v in $(ALL_PROGRAMS) $(BUILT_INS) git gitk; \
 	do \
 		case "$$v" in \
 		git-merge-octopus | git-merge-ours | git-merge-recursive | \
-		git-merge-resolve | git-merge-stupid | \
+		git-merge-resolve | git-merge-stupid | git-merge-subtree | \
 		git-add--interactive | git-fsck-objects | git-init-db | \
+		git-rebase--interactive | \
 		git-repo-config | git-fetch--tool ) continue ;; \
 		esac ; \
 		test -f "Documentation/$$v.txt" || \
@@ -1141,7 +1142,30 @@ check-docs::
 		git) ;; \
 		*) echo "no link: $$v";; \
 		esac ; \
-	done | sort
+	done; \
+	( \
+		sed -e '1,/^__DATA__/d' \
+		    -e 's/[ 	].*//' \
+		    -e 's/^/listed /' Documentation/cmd-list.perl; \
+		ls -1 Documentation/git*txt | \
+		sed -e 's|Documentation/|documented |' \
+		    -e 's/\.txt//'; \
+	) | while read how cmd; \
+	do \
+		case "$$how,$$cmd" in \
+		*,git-citool | \
+		*,git-gui | \
+		documented,gitattributes | \
+		documented,gitignore | \
+		documented,gitmodules | \
+		documented,git-tools | \
+		sentinel,not,matching,is,ok ) continue ;; \
+		esac; \
+		case " $(ALL_PROGRAMS) $(BUILT_INS) git gitk " in \
+		*" $$cmd "*)	;; \
+		*) echo "removed but $$how: $$cmd" ;; \
+		esac; \
+	done ) | sort
 
 ### Make sure built-ins do not have dups and listed in git.c
 #
-- 
1.5.3.5.1622.g41d10
