From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] Implement limited context matching in git-apply.
Date: Mon, 10 Apr 2006 03:33:06 -0600
Message-ID: <m1irphhj1p.fsf_-_@ebiederm.dsl.xmission.com>
References: <m1d5fqi23b.fsf@ebiederm.dsl.xmission.com>
	<m13bgmht9v.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 10 11:34:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSsmo-0008Px-FU
	for gcvg-git@gmane.org; Mon, 10 Apr 2006 11:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWDJJeP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 05:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWDJJeO
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 05:34:14 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18404 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751090AbWDJJeO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Apr 2006 05:34:14 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k3A9X7Hb032599;
	Mon, 10 Apr 2006 03:33:07 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k3A9X7aw032598;
	Mon, 10 Apr 2006 03:33:07 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <m13bgmht9v.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
 message of "Sun, 09 Apr 2006 23:52:12 -0600")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18588>


Ok this really should be the good version.  The option
handling has been reworked to be automation safe.

Currently to import the -mm tree I have to work around
git-apply by using patch.  Because some of Andrews
patches in quilt will only apply with fuzz.

I started out implementing a --fuzz option and then I realized
fuzz is not a very safe concept for an automated system.  What
you really want is a minimum number of context lines that must
match.  This allows policy to be set without knowing how many
lines of context a patch actually provides.   By default
the policy remains to match all provided lines of context.

Allowng git-apply to match a restricted set of context makes
it much easier to import the -mm tree into git.  I am still only
processing  1.5 to 1.6 patches a second for the 692 patches in
2.6.17-rc1-mm2 is still painful but it does help.

If I just loop through all of Andrews patches in order
and run git-apply --index -C1 I process the entire patchset
in 1m53s or about 6 patches per second.  So running
git-mailinfo, git-write-tree, git-commit-tree, and
git-update-ref everytime has a measurable impact,
and shows things can be speeded up even more.

All of these timings were taking on my poor 700Mhz Athlon
with 512MB of ram.  So people with fast machiens should
see much better performance.

When a match is found after the number of context are reduced a
warning is generated.  Since this is a rare event and possibly
dangerous this seems to make sense.  Unless you are patching
a single file the error message is a little bit terse at
the moment, but it should be easy to go back and fix.

I have also updated the documentation for git-apply to reflect
the new -C option that sets the minimum number of context
lines that must match.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 Documentation/git-apply.txt |    8 ++-
 apply.c                     |  121 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 111 insertions(+), 18 deletions(-)

6b3a4565b760664a9b72096dd5eea8be9e1d1311
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 1c64a1a..e93ea1f 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git-apply' [--stat] [--numstat] [--summary] [--check] [--index] [--apply]
 	  [--no-add] [--index-info] [--allow-binary-replacement] [-z] [-pNUM]
-	  [--whitespace=<nowarn|warn|error|error-all|strip>]
+	  [-CNUM] [--whitespace=<nowarn|warn|error|error-all|strip>]
 	  [<patch>...]
 
 DESCRIPTION
@@ -72,6 +72,12 @@ OPTIONS
 -p<n>::
 	Remove <n> leading slashes from traditional diff paths. The
 	default is 1.
+
+-C<n>::
+	Ensure at least <n> lines of surrounding context match before
+	and after each change.  When fewer lines of surrounding
+	context exist they all most match.  By default no context is
+	ever ignored.
 
 --apply::
 	If you use any of the options marked ``Turns off
diff --git a/apply.c b/apply.c
index 33b4271..147a919 100644
--- a/apply.c
+++ b/apply.c
@@ -32,8 +32,9 @@ static int apply = 1;
 static int no_add = 0;
 static int show_index_info = 0;
 static int line_termination = '\n';
+static unsigned long p_context = -1;
 static const char apply_usage[] =
-"git-apply [--stat] [--numstat] [--summary] [--check] [--index] [--apply] [--no-add] [--index-info] [--allow-binary-replacement] [-z] [-pNUM] [--whitespace=<nowarn|warn|error|error-all|strip>] <patch>...";
+"git-apply [--stat] [--numstat] [--summary] [--check] [--index] [--apply] [--no-add] [--index-info] [--allow-binary-replacement] [-z] [-pNUM] [-CNUM] [--whitespace=<nowarn|warn|error|error-all|strip>] <patch>...";
 
 static enum whitespace_eol {
 	nowarn_whitespace,
@@ -100,6 +101,7 @@ static int max_change, max_len;
 static int linenr = 1;
 
 struct fragment {
+	unsigned long leading, trailing;
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
@@ -904,6 +914,9 @@ static int parse_fragment(char *line, un
 	}
 	if (oldlines || newlines)
 		return -1;
+	fragment->leading = leading;
+	fragment->trailing = trailing;
+
 	/* If a fragment ends with an incomplete line, we failed to include
 	 * it in the above loop because we hit oldlines == newlines == 0
 	 * before seeing it.
@@ -1087,7 +1100,7 @@ static int read_old_data(struct stat *st
 	}
 }
 
-static int find_offset(const char *buf, unsigned long size, const char *fragment, unsigned long fragsize, int line)
+static int find_offset(const char *buf, unsigned long size, const char *fragment, unsigned long fragsize, int line, int *lines)
 {
 	int i;
 	unsigned long start, backwards, forwards;
@@ -1148,6 +1161,7 @@ static int find_offset(const char *buf, 
 		n = (i >> 1)+1;
 		if (i & 1)
 			n = -n;
+		*lines = n;
 		return try;
 	}
 
@@ -1155,6 +1169,33 @@ static int find_offset(const char *buf, 
 	 * We should start searching forward and backward.
 	 */
 	return -1;
+}
+
+static void remove_first_line(const char **rbuf, int *rsize)
+{
+	const char *buf = *rbuf;
+	int size = *rsize;
+	unsigned long offset;
+	offset = 0;
+	while (offset <= size) {
+		if (buf[offset++] == '\n')
+			break;
+	}
+	*rsize = size - offset;
+	*rbuf = buf + offset;
+}
+
+static void remove_last_line(const char **rbuf, int *rsize)
+{
+	const char *buf = *rbuf;
+	int size = *rsize;
+	unsigned long offset;
+	offset = size - 1;
+	while (offset > 0) {
+		if (buf[--offset] == '\n')
+			break;
+	}
+	*rsize = offset + 1;
 }
 
 struct buffer_desc {
@@ -1192,7 +1233,10 @@ static int apply_one_fragment(struct buf
 	int offset, size = frag->size;
 	char *old = xmalloc(size);
 	char *new = xmalloc(size);
+	const char *oldlines, *newlines;
 	int oldsize = 0, newsize = 0;
+	unsigned long leading, trailing;
+	int pos, lines;
 
 	while (size > 0) {
 		int len = linelen(patch, size);
@@ -1241,23 +1285,59 @@ #ifdef NO_ACCURATE_DIFF
 		newsize--;
 	}
 #endif
+
+	oldlines = old;
+	newlines = new;
+	leading = frag->leading;
+	trailing = frag->trailing;
+	lines = 0;
+	pos = frag->newpos;
+	for (;;) {
+		offset = find_offset(buf, desc->size, oldlines, oldsize, pos, &lines);
+		if (offset >= 0) {
+			int diff = newsize - oldsize;
+			unsigned long size = desc->size + diff;
+			unsigned long alloc = desc->alloc;
+
+			/* Warn if it was necessary to reduce the number 
+			 * of context lines.
+			 */
+			if ((leading != frag->leading) || (trailing != frag->trailing))
+				fprintf(stderr, "Context reduced to (%ld/%ld) to apply fragment at %d\n",
+					leading, trailing, pos + lines);
+
+			if (size > alloc) {
+				alloc = size + 8192;
+				desc->alloc = alloc;
+				buf = xrealloc(buf, alloc);
+				desc->buffer = buf;
+			}
+			desc->size = size;
+			memmove(buf + offset + newsize, buf + offset + oldsize, size - offset - newsize);
+			memcpy(buf + offset, newlines, newsize);
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
+
+		/* Am I at my context limits? */
+		if ((leading <= p_context) && (trailing <= p_context))
+			break;
+		/* Reduce the number of context lines
+		 * Reduce both leading and trailing if they are equal
+		 * otherwise just reduce the larger context.
+		 */
+		if (leading >= trailing) {
+			remove_first_line(&oldlines, &oldsize);
+			remove_first_line(&newlines, &newsize);
+			pos--;
+			leading--;
+		}
+		if (trailing > leading) {
+			remove_last_line(&oldlines, &oldsize);
+			remove_last_line(&newlines, &newsize);
+			trailing--;
+		}
 	}
 
 	free(old);
@@ -1882,6 +1962,7 @@ int main(int argc, char **argv)
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
+		char *end;
 		int fd;
 
 		if (!strcmp(arg, "-")) {
@@ -1943,6 +2024,12 @@ int main(int argc, char **argv)
 		}
 		if (!strcmp(arg, "-z")) {
 			line_termination = 0;
+			continue;
+		}
+		if (!strncmp(arg, "-C", 2)) {
+			p_context = strtoul(arg + 2, &end, 0);
+			if (*end != '\0')
+				die("unrecognized context count '%s'", arg + 2);
 			continue;
 		}
 		if (!strncmp(arg, "--whitespace=", 13)) {
-- 
1.3-rc3.GIT
