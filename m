From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 2/3] fast-import: add option command
Date: Thu, 13 Aug 2009 12:02:35 -0700
Message-ID: <1250190156-4752-3-git-send-email-srabbelier@gmail.com>
References: <1250190156-4752-1-git-send-email-srabbelier@gmail.com>
 <1250190156-4752-2-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 21:03:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbfZs-0007Q3-Dr
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 21:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755377AbZHMTC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 15:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755373AbZHMTC5
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 15:02:57 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:36825 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755370AbZHMTCz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 15:02:55 -0400
Received: by rv-out-0506.google.com with SMTP id f6so305427rvb.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 12:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fw4kFNNbO2huQ6mXkHMf0VWeNZ0o1cgakvBcBJ5rlVY=;
        b=HV943RkjXeUE04myuz/Svtm2v7czVJjEoJ6L8+VAtPZT1Il5arBVmiwMYeGm0wcbry
         HCN/17Lli2XJ1hI8930KJPSu8bNABaQnHG3AWT3eznRe373N/w8MgDenk8kE8Nv55lm2
         WiQ6hUZkVG6yF1etaju2ybqOC8P2pIt0RW0xM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DSZo7u1wLYrKvPTeplUk2OXdHLlOmX/k4eVzfWFG4Uee8gmGm89vroy1j3ArcETIv7
         DJmkpU/tuTEg57OFnoOyUI1qUhgkxQ16wft5Sb+njkSSsH48s0MEGzbWLEvOWrmtFhWG
         F+ouqcP0bMUTpEhR7x6M3WzLvgsjvlffyHgpI=
Received: by 10.140.144.6 with SMTP id r6mr634125rvd.137.1250190176694;
        Thu, 13 Aug 2009 12:02:56 -0700 (PDT)
Received: from localhost.localdomain ([216.239.45.19])
        by mx.google.com with ESMTPS id f42sm3575374rvb.35.2009.08.13.12.02.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Aug 2009 12:02:55 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
In-Reply-To: <1250190156-4752-2-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125853>

This allows the frontend to specify any of the supported options as
long as no non-option command has been given. This way the
user does not have to include any frontend-specific options, but
instead she can rely on the frontend to tell fast-import what it
needs.

Also factor out parsing of argv and have it execute when we reach the
first non-option command, or after all commands have been read and
no non-option command has been encountered.

Lastly do not read the marks file till after all options have been
parsed, instead of when receiving the option.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	Now we delay reading the marks file till option parsing is done.

 Documentation/git-fast-import.txt |   23 +++++++
 fast-import.c                     |  130 +++++++++++++++++++++++++------------
 2 files changed, 111 insertions(+), 42 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index c2f483a..ed8bd0d 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -303,6 +303,11 @@ and control the current import process.  More detailed discussion
 	standard output.  This command is optional and is not needed
 	to perform an import.
 
+`option`::
+    Specify any of the options listed under OPTIONS to change
+    fast-import's behavior to suit the frontend's needs. This command
+    is optional and is not needed to perform an import.
+
 `commit`
 ~~~~~~~~
 Create or update a branch with a new commit, recording one logical
@@ -813,6 +818,24 @@ Placing a `progress` command immediately after a `checkpoint` will
 inform the reader when the `checkpoint` has been completed and it
 can safely access the refs that fast-import updated.
 
+`option`
+~~~~~~~~
+Processes the specified option so that git fast-import behaves in a
+way that suits the frontend's needs.
+Note that options specified by the frontend are overridden by any
+options the user may specify to git fast-import itself.
+
+....
+    'option' SP <option> LF
+....
+
+The `<option>` part of the command may contain any of the options
+listed in the OPTIONS section, without the leading '--' and is
+treated in the same way.
+
+Option commands must be the first commands on the input, to give an
+option command after any non-option command is an error.
+
 Crash Reports
 -------------
 If fast-import is supplied invalid input it will terminate with a
diff --git a/fast-import.c b/fast-import.c
index b904f20..dff2937 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -292,6 +292,8 @@ static unsigned long branch_load_count;
 static int failure;
 static FILE *pack_edges;
 static unsigned int show_stats = 1;
+static int global_argc;
+static const char **global_argv;
 
 /* Memory pools */
 static size_t mem_pool_alloc = 2*1024*1024 - sizeof(struct mem_pool);
@@ -315,6 +317,7 @@ static struct object_entry_pool *blocks;
 static struct object_entry *object_table[1 << 16];
 static struct mark_set *marks;
 static const char *mark_file;
+static const char *input_file;
 
 /* Our last blob */
 static struct last_object last_blob = { STRBUF_INIT, 0, 0, 0 };
@@ -348,6 +351,9 @@ static struct recent_command *rc_free;
 static unsigned int cmd_save = 100;
 static uintmax_t next_mark;
 static struct strbuf new_data = STRBUF_INIT;
+static int seen_non_option_command;
+
+static void parse_argv(void);
 
 static void write_branch_report(FILE *rpt, struct branch *b)
 {
@@ -1643,6 +1649,42 @@ static void dump_marks(void)
 	}
 }
 
+static void read_marks(void)
+{
+	char line[512];
+	FILE *f = fopen(input_file, "r");
+	if (!f)
+		die_errno("cannot read '%s'", input_file);
+	while (fgets(line, sizeof(line), f)) {
+		uintmax_t mark;
+		char *end;
+		unsigned char sha1[20];
+		struct object_entry *e;
+
+		end = strchr(line, '\n');
+		if (line[0] != ':' || !end)
+			die("corrupt mark line: %s", line);
+		*end = 0;
+		mark = strtoumax(line + 1, &end, 10);
+		if (!mark || end == line + 1
+			|| *end != ' ' || get_sha1(end + 1, sha1))
+			die("corrupt mark line: %s", line);
+		e = find_object(sha1);
+		if (!e) {
+			enum object_type type = sha1_object_info(sha1, NULL);
+			if (type < 0)
+				die("object not found: %s", sha1_to_hex(sha1));
+			e = insert_object(sha1);
+			e->type = type;
+			e->pack_id = MAX_PACK_ID;
+			e->offset = 1; /* just not zero! */
+		}
+		insert_mark(mark, e);
+	}
+	fclose(f);
+}
+
+
 static int read_next_command(void)
 {
 	static int stdin_eof = 0;
@@ -1663,6 +1705,11 @@ static int read_next_command(void)
 			if (stdin_eof)
 				return EOF;
 
+			if (!seen_non_option_command
+				&& prefixcmp(command_buf.buf, "option ")) {
+				parse_argv();
+			}
+
 			rc = rc_free;
 			if (rc)
 				rc_free = rc->next;
@@ -2338,39 +2385,9 @@ static void parse_progress(void)
 	skip_optional_lf();
 }
 
-static void option_import_marks(const char *input_file)
+static void option_import_marks(const char *marks)
 {
-	char line[512];
-	FILE *f = fopen(input_file, "r");
-	if (!f)
-		die_errno("cannot read '%s'", input_file);
-	while (fgets(line, sizeof(line), f)) {
-		uintmax_t mark;
-		char *end;
-		unsigned char sha1[20];
-		struct object_entry *e;
-
-		end = strchr(line, '\n');
-		if (line[0] != ':' || !end)
-			die("corrupt mark line: %s", line);
-		*end = 0;
-		mark = strtoumax(line + 1, &end, 10);
-		if (!mark || end == line + 1
-			|| *end != ' ' || get_sha1(end + 1, sha1))
-			die("corrupt mark line: %s", line);
-		e = find_object(sha1);
-		if (!e) {
-			enum object_type type = sha1_object_info(sha1, NULL);
-			if (type < 0)
-				die("object not found: %s", sha1_to_hex(sha1));
-			e = insert_object(sha1);
-			e->type = type;
-			e->pack_id = MAX_PACK_ID;
-			e->offset = 1; /* just not zero! */
-		}
-		insert_mark(mark, e);
-	}
-	fclose(f);
+	input_file = xstrdup(marks);
 }
 
 static void option_date_format(const char *fmt)
@@ -2443,6 +2460,16 @@ static void parse_one_option(const char *option)
 	}
 }
 
+static void parse_option(void)
+{
+	char* option = command_buf.buf + 7;
+
+	if (seen_non_option_command)
+		die("Got option command '%s' after non-option command", option);
+
+	parse_one_option(option);
+}
+
 static int git_pack_config(const char *k, const char *v, void *cb)
 {
 	if (!strcmp(k, "pack.depth")) {
@@ -2467,6 +2494,26 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 static const char fast_import_usage[] =
 "git fast-import [--date-format=f] [--max-pack-size=n] [--depth=n] [--active-branches=n] [--export-marks=marks.file]";
 
+static void parse_argv(void)
+{
+	unsigned int i;
+
+	for (i = 1; i < global_argc; i++) {
+		const char *a = global_argv[i];
+
+		if (*a != '-' || !strcmp(a, "--"))
+			break;
+
+		parse_one_option(a + 2);
+	}
+	if (i != global_argc)
+		usage(fast_import_usage);
+
+	seen_non_option_command = 1;
+	if (input_file)
+		read_marks();
+}
+
 int main(int argc, const char **argv)
 {
 	unsigned int i;
@@ -2485,16 +2532,8 @@ int main(int argc, const char **argv)
 	avail_tree_table = xcalloc(avail_tree_table_sz, sizeof(struct avail_tree_content*));
 	marks = pool_calloc(1, sizeof(struct mark_set));
 
-	for (i = 1; i < argc; i++) {
-		const char *a = argv[i];
-
-		if (*a != '-' || !strcmp(a, "--"))
-			break;
-
-		parse_one_option(a + 2);
-	}
-	if (i != argc)
-		usage(fast_import_usage);
+	global_argc = argc;
+	global_argv = argv;
 
 	rc_free = pool_alloc(cmd_save * sizeof(*rc_free));
 	for (i = 0; i < (cmd_save - 1); i++)
@@ -2517,9 +2556,16 @@ int main(int argc, const char **argv)
 			parse_checkpoint();
 		else if (!prefixcmp(command_buf.buf, "progress "))
 			parse_progress();
+		else if (!prefixcmp(command_buf.buf, "option "))
+			parse_option();
 		else
 			die("Unsupported command: %s", command_buf.buf);
 	}
+
+	// argv hasn't been parsed yet, do so
+	if (!seen_non_option_command)
+		parse_argv();
+
 	end_packfile();
 
 	dump_branches();
-- 
1.6.4.122.g6ffd7
