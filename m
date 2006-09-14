From: Linus Torvalds <torvalds@osdl.org>
Subject: Add "-h/-H" parsing to "git grep"
Date: Thu, 14 Sep 2006 10:45:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609141039380.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Sep 14 19:45:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNvH8-0004PU-JJ
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 19:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWINRpT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 13:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWINRpT
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 13:45:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62090 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750824AbWINRpS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Sep 2006 13:45:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8EHjDnW024602
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 14 Sep 2006 10:45:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8EHjCkp027655;
	Thu, 14 Sep 2006 10:45:13 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-0.511 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.148 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27021>


It turns out that I actually wanted to avoid the filenames (because I 
didn't care - I just wanted to see the context in which something was 
used) when doing a grep. But since "git grep" didn't take the "-h" 
parameter, I ended up having to do "grep -5 -h *.c" instead.

So here's a trivial patch that adds "-h" (and thus has to enable -H too) 
to "git grep" parsing.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

I just verified that it does the same thing as GNU grep with some of the 
combinations like "-l -h" and "-h -n", but I didn't bother digging any 
deeper. Regardless, it doesn't change any behaviour unless people start 
using "-h", and when they do, it's at least no worse than the old 
behaviour (which was to say "I can't do that, Dave" or something).

diff --git a/builtin-grep.c b/builtin-grep.c
index 6430f6d..ed87a55 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -138,6 +138,7 @@ #define GREP_BINARY_TEXT	2
 	unsigned binary:2;
 	unsigned extended:1;
 	unsigned relative:1;
+	unsigned pathname:1;
 	int regflags;
 	unsigned pre_context;
 	unsigned post_context;
@@ -316,7 +317,8 @@ static int word_char(char ch)
 static void show_line(struct grep_opt *opt, const char *bol, const char *eol,
 		      const char *name, unsigned lno, char sign)
 {
-	printf("%s%c", name, sign);
+	if (opt->pathname)
+		printf("%s%c", name, sign);
 	if (opt->linenum)
 		printf("%d%c", lno, sign);
 	printf("%.*s\n", (int)(eol-bol), bol);
@@ -691,6 +693,8 @@ static int external_grep(struct grep_opt
 		push_arg("-F");
 	if (opt->linenum)
 		push_arg("-n");
+	if (!opt->pathname)
+		push_arg("-h");
 	if (opt->regflags & REG_EXTENDED)
 		push_arg("-E");
 	if (opt->regflags & REG_ICASE)
@@ -911,6 +915,7 @@ int cmd_grep(int argc, const char **argv
 	memset(&opt, 0, sizeof(opt));
 	opt.prefix_length = (prefix && *prefix) ? strlen(prefix) : 0;
 	opt.relative = 1;
+	opt.pathname = 1;
 	opt.pattern_tail = &opt.pattern_list;
 	opt.regflags = REG_NEWLINE;
 
@@ -970,10 +975,12 @@ int cmd_grep(int argc, const char **argv
 			opt.linenum = 1;
 			continue;
 		}
+		if (!strcmp("-h", arg)) {
+			opt.pathname = 0;
+			continue;
+		}
 		if (!strcmp("-H", arg)) {
-			/* We always show the pathname, so this
-			 * is a noop.
-			 */
+			opt.pathname = 1;
 			continue;
 		}
 		if (!strcmp("-l", arg) ||
