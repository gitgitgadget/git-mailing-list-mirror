From: Carl Worth <cworth@cworth.org>
Subject: [PATCH] format-patch: Emit bare email rather than mbox for single messages.
Date: Tue,  8 Jun 2010 16:43:35 -0700
Message-ID: <1276040615-26008-1-git-send-email-cworth@cworth.org>
Cc: Carl Worth <cworth@cworth.org>
To: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 01:44:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM8T2-0006Gi-0o
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 01:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014Ab0FHXnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 19:43:49 -0400
Received: from u15218177.onlinehome-server.com ([74.208.220.233]:49675 "EHLO
	olra.theworths.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971Ab0FHXnt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 19:43:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 61C114196F3;
	Tue,  8 Jun 2010 16:43:48 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xHfHhy9v3TUI; Tue,  8 Jun 2010 16:43:36 -0700 (PDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 4176C431FC1;
	Tue,  8 Jun 2010 16:43:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148736>

We don't need an mbox when generating a file with just a single
message. And tools tools such as "git am" and "git send-email" already
handle a bare email rather than an mbox just fine. Users wanting to
manually insert the output into an MUA are not likely to want an
mbox-formatted file either.

Finally, git's current mbox formatting is not robust, (does not yet
deal well with a commit message containing a line matching "^From ").

For all of these reasons, it's better to just generate an email
message rather than an mbox when generating a file with a single
message.

Note that "format-patch --stdout" will still use the (less than
totally robust) mbox format, even if there is only a single
commit. This is because "git rebase" uses "format-patch --stdout" with
"am --rebasing" which looks at the generated "From " line to find the
commit identifier that is embedded there.

Signed-off-by: Carl Worth <cworth@cworth.org>
---

This is as recently discussed by myself and H. Peter Anvin on the
list.

Note that I originally claimed that git-send-email would need to be
updated to support this mode, but I found that it actually already has
the necessary code.

Also, this patch doesn't add any new test cases only because the test
suite seems to provide good coverange of "git format-patch" usage
already, (generating and using both mbox and non-mbox output after
this patch). Indeed the test suite showed me a problem I had with
"git rebase" in an early version of this patch.

 builtin/log.c |    4 +++-
 log-tree.c    |    6 ++++--
 revision.h    |    3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 976e16f..adbec9f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1205,7 +1205,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		get_patch_ids(&rev, &ids, prefix);
 	}
 
-	if (!use_stdout)
+	if (use_stdout)
+		rev.format_mbox = 1;
+	else
 		realstdout = xfdopen(xdup(1), "w");
 
 	if (prepare_revision_walk(&rev))
diff --git a/log-tree.c b/log-tree.c
index d3ae969..6aab273 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -217,8 +217,10 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 		subject = "Subject: ";
 	}
 
-	printf("From %s Mon Sep 17 00:00:00 2001\n", name);
-	graph_show_oneline(opt->graph);
+	if (opt->format_mbox) {
+		printf("From %s Mon Sep 17 00:00:00 2001\n", name);
+		graph_show_oneline(opt->graph);
+	}
 	if (opt->message_id) {
 		printf("Message-Id: <%s>\n", opt->message_id);
 		graph_show_oneline(opt->graph);
diff --git a/revision.h b/revision.h
index 568f1c9..10cc747 100644
--- a/revision.h
+++ b/revision.h
@@ -88,7 +88,8 @@ struct rev_info {
 			abbrev_commit:1,
 			use_terminator:1,
 			missing_newline:1,
-			date_mode_explicit:1;
+			date_mode_explicit:1,
+			format_mbox:1;
 	unsigned int	disable_stdin:1;
 
 	enum date_mode date_mode;
-- 
1.7.0.4
