From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v6 5/6] fast-import: add option command
Date: Wed,  2 Sep 2009 19:57:02 +0200
Message-ID: <1251914223-31435-6-git-send-email-srabbelier@gmail.com>
References: <1251914223-31435-1-git-send-email-srabbelier@gmail.com>
 <1251914223-31435-2-git-send-email-srabbelier@gmail.com>
 <1251914223-31435-3-git-send-email-srabbelier@gmail.com>
 <1251914223-31435-4-git-send-email-srabbelier@gmail.com>
 <1251914223-31435-5-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.cla
X-From: git-owner@vger.kernel.org Wed Sep 02 19:58:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Miu6G-0007Zr-5p
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 19:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246AbZIBR5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 13:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753215AbZIBR5s
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 13:57:48 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:57092 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209AbZIBR5q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 13:57:46 -0400
Received: by mail-bw0-f219.google.com with SMTP id 19so909406bwz.37
        for <git@vger.kernel.org>; Wed, 02 Sep 2009 10:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=xxvnzVZLnaW0VxItbM/rGdStZJyoNoJYLeSKaoxHcCA=;
        b=tFOeWqE6A4zFwg4aKWHGlk68rRlTDGzguYcMeeAcvlDFj9CyUHfFNfDc9Tjab5dd8R
         jYoqEvdb4F54ysAx3lk3dhXGnIFoyfaPp72ooxzzcfpmkOYvQWTj/n+QEBTeQnWXeXvi
         Pr7LD4eC57mHBTQgF4VFbYAMfmSxLaw4k4M54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XDxHGbfNen9AQriUabESD5HNIRbuOPvP94e3taRmg7walrQaN5XIArPIALe6GxtRQL
         90pCxox1MFAkDSvNZ+aFigE0omU2g0/vtC/yxKb8l1n+rU6Xr60QRRe15ut+bYG+ZFb9
         mHzY+KWwfXr/7bV6IN0hfkFjBhPLUwwUA4gv0=
Received: by 10.204.34.8 with SMTP id j8mr7045761bkd.54.1251914268317;
        Wed, 02 Sep 2009 10:57:48 -0700 (PDT)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 21sm325505fks.9.2009.09.02.10.57.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Sep 2009 10:57:47 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
In-Reply-To: <1251914223-31435-5-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127618>

This allows the frontend to specify any of the supported options as
long as no non-option command has been given. This way the
user does not have to include any frontend-specific options, but
instead she can rely on the frontend to tell fast-import what it
needs.

Also factor out parsing of argv and have it execute when we reach the
first non-option command, or after all commands have been read and
no non-option command has been encountered.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Main difference with v5 is that the syntax is now 'option git ...'
  as per a discussion with the other fast-import devs. Other options,
  e.g. 'option hg' are ignored. Also fixed the docs to say that
  feature commands are allowed before git option commands.

 Documentation/git-fast-import.txt |   24 ++++++++++++
 fast-import.c                     |   75 +++++++++++++++++++++++++++++++------
 2 files changed, 87 insertions(+), 12 deletions(-)

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
index 9bf06a4..bad93dc 100644
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
@@ -2456,11 +2468,31 @@ static void parse_feature(void)
 
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
+	char* option = command_buf.buf + 11;
+
+	if (!options_enabled)
+		die("Got option command '%s' before options feature'", option);
+
+	if (seen_non_option_command)
+		die("Got option command '%s' after non-option command", option);
+
+	parse_one_option(option);
+}
+
+static void parse_nongit_option(void)
+{
+  // do nothing
+}
+
 static int git_pack_config(const char *k, const char *v, void *cb)
 {
 	if (!strcmp(k, "pack.depth")) {
@@ -2485,6 +2517,26 @@ static int git_pack_config(const char *k, const char *v, void *cb)
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
@@ -2503,18 +2555,8 @@ int main(int argc, const char **argv)
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
@@ -2539,9 +2581,18 @@ int main(int argc, const char **argv)
 			parse_progress();
 		else if (!prefixcmp(command_buf.buf, "feature "))
 			parse_feature();
+		else if (!prefixcmp(command_buf.buf, "option git "))
+			parse_option();
+    else if (!prefixcmp(command_buf.buf, "option "))
+      parse_nongit_option();
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
