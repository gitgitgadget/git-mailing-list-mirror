From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Beautify the output of send-pack a bit
Date: Mon, 12 Nov 2007 23:11:40 +0100
Message-ID: <20071112221140.GD2918@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 23:12:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrhWL-0002zP-45
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 23:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759602AbXKLWLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 17:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756519AbXKLWLn
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 17:11:43 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:46926 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759583AbXKLWLm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 17:11:42 -0500
Received: from tigra.home (Faf31.f.strato-dslnet.de [195.4.175.49])
	by post.webmailer.de (klopstock mo15) (RZmta 14.0)
	with ESMTP id U046d7jACHdMKk ; Mon, 12 Nov 2007 23:11:40 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 99FDC277AE;
	Mon, 12 Nov 2007 23:11:40 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 777BE56D22; Mon, 12 Nov 2007 23:11:40 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz0wOR49Q==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64719>

Cluster the errors regarding ancestry violation and output them
in one batch, together with a hint to pull before pushing.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Catching trend...

 send-pack.c |   33 ++++++++++++++++++++++-----------
 1 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index d56d980..e6da567 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -215,6 +215,7 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 	int ask_for_status_report = 0;
 	int allow_deleting_refs = 0;
 	int expect_status_report = 0;
+	struct ref *failed_refs = NULL, **failed_tail = &failed_refs;
 
 	/* No funny business with the matcher */
 	remote_tail = get_remote_heads(in, &remote_refs, 0, NULL, REF_NORMAL);
@@ -243,25 +244,27 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 	 * Finally, tell the other end!
 	 */
 	new_refs = 0;
-	for (ref = remote_refs; ref; ref = ref->next) {
+	ref = remote_refs;
+	remote_refs = NULL;
+	remote_tail = &remote_refs;
+	for (; ref; ref = ref->next) {
 		char old_hex[60], *new_hex;
 		int will_delete_ref;
 
 		if (!ref->peer_ref)
-			continue;
-
+			goto remote_ok;
 
 		will_delete_ref = is_null_sha1(ref->peer_ref->new_sha1);
 		if (will_delete_ref && !allow_deleting_refs) {
 			error("remote does not support deleting refs");
 			ret = -2;
-			continue;
+			goto remote_ok;
 		}
 		if (!will_delete_ref &&
 		    !hashcmp(ref->old_sha1, ref->peer_ref->new_sha1)) {
 			if (verbose)
 				fprintf(stderr, "'%s': up-to-date\n", ref->name);
-			continue;
+			goto remote_ok;
 		}
 
 		/* This part determines what can overwrite what.
@@ -297,13 +300,9 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 				 * commits at the remote end and likely
 				 * we were not up to date to begin with.
 				 */
-				error("remote '%s' is not an ancestor of\n"
-				      " local  '%s'.\n"
-				      " Maybe you are not up-to-date and "
-				      "need to pull first?",
-				      ref->name,
-				      ref->peer_ref->name);
 				ret = -2;
+				*failed_tail = ref;
+				failed_tail = &ref->next;
 				continue;
 			}
 		}
@@ -335,6 +334,18 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 			fprintf(stderr, "\n  from %s\n  to   %s\n",
 				old_hex, new_hex);
 		}
+	remote_ok:
+		*remote_tail = ref;
+		remote_tail = &ref->next;
+	}
+	*remote_tail = NULL;
+	*failed_tail = NULL;
+
+	if (failed_refs) {
+		for (ref = failed_refs; ref; ref = ref->next)
+			error("remote '%s' is not an ancestor of local '%s'",
+			      ref->name, ref->peer_ref->name);
+		fprintf(stderr, "Maybe you are not up-to-date and need to pull first?\n");
 	}
 
 	packet_flush(out);
-- 
1.5.3.5.648.g1e92c
