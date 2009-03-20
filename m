From: Jeff King <peff@peff.net>
Subject: [PATCH] make oneline reflog dates more consistent with multiline
	format
Date: Fri, 20 Mar 2009 02:00:43 -0400
Message-ID: <20090320060043.GA27008@coredump.intra.peff.net>
References: <49C249B9.7010001@drmicha.warpmail.net> <1cd1989b0903190643p19a40718yc4fd2730aab0a9a0@mail.gmail.com> <49C24D9B.1060301@drmicha.warpmail.net> <1cd1989b0903190701uac4602dl1d2c3cace45a9938@mail.gmail.com> <20090319151610.GO23521@spearce.org> <1cd1989b0903190850p1a08991y754904e7799c7879@mail.gmail.com> <20090319201405.GD17028@coredump.intra.peff.net> <9b18b3110903191440w20ca9801pfb218cc4b10ea769@mail.gmail.com> <20090319214317.GU23521@spearce.org> <20090320052802.GA27714@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, demerphq <demerphq@gmail.com>,
	Git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 20 07:02:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkXoF-0000Wp-AT
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 07:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038AbZCTGAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 02:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752251AbZCTGAy
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 02:00:54 -0400
Received: from peff.net ([208.65.91.99]:39022 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838AbZCTGAx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 02:00:53 -0400
Received: (qmail 6798 invoked by uid 107); 20 Mar 2009 06:01:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 20 Mar 2009 02:01:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2009 02:00:43 -0400
Content-Disposition: inline
In-Reply-To: <20090320052802.GA27714@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113898>

The multiline reflog format (e.g., as shown by "git log -g")
will show HEAD@{<date>} rather than HEAD@{<count>} in two
situations:

  1. If the user gave branch@{<date>} syntax to specify the
     reflog

  2. If the user gave a --date=<format> specifier

It uses the "normal" date format in case 1, and the
user-specified format in case 2.

The oneline reflog format (e.g., "git reflog show" or "git
log -g --oneline") will show the date in the same two
circumstances. However, it _always_ shows the date as a
relative date, and it always ignores the timezone.

In case 2, it seems ridiculous to trigger the date but use a
format totally different from what the user requested.

For case 1, it is arguable that the user might want to see
the relative date by default; however, the multiline version
shows the normal format.

This patch does three things:

  - refactors the "relative_date" parameter to
    show_reflog_message to be an actual date_mode enum,
    since this is how it is used (it is passed to show_date)

  - uses the passed date_mode parameter in the oneline
    format (making it consistent with the multiline format)

  - does not ignore the timezone parameter in oneline mode

Signed-off-by: Jeff King <peff@peff.net>
---
 reflog-walk.c          |   12 +++++---
 reflog-walk.h          |    5 +++-
 t/t1411-reflog-show.sh |   67 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 6 deletions(-)
 create mode 100755 t/t1411-reflog-show.sh

diff --git a/reflog-walk.c b/reflog-walk.c
index f751fdc..fd065f4 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -242,7 +242,7 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 }
 
 void show_reflog_message(struct reflog_walk_info* info, int oneline,
-	int relative_date)
+	enum date_mode dmode)
 {
 	if (info && info->last_commit_reflog) {
 		struct commit_reflog *commit_reflog = info->last_commit_reflog;
@@ -251,8 +251,10 @@ void show_reflog_message(struct reflog_walk_info* info, int oneline,
 		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
 		if (oneline) {
 			printf("%s@{", commit_reflog->reflogs->ref);
-			if (commit_reflog->flag || relative_date)
-				printf("%s", show_date(info->timestamp, 0, 1));
+			if (commit_reflog->flag || dmode)
+				printf("%s", show_date(info->timestamp,
+						       info->tz,
+						       dmode));
 			else
 				printf("%d", commit_reflog->reflogs->nr
 				       - 2 - commit_reflog->recno);
@@ -260,10 +262,10 @@ void show_reflog_message(struct reflog_walk_info* info, int oneline,
 		}
 		else {
 			printf("Reflog: %s@{", commit_reflog->reflogs->ref);
-			if (commit_reflog->flag || relative_date)
+			if (commit_reflog->flag || dmode)
 				printf("%s", show_date(info->timestamp,
 							info->tz,
-							relative_date));
+							dmode));
 			else
 				printf("%d", commit_reflog->reflogs->nr
 				       - 2 - commit_reflog->recno);
diff --git a/reflog-walk.h b/reflog-walk.h
index 7ca1438..74c9096 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -1,11 +1,14 @@
 #ifndef REFLOG_WALK_H
 #define REFLOG_WALK_H
 
+#include "cache.h"
+
 extern void init_reflog_walk(struct reflog_walk_info** info);
 extern int add_reflog_for_walk(struct reflog_walk_info *info,
 		struct commit *commit, const char *name);
 extern void fake_reflog_parent(struct reflog_walk_info *info,
 		struct commit *commit);
-extern void show_reflog_message(struct reflog_walk_info *info, int, int);
+extern void show_reflog_message(struct reflog_walk_info *info, int,
+		enum date_mode);
 
 #endif
diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
new file mode 100755
index 0000000..c18ed8e
--- /dev/null
+++ b/t/t1411-reflog-show.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+
+test_description='Test reflog display routines'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo content >file &&
+	git add file &&
+	test_tick &&
+	git commit -m one
+'
+
+cat >expect <<'EOF'
+Reflog: HEAD@{0} (C O Mitter <committer@example.com>)
+Reflog message: commit (initial): one
+EOF
+test_expect_success 'log -g shows reflog headers' '
+	git log -g -1 >tmp &&
+	grep ^Reflog <tmp >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+e46513e HEAD@{0}: commit (initial): one
+EOF
+test_expect_success 'oneline reflog format' '
+	git log -g -1 --oneline >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+Reflog: HEAD@{Thu Apr 7 15:13:13 2005 -0700} (C O Mitter <committer@example.com>)
+Reflog message: commit (initial): one
+EOF
+test_expect_success 'using @{now} syntax shows reflog date (multiline)' '
+	git log -g -1 HEAD@{now} >tmp &&
+	grep ^Reflog <tmp >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+e46513e HEAD@{Thu Apr 7 15:13:13 2005 -0700}: commit (initial): one
+EOF
+test_expect_success 'using @{now} syntax shows reflog date (oneline)' '
+	git log -g -1 --oneline HEAD@{now} >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+Reflog: HEAD@{1112911993 -0700} (C O Mitter <committer@example.com>)
+Reflog message: commit (initial): one
+EOF
+test_expect_success 'using --date= shows reflog date (multiline)' '
+	git log -g -1 --date=raw >tmp &&
+	grep ^Reflog <tmp >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+e46513e HEAD@{1112911993 -0700}: commit (initial): one
+EOF
+test_expect_success 'using --date= shows reflog date (oneline)' '
+	git log -g -1 --oneline --date=raw >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.6.2.1.342.gdbf4
