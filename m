From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Fix branches file configuration
Date: Tue, 25 Mar 2008 19:35:28 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803251931500.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 00:36:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeIgc-000396-3o
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 00:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760792AbYCYXfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 19:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753556AbYCYXfa
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 19:35:30 -0400
Received: from iabervon.org ([66.92.72.58]:49548 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752621AbYCYXfa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 19:35:30 -0400
Received: (qmail 13502 invoked by uid 1000); 25 Mar 2008 23:35:28 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Mar 2008 23:35:28 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78230>

It turns out that .git/branches/foo should fetch into refs/heads/foo.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
We still don't have a test for that bit of the behavior, so I could have 
it still doing the wrong thing. But it at least should do what I think 
people want.

Andrew, could you give this a try, on top of current master (or, for that 
matter, any released version that doesn't work), and let me know if it 
does the wrong thing?

 remote.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/remote.c b/remote.c
index 40ed246..a027bca 100644
--- a/remote.c
+++ b/remote.c
@@ -232,7 +232,7 @@ static void read_branches_file(struct remote *remote)
 {
 	const char *slash = strchr(remote->name, '/');
 	char *frag;
-	char *branch;
+	struct strbuf branch;
 	int n = slash ? slash - remote->name : 1000;
 	FILE *f = fopen(git_path("branches/%.*s", n, remote->name), "r");
 	char *s, *p;
@@ -258,17 +258,16 @@ static void read_branches_file(struct remote *remote)
 	strcpy(p, s);
 	if (slash)
 		strcat(p, slash);
+	strbuf_init(&branch, 0);
 	frag = strchr(p, '#');
 	if (frag) {
 		*(frag++) = '\0';
-		branch = xmalloc(strlen(frag) + 12);
-		strcpy(branch, "refs/heads/");
-		strcat(branch, frag);
-	} else {
-		branch = "refs/heads/master";
-	}
+		strbuf_addf(&branch, "refs/heads/%s", frag);
+	} else
+		strbuf_addstr(&branch, "refs/heads/master");
 	add_url_alias(remote, p);
-	add_fetch_refspec(remote, branch);
+	strbuf_addf(&branch, ":refs/heads/%s", remote->name);
+	add_fetch_refspec(remote, strbuf_detach(&branch, 0));
 	remote->fetch_tags = 1; /* always auto-follow */
 }
 
-- 
1.5.4.3.610.gea6cd
