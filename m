Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B56BD1FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 19:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755832AbdC1TrE (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:47:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:53166 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755801AbdC1TrD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:47:03 -0400
Received: (qmail 11807 invoked by uid 109); 28 Mar 2017 19:46:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 19:46:52 +0000
Received: (qmail 7314 invoked by uid 111); 28 Mar 2017 19:47:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 15:47:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 15:46:50 -0400
Date:   Tue, 28 Mar 2017 15:46:50 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 13/18] replace unchecked snprintf calls with heap buffers
Message-ID: <20170328194650.zr3ee3yjqpnxxzlg@sigill.intra.peff.net>
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We'd prefer to avoid unchecked snprintf calls because
truncation can lead to unexpected results.

These are all cases where truncation shouldn't ever happen,
because the input to snprintf is fixed in size. That makes
them candidates for xsnprintf(), but it's simpler still to
just use the heap, and then nobody has to wonder if "100" is
big enough.

We'll use xstrfmt() where possible, and a strbuf when we need
the resulting size or to reuse the same buffer in a loop.

Signed-off-by: Jeff King <peff@peff.net>
---
 bisect.c             | 8 +++++---
 builtin/index-pack.c | 9 +++++----
 builtin/notes.c      | 9 ++++-----
 builtin/rev-parse.c  | 5 +++--
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/bisect.c b/bisect.c
index 30808cadf..d12583eaa 100644
--- a/bisect.c
+++ b/bisect.c
@@ -200,6 +200,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
 {
 	struct commit_list *p;
 	struct commit_dist *array = xcalloc(nr, sizeof(*array));
+	struct strbuf buf = STRBUF_INIT;
 	int cnt, i;
 
 	for (p = list, cnt = 0; p; p = p->next) {
@@ -217,17 +218,18 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
 	}
 	QSORT(array, cnt, compare_commit_dist);
 	for (p = list, i = 0; i < cnt; i++) {
-		char buf[100]; /* enough for dist=%d */
 		struct object *obj = &(array[i].commit->object);
 
-		snprintf(buf, sizeof(buf), "dist=%d", array[i].distance);
-		add_name_decoration(DECORATION_NONE, buf, obj);
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "dist=%d", array[i].distance);
+		add_name_decoration(DECORATION_NONE, buf.buf, obj);
 
 		p->item = array[i].commit;
 		p = p->next;
 	}
 	if (p)
 		p->next = NULL;
+	strbuf_release(&buf);
 	free(array);
 	return list;
 }
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f4af2ab37..197c51912 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1443,10 +1443,11 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 	if (!from_stdin) {
 		printf("%s\n", sha1_to_hex(sha1));
 	} else {
-		char buf[48];
-		int len = snprintf(buf, sizeof(buf), "%s\t%s\n",
-				   report, sha1_to_hex(sha1));
-		write_or_die(1, buf, len);
+		struct strbuf buf = STRBUF_INIT;
+
+		strbuf_addf(&buf, "%s\t%s\n", report, sha1_to_hex(sha1));
+		write_or_die(1, buf.buf, buf.len);
+		strbuf_release(&buf);
 
 		/*
 		 * Let's just mimic git-unpack-objects here and write
diff --git a/builtin/notes.c b/builtin/notes.c
index 0513f7455..7b891471c 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -554,7 +554,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	struct notes_tree *t;
 	unsigned char object[20], new_note[20];
 	const unsigned char *note;
-	char logmsg[100];
+	char *logmsg;
 	const char * const *usage;
 	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
 	struct option options[] = {
@@ -618,17 +618,16 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		write_note_data(&d, new_note);
 		if (add_note(t, object, new_note, combine_notes_overwrite))
 			die("BUG: combine_notes_overwrite failed");
-		snprintf(logmsg, sizeof(logmsg), "Notes added by 'git notes %s'",
-			argv[0]);
+		logmsg = xstrfmt("Notes added by 'git notes %s'", argv[0]);
 	} else {
 		fprintf(stderr, _("Removing note for object %s\n"),
 			sha1_to_hex(object));
 		remove_note(t, object);
-		snprintf(logmsg, sizeof(logmsg), "Notes removed by 'git notes %s'",
-			argv[0]);
+		logmsg = xstrfmt("Notes removed by 'git notes %s'", argv[0]);
 	}
 	commit_notes(t, logmsg);
 
+	free(logmsg);
 	free_note_data(&d);
 	free_notes(t);
 	return 0;
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 9e53a1a7c..f54d7b502 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -213,13 +213,14 @@ static int show_abbrev(const unsigned char *sha1, void *cb_data)
 
 static void show_datestring(const char *flag, const char *datestr)
 {
-	static char buffer[100];
+	char *buffer;
 
 	/* date handling requires both flags and revs */
 	if ((filter & (DO_FLAGS | DO_REVS)) != (DO_FLAGS | DO_REVS))
 		return;
-	snprintf(buffer, sizeof(buffer), "%s%lu", flag, approxidate(datestr));
+	buffer = xstrfmt("%s%lu", flag, approxidate(datestr));
 	show(buffer);
+	free(buffer);
 }
 
 static int show_file(const char *arg, int output_prefix)
-- 
2.12.2.845.g55fcf8b10

