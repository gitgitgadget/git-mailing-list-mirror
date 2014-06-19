From: Jeff King <peff@peff.net>
Subject: [PATCH v2 03/10] use xstrdup instead of xmalloc + strcpy
Date: Thu, 19 Jun 2014 17:19:43 -0400
Message-ID: <20140619211942.GC28474@sigill.intra.peff.net>
References: <20140619211659.GA32412@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 23:19:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxjkM-0006D7-Mr
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 23:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965847AbaFSVTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 17:19:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:47774 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965706AbaFSVTo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 17:19:44 -0400
Received: (qmail 16555 invoked by uid 102); 19 Jun 2014 21:19:44 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Jun 2014 16:19:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jun 2014 17:19:43 -0400
Content-Disposition: inline
In-Reply-To: <20140619211659.GA32412@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252186>

This is one line shorter, and makes sure the length in the
malloc and copy steps match.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c | 5 +----
 http-push.c            | 6 ++----
 http-walker.c          | 3 +--
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c323081..18458e8 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -614,12 +614,9 @@ static void run_update_post_hook(struct command *commands)
 	argv[0] = hook;
 
 	for (argc = 1, cmd = commands; cmd; cmd = cmd->next) {
-		char *p;
 		if (cmd->error_string || cmd->did_not_exist)
 			continue;
-		p = xmalloc(strlen(cmd->ref_name) + 1);
-		strcpy(p, cmd->ref_name);
-		argv[argc] = p;
+		argv[argc] = xstrdup(cmd->ref_name);
 		argc++;
 	}
 	argv[argc] = NULL;
diff --git a/http-push.c b/http-push.c
index de00d16..95650a0 100644
--- a/http-push.c
+++ b/http-push.c
@@ -767,15 +767,13 @@ static void handle_new_lock_ctx(struct xml_ctx *ctx, int tag_closed)
 
 	if (tag_closed && ctx->cdata) {
 		if (!strcmp(ctx->name, DAV_ACTIVELOCK_OWNER)) {
-			lock->owner = xmalloc(strlen(ctx->cdata) + 1);
-			strcpy(lock->owner, ctx->cdata);
+			lock->owner = xstrdup(ctx->cdata);
 		} else if (!strcmp(ctx->name, DAV_ACTIVELOCK_TIMEOUT)) {
 			if (starts_with(ctx->cdata, "Second-"))
 				lock->timeout =
 					strtol(ctx->cdata + 7, NULL, 10);
 		} else if (!strcmp(ctx->name, DAV_ACTIVELOCK_TOKEN)) {
-			lock->token = xmalloc(strlen(ctx->cdata) + 1);
-			strcpy(lock->token, ctx->cdata);
+			lock->token = xstrdup(ctx->cdata);
 
 			git_SHA1_Init(&sha_ctx);
 			git_SHA1_Update(&sha_ctx, lock->token, strlen(lock->token));
diff --git a/http-walker.c b/http-walker.c
index 1516c5e..ab6a4fe 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -566,8 +566,7 @@ struct walker *get_http_walker(const char *url)
 	struct walker *walker = xmalloc(sizeof(struct walker));
 
 	data->alt = xmalloc(sizeof(*data->alt));
-	data->alt->base = xmalloc(strlen(url) + 1);
-	strcpy(data->alt->base, url);
+	data->alt->base = xstrdup(url);
 	for (s = data->alt->base + strlen(data->alt->base) - 1; *s == '/'; --s)
 		*s = 0;
 
-- 
2.0.0.566.gfe3e6b2
