From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 5/5] grep: add support for coloring with external greps
Date: Sat, 07 Mar 2009 13:34:46 +0100
Message-ID: <1236429286.6486.52.camel@ubuntu.ubuntu-domain>
References: <1236428699.6486.41.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Thiago Alves <thiago.salves@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 07 13:36:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfvlJ-0001jy-EE
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 13:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628AbZCGMev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 07:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754604AbZCGMeu
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 07:34:50 -0500
Received: from india601.server4you.de ([85.25.151.105]:36523 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754579AbZCGMet (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 07:34:49 -0500
Received: from [10.0.1.101] (p57B7BF05.dip.t-dialin.net [87.183.191.5])
	by india601.server4you.de (Postfix) with ESMTPSA id C9E3B2F8057;
	Sat,  7 Mar 2009 13:34:46 +0100 (CET)
In-Reply-To: <1236428699.6486.41.camel@ubuntu.ubuntu-domain>
X-Mailer: Evolution 2.24.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112536>

Add the config variable color.grep.external, which can be used to
switch on coloring of external greps.  To enable auto coloring with
GNU grep, one needs to set color.grep.external to --color=always to
defeat the pager started by git grep.  The value of the config
variable will be passed to the external grep only if it would
colorize internal grep's output, so automatic terminal detected
works.  The default is to not pass any option, because the external
grep command could be a program without color support.

Also set the environment variables GREP_COLOR and GREP_COLORS to
pass the configured color for matches to the external grep.  This
works with GNU grep; other variables could be added as needed.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/config.txt |   12 +++++++++++-
 builtin-grep.c           |   36 ++++++++++++++++++++++++++++++++++++
 grep.h                   |    1 +
 3 files changed, 48 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b75dada..4d42bff 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -553,9 +553,19 @@ color.grep::
 	`never`), never.  When set to `true` or `auto`, use color only
 	when the output is written to the terminal.  Defaults to `false`.
 
+color.grep.external::
+	The string value of this variable is passed to an external 'grep'
+	command as a command line option if match highlighting is turned
+	on.  If set to an empty string, no option is passed at all,
+	turning off coloring for external 'grep' calls; this is the default.
+	For GNU grep, set it to `--color=always` to highlight matches even
+	when a pager is used.
+
 color.grep.match::
 	Use customized color for matches.  The value of this variable
-	may be specified as in color.branch.<slot>.
+	may be specified as in color.branch.<slot>.  It is passed using
+	the environment variables 'GREP_COLOR' and 'GREP_COLORS' when
+	calling an external 'grep'.
 
 color.interactive::
 	When set to `always`, always use colors for interactive prompts
diff --git a/builtin-grep.c b/builtin-grep.c
index e2c0f01..9e7e766 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -30,6 +30,10 @@ static int grep_config(const char *var, const char *value, void *cb)
 		opt->color = git_config_colorbool(var, value, -1);
 		return 0;
 	}
+	if (!strcmp(var, "grep.color.external") ||
+	    !strcmp(var, "color.grep.external")) {
+		return git_config_string(&(opt->color_external), var, value);
+	}
 	if (!strcmp(var, "grep.color.match") ||
 	    !strcmp(var, "color.grep.match")) {
 		if (!value)
@@ -287,6 +291,21 @@ static int flush_grep(struct grep_opt *opt,
 	return status;
 }
 
+static void grep_add_color(struct strbuf *sb, const char *escape_seq)
+{
+	size_t orig_len = sb->len;
+
+	while (*escape_seq) {
+		if (*escape_seq == 'm')
+			strbuf_addch(sb, ';');
+		else if (*escape_seq != '\033' && *escape_seq  != '[')
+			strbuf_addch(sb, *escape_seq);
+		escape_seq++;
+	}
+	if (sb->len > orig_len && sb->buf[sb->len - 1] == ';')
+		strbuf_setlen(sb, sb->len - 1);
+}
+
 static int external_grep(struct grep_opt *opt, const char **paths, int cached)
 {
 	int i, nr, argc, hit, len, status;
@@ -357,6 +376,23 @@ static int external_grep(struct grep_opt *opt, const char **paths, int cached)
 		push_arg("-e");
 		push_arg(p->pattern);
 	}
+	if (opt->color) {
+		struct strbuf sb = STRBUF_INIT;
+
+		grep_add_color(&sb, opt->color_match);
+		setenv("GREP_COLOR", sb.buf, 1);
+
+		strbuf_reset(&sb);
+		strbuf_addstr(&sb, "mt=");
+		grep_add_color(&sb, opt->color_match);
+		strbuf_addstr(&sb, ":sl=:cx=:fn=:ln=:bn=:se=");
+		setenv("GREP_COLORS", sb.buf, 1);
+
+		strbuf_release(&sb);
+
+		if (opt->color_external && strlen(opt->color_external) > 0)
+			push_arg(opt->color_external);
+	}
 
 	hit = 0;
 	argc = nr;
diff --git a/grep.h b/grep.h
index 73b33ab..a67005d 100644
--- a/grep.h
+++ b/grep.h
@@ -80,6 +80,7 @@ struct grep_opt {
 	unsigned null_following_name:1;
 	int color;
 	char color_match[COLOR_MAXLEN];
+	const char *color_external;
 	int regflags;
 	unsigned pre_context;
 	unsigned post_context;
-- 
1.6.2
