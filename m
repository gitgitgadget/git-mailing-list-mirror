From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] commit: add get_commit_encoding()
Date: Mon,  8 Apr 2013 16:01:54 -0700
Message-ID: <1365462114-8630-4-git-send-email-gitster@pobox.com>
References: <20130408210903.GC9649@sigill.intra.peff.net>
 <1365462114-8630-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 09 01:02:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPL4l-0001C6-Jd
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 01:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936491Ab3DHXCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 19:02:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57727 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936305Ab3DHXCE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 19:02:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D4521491E;
	Mon,  8 Apr 2013 23:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Di/m
	WYjRLhXWMM2wgGTxhXzuG3g=; b=fvjjAfM1oqBXowrPFNBK9PSEvbUPK3oEj9m4
	0REbFyC5PlvwKZu3YqPYOJXWwXejShMLn24TLdeIiwCgvw/FAYCfUDRcDtPkU4M/
	kYObP+iGxtQL1O+T1Z8FHH8fn0ze8ghdIeaZ5BkUU9EPyw4zEtauPhwV2capPfUS
	NMJb/KA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	W8nbtUSE1atbYBXw3yil5dAwe/ke5VYK1awHIB+63MklF61a/746+JsSO0Kd5Me6
	kUBCnpGHfH0Os3hNKe8gQh6puXNxL7ayCRMPIPfY8WSaBsw+Zol/2zWvT3riHL0h
	CXwCr8Pz+OqvSu6YQhKRW91/goN/ku4uPvfOJCJN1Ek=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74E7B1491C;
	Mon,  8 Apr 2013 23:02:03 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6BDA314918; Mon,  8 Apr
 2013 23:02:02 +0000 (UTC)
X-Mailer: git-send-email 1.8.2.1-450-gd047976
In-Reply-To: <1365462114-8630-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 53221F82-A0A0-11E2-91D7-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220540>

This replaces two duplicated and slightly different helper functions
in pretty.c and sequencer.c that parses the commit object to find
the encoding header, by having the header parsed when other standard
commit header fields are parsed.  A commit object now has a small
integer that is used to index into a static table that holds the
first 200+ values for encoding headers, and in a weird project that
uses more than that many encoding, the encoding values are parsed
into a separate decoration hash (that is not expected to be used in
real life).

Incidentally, this fixes a small leak in sequencer(); the memory
allocated in its get_encoding() helper was never freed in the
caller.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c    | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 commit.h    |  3 +++
 pretty.c    | 33 ++------------------------------
 sequencer.c | 23 +----------------------
 4 files changed, 64 insertions(+), 57 deletions(-)

diff --git a/commit.c b/commit.c
index 50a9827..89c8d7c 100644
--- a/commit.c
+++ b/commit.c
@@ -78,10 +78,53 @@ struct commit *lookup_commit_reference_by_name(const char *name)
 	return commit;
 }
 
+#define QUICK_ENCODING_LIMIT 254 /* offset 1, as 0 is for "no encoding" */
+
+static int quick_encoding_used;
+static struct {
+	const char *encoding;
+	size_t sz;
+} quick_encoding[QUICK_ENCODING_LIMIT];
+static struct decoration slow_encoding;
+
+static void set_commit_encoding(struct commit *item, const char *encoding, size_t sz)
+{
+	int i;
+
+	for (i = 0; i < quick_encoding_used; i++) {
+		if (sz == quick_encoding[i].sz &&
+		    !memcmp(encoding, quick_encoding[i].encoding, sz)) {
+			item->encoding = i + 1;
+			return;
+		}
+	}
+	if (i < QUICK_ENCODING_LIMIT) {
+		quick_encoding[i].sz = sz;
+		quick_encoding[i].encoding = xmemdupz(encoding, sz);
+		item->encoding = i + 1;
+		quick_encoding_used++;
+		return;
+	}
+	item->encoding = QUICK_ENCODING_LIMIT;
+	add_decoration(&slow_encoding, &item->object, xmemdupz(encoding, sz));
+}
+
+const char *get_commit_encoding(const struct commit *item)
+{
+	int i;
+
+	if (!item->encoding)
+		return NULL;
+	i = item->encoding - 1; /* offset 1 */
+	if (i < QUICK_ENCODING_LIMIT)
+		return quick_encoding[i].encoding;
+	return lookup_decoration(&slow_encoding, &item->object);
+}
+
 static void parse_commit_standard_headers(const char *buf, const char *tail,
 					  struct commit *item)
 {
-	const char *dateptr;
+	const char *ptr;
 
 	item->date = 0;
 	if (buf + 6 >= tail)
@@ -98,13 +141,24 @@ static void parse_commit_standard_headers(const char *buf, const char *tail,
 		; /* skip to the end of the e-mail */
 	if (buf >= tail)
 		return;
-	dateptr = buf;
+	ptr = buf;
+	while (buf < tail && *buf++ != '\n')
+		; /* skip to the end of the line */
+	if (buf >= tail)
+		return;
+	/* ptr < buf && buf[-1] == '\n', so strtoul will stop at buf-1 */
+	item->date = strtoul(ptr, NULL, 10);
+
+	item->encoding = 0; /* no encoding header */
+	if (memcmp(buf, "encoding ", 9))
+		return;
+	ptr = buf + 9;
 	while (buf < tail && *buf++ != '\n')
 		; /* skip to the end of the line */
 	if (buf >= tail)
 		return;
-	/* dateptr < buf && buf[-1] == '\n', so strtoul will stop at buf-1 */
-	item->date = strtoul(dateptr, NULL, 10);
+	/* buf[-1] == '\n' that is the end of encoding */
+	set_commit_encoding(item, ptr, buf - ptr);
 }
 
 static struct commit_graft **commit_graft;
diff --git a/commit.h b/commit.h
index 771eeae..e7a70d3 100644
--- a/commit.h
+++ b/commit.h
@@ -16,12 +16,15 @@ struct commit {
 	struct object object;
 	void *util;
 	unsigned int indegree:8; /* see QUICK_INDEGREE_LIMIT in commit.c */
+	unsigned int encoding:8; /* see QUICK_ENCODING_LIMIT in commit.c */
 	unsigned long date;
 	struct commit_list *parents;
 	struct tree *tree;
 	char *buffer;
 };
 
+extern const char *get_commit_encoding(const struct commit *);
+
 extern int save_commit_buffer;
 extern const char *commit_type;
 
diff --git a/pretty.c b/pretty.c
index d3a82d2..08c6ffc 100644
--- a/pretty.c
+++ b/pretty.c
@@ -534,34 +534,6 @@ static void add_merge_info(const struct pretty_print_context *pp,
 	strbuf_addch(sb, '\n');
 }
 
-static char *get_header(const struct commit *commit, const char *msg,
-			const char *key)
-{
-	int key_len = strlen(key);
-	const char *line = msg;
-
-	while (line) {
-		const char *eol = strchr(line, '\n'), *next;
-
-		if (line == eol)
-			return NULL;
-		if (!eol) {
-			warning("malformed commit (header is missing newline): %s",
-				sha1_to_hex(commit->object.sha1));
-			eol = line + strlen(line);
-			next = NULL;
-		} else
-			next = eol + 1;
-		if (eol - line > key_len &&
-		    !strncmp(line, key, key_len) &&
-		    line[key_len] == ' ') {
-			return xmemdupz(line + key_len + 1, eol - line - key_len - 1);
-		}
-		line = next;
-	}
-	return NULL;
-}
-
 static char *replace_encoding_header(char *buf, const char *encoding)
 {
 	struct strbuf tmp = STRBUF_INIT;
@@ -598,7 +570,7 @@ char *logmsg_reencode(const struct commit *commit,
 {
 	static const char *utf8 = "UTF-8";
 	const char *use_encoding;
-	char *encoding;
+	const char *encoding;
 	char *msg = commit->buffer;
 	char *out;
 
@@ -617,7 +589,7 @@ char *logmsg_reencode(const struct commit *commit,
 
 	if (!output_encoding || !*output_encoding)
 		return msg;
-	encoding = get_header(commit, msg, "encoding");
+	encoding = get_commit_encoding(commit);
 	use_encoding = encoding ? encoding : utf8;
 	if (same_encoding(use_encoding, output_encoding)) {
 		/*
@@ -658,7 +630,6 @@ char *logmsg_reencode(const struct commit *commit,
 	if (out)
 		out = replace_encoding_header(out, output_encoding);
 
-	free(encoding);
 	/*
 	 * If the re-encoding failed, out might be NULL here; in that
 	 * case we just return the commit message verbatim.
diff --git a/sequencer.c b/sequencer.c
index baa0310..5d97519 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -116,8 +116,6 @@ static const char *action_name(const struct replay_opts *opts)
 	return opts->action == REPLAY_REVERT ? "revert" : "cherry-pick";
 }
 
-static char *get_encoding(const char *message);
-
 struct commit_message {
 	char *parent_label;
 	const char *label;
@@ -135,7 +133,7 @@ static int get_message(struct commit *commit, struct commit_message *out)
 
 	if (!commit->buffer)
 		return -1;
-	encoding = get_encoding(commit->buffer);
+	encoding = get_commit_encoding(commit);
 	if (!encoding)
 		encoding = "UTF-8";
 	if (!git_commit_encoding)
@@ -173,25 +171,6 @@ static void free_message(struct commit_message *msg)
 	free(msg->reencoded_message);
 }
 
-static char *get_encoding(const char *message)
-{
-	const char *p = message, *eol;
-
-	while (*p && *p != '\n') {
-		for (eol = p + 1; *eol && *eol != '\n'; eol++)
-			; /* do nothing */
-		if (!prefixcmp(p, "encoding ")) {
-			char *result = xmalloc(eol - 8 - p);
-			strlcpy(result, p + 9, eol - 8 - p);
-			return result;
-		}
-		p = eol;
-		if (*p == '\n')
-			p++;
-	}
-	return NULL;
-}
-
 static void write_cherry_pick_head(struct commit *commit, const char *pseudoref)
 {
 	const char *filename;
-- 
1.8.2.1-450-gd047976
