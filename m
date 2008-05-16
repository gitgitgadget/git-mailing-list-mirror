From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] mailsplit and mailinfo: gracefully handle NUL characters
Date: Fri, 16 May 2008 14:03:30 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805161403130.30431@racer>
References: <482BE5F7.2050108@thorn.ws> <alpine.DEB.1.00.0805161139530.30431@racer> <alpine.DEB.1.00.0805161148010.30431@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tommy Thorn <tommy-git@thorn.ws>
X-From: git-owner@vger.kernel.org Fri May 16 15:04:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwzbg-0004Iw-72
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 15:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496AbYEPND2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 09:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753305AbYEPND2
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 09:03:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:55266 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752496AbYEPND0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 09:03:26 -0400
Received: (qmail invoked by alias); 16 May 2008 13:03:24 -0000
Received: from R4f5c.r.pppool.de (EHLO racer.local) [89.54.79.92]
  by mail.gmx.net (mp054) with SMTP; 16 May 2008 15:03:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19csWt+q4lcmaaQjYD0vnpWK2g3cNfu145hRzXc7T
	4eXjWPfHVRAYgd
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0805161148010.30431@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82283>


The function fgets() has a big problem with NUL characters: it reads
them, but nobody will know if the NUL comes from the file stream, or
was appended at the end of the line.

So implement a custom read_line() function.

Noticed by Tommy Thorn.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Sorry for the binary patch: the file t5100/nul contains NUL
	characters, obviously.

	BTW I do not know how much fgetc() instead of fgets() slows
	down things, but I expect both to be equally fast because
	they are both buffered, right?

 builtin-mailinfo.c  |   24 +++++++++++++-----------
 builtin-mailsplit.c |   27 +++++++++++++++++++++++----
 builtin.h           |    1 +
 t/t5100-mailinfo.sh |    9 +++++++++
 t/t5100/nul         |  Bin 0 -> 91 bytes
 5 files changed, 46 insertions(+), 15 deletions(-)
 create mode 100644 t/t5100/nul

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 11f154b..f0c4209 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -641,7 +641,7 @@ static void decode_transfer_encoding(char *line, unsigned linesize)
 	}
 }
 
-static int handle_filter(char *line, unsigned linesize);
+static int handle_filter(char *line, unsigned linesize, int linelen);
 
 static int find_boundary(void)
 {
@@ -669,7 +669,7 @@ again:
 					"can't recover\n");
 			exit(1);
 		}
-		handle_filter(newline, sizeof(newline));
+		handle_filter(newline, sizeof(newline), strlen(newline));
 
 		/* skip to the next boundary */
 		if (!find_boundary())
@@ -759,14 +759,14 @@ static int handle_commit_msg(char *line, unsigned linesize)
 	return 0;
 }
 
-static int handle_patch(char *line)
+static int handle_patch(char *line, int len)
 {
-	fputs(line, patchfile);
+	fwrite(line, 1, len, patchfile);
 	patch_lines++;
 	return 0;
 }
 
-static int handle_filter(char *line, unsigned linesize)
+static int handle_filter(char *line, unsigned linesize, int linelen)
 {
 	static int filter = 0;
 
@@ -779,7 +779,7 @@ static int handle_filter(char *line, unsigned linesize)
 			break;
 		filter++;
 	case 1:
-		if (!handle_patch(line))
+		if (!handle_patch(line, linelen))
 			break;
 		filter++;
 	default:
@@ -794,6 +794,7 @@ static void handle_body(void)
 	int rc = 0;
 	static char newline[2000];
 	static char *np = newline;
+	int len = strlen(line);
 
 	/* Skip up to the first boundary */
 	if (content_top->boundary) {
@@ -807,7 +808,8 @@ static void handle_body(void)
 			/* flush any leftover */
 			if ((transfer_encoding == TE_BASE64)  &&
 			    (np != newline)) {
-				handle_filter(newline, sizeof(newline));
+				handle_filter(newline, sizeof(newline),
+						strlen(newline));
 			}
 			if (!handle_boundary())
 				return;
@@ -824,7 +826,7 @@ static void handle_body(void)
 
 			/* binary data most likely doesn't have newlines */
 			if (message_type != TYPE_TEXT) {
-				rc = handle_filter(line, sizeof(newline));
+				rc = handle_filter(line, sizeof(line), len);
 				break;
 			}
 
@@ -841,7 +843,7 @@ static void handle_body(void)
 					/* should be sitting on a new line */
 					*(++np) = 0;
 					op++;
-					rc = handle_filter(newline, sizeof(newline));
+					rc = handle_filter(newline, sizeof(newline), np - newline);
 					np = newline;
 				}
 			} while (*op != 0);
@@ -851,12 +853,12 @@ static void handle_body(void)
 			break;
 		}
 		default:
-			rc = handle_filter(line, sizeof(newline));
+			rc = handle_filter(line, sizeof(line), len);
 		}
 		if (rc)
 			/* nothing left to filter */
 			break;
-	} while (fgets(line, sizeof(line), fin));
+	} while ((len = read_line_with_nul(line, sizeof(line), fin)));
 
 	return;
 }
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index 46b27cd..021dc16 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -45,6 +45,25 @@ static int is_from_line(const char *line, int len)
 /* Could be as small as 64, enough to hold a Unix "From " line. */
 static char buf[4096];
 
+/* We cannot use fgets() because our lines can contain NULs */
+int read_line_with_nul(char *buf, int size, FILE *in)
+{
+	int len = 0, c;
+
+	for (;;) {
+		c = fgetc(in);
+		buf[len++] = c;
+		if (c == EOF || c == '\n' || len + 1 >= size)
+			break;
+	}
+
+	if (c == EOF)
+		len--;
+	buf[len] = '\0';
+
+	return len;
+}
+
 /* Called with the first line (potentially partial)
  * already in buf[] -- normally that should begin with
  * the Unix "From " line.  Write it into the specified
@@ -70,19 +89,19 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
 	 * "From " and having something that looks like a date format.
 	 */
 	for (;;) {
-		int is_partial = (buf[len-1] != '\n');
+		int is_partial = len && buf[len-1] != '\n';
 
-		if (fputs(buf, output) == EOF)
+		if (fwrite(buf, 1, len, output) != len)
 			die("cannot write output");
 
-		if (fgets(buf, sizeof(buf), mbox) == NULL) {
+		len = read_line_with_nul(buf, sizeof(buf), mbox);
+		if (len == 0) {
 			if (feof(mbox)) {
 				status = 1;
 				break;
 			}
 			die("cannot read mbox");
 		}
-		len = strlen(buf);
 		if (!is_partial && !is_bare && is_from_line(buf, len))
 			break; /* done with one message */
 	}
diff --git a/builtin.h b/builtin.h
index c630d5b..d0a0ead 100644
--- a/builtin.h
+++ b/builtin.h
@@ -9,6 +9,7 @@ extern const char git_usage_string[];
 extern void list_common_cmds_help(void);
 extern void help_unknown_cmd(const char *cmd);
 extern void prune_packed_objects(int);
+extern int read_line_with_nul(char *buf, int size, FILE *file);
 
 extern int cmd_add(int argc, const char **argv, const char *prefix);
 extern int cmd_annotate(int argc, const char **argv, const char *prefix);
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index d6c55c1..5a4610b 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -25,4 +25,13 @@ do
 		diff ../t5100/info$mail info$mail"
 done
 
+test_expect_success 'respect NULs' '
+
+	git mailsplit -d3 -o. ../t5100/nul &&
+	cmp ../t5100/nul 001 &&
+	(cat 001 | git mailinfo msg patch) &&
+	test 4 = $(wc -l < patch)
+
+'
+
 test_done
diff --git a/t/t5100/nul b/t/t5100/nul
new file mode 100644
index 0000000000000000000000000000000000000000..3d40691787b855cc0133514a19052492eb853d21
GIT binary patch
literal 91
zcmW;6y$ygM5C%|6a#MT@Tm%~v2e7kZ0t`Q)fHOej_C}MJcXX*}a!Gh_N`s3x>;_}@
mA68>55i?ULDS<hc3BM!}T;HU$lNvE*_bo@vIHuA{lcE=x<rtIz

literal 0
HcmV?d00001

-- 
1.5.5.1.425.g5f464.dirty
