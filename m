From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] Teach git-apply about '-R'
Date: Fri, 28 Jul 2006 17:46:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607281736550.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607261940090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <200607262039.25155.Josef.Weidendorfer@gmx.de> <20060728013038.GH13776@pasky.or.cz>
 <Pine.LNX.4.63.0607281213250.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0607280809550.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Jul 28 17:46:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6UXe-0008Aj-55
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 17:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161142AbWG1PqS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 11:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbWG1PqS
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 11:46:18 -0400
Received: from mail.gmx.de ([213.165.64.21]:39902 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161142AbWG1PqR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 11:46:17 -0400
Received: (qmail invoked by alias); 28 Jul 2006 15:46:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 28 Jul 2006 17:46:11 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607280809550.4168@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24393>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

On Fri, 28 Jul 2006, Linus Torvalds wrote:

> On Fri, 28 Jul 2006, Johannes Schindelin wrote:
> >
> > +/* a and b may not overlap! */
> > +static void memswap(void *a, void *b, unsigned int len)
> 
> This is disgusting.

Yes, it is. Sorry, was just meant for prototyping. I had in mind to 
replace it with temporary variables, but your solution seems way 
nicer.

 builtin-apply.c         |   65 ++++++++++++++++++++++++++++++++++++++++-------
 t/t4102-apply-rename.sh |   24 ++++++++++++++++-
 2 files changed, 77 insertions(+), 12 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index d924ac3..6b38a8a 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -120,7 +120,7 @@ struct fragment {
 struct patch {
 	char *new_name, *old_name, *def_name;
 	unsigned int old_mode, new_mode;
-	int is_rename, is_copy, is_new, is_delete, is_binary;
+	int is_rename, is_copy, is_new, is_delete, is_binary, is_reverse;
 #define BINARY_DELTA_DEFLATED 1
 #define BINARY_LITERAL_DEFLATED 2
 	unsigned long deflate_origlen;
@@ -1119,6 +1119,34 @@ static int parse_chunk(char *buffer, uns
 	return offset + hdrsize + patchsize;
 }
 
+#define swap(a,b) myswap((a),(b),sizeof(a))
+
+#define myswap(a, b, size) do {		\
+	unsigned char mytmp[size];	\
+	memcpy(mytmp, &a, size);		\
+	memcpy(&a, &b, size);		\
+	memcpy(&b, mytmp, size);		\
+} while (0)
+
+static void reverse_patches(struct patch *p)
+{
+	for (; p; p = p->next) {
+		struct fragment *frag = p->fragments;
+
+		swap(p->new_name, p->old_name);
+		swap(p->new_mode, p->old_mode);
+		swap(p->is_new, p->is_delete);
+		swap(p->lines_added, p->lines_deleted);
+		swap(p->old_sha1_prefix, p->new_sha1_prefix);
+
+		for (; frag; frag = frag->next) {
+			swap(frag->newpos, frag->oldpos);
+			swap(frag->newlines, frag->oldlines);
+		}
+		p->is_reverse = !p->is_reverse;
+	}
+}
+
 static const char pluses[] = "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++";
 static const char minuses[]= "----------------------------------------------------------------------";
 
@@ -1336,7 +1364,7 @@ static int apply_line(char *output, cons
 }
 
 static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag,
-	int inaccurate_eof)
+	int reverse, int inaccurate_eof)
 {
 	int match_beginning, match_end;
 	char *buf = desc->buffer;
@@ -1350,6 +1378,7 @@ static int apply_one_fragment(struct buf
 	int pos, lines;
 
 	while (size > 0) {
+		char first;
 		int len = linelen(patch, size);
 		int plen;
 
@@ -1366,16 +1395,23 @@ static int apply_one_fragment(struct buf
 		plen = len-1;
 		if (len < size && patch[len] == '\\')
 			plen--;
-		switch (*patch) {
+		first = *patch;
+		if (reverse) {
+			if (first == '-')
+				first = '+';
+			else if (first == '+')
+				first = '-';
+		}
+		switch (first) {
 		case ' ':
 		case '-':
 			memcpy(old + oldsize, patch + 1, plen);
 			oldsize += plen;
-			if (*patch == '-')
+			if (first == '-')
 				break;
 		/* Fall-through for ' ' */
 		case '+':
-			if (*patch != '+' || !no_add)
+			if (first != '+' || !no_add)
 				newsize += apply_line(new + newsize, patch,
 						      plen);
 			break;
@@ -1615,7 +1651,8 @@ static int apply_fragments(struct buffer
 		return apply_binary(desc, patch);
 
 	while (frag) {
-		if (apply_one_fragment(desc, frag, patch->inaccurate_eof) < 0)
+		if (apply_one_fragment(desc, frag, patch->is_reverse,
+					patch->inaccurate_eof) < 0)
 			return error("patch failed: %s:%ld",
 				     name, frag->oldpos);
 		frag = frag->next;
@@ -2142,7 +2179,8 @@ static int use_patch(struct patch *p)
 	return 1;
 }
 
-static int apply_patch(int fd, const char *filename, int inaccurate_eof)
+static int apply_patch(int fd, const char *filename,
+		int reverse, int inaccurate_eof)
 {
 	unsigned long offset, size;
 	char *buffer = read_patch_file(fd, &size);
@@ -2162,6 +2200,8 @@ static int apply_patch(int fd, const cha
 		nr = parse_chunk(buffer + offset, size, patch);
 		if (nr < 0)
 			break;
+		if (reverse)
+			reverse_patches(patch);
 		if (use_patch(patch)) {
 			patch_stats(patch);
 			*listp = patch;
@@ -2226,6 +2266,7 @@ int cmd_apply(int argc, const char **arg
 {
 	int i;
 	int read_stdin = 1;
+	int reverse = 0;
 	int inaccurate_eof = 0;
 
 	const char *whitespace_option = NULL;
@@ -2236,7 +2277,7 @@ int cmd_apply(int argc, const char **arg
 		int fd;
 
 		if (!strcmp(arg, "-")) {
-			apply_patch(0, "<stdin>", inaccurate_eof);
+			apply_patch(0, "<stdin>", reverse, inaccurate_eof);
 			read_stdin = 0;
 			continue;
 		}
@@ -2313,6 +2354,10 @@ int cmd_apply(int argc, const char **arg
 			parse_whitespace_option(arg + 13);
 			continue;
 		}
+		if (!strcmp(arg, "-R") || !strcmp(arg, "--reverse")) {
+			reverse = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--inaccurate-eof")) {
 			inaccurate_eof = 1;
 			continue;
@@ -2333,12 +2378,12 @@ int cmd_apply(int argc, const char **arg
 			usage(apply_usage);
 		read_stdin = 0;
 		set_default_whitespace_mode(whitespace_option);
-		apply_patch(fd, arg, inaccurate_eof);
+		apply_patch(fd, arg, reverse, inaccurate_eof);
 		close(fd);
 	}
 	set_default_whitespace_mode(whitespace_option);
 	if (read_stdin)
-		apply_patch(0, "<stdin>", inaccurate_eof);
+		apply_patch(0, "<stdin>", reverse, inaccurate_eof);
 	if (whitespace_error) {
 		if (squelch_whitespace_errors &&
 		    squelch_whitespace_errors < whitespace_error) {
diff --git a/t/t4102-apply-rename.sh b/t/t4102-apply-rename.sh
index fbb508d..22da6a0 100755
--- a/t/t4102-apply-rename.sh
+++ b/t/t4102-apply-rename.sh
@@ -13,8 +13,8 @@ # setup
 cat >test-patch <<\EOF
 diff --git a/foo b/bar
 similarity index 47%
-copy from foo
-copy to bar
+rename from foo
+rename to bar
 --- a/foo
 +++ b/bar
 @@ -1 +1 @@
@@ -39,4 +39,24 @@ else
 	    'test -f bar && ls -l bar | grep "^-..x......"'
 fi
 
+test_expect_success 'apply reverse' \
+    'git-apply -R --index --stat --summary --apply test-patch &&
+     test "$(cat foo)" = "This is foo"'
+
+cat >test-patch <<\EOF
+diff --git a/foo b/bar
+similarity index 47%
+copy from foo
+copy to bar
+--- a/foo
++++ b/bar
+@@ -1 +1 @@
+-This is foo
++This is bar
+EOF
+
+test_expect_success 'apply copy' \
+    'git-apply --index --stat --summary --apply test-patch &&
+     test "$(cat bar)" = "This is bar" -a "$(cat foo)" = "This is foo"'
+
 test_done
-- 
1.4.2.rc2.g8b063-dirty
