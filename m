From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] builtin-commit: fix --signoff
Date: Sat, 10 Nov 2007 05:49:14 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711100548071.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Nov 10 06:49:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqjDv-0003IR-NN
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 06:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbXKJFtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 00:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbXKJFtY
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 00:49:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:59836 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751103AbXKJFtY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 00:49:24 -0500
Received: (qmail invoked by alias); 10 Nov 2007 05:49:21 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp040) with SMTP; 10 Nov 2007 06:49:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+7uGFSdCa7/MeaEx8t18ICTM1x19oJTHFlDlmlfM
	mhtGzmCkN1nCyq
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64304>


The Signed-off-by: line contained a spurious timestamp.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-commit.c |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index e8bc4c4..f79ad48 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -181,21 +181,30 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 		die("could not open %s\n", git_path(commit_editmsg));
 
 	stripspace(&sb, 0);
-	if (fwrite(sb.buf, 1, sb.len, fp) < sb.len)
-		die("could not write commit template: %s\n",
-		    strerror(errno));
 
 	if (signoff) {
-		const char *info, *bol;
-
-		info = git_committer_info(1);
-		strbuf_addch(&sb, '\0');
-		bol = strrchr(sb.buf + sb.len - 1, '\n');
-		if (!bol || prefixcmp(bol, sign_off_header))
-			fprintf(fp, "\n");
-		fprintf(fp, "%s%s\n", sign_off_header, git_committer_info(1));
+		struct strbuf sob;
+		const char *p;
+		int i;
+
+		strbuf_init(&sob, 0);
+		strbuf_addstr(&sob, sign_off_header);
+		strbuf_addstr(&sob, git_committer_info(1));
+		p = strrchr(sob.buf, '>');
+		if (p)
+			strbuf_setlen(&sob, p + 1 - sob.buf);
+		strbuf_addch(&sob, '\n');
+
+		for (i = sb.len - 1; i > 0 && sb.buf[i - 1] != '\n'; i--)
+			; /* do nothing */
+		if (prefixcmp(sb.buf + i, sob.buf))
+			strbuf_addbuf(&sb, &sob);
 	}
 
+	if (fwrite(sb.buf, 1, sb.len, fp) < sb.len)
+		die("could not write commit template: %s\n",
+		    strerror(errno));
+
 	strbuf_release(&sb);
 
 	if (in_merge && !no_edit)
-- 
1.5.3.5.1674.g6e7f7
