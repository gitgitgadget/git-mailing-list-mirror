From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] builtin-commit: fix --signoff
Date: Sat, 10 Nov 2007 15:58:31 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711101557520.4362@racer.site>
References: <Pine.LNX.4.64.0711100548071.4362@racer.site>
 <7vr6iyo4ff.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711101346120.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, krh@redhat.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 16:58:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqsjb-0003he-6x
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 16:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbXKJP6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 10:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbXKJP6n
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 10:58:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:43595 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751578AbXKJP6m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 10:58:42 -0500
Received: (qmail invoked by alias); 10 Nov 2007 15:58:40 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp034) with SMTP; 10 Nov 2007 16:58:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18TPQ5AzyIToVB4QWHu4/gROILMKjUiZ2hOV3rnI6
	hhv/w8DC/b/so0
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0711101346120.4362@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64354>


The Signed-off-by: line contained a spurious timestamp.  The reason was
a call to git_committer_info(1), which automatically added the
timestamp.

Instead, fmt_ident() was taught to interpret an empty string for the
date (as opposed to NULL, which still triggers the default behavior)
as "do not bother with the timestamp", and builtin-commit.c uses it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Sat, 10 Nov 2007, Johannes Schindelin wrote:

	> Will redo the patch.

	And here it is.

 builtin-commit.c  |   29 ++++++++++++++++++-----------
 ident.c           |   10 +++++++---
 t/t7500-commit.sh |   13 +++++++++++++
 3 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index e8bc4c4..a4d69ad 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -181,21 +181,28 @@ static int prepare_log_message(const char *index_file, const char *prefix)
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
+		int i;
+
+		strbuf_init(&sob, 0);
+		strbuf_addstr(&sob, sign_off_header);
+		strbuf_addstr(&sob, fmt_ident(getenv("GIT_COMMITTER_NAME"),
+                         getenv("GIT_COMMITTER_EMAIL"), "", 1));
+		strbuf_addch(&sob, '\n');
+
+		for (i = sb.len - 1; i > 0 && sb.buf[i - 1] != '\n'; i--)
+			; /* do nothing */
+		if (prefixcmp(sb.buf + i, sob.buf))
+			strbuf_addbuf(&sb, &sob);
+		strbuf_release(&sob);
 	}
 
+	if (fwrite(sb.buf, 1, sb.len, fp) < sb.len)
+		die("could not write commit template: %s\n",
+		    strerror(errno));
+
 	strbuf_release(&sb);
 
 	if (in_merge && !no_edit)
diff --git a/ident.c b/ident.c
index 9b2a852..5be7533 100644
--- a/ident.c
+++ b/ident.c
@@ -224,13 +224,17 @@ const char *fmt_ident(const char *name, const char *email,
 	}
 
 	strcpy(date, git_default_date);
-	if (date_str)
-		parse_date(date_str, date, sizeof(date));
+	if (date_str) {
+		if (*date_str)
+			parse_date(date_str, date, sizeof(date));
+		else
+			date[0] = '\0';
+	}
 
 	i = copy(buffer, sizeof(buffer), 0, name);
 	i = add_raw(buffer, sizeof(buffer), i, " <");
 	i = copy(buffer, sizeof(buffer), i, email);
-	i = add_raw(buffer, sizeof(buffer), i, "> ");
+	i = add_raw(buffer, sizeof(buffer), i, date[0] ? "> " : ">");
 	i = copy(buffer, sizeof(buffer), i, date);
 	if (i >= sizeof(buffer))
 		die("Impossibly long personal identifier");
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index abbf54b..13d5a0c 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -93,4 +93,17 @@ test_expect_success 'commit message from file should override template' '
 	commit_msg_is "standard input msg"
 '
 
+cat > expect << EOF
+zort
+Signed-off-by: C O Mitter <committer@example.com>
+EOF
+
+test_expect_success '--signoff' '
+	echo "yet another content *narf*" >> foo &&
+	echo "zort" |
+		GIT_EDITOR=../t7500/add-content git commit -s -F - foo &&
+	git cat-file commit HEAD | sed "1,/^$/d" > output &&
+	git diff expect output
+'
+
 test_done
-- 
1.5.3.5.1674.g6e7f7
