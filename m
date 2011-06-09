From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [RFC/PATCH] config.c: Make git_config() work correctly when called
 recursively
Date: Thu, 09 Jun 2011 18:45:28 +0100
Message-ID: <4DF106B8.2080902@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Erik Faye-Lund <kusmabite@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, johan@herland.net
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 19:47:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUjJu-0005UO-0M
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 19:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105Ab1FIRq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 13:46:57 -0400
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:59661 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753060Ab1FIRq4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2011 13:46:56 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1QUjJl-0002y8-X0; Thu, 09 Jun 2011 17:46:54 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175561>


On Cygwin, this fixes a test failure in t3301-notes.sh (test 98,
"git notes copy --for-rewrite (disabled)").

The test failure is caused by a recursive call to git_config() which
has the effect of skipping to the end-of-file while processing the
"notes.rewriteref" config variable. Thus, any config variables that
appear after "notes.rewriteref" are simply ignored by git_config().

The recursive call to git_config() is due to the "schizophrenic stat"
functions on cygwin, and is arrived at as follows:

  cmd_notes() : builtin/notes.c:1057
    =>copy() @1084: builtin/notes.c:605
      =>notes_copy_from_stdin() @630: builtin/notes.c:418
        =>init_copy_notes_for_rewrite() @426: builtin/notes.c:359
          =>git_config() @384: config.c:876

  *cb=>notes_rewite_config() : builtin/notes.c:329
    =>string_list_add_refs_by_glob() @348 : notes.c:936
      =>for_each_glob_ref() @939: refs.c:815
        =>for_each_glob_ref_in() @817: refs.c:785
          =>for_each_ref() @809: refs.c:729
            =>do_for_each_ref() @731: refs.c:658
              =>get_loose_refs() @663: refs.c:359
                =>get_ref_dir() @368: refs.c:258
                  =>stat() @299: compat/cygwin.h:8

  stat macro => indirect call: *cygwin_stat_fn : compat/cygwin.c:141
    =>cygwin_stat_stub() : compat/cygwin.c:131
      =>init_stat() @133: compat/cygwin.c:115
        =>git_config() @118: config.c:876

[The line numbers are from a somewhat recent version of git, but are
just quoted as a guide; some of them have probably already changed]

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

While rebasing my 'cygwin-tests' branch recently, this commit conflicted
with e96c19c5 (config: support values longer than 1023 bytes, 10-04-2011),
due to the replacement of the value char array with a strbuf.

I have not sent this patch to the list before, since I had planned to find
a different solution first, so this (updated patch) is more by way of an
extended bug-report! Having said that, it works fine ...

[I had also intended to check if a similar change for the key (currently
limited to MAXNAME) would be a good idea; my initial reaction was no since
we have control of the key names, with only a few exceptions eg. some keys
contain branch names ...]

ATB,
Ramsay Jones

 config.c |   80 ++++++++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/config.c b/config.c
index e0b3b80..1fc063b 100644
--- a/config.c
+++ b/config.c
@@ -12,10 +12,18 @@
 
 #define MAXNAME (256)
 
-static FILE *config_file;
-static const char *config_file_name;
-static int config_linenr;
-static int config_file_eof;
+typedef struct config_file {
+	struct config_file *prev;
+	FILE *f;
+	const char *name;
+	int linenr;
+	int eof;
+	struct strbuf value;
+	char var[MAXNAME];
+} config_file;
+
+static config_file *cf;
+
 static int zlib_compression_seen;
 
 const char *config_exclusive_filename = NULL;
@@ -99,7 +107,7 @@ static int get_next_char(void)
 	FILE *f;
 
 	c = '\n';
-	if ((f = config_file) != NULL) {
+	if (cf && ((f = cf->f) != NULL)) {
 		c = fgetc(f);
 		if (c == '\r') {
 			/* DOS like systems */
@@ -110,9 +118,9 @@ static int get_next_char(void)
 			}
 		}
 		if (c == '\n')
-			config_linenr++;
+			cf->linenr++;
 		if (c == EOF) {
-			config_file_eof = 1;
+			cf->eof = 1;
 			c = '\n';
 		}
 	}
@@ -121,21 +129,20 @@ static int get_next_char(void)
 
 static char *parse_value(void)
 {
-	static struct strbuf value = STRBUF_INIT;
 	int quote = 0, comment = 0, space = 0;
 
-	strbuf_reset(&value);
+	strbuf_reset(&cf->value);
 	for (;;) {
 		int c = get_next_char();
 		if (c == '\n') {
 			if (quote)
 				return NULL;
-			return value.buf;
+			return cf->value.buf;
 		}
 		if (comment)
 			continue;
 		if (isspace(c) && !quote) {
-			if (value.len)
+			if (cf->value.len)
 				space++;
 			continue;
 		}
@@ -146,7 +153,7 @@ static char *parse_value(void)
 			}
 		}
 		for (; space; space--)
-			strbuf_addch(&value, ' ');
+			strbuf_addch(&cf->value, ' ');
 		if (c == '\\') {
 			c = get_next_char();
 			switch (c) {
@@ -168,14 +175,14 @@ static char *parse_value(void)
 			default:
 				return NULL;
 			}
-			strbuf_addch(&value, c);
+			strbuf_addch(&cf->value, c);
 			continue;
 		}
 		if (c == '"') {
 			quote = 1-quote;
 			continue;
 		}
-		strbuf_addch(&value, c);
+		strbuf_addch(&cf->value, c);
 	}
 }
 
@@ -192,7 +199,7 @@ static int get_value(config_fn_t fn, void *data, char *name, unsigned int len)
 	/* Get the full name */
 	for (;;) {
 		c = get_next_char();
-		if (config_file_eof)
+		if (cf->eof)
 			break;
 		if (!iskeychar(c))
 			break;
@@ -256,7 +263,7 @@ static int get_base_var(char *name)
 
 	for (;;) {
 		int c = get_next_char();
-		if (config_file_eof)
+		if (cf->eof)
 			return -1;
 		if (c == ']')
 			return baselen;
@@ -274,7 +281,7 @@ static int git_parse_file(config_fn_t fn, void *data)
 {
 	int comment = 0;
 	int baselen = 0;
-	static char var[MAXNAME];
+	char *var = cf->var;
 
 	/* U+FEFF Byte Order Mark in UTF8 */
 	static const unsigned char *utf8_bom = (unsigned char *) "\xef\xbb\xbf";
@@ -298,7 +305,7 @@ static int git_parse_file(config_fn_t fn, void *data)
 			}
 		}
 		if (c == '\n') {
-			if (config_file_eof)
+			if (cf->eof)
 				return 0;
 			comment = 0;
 			continue;
@@ -323,7 +330,7 @@ static int git_parse_file(config_fn_t fn, void *data)
 		if (get_value(fn, data, var, baselen+1) < 0)
 			break;
 	}
-	die("bad config file line %d in %s", config_linenr, config_file_name);
+	die("bad config file line %d in %s", cf->linenr, cf->name);
 }
 
 static int parse_unit_factor(const char *end, unsigned long *val)
@@ -374,8 +381,8 @@ int git_parse_ulong(const char *value, unsigned long *ret)
 
 static void die_bad_config(const char *name)
 {
-	if (config_file_name)
-		die("bad config value for '%s' in %s", name, config_file_name);
+	if (cf && cf->name)
+		die("bad config value for '%s' in %s", name, cf->name);
 	die("bad config value for '%s'", name);
 }
 
@@ -795,13 +802,24 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 
 	ret = -1;
 	if (f) {
-		config_file = f;
-		config_file_name = filename;
-		config_linenr = 1;
-		config_file_eof = 0;
+		config_file top;
+
+		/* push config-file parsing state stack */
+		top.prev = cf;
+		top.f = f;
+		top.name = filename;
+		top.linenr = 1;
+		top.eof = 0;
+		strbuf_init(&top.value, 1024);
+		cf = &top;
+
 		ret = git_parse_file(fn, data);
+
+		/* pop config-file parsing state stack */
+		strbuf_release(&top.value);
+		cf = top.prev;
+
 		fclose(f);
-		config_file_name = NULL;
 	}
 	return ret;
 }
@@ -909,6 +927,7 @@ static int store_aux(const char *key, const char *value, void *cb)
 {
 	const char *ep;
 	size_t section_len;
+	FILE *f = cf->f;
 
 	switch (store.state) {
 	case KEY_SEEN:
@@ -920,7 +939,7 @@ static int store_aux(const char *key, const char *value, void *cb)
 				return 1;
 			}
 
-			store.offset[store.seen] = ftell(config_file);
+			store.offset[store.seen] = ftell(f);
 			store.seen++;
 		}
 		break;
@@ -947,19 +966,19 @@ static int store_aux(const char *key, const char *value, void *cb)
 		 * Do not increment matches: this is no match, but we
 		 * just made sure we are in the desired section.
 		 */
-		store.offset[store.seen] = ftell(config_file);
+		store.offset[store.seen] = ftell(f);
 		/* fallthru */
 	case SECTION_END_SEEN:
 	case START:
 		if (matches(key, value)) {
-			store.offset[store.seen] = ftell(config_file);
+			store.offset[store.seen] = ftell(f);
 			store.state = KEY_SEEN;
 			store.seen++;
 		} else {
 			if (strrchr(key, '.') - key == store.baselen &&
 			      !strncmp(key, store.key, store.baselen)) {
 					store.state = SECTION_SEEN;
-					store.offset[store.seen] = ftell(config_file);
+					store.offset[store.seen] = ftell(f);
 			}
 		}
 	}
@@ -1415,6 +1434,7 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 	struct lock_file *lock = xcalloc(sizeof(struct lock_file), 1);
 	int out_fd;
 	char buf[1024];
+	FILE *config_file;
 
 	if (config_exclusive_filename)
 		config_filename = xstrdup(config_exclusive_filename);
-- 
1.7.5
