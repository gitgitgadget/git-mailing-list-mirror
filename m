From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] Implement --fuzz= option for git-apply.
Date: Sun, 09 Apr 2006 20:41:44 -0600
Message-ID: <m1d5fqi23b.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 10 04:43:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSmMp-0008QG-8K
	for gcvg-git@gmane.org; Mon, 10 Apr 2006 04:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWDJCmz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 22:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWDJCmz
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 22:42:55 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17376 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750942AbWDJCmy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Apr 2006 22:42:54 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k3A2fjRK030426;
	Sun, 9 Apr 2006 20:41:45 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k3A2fiS7030425;
	Sun, 9 Apr 2006 20:41:44 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18574>


Currently to import the -mm tree I have to work around
git-apply by using patch.  Because some of Andrews
patches in quilt will only apply with fuzz.

Allow git-apply to handle fuzz makes it much easier to import
the -mm tree into git.  I am still only processing about 1.5 patch a
second which for the 692 patches in 2.6.17-rc1-mm2 is still painful
but it does help.

If I just apply the patches and don't run git-mailinfo
git-write-tree, and git-write-commit I get about 4 patches
per second.

This patch defaults to leaving fuzz processing off so if you don't
want patches that only apply with fuzz you won't get them.

If a patch does require fuzz to apply you will get a warning:
> Fragment applied at offset: +-#lines (fuzz: #context_lines_deleted)

diff --git a/apply.c b/apply.c
index 33b4271..a07503f 100644
--- a/apply.c
+++ b/apply.c
@@ -32,8 +32,9 @@ static int apply = 1;
 static int no_add = 0;
 static int show_index_info = 0;
 static int line_termination = '\n';
+static int p_fuzz = 0;
 static const char apply_usage[] =
-"git-apply [--stat] [--numstat] [--summary] [--check] [--index] [--apply] [--no-add] [--index-info] [--allow-binary-replacement] [-z] [-pNUM] [--whitespace=<nowarn|warn|error|error-all|strip>] <patch>...";
+"git-apply [--stat] [--numstat] [--summary] [--check] [--index] [--apply] [--no-add] [--index-info] [--allow-binary-replacement] [-z] [-pNUM] [--fuzz=NUM] [--whitespace=<nowarn|warn|error|error-all|strip>] <patch>...";
 
 static enum whitespace_eol {
 	nowarn_whitespace,
@@ -100,6 +101,7 @@ static int max_change, max_len;
 static int linenr = 1;
 
 struct fragment {
+	unsigned long context;
 	unsigned long oldpos, oldlines;
 	unsigned long newpos, newlines;
 	const char *patch;
@@ -817,12 +819,15 @@ static int parse_fragment(char *line, un
 	int added, deleted;
 	int len = linelen(line, size), offset;
 	unsigned long oldlines, newlines;
+	unsigned long leading, trailing;
 
 	offset = parse_fragment_header(line, len, fragment);
 	if (offset < 0)
 		return -1;
 	oldlines = fragment->oldlines;
 	newlines = fragment->newlines;
+	leading = 0;
+	trailing = 0;
 
 	if (patch->is_new < 0) {
 		patch->is_new =  !oldlines;
@@ -860,10 +865,14 @@ static int parse_fragment(char *line, un
 		case ' ':
 			oldlines--;
 			newlines--;
+			if (!deleted && !added)
+				leading++;
+			trailing++;
 			break;
 		case '-':
 			deleted++;
 			oldlines--;
+			trailing = 0;
 			break;
 		case '+':
 			/*
@@ -887,6 +896,7 @@ static int parse_fragment(char *line, un
 			}
 			added++;
 			newlines--;
+			trailing = 0;
 			break;
 
                 /* We allow "\ No newline at end of file". Depending
@@ -904,6 +914,10 @@ static int parse_fragment(char *line, un
 	}
 	if (oldlines || newlines)
 		return -1;
+	fragment->context = leading;
+	if (leading > trailing)
+		fragment->context = trailing;
+
 	/* If a fragment ends with an incomplete line, we failed to include
 	 * it in the above loop because we hit oldlines == newlines == 0
 	 * before seeing it.
@@ -1087,7 +1101,7 @@ static int read_old_data(struct stat *st
 	}
 }
 
-static int find_offset(const char *buf, unsigned long size, const char *fragment, unsigned long fragsize, int line)
+static int find_offset(const char *buf, unsigned long size, const char *fragment, unsigned long fragsize, int line, int *lines)
 {
 	int i;
 	unsigned long start, backwards, forwards;
@@ -1148,6 +1162,7 @@ static int find_offset(const char *buf, 
 		n = (i >> 1)+1;
 		if (i & 1)
 			n = -n;
+		*lines = n;
 		return try;
 	}
 
@@ -1155,6 +1170,31 @@ static int find_offset(const char *buf, 
 	 * We should start searching forward and backward.
 	 */
 	return -1;
+}
+
+static void reduce_context(char **buf, int *size)
+{
+	char *ctx = *buf;
+	unsigned long ctxsize = *size;
+	unsigned long offset;
+
+	/* Remove the first line */
+	offset = 0;
+	while (offset <= ctxsize) {
+		if (ctx[offset++] == '\n')
+			break;
+	}
+	ctxsize -= offset;
+	ctx += offset;
+	/* Remove the last line */
+	offset = ctxsize - 1;
+	while (offset > 0) {
+		if (ctx[--offset] == '\n')
+			break;
+	}
+	ctxsize = offset + 1;
+	*buf = ctx;
+	*size = ctxsize;
 }
 
 struct buffer_desc {
@@ -1192,7 +1232,10 @@ static int apply_one_fragment(struct buf
 	int offset, size = frag->size;
 	char *old = xmalloc(size);
 	char *new = xmalloc(size);
-	int oldsize = 0, newsize = 0;
+	char *ctx;
+	int oldsize = 0, newsize = 0, ctxsize;
+	int lines;
+	int fuzz, max_fuzz;
 
 	while (size > 0) {
 		int len = linelen(patch, size);
@@ -1241,23 +1284,39 @@ #ifdef NO_ACCURATE_DIFF
 		newsize--;
 	}
 #endif
+
+	offset = -1; /* shutup gcc */
+	ctx = old;
+	ctxsize = oldsize;
+	lines = 0;
+	max_fuzz = (p_fuzz < frag->context) ? p_fuzz : frag->context;
+	for (fuzz = 0; fuzz <= max_fuzz; fuzz++) {
+		/* Reduce the number of context lines */
+		if (fuzz) 
+			reduce_context(&ctx, &ctxsize);
+		offset = find_offset(buf, desc->size, ctx, ctxsize, frag->newpos + fuzz, &lines);
+		if (offset >= 0) {
+			int diff = newsize - ctxsize;
+			unsigned long size = desc->size + diff;
+			unsigned long alloc = desc->alloc;
+
+			if (fuzz)
+				fprintf(stderr, "Fragment applied at offset: %d (fuzz: %d)\n",
+					lines, fuzz);
+
+			if (size > alloc) {
+				alloc = size + 8192;
+				desc->alloc = alloc;
+				buf = xrealloc(buf, alloc);
+				desc->buffer = buf;
+			}
+			desc->size = size;
+			memmove(buf + offset + newsize, buf + offset + ctxsize, size - offset - newsize);
+			memcpy(buf + offset, new, newsize);
+			offset = 0;
 			
-	offset = find_offset(buf, desc->size, old, oldsize, frag->newpos);
-	if (offset >= 0) {
-		int diff = newsize - oldsize;
-		unsigned long size = desc->size + diff;
-		unsigned long alloc = desc->alloc;
-
-		if (size > alloc) {
-			alloc = size + 8192;
-			desc->alloc = alloc;
-			buf = xrealloc(buf, alloc);
-			desc->buffer = buf;
+			break;
 		}
-		desc->size = size;
-		memmove(buf + offset + newsize, buf + offset + oldsize, size - offset - newsize);
-		memcpy(buf + offset, new, newsize);
-		offset = 0;
 	}
 
 	free(old);
@@ -1943,6 +2002,10 @@ int main(int argc, char **argv)
 		}
 		if (!strcmp(arg, "-z")) {
 			line_termination = 0;
+			continue;
+		}
+		if (!strncmp(arg, "--fuzz=", 7)) {
+			p_fuzz = atoi(arg + 7);
 			continue;
 		}
 		if (!strncmp(arg, "--whitespace=", 13)) {
