From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH 1/2] Function stripspace now gets a buffer instead file descriptors.
Date: Wed, 11 Jul 2007 20:50:34 +0200
Message-ID: <4695267A.7080202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 20:50:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8hH5-0008Bq-KS
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 20:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756977AbXGKSuw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 14:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756262AbXGKSuw
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 14:50:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:32649 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756039AbXGKSuu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 14:50:50 -0400
Received: by ug-out-1314.google.com with SMTP id j3so178388ugf
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 11:50:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=sa4a8YB2/dOpQbGqGw5wGz+DgUSgIVW8t9AQBTQf/HE7yCpXFs1naG/m0AFLPLtYckJA/xUZnAROH1rqAiRpo32Zb9tmccXWFZi7EWpxRQDz4Uc55W1jukXShFpV/93JZOTOAZxbTuUFg2XHa6sdslpOTmv8m5wpdwe+HuWukJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=ldbH9pfI/gej+uyOeU42ATtqv2cZXItj990v1kb58dv2S6Nwj+2f24/66I02qfp0qUNgswDwUqiCPfyKYORv8CkmsoS7xq6Es7yQUBHDnPVQlMaHglzaU6H8hSQEzRhTGyzm+P2trtdNpg/FYgjrDTE1oz7q1Va6PQCkeCYRNTA=
Received: by 10.67.100.10 with SMTP id c10mr637436ugm.1184179849113;
        Wed, 11 Jul 2007 11:50:49 -0700 (PDT)
Received: from ?192.168.0.194? ( [212.145.102.186])
        by mx.google.com with ESMTPS id 5sm439053ugc.2007.07.11.11.50.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Jul 2007 11:50:45 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52187>

An implementation easier to call from builtins. It is designed
to be used from the upcoming builtin-tag.c and builtin-commit.c,
because both need to remove unwanted spaces from messages.

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---

  This new implementation is a response to some Junio's comments
  on the version of builtin-tag.c which Kristian released:
  http://article.gmane.org/gmane.comp.version-control.git/49601

  The aim on not making this function internal yet
  is to be able to test it easily using the extensive
  test suite designed for git-stripspace. Later,
  this function could be in the file named "editor.c",
  along with the "launch_editor" function called when the
  program asks the user for a message not given from
  command-line.

 builtin-stripspace.c |   61 ++++++++++++++++++++++++++++++-------------------
 builtin.h            |    2 +-
 2 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/builtin-stripspace.c b/builtin-stripspace.c
index d8358e2..949b640 100644
--- a/builtin-stripspace.c
+++ b/builtin-stripspace.c
@@ -2,12 +2,11 @@
 #include "cache.h"

 /*
- * Remove trailing spaces from a line.
+ * Returns the length of a line removing trailing spaces.
  *
  * If the line ends with newline, it will be removed too.
- * Returns the new length of the string.
  */
-static int cleanup(char *line, int len)
+static size_t cleanup(char *line, size_t len)
 {
 	if (len) {
 		if (line[len - 1] == '\n')
@@ -19,7 +18,6 @@ static int cleanup(char *line, int len)
 				break;
 			len--;
 		}
-		line[len] = 0;
 	}
 	return len;
 }
@@ -28,52 +26,67 @@ static int cleanup(char *line, int len)
  * Remove empty lines from the beginning and end
  * and also trailing spaces from every line.
  *
+ * Note that the buffer will not be null-terminated.
+ *
  * Turn multiple consecutive empty lines between paragraphs
  * into just one empty line.
  *
  * If the input has only empty lines and spaces,
  * no output will be produced.
  *
+ * If last line has a newline at the end, it will be removed.
+ *
  * Enable skip_comments to skip every line starting with "#".
  */
-void stripspace(FILE *in, FILE *out, int skip_comments)
+size_t stripspace(char *buffer, size_t length, int skip_comments)
 {
 	int empties = -1;
-	int alloc = 1024;
-	char *line = xmalloc(alloc);
+	size_t i, j, len, newlen;
+	char *eol;

-	while (fgets(line, alloc, in)) {
-		int len = strlen(line);
+	for (i = j = 0; i < length; i += len, j += newlen) {
+		eol = memchr(buffer + i, '\n', length - i);
+		len = eol ? eol - (buffer + i) + 1 : length - i;

-		while (len == alloc - 1 && line[len - 1] != '\n') {
-			alloc = alloc_nr(alloc);
-			line = xrealloc(line, alloc);
-			fgets(line + len, alloc - len, in);
-			len += strlen(line + len);
-		}
-
-		if (skip_comments && line[0] == '#')
+		if (skip_comments && len && buffer[i] == '#') {
+			newlen = 0;
 			continue;
-		len = cleanup(line, len);
+		}
+		newlen = cleanup(buffer + i, len);

 		/* Not just an empty line? */
-		if (len) {
+		if (newlen) {
+			if (empties != -1)
+				buffer[j++] = '\n';
 			if (empties > 0)
-				fputc('\n', out);
+				buffer[j++] = '\n';
 			empties = 0;
-			fputs(line, out);
-			fputc('\n', out);
+			memmove(buffer + j, buffer + i, newlen);
 			continue;
 		}
 		if (empties < 0)
 			continue;
 		empties++;
 	}
-	free(line);
+
+	return j;
 }

 int cmd_stripspace(int argc, const char **argv, const char *prefix)
 {
-	stripspace(stdin, stdout, 0);
+	char *buffer;
+	unsigned long size;
+
+	size = 1024;
+	buffer = xmalloc(size);
+	if (read_pipe(0, &buffer, &size))
+		die("could not read the input");
+
+	size = stripspace(buffer, size, 0);
+	write_or_die(1, buffer, size);
+	if (size)
+		putc('\n', stdout);
+
+	free(buffer);
 	return 0;
 }
diff --git a/builtin.h b/builtin.h
index 661a92f..4cc228d 100644
--- a/builtin.h
+++ b/builtin.h
@@ -7,7 +7,7 @@ extern const char git_version_string[];
 extern const char git_usage_string[];

 extern void help_unknown_cmd(const char *cmd);
-extern void stripspace(FILE *in, FILE *out, int skip_comments);
+extern size_t stripspace(char *buffer, size_t length, int skip_comments);
 extern int write_tree(unsigned char *sha1, int missing_ok, const char *prefix);
 extern void prune_packed_objects(int);

-- 
1.5.0
