From: "Stephen C. Tweedie" <sct@redhat.com>
Subject: [PATCH] Don't sent objects for refs we're not going to update.
Date: Tue, 21 Feb 2006 13:48:22 -0500
Message-ID: <1140547702.5509.24.camel@orbit.scot.redhat.com>
References: <1140547568.5509.21.camel@orbit.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Stephen Tweedie <sct@redhat.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 19:48:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBcYs-0006J3-2y
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 19:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbWBUSsb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 13:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbWBUSsb
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 13:48:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62099 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932639AbWBUSsa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 13:48:30 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id k1LImU2U030023
	for <git@vger.kernel.org>; Tue, 21 Feb 2006 13:48:30 -0500
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k1LImP127081;
	Tue, 21 Feb 2006 13:48:25 -0500
Received: from vpn83-173.boston.redhat.com (vpn83-173.boston.redhat.com [172.16.83.173])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id k1LImOmR029550;
	Tue, 21 Feb 2006 13:48:24 -0500
To: git mailing list <git@vger.kernel.org>
In-Reply-To: <1140547568.5509.21.camel@orbit.scot.redhat.com>
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16541>

send_pack() sends only those refs we've asked to be updated on the
destination---either via an explicit refspec or by matching local and
remote refs.  But rev_list() builds an object list for *all* refs it
can find.  For a tree with many tags/heads, this means that it is
impossible to push updates even to a single refspec, as exec_rev_list()
overflows its arg length limit.

Fix this by skipping refs with no peer_ref set in exec_rev_list().
send_pack() already skips it when sending refs; we need to skip it
when building the object list for the pack too.

Signed-off-by: Stephen Tweedie <sct@redhat.com>

---

 send-pack.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

4aa39c0920eea37987ca8a6b10861da7a87b5c14
diff --git a/send-pack.c b/send-pack.c
index 990be3f..d2a39d9 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -42,8 +42,10 @@ static void exec_rev_list(struct ref *re
 
 	args[i++] = "rev-list";	/* 0 */
 	args[i++] = "--objects";	/* 1 */
-	while (refs) {
+	for (; refs; refs = refs->next) {
 		char *buf = malloc(100);
+		if (!refs->peer_ref)
+			continue;
 		if (i > 900)
 			die("git-rev-list environment overflow");
 		if (!is_zero_sha1(refs->old_sha1) &&
@@ -56,7 +58,6 @@ static void exec_rev_list(struct ref *re
 			args[i++] = buf;
 			snprintf(buf, 50, "%s", sha1_to_hex(refs->new_sha1));
 		}
-		refs = refs->next;
 	}
 	args[i] = NULL;
 	execv_git_cmd(args);
-- 
1.2.2.g6643-dirty
