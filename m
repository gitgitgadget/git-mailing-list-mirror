From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] reflog-walk: clean up "flag" field of commit_reflog
 struct
Date: Fri, 4 May 2012 01:26:26 -0400
Message-ID: <20120504052626.GC16107@sigill.intra.peff.net>
References: <20120504052106.GA15970@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yann Hodique <yann.hodique@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	magit@googlegroups.com
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Fri May 04 07:26:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQB2H-0000zP-9y
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 07:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503Ab2EDF03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 01:26:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57549
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807Ab2EDF03 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 01:26:29 -0400
Received: (qmail 15158 invoked by uid 107); 4 May 2012 05:26:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 May 2012 01:26:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 May 2012 01:26:26 -0400
Content-Disposition: inline
In-Reply-To: <20120504052106.GA15970@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196991>

When we prepare to walk a reflog, we parse the specification
and pull some information from it, such as which reflog to
look in (e.g., HEAD), and where to start (e.g., HEAD@{10} or
HEAD@{yesterday}). The resulting struct has a "recno" field
to show where in the reflog we are starting. It also has a
"flag" field; if true, it means the recno field came from
parsing a date like HEAD@{yesterday}.

There are two problems with this:

  1. "flag" is an absolutely terrible name, as it conveys
     nothing about the meaning

  2. you can tell "HEAD" from "HEAD@{yesterday}", but you
     can't differentiate "HEAD" from "HEAD{0}"

This patch converts the flag into a tri-state (and gives it
a better name!).

Signed-off-by: Jeff King <peff@peff.net>
---
 reflog-walk.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index 86d1884..3549318 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -126,7 +126,12 @@ static void add_commit_info(struct commit *commit, void *util,
 }
 
 struct commit_reflog {
-	int flag, recno;
+	int recno;
+	enum selector_type {
+		SELECTOR_NONE,
+		SELECTOR_INDEX,
+		SELECTOR_DATE
+	} selector;
 	struct complete_reflogs *reflogs;
 };
 
@@ -150,6 +155,7 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 	struct complete_reflogs *reflogs;
 	char *branch, *at = strchr(name, '@');
 	struct commit_reflog *commit_reflog;
+	enum selector_type selector = SELECTOR_NONE;
 
 	if (commit->object.flags & UNINTERESTING)
 		die ("Cannot walk reflogs for %s", name);
@@ -162,7 +168,10 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 		if (*ep != '}') {
 			recno = -1;
 			timestamp = approxidate(at + 2);
+			selector = SELECTOR_DATE;
 		}
+		else
+			selector = SELECTOR_INDEX;
 	} else
 		recno = 0;
 
@@ -200,7 +209,6 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 
 	commit_reflog = xcalloc(sizeof(struct commit_reflog), 1);
 	if (recno < 0) {
-		commit_reflog->flag = 1;
 		commit_reflog->recno = get_reflog_recno_by_time(reflogs, timestamp);
 		if (commit_reflog->recno < 0) {
 			free(branch);
@@ -209,6 +217,7 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 		}
 	} else
 		commit_reflog->recno = reflogs->nr - recno - 1;
+	commit_reflog->selector = selector;
 	commit_reflog->reflogs = reflogs;
 
 	add_commit_info(commit, commit_reflog, &info->reflogs);
@@ -267,7 +276,7 @@ void get_reflog_selector(struct strbuf *sb,
 	}
 
 	strbuf_addf(sb, "%s@{", printed_ref);
-	if (commit_reflog->flag || dmode) {
+	if (commit_reflog->selector == SELECTOR_DATE || dmode) {
 		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
 		strbuf_addstr(sb, show_date(info->timestamp, info->tz, dmode));
 	} else {
-- 
1.7.10.1.10.ge534bc3
