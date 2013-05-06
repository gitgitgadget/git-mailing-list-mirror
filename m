From: "Arend van Spriel" <arend@broadcom.com>
Subject: [RFC] git: make signoff header configurable
Date: Mon, 6 May 2013 23:33:52 +0200
Message-ID: <1367876032-6833-1-git-send-email-arend@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Arend van Spriel" <arend@broadcom.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 06 23:34:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZT2z-00056j-2w
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 23:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757354Ab3EFVeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 17:34:08 -0400
Received: from mms3.broadcom.com ([216.31.210.19]:2540 "EHLO mms3.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757107Ab3EFVeH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 17:34:07 -0400
Received: from [10.9.208.57] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 06 May 2013 14:25:33 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 6 May 2013 14:33:57 -0700
Received: from mail-sj1-12.sj.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 6 May 2013 14:33:56 -0700
Received: from arend-ubuntu-1 (unknown [10.177.252.129]) by
 mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id 50902207C0; Mon, 6
 May 2013 14:33:56 -0700 (PDT)
Received: from arend by arend-ubuntu-1 with local (Exim 4.80) (
 envelope-from <arend@broadcom.com>) id 1UZT2g-0001ml-JK; Mon, 06 May
 2013 23:33:54 +0200
X-Mailer: git-send-email 1.7.10.4
X-WSS-ID: 7D96C0472L812500273-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223510>

When using -s for commit, revert, and format-patch (there
may be more) command the comments message gets a generated
and hard-coded signed-off-by message. For some projects a
different header is used, eg. HostAP. Adding a config parameter
named 'signoff.label'.

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
I had an itch to scratch. Like the -s command line parameter to
get the signed-off message added, but not all projects use the
same signature format. So let me know what you think about this
idea. Never contributed to git before so decided to make it an
RFC first as this solution may be a bit hack-ish.

Regards,
Arend
---
 builtin/commit.c |    5 +++--
 config.c         |   12 ++++++++++++
 sequencer.c      |   15 +++++++++++++--
 sequencer.h      |    3 ++-
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d2f30d9..6e28325 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -848,6 +848,7 @@ static int rest_is_empty(struct strbuf *sb, int start)
 {
 	int i, eol;
 	const char *nl;
+	char *so_hdr = get_signoff_header();
 
 	/* Check if the rest is just whitespace and Signed-of-by's. */
 	for (i = start; i < sb->len; i++) {
@@ -857,8 +858,8 @@ static int rest_is_empty(struct strbuf *sb, int start)
 		else
 			eol = sb->len;
 
-		if (strlen(sign_off_header) <= eol - i &&
-		    !prefixcmp(sb->buf + i, sign_off_header)) {
+		if (strlen(so_hdr) <= eol - i &&
+		    !prefixcmp(sb->buf + i, so_hdr)) {
 			i = eol;
 			continue;
 		}
diff --git a/config.c b/config.c
index aefd80b..110fa04 100644
--- a/config.c
+++ b/config.c
@@ -9,6 +9,7 @@
 #include "exec_cmd.h"
 #include "strbuf.h"
 #include "quote.h"
+#include "sequencer.h"
 
 typedef struct config_file {
 	struct config_file *prev;
@@ -892,6 +893,17 @@ int git_default_config(const char *var, const char *value, void *dummy)
 		pack_size_limit_cfg = git_config_ulong(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "signoff.label")) {
+		const char *label;
+
+		if (!git_config_string(&label, var, value)) {
+			size_t len = strlen(label) + 3;
+			sign_off_header = xcalloc(1, len);
+			snprintf(sign_off_header, len, "%s: ", label);
+			free((void *)label);
+		}
+		return 0;
+	}
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/sequencer.c b/sequencer.c
index cf8fbeb..7e9a0dd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -17,9 +17,20 @@
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
-const char sign_off_header[] = "Signed-off-by: ";
+static const char def_signoff_header[] = "Signed-off-by";
+char *sign_off_header = NULL;
 static const char cherry_picked_prefix[] = "(cherry picked from commit ";
 
+char *get_signoff_header(void)
+{
+	if (!sign_off_header) {
+		size_t len = strlen(def_signoff_header) + 3;
+		sign_off_header = xcalloc(1, len);
+		snprintf(sign_off_header, len, "%s: ", def_signoff_header);
+	}
+	return sign_off_header;
+}
+
 static int is_rfc2822_line(const char *buf, int len)
 {
 	int i;
@@ -1130,7 +1141,7 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
 	struct strbuf sob = STRBUF_INIT;
 	int has_footer;
 
-	strbuf_addstr(&sob, sign_off_header);
+	strbuf_addstr(&sob, get_signoff_header());
 	strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
 				getenv("GIT_COMMITTER_EMAIL")));
 	strbuf_addch(&sob, '\n');
diff --git a/sequencer.h b/sequencer.h
index 1fc22dc..5a91105 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -48,8 +48,9 @@ struct replay_opts {
 
 int sequencer_pick_revisions(struct replay_opts *opts);
 
-extern const char sign_off_header[];
+extern char* sign_off_header;
 
+char *get_signoff_header(void);
 void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
 
 #endif
-- 
1.7.10.4
