From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in git.git and announcing v1.4.1-rc1
Date: Thu, 22 Jun 2006 13:53:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606221301500.5498@g5.osdl.org>
References: <7v8xnpj7hg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 22 22:53:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtWBN-0000Ct-7g
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 22:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbWFVUxl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 16:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbWFVUxl
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 16:53:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49810 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750775AbWFVUxk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 16:53:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5MKrWUT028744
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 22 Jun 2006 13:53:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5MKrVo9015467;
	Thu, 22 Jun 2006 13:53:32 -0700
To: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <7v8xnpj7hg.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22369>



On Thu, 22 Jun 2006, Junio C Hamano wrote:
> 
>  - diff --color (Johannes).

I like colorized diffs, but let's face it, those particular color choices 
will make most people decide to pick out their eyes with a fondue fork.

And that's not good. Digging in your eye-sockets with a fondue fork is 
strictly considered to be bad for your health, and seven out of nine 
optometrists are dead set against the practice.

So in order to avoid a lot of blind git users, please apply this patch.

This patch does:

 - always reset the color _before_ printing out the newline.

   This is actually important. You (and Johannes) didn't see it, because 
   it only matters if you set the background, but if you don't do this, 
   you get some random and funky behaviour if you pick a color with a 
   non-default background (which still potentially has problems with tabs 
   etc, but less so).

 - allow people to have a different color for the "file headers" 
   (DIFF_METAINFO) and for the "fragment header" (DIFF_FRAGINFO). Also, 
   make a difference between "normal color" and "reset colors"

 - default to red/green for old/new lines. That's the norm, I'd think.

 - instead of that eye-popping (and eye-ball-with-a-fondue-fork-popping) 
   purple color for metadata, use bold-face for file headers, and cyan for 
   the frag headers. I actually prefer the "gray background" for that, but 
   it only works well in xterms, so COLOR_CYAN it is..

Hmm?

		Linus
---
 diff.c |   99 +++++++++++++++++++++++++++++++++++++---------------------------
 1 files changed, 58 insertions(+), 41 deletions(-)

diff --git a/diff.c b/diff.c
index 22b643c..07e9d56 100644
--- a/diff.c
+++ b/diff.c
@@ -26,17 +26,41 @@ int git_diff_config(const char *var, con
 }
 
 enum color_diff {
-	DIFF_PLAIN = 0,
-	DIFF_METAINFO = 1,
-	DIFF_FILE_OLD = 2,
-	DIFF_FILE_NEW = 3,
+	DIFF_RESET = 0,
+	DIFF_PLAIN = 1,
+	DIFF_METAINFO = 2,
+	DIFF_FRAGINFO = 3,
+	DIFF_FILE_OLD = 4,
+	DIFF_FILE_NEW = 5,
 };
 
+#define COLOR_NORMAL  ""
+#define COLOR_BOLD    "\033[1m"
+#define COLOR_DIM     "\033[2m"
+#define COLOR_UL      "\033[4m"
+#define COLOR_BLINK   "\033[5m"
+#define COLOR_REVERSE "\033[7m"
+#define COLOR_RESET   "\033[m"
+
+#define COLOR_BLACK   "\033[30m"
+#define COLOR_RED     "\033[31m"
+#define COLOR_GREEN   "\033[32m"
+#define COLOR_YELLOW  "\033[33m"
+#define COLOR_BLUE    "\033[34m"
+#define COLOR_MAGENTA "\033[35m"
+#define COLOR_CYAN    "\033[36m"
+#define COLOR_WHITE   "\033[37m"
+
+#define COLOR_CYANBG  "\033[46m"
+#define COLOR_GRAYBG  "\033[47m"	// Good for xterm
+
 static const char *diff_colors[] = {
-	"\033[0;0m",
-	"\033[1;35m",
-	"\033[1;31m",
-	"\033[1;34m",
+	[DIFF_RESET]    = COLOR_RESET,
+	[DIFF_PLAIN]    = COLOR_NORMAL,
+	[DIFF_METAINFO] = COLOR_BOLD,
+	[DIFF_FRAGINFO] = COLOR_CYAN,
+	[DIFF_FILE_OLD] = COLOR_RED,
+	[DIFF_FILE_NEW] = COLOR_GREEN,
 };
 
 static char *quote_one(const char *str)
@@ -196,22 +220,23 @@ struct emit_callback {
 	const char **label_path;
 };
 
-static inline void color_diff(int diff_use_color, enum color_diff ix)
+static inline const char *get_color(int diff_use_color, enum color_diff ix)
 {
 	if (diff_use_color)
-		fputs(diff_colors[ix], stdout);
+		return diff_colors[ix];
+	return "";
 }
 
 static void fn_out_consume(void *priv, char *line, unsigned long len)
 {
 	int i;
 	struct emit_callback *ecbdata = priv;
+	const char *set = get_color(ecbdata->color_diff, DIFF_METAINFO);
+	const char *reset = get_color(ecbdata->color_diff, DIFF_RESET);	
 
 	if (ecbdata->label_path[0]) {
-		color_diff(ecbdata->color_diff, DIFF_METAINFO);
-		printf("--- %s\n", ecbdata->label_path[0]);
-		color_diff(ecbdata->color_diff, DIFF_METAINFO);
-		printf("+++ %s\n", ecbdata->label_path[1]);
+		printf("%s--- %s%s\n", set, ecbdata->label_path[0], reset);
+		printf("%s+++ %s%s\n", set, ecbdata->label_path[1], reset);
 		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
 	}
 
@@ -222,10 +247,10 @@ static void fn_out_consume(void *priv, c
 		;
 	if (2 <= i && i < len && line[i] == ' ') {
 		ecbdata->nparents = i - 1;
-		color_diff(ecbdata->color_diff, DIFF_METAINFO);
+		set = get_color(ecbdata->color_diff, DIFF_FRAGINFO);
 	}
 	else if (len < ecbdata->nparents)
-		color_diff(ecbdata->color_diff, DIFF_PLAIN);
+		set = reset;
 	else {
 		int nparents = ecbdata->nparents;
 		int color = DIFF_PLAIN;
@@ -235,10 +260,11 @@ static void fn_out_consume(void *priv, c
 			else if (line[i] == '+')
 				color = DIFF_FILE_NEW;
 		}
-		color_diff(ecbdata->color_diff, color);
+		set = get_color(ecbdata->color_diff, color);
 	}
-	fwrite(line, len, 1, stdout);
-	color_diff(ecbdata->color_diff, DIFF_PLAIN);
+	if (len > 0 && line[len-1] == '\n')
+		len--;
+	printf("%s%.*s%s\n", set, (int) len, line, reset);
 }
 
 static char *pprint_rename(const char *a, const char *b)
@@ -589,40 +615,32 @@ static void builtin_diff(const char *nam
 	mmfile_t mf1, mf2;
 	const char *lbl[2];
 	char *a_one, *b_two;
+	const char *set = get_color(o->color_diff, DIFF_METAINFO);
+	const char *reset = get_color(o->color_diff, DIFF_PLAIN);
 
 	a_one = quote_two("a/", name_a);
 	b_two = quote_two("b/", name_b);
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
-	color_diff(o->color_diff, DIFF_METAINFO);
-	printf("diff --git %s %s\n", a_one, b_two);
+	printf("%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
 	if (lbl[0][0] == '/') {
 		/* /dev/null */
-		color_diff(o->color_diff, DIFF_METAINFO);
-		printf("new file mode %06o\n", two->mode);
-		if (xfrm_msg && xfrm_msg[0]) {
-			color_diff(o->color_diff, DIFF_METAINFO);
-			puts(xfrm_msg);
-		}
+		printf("%snew file mode %06o%s\n", set, two->mode, reset);
+		if (xfrm_msg && xfrm_msg[0])
+			printf("%s%s%s\n", set, xfrm_msg, reset);
 	}
 	else if (lbl[1][0] == '/') {
-		printf("deleted file mode %06o\n", one->mode);
-		if (xfrm_msg && xfrm_msg[0]) {
-			color_diff(o->color_diff, DIFF_METAINFO);
-			puts(xfrm_msg);
-		}
+		printf("%sdeleted file mode %06o%s\n", set, one->mode, reset);
+		if (xfrm_msg && xfrm_msg[0])
+			printf("%s%s%s\n", set, xfrm_msg, reset);
 	}
 	else {
 		if (one->mode != two->mode) {
-			color_diff(o->color_diff, DIFF_METAINFO);
-			printf("old mode %06o\n", one->mode);
-			color_diff(o->color_diff, DIFF_METAINFO);
-			printf("new mode %06o\n", two->mode);
-		}
-		if (xfrm_msg && xfrm_msg[0]) {
-			color_diff(o->color_diff, DIFF_METAINFO);
-			puts(xfrm_msg);
+			printf("%sold mode %06o%s\n", set, one->mode, reset);
+			printf("%snew mode %06o%s\n", set, two->mode, reset);
 		}
+		if (xfrm_msg && xfrm_msg[0])
+			printf("%s%s%s\n", set, xfrm_msg, reset);
 		/*
 		 * we do not run diff between different kind
 		 * of objects.
@@ -630,7 +648,6 @@ static void builtin_diff(const char *nam
 		if ((one->mode ^ two->mode) & S_IFMT)
 			goto free_ab_and_return;
 		if (complete_rewrite) {
-			color_diff(o->color_diff, DIFF_PLAIN);
 			emit_rewrite_diff(name_a, name_b, one, two);
 			goto free_ab_and_return;
 		}
