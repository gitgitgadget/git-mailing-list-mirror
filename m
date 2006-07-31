From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pager: config variable pager.color
Date: Sun, 30 Jul 2006 17:43:21 -0700
Message-ID: <7vd5bmbo46.fsf@assigned-by-dhcp.cox.net>
References: <E1G6xHb-0008Rw-G2@moooo.ath.cx>
	<Pine.LNX.4.63.0607300112340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<E1G6zPH-00062L-Je@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 31 02:44:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7LtH-00027j-1G
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 02:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbWGaAnl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 20:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWGaAnl
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 20:43:41 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:16894 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932499AbWGaAnW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jul 2006 20:43:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060731004322.LOCV12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 30 Jul 2006 20:43:22 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1G6zPH-00062L-Je@moooo.ath.cx> (Matthias Lederhofer's message
	of "Sun, 30 Jul 2006 02:43:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24481>

Matthias Lederhofer <matled@gmx.net> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> Why? The three users of cmd_log_walk() need to call setup_pager() 
>> explicitely, when cmd_log_walk() can do it for them?
>
> The explanation is below the commit message:
> "setup_pager has to be called before git_diff_ui_config because the
> latter uses pager_use_color initialized by setup_pager."

If that is the reason, perhaps we could restructure the setting
and use of of diff_use_color_default like the attached, which
would be cleaner.

-- >8 --

diff --git a/cache.h b/cache.h
index 8891073..913be6a 100644
--- a/cache.h
+++ b/cache.h
@@ -392,6 +392,7 @@ extern int receive_keep_pack(int fd[2], 
 /* pager.c */
 extern void setup_pager(void);
 extern int pager_in_use;
+extern int pager_use_color;
 
 /* base85 */
 int decode_85(char *dst, char *line, int linelen);
diff --git a/diff.c b/diff.c
index 6198a61..043ecb1 100644
--- a/diff.c
+++ b/diff.c
@@ -173,14 +173,8 @@ int git_diff_ui_config(const char *var, 
 	if (!strcmp(var, "diff.color")) {
 		if (!value)
 			diff_use_color_default = 1; /* bool */
-		else if (!strcasecmp(value, "auto")) {
-			diff_use_color_default = 0;
-			if (isatty(1) || pager_in_use) {
-				char *term = getenv("TERM");
-				if (term && strcmp(term, "dumb"))
-					diff_use_color_default = 1;
-			}
-		}
+		else if (!strcasecmp(value, "auto"))
+			diff_use_color_default = -1; /* decide in setup */
 		else if (!strcasecmp(value, "never"))
 			diff_use_color_default = 0;
 		else if (!strcasecmp(value, "always"))
@@ -1509,6 +1503,14 @@ void diff_setup(struct diff_options *opt
 
 	options->change = diff_change;
 	options->add_remove = diff_addremove;
+	if (diff_use_color_default < 0) {
+		diff_use_color_default = 0;
+		if (isatty(1) || (pager_in_use && pager_use_color)) {
+			char *term = getenv("TERM");
+			if (term && strcmp(term, "dumb"))
+				diff_use_color_default = 1;
+		}
+	}
 	options->color_diff = diff_use_color_default;
 	options->detect_rename = diff_detect_rename_default;
 }
diff --git a/environment.c b/environment.c
index 558801a..1ce3411 100644
--- a/environment.c
+++ b/environment.c
@@ -23,6 +23,7 @@ int shared_repository = PERM_UMASK;
 const char *apply_default_whitespace = NULL;
 int zlib_compression_level = Z_DEFAULT_COMPRESSION;
 int pager_in_use;
+int pager_use_color = 1;
 
 static int dyn_git_object_dir, dyn_git_index_file, dyn_git_graft_file;
 static char *git_dir, *git_object_dir, *git_index_file, *git_refs_dir,
diff --git a/pager.c b/pager.c
index 3f753f6..e86ea9e 100644
--- a/pager.c
+++ b/pager.c
@@ -14,6 +14,10 @@ static int git_pager_config(const char *
 			pager = strdup(value);
 		return 0;
 	}
+	if (!strcmp(var, "pager.color")) {
+		pager_use_color = git_config_bool(var, value);
+		return 0;
+	}
 	return 0;
 }
 
