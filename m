From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Always use the current connection's remote ref list in git
 protocol
Date: Thu, 28 Feb 2008 11:10:51 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802281106390.19665@iabervon.org>
References: <alpine.LNX.1.00.0802281026030.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 17:11:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUlM7-0001Rl-JU
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 17:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758118AbYB1QKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 11:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757739AbYB1QKy
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 11:10:54 -0500
Received: from iabervon.org ([66.92.72.58]:58948 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756269AbYB1QKx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 11:10:53 -0500
Received: (qmail 4136 invoked by uid 1000); 28 Feb 2008 16:10:51 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Feb 2008 16:10:51 -0000
In-Reply-To: <alpine.LNX.1.00.0802281026030.19665@iabervon.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75420>

We always report to the user the list of refs we got from the first
connection, even if we do multiple connections. But we should always
use each connection's own list of refs in the communication with the
server, in case we got a different server out of DNS rotation or the
timing was surprising or something.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
This should fix the same part of the problem that discarding 
transport->remote_refs did, but without having transport.c try to do 
foolish stuff and builtin-fetch need to tell it not to.

 transport.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/transport.c b/transport.c
index 397983d..fc92311 100644
--- a/transport.c
+++ b/transport.c
@@ -622,6 +622,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	char *dest = xstrdup(transport->url);
 	struct fetch_pack_args args;
 	int i;
+	struct ref *refs_tmp = NULL;
 
 	memset(&args, 0, sizeof(args));
 	args.uploadpack = data->uploadpack;
@@ -634,15 +635,13 @@ static int fetch_refs_via_pack(struct transport *transport,
 	for (i = 0; i < nr_heads; i++)
 		origh[i] = heads[i] = xstrdup(to_fetch[i]->name);
 
-	refs = transport_get_remote_refs(transport);
 	if (!data->conn) {
-		struct ref *refs_tmp;
 		connect_setup(transport);
 		get_remote_heads(data->fd[0], &refs_tmp, 0, NULL, 0);
-		free_refs(refs_tmp);
 	}
 
-	refs = fetch_pack(&args, data->fd, data->conn, transport->remote_refs,
+	refs = fetch_pack(&args, data->fd, data->conn, 
+			  refs_tmp ? refs_tmp : transport->remote_refs,
 			  dest, nr_heads, heads, &transport->pack_lockfile);
 	close(data->fd[0]);
 	close(data->fd[1]);
@@ -650,6 +649,8 @@ static int fetch_refs_via_pack(struct transport *transport,
 		refs = NULL;
 	data->conn = NULL;
 
+	free_refs(refs_tmp);
+
 	for (i = 0; i < nr_heads; i++)
 		free(origh[i]);
 	free(origh);
-- 
1.5.4.3.328.gcaed
