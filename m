From: Jeff King <peff@peff.net>
Subject: [PATCH 08/17] remote.c: drop extraneous local variable from
 migrate_file
Date: Mon, 10 Aug 2015 05:35:49 -0400
Message-ID: <20150810093549.GH30981@sigill.intra.peff.net>
References: <20150810092731.GA9027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 11:35:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjUs-0004Qt-OE
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964AbbHJJfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:35:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:42832 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753851AbbHJJfy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 05:35:54 -0400
Received: (qmail 30926 invoked by uid 102); 10 Aug 2015 09:35:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 04:35:54 -0500
Received: (qmail 3152 invoked by uid 107); 10 Aug 2015 09:36:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 05:36:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 05:35:49 -0400
Content-Disposition: inline
In-Reply-To: <20150810092731.GA9027@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275574>

It's an anti-pattern to assign the result of git_path to a
variable, since other calls may reuse our buffer. In this
case, we feed the result to unlink_or_warn immediately
afterwards, so it's OK. However, it's nice to avoid
assignment entirely, which makes it more obvious that
there's no bug.

We can just pass the result directly to unlink_or_warn,
which is a known-simple function. As a bonus, the code flow
is a little more obvious, as we eliminate an extra
conditional (a reader does not have to wonder any more
"under which circumstances is 'path' set?").

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/remote.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index cc3c741..181668d 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -581,7 +581,6 @@ static int migrate_file(struct remote *remote)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int i;
-	const char *path = NULL;
 
 	strbuf_addf(&buf, "remote.%s.url", remote->name);
 	for (i = 0; i < remote->url_nr; i++)
@@ -601,11 +600,9 @@ static int migrate_file(struct remote *remote)
 			return error(_("Could not append '%s' to '%s'"),
 					remote->fetch_refspec[i], buf.buf);
 	if (remote->origin == REMOTE_REMOTES)
-		path = git_path("remotes/%s", remote->name);
+		unlink_or_warn(git_path("remotes/%s", remote->name));
 	else if (remote->origin == REMOTE_BRANCHES)
-		path = git_path("branches/%s", remote->name);
-	if (path)
-		unlink_or_warn(path);
+		unlink_or_warn(git_path("branches/%s", remote->name));
 	return 0;
 }
 
-- 
2.5.0.414.g670f2a4
