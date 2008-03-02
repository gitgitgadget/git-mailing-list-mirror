From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH, fixed] builtin-clone: create remotes/origin/HEAD symref, if
 guessed
Date: Sun, 2 Mar 2008 06:25:29 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803020622190.22527@racer.site>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <200802260321.14038.johan@herland.net> <alpine.LNX.1.00.0802261128360.19024@iabervon.org> <alpine.LSU.1.00.0803020556380.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 02 07:27:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVhex-0008Ba-Pa
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 07:26:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbYCBG0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 01:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbYCBG0O
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 01:26:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:37952 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751783AbYCBG0N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 01:26:13 -0500
Received: (qmail invoked by alias); 02 Mar 2008 06:26:11 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp049) with SMTP; 02 Mar 2008 07:26:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19AYqk4fqBA3jG19ckCXHXiOyAH17oZc5A6dOdIPg
	3Yeh8S9QRMkdoW
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0803020556380.22527@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75730>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Sorry, my previous patch was broken in so many ways.  This one
	is better, promise.

	BTW this incidentally fixes the branch.<branch>.{remote,merge} 
	setup: it used to strip all up-to and including a slash from the 
	ref name.  This just _happened_ to work, because commonly HEAD is 
	at "refs/heads/master".  However, if it is at "refs/heads/a/b", it 
	would fail.

 builtin-clone.c |   35 ++++++++++++++++++++---------------
 1 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 056e8a3..f27d205 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -523,33 +523,38 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		git_config_set_multivar(key, value, "^$", 0);
 	}
 
+	if (head_points_at)
+		/* Local default branch */
+		create_symref("HEAD", head_points_at->name, NULL);
+
 	if (option_bare) {
-		if (head_points_at) {
-			/* Local default branch */
-			create_symref("HEAD", head_points_at->name, NULL);
-		}
 		junk_work_tree = NULL;
 		junk_git_dir = NULL;
 		return 0;
 	}
 
 	if (head_points_at) {
-		if (strrchr(head_points_at->name, '/'))
-			head = strrchr(head_points_at->name, '/') + 1;
-		else
-			head = head_points_at->name;
+		struct strbuf head_ref, real_ref;
 
-		/* Local default branch */
-		create_symref("HEAD", head_points_at->name, NULL);
+		head = head_points_at->name;
+		if (!prefixcmp(head, "refs/heads/"))
+			head += 11;
 
 		/* Tracking branch for the primary branch at the remote. */
 		update_ref(NULL, "HEAD", head_points_at->old_sha1,
 			   NULL, 0, DIE_ON_ERR);
-	/*
-		rm -f "refs/remotes/$origin/HEAD"
-		git symbolic-ref "refs/remotes/$origin/HEAD" \
-			"refs/remotes/$origin/$head_points_at" &&
-	*/
+
+		strbuf_init(&head_ref, 0);
+		strbuf_addstr(&head_ref, branch_top);
+		strbuf_addstr(&head_ref, "/HEAD");
+		delete_ref(head_ref.buf, head_points_at->old_sha1);
+		strbuf_init(&real_ref, 0);
+		strbuf_addstr(&real_ref, branch_top);
+		strbuf_addch(&real_ref, '/');
+		strbuf_addstr(&real_ref, head);
+		create_symref(head_ref.buf, real_ref.buf, reflog_msg.buf);
+		strbuf_release(&head_ref);
+		strbuf_release(&real_ref);
 
 		snprintf(key, sizeof key, "branch.%s.remote", head);
 		git_config_set(key, option_origin);
-- 
1.5.4.3.446.gbe8932


