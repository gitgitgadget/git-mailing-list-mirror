From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] wt-status: refactor initial commit printing
Date: Wed, 12 Nov 2008 03:21:39 -0500
Message-ID: <20081112082138.GB3751@coredump.intra.peff.net>
References: <20081112081609.GA3720@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 09:22:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0B04-0008CX-Jj
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 09:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbYKLIVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 03:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbYKLIVm
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 03:21:42 -0500
Received: from peff.net ([208.65.91.99]:3165 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751206AbYKLIVl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 03:21:41 -0500
Received: (qmail 17647 invoked by uid 111); 12 Nov 2008 08:21:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Nov 2008 03:21:40 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Nov 2008 03:21:39 -0500
Content-Disposition: inline
In-Reply-To: <20081112081609.GA3720@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100723>

When we showed the initial commit, we had no reference to
diff against, so we went through the cache manually.
Nowadays, however, we have a virtual empty tree commit, so
we can simply diff against that to get the same results.

Signed-off-by: Jeff King <peff@peff.net>
---
I ran across this when I realized I could do the same trick for the
verbose diff (which I will do in the next patch). I think it is a
worthwhile cleanup. Not only does it remove a lot of lines, but it gives
a single codepath for printing, which will be helpful if that codepath
ever changes (e.g., with the alternate status formats we talked about a
few weeks ago).

This could be made even simpler by setting s->reference to the empty
tree when we are on the initial commit, but I think that is a little
messy. The caller may have set s->reference to an arbitrary pointer,
including one which needs free()d, and we would be overwriting that.
As it happens, with the current callers there is no problem, but it
seems like a bad interface.

 wt-status.c |   28 +++-------------------------
 1 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 6a7645e..c78588e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -185,31 +185,12 @@ static void wt_status_print_changed_cb(struct diff_queue_struct *q,
 		wt_status_print_trailer(s);
 }
 
-static void wt_status_print_initial(struct wt_status *s)
-{
-	int i;
-	struct strbuf buf = STRBUF_INIT;
-
-	if (active_nr) {
-		s->commitable = 1;
-		wt_status_print_cached_header(s);
-	}
-	for (i = 0; i < active_nr; i++) {
-		color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
-		color_fprintf_ln(s->fp, color(WT_STATUS_UPDATED), "new file: %s",
-				quote_path(active_cache[i]->name, -1,
-					   &buf, s->prefix));
-	}
-	if (active_nr)
-		wt_status_print_trailer(s);
-	strbuf_release(&buf);
-}
-
 static void wt_status_print_updated(struct wt_status *s)
 {
 	struct rev_info rev;
 	init_revisions(&rev, NULL);
-	setup_revisions(0, NULL, &rev, s->reference);
+	setup_revisions(0, NULL, &rev,
+		s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference);
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = wt_status_print_updated_cb;
 	rev.diffopt.format_callback_data = s;
@@ -360,12 +341,9 @@ void wt_status_print(struct wt_status *s)
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "# Initial commit");
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
-		wt_status_print_initial(s);
-	}
-	else {
-		wt_status_print_updated(s);
 	}
 
+	wt_status_print_updated(s);
 	wt_status_print_changed(s);
 	if (wt_status_submodule_summary)
 		wt_status_print_submodule_summary(s);
-- 
1.6.0.4.883.g4593ee.dirty
