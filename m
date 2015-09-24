From: Jeff King <peff@peff.net>
Subject: [PATCH 33/68] read_branches_file: simplify string handling
Date: Thu, 24 Sep 2015 17:07:18 -0400
Message-ID: <20150924210718.GD30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:07:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDjn-00020P-E5
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504AbbIXVHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:07:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:35975 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753399AbbIXVHV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:07:21 -0400
Received: (qmail 11979 invoked by uid 102); 24 Sep 2015 21:07:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:07:20 -0500
Received: (qmail 29259 invoked by uid 107); 24 Sep 2015 21:07:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:07:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:07:18 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278587>

This function does a lot of manual string handling, and has
some unnecessary limits. This patch cleans up a number of
things:

  1. Drop the arbitrary 1000-byte limit on the size of the
     remote name (we do not have such a limit in any of the
     other remote-reading mechanisms).

  2. Replace fgets into a fixed-size buffer with a strbuf,
     eliminating any limits on the length of the URL.

  3. Replace manual whitespace handling with strbuf_trim
     (since we now have a strbuf). This also gets rid
     of a call to strcpy, and the confusing reuse of the "p"
     pointer for multiple purposes.

  4. We currently build up the refspecs over multiple strbuf
     calls. We do this to handle the fact that the URL "frag"
     may not be present. But rather than have multiple
     conditionals, let's just default "frag" to "master".
     This lets us format the refspecs with a single xstrfmt.
     It's shorter, and easier to see what the final string
     looks like.

     We also update the misleading comment in this area (the
     local branch is named after the remote name, not after
     the branch name on the remote side).

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 54 ++++++++++++++++++++----------------------------------
 1 file changed, 20 insertions(+), 34 deletions(-)

diff --git a/remote.c b/remote.c
index 5ab0f7f..22a60fc 100644
--- a/remote.c
+++ b/remote.c
@@ -293,56 +293,42 @@ static void read_remotes_file(struct remote *remote)
 static void read_branches_file(struct remote *remote)
 {
 	char *frag;
-	struct strbuf branch = STRBUF_INIT;
-	int n = 1000;
-	FILE *f = fopen(git_path("branches/%.*s", n, remote->name), "r");
-	char *s, *p;
-	int len;
+	struct strbuf buf = STRBUF_INIT;
+	FILE *f = fopen(git_path("branches/%s", remote->name), "r");
 
 	if (!f)
 		return;
-	s = fgets(buffer, BUF_SIZE, f);
-	fclose(f);
-	if (!s)
-		return;
-	while (isspace(*s))
-		s++;
-	if (!*s)
+
+	strbuf_getline(&buf, f, '\n');
+	strbuf_trim(&buf);
+	if (!buf.len) {
+		strbuf_release(&buf);
 		return;
+	}
+
 	remote->origin = REMOTE_BRANCHES;
-	p = s + strlen(s);
-	while (isspace(p[-1]))
-		*--p = 0;
-	len = p - s;
-	p = xmalloc(len + 1);
-	strcpy(p, s);
 
 	/*
 	 * The branches file would have URL and optionally
 	 * #branch specified.  The "master" (or specified) branch is
-	 * fetched and stored in the local branch of the same name.
+	 * fetched and stored in the local branch matching the
+	 * remote name.
 	 */
-	frag = strchr(p, '#');
-	if (frag) {
+	frag = strchr(buf.buf, '#');
+	if (frag)
 		*(frag++) = '\0';
-		strbuf_addf(&branch, "refs/heads/%s", frag);
-	} else
-		strbuf_addstr(&branch, "refs/heads/master");
+	else
+		frag = "master";
+
+	add_url_alias(remote, strbuf_detach(&buf, NULL));
+	add_fetch_refspec(remote, xstrfmt("refs/heads/%s:refs/heads/%s",
+					  frag, remote->name));
 
-	strbuf_addf(&branch, ":refs/heads/%s", remote->name);
-	add_url_alias(remote, p);
-	add_fetch_refspec(remote, strbuf_detach(&branch, NULL));
 	/*
 	 * Cogito compatible push: push current HEAD to remote #branch
 	 * (master if missing)
 	 */
-	strbuf_init(&branch, 0);
-	strbuf_addstr(&branch, "HEAD");
-	if (frag)
-		strbuf_addf(&branch, ":refs/heads/%s", frag);
-	else
-		strbuf_addstr(&branch, ":refs/heads/master");
-	add_push_refspec(remote, strbuf_detach(&branch, NULL));
+	add_push_refspec(remote, xstrfmt("HEAD:refs/heads/%s", frag));
 	remote->fetch_tags = 1; /* always auto-follow */
 }
 
-- 
2.6.0.rc3.454.g204ad51
