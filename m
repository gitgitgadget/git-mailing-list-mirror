From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff --color: use $GIT_DIR/config
Date: Sat, 24 Jun 2006 04:12:42 -0700
Message-ID: <7v7j36yfh1.fsf_-_@assigned-by-dhcp.cox.net>
References: <7v8xnpj7hg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606221301500.5498@g5.osdl.org>
	<Pine.LNX.4.63.0606231305000.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0606230756050.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jun 24 13:12:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu64E-00017T-M6
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 13:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210AbWFXLMo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 07:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752211AbWFXLMo
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 07:12:44 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:24485 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1752209AbWFXLMn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 07:12:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624111243.EXBN19057.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 07:12:43 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.64.0606230756050.6483@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 23 Jun 2006 07:59:33 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22500>

This lets you use something like this in your $GIT_DIR/config
file.

	[diff]
		color = auto

	[diff.color]
		new = blue
		old = yellow
		frag = reverse

When diff.color is set to "auto", colored diff is enabled when
the standard output is the terminal.  Other choices are "always",
and "never".  Usual boolean true/false can also be used.

The colormap entries can specify colors for the following slots:

	plain	- lines that appear in both old and new file (context)
	meta	- diff --git header and extended git diff headers
	frag	- @@ -n,m +l,k @@ lines (hunk header)
	old	- lines deleted from old file
	new	- lines added to new file

The following color names can be used:

	normal, bold, dim, l, blink, reverse, reset,
	black, red, green, yellow, blue, magenta, cyan,
	white

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Linus Torvalds <torvalds@osdl.org> writes:

 > Which just means that we should have some way to let people set their own 
 > colors.

 At the source level it is easy to specify color and attribute
 combinations (e.g. "bold|red") by having the preprocessor
 concatenate string literals, but I was too lazy to allow that
 from the configuration level.  People might want to have that,
 though.

 BTW, while doing this, I noticed that the patch does not do the
 color output for combined diffs.  Care to look into it after
 Timo's output format series settles?

 cache.h |    1 -
 diff.c  |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 80 insertions(+), 15 deletions(-)

diff --git a/cache.h b/cache.h
index efeafea..3502fee 100644
--- a/cache.h
+++ b/cache.h
@@ -181,7 +181,6 @@ extern int assume_unchanged;
 extern int prefer_symlink_refs;
 extern int log_all_ref_updates;
 extern int warn_ambiguous_refs;
-extern int diff_rename_limit_default;
 extern int shared_repository;
 extern const char *apply_default_whitespace;
 
diff --git a/diff.c b/diff.c
index 1db0285..33c8c57 100644
--- a/diff.c
+++ b/diff.c
@@ -13,17 +13,8 @@ #include "xdiff-interface.h"
 
 static int use_size_cache;
 
-int diff_rename_limit_default = -1;
-
-int git_diff_config(const char *var, const char *value)
-{
-	if (!strcmp(var, "diff.renamelimit")) {
-		diff_rename_limit_default = git_config_int(var, value);
-		return 0;
-	}
-
-	return git_default_config(var, value);
-}
+static int diff_rename_limit_default = -1;
+static int diff_use_color_default = 0;
 
 enum color_diff {
 	DIFF_RESET = 0,
@@ -51,9 +42,6 @@ #define COLOR_MAGENTA "\033[35m"
 #define COLOR_CYAN    "\033[36m"
 #define COLOR_WHITE   "\033[37m"
 
-#define COLOR_CYANBG  "\033[46m"
-#define COLOR_GRAYBG  "\033[47m"	// Good for xterm
-
 static const char *diff_colors[] = {
 	[DIFF_RESET]    = COLOR_RESET,
 	[DIFF_PLAIN]    = COLOR_NORMAL,
@@ -63,6 +51,83 @@ static const char *diff_colors[] = {
 	[DIFF_FILE_NEW] = COLOR_GREEN,
 };
 
+static int parse_diff_color_slot(const char *var, int ofs)
+{
+	if (!strcasecmp(var+ofs, "plain"))
+		return DIFF_PLAIN;
+	if (!strcasecmp(var+ofs, "meta"))
+		return DIFF_METAINFO;
+	if (!strcasecmp(var+ofs, "frag"))
+		return DIFF_FRAGINFO;
+	if (!strcasecmp(var+ofs, "old"))
+		return DIFF_FILE_OLD;
+	if (!strcasecmp(var+ofs, "new"))
+		return DIFF_FILE_NEW;
+	die("bad config variable '%s'", var);
+}
+
+static const char *parse_diff_color_value(const char *value, const char *var)
+{
+	if (!strcasecmp(value, "normal"))
+		return COLOR_NORMAL;
+	if (!strcasecmp(value, "bold"))
+		return COLOR_BOLD;
+	if (!strcasecmp(value, "dim"))
+		return COLOR_DIM;
+	if (!strcasecmp(value, "ul"))
+		return COLOR_UL;
+	if (!strcasecmp(value, "blink"))
+		return COLOR_BLINK;
+	if (!strcasecmp(value, "reverse"))
+		return COLOR_REVERSE;
+	if (!strcasecmp(value, "reset"))
+		return COLOR_RESET;
+	if (!strcasecmp(value, "black"))
+		return COLOR_BLACK;
+	if (!strcasecmp(value, "red"))
+		return COLOR_RED;
+	if (!strcasecmp(value, "green"))
+		return COLOR_GREEN;
+	if (!strcasecmp(value, "yellow"))
+		return COLOR_YELLOW;
+	if (!strcasecmp(value, "blue"))
+		return COLOR_BLUE;
+	if (!strcasecmp(value, "magenta"))
+		return COLOR_MAGENTA;
+	if (!strcasecmp(value, "cyan"))
+		return COLOR_CYAN;
+	if (!strcasecmp(value, "white"))
+		return COLOR_WHITE;
+	die("bad config value '%s' for variable '%s'", value, var);
+}
+
+int git_diff_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "diff.renamelimit")) {
+		diff_rename_limit_default = git_config_int(var, value);
+		return 0;
+	}
+	if (!strcmp(var, "diff.color")) {
+		if (!value)
+			diff_use_color_default = 1; /* bool */
+		else if (!strcasecmp(value, "auto"))
+			diff_use_color_default = isatty(1);
+		else if (!strcasecmp(value, "never"))
+			diff_use_color_default = 0;
+		else if (!strcasecmp(value, "always"))
+			diff_use_color_default = 1;
+		else
+			diff_use_color_default = git_config_bool(var, value);
+		return 0;
+	}
+	if (!strncmp(var, "diff.color.", 11)) {
+		int slot = parse_diff_color_slot(var, 11);
+		diff_colors[slot] = parse_diff_color_value(value, var);
+		return 0;
+	}
+	return git_default_config(var, value);
+}
+
 static char *quote_one(const char *str)
 {
 	int needlen;
@@ -1362,6 +1427,7 @@ void diff_setup(struct diff_options *opt
 
 	options->change = diff_change;
 	options->add_remove = diff_addremove;
+	options->color_diff = diff_use_color_default;
 }
 
 int diff_setup_done(struct diff_options *options)
-- 
1.4.1.rc1.ga77b7
