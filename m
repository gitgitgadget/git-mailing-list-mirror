From: Linus Torvalds <torvalds@osdl.org>
Subject: Add ".git/config" file parser
Date: Mon, 10 Oct 2005 14:35:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510101415080.14597@g5.osdl.org>
References: <20051008180023.GC28875@diku.dk> <7vfyrbrgdw.fsf@assigned-by-dhcp.cox.net>
 <20051008213612.GA5794@steel.home> <7vzmpjoa32.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510081909250.31407@g5.osdl.org> <Pine.LNX.4.63.0510100220330.23242@iabervon.org>
 <7vu0fpbz43.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0510101354520.23242@iabervon.org>
 <Pine.LNX.4.64.0510101120410.14597@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 10 23:38:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP5JD-000208-GC
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 23:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbVJJVfn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 17:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbVJJVfn
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 17:35:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25806 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751261AbVJJVfm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2005 17:35:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9ALZb4s006449
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 10 Oct 2005 14:35:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9ALZa1d007051;
	Mon, 10 Oct 2005 14:35:36 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0510101120410.14597@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.123 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9944>


This is a first cut at a very simple parser for a git config file.

The format of the file is a simple ini-file like thing, with simple 
variable/value pairs. You can (and should) make the variables have a 
simple single-level scope, ie a valid file looks something like this:

	#
	# This is the config file, and
	# a '#' or ';' character indicates
	# a comment
	#

	; core variables
	[core]
		; Don't trust file modes
		filemode = false

	; Our diff algorithm 
	[diff]
		external = "/usr/local/bin/gnu-diff -u"
		renames = true

which parses into two variables: "core.filemode" is associated with the 
string "false", and "diff.external" gets the appropriate quoted value.

Right now we only react to one variable: "core.filemode" is a boolean that 
decides if we should care about the 0100 (user-execute) bit of the stat 
information. Even that is just a parsing demonstration - this doesn't 
actually implement that st_mode compare logic itself.

Different programs can react to different config options, although they 
should always fall back to calling "git_default_config()" on any config 
option name that they don't recognize.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
----

Ok, so it's stupid. But quite frankly, I think the Windows ini-file format 
is a hell of a lot more readable than something over-engineered like XML 
files or other crap.

The interface is really easy to use, imho. You can do things like

	static int enable_renames = 0;

	static int my_options(const char *var, const char *value)
	{
		if (!strcmp("diff.renames", var)) {
			enable_renames = git_config_bool(var, value);
			return 0;
		}

		/*
		 * Put other local option parsing for this program
		 * here .. 
		 */

		/* Fall back on the default ones */
		return git_default_config(var, value);
	}

and then in the "main()" routine you just do

		git_config(my_options);

at the top (or, more precisely, just after the "git_setup_directory()" if 
you have one).

And as usual, it's not like this has gotten a whole lot of testing.

Flames, comments, whatever? The code is actually written so that the 
config file parsing should really be pretty neutral. It doesn't even have 
any git-specific in it, except for the naming and the actual initial 
"fopen()" pathname used, I think.

---
diff --git a/Makefile b/Makefile
index a201187..e8b46f1 100644
--- a/Makefile
+++ b/Makefile
@@ -158,7 +158,7 @@ LIB_OBJS = \
 	object.o pack-check.o patch-delta.o path.o pkt-line.o \
 	quote.o read-cache.o refs.o run-command.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
-	tag.o tree.o usage.o $(DIFF_OBJS)
+	tag.o tree.o usage.o config.o $(DIFF_OBJS)
 
 LIBS = $(LIB_FILE)
 LIBS += -lz
diff --git a/cache.h b/cache.h
index 5987d4c..0571282 100644
--- a/cache.h
+++ b/cache.h
@@ -178,6 +178,8 @@ extern int hold_index_file_for_update(st
 extern int commit_index_file(struct cache_file *);
 extern void rollback_index_file(struct cache_file *);
 
+extern int trust_executable_bit;
+
 #define MTIME_CHANGED	0x0001
 #define CTIME_CHANGED	0x0002
 #define OWNER_CHANGED	0x0004
@@ -372,4 +374,10 @@ extern int gitfakemunmap(void *start, si
 
 #endif
 
+typedef int (*config_fn_t)(const char *, const char *);
+extern int git_default_config(const char *, const char *);
+extern int git_config(config_fn_t fn);
+extern int git_config_int(const char *, const char *);
+extern int git_config_bool(const char *, const char *);
+
 #endif /* CACHE_H */
diff --git a/config.c b/config.c
new file mode 100644
index 0000000..f3c4fa4
--- /dev/null
+++ b/config.c
@@ -0,0 +1,222 @@
+#include <ctype.h>
+
+#include "cache.h"
+
+#define MAXNAME (256)
+
+static FILE *config_file;
+static int config_linenr;
+static int get_next_char(void)
+{
+	int c;
+	FILE *f;
+
+	c = '\n';
+	if ((f = config_file) != NULL) {
+		c = fgetc(f);
+		if (c == '\n')
+			config_linenr++;
+		if (c == EOF) {
+			config_file = NULL;
+			c = '\n';
+		}
+	}
+	return c;
+}
+
+static char *parse_value(void)
+{
+	static char value[1024];
+	int quote = 0, comment = 0, len = 0, space = 0;
+
+	for (;;) {
+		int c = get_next_char();
+		if (len >= sizeof(value))
+			return NULL;
+		if (c == '\n') {
+			if (quote)
+				return NULL;
+			value[len] = 0;
+			return value;
+		}
+		if (comment)
+			continue;
+		if (isspace(c) && !quote) {
+			space = 1;
+			continue;
+		}
+		if (space) {
+			if (len)
+				value[len++] = ' ';
+			space = 0;
+		}
+		if (c == '\\') {
+			c = get_next_char();
+			switch (c) {
+			case '\n':
+				continue;
+			case 't':
+				c = '\t';
+				break;
+			case 'b':
+				c = '\b';
+				break;
+			case 'n':
+				c = '\n';
+				break;
+			return NULL;
+			}
+			value[len++] = c;
+			continue;
+		}
+		if (c == '"') {
+			quote = 1-quote;
+			continue;
+		}
+		if (!quote) {
+			if (c == ';' || c == '#') {
+				comment = 1;
+				continue;
+			}
+		}
+		value[len++] = c;
+	}
+}
+
+static int get_value(config_fn_t fn, char *name, unsigned int len)
+{
+	int c;
+	char *value;
+
+	/* Get the full name */
+	for (;;) {
+		c = get_next_char();
+		if (c == EOF)
+			break;
+		if (!isalnum(c))
+			break;
+		name[len++] = tolower(c);
+		if (len >= MAXNAME)
+			return -1;
+	}
+	name[len] = 0;
+	while (c == ' ' || c == '\t')
+		c = get_next_char();
+
+	value = NULL;
+	if (c != '\n') {
+		if (c != '=')
+			return -1;
+		value = parse_value();
+		if (!value)
+			return -1;
+	}
+	return fn(name, value);
+}
+
+static int get_base_var(char *name)
+{
+	int baselen = 0;
+
+	for (;;) {
+		int c = get_next_char();
+		if (c == EOF)
+			return -1;
+		if (c == ']')
+			return baselen;
+		if (!isalnum(c))
+			return -1;
+		if (baselen > MAXNAME / 2)
+			return -1;
+		name[baselen++] = tolower(c);
+	}
+}
+
+static int git_parse_file(config_fn_t fn)
+{
+	int comment = 0;
+	int baselen = 0;
+	static char var[MAXNAME];
+
+	for (;;) {
+		int c = get_next_char();
+		if (c == '\n') {
+			/* EOF? */
+			if (!config_file)
+				return 0;
+			comment = 0;
+			continue;
+		}
+		if (comment || isspace(c))
+			continue;
+		if (c == '#' || c == ';') {
+			comment = 1;
+			continue;
+		}
+		if (c == '[') {
+			baselen = get_base_var(var);
+			if (baselen <= 0)
+				break;
+			var[baselen++] = '.';
+			var[baselen] = 0;
+			continue;
+		}
+		if (!isalpha(c))
+			break;
+		var[baselen] = c;
+		if (get_value(fn, var, baselen+1) < 0)
+			break;
+	}
+	die("bad config file line %d", config_linenr);
+}
+
+int git_config_int(const char *name, const char *value)
+{
+	if (value && *value) {
+		char *end;
+		int val = strtol(value, &end, 0);
+		if (!*end)
+			return val;
+	}
+	die("bad config value for '%s'", name);
+}
+
+int git_config_bool(const char *name, const char *value)
+{
+	if (!value)
+		return 1;
+	if (!*value)
+		return 0;
+	if (!strcasecmp(value, "true"))
+		return 1;
+	if (!strcasecmp(value, "false"))
+		return 0;
+	return git_config_int(name, value) != 0;
+}
+
+int git_default_config(const char *var, const char *value)
+{
+	/* This needs a better name */
+	if (!strcmp(var, "core.filemode")) {
+		trust_executable_bit = git_config_bool(var, value);
+		return 0;
+	}
+
+	/* Add other config variables here.. */
+	return 0;
+}
+
+int git_config(config_fn_t fn)
+{
+	int ret;
+	FILE *f = fopen(git_path("config"), "r");
+
+	ret = -1;
+	if (f) {
+		config_file = f;
+		config_linenr = 1;
+		ret = git_parse_file(fn);
+		fclose(f);
+	}
+	return ret;
+}
diff --git a/diff-files.c b/diff-files.c
index 5e59832..96d2c7f 100644
--- a/diff-files.c
+++ b/diff-files.c
@@ -38,6 +38,7 @@ int main(int argc, const char **argv)
 	const char *prefix = setup_git_directory();
 	int entries, i;
 
+	git_config(git_default_config);
 	diff_setup(&diff_options);
 	while (1 < argc && argv[1][0] == '-') {
 		if (!strcmp(argv[1], "-q"))
diff --git a/diff-tree.c b/diff-tree.c
index b2d74eb..2203fa5 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -408,6 +408,7 @@ int main(int argc, const char **argv)
 	unsigned char sha1[2][20];
 	const char *prefix = setup_git_directory();
 
+	git_config(git_default_config);
 	nr_sha1 = 0;
 	diff_setup(&diff_options);
 
diff --git a/read-cache.c b/read-cache.c
index d2aebdd..c7f3b26 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 
+int trust_executable_bit = 1;
 struct cache_entry **active_cache = NULL;
 unsigned int active_nr = 0, active_alloc = 0, active_cache_changed = 0;
 
