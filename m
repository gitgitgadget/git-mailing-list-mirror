From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v8 4/7] fast-import: add option command
Date: Fri,  4 Dec 2009 18:06:57 +0100
Message-ID: <1259946420-8845-5-git-send-email-srabbelier@gmail.com>
References: <1259946420-8845-1-git-send-email-srabbelier@gmail.com>
 <1259946420-8845-2-git-send-email-srabbelier@gmail.com>
 <1259946420-8845-3-git-send-email-srabbelier@gmail.com>
 <1259946420-8845-4-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	<vcs-fast-import-devs@l
X-From: git-owner@vger.kernel.org Fri Dec 04 18:14:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGbdE-000621-PW
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 18:07:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbZLDRHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 12:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbZLDRHV
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 12:07:21 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:58084 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932264AbZLDRHP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 12:07:15 -0500
Received: by mail-ew0-f219.google.com with SMTP id 19so3051396ewy.1
        for <git@vger.kernel.org>; Fri, 04 Dec 2009 09:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=EUnNoisjKudY/3aLtoyjqN75Osig97YzDvbZ2fY/TjM=;
        b=K64ZcT8v26DC1ayljfpXgnoZnpV6yGpFTIdIRscpsL2wt86HPq540sfpluawQt9+0t
         TXIlOUJmrBKUv+qaeuubwn2e6CihCnpyQbFhAXxsmehKHjGX9/Qoz/lcmctJ/J3RmpYB
         HVT5MaFOgZDbBgwxO+0O48d+MiLsVRw11ZUHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vxMfpwnrnkK/D471dOhozjTIUgdxYsv78i6IasHfmgi1yBQiOFaa8oas0biwUJkUNk
         u0o/HlflAxF+8xXHqO96Vti2dAyn8Ety9UphsbMxZWQK6Y0ASmVYKHEd8zi6vAZPY3zE
         h4xFdTtfHKe/jlY+vWJWR0jye1QqLJexLfonY=
Received: by 10.213.96.207 with SMTP id i15mr5487305ebn.69.1259946441651;
        Fri, 04 Dec 2009 09:07:21 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 16sm1980184ewy.14.2009.12.04.09.07.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Dec 2009 09:07:20 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3.164.g07b0c
In-Reply-To: <1259946420-8845-4-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134544>

This allows the frontend to specify any of the supported options as
long as no non-option command has been given. This way the
user does not have to include any frontend-specific options, but
instead she can rely on the frontend to tell fast-import what it
needs.

Also factor out parsing of argv and have it execute when we reach the
first non-option command, or after all commands have been read and
no non-option command has been encountered.

Non-git options are ignored, unrecognised options result in an error.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	Reject unknown options, update documentation, and some style fixes.

 Documentation/git-fast-import.txt |   32 +++++++++++++
 fast-import.c                     |   87 ++++++++++++++++++++++++++-----------
 2 files changed, 94 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 4357c21..2d5f533 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -307,6 +307,11 @@ and control the current import process.  More detailed discussion
 	Require that fast-import supports the specified feature, or
 	abort if it does not.
 
+`option`::
+	Specify any of the options listed under OPTIONS that do not
+	change stream semantic to suit the frontend's needs. This
+	command is optional and is not needed to perform an import.
+
 `commit`
 ~~~~~~~~
 Create or update a branch with a new commit, recording one logical
@@ -871,6 +876,33 @@ The following features are currently supported:
 * export-marks
 * force
 
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
+listed in the OPTIONS section that do not change import semantics,
+without the leading '--' and is treated in the same way.
+
+Option commands must be the first commands on the input (not counting
+feature commands), to give an option command after any non-option
+command is an error.
+
+The following commandline options change import semantics and may therefore
+not be passed as option:
+
+* date-format
+* import-marks
+* export-marks
+* force
+
 Crash Reports
 -------------
 If fast-import is supplied invalid input it will terminate with a
diff --git a/fast-import.c b/fast-import.c
index ce0cd4e..ab099b6 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -296,6 +296,8 @@ static unsigned long branch_load_count;
 static int failure;
 static FILE *pack_edges;
 static unsigned int show_stats = 1;
+static int global_argc;
+static const char **global_argv;
 
 /* Memory pools */
 static size_t mem_pool_alloc = 2*1024*1024 - sizeof(struct mem_pool);
@@ -355,6 +357,8 @@ static uintmax_t next_mark;
 static struct strbuf new_data = STRBUF_INIT;
 static int seen_data_command;
 
+static void parse_argv(void);
+
 static void write_branch_report(FILE *rpt, struct branch *b)
 {
 	fprintf(rpt, "%s:\n", b->name);
@@ -1706,8 +1710,9 @@ static int read_next_command(void)
 				return EOF;
 
 			if (!seen_data_command
-				&& prefixcmp(command_buf.buf, "feature ")) {
-				seen_data_command = 1;
+				&& prefixcmp(command_buf.buf, "feature ")
+				&& prefixcmp(command_buf.buf, "option ")) {
+				parse_argv();
 			}
 
 			rc = rc_free;
@@ -2512,31 +2517,25 @@ static void option_export_pack_edges(const char *edges)
 		die_errno("Cannot open '%s'", edges);
 }
 
-static void parse_one_option(const char *option)
+static int parse_one_option(const char *option)
 {
-	if (!prefixcmp(option, "date-format=")) {
-		option_date_format(option + 12);
-	} else if (!prefixcmp(option, "max-pack-size=")) {
+	if (!prefixcmp(option, "max-pack-size=")) {
 		option_max_pack_size(option + 14);
 	} else if (!prefixcmp(option, "depth=")) {
 		option_depth(option + 6);
 	} else if (!prefixcmp(option, "active-branches=")) {
 		option_active_branches(option + 16);
-	} else if (!prefixcmp(option, "import-marks=")) {
-		option_import_marks(option + 13);
-	} else if (!prefixcmp(option, "export-marks=")) {
-		option_export_marks(option + 13);
 	} else if (!prefixcmp(option, "export-pack-edges=")) {
 		option_export_pack_edges(option + 18);
-	} else if (!prefixcmp(option, "force")) {
-		force_update = 1;
 	} else if (!prefixcmp(option, "quiet")) {
 		show_stats = 0;
 	} else if (!prefixcmp(option, "stats")) {
 		show_stats = 1;
 	} else {
-		die("Unsupported option: %s", option);
+		return 0;
 	}
+
+	return 1;
 }
 
 static int parse_one_feature(const char *feature)
@@ -2569,6 +2568,19 @@ static void parse_feature(void)
 	die("This version of fast-import does not support feature %s.", feature);
 }
 
+static void parse_option(void)
+{
+	char *option = command_buf.buf + 11;
+
+	if (seen_data_command)
+		die("Got option command '%s' after data command", option);
+
+	if (parse_one_option(option))
+		return;
+
+	die("This version of fast-import does not support option: %s", option);
+}
+
 static int git_pack_config(const char *k, const char *v, void *cb)
 {
 	if (!strcmp(k, "pack.depth")) {
@@ -2593,6 +2605,32 @@ static int git_pack_config(const char *k, const char *v, void *cb)
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
+		if (parse_one_option(a + 2))
+			continue;
+
+		if (parse_one_feature(a + 2))
+			continue;
+
+		die("unknown option %s", a);
+	}
+	if (i != global_argc)
+		usage(fast_import_usage);
+
+	seen_data_command = 1;
+	if (import_marks_file)
+		read_marks();
+}
+
 int main(int argc, const char **argv)
 {
 	unsigned int i;
@@ -2614,18 +2652,8 @@ int main(int argc, const char **argv)
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
-	if (import_marks_file)
-		read_marks();
+	global_argc = argc;
+	global_argv = argv;
 
 	rc_free = pool_alloc(cmd_save * sizeof(*rc_free));
 	for (i = 0; i < (cmd_save - 1); i++)
@@ -2650,9 +2678,18 @@ int main(int argc, const char **argv)
 			parse_progress();
 		else if (!prefixcmp(command_buf.buf, "feature "))
 			parse_feature();
+		else if (!prefixcmp(command_buf.buf, "option git "))
+			parse_option();
+		else if (!prefixcmp(command_buf.buf, "option "))
+			/* ignore non-git options*/;
 		else
 			die("Unsupported command: %s", command_buf.buf);
 	}
+
+	/* argv hasn't been parsed yet, do so */
+	if (!seen_data_command)
+		parse_argv();
+
 	end_packfile();
 
 	dump_branches();
-- 
1.6.5.3.164.g07b0c
