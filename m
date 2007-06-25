From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH 2/2] Fix git-stripspace to process correctly long lines and
 spaces.
Date: Mon, 25 Jun 2007 21:28:01 +0200
Message-ID: <46801741.5080906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Johannes.Schindelin@gmx.de, krh@redhat.com
X-From: git-owner@vger.kernel.org Mon Jun 25 21:28:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2uEP-000459-Fb
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 21:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971AbXFYT2M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 15:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752885AbXFYT2M
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 15:28:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:14640 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbXFYT2L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 15:28:11 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1359620ugf
        for <git@vger.kernel.org>; Mon, 25 Jun 2007 12:28:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=uGvqUdwXayfc2gV16KidC9fR7zVKx6DoSzEpfq4zeTsfKZnxv5Dm51HkeOJvqbB917nJMtJyKk0mzv6L5VcABBgwtESLFFtrb7rnX4Xt1C8J3CQXELijqRd7qEvV7Ji8Jhwy9Ma0suwon3vYaiyZa7kQpfEXpEyHb7DGSzsEMfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=jewG0vBND2bQQbp1NCSAUz0MY5nHO2Vvs1k1EKah+79Nj4CDgKo6fAFtk+B4fTws6QgrzjhAJmGf4NPjqyX6XXBuMV05eOoY/23WQMEnFply6XkUsRfvsoXwoKLQYaXb9QnFjrS7vt7Hx7T1wfz4WZLw9dHMLeyF2vSECuwHHgI=
Received: by 10.67.102.12 with SMTP id e12mr5336222ugm.1182799689836;
        Mon, 25 Jun 2007 12:28:09 -0700 (PDT)
Received: from ?192.168.0.192? ( [212.145.102.186])
        by mx.google.com with ESMTP id s7sm2962434uge.2007.06.25.12.28.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Jun 2007 12:28:09 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50915>

Now the implementation gets more memory to store completely
each line before removing trailing spaces, and does it right
when the last line of the file ends with spaces and no newline
at the end.

Function stripspace needs again to be non-static in order to call
it from "builtin-tag.c" and the upcoming "builtin-commit.c".
A new parameter skip_comments was also added to the stripspace
function to optionally strips every shell #comment from the input,
needed for doing this task on those programs.

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---
 builtin-stripspace.c |   69 ++++++++++++++++++++++++++++++++-----------------
 builtin.h            |    1 +
 2 files changed, 46 insertions(+), 24 deletions(-)

diff --git a/builtin-stripspace.c b/builtin-stripspace.c
index 62bd4b5..d8358e2 100644
--- a/builtin-stripspace.c
+++ b/builtin-stripspace.c
@@ -1,58 +1,79 @@
 #include "builtin.h"
+#include "cache.h"

 /*
- * Remove empty lines from the beginning and end.
+ * Remove trailing spaces from a line.
  *
- * Turn multiple consecutive empty lines into just one
- * empty line.  Return true if it is an incomplete line.
+ * If the line ends with newline, it will be removed too.
+ * Returns the new length of the string.
  */
-static int cleanup(char *line)
+static int cleanup(char *line, int len)
 {
-	int len = strlen(line);
+	if (len) {
+		if (line[len - 1] == '\n')
+			len--;

-	if (len && line[len-1] == '\n') {
-		if (len == 1)
-			return 0;
-		do {
-			unsigned char c = line[len-2];
+		while (len) {
+			unsigned char c = line[len - 1];
 			if (!isspace(c))
 				break;
-			line[len-2] = '\n';
 			len--;
-			line[len] = 0;
-		} while (len > 1);
-		return 0;
+		}
+		line[len] = 0;
 	}
-	return 1;
+	return len;
 }

-static void stripspace(FILE *in, FILE *out)
+/*
+ * Remove empty lines from the beginning and end
+ * and also trailing spaces from every line.
+ *
+ * Turn multiple consecutive empty lines between paragraphs
+ * into just one empty line.
+ *
+ * If the input has only empty lines and spaces,
+ * no output will be produced.
+ *
+ * Enable skip_comments to skip every line starting with "#".
+ */
+void stripspace(FILE *in, FILE *out, int skip_comments)
 {
 	int empties = -1;
-	int incomplete = 0;
-	char line[1024];
+	int alloc = 1024;
+	char *line = xmalloc(alloc);
+
+	while (fgets(line, alloc, in)) {
+		int len = strlen(line);

-	while (fgets(line, sizeof(line), in)) {
-		incomplete = cleanup(line);
+		while (len == alloc - 1 && line[len - 1] != '\n') {
+			alloc = alloc_nr(alloc);
+			line = xrealloc(line, alloc);
+			fgets(line + len, alloc - len, in);
+			len += strlen(line + len);
+		}
+
+		if (skip_comments && line[0] == '#')
+			continue;
+		len = cleanup(line, len);

 		/* Not just an empty line? */
-		if (line[0] != '\n') {
+		if (len) {
 			if (empties > 0)
 				fputc('\n', out);
 			empties = 0;
 			fputs(line, out);
+			fputc('\n', out);
 			continue;
 		}
 		if (empties < 0)
 			continue;
 		empties++;
 	}
-	if (incomplete)
-		fputc('\n', out);
+	free(line);
 }

 int cmd_stripspace(int argc, const char **argv, const char *prefix)
 {
-	stripspace(stdin, stdout);
+	stripspace(stdin, stdout, 0);
 	return 0;
 }
diff --git a/builtin.h b/builtin.h
index da4834c..661a92f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -7,6 +7,7 @@ extern const char git_version_string[];
 extern const char git_usage_string[];

 extern void help_unknown_cmd(const char *cmd);
+extern void stripspace(FILE *in, FILE *out, int skip_comments);
 extern int write_tree(unsigned char *sha1, int missing_ok, const char *prefix);
 extern void prune_packed_objects(int);

-- 
1.5.0
