From: Jeff King <peff@peff.net>
Subject: Re: 'git log' escape symbols shown as ESC[33 and ESC[m
Date: Thu, 16 Jan 2014 21:13:20 -0500
Message-ID: <20140117021320.GA12444@sigill.intra.peff.net>
References: <52D87A79.6060600@rawbw.com>
 <20140117014758.GF7249@sigill.intra.peff.net>
 <52D88F30.4000807@rawbw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Yuri <yuri@rawbw.com>
X-From: git-owner@vger.kernel.org Fri Jan 17 03:13:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3yw3-0001Ut-Hs
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 03:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbaAQCNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 21:13:24 -0500
Received: from cloud.peff.net ([50.56.180.127]:33907 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751310AbaAQCNW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 21:13:22 -0500
Received: (qmail 8614 invoked by uid 102); 17 Jan 2014 02:13:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jan 2014 20:13:22 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jan 2014 21:13:20 -0500
Content-Disposition: inline
In-Reply-To: <52D88F30.4000807@rawbw.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240558>

On Thu, Jan 16, 2014 at 06:02:24PM -0800, Yuri wrote:

> On 01/16/2014 17:47, Jeff King wrote:
> >Are you using "less" as your pager (it is the default in git unless you
> >have set your PAGER environment variable)? If so, do you have the "R"
> >option set to pass through ANSI codes? Git will set this automatically
> >in your "LESS" variable if you do not already have such a variable (but
> >it will not touch it if you already have it set, and are missing "R").
> 
> My PAGER variable was set to "more". PAGER=more is also a default for
> a newly created user in FreeBSD.

Interesting. I take it that "more" does not pass through ANSI codes at
all, then.

> So what would be the correct fix here in general, so that git will
> work fine for a new unchanged user?

This was a non-issue until 4c7f181 (make color.ui default to 'auto',
2013-06-10), which was released in git v1.8.4, as people had to
explicitly turn color on. I'm cc-ing Matthieu, who authored that commit.

You can:

  git config color.ui false

to turn off color completely. But in this case, I think it is more
exact to tell git simply that your pager does not handle color:

  git config color.pager false

Obviously that does not help the "new unchanged user".  I think we can
be smarter about guessing whether the pager can actually handle color,
based on the name. Is it possible for you to compile git with the patch
below? It should make your problem go away without having to configure
anything. It can't cover every possible pager, but I think it should
catch the common ones.

---
diff --git a/cache.h b/cache.h
index 83a2726..7fd1977 100644
--- a/cache.h
+++ b/cache.h
@@ -1215,7 +1215,8 @@ static inline ssize_t write_str_in_full(int fd, const char *str)
 extern void setup_pager(void);
 extern const char *pager_program;
 extern int pager_in_use(void);
-extern int pager_use_color;
+extern int pager_use_color_config;
+extern int pager_use_color(void);
 extern int term_columns(void);
 extern int decimal_width(int);
 extern int check_pager_config(const char *cmd);
diff --git a/color.c b/color.c
index f672885..ffbff40 100644
--- a/color.c
+++ b/color.c
@@ -184,7 +184,7 @@ static int check_auto_color(void)
 {
 	if (color_stdout_is_tty < 0)
 		color_stdout_is_tty = isatty(1);
-	if (color_stdout_is_tty || (pager_in_use() && pager_use_color)) {
+	if (color_stdout_is_tty || (pager_in_use() && pager_use_color())) {
 		char *term = getenv("TERM");
 		if (term && strcmp(term, "dumb"))
 			return 1;
diff --git a/config.c b/config.c
index d969a5a..2a8236b 100644
--- a/config.c
+++ b/config.c
@@ -991,7 +991,7 @@ int git_default_config(const char *var, const char *value, void *dummy)
 		return git_default_advice_config(var, value);
 
 	if (!strcmp(var, "pager.color") || !strcmp(var, "color.pager")) {
-		pager_use_color = git_config_bool(var,value);
+		pager_use_color_config = git_config_bool(var,value);
 		return 0;
 	}
 
diff --git a/environment.c b/environment.c
index 3c76905..5cd642f 100644
--- a/environment.c
+++ b/environment.c
@@ -39,7 +39,7 @@ size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 16 * 1024 * 1024;
 unsigned long big_file_threshold = 512 * 1024 * 1024;
 const char *pager_program;
-int pager_use_color = 1;
+int pager_use_color_config = -1;
 const char *editor_program;
 const char *askpass_program;
 const char *excludes_file;
diff --git a/pager.c b/pager.c
index 0cc75a8..a816af3 100644
--- a/pager.c
+++ b/pager.c
@@ -182,3 +182,38 @@ int check_pager_config(const char *cmd)
 		pager_program = c.value;
 	return c.want;
 }
+
+static int pager_can_handle_color(void)
+{
+	const char *pager = git_pager(1);
+
+	/*
+	 * If it's less, we automatically set "R" and can handle color,
+	 * unless the user already has a "LESS" variable that does not
+	 * include "R".
+	 */
+	if (!strcmp(pager, "less")) {
+		const char *x = getenv("LESS");
+		return !x || !!strchr(x, 'R');
+	}
+
+	/*
+	 * We know that "more" does not pass through colors at all.
+	 */
+	if (!strcmp(pager, "more"))
+		return 0;
+
+	/*
+	 * Otherwise, we don't recognize it. Guess that it can probably handle
+	 * color. This matches historical behavior, though it is probably not
+	 * the safest default.
+	 */
+	return 1;
+}
+
+int pager_use_color(void)
+{
+	if (pager_use_color_config < 0)
+		pager_use_color_config = pager_can_handle_color();
+	return pager_use_color_config;
+}
