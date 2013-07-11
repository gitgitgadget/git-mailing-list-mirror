From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: [PATCH 3/3] fetch-pack: Request fixed-off-by-one-depth when available
Date: Thu, 11 Jul 2013 13:25:54 +0200
Message-ID: <1373541954-16493-3-git-send-email-matthijs@stdin.nl>
References: <20130711105733.GG10217@login.drsnuggles.stderr.nl>
 <1373541954-16493-1-git-send-email-matthijs@stdin.nl>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org, Matthijs Kooijman <matthijs@stdin.nl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 13:26:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxF0y-0006bV-UK
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 13:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400Ab3GKL0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 07:26:21 -0400
Received: from 84-245-11-97.dsl.cambrium.nl ([84.245.11.97]:53748 "EHLO
	grubby.stderr.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932349Ab3GKL0T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 07:26:19 -0400
Received: from matthijs by grubby.stderr.nl with local (Exim 4.80)
	(envelope-from <matthijs@stdin.nl>)
	id 1UxF0m-0004Ij-Hl; Thu, 11 Jul 2013 13:26:12 +0200
X-Mailer: git-send-email 1.8.3.rc1
In-Reply-To: <1373541954-16493-1-git-send-email-matthijs@stdin.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230087>

This server feature changes the meaning of the fetch depth, allowing
fetching only a single revision instead of at least two as before. To
make sure the behaviour only depends on the client version, the depth
value sent over the wire is corrected depending on wether the server has
the fix.

There is one corner case: A server without the fix cannot send less than
2 commmits, so when --depth=1 is specified a warning is shown and 2
commits are fetched instead of 1.

Signed-off-by: Matthijs Kooijman <matthijs@stdin.nl>
---
 fetch-pack.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index abe5ffb..799b2c1 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -39,6 +39,7 @@ static int marked;
 
 static struct commit_list *rev_list;
 static int non_common_revs, multi_ack, use_sideband, allow_tip_sha1_in_want;
+static int fixed_depth;
 
 static void rev_list_push(struct commit *commit, int mark)
 {
@@ -327,6 +328,7 @@ static int find_common(struct fetch_pack_args *args,
 			if (prefer_ofs_delta)   strbuf_addstr(&c, " ofs-delta");
 			if (agent_supported)    strbuf_addf(&c, " agent=%s",
 							    git_user_agent_sanitized());
+			if (fixed_depth)        strbuf_addstr(&c, " fixed-off-by-one-depth");
 			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
 			strbuf_release(&c);
 		} else
@@ -342,8 +344,23 @@ static int find_common(struct fetch_pack_args *args,
 
 	if (is_repository_shallow())
 		write_shallow_commits(&req_buf, 1);
-	if (args->depth > 0)
-		packet_buf_write(&req_buf, "deepen %d", args->depth);
+	if (args->depth > 0) {
+		if (!fixed_depth && args->depth == 1)
+			warning("Server does not support depth=1, using depth=2 instead");
+		if (!fixed_depth && args->depth > 1) {
+			/* Old server that interprets "deepen 1" as
+			   "give me tip + 1 extra commit" */
+			packet_buf_write(&req_buf, "deepen %d", args->depth - 1);
+		} else if (!fixed_depth && args->depth == 1) {
+			/* Old servers cannot handle depth=1 (deepen=0
+			   means don't change depth / full depth). */
+			packet_buf_write(&req_buf, "deepen 1");
+		} else {
+			/* New server, send depth as-is */
+			packet_buf_write(&req_buf, "deepen %d", args->depth);
+		}
+	}
+
 	packet_buf_flush(&req_buf);
 	state_len = req_buf.len;
 
@@ -874,6 +891,11 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 			fprintf(stderr, "Server supports ofs-delta\n");
 	} else
 		prefer_ofs_delta = 0;
+	if (server_supports("fixed-off-by-one-depth")) {
+		if (args->verbose)
+			fprintf(stderr, "Server has fixed meaning of depth value\n");
+		fixed_depth = 1;
+	}
 
 	if ((agent_feature = server_feature_value("agent", &agent_len))) {
 		agent_supported = 1;
-- 
1.8.3.rc1
