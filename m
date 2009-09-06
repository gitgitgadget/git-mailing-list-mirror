From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v7 5/6] fast-import: add option command
Date: Sun,  6 Sep 2009 16:35:47 +0200
Message-ID: <1252247748-14507-6-git-send-email-srabbelier@gmail.com>
References: <1252247748-14507-1-git-send-email-srabbelier@gmail.com>
 <1252247748-14507-2-git-send-email-srabbelier@gmail.com>
 <1252247748-14507-3-git-send-email-srabbelier@gmail.com>
 <1252247748-14507-4-git-send-email-srabbelier@gmail.com>
 <1252247748-14507-5-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.cla
X-From: git-owner@vger.kernel.org Sun Sep 06 16:36:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkIrD-00078l-3P
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 16:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757987AbZIFOgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 10:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757981AbZIFOgV
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 10:36:21 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:36677 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693AbZIFOgS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 10:36:18 -0400
Received: by mail-ew0-f206.google.com with SMTP id 2so1511768ewy.17
        for <git@vger.kernel.org>; Sun, 06 Sep 2009 07:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Qyeg/425+nHxCSAz5fNp5LGgZ0kzExkS1kO8mrwqREs=;
        b=mpCpSuY20ogOoooRJeEnrX41AKum9f/GUtnrCrbzESi6JLQIbSM5iDXxU2OODtrlEO
         /IuleGILrr0I5w1oRFez5j+8QqC2wIVNyOsJDWH/ET9vBUjqgnsG1nIS6fJIDn0Az+1h
         1xFSsFBf0QoJNNwU2i2DcS4h8hAhDIEPPQ/qo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NiYeHQ2Ah8nMQdUM8xda7Gjm7KP0TsK6r1qqGiAoYIKH2H8LbfkEKZZcFsL3rSpjJu
         0LSm8gpGWcw+lkmpqBbh5zDq/hpKlJdRCBFLqi0THi3V32hn4pBfBp3f10ecQ+RHfrSZ
         wpzyShyh6VnLoa9Ls+ZH37GeVlgg5a25sztKQ=
Received: by 10.216.90.129 with SMTP id e1mr1299324wef.98.1252247780294;
        Sun, 06 Sep 2009 07:36:20 -0700 (PDT)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id q9sm8759493gve.6.2009.09.06.07.36.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Sep 2009 07:36:19 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
In-Reply-To: <1252247748-14507-5-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127860>

This allows the frontend to specify any of the supported options as
long as no non-option command has been given. This way the
user does not have to include any frontend-specific options, but
instead she can rely on the frontend to tell fast-import what it
needs.

Also factor out parsing of argv and have it execute when we reach the
first non-option command, or after all commands have been read and
no non-option command has been encountered.

Non-git options and unrecognised git options are ignored, although
unrecognised options on the commandline still result in an error.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Fixed a few style errors pointed out by Junio and ignore
  unrecognised git options.

 Documentation/git-fast-import.txt |   24 +++++++++++
 fast-import.c                     |   81 ++++++++++++++++++++++++++++++------
 2 files changed, 91 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 1e293f2..f1c94b4 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -307,6 +307,11 @@ and control the current import process.  More detailed discussion
 	Require that fast-import supports the specified feature, or
 	abort if it does not.
 
+`option`::
+    Specify any of the options listed under OPTIONS to change
+    fast-import's behavior to suit the frontend's needs. This command
+    is optional and is not needed to perform an import.
+
 `commit`
 ~~~~~~~~
 Create or update a branch with a new commit, recording one logical
@@ -829,6 +834,25 @@ it does not.
 The <feature> part of the command may be any string matching
 [a-zA-Z-] and should be understood by a version of fast-import.
 
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
+Option commands must be the first commands on the input (not counting
+feature commands), to give an option command after any non-option
+command is an error.
+
 Crash Reports
 -------------
 If fast-import is supplied invalid input it will terminate with a
diff --git a/fast-import.c b/fast-import.c
index 9bf06a4..dcfb8fa 100644
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
@@ -349,6 +351,10 @@ static struct recent_command *rc_free;
 static unsigned int cmd_save = 100;
 static uintmax_t next_mark;
 static struct strbuf new_data = STRBUF_INIT;
+static int options_enabled;
+static int seen_non_option_command;
+
+static void parse_argv(void);
 
 static void write_branch_report(FILE *rpt, struct branch *b)
 {
@@ -1700,6 +1706,12 @@ static int read_next_command(void)
 			if (stdin_eof)
 				return EOF;
 
+			if (!seen_non_option_command
+				&& prefixcmp(command_buf.buf, "feature ")
+				&& prefixcmp(command_buf.buf, "option ")) {
+				parse_argv();
+			}
+
 			rc = rc_free;
 			if (rc)
 				rc_free = rc->next;
@@ -2423,7 +2435,7 @@ static void option_export_pack_edges(const char *edges)
 		die_errno("Cannot open '%s'", edges);
 }
 
-static void parse_one_option(const char *option)
+static void parse_one_option(const char *option, int optional)
 {
 	if (!prefixcmp(option, "date-format=")) {
 		option_date_format(option + 12);
@@ -2445,7 +2457,7 @@ static void parse_one_option(const char *option)
 		show_stats = 0;
 	} else if (!prefixcmp(option, "stats")) {
 		show_stats = 1;
-	} else {
+	} else if (!optional) {
 		die("Unsupported option: %s", option);
 	}
 }
@@ -2456,11 +2468,32 @@ static void parse_feature(void)
 
 	if (!prefixcmp(feature, "date-format=")) {
 		option_date_format(feature + 12);
+	} else if (!strcmp("git-options", feature)) {
+		options_enabled = 1;
 	} else {
 		die("This version of fast-import does not support feature %s.", feature);
 	}
 }
 
+static void parse_option(void)
+{
+	char *option = command_buf.buf + 11;
+
+	if (!options_enabled)
+		die("Got option command '%s' before options feature'", option);
+
+	if (seen_non_option_command)
+		die("Got option command '%s' after non-option command", option);
+
+	/* ignore unknown options, instead of erroring */
+	parse_one_option(option, 1);
+}
+
+static void parse_nongit_option(void)
+{
+	/* do nothing */
+}
+
 static int git_pack_config(const char *k, const char *v, void *cb)
 {
 	if (!strcmp(k, "pack.depth")) {
@@ -2485,6 +2518,27 @@ static int git_pack_config(const char *k, const char *v, void *cb)
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
+		/* error on unknown options */
+		parse_one_option(a + 2, 0);
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
@@ -2503,18 +2557,8 @@ int main(int argc, const char **argv)
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
@@ -2539,9 +2583,18 @@ int main(int argc, const char **argv)
 			parse_progress();
 		else if (!prefixcmp(command_buf.buf, "feature "))
 			parse_feature();
+		else if (!prefixcmp(command_buf.buf, "option git "))
+			parse_option();
+		else if (!prefixcmp(command_buf.buf, "option "))
+			parse_nongit_option();
 		else
 			die("Unsupported command: %s", command_buf.buf);
 	}
+
+	/* argv hasn't been parsed yet, do so */
+	if (!seen_non_option_command)
+		parse_argv();
+
 	end_packfile();
 
 	dump_branches();
-- 
1.6.4.16.g72c66.dirty
