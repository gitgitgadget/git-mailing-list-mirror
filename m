From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC 4/6] status: refactor format option parsing
Date: Sat, 5 Sep 2009 04:54:14 -0400
Message-ID: <20090905085414.GD13157@coredump.intra.peff.net>
References: <20090905084809.GA13073@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 10:54:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjr2P-0002Vf-3g
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 10:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757228AbZIEIyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 04:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756674AbZIEIyP
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 04:54:15 -0400
Received: from peff.net ([208.65.91.99]:38084 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400AbZIEIyP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 04:54:15 -0400
Received: (qmail 26102 invoked by uid 107); 5 Sep 2009 08:54:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 05 Sep 2009 04:54:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Sep 2009 04:54:14 -0400
Content-Disposition: inline
In-Reply-To: <20090905084809.GA13073@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127802>

This makes it possible to have more than two formats.

Signed-off-by: Jeff King <peff@peff.net>
---
This would make a "--long" option trivial, but I'm not sure there is
much point.

 builtin-commit.c |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 5b42179..aa4a358 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -991,12 +991,16 @@ static void short_print(struct wt_status *s, int null_termination)
 int cmd_status(int argc, const char **argv, const char *prefix)
 {
 	struct wt_status s;
-	static int null_termination, shortstatus;
+	static int null_termination;
+	static enum {
+		STATUS_FORMAT_LONG,
+		STATUS_FORMAT_SHORT,
+	} status_format = STATUS_FORMAT_LONG;
 	unsigned char sha1[20];
 	static struct option builtin_status_options[] = {
 		OPT__VERBOSE(&verbose),
-		OPT_BOOLEAN('s', "short", &shortstatus,
-			    "show status concisely"),
+		OPT_SET_INT('s', "short", &status_format,
+			    "show status concisely", STATUS_FORMAT_SHORT),
 		OPT_BOOLEAN('z', "null", &null_termination,
 			    "terminate entries with NUL"),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg,
@@ -1006,8 +1010,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
-	if (null_termination)
-		shortstatus = 1;
+	if (null_termination && status_format == STATUS_FORMAT_LONG)
+		status_format = STATUS_FORMAT_SHORT;
 
 	wt_status_prepare(&s);
 	git_config(git_status_config, &s);
@@ -1024,9 +1028,11 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
 	wt_status_collect(&s);
 
-	if (shortstatus)
+	switch (status_format) {
+	case STATUS_FORMAT_SHORT:
 		short_print(&s, null_termination);
-	else {
+		break;
+	case STATUS_FORMAT_LONG:
 		s.verbose = verbose;
 		if (s.relative_paths)
 			s.prefix = prefix;
@@ -1035,6 +1041,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		if (diff_use_color_default == -1)
 			diff_use_color_default = git_use_color_default;
 		wt_status_print(&s);
+		break;
 	}
 	return 0;
 }
-- 
1.6.4.2.418.g1a1d3.dirty
