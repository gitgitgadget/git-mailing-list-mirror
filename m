From: Matthias Kestenholz <mk@spinlock.ch>
Subject: Re: [PATCH/resend] add--interactive: allow diff colors without
	interactive colors
Date: Sat, 05 Jan 2008 11:58:04 +0100
Message-ID: <1199530684.6209.6.camel@futex>
References: <20080104083521.GB3354@coredump.intra.peff.net>
	 <7v3atdi0na.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 11:58:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB6jn-0001mc-B6
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 11:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290AbYAEK6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 05:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbYAEK6L
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 05:58:11 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:50336 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010AbYAEK6K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 05:58:10 -0500
Received: by fg-out-1718.google.com with SMTP id e21so3802770fga.17
        for <git@vger.kernel.org>; Sat, 05 Jan 2008 02:58:07 -0800 (PST)
Received: by 10.86.97.7 with SMTP id u7mr17772242fgb.39.1199530686943;
        Sat, 05 Jan 2008 02:58:06 -0800 (PST)
Received: from ?192.168.1.8? ( [83.78.66.175])
        by mx.google.com with ESMTPS id 4sm14279079fgg.4.2008.01.05.02.58.05
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 05 Jan 2008 02:58:05 -0800 (PST)
In-Reply-To: <7v3atdi0na.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.21.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69664>

(trying to resend because vger.kernel.org would not let the previous
email pass to the list. I am very sorry. The Evolution MUA is making
trouble.)

On Fri, 2008-01-04 at 16:20 -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > Users with color.diff set to true/auto will not see color in
> > "git add -i" unless they also set color.interactive.
> >
> > However, some users may want just one without the other, so
> > there's no reason to tie them together.
> >
> > Note that there is now no way to have color on for "git
> > diff" but not for diffs from "git add -i"; such a
> > configuration seems unlikely, though.
> 
> Although I would agree with what this patch does, I think you
> are contradicting with yourself in the above justification.
> Some users may want to color "git diff" output but not
> interaction with "git add -i", and that's also "just one without
> the other", but you just tied them together, only differently,
> and "seems unlikely" is a rather weak excuse.
> 
> The justification should instead be: having more independent
> knobs is not necessarily better.  The user should not have to
> tweak too many knobs.
> 
> In the longer term, I think we should try reducing the number of
> knobs by giving "color.git" that allows you to pretend as if all
> of the "color.interactive", "color.diff", "color.status",
> "color.someothercolorizedcommand" are all set.  I do not think
> being able to control the use of colors per command is giving
> much other than confusion to the user.
> 
> That may not be so easy with the current structure of the config
> reader, though.

I managed to throw something together which works and passes all
the tests. Documentation included. :-)

I would be happy for feedback and suggestions.

-- 8< --

>From 90663fa5a7ac1a59d74aab3aa4d2bd8397340bd4 Mon Sep 17 00:00:00 2001
From: Matthias Kestenholz <matthias@spinlock.ch>
Date: Sat, 5 Jan 2008 11:20:08 +0100
Subject: [PATCH] Add global color config switch color.git

Signed-off-by: Matthias Kestenholz <matthias@spinlock.ch>
---
 Documentation/config.txt  |    6 ++++++
 builtin-branch.c          |    4 ++--
 builtin-log.c             |    3 ++-
 cache.h                   |    1 +
 color.c                   |   12 ++++++++++++
 color.h                   |    3 +++
 diff.c                    |    4 ++--
 git-add--interactive.perl |    4 ++--
 wt-status.c               |    4 ++--
 9 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ee08845..0a40102 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -405,6 +405,12 @@ color.diff.<slot>::
 	whitespace errors). The values of these variables may be specified as
 	in color.branch.<slot>.
 
+color.git::
+	When set to `always`, always use colors in all git commands which
+	are capable of colored output. When false (or `never`), never. When
+	set to `true` or `auto`, use colors only when the output is to the
+	terminal. Defaults to false.
+
 color.interactive::
 	When set to `always`, always use colors in `git add --interactive`.
 	When false (or `never`), never.  When set to `true` or `auto`, use
diff --git a/builtin-branch.c b/builtin-branch.c
index 089cae5..8179938 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -76,12 +76,12 @@ static int git_branch_config(const char *var, const char *value)
 	if (!strcmp(var, "branch.autosetupmerge"))
 			branch_track = git_config_bool(var, value);
 
-	return git_default_config(var, value);
+	return git_use_color_config(var, value) || git_default_config(var, value);
 }
 
 static const char *branch_get_color(enum color_branch ix)
 {
-	if (branch_use_color)
+	if (branch_use_color || git_use_color)
 		return branch_colors[ix];
 	return "";
 }
diff --git a/builtin-log.c b/builtin-log.c
index dcc9f81..03ba732 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -436,7 +436,8 @@ static int git_format_config(const char *var, const char *value)
 		fmt_patch_suffix = xstrdup(value);
 		return 0;
 	}
-	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
+	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")
+			|| !strcmp(var, "color.git")) {
 		return 0;
 	}
 	if (!strcmp(var, "format.numbered")) {
diff --git a/cache.h b/cache.h
index 39331c2..0968551 100644
--- a/cache.h
+++ b/cache.h
@@ -329,6 +329,7 @@ extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern int auto_crlf;
+extern int git_use_color;
 
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
diff --git a/color.c b/color.c
index 7f66c29..c891fd8 100644
--- a/color.c
+++ b/color.c
@@ -3,6 +3,8 @@
 
 #define COLOR_RESET "\033[m"
 
+int git_use_color = 0;
+
 static int parse_color(const char *name, int len)
 {
 	static const char * const color_names[] = {
@@ -143,6 +145,16 @@ int git_config_colorbool(const char *var, const char *value, int stdout_is_tty)
 	return 0;
 }
 
+int git_use_color_config(const char *var, const char *value)
+{
+	if(!strcmp(var, "color.git")) {
+		git_use_color = git_config_colorbool(var, value, -1);
+		return 1;
+	}
+
+	return 0;
+}
+
 static int color_vfprintf(FILE *fp, const char *color, const char *fmt,
 		va_list args, const char *trail)
 {
diff --git a/color.h b/color.h
index ff63513..929ebf2 100644
--- a/color.h
+++ b/color.h
@@ -4,7 +4,10 @@
 /* "\033[1;38;5;2xx;48;5;2xxm\0" is 23 bytes */
 #define COLOR_MAXLEN 24
 
+extern int git_use_color;
+
 int git_config_colorbool(const char *var, const char *value, int stdout_is_tty);
+int git_use_color_config(const char *var, const char *value);
 void color_parse(const char *var, const char *value, char *dst);
 int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
 int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...);
diff --git a/diff.c b/diff.c
index 5bdc111..5fa6d14 100644
--- a/diff.c
+++ b/diff.c
@@ -184,7 +184,7 @@ int git_diff_ui_config(const char *var, const char *value)
 		return 0;
 	}
 
-	return git_default_config(var, value);
+	return git_use_color_config(var, value) || git_default_config(var, value);
 }
 
 static char *quote_two(const char *one, const char *two)
@@ -2021,7 +2021,7 @@ void diff_setup(struct diff_options *options)
 
 	options->change = diff_change;
 	options->add_remove = diff_addremove;
-	if (diff_use_color_default)
+	if (diff_use_color_default || git_use_color)
 		DIFF_OPT_SET(options, COLOR_DIFF);
 	else
 		DIFF_OPT_CLR(options, COLOR_DIFF);
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 0cdd800..eaae888 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -11,7 +11,7 @@ my ($new_color, $old_color, $fraginfo_color, $metainfo_color, $whitespace_color)
 my ($use_color, $diff_use_color);
 my $repo = Git->repository();
 
-$use_color = $repo->get_colorbool('color.interactive');
+$use_color = $repo->get_colorbool('color.interactive') || $repo->get_colorbool('color.git');
 
 if ($use_color) {
 	# Set interactive colors:
@@ -24,7 +24,7 @@ if ($use_color) {
 	$normal_color = $repo->get_color("", "reset");
 
 	# Do we also set diff colors?
-	$diff_use_color = $repo->get_colorbool('color.diff');
+	$diff_use_color = $repo->get_colorbool('color.diff') || $repo->get_colorbool('color.git');
 	if ($diff_use_color) {
 		$new_color = $repo->get_color("color.diff.new", "green");
 		$old_color = $repo->get_color("color.diff.old", "red");
diff --git a/wt-status.c b/wt-status.c
index c0c2472..1c4169c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -40,7 +40,7 @@ static int parse_status_slot(const char *var, int offset)
 
 static const char* color(int slot)
 {
-	return wt_status_use_color ? wt_status_colors[slot] : "";
+	return wt_status_use_color || git_use_color ? wt_status_colors[slot] : "";
 }
 
 void wt_status_prepare(struct wt_status *s)
@@ -409,5 +409,5 @@ int git_status_config(const char *k, const char *v)
 		wt_status_relative_paths = git_config_bool(k, v);
 		return 0;
 	}
-	return git_default_config(k, v);
+	return git_use_color_config(k, v) || git_default_config(k, v);
 }
-- 
1.5.4.rc2.1105.g90663f
