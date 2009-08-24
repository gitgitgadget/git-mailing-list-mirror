From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v4 3/4] fast-import: add option command
Date: Mon, 24 Aug 2009 13:52:35 -0700
Message-ID: <1251147156-19279-4-git-send-email-srabbelier@gmail.com>
References: <1251147156-19279-1-git-send-email-srabbelier@gmail.com>
 <1251147156-19279-2-git-send-email-srabbelier@gmail.com>
 <1251147156-19279-3-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 24 22:53:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfgXp-00068r-PJ
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 22:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485AbZHXUxC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 16:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753484AbZHXUxB
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 16:53:01 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:31951 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476AbZHXUw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 16:52:58 -0400
Received: by wa-out-1112.google.com with SMTP id j5so466600wah.21
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 13:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=oBIcESGfLbhTZ5H6pUH1SSotz2g+50dcMBNJHgRvGoM=;
        b=fwZlQeBzAVWgYFbH8zZPOZaIKzEykceqXmSUx9jukAruC21MY54XArbmw5Nsrj91r8
         v30gFKy2BmD9PCfc+gpBuRnMLe7QO4eM+R9Fgf6QRVPF4HV4XFcRrch46S4fNSsBUBUR
         8qeNg8PcQ1w5CqdgwrP6py+AFmE5CyyUX5cDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FZyUIni5NOFkpN+ZnyzB73D6uuhkHBin/KYbx7CIp/Df/Oro43eUFCkSX7wIKd87G1
         JmD2RkXH3veQQ0MWJSz3kR9OwthuX6pPhAT6M8KO18yr0R6l2CC+9BCU3V+pgzDxtLXH
         Xw2giUHcOTCJH4sL+JZF1u37KtYcZ5+DbJk8I=
Received: by 10.115.61.9 with SMTP id o9mr6476728wak.217.1251147178816;
        Mon, 24 Aug 2009 13:52:58 -0700 (PDT)
Received: from localhost.localdomain ([216.239.45.19])
        by mx.google.com with ESMTPS id 20sm1023981pzk.5.2009.08.24.13.52.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 Aug 2009 13:52:57 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
In-Reply-To: <1251147156-19279-3-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126964>

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

    Same as v3 but with the --import-marks change already done in 2/4

 Documentation/git-fast-import.txt |   23 ++++++++++++++
 fast-import.c                     |   61 +++++++++++++++++++++++++++++-------
 2 files changed, 72 insertions(+), 12 deletions(-)

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
index 812fcf0..dff2937 100644
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
@@ -349,6 +351,9 @@ static struct recent_command *rc_free;
 static unsigned int cmd_save = 100;
 static uintmax_t next_mark;
 static struct strbuf new_data = STRBUF_INIT;
+static int seen_non_option_command;
+
+static void parse_argv(void);
 
 static void write_branch_report(FILE *rpt, struct branch *b)
 {
@@ -1700,6 +1705,11 @@ static int read_next_command(void)
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
@@ -2450,6 +2460,16 @@ static void parse_one_option(const char *option)
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
@@ -2474,6 +2494,26 @@ static int git_pack_config(const char *k, const char *v, void *cb)
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
@@ -2492,18 +2532,8 @@ int main(int argc, const char **argv)
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
-	if (input_file)
-		read_marks();
+	global_argc = argc;
+	global_argv = argv;
 
 	rc_free = pool_alloc(cmd_save * sizeof(*rc_free));
 	for (i = 0; i < (cmd_save - 1); i++)
@@ -2526,9 +2556,16 @@ int main(int argc, const char **argv)
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
1.6.4.16.g72c66.dirty
