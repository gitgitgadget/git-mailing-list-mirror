Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C9FC433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 23:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0098B6140C
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 23:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhD3X0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 19:26:53 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:47096 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232911AbhD3X0s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 19:26:48 -0400
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 4A8DD80592;
        Fri, 30 Apr 2021 19:25:59 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH v4 4/5] fast-export: do not modify memory from get_commit_buffer
Date:   Fri, 30 Apr 2021 17:25:36 -0600
Message-Id: <20210430232537.1131641-5-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210430232537.1131641-1-lukeshu@lukeshu.com>
References: <20210423164118.693197-1-lukeshu@lukeshu.com>
 <20210430232537.1131641-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

fast-export's helper function find_encoding() takes a `const char *`, but
modifies that memory despite the `const`.  Ultimately, this memory came
from get_commit_buffer(), and you're not supposed to modify the memory
that you get from get_commit_buffer().

So, get rid of find_encoding() in favor of commit.h:find_commit_header(),
which gives back a string length, rather than mutating the memory to
insert a '\0' terminator.

Because find_commit_header() detects the "\n\n" string that separates the
headers and the commit message, move the call to be above the
`message = strstr(..., "\n\n")` call.  This helps readability, and allows
for the value of `encoding` to be used for a better value of "..." so that
the same memory doesn't need to be checked twice.  Introduce a
`commit_buffer_cursor` variable to avoid writing an awkward
`encoding ? encoding + encoding_len : committer_end` expression.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---

Notes:
    v4: This commit is new in v4.

 builtin/fast-export.c | 65 ++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index d1cb8a3183..81f3fb1f05 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -499,21 +499,6 @@ static void show_filemodify(struct diff_queue_struct *q,
 	}
 }
 
-static const char *find_encoding(const char *begin, const char *end)
-{
-	const char *needle = "\nencoding ";
-	char *bol, *eol;
-
-	bol = memmem(begin, end ? end - begin : strlen(begin),
-		     needle, strlen(needle));
-	if (!bol)
-		return NULL;
-	bol += strlen(needle);
-	eol = strchrnul(bol, '\n');
-	*eol = '\0';
-	return bol;
-}
-
 static char *anonymize_ref_component(void *data)
 {
 	static int counter;
@@ -615,13 +600,26 @@ static void anonymize_ident_line(const char **beg, const char **end)
 	*end = out->buf + out->len;
 }
 
+static char *reencode_message(const char *in_msg,
+			      const char *in_encoding, size_t in_encoding_len)
+{
+	static struct strbuf in_encoding_buf = STRBUF_INIT;
+
+	strbuf_reset(&in_encoding_buf);
+	strbuf_add(&in_encoding_buf, in_encoding, in_encoding_len);
+
+	return reencode_string(in_msg, "UTF-8", in_encoding_buf.buf);
+}
+
 static void handle_commit(struct commit *commit, struct rev_info *rev,
 			  struct string_list *paths_of_changed_objects)
 {
 	int saved_output_format = rev->diffopt.output_format;
-	const char *commit_buffer;
+	const char *commit_buffer, *commit_buffer_cursor;
 	const char *author, *author_end, *committer, *committer_end;
-	const char *encoding, *message;
+	const char *encoding;
+	size_t encoding_len;
+	const char *message;
 	char *reencoded = NULL;
 	struct commit_list *p;
 	const char *refname;
@@ -630,21 +628,31 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	rev->diffopt.output_format = DIFF_FORMAT_CALLBACK;
 
 	parse_commit_or_die(commit);
-	commit_buffer = get_commit_buffer(commit, NULL);
-	author = strstr(commit_buffer, "\nauthor ");
+	commit_buffer_cursor = commit_buffer = get_commit_buffer(commit, NULL);
+
+	author = strstr(commit_buffer_cursor, "\nauthor ");
 	if (!author)
 		die("could not find author in commit %s",
 		    oid_to_hex(&commit->object.oid));
 	author++;
-	author_end = strchrnul(author, '\n');
-	committer = strstr(author_end, "\ncommitter ");
+	commit_buffer_cursor = author_end = strchrnul(author, '\n');
+
+	committer = strstr(commit_buffer_cursor, "\ncommitter ");
 	if (!committer)
 		die("could not find committer in commit %s",
 		    oid_to_hex(&commit->object.oid));
 	committer++;
-	committer_end = strchrnul(committer, '\n');
-	message = strstr(committer_end, "\n\n");
-	encoding = find_encoding(committer_end, message);
+	commit_buffer_cursor = committer_end = strchrnul(committer, '\n');
+
+	/* find_commit_header() gets a `+ 1` because
+	 * commit_buffer_cursor points at the trailing "\n" at the end
+	 * of the previous line, but find_commit_header() wants a
+	 * pointer to the beginning of the next line. */
+	encoding = find_commit_header(commit_buffer_cursor + 1, "encoding", &encoding_len);
+	if (encoding)
+		commit_buffer_cursor = encoding + encoding_len;
+
+	message = strstr(commit_buffer_cursor, "\n\n");
 	if (message)
 		message += 2;
 
@@ -685,14 +693,15 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	} else if (encoding) {
 		switch(reencode_mode) {
 		case REENCODE_YES:
-			reencoded = reencode_string(message, "UTF-8", encoding);
+			reencoded = reencode_message(message, encoding, encoding_len);
 			break;
 		case REENCODE_NO:
 			break;
 		case REENCODE_ABORT:
-			die("Encountered commit-specific encoding %s in commit "
+			die("Encountered commit-specific encoding %.*s in commit "
 			    "%s; use --reencode=[yes|no] to handle it",
-			    encoding, oid_to_hex(&commit->object.oid));
+			    (int)encoding_len, encoding,
+			    oid_to_hex(&commit->object.oid));
 		}
 	}
 	if (!commit->parents)
@@ -704,7 +713,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	       (int)(author_end - author), author,
 	       (int)(committer_end - committer), committer);
 	if (!reencoded && encoding)
-		printf("encoding %s\n", encoding);
+		printf("encoding %.*s\n", (int)encoding_len, encoding);
 	printf("data %u\n%s",
 	       (unsigned)(reencoded
 			  ? strlen(reencoded) : message
-- 
2.31.1

