From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 6/8] fmt-merge-msg: refactor merge title formatting
Date: Tue, 11 May 2010 01:17:50 +0800
Message-ID: <1273511872-4924-7-git-send-email-rctay89@gmail.com>
References: <1273511872-4924-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 10 19:18:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBWd0-0007lB-Ho
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 19:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755915Ab0EJRSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 13:18:31 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63452 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755891Ab0EJRS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 13:18:28 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so1771315pwi.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 10:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=EOlUFmo3e42PQ3YjBxbhTbAs6xENPEiWrOPnH8+3ziw=;
        b=G6MJFJyQOxnlARd4v3pR/caR58M3j0tmFNJG2ML4qbew59gpOlcqUMntAKFeB+EPZ4
         Zopnb3qkT4N93gr2bwEU+1IPRRPT1NJPljqfU3PEMJODCsUeelxIoHyt9n4x+VR5RqA+
         mvWJR5v5Y+uGlemFvxgaVADX1zU2lEePJDQ5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Y/M5z3LLjolk/xxqoFD+xjFSoeEzlyxW57y2rsDfvycfX2ejcVjhxCkd3CANNeSS1Y
         d5uusiXMrlmUgQgO81I3PEsfVZtRh4fnxzDm/TCxN4MkkhjbSw1LhWyq02TZxtsPuEBD
         nbU2+aw7smCSxLEWdWtgt/NPGZIvNFPyvi/yI=
Received: by 10.115.134.14 with SMTP id l14mr3394432wan.184.1273511907602;
        Mon, 10 May 2010 10:18:27 -0700 (PDT)
Received: from localhost.localdomain (cm71.zeta153.maxonline.com.sg [116.87.153.71])
        by mx.google.com with ESMTPS id v13sm27449213wav.2.2010.05.10.10.18.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 10:18:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.337.gbd0bc
In-Reply-To: <1273511872-4924-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146838>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin/fmt-merge-msg.c |   65 ++++++++++++++++++++++++++---------------------
 1 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index a2bccd6..d0160cb 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -202,36 +202,10 @@ static void shortlog(const char *name, unsigned char *sha1,
 	string_list_clear(&subjects, 0);
 }
 
-static int do_fmt_merge_msg(int merge_summary, struct strbuf *in,
-	struct strbuf *out) {
-	int limit = 20, i = 0, pos = 0;
+static void do_fmt_merge_msg_title(struct strbuf *out,
+	const char *current_branch) {
+	int i = 0;
 	char *sep = "";
-	unsigned char head_sha1[20];
-	const char *current_branch;
-
-	/* get current branch */
-	current_branch = resolve_ref("HEAD", head_sha1, 1, NULL);
-	if (!current_branch)
-		die("No current branch");
-	if (!prefixcmp(current_branch, "refs/heads/"))
-		current_branch += 11;
-
-	/* get a line */
-	while (pos < in->len) {
-		int len;
-		char *newline, *p = in->buf + pos;
-
-		newline = strchr(p, '\n');
-		len = newline ? newline - p : strlen(p);
-		pos += len + !!newline;
-		i++;
-		p[len] = 0;
-		if (handle_line(p))
-			die ("Error in line %d: %.*s", i, len, p);
-	}
-
-	if (!srcs.nr)
-		return 0;
 
 	strbuf_addstr(out, "Merge ");
 	for (i = 0; i < srcs.nr; i++) {
@@ -279,6 +253,39 @@ static int do_fmt_merge_msg(int merge_summary, struct strbuf *in,
 		strbuf_addch(out, '\n');
 	else
 		strbuf_addf(out, " into %s\n", current_branch);
+}
+
+static int do_fmt_merge_msg(int merge_summary, struct strbuf *in,
+	struct strbuf *out) {
+	int limit = 20, i = 0, pos = 0;
+	unsigned char head_sha1[20];
+	const char *current_branch;
+
+	/* get current branch */
+	current_branch = resolve_ref("HEAD", head_sha1, 1, NULL);
+	if (!current_branch)
+		die("No current branch");
+	if (!prefixcmp(current_branch, "refs/heads/"))
+		current_branch += 11;
+
+	/* get a line */
+	while (pos < in->len) {
+		int len;
+		char *newline, *p = in->buf + pos;
+
+		newline = strchr(p, '\n');
+		len = newline ? newline - p : strlen(p);
+		pos += len + !!newline;
+		i++;
+		p[len] = 0;
+		if (handle_line(p))
+			die ("Error in line %d: %.*s", i, len, p);
+	}
+
+	if (!srcs.nr)
+		return 0;
+
+	do_fmt_merge_msg_title(out, current_branch);
 
 	if (merge_summary) {
 		struct commit *head;
-- 
1.7.1.189.g07419
