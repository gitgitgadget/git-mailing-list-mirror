From: Quint Guvernator <quintus.public@gmail.com>
Subject: [PATCH 1/1] general style: replaces memcmp() with starts_with()
Date: Mon, 17 Mar 2014 17:52:24 -0400
Message-ID: <1395093144-6786-2-git-send-email-quintus.public@gmail.com>
References: <1395093144-6786-1-git-send-email-quintus.public@gmail.com>
Cc: Quint Guvernator <quintus.public@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 17 22:52:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPfSd-0004JH-QS
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 22:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbaCQVwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 17:52:39 -0400
Received: from mail-qc0-f178.google.com ([209.85.216.178]:58500 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbaCQVwi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 17:52:38 -0400
Received: by mail-qc0-f178.google.com with SMTP id i8so6734296qcq.37
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 14:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v5Rd7NvDmM9dQ0UZzAvqud9te8+80JmSLMjrvVfnnwU=;
        b=jsIoydoYHjLfQlwd3UuxvpaFv98FXzI4oAtuoKjPyqoxE3DXLOsR1KYbH5PG/c3jZA
         L8kkZg5Tbx+DkEj3u2PxZ9oP6hsHLp2QJywFn8iBOjEtro9sU+aC4PyQyXGHv2eVOcfj
         UYJFEr3XBw1Q2jbcxouPOnwEVDzXjJDZBhHOK7wJiBRiiJL8DlM2awqDcX4FZGRkMI3z
         ed3dVq2ObzAS+H/yid/4iyOHMaBCUQftWLvUUvXQB445jEtN/ZqRG0CP3tqWeTNWS87D
         Hi1rkyFYm6o6JBvX7fAwprzHwJhMBXSPU2biEaFmGtfrbL0k/zSFRMXtrgzlDnaEal3i
         sLrw==
X-Received: by 10.140.109.9 with SMTP id k9mr9232268qgf.6.1395093157495;
        Mon, 17 Mar 2014 14:52:37 -0700 (PDT)
Received: from lovelace.wm.edu ([128.239.171.194])
        by mx.google.com with ESMTPSA id 21sm18928351qgh.23.2014.03.17.14.52.36
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 17 Mar 2014 14:52:36 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395093144-6786-1-git-send-email-quintus.public@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244293>

memcmp() is replaced with negated starts_with() when comparing strings
from the beginning and when it is logical to do so. starts_with() looks
nicer and it saves the extra argument of the length of the comparing
string.

Signed-off-by: Quint Guvernator <quintus.public@gmail.com>
---
 builtin/apply.c        |  6 +++---
 builtin/for-each-ref.c |  2 +-
 builtin/mktag.c        |  4 ++--
 builtin/patch-id.c     | 10 +++++-----
 connect.c              |  4 ++--
 imap-send.c            |  6 +++---
 remote.c               |  2 +-
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 0189523..de84dce 100644
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
@@ -1673,7 +1673,7 @@ static int parse_single_patch(const char *line, unsigned long size, struct patch
 	unsigned long oldlines = 0, newlines = 0, context = 0;
 	struct fragment **fragp = &patch->fragments;
 
-	while (size > 4 && !memcmp(line, "@@ -", 4)) {
+	while (size > 4 && starts_with(line, "@@ -")) {
 		struct fragment *fragment;
 		int len;
 
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
index 640ab64..640c28f 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -57,7 +57,7 @@ static int verify_tag(char *buffer, unsigned long size)
 
 	/* Verify type line */
 	type_line = object + 48;
-	if (memcmp(type_line - 1, "\ntype ", 6))
+	if (!starts_with(type_line - 1, "\ntype "))
 		return error("char%d: could not find \"\\ntype \"", 47);
 
 	/* Verify tag-line */
@@ -66,7 +66,7 @@ static int verify_tag(char *buffer, unsigned long size)
 		return error("char%"PRIuMAX": could not find next \"\\n\"",
 				(uintmax_t) (type_line - buffer));
 	tag_line++;
-	if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
+	if (!starts_with(tag_line, "tag ") || tag_line[4] == '\n')
 		return error("char%"PRIuMAX": no \"tag \" found",
 				(uintmax_t) (tag_line - buffer));
 
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
