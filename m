From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 5/6] builtin-remote: prune remotes correctly that were added
 with --mirror
Date: Wed, 5 Dec 2007 19:02:41 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712051902300.27959@racer.site>
References: <Pine.LNX.4.64.0712051858270.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 05 20:03:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzzX1-00025a-NO
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 20:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbXLETDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 14:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbXLETDK
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 14:03:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:51075 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751658AbXLETDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 14:03:09 -0500
Received: (qmail invoked by alias); 05 Dec 2007 19:03:07 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp004) with SMTP; 05 Dec 2007 20:03:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Xs2xbBpvXh1qNGeZCOjXVeFuzjuxmMwXP4w9djZ
	vxuZYK3IIVXMCG
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0712051858270.27959@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67178>


This adds special handling for mirror remotes.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This fixes a real bug in git-remote, which I tried to fix in the
	perl script, failing.

 builtin-remote.c  |   16 +++++++++++++---
 t/t5505-remote.sh |   16 ++++++++++++++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 41ac4a1..142eb97 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -367,12 +367,22 @@ static int show_or_prune(int argc, const char **argv, int prune)
 
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
-						states.stale.items[i].path);
+				strbuf_setlen(&buf, prefix_len);
+				strbuf_addstr(&buf, states.stale.items[i].path);
 				result |= delete_ref(buf.buf, NULL);
 			}
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index d343a96..2376e0a 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -131,4 +131,20 @@ test_expect_success 'prune' '
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
1.5.3.7.2157.g9598e
