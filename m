From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] apply --whitespace fixes and enhancements.
Date: Sun, 26 Feb 2006 18:14:51 -0800
Message-ID: <7v8xrx4kf8.fsf_-_@assigned-by-dhcp.cox.net>
References: <20060225174047.0e9a6d29.akpm@osdl.org>
	<7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>
	<20060225210712.29b30f59.akpm@osdl.org>
	<Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>
	<20060226103604.2d97696c.akpm@osdl.org>
	<Pine.LNX.4.64.0602261213340.22647@g5.osdl.org>
	<7vr75p4ojt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 03:15:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDXus-0000Oq-V8
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 03:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWB0COz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 21:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWB0COz
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 21:14:55 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:24762 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750712AbWB0COy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2006 21:14:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060227021122.LUYS17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 26 Feb 2006 21:11:22 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vr75p4ojt.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 26 Feb 2006 16:45:42 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16820>

In addition to fixing obvious command line parsing bugs in the
previous round, this changes the following:

 * Adds "--whitespace=strip".  This applies after stripping the
   new trailing whitespaces introduced to the patch.

 * The output error message format is changed to say
   "patch-filename:linenumber:contents of the line".  This makes
   it similar to typical compiler error message format, and
   helps C-x ` (next-error) in Emacs compilation buffer.

 * --whitespace=error and --whitespace=warn do not stop at the
   first error.  We might want to limit the output to say first
   20 such lines to prevent cluttering, but on the other hand if
   you are willing to hand-fix after inspecting them, getting
   everything with a single run might be easier to work with.
   After all, somebody has to do the clean-up work somewhere.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Junio C Hamano <junkio@cox.net> writes:

 > Regarding git-apply change, I suspect warn_on_whitespace should
 > not squelch itself after the first one, and error_on_whitespace
 > should not die instantly.  The sample pre-applypatch hook (it
 > was missing code to figure out where GIT_DIR was so it never
 > worked as shipped; corrected in "master") shows line numbers of
 > suspicious lines from the files being patched.  They can be
 > manually fixed up, and then "git am --resolved", if the
 > integrator is in a better mood.
 >
 > The error messages from pre-commit/pre-applypatch hook mimic the
 > way compiler errors are spit out, so that it works well in Emacs
 > compilation buffer -- doing C-x ` (next-error) takes you the
 > line the error appears and lets you edit it.

 apply.c |   77 ++++++++++++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 54 insertions(+), 23 deletions(-)

e0af70a72d4115c32a1f9b91f1cf4556bbd014b6
diff --git a/apply.c b/apply.c
index e7b3dca..7dbbeb4 100644
--- a/apply.c
+++ b/apply.c
@@ -37,8 +37,11 @@ static const char apply_usage[] =
 static enum whitespace_eol {
 	nowarn,
 	warn_on_whitespace,
-	error_on_whitespace
+	error_on_whitespace,
+	strip_and_apply,
 } new_whitespace = nowarn;
+static int whitespace_error = 0;
+static const char *patch_input_file = NULL;
 
 /*
  * For "diff-stat" like behaviour, we keep track of the biggest change
@@ -823,19 +826,17 @@ static int parse_fragment(char *line, un
 		case '+':
 			/*
 			 * We know len is at least two, since we have a '+' and
-			 * we checked that the last character was a '\n' above
+			 * we checked that the last character was a '\n' above.
+			 * That is, an addition of an empty line would check
+			 * the '+' here.  Sneaky...
 			 */
-			if (isspace(line[len-2])) {
-				switch (new_whitespace) {
-				case nowarn:
-					break;
-				case warn_on_whitespace:
-					new_whitespace = nowarn;	/* Just once */
-					error("Added whitespace at end of line at line %d", linenr);
-					break;
-				case error_on_whitespace:
-					die("Added whitespace at end of line at line %d", linenr);
-				}
+			if ((new_whitespace != nowarn) &&
+			    isspace(line[len-2])) {
+				fprintf(stderr, "Added whitespace\n");
+				fprintf(stderr, "%s:%d:%.*s\n",
+					patch_input_file,
+					linenr, len-2, line+1);
+				whitespace_error = 1;
 			}
 			added++;
 			newlines--;
@@ -1114,6 +1115,27 @@ struct buffer_desc {
 	unsigned long alloc;
 };
 
+static int apply_line(char *output, const char *patch, int plen)
+{
+	/* plen is number of bytes to be copied from patch,
+	 * starting at patch+1 (patch[0] is '+').  Typically
+	 * patch[plen] is '\n'.
+	 */
+	int add_nl_to_tail = 0;
+	if ((new_whitespace == strip_and_apply) &&
+	    1 < plen && isspace(patch[plen-1])) {
+		if (patch[plen] == '\n')
+			add_nl_to_tail = 1;
+		plen--;
+		while (0 < plen && isspace(patch[plen]))
+			plen--;
+	}
+	memcpy(output, patch + 1, plen);
+	if (add_nl_to_tail)
+		output[plen++] = '\n';
+	return plen;
+}
+
 static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag)
 {
 	char *buf = desc->buffer;
@@ -1149,10 +1171,9 @@ static int apply_one_fragment(struct buf
 				break;
 		/* Fall-through for ' ' */
 		case '+':
-			if (*patch != '+' || !no_add) {
-				memcpy(new + newsize, patch + 1, plen);
-				newsize += plen;
-			}
+			if (*patch != '+' || !no_add)
+				newsize += apply_line(new + newsize, patch,
+						      plen);
 			break;
 		case '@': case '\\':
 			/* Ignore it, we already handled it */
@@ -1721,7 +1742,7 @@ static int use_patch(struct patch *p)
 	return 1;
 }
 
-static int apply_patch(int fd)
+static int apply_patch(int fd, const char *filename)
 {
 	int newfd;
 	unsigned long offset, size;
@@ -1729,6 +1750,7 @@ static int apply_patch(int fd)
 	struct patch *list = NULL, **listp = &list;
 	int skipped_patch = 0;
 
+	patch_input_file = filename;
 	if (!buffer)
 		return -1;
 	offset = 0;
@@ -1755,6 +1777,9 @@ static int apply_patch(int fd)
 	}
 
 	newfd = -1;
+	if (whitespace_error && (new_whitespace == error_on_whitespace))
+		apply = 0;
+
 	write_index = check_index && apply;
 	if (write_index)
 		newfd = hold_index_file_for_update(&cache_file, get_index_file());
@@ -1801,7 +1826,7 @@ int main(int argc, char **argv)
 		int fd;
 
 		if (!strcmp(arg, "-")) {
-			apply_patch(0);
+			apply_patch(0, "<stdin>");
 			read_stdin = 0;
 			continue;
 		}
@@ -1862,14 +1887,18 @@ int main(int argc, char **argv)
 			continue;
 		}
 		if (!strncmp(arg, "--whitespace=", 13)) {
-			if (strcmp(arg+13, "warn")) {
+			if (!strcmp(arg+13, "warn")) {
 				new_whitespace = warn_on_whitespace;
 				continue;
 			}
-			if (strcmp(arg+13, "error")) {
+			if (!strcmp(arg+13, "error")) {
 				new_whitespace = error_on_whitespace;
 				continue;
 			}
+			if (!strcmp(arg+13, "strip")) {
+				new_whitespace = strip_and_apply;
+				continue;
+			}
 			die("unrecognixed whitespace option '%s'", arg+13);
 		}
 
@@ -1885,10 +1914,12 @@ int main(int argc, char **argv)
 		if (fd < 0)
 			usage(apply_usage);
 		read_stdin = 0;
-		apply_patch(fd);
+		apply_patch(fd, arg);
 		close(fd);
 	}
 	if (read_stdin)
-		apply_patch(0);
+		apply_patch(0, "<stdin>");
+	if (whitespace_error && new_whitespace == error_on_whitespace)
+		return 1;
 	return 0;
 }
-- 
1.2.3.gac5f
