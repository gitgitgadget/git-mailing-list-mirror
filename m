From: Jeff King <peff@peff.net>
Subject: [PATCH 2/7] wt_status: fix signedness mismatch in strbuf_read call
Date: Sun, 22 Mar 2015 06:00:32 -0400
Message-ID: <20150322100032.GB11615@peff.net>
References: <20150322095924.GA24651@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 11:00:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZcgW-00053b-AA
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 11:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbbCVKAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 06:00:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:36702 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751658AbbCVKAe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 06:00:34 -0400
Received: (qmail 32268 invoked by uid 102); 22 Mar 2015 10:00:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 05:00:34 -0500
Received: (qmail 6928 invoked by uid 107); 22 Mar 2015 10:00:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 06:00:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2015 06:00:32 -0400
Content-Disposition: inline
In-Reply-To: <20150322095924.GA24651@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266060>

We call strbuf_read(), and want to know whether we got any
output. To do so, we assign the result to a size_t, and
check whether it is non-zero.

But strbuf_read returns a signed ssize_t. If it encounters
an error, it will return -1, and we'll end up treating this
the same as if we had gotten output. Instead, we can just
check whether our buffer has anything in it (which is what
we care about anyway, and is the same thing since we know
the buffer was empty to begin with).

Note that the "len" variable actually has two roles in this
function. Now that we've eliminated the first, we can push the
declaration closer to the point of use for the second one.

Signed-off-by: Jeff King <peff@peff.net>
---
 wt-status.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 1712762..b47f6d9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -729,7 +729,6 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
 	struct strbuf cmd_stdout = STRBUF_INIT;
 	struct strbuf summary = STRBUF_INIT;
 	char *summary_content;
-	size_t len;
 
 	argv_array_pushf(&sm_summary.env_array, "GIT_INDEX_FILE=%s",
 			 s->index_file);
@@ -749,10 +748,10 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
 
 	run_command(&sm_summary);
 
-	len = strbuf_read(&cmd_stdout, sm_summary.out, 1024);
+	strbuf_read(&cmd_stdout, sm_summary.out, 1024);
 
 	/* prepend header, only if there's an actual output */
-	if (len) {
+	if (cmd_stdout.len) {
 		if (uncommitted)
 			strbuf_addstr(&summary, _("Submodules changed but not updated:"));
 		else
@@ -763,6 +762,7 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
 	strbuf_release(&cmd_stdout);
 
 	if (s->display_comment_prefix) {
+		size_t len;
 		summary_content = strbuf_detach(&summary, &len);
 		strbuf_add_commented_lines(&summary, summary_content, len);
 		free(summary_content);
-- 
2.3.3.618.ga041503
