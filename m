From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce Git.pm (v3)
Date: Sat, 24 Jun 2006 22:10:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606242207510.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v1wtghga6.fsf@assigned-by-dhcp.cox.net> <20060623011205.GJ21864@pasky.or.cz>
 <7vejxgckq9.fsf@assigned-by-dhcp.cox.net> <m1k678yt6m.fsf@ebiederm.dsl.xmission.com>
 <20060622220201.19132.67536.stgit@machine.or.cz> <7vlkrohj9p.fsf@assigned-by-dhcp.cox.net>
 <20060622235017.GH21864@pasky.or.cz> <7v1wtghga6.fsf@assigned-by-dhcp.cox.net>
 <20060623011205.GJ21864@pasky.or.cz> <7vejxgckq9.fsf@assigned-by-dhcp.cox.net>
 <20060623123904.GL21864@pasky.or.cz> <7vejxf74e3.fsf@assigned-by-dhcp.cox.net>
 <7vzmg35pkt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 22:10:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuESU-0004Qr-Ku
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 22:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWFXUKP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 16:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWFXUKP
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 16:10:15 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:46563 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751085AbWFXUKN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 16:10:13 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 1C5ADCA9;
	Sat, 24 Jun 2006 22:10:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 104D4BF1;
	Sat, 24 Jun 2006 22:10:12 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id D8A6DB31;
	Sat, 24 Jun 2006 22:10:11 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmg35pkt.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22543>

Hi,

On Fri, 23 Jun 2006, Junio C Hamano wrote:

> By the way, I noticed NO_ACCURATE_DIFF is a compile time option
> to cause git-apply to accept diff output from implementations
> that botch "\No newline at the end of file", and I think it is
> wrong -- it should be a run time option to git-apply if we would
> want to support it, because the version of diff you have does
> not have much to do with which implementations of diff were used
> to generate patches you would receive and apply.
> 
> Thoughts?

My original idea: on a machine where you have no accurate diff, you at 
least want to pass the tests, and you want to ensure you can apply a diff 
you generated on that machine.

But I was wrong. This patch is just compile tested, but obviously correct 
(lacking usage() and Documentation updates as usual, since I do not want 
to do that work before I know the patch is applied):

---
[PATCH] apply: add --no-accurate-diff and --accurate-diff options

You can still set the default behaviour in the Makefile, but at least you
can override it.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 builtin-apply.c |   32 +++++++++++++++++++++++---------
 1 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index e113c74..2d26ade 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -125,6 +125,7 @@ #define BINARY_LITERAL_DEFLATED 2
 	unsigned long deflate_origlen;
 	int lines_added, lines_deleted;
 	int score;
+	int no_accurate_diff:1;
 	struct fragment *fragments;
 	char *result;
 	unsigned long resultsize;
@@ -1333,7 +1334,8 @@ static int apply_line(char *output, cons
 	return plen;
 }
 
-static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag)
+static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag,
+	int no_accurate_diff)
 {
 	int match_beginning, match_end;
 	char *buf = desc->buffer;
@@ -1386,13 +1388,11 @@ static int apply_one_fragment(struct buf
 		size -= len;
 	}
 
-#ifdef NO_ACCURATE_DIFF
-	if (oldsize > 0 && old[oldsize - 1] == '\n' &&
+	if (no_accurate_diff && oldsize > 0 && old[oldsize - 1] == '\n' &&
 			newsize > 0 && new[newsize - 1] == '\n') {
 		oldsize--;
 		newsize--;
 	}
-#endif
 
 	oldlines = old;
 	newlines = new;
@@ -1614,7 +1614,7 @@ static int apply_fragments(struct buffer
 		return apply_binary(desc, patch);
 
 	while (frag) {
-		if (apply_one_fragment(desc, frag) < 0)
+		if (apply_one_fragment(desc, frag, patch->no_accurate_diff) < 0)
 			return error("patch failed: %s:%ld",
 				     name, frag->oldpos);
 		frag = frag->next;
@@ -2097,7 +2097,7 @@ static int use_patch(struct patch *p)
 	return 1;
 }
 
-static int apply_patch(int fd, const char *filename)
+static int apply_patch(int fd, const char *filename, int no_accurate_diff)
 {
 	unsigned long offset, size;
 	char *buffer = read_patch_file(fd, &size);
@@ -2113,6 +2113,7 @@ static int apply_patch(int fd, const cha
 		int nr;
 
 		patch = xcalloc(1, sizeof(*patch));
+		patch->no_accurate_diff = no_accurate_diff;
 		nr = parse_chunk(buffer + offset, size, patch);
 		if (nr < 0)
 			break;
@@ -2180,6 +2181,11 @@ int cmd_apply(int argc, const char **arg
 {
 	int i;
 	int read_stdin = 1;
+#ifdef NO_ACCURATE_DIFF
+	int no_accurate_diff = 1;
+#else
+	int no_accurate_diff = 0;
+#endif
 	const char *whitespace_option = NULL;
 
 	for (i = 1; i < argc; i++) {
@@ -2188,7 +2194,7 @@ int cmd_apply(int argc, const char **arg
 		int fd;
 
 		if (!strcmp(arg, "-")) {
-			apply_patch(0, "<stdin>");
+			apply_patch(0, "<stdin>", no_accurate_diff);
 			read_stdin = 0;
 			continue;
 		}
@@ -2265,6 +2271,14 @@ int cmd_apply(int argc, const char **arg
 			parse_whitespace_option(arg + 13);
 			continue;
 		}
+		if (!strcmp(arg, "--no-accurate-diff")) {
+			no_accurate_diff = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--accurate-diff")) {
+			no_accurate_diff = 0;
+			continue;
+		}
 
 		if (check_index && prefix_length < 0) {
 			prefix = setup_git_directory();
@@ -2281,12 +2295,12 @@ int cmd_apply(int argc, const char **arg
 			usage(apply_usage);
 		read_stdin = 0;
 		set_default_whitespace_mode(whitespace_option);
-		apply_patch(fd, arg);
+		apply_patch(fd, arg, no_accurate_diff);
 		close(fd);
 	}
 	set_default_whitespace_mode(whitespace_option);
 	if (read_stdin)
-		apply_patch(0, "<stdin>");
+		apply_patch(0, "<stdin>", no_accurate_diff);
 	if (whitespace_error) {
 		if (squelch_whitespace_errors &&
 		    squelch_whitespace_errors < whitespace_error) {
