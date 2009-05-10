From: Josh Micich <josh.micich@gmail.com>
Subject: Re: questions about git-mktree - [PATCH] proposed '--batch' option
Date: Sun, 10 May 2009 18:54:25 +0000 (UTC)
Message-ID: <loom.20090510T184606-644@post.gmane.org>
References: <2cfc40320905100641v3e8742c4v1d0e1091a730970b@mail.gmail.com> <7v63g829pg.fsf@alter.siamese.dyndns.org> <7vvdo8zxwp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 21:02:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3EIH-0000p7-Eu
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 21:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbZEJTAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 15:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbZEJTAH
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 15:00:07 -0400
Received: from main.gmane.org ([80.91.229.2]:42614 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062AbZEJTAF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 15:00:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1M3EFn-0004H1-7j
	for git@vger.kernel.org; Sun, 10 May 2009 19:00:03 +0000
Received: from 148.sub-75-211-195.myvzw.com ([75.211.195.148])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 May 2009 19:00:03 +0000
Received: from josh.micich by 148.sub-75-211-195.myvzw.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 May 2009 19:00:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 75.211.195.148 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.65 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118740>

Junio C Hamano <gitster <at> pobox.com> writes:
> 
> I'm fixing it.  You _might_ get your recursive mktree as a side effect at
> the end of the series, but no promises 

Is it possible add a '--batch' option to git-mktree? Here is a change I made 
locally which seems to work.  Hopefully it's not too hard to incorporate with 
your other changes.
-josh

 Documentation/git-mktree.txt |   14 +++++-
 mktree.c                     |   98 +++++++++++++++++++++++++----------------
diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index af19f06..1aa24b5 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -8,18 +8,25 @@ git-mktree - Build a tree-object from ls-tree formatted text
 
 SYNOPSIS
 --------
-'git mktree' [-z]
+'git mktree' [-z] [--batch]
 
 DESCRIPTION
 -----------
 Reads standard input in non-recursive `ls-tree` output format,
-and creates a tree object.  The object name of the tree object
-built is written to the standard output.
+and creates a tree object.  The order of the tree entries is 
+normalised by mktree so pre-sorting the input is not required.
+The object name of the tree object built is written to the
+standard output.
 
 OPTIONS
 -------
 -z::
 	Read the NUL-terminated `ls-tree -z` output instead.
+--batch::
+	Allow building of more than one tree object before exiting.
+	Each tree is separated by as single blank line. The final
+	new-line is optional.  Note - if the '-z' option is used,
+	lines are terminated with NUL.
 
 Author
 ------
diff --git a/mktree.c b/mktree.c
index 137a095..2743aaa 100644
--- a/mktree.c
+++ b/mktree.c
@@ -62,7 +62,7 @@ static void write_tree(unsigned char *sha1)
 	write_sha1_file(buf.buf, buf.len, tree_type, sha1);
 }
 
-static const char mktree_usage[] = "git mktree [-z]";
+static const char mktree_usage[] = "git mktree [-z] [--batch]";
 
 int main(int ac, char **av)
 {
@@ -70,6 +70,7 @@ int main(int ac, char **av)
 	struct strbuf p_uq = STRBUF_INIT;
 	unsigned char sha1[20];
 	int line_termination = '\n';
+	int is_batch_mode = 0;
 
 	git_extract_argv0_path(av[0]);
 
@@ -79,53 +80,74 @@ int main(int ac, char **av)
 		char *arg = av[1];
 		if (!strcmp("-z", arg))
 			line_termination = 0;
+		else if (!strcmp("--batch", arg))
+			is_batch_mode = 1;
 		else
 			usage(mktree_usage);
 		ac--;
 		av++;
 	}
 
-	while (strbuf_getline(&sb, stdin, line_termination) != EOF) {
-		char *ptr, *ntr;
-		unsigned mode;
-		enum object_type type;
-		char *path;
-
-		ptr = sb.buf;
-		/* Input is non-recursive ls-tree output format
-		 * mode SP type SP sha1 TAB name
-		 */
-		mode = strtoul(ptr, &ntr, 8);
-		if (ptr == ntr || !ntr || *ntr != ' ')
-			die("input format error: %s", sb.buf);
-		ptr = ntr + 1; /* type */
-		ntr = strchr(ptr, ' ');
-		if (!ntr || sb.buf + sb.len <= ntr + 40 ||
-		    ntr[41] != '\t' ||
-		    get_sha1_hex(ntr + 1, sha1))
-			die("input format error: %s", sb.buf);
-		type = sha1_object_info(sha1, NULL);
-		if (type < 0)
-			die("object %s unavailable", sha1_to_hex(sha1));
-		*ntr++ = 0; /* now at the beginning of SHA1 */
-		if (type != type_from_string(ptr))
-			die("object type %s mismatch (%s)", ptr, 
typename(type));
-
-		path = ntr + 41;  /* at the beginning of name */
-		if (line_termination && path[0] == '"') {
-			strbuf_reset(&p_uq);
-			if (unquote_c_style(&p_uq, path, NULL)) {
-				die("invalid quoting");
+	int got_eof = 0;
+	while (!got_eof) {
+		while (1) {
+			if (strbuf_getline(&sb, stdin, line_termination) == 
EOF) {
+				got_eof = 1;
+				break;
+			}
+			if (sb.buf[0] == '\0') {
+				// empty lines denote tree boundaries in batch 
mode
+				if (is_batch_mode) {
+					break;
+				}
+				die("input format error: (blank line only valid 
in batch mode)");
+			}
+			char *ptr, *ntr;
+			unsigned mode;
+			enum object_type type;
+			char *path;
+	
+			ptr = sb.buf;
+			/* Input is non-recursive ls-tree output format
+			 * mode SP type SP sha1 TAB name
+			 */
+			mode = strtoul(ptr, &ntr, 8);
+			if (ptr == ntr || !ntr || *ntr != ' ')
+				die("input format error: %s", sb.buf);
+			ptr = ntr + 1; /* type */
+			ntr = strchr(ptr, ' ');
+			if (!ntr || sb.buf + sb.len <= ntr + 40 ||
+				ntr[41] != '\t' ||
+				get_sha1_hex(ntr + 1, sha1))
+				die("input format error: %s", sb.buf);
+			type = sha1_object_info(sha1, NULL);
+			if (type < 0)
+				die("object %s unavailable", 
sha1_to_hex(sha1));
+			*ntr++ = 0; /* now at the beginning of SHA1 */
+			if (type != type_from_string(ptr))
+				die("object type %s mismatch (%s)", ptr, 
typename(type));
+
+			path = ntr + 41;  /* at the beginning of name */
+			if (line_termination && path[0] == '"') {
+				strbuf_reset(&p_uq);
+				if (unquote_c_style(&p_uq, path, NULL)) {
+					die("invalid quoting");
+				}
+				path = p_uq.buf;
 			}
-			path = p_uq.buf;
-		}
 
-		append_to_tree(mode, sha1, path);
+			append_to_tree(mode, sha1, path);
+		}
+		if (is_batch_mode && got_eof && used < 1) {
+			// allow input to finish with a new-line (or not)
+		} else {
+			write_tree(sha1);
+			puts(sha1_to_hex(sha1));
+			fflush(stdout);
+		}
+		used=0; // reset tree entry buffer for re-use in batch mode
 	}
 	strbuf_release(&p_uq);
 	strbuf_release(&sb);
-
-	write_tree(sha1);
-	puts(sha1_to_hex(sha1));
 	exit(0);
 }
