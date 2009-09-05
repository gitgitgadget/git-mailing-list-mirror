From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC 3/6] status: refactor short-mode printing to its own
 function
Date: Sat, 5 Sep 2009 04:53:48 -0400
Message-ID: <20090905085348.GC13157@coredump.intra.peff.net>
References: <20090905084809.GA13073@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 10:53:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjr1y-0002RB-M7
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 10:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757118AbZIEIxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 04:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756242AbZIEIxt
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 04:53:49 -0400
Received: from peff.net ([208.65.91.99]:38075 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151AbZIEIxs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 04:53:48 -0400
Received: (qmail 26076 invoked by uid 107); 5 Sep 2009 08:54:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 05 Sep 2009 04:54:05 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Sep 2009 04:53:48 -0400
Content-Disposition: inline
In-Reply-To: <20090905084809.GA13073@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127801>

We want to be able to call it from multiple places.

Signed-off-by: Jeff King <peff@peff.net>
---
I am tempted to move all of the short-printing code to its own file, and
move "cmd_status" to its own builtin-status.c, as well. I don't know if
that is a cleanup that makes sense to others, as well, or if it is too
much churn for too little good.

 builtin-commit.c |   45 +++++++++++++++++++++++++--------------------
 1 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 812470e..5b42179 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -966,11 +966,32 @@ static void short_untracked(int null_termination, struct string_list_item *it,
 	}
 }
 
+static void short_print(struct wt_status *s, int null_termination)
+{
+	int i;
+	for (i = 0; i < s->change.nr; i++) {
+		struct wt_status_change_data *d;
+		struct string_list_item *it;
+
+		it = &(s->change.items[i]);
+		d = it->util;
+		if (d->stagemask)
+			short_unmerged(null_termination, it, s);
+		else
+			short_status(null_termination, it, s);
+	}
+	for (i = 0; i < s->untracked.nr; i++) {
+		struct string_list_item *it;
+
+		it = &(s->untracked.items[i]);
+		short_untracked(null_termination, it, s);
+	}
+}
+
 int cmd_status(int argc, const char **argv, const char *prefix)
 {
 	struct wt_status s;
 	static int null_termination, shortstatus;
-	int i;
 	unsigned char sha1[20];
 	static struct option builtin_status_options[] = {
 		OPT__VERBOSE(&verbose),
@@ -1003,25 +1024,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
 	wt_status_collect(&s);
 
-	if (shortstatus) {
-		for (i = 0; i < s.change.nr; i++) {
-			struct wt_status_change_data *d;
-			struct string_list_item *it;
-
-			it = &(s.change.items[i]);
-			d = it->util;
-			if (d->stagemask)
-				short_unmerged(null_termination, it, &s);
-			else
-				short_status(null_termination, it, &s);
-		}
-		for (i = 0; i < s.untracked.nr; i++) {
-			struct string_list_item *it;
-
-			it = &(s.untracked.items[i]);
-			short_untracked(null_termination, it, &s);
-		}
-	} else {
+	if (shortstatus)
+		short_print(&s, null_termination);
+	else {
 		s.verbose = verbose;
 		if (s.relative_paths)
 			s.prefix = prefix;
-- 
1.6.4.2.418.g1a1d3.dirty
