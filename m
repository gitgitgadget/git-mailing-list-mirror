From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 5/5] Avoid duplicating memory, and use xmemdupz instead of xstrdup.
Date: Tue, 18 Sep 2007 23:48:22 +0200
Message-ID: <20070918224123.3251C344AB3@madism.org>
References: <20070918223947.GB4535@artemis.corp>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 00:42:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXllj-0007mW-RW
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 00:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755725AbXIRWl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 18:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754660AbXIRWl0
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 18:41:26 -0400
Received: from pan.madism.org ([88.191.52.104]:54831 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753498AbXIRWlX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 18:41:23 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 7B8E820A23;
	Wed, 19 Sep 2007 00:41:23 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 3251C344AB3; Wed, 19 Sep 2007 00:41:23 +0200 (CEST)
In-Reply-To: <20070918223947.GB4535@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58649>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 fetch.c |   23 +++++++++--------------
 1 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/fetch.c b/fetch.c
index b1c1f07..479ec02 100644
--- a/fetch.c
+++ b/fetch.c
@@ -218,24 +218,19 @@ int pull_targets_stdin(char ***target, const char ***write_ref)
 	struct strbuf buf;
 	*target = NULL; *write_ref = NULL;
 	strbuf_init(&buf, 0);
-	while (1) {
-		char *rf_one = NULL;
-		char *tg_one;
-
-		if (strbuf_getline(&buf, stdin, '\n') == EOF)
-			break;
-		tg_one = buf.buf;
-		rf_one = strchr(tg_one, '\t');
-		if (rf_one)
-			*rf_one++ = 0;
+	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
+		char *rf_one = memchr(buf.buf, '\t', buf.len);
 
 		if (targets >= targets_alloc) {
-			targets_alloc = targets_alloc ? targets_alloc * 2 : 64;
-			*target = xrealloc(*target, targets_alloc * sizeof(**target));
+			ALLOC_GROW(target, targets, targets_alloc);
 			*write_ref = xrealloc(*write_ref, targets_alloc * sizeof(**write_ref));
 		}
-		(*target)[targets] = xstrdup(tg_one);
-		(*write_ref)[targets] = rf_one ? xstrdup(rf_one) : NULL;
+		if (rf_one) {
+			(*write_ref)[targets] = xmemdupz(rf_one, buf.len - (rf_one - buf.buf));
+		} else {
+			(*write_ref)[targets] = NULL;
+		}
+		(*target)[targets] = strbuf_detach(&buf);
 		targets++;
 	}
 	strbuf_release(&buf);
-- 
1.5.3.1
