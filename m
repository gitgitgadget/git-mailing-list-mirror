From: Sam Vilain <sam@vilain.net>
Subject: [PATCH 4/4] fetch: cleanup refs with --use-mirror
Date: Wed, 25 Nov 2009 23:06:57 +1300
Message-ID: <1259143617-26580-5-git-send-email-sam@vilain.net>
References: <1259143617-26580-1-git-send-email-sam@vilain.net>
 <1259143617-26580-2-git-send-email-sam@vilain.net>
 <1259143617-26580-3-git-send-email-sam@vilain.net>
 <1259143617-26580-4-git-send-email-sam@vilain.net>
Cc: Sam Vilain <sam@vilain.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 11:24:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDF3M-0006bC-H2
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 11:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758557AbZKYKYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 05:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752752AbZKYKYk
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 05:24:40 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:51583 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758384AbZKYKYh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 05:24:37 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 3DC9721C39E; Wed, 25 Nov 2009 23:07:29 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from denix (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 32B7721C36E;
	Wed, 25 Nov 2009 23:07:03 +1300 (NZDT)
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by denix with esmtp (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1NDEmJ-0006vO-7f; Wed, 25 Nov 2009 23:07:15 +1300
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1259143617-26580-4-git-send-email-sam@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133628>

Remove identical refs after a successful fetch.  The ref under
'refs/mirrors/HOST/XXX' is compared with 'refs/XXX', and if matched,
then the 'refs/mirrors/' version is removed.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
  This is a simple mechanism for removing stale mirror refs; a more
  sophisticated approach would use the revision walker.

 builtin-fetch.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index daa287a..0c52f23 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -211,6 +211,57 @@ struct ref *mirror_refmap(struct transport* transport,
 	return rv;
 }
 
+int clean_up_mirror_ref(const char *refname,
+			const unsigned char *sha1,
+			int flags,
+			void *leading)
+{
+	char *orig_refname;
+	char *target_refname;
+	char *x;
+	unsigned char found_sha1[20];
+
+	orig_refname = xmalloc(strlen(refname)+strlen(leading)+1);
+	x = strchr(refname, '/');
+	if (!x)
+		return 0;
+	target_refname = xmalloc(strlen(x)+strlen("refs/remotes/")+1); 
+
+	strcpy(orig_refname, leading);
+	x = orig_refname + strlen(leading);
+	strcpy(x, refname);
+
+	warning("cleaning up mirror ref: %s (%s)",
+		orig_refname, sha1_to_hex(sha1));
+
+	strcpy(target_refname, "refs/remotes/");
+	strcpy(target_refname+5, strchr(refname, '/')+1);
+
+	warning("target ref is %s", target_refname);
+
+	if (resolve_ref(target_refname, found_sha1, 1, NULL)) {
+		if (!hashcmp(found_sha1, sha1)) {
+			warning("deleting ref %s", orig_refname);
+			delete_ref(orig_refname, sha1, REF_NODEREF);
+		}
+	}
+}
+
+void clean_up_mirror_refs(struct remote* remote)
+{
+	int rem_l = strlen(remote->name);
+	char *dst_name = xmalloc(rem_l+14);
+	char *x;
+	strcpy(dst_name, "refs/mirrors/");
+	x = dst_name + 13;
+	strcpy(x, remote->name);
+	x += rem_l;
+	*x++ = '/';
+
+	warning("cleaning up mirror refs for remote %s", remote->name);
+	for_each_ref_in(dst_name, clean_up_mirror_ref,
+			(void *)dst_name);
+}
 
 static struct ref *get_ref_map(struct transport *transport,
 			       struct refspec *refs, int ref_count, int tags,
@@ -884,9 +935,14 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		transport = NULL;
 		urls_remaining--;
 		if (use_mirror) {
-			if (!exit_code && urls_remaining >= 1) {
-				warning("successful fetch from mirror");
-				urls_remaining = 1;
+			if (!exit_code) {
+				if (urls_remaining >= 1) {
+					warning("successful fetch from mirror");
+					urls_remaining = 1;
+				}
+				else {
+					clean_up_mirror_refs(remote);
+				}
 			}
 			if (urls_remaining == 1) {
 				transport = real_transport;
-- 
1.6.3.3
