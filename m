From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 33/67] read_branches_file: replace strcpy with xstrdup
Date: Thu, 17 Sep 2015 07:28:56 -0400
Message-ID: <20150917112856.GA22085@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915154950.GG29753@sigill.intra.peff.net>
 <xmqqlhc6p2f9.fsf@gitster.mtv.corp.google.com>
 <20150916204226.GE3915@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 13:29:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcXNB-0006sl-0n
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 13:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbbIQL3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 07:29:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:60736 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751339AbbIQL27 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 07:28:59 -0400
Received: (qmail 22182 invoked by uid 102); 17 Sep 2015 11:28:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Sep 2015 06:28:58 -0500
Received: (qmail 29454 invoked by uid 107); 17 Sep 2015 11:29:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Sep 2015 07:29:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Sep 2015 07:28:56 -0400
Content-Disposition: inline
In-Reply-To: <20150916204226.GE3915@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278108>

On Wed, Sep 16, 2015 at 04:42:26PM -0400, Jeff King wrote:

> > We use buffer[BUFSIZ] to read various things in this file, not just
> > $GIT_DIR/branches/* files, with fgets(), which may be better done if
> > we switched to strbuf_getline().  Then we can also use trim family
> > of calls from the strbuf API suite.
> >
> > Move to strbuf_getline() may be a doubly attractive proposition,
> > with a possible change to strbuf_getline() to make it also remove CR
> > that immediately precedes LF [*1*], helping DOSsy platforms.
> 
> I'll take a look and see how painful this is.

I think that this already works, because we strip whitespace from the
right side of the buffer (and isspace('\r') returns true). Likewise, I
don't think we need to teach strbuf_getline() about CRs for the same
reason (I agree it would be a good thing to do in general, but I stopped
short here).

Here is the patch I ended up with:

-- >8 --
Subject: [PATCH] read_branches_file: simplify string handling

This function does a lot of manual string handling, and has
some unnecessary limits. This patch cleans up a number of
things:

  1. Drop the arbitrary 1000-byte limit on the size of the
     remote name (we do not have such a limit in any of the
     other remote-reading mechanisms).

  2. Replace fgets into a fixed-size buffer with a strbuf,
     eliminating any limits on the length of the URL.

     This uses strbuf_read_file for simplicity. Technically
     this behavior is different than the original, as we
     will read the whole file content, whereas the original
     simply ignored subsequent lines.

     Given that branches files are supposed to be one line,
     this doesn't matter in practice (and arguably including
     the extra lines is better, as it will probably cause
     the URL to be bogus and bring attention to the issue).

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
I guess (2) could be wrong if people are counting on adding arbitrary
comment lines to the end of a "branches" file, but AFAIK that has never
been a thing.

 remote.c | 54 +++++++++++++++++++-----------------------------------
 1 file changed, 19 insertions(+), 35 deletions(-)

diff --git a/remote.c b/remote.c
index 5ab0f7f..2bef5a4 100644
--- a/remote.c
+++ b/remote.c
@@ -293,56 +293,40 @@ static void read_remotes_file(struct remote *remote)
 static void read_branches_file(struct remote *remote)
 {
 	char *frag;
-	struct strbuf branch = STRBUF_INIT;
-	int n = 1000;
-	FILE *f = fopen(git_path("branches/%.*s", n, remote->name), "r");
-	char *s, *p;
-	int len;
+	struct strbuf buf = STRBUF_INIT;
 
-	if (!f)
+	if (strbuf_read_file(&buf, git_path("branches/%s", remote->name), 0) < 0)
 		return;
-	s = fgets(buffer, BUF_SIZE, f);
-	fclose(f);
-	if (!s)
-		return;
-	while (isspace(*s))
-		s++;
-	if (!*s)
+
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
2.6.0.rc2.408.ga2926b9
