From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v2 10/14] For each exclude pattern, store information about where it came from
Date: Thu, 20 Sep 2012 20:46:19 +0100
Message-ID: <1348170383-15751-11-git-send-email-git@adamspiers.org>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
 <1348170383-15751-1-git-send-email-git@adamspiers.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 21:47:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEmiJ-0000f4-5b
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 21:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918Ab2ITTqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 15:46:40 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:46197 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754870Ab2ITTqe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 15:46:34 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 2B34D2E5EC;
	Thu, 20 Sep 2012 20:46:33 +0100 (BST)
X-Mailer: git-send-email 1.7.12.147.g6d168f4
In-Reply-To: <1348170383-15751-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206082>

For exclude patterns read in from files, the filename is stored together
with the corresponding line number (counting starting at 1).

For exclude patterns provided on the command line, the sequence number
is negative, with counting starting at -1, so for example the 2nd
pattern provided via --exclude would be numbered -2.  This allows any
future consumers of that data to easily distinguish between exclude
patterns from files vs. from the CLI.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 builtin/clean.c    |  2 +-
 builtin/ls-files.c |  3 ++-
 dir.c              | 25 +++++++++++++++++++------
 dir.h              |  5 ++++-
 4 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 69c1cda..893dd7a 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -99,7 +99,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	for (i = 0; i < exclude_list.nr; i++)
 		add_exclude(exclude_list.items[i].string, "", 0,
-			    &dir.exclude_list[EXC_CMDL]);
+			    &dir.exclude_list[EXC_CMDL], "--exclude option", -(i+1));
 
 	pathspec = get_pathspec(prefix, argv);
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index d226456..64b1969 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -35,6 +35,7 @@ static int error_unmatch;
 static char *ps_matched;
 static const char *with_tree;
 static int exc_given;
+static int exclude_args;
 
 static const char *tag_cached = "";
 static const char *tag_unmerged = "";
@@ -423,7 +424,7 @@ static int option_parse_exclude(const struct option *opt,
 	struct exclude_list *list = opt->value;
 
 	exc_given = 1;
-	add_exclude(arg, "", 0, list);
+	add_exclude(arg, "", 0, list, "--exclude option", --exclude_args);
 
 	return 0;
 }
diff --git a/dir.c b/dir.c
index 904a7f3..705546f 100644
--- a/dir.c
+++ b/dir.c
@@ -311,7 +311,7 @@ static int no_wildcard(const char *string)
 }
 
 void add_exclude(const char *string, const char *base,
-		 int baselen, struct exclude_list *el)
+		 int baselen, struct exclude_list *el, const char *src, int srcpos)
 {
 	struct exclude *x;
 	size_t len;
@@ -341,6 +341,8 @@ void add_exclude(const char *string, const char *base,
 	x->base = base;
 	x->baselen = baselen;
 	x->flags = flags;
+	x->src = src;
+	x->srcpos = srcpos;
 	if (!strchr(string, '/'))
 		x->flags |= EXC_FLAG_NODIR;
 	x->nowildcardlen = simple_length(string);
@@ -393,7 +395,7 @@ int add_excludes_from_file_to_list(const char *fname,
 				   int check_index)
 {
 	struct stat st;
-	int fd, i;
+	int fd, i, lineno = 1;
 	size_t size = 0;
 	char *buf, *entry;
 
@@ -438,8 +440,9 @@ int add_excludes_from_file_to_list(const char *fname,
 		if (buf[i] == '\n') {
 			if (entry != buf + i && entry[0] != '#') {
 				buf[i - (i && buf[i-1] == '\r')] = 0;
-				add_exclude(entry, base, baselen, el);
+				add_exclude(entry, base, baselen, el, fname, lineno);
 			}
+			lineno++;
 			entry = buf + i + 1;
 		}
 	}
@@ -474,8 +477,10 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 		    !strncmp(dir->basebuf, base, stk->baselen))
 			break;
 		dir->exclude_stack = stk->prev;
-		while (stk->exclude_ix < el->nr)
-			free(el->excludes[--el->nr]);
+		while (stk->exclude_ix < el->nr) {
+			struct exclude *exclude = el->excludes[--el->nr];
+			free(exclude);
+		}
 		free(stk->filebuf);
 		free(stk);
 	}
@@ -502,7 +507,15 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 		memcpy(dir->basebuf + current, base + current,
 		       stk->baselen - current);
 		strcpy(dir->basebuf + stk->baselen, dir->exclude_per_dir);
-		add_excludes_from_file_to_list(dir->basebuf,
+
+		/* dir->basebuf gets reused by the traversal, but we
+		 * need fname to remain unchanged to ensure the src
+		 * member of each struct exclude correctly back-references
+		 * its source file.
+		 */
+		char *fname = strdup(dir->basebuf);
+
+		add_excludes_from_file_to_list(fname,
 					       dir->basebuf, stk->baselen,
 					       &stk->filebuf, el, 1);
 		dir->exclude_stack = stk;
diff --git a/dir.h b/dir.h
index 19beddb..ebb0367 100644
--- a/dir.h
+++ b/dir.h
@@ -31,6 +31,9 @@ struct exclude_list {
 		int baselen;
 		int to_exclude;
 		int flags;
+		const char *src;
+		int srcpos; /* counting starts from 1 for line numbers in ignore files,
+			       and from -1 decrementing for patterns from CLI (--exclude) */
 	} **excludes;
 };
 
@@ -123,7 +126,7 @@ extern int add_excludes_from_file_to_list(const char *fname, const char *base, i
 					  char **buf_p, struct exclude_list *el, int check_index);
 extern void add_excludes_from_file(struct dir_struct *, const char *fname);
 extern void add_exclude(const char *string, const char *base,
-			int baselen, struct exclude_list *el);
+			int baselen, struct exclude_list *el, const char *src, int srcpos);
 extern void free_excludes(struct exclude_list *el);
 extern int file_exists(const char *);
 
-- 
1.7.12.147.g6d168f4
