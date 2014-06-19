From: Jeff King <peff@peff.net>
Subject: [PATCH v2 08/10] merge: use argv_array when spawning merge strategy
Date: Thu, 19 Jun 2014 17:29:31 -0400
Message-ID: <20140619212931.GH28474@sigill.intra.peff.net>
References: <20140619211659.GA32412@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 23:29:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxjtq-0003YN-T6
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 23:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965736AbaFSV3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 17:29:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:47801 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964833AbaFSV3d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 17:29:33 -0400
Received: (qmail 17230 invoked by uid 102); 19 Jun 2014 21:29:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Jun 2014 16:29:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jun 2014 17:29:31 -0400
Content-Disposition: inline
In-Reply-To: <20140619211659.GA32412@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252191>

This is shorter, and avoids a rather complicated set of
allocation and free steps.

Signed-off-by: Jeff King <peff@peff.net>
---
 merge.c | 42 +++++++++++++-----------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/merge.c b/merge.c
index 70f1000..1fa6e52 100644
--- a/merge.c
+++ b/merge.c
@@ -18,39 +18,23 @@ int try_merge_command(const char *strategy, size_t xopts_nr,
 		      const char **xopts, struct commit_list *common,
 		      const char *head_arg, struct commit_list *remotes)
 {
-	const char **args;
-	int i = 0, x = 0, ret;
+	struct argv_array args = ARGV_ARRAY_INIT;
+	int i, ret;
 	struct commit_list *j;
-	struct strbuf buf = STRBUF_INIT;
 
-	args = xmalloc((4 + xopts_nr + commit_list_count(common) +
-			commit_list_count(remotes)) * sizeof(char *));
-	strbuf_addf(&buf, "merge-%s", strategy);
-	args[i++] = buf.buf;
-	for (x = 0; x < xopts_nr; x++) {
-		char *s = xmalloc(strlen(xopts[x])+2+1);
-		strcpy(s, "--");
-		strcpy(s+2, xopts[x]);
-		args[i++] = s;
-	}
-	for (j = common; j; j = j->next)
-		args[i++] = xstrdup(merge_argument(j->item));
-	args[i++] = "--";
-	args[i++] = head_arg;
-	for (j = remotes; j; j = j->next)
-		args[i++] = xstrdup(merge_argument(j->item));
-	args[i] = NULL;
-	ret = run_command_v_opt(args, RUN_GIT_CMD);
-	strbuf_release(&buf);
-	i = 1;
-	for (x = 0; x < xopts_nr; x++)
-		free((void *)args[i++]);
+	argv_array_pushf(&args, "merge-%s", strategy);
+	for (i = 0; i < xopts_nr; i++)
+		argv_array_pushf(&args, "--%s", xopts[i]);
 	for (j = common; j; j = j->next)
-		free((void *)args[i++]);
-	i += 2;
+		argv_array_push(&args, merge_argument(j->item));
+	argv_array_push(&args, "--");
+	argv_array_push(&args, head_arg);
 	for (j = remotes; j; j = j->next)
-		free((void *)args[i++]);
-	free(args);
+		argv_array_push(&args, merge_argument(j->item));
+
+	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
+	argv_array_clear(&args);
+
 	discard_cache();
 	if (read_cache() < 0)
 		die(_("failed to read the cache"));
-- 
2.0.0.566.gfe3e6b2
