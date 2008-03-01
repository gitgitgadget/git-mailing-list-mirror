From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 6/6] builtin-remote: prune remotes correctly that were added
 with --mirror
Date: Sat, 1 Mar 2008 13:17:18 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803011317100.22527@racer.site>
References: <alpine.LSU.1.00.0802290144130.22527@racer.site> <alpine.LSU.1.00.0802290144410.22527@racer.site> <7vprugfrgw.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802290214150.22527@racer.site> <alpine.LSU.1.00.0803011313020.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 14:18:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVRbm-0007rm-93
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 14:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756028AbYCANR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 08:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755991AbYCANR6
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 08:17:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:52954 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753535AbYCANR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 08:17:57 -0500
Received: (qmail invoked by alias); 01 Mar 2008 13:17:56 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp024) with SMTP; 01 Mar 2008 14:17:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18XeMZXM/gXAIlxLr6fSJa67TepLHAD5wn6bWT5XV
	3EM6dg3kEIxgxO
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0803011313020.22527@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75671>


This adds special handling for mirror remotes.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-remote.c  |   15 +++++++++++++--
 t/t5505-remote.sh |   16 ++++++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 2c10df3..221d2d6 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -396,11 +396,22 @@ static int show_or_prune(int argc, const char **argv, int prune)
 
 		if (prune) {
 			struct strbuf buf;
+			int prefix_len;
 
 			strbuf_init(&buf, 0);
+			if (states.remote->fetch_refspec_nr == 1 &&
+					states.remote->fetch->pattern &&
+					!strcmp(states.remote->fetch->src,
+						states.remote->fetch->dst))
+				/* handle --mirror remote */
+				strbuf_addstr(&buf, "refs/heads/");
+			else
+				strbuf_addf(&buf, "refs/remotes/%s/", *argv);
+			prefix_len = buf.len;
+
 			for (i = 0; i < states.stale.nr; i++) {
-				strbuf_reset(&buf);
-				strbuf_addf(&buf, "refs/remotes/%s/%s", *argv,
+				strbuf_setlen(&buf, prefix_len);
+				strbuf_addstr(&buf,
 						states.stale.items[i].string);
 				result |= delete_ref(buf.buf, NULL);
 			}
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 5986982..0a25c8b 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -128,4 +128,20 @@ test_expect_success 'prune' '
 	 ! git rev-parse refs/remotes/origin/side)
 '
 
+test_expect_success 'add --mirror && prune' '
+	(mkdir mirror &&
+	 cd mirror &&
+	 git init &&
+	 git remote add --mirror -f origin ../one) &&
+	(cd one &&
+	 git branch -m side2 side) &&
+	(cd mirror &&
+	 git rev-parse --verify refs/heads/side2 &&
+	 ! git rev-parse --verify refs/heads/side &&
+	 git fetch origin &&
+	 git remote prune origin &&
+	 ! git rev-parse --verify refs/heads/side2 &&
+	 git rev-parse --verify refs/heads/side)
+'
+
 test_done
-- 
1.5.4.3.446.gbe8932


