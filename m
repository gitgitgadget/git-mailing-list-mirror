From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] builtin-apply: rename "whitespace" variables and fix styles
Date: Fri, 23 Nov 2007 20:24:52 -0800
Message-ID: <7v8x4os223.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 05:25:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvmZz-0007Tm-BN
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 05:25:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbXKXEZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 23:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbXKXEY7
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 23:24:59 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:41711 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbXKXEY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 23:24:58 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id CA25A2F2;
	Fri, 23 Nov 2007 23:25:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 26285992BF;
	Fri, 23 Nov 2007 23:25:15 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65936>

The variables were somewhat misnamed.

 * "What to do when whitespace errors are detected" is now called
   "ws_error_action" (used to be called "new_whitespace");

 * The constants to denote the possible actions are "nowarn_ws_error",
   "warn_on_ws_error", "die_on_ws_error", and "correct_ws_error".  The
   last one used to be "strip_whitespace", but we correct whitespace
   error in indent (SP followed by HT) and "strip" is not quite an
   accurate name for it.

Other than the renaming of variables and constants, there is no
functional change in this patch.  While we are at it, it also fixes
overly long lines and multi-line comment styles (which of course do
not affect the generated code at all).

Ah, by the way, this introduces a synonym "fix" that is equivalent to
"strip" that you can give to --whitespace=<what-to-do>, so in that sense
it is not exactly "no functional change whatsoever".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is on top of jc/spht topic that is in 'next'.  The next one is
   the real thing.

 builtin-apply.c |  148 ++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 91 insertions(+), 57 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 8411b38..eb09bfe 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -47,12 +47,12 @@ static unsigned long p_context = ULONG_MAX;
 static const char apply_usage[] =
 "git-apply [--stat] [--numstat] [--summary] [--check] [--index] [--cached] [--apply] [--no-add] [--index-info] [--allow-binary-replacement] [--reverse] [--reject] [--verbose] [-z] [-pNUM] [-CNUM] [--whitespace=<nowarn|warn|error|error-all|strip>] <patch>...";
 
-static enum whitespace_eol {
-	nowarn_whitespace,
-	warn_on_whitespace,
-	error_on_whitespace,
-	strip_whitespace,
-} new_whitespace = warn_on_whitespace;
+static enum ws_error_action {
+	nowarn_ws_error,
+	warn_on_ws_error,
+	die_on_ws_error,
+	correct_ws_error,
+} ws_error_action = warn_on_ws_error;
 static int whitespace_error;
 static int squelch_whitespace_errors = 5;
 static int applied_after_fixing_ws;
@@ -61,28 +61,28 @@ static const char *patch_input_file;
 static void parse_whitespace_option(const char *option)
 {
 	if (!option) {
-		new_whitespace = warn_on_whitespace;
+		ws_error_action = warn_on_ws_error;
 		return;
 	}
 	if (!strcmp(option, "warn")) {
-		new_whitespace = warn_on_whitespace;
+		ws_error_action = warn_on_ws_error;
 		return;
 	}
 	if (!strcmp(option, "nowarn")) {
-		new_whitespace = nowarn_whitespace;
+		ws_error_action = nowarn_ws_error;
 		return;
 	}
 	if (!strcmp(option, "error")) {
-		new_whitespace = error_on_whitespace;
+		ws_error_action = die_on_ws_error;
 		return;
 	}
 	if (!strcmp(option, "error-all")) {
-		new_whitespace = error_on_whitespace;
+		ws_error_action = die_on_ws_error;
 		squelch_whitespace_errors = 0;
 		return;
 	}
-	if (!strcmp(option, "strip")) {
-		new_whitespace = strip_whitespace;
+	if (!strcmp(option, "strip") || !strcmp(option, "fix")) {
+		ws_error_action = correct_ws_error;
 		return;
 	}
 	die("unrecognized whitespace option '%s'", option);
@@ -90,11 +90,8 @@ static void parse_whitespace_option(const char *option)
 
 static void set_default_whitespace_mode(const char *whitespace_option)
 {
-	if (!whitespace_option && !apply_default_whitespace) {
-		new_whitespace = (apply
-				  ? warn_on_whitespace
-				  : nowarn_whitespace);
-	}
+	if (!whitespace_option && !apply_default_whitespace)
+		ws_error_action = (apply ? warn_on_ws_error : nowarn_ws_error);
 }
 
 /*
@@ -137,6 +134,11 @@ struct fragment {
 #define BINARY_DELTA_DEFLATED	1
 #define BINARY_LITERAL_DEFLATED 2
 
+/*
+ * This represents a "patch" to a file, both metainfo changes
+ * such as creation/deletion, filemode and content changes represented
+ * as a series of fragments.
+ */
 struct patch {
 	char *new_name, *old_name, *def_name;
 	unsigned int old_mode, new_mode;
@@ -158,7 +160,8 @@ struct patch {
 	struct patch *next;
 };
 
-static void say_patch_name(FILE *output, const char *pre, struct patch *patch, const char *post)
+static void say_patch_name(FILE *output, const char *pre,
+			   struct patch *patch, const char *post)
 {
 	fputs(pre, output);
 	if (patch->old_name && patch->new_name &&
@@ -229,7 +232,8 @@ static char *find_name(const char *line, char *def, int p_value, int terminate)
 	if (*line == '"') {
 		struct strbuf name;
 
-		/* Proposed "new-style" GNU patch/diff format; see
+		/*
+		 * Proposed "new-style" GNU patch/diff format; see
 		 * http://marc.theaimsgroup.com/?l=git&m=112927316408690&w=2
 		 */
 		strbuf_init(&name, 0);
@@ -499,7 +503,8 @@ static int gitdiff_dissimilarity(const char *line, struct patch *patch)
 
 static int gitdiff_index(const char *line, struct patch *patch)
 {
-	/* index line is N hexadecimal, "..", N hexadecimal,
+	/*
+	 * index line is N hexadecimal, "..", N hexadecimal,
 	 * and optional space with octal mode.
 	 */
 	const char *ptr, *eol;
@@ -550,7 +555,8 @@ static const char *stop_at_slash(const char *line, int llen)
 	return NULL;
 }
 
-/* This is to extract the same name that appears on "diff --git"
+/*
+ * This is to extract the same name that appears on "diff --git"
  * line.  We do not find and return anything if it is a rename
  * patch, and it is OK because we will find the name elsewhere.
  * We need to reliably find name only when it is mode-change only,
@@ -584,7 +590,8 @@ static char *git_header_name(char *line, int llen)
 			goto free_and_fail1;
 		strbuf_remove(&first, 0, cp + 1 - first.buf);
 
-		/* second points at one past closing dq of name.
+		/*
+		 * second points at one past closing dq of name.
 		 * find the second name.
 		 */
 		while ((second < line + llen) && isspace(*second))
@@ -627,7 +634,8 @@ static char *git_header_name(char *line, int llen)
 		return NULL;
 	name++;
 
-	/* since the first name is unquoted, a dq if exists must be
+	/*
+	 * since the first name is unquoted, a dq if exists must be
 	 * the beginning of the second name.
 	 */
 	for (second = name; second < line + llen; second++) {
@@ -759,7 +767,7 @@ static int parse_num(const char *line, unsigned long *p)
 }
 
 static int parse_range(const char *line, int len, int offset, const char *expect,
-			unsigned long *p1, unsigned long *p2)
+		       unsigned long *p1, unsigned long *p2)
 {
 	int digits, ex;
 
@@ -868,14 +876,14 @@ static int find_header(char *line, unsigned long size, int *hdrsize, struct patc
 			return offset;
 		}
 
-		/** --- followed by +++ ? */
+		/* --- followed by +++ ? */
 		if (memcmp("--- ", line,  4) || memcmp("+++ ", line + len, 4))
 			continue;
 
 		/*
 		 * We only accept unified patches, so we want it to
 		 * at least have "@@ -a,b +c,d @@\n", which is 14 chars
-		 * minimum
+		 * minimum ("@@ -0,0 +1 @@\n" is the shortest).
 		 */
 		nextlen = linelen(line + len, size - len);
 		if (size < nextlen + 14 || memcmp("@@ -", line + len + nextlen, 4))
@@ -932,14 +940,14 @@ static void check_whitespace(const char *line, int len)
 			err, patch_input_file, linenr, len-2, line+1);
 }
 
-
 /*
  * Parse a unified diff. Note that this really needs to parse each
  * fragment separately, since the only way to know the difference
  * between a "---" that is part of a patch, and a "---" that starts
  * the next patch is to look at the line counts..
  */
-static int parse_fragment(char *line, unsigned long size, struct patch *patch, struct fragment *fragment)
+static int parse_fragment(char *line, unsigned long size,
+			  struct patch *patch, struct fragment *fragment)
 {
 	int added, deleted;
 	int len = linelen(line, size), offset;
@@ -980,7 +988,7 @@ static int parse_fragment(char *line, unsigned long size, struct patch *patch, s
 			break;
 		case '-':
 			if (apply_in_reverse &&
-					new_whitespace != nowarn_whitespace)
+			    ws_error_action != nowarn_ws_error)
 				check_whitespace(line, len);
 			deleted++;
 			oldlines--;
@@ -988,14 +996,15 @@ static int parse_fragment(char *line, unsigned long size, struct patch *patch, s
 			break;
 		case '+':
 			if (!apply_in_reverse &&
-					new_whitespace != nowarn_whitespace)
+			    ws_error_action != nowarn_ws_error)
 				check_whitespace(line, len);
 			added++;
 			newlines--;
 			trailing = 0;
 			break;
 
-                /* We allow "\ No newline at end of file". Depending
+		/*
+		 * We allow "\ No newline at end of file". Depending
                  * on locale settings when the patch was produced we
                  * don't know what this line looks like. The only
                  * thing we do know is that it begins with "\ ".
@@ -1013,7 +1022,8 @@ static int parse_fragment(char *line, unsigned long size, struct patch *patch, s
 	fragment->leading = leading;
 	fragment->trailing = trailing;
 
-	/* If a fragment ends with an incomplete line, we failed to include
+	/*
+	 * If a fragment ends with an incomplete line, we failed to include
 	 * it in the above loop because we hit oldlines == newlines == 0
 	 * before seeing it.
 	 */
@@ -1141,7 +1151,8 @@ static struct fragment *parse_binary_hunk(char **buf_p,
 					  int *status_p,
 					  int *used_p)
 {
-	/* Expect a line that begins with binary patch method ("literal"
+	/*
+	 * Expect a line that begins with binary patch method ("literal"
 	 * or "delta"), followed by the length of data before deflating.
 	 * a sequence of 'length-byte' followed by base-85 encoded data
 	 * should follow, terminated by a newline.
@@ -1190,7 +1201,8 @@ static struct fragment *parse_binary_hunk(char **buf_p,
 			size--;
 			break;
 		}
-		/* Minimum line is "A00000\n" which is 7-byte long,
+		/*
+		 * Minimum line is "A00000\n" which is 7-byte long,
 		 * and the line length must be multiple of 5 plus 2.
 		 */
 		if ((llen < 7) || (llen-2) % 5)
@@ -1241,7 +1253,8 @@ static struct fragment *parse_binary_hunk(char **buf_p,
 
 static int parse_binary(char *buffer, unsigned long size, struct patch *patch)
 {
-	/* We have read "GIT binary patch\n"; what follows is a line
+	/*
+	 * We have read "GIT binary patch\n"; what follows is a line
 	 * that says the patch method (currently, either "literal" or
 	 * "delta") and the length of data before deflating; a
 	 * sequence of 'length-byte' followed by base-85 encoded data
@@ -1271,7 +1284,8 @@ static int parse_binary(char *buffer, unsigned long size, struct patch *patch)
 	if (reverse)
 		used += used_1;
 	else if (status) {
-		/* not having reverse hunk is not an error, but having
+		/*
+		 * Not having reverse hunk is not an error, but having
 		 * a corrupt reverse hunk is.
 		 */
 		free((void*) forward->patch);
@@ -1292,7 +1306,8 @@ static int parse_chunk(char *buffer, unsigned long size, struct patch *patch)
 	if (offset < 0)
 		return offset;
 
-	patchsize = parse_single_patch(buffer + offset + hdrsize, size - offset - hdrsize, patch);
+	patchsize = parse_single_patch(buffer + offset + hdrsize,
+				       size - offset - hdrsize, patch);
 
 	if (!patchsize) {
 		static const char *binhdr[] = {
@@ -1368,8 +1383,10 @@ static void reverse_patches(struct patch *p)
 	}
 }
 
-static const char pluses[] = "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++";
-static const char minuses[]= "----------------------------------------------------------------------";
+static const char pluses[] =
+"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++";
+static const char minuses[]=
+"----------------------------------------------------------------------";
 
 static void show_stats(struct patch *patch)
 {
@@ -1438,7 +1455,9 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 	}
 }
 
-static int find_offset(const char *buf, unsigned long size, const char *fragment, unsigned long fragsize, int line, int *lines)
+static int find_offset(const char *buf, unsigned long size,
+		       const char *fragment, unsigned long fragsize,
+		       int line, int *lines)
 {
 	int i;
 	unsigned long start, backwards, forwards;
@@ -1539,7 +1558,8 @@ static void remove_last_line(const char **rbuf, int *rsize)
 
 static int apply_line(char *output, const char *patch, int plen)
 {
-	/* plen is number of bytes to be copied from patch,
+	/*
+	 * plen is number of bytes to be copied from patch,
 	 * starting at patch+1 (patch[0] is '+').  Typically
 	 * patch[plen] is '\n', unless this is the incomplete
 	 * last line.
@@ -1552,12 +1572,15 @@ static int apply_line(char *output, const char *patch, int plen)
 	int need_fix_leading_space = 0;
 	char *buf;
 
-	if ((new_whitespace != strip_whitespace) || !whitespace_error ||
+	if ((ws_error_action != correct_ws_error) || !whitespace_error ||
 	    *patch != '+') {
 		memcpy(output, patch + 1, plen);
 		return plen;
 	}
 
+	/*
+	 * Strip trailing whitespace
+	 */
 	if (1 < plen && isspace(patch[plen-1])) {
 		if (patch[plen] == '\n')
 			add_nl_to_tail = 1;
@@ -1567,6 +1590,9 @@ static int apply_line(char *output, const char *patch, int plen)
 		fixed = 1;
 	}
 
+	/*
+	 * Check leading whitespaces (indent)
+	 */
 	for (i = 1; i < plen; i++) {
 		char ch = patch[i];
 		if (ch == '\t') {
@@ -1583,7 +1609,8 @@ static int apply_line(char *output, const char *patch, int plen)
 	buf = output;
 	if (need_fix_leading_space) {
 		int consecutive_spaces = 0;
-		/* between patch[1..last_tab_in_indent] strip the
+		/*
+		 * between patch[1..last_tab_in_indent] strip the
 		 * funny spaces, updating them to tab as needed.
 		 */
 		for (i = 1; i < last_tab_in_indent; i++, plen--) {
@@ -1613,7 +1640,8 @@ static int apply_line(char *output, const char *patch, int plen)
 	return output + plen - buf;
 }
 
-static int apply_one_fragment(struct strbuf *buf, struct fragment *frag, int inaccurate_eof)
+static int apply_one_fragment(struct strbuf *buf, struct fragment *frag,
+			      int inaccurate_eof)
 {
 	int match_beginning, match_end;
 	const char *patch = frag->patch;
@@ -1695,8 +1723,9 @@ static int apply_one_fragment(struct strbuf *buf, struct fragment *frag, int ina
 		size -= len;
 	}
 
-	if (inaccurate_eof && oldsize > 0 && old[oldsize - 1] == '\n' &&
-			newsize > 0 && new[newsize - 1] == '\n') {
+	if (inaccurate_eof &&
+	    oldsize > 0 && old[oldsize - 1] == '\n' &&
+	    newsize > 0 && new[newsize - 1] == '\n') {
 		oldsize--;
 		newsize--;
 	}
@@ -1733,7 +1762,7 @@ static int apply_one_fragment(struct strbuf *buf, struct fragment *frag, int ina
 		if (match_beginning && offset)
 			offset = -1;
 		if (offset >= 0) {
-			if (new_whitespace == strip_whitespace &&
+			if (ws_error_action == correct_ws_error &&
 			    (buf->len - oldsize - offset == 0)) /* end of file? */
 				newsize -= new_blank_lines_at_end;
 
@@ -1758,9 +1787,10 @@ static int apply_one_fragment(struct strbuf *buf, struct fragment *frag, int ina
 			match_beginning = match_end = 0;
 			continue;
 		}
-		/* Reduce the number of context lines
-		 * Reduce both leading and trailing if they are equal
-		 * otherwise just reduce the larger context.
+		/*
+		 * Reduce the number of context lines; reduce both
+		 * leading and trailing if they are equal otherwise
+		 * just reduce the larger context.
 		 */
 		if (leading >= trailing) {
 			remove_first_line(&oldlines, &oldsize);
@@ -1820,7 +1850,8 @@ static int apply_binary(struct strbuf *buf, struct patch *patch)
 	const char *name = patch->old_name ? patch->old_name : patch->new_name;
 	unsigned char sha1[20];
 
-	/* For safety, we require patch index line to contain
+	/*
+	 * For safety, we require patch index line to contain
 	 * full 40-byte textual SHA1 for old and new, at least for now.
 	 */
 	if (strlen(patch->old_sha1_prefix) != 40 ||
@@ -1831,7 +1862,8 @@ static int apply_binary(struct strbuf *buf, struct patch *patch)
 			     "without full index line", name);
 
 	if (patch->old_name) {
-		/* See if the old one matches what the patch
+		/*
+		 * See if the old one matches what the patch
 		 * applies to.
 		 */
 		hash_sha1_file(buf->buf, buf->len, blob_type, sha1);
@@ -1868,7 +1900,8 @@ static int apply_binary(struct strbuf *buf, struct patch *patch)
 		/* XXX read_sha1_file NUL-terminates */
 		strbuf_attach(buf, result, size, size + 1);
 	} else {
-		/* We have verified buf matches the preimage;
+		/*
+		 * We have verified buf matches the preimage;
 		 * apply the patch data to it, which is stored
 		 * in the patch->fragments->{patch,size}.
 		 */
@@ -2067,7 +2100,8 @@ static int check_patch(struct patch *patch, struct patch *prev_patch)
 
 	if (new_name && prev_patch && 0 < prev_patch->is_delete &&
 	    !strcmp(prev_patch->old_name, new_name))
-		/* A type-change diff is always split into a patch to
+		/*
+		 * A type-change diff is always split into a patch to
 		 * delete old, immediately followed by a patch to
 		 * create new (see diff.c::run_diff()); in such a case
 		 * it is Ok that the entry to be deleted by the
@@ -2671,7 +2705,7 @@ static int apply_patch(int fd, const char *filename, int inaccurate_eof)
 		offset += nr;
 	}
 
-	if (whitespace_error && (new_whitespace == error_on_whitespace))
+	if (whitespace_error && (ws_error_action == die_on_ws_error))
 		apply = 0;
 
 	update_index = check_index && apply;
@@ -2866,7 +2900,7 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 				squelched,
 				squelched == 1 ? "" : "s");
 		}
-		if (new_whitespace == error_on_whitespace)
+		if (ws_error_action == die_on_ws_error)
 			die("%d line%s add%s whitespace errors.",
 			    whitespace_error,
 			    whitespace_error == 1 ? "" : "s",
-- 
1.5.3.6.1991.ge56ac
