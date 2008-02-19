From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 3/4] Combine To: and Cc: headers
Date: Tue, 19 Feb 2008 02:40:33 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802190239500.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 08:41:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRN6k-0006Rf-JJ
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 08:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760171AbYBSHkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 02:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760122AbYBSHkf
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 02:40:35 -0500
Received: from iabervon.org ([66.92.72.58]:33332 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760058AbYBSHke (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 02:40:34 -0500
Received: (qmail 16214 invoked by uid 1000); 19 Feb 2008 07:40:33 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Feb 2008 07:40:33 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74386>

RFC 2822 only permits a single To: header and a single Cc: header, so
we need to turn multiple values of each of these into a list. This
will be particularly significant with a command-line option to add Cc:
headers, where the user can't make sure to configure valid header sets
in any easy way.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-log.c           |   78 ++++++++++++++++++++++++++++++++++++++--------
 t/t4014-format-patch.sh |    2 +-
 2 files changed, 65 insertions(+), 15 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 73b6d53..ae62668 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -411,28 +411,47 @@ static int istitlechar(char c)
 		(c >= '0' && c <= '9') || c == '.' || c == '_';
 }
 
-static char *extra_headers = NULL;
-static int extra_headers_size = 0;
 static const char *fmt_patch_suffix = ".patch";
 static int numbered = 0;
 static int auto_number = 0;
 
+static char **extra_hdr;
+static int extra_hdr_nr;
+static int extra_hdr_alloc;
+
+static char **extra_to;
+static int extra_to_nr;
+static int extra_to_alloc;
+
+static char **extra_cc;
+static int extra_cc_nr;
+static int extra_cc_alloc;
+
+static void add_header(const char *value)
+{
+	int len = strlen(value);
+	while (value[len - 1] == '\n')
+		len--;
+	if (!strncasecmp(value, "to: ", 4)) {
+		ALLOC_GROW(extra_to, extra_to_nr + 1, extra_to_alloc);
+		extra_to[extra_to_nr++] = xstrndup(value + 4, len - 4);
+		return;
+	}
+	if (!strncasecmp(value, "cc: ", 4)) {
+		ALLOC_GROW(extra_cc, extra_cc_nr + 1, extra_cc_alloc);
+		extra_cc[extra_cc_nr++] = xstrndup(value + 4, len - 4);
+		return;
+	}
+	ALLOC_GROW(extra_hdr, extra_hdr_nr + 1, extra_hdr_alloc);
+	extra_hdr[extra_hdr_nr++] = xstrndup(value, len);
+}
+
 static int git_format_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "format.headers")) {
-		int len;
-
 		if (!value)
 			die("format.headers without value");
-		len = strlen(value);
-		while (value[len - 1] == '\n')
-			len--;
-		extra_headers_size += len + 2;
-		extra_headers = xrealloc(extra_headers, extra_headers_size);
-		extra_headers[extra_headers_size - len - 2] = 0;
-		strcat(extra_headers, value);
-		extra_headers[extra_headers_size - 2] = '\n';
-		extra_headers[extra_headers_size - 1] = 0;
+		add_header(value);
 		return 0;
 	}
 	if (!strcmp(var, "format.suffix")) {
@@ -712,6 +731,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	const char *in_reply_to = NULL;
 	struct patch_ids ids;
 	char *add_signoff = NULL;
+	struct strbuf buf;
 
 	git_config(git_format_config);
 	init_revisions(&rev, prefix);
@@ -724,7 +744,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
 
 	rev.subject_prefix = fmt_patch_subject_prefix;
-	rev.extra_headers = extra_headers;
 
 	/*
 	 * Parse the arguments before setup_revisions(), or something
@@ -815,6 +834,37 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	}
 	argc = j;
 
+	strbuf_init(&buf, 0);
+
+	for (i = 0; i < extra_hdr_nr; i++) {
+		strbuf_addstr(&buf, extra_hdr[i]);
+		strbuf_addch(&buf, '\n');
+	}
+
+	if (extra_to_nr)
+		strbuf_addstr(&buf, "To: ");
+	for (i = 0; i < extra_to_nr; i++) {
+		if (i)
+			strbuf_addstr(&buf, "    ");
+		strbuf_addstr(&buf, extra_to[i]);
+		if (i + 1 < extra_to_nr)
+			strbuf_addch(&buf, ',');
+		strbuf_addch(&buf, '\n');
+	}
+
+	if (extra_cc_nr)
+		strbuf_addstr(&buf, "Cc: ");
+	for (i = 0; i < extra_cc_nr; i++) {
+		if (i)
+			strbuf_addstr(&buf, "    ");
+		strbuf_addstr(&buf, extra_cc[i]);
+		if (i + 1 < extra_cc_nr)
+			strbuf_addch(&buf, ',');
+		strbuf_addch(&buf, '\n');
+	}
+
+	rev.extra_headers = strbuf_detach(&buf, 0);
+
 	if (start_number < 0)
 		start_number = 1;
 	if (numbered && keep_subject)
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 755fe6d..43d8841 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -112,7 +112,7 @@ test_expect_success 'extra headers without newlines' '
 	
 '
 
-test_expect_failure 'extra headers with multiple To:s' '
+test_expect_success 'extra headers with multiple To:s' '
 
 	git config --replace-all format.headers "To: R. E. Cipient <rcipient@example.com>" &&
 	git config --add format.headers "To: S. E. Cipient <scipient@example.com>" &&
-- 
1.5.4.1.192.g8ea3a
