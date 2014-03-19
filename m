From: Quint Guvernator <quintus.public@gmail.com>
Subject: [PATCH v5] use starts_with() instead of !memcmp()
Date: Tue, 18 Mar 2014 21:18:03 -0400
Message-ID: <1395191883-42409-2-git-send-email-quintus.public@gmail.com>
References: <1395191883-42409-1-git-send-email-quintus.public@gmail.com>
Cc: Quint Guvernator <quintus.public@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 02:18:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ59D-0000H7-A1
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 02:18:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758716AbaCSBSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 21:18:16 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:42359 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758493AbaCSBSO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 21:18:14 -0400
Received: by mail-qc0-f172.google.com with SMTP id i8so8878889qcq.17
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 18:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J9B2Gb1DGP4gC7Ny7RdRZGqM2b6DLnuhiNoj0JEnbks=;
        b=sTS0ehcPTSgmZgnX+dibRdsbwSS0ihhIa7l0tWEFmn1cKHU1AyZisOo7iL9yKnns3E
         WO8YrXedln9qiXM13jLqWF/ZVEMTP35kXvMwJKZ6knye4qgdNM/ir5tIubHL+sl7KpzY
         sWMxG7jUK6TkuRnoLu+Wic4QW++mo5J35KvTCWbYFlLOStNwSpJoUDQnHu+9/zd/TnqB
         05e4L+MtnyNZ6mF8EMPU7TrwX7nREs/jOLOnED3h6LhmoCm+ZSRuKTq248skNens8EmF
         oarESfxdc2MFNiXUmwhxixexIyik+HsmsI8XZc0b2UzkitEpAGmJShiO38Vd8Wolxp64
         Jomw==
X-Received: by 10.224.80.134 with SMTP id t6mr39685609qak.34.1395191893119;
        Tue, 18 Mar 2014 18:18:13 -0700 (PDT)
Received: from lovelace.wm.edu ([128.239.171.194])
        by mx.google.com with ESMTPSA id r31sm28701190qgr.12.2014.03.18.18.18.11
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 18 Mar 2014 18:18:11 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395191883-42409-1-git-send-email-quintus.public@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244403>

When checking if a string begins with a constant string, using
starts_with() indicates the intention of the check more clearly and is
less error-prone than calling !memcmp() with an explicit byte count.

Signed-off-by: Quint Guvernator <quintus.public@gmail.com>
---
 builtin/apply.c        |  4 ++--
 builtin/for-each-ref.c |  2 +-
 builtin/mktag.c        |  2 +-
 builtin/patch-id.c     | 10 +++++-----
 connect.c              |  4 ++--
 imap-send.c            |  6 +++---
 remote.c               |  2 +-
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 0189523..826b3e2 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1631,7 +1631,7 @@ static int parse_fragment(const char *line, unsigned long size,
 		 * l10n of "\ No newline..." is at least that long.
 		 */
 		case '\\':
-			if (len < 12 || memcmp(line, "\\ ", 2))
+			if (len < 12 || !starts_with(line, "\\ "))
 				return -1;
 			break;
 		}
@@ -1646,7 +1646,7 @@ static int parse_fragment(const char *line, unsigned long size,
 	 * it in the above loop because we hit oldlines == newlines == 0
 	 * before seeing it.
 	 */
-	if (12 < size && !memcmp(line, "\\ ", 2))
+	if (12 < size && starts_with(line, "\\ "))
 		offset += linelen(line, size);
 
 	patch->lines_added += added;
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 3e1d5c3..4135980 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -193,7 +193,7 @@ static int verify_format(const char *format)
 		at = parse_atom(sp + 2, ep);
 		cp = ep + 1;
 
-		if (!memcmp(used_atom[at], "color:", 6))
+		if (starts_with(used_atom[at], "color:"))
 			need_color_reset_at_eol = !!strcmp(used_atom[at], color_reset);
 	}
 	return 0;
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 640ab64..d2d9310 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -57,7 +57,7 @@ static int verify_tag(char *buffer, unsigned long size)
 
 	/* Verify type line */
 	type_line = object + 48;
-	if (memcmp(type_line - 1, "\ntype ", 6))
+	if (!starts_with(type_line - 1, "\ntype "))
 		return error("char%d: could not find \"\\ntype \"", 47);
 
 	/* Verify tag-line */
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 3cfe02d..23ef424 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -81,14 +81,14 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
 		}
 
 		/* Ignore commit comments */
-		if (!patchlen && memcmp(line, "diff ", 5))
+		if (!patchlen && !starts_with(line, "diff "))
 			continue;
 
 		/* Parsing diff header?  */
 		if (before == -1) {
-			if (!memcmp(line, "index ", 6))
+			if (starts_with(line, "index "))
 				continue;
-			else if (!memcmp(line, "--- ", 4))
+			else if (starts_with(line, "--- "))
 				before = after = 1;
 			else if (!isalpha(line[0]))
 				break;
@@ -96,14 +96,14 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
 
 		/* Looking for a valid hunk header?  */
 		if (before == 0 && after == 0) {
-			if (!memcmp(line, "@@ -", 4)) {
+			if (starts_with(line, "@@ -")) {
 				/* Parse next hunk, but ignore line numbers.  */
 				scan_hunk_header(line, &before, &after);
 				continue;
 			}
 
 			/* Split at the end of the patch.  */
-			if (memcmp(line, "diff ", 5))
+			if (!starts_with(line, "diff "))
 				break;
 
 			/* Else we're parsing another header.  */
diff --git a/connect.c b/connect.c
index 4150412..5ae2aaa 100644
--- a/connect.c
+++ b/connect.c
@@ -30,11 +30,11 @@ static int check_ref(const char *name, int len, unsigned int flags)
 		return 0;
 
 	/* REF_HEADS means that we want regular branch heads */
-	if ((flags & REF_HEADS) && !memcmp(name, "heads/", 6))
+	if ((flags & REF_HEADS) && starts_with(name, "heads/"))
 		return 1;
 
 	/* REF_TAGS means that we want tags */
-	if ((flags & REF_TAGS) && !memcmp(name, "tags/", 5))
+	if ((flags & REF_TAGS) && starts_with(name, "tags/"))
 		return 1;
 
 	/* All type bits clear means that we are ok with anything */
diff --git a/imap-send.c b/imap-send.c
index 0bc6f7f..019de18 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -524,7 +524,7 @@ static struct imap_cmd *v_issue_imap_cmd(struct imap_store *ctx,
 	if (Verbose) {
 		if (imap->num_in_progress)
 			printf("(%d in progress) ", imap->num_in_progress);
-		if (memcmp(cmd->cmd, "LOGIN", 5))
+		if (!starts_with(cmd->cmd, "LOGIN"))
 			printf(">>> %s", buf);
 		else
 			printf(">>> %d LOGIN <user> <pass>\n", cmd->tag);
@@ -802,7 +802,7 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
 				resp = DRV_OK;
 			else {
 				if (!strcmp("NO", arg)) {
-					if (cmdp->cb.create && cmd && (cmdp->cb.trycreate || !memcmp(cmd, "[TRYCREATE]", 11))) { /* SELECT, APPEND or UID COPY */
+					if (cmdp->cb.create && cmd && (cmdp->cb.trycreate || starts_with(cmd, "[TRYCREATE]"))) { /* SELECT, APPEND or UID COPY */
 						p = strchr(cmdp->cmd, '"');
 						if (!issue_imap_cmd(ctx, NULL, "CREATE \"%.*s\"", (int)(strchr(p + 1, '"') - p + 1), p)) {
 							resp = RESP_BAD;
@@ -827,7 +827,7 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
 				} else /*if (!strcmp("BAD", arg))*/
 					resp = RESP_BAD;
 				fprintf(stderr, "IMAP command '%s' returned response (%s) - %s\n",
-					 memcmp(cmdp->cmd, "LOGIN", 5) ?
+					 !starts_with(cmdp->cmd, "LOGIN") ?
 							cmdp->cmd : "LOGIN <user> <pass>",
 							arg, cmd ? cmd : "");
 			}
diff --git a/remote.c b/remote.c
index 5f63d55..bd02b0e 100644
--- a/remote.c
+++ b/remote.c
@@ -1149,7 +1149,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	case 1:
 		break;
 	case 0:
-		if (!memcmp(dst_value, "refs/", 5))
+		if (starts_with(dst_value, "refs/"))
 			matched_dst = make_linked_ref(dst_value, dst_tail);
 		else if (is_null_sha1(matched_src->new_sha1))
 			error("unable to delete '%s': remote ref does not exist",
-- 
1.9.0
