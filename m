From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 7/6] builtin-remote: guard remote->url accesses by remote->url_nr
 check
Date: Wed, 5 Dec 2007 21:40:49 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712052139560.27959@racer.site>
References: <Pine.LNX.4.64.0712051858270.27959@racer.site>
 <Pine.LNX.4.64.0712051902080.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 05 22:41:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J01zv-0000Lq-Ag
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 22:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbXLEVlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 16:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752527AbXLEVlS
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 16:41:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:38765 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752399AbXLEVlS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 16:41:18 -0500
Received: (qmail invoked by alias); 05 Dec 2007 21:41:16 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp038) with SMTP; 05 Dec 2007 22:41:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX193JHFTC0x3PHJU1iAP7V3sFdmFMaoIhrBk7MtiGH
	up40fZS7mYJt81
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0712051902080.27959@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67199>


struct remote's url member is not a NULL terminated list.  Instead, we
have to check url_nr before accessing it.

Noticed by Johannes Sixt.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	For your viewing pleasure, this is not a resend, but an amend.  
	Feel free to squash with 4/6, or to bug me to do it.

 builtin-remote.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 142eb97..ea323e2 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -356,7 +356,8 @@ static int show_or_prune(int argc, const char **argv, int prune)
 		states.remote = remote_get(*argv);
 		if (!states.remote)
 			return error("No such remote: %s", *argv);
-		transport = transport_get(NULL, states.remote->url[0]);
+		transport = transport_get(NULL, states.remote->url_nr > 0 ?
+			states.remote->url[0] : NULL);
 		ref = transport_get_remote_refs(transport);
 
 		read_branches();
@@ -391,7 +392,7 @@ static int show_or_prune(int argc, const char **argv, int prune)
 		}
 
 		printf("* remote %s\n  URL: %s\n", *argv,
-			states.remote->url[0] ?
+			states.remote->url_nr > 0 ?
 				states.remote->url[0] : "(no URL)");
 
 		for (i = 0; i < branch_list.nr; i++) {
@@ -468,8 +469,9 @@ static int get_one_entry(struct remote *remote, void *priv)
 {
 	struct path_list *list = priv;
 
-	path_list_append(remote->name, list)->util = (void *)remote->url[0];
-	if (remote->url[0] && remote->url[1])
+	path_list_append(remote->name, list)->util = remote->url_nr ?
+		(void *)remote->url[0] : NULL;
+	if (remote->url_nr > 1)
 		warning ("Remote %s has more than one URL", remote->name);
 
 	return 0;
-- 
1.5.3.7.2157.g9598e
