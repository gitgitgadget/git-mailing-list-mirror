From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Teach "git apply" to prepend a prefix with "--root=<root>"
Date: Tue, 1 Jul 2008 00:44:47 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807010043440.9925@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 01:47:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDT5u-0003Oa-25
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 01:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966AbYF3Xqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 19:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754073AbYF3Xql
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 19:46:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:40428 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751570AbYF3Xql (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 19:46:41 -0400
Received: (qmail invoked by alias); 30 Jun 2008 23:46:39 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp004) with SMTP; 01 Jul 2008 01:46:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX195SrtZCl95prV7HjXBq576TQyB7XILX9uD5xYwsQ
	YyJdrGXMDJ1yp8
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86971>


With "git apply --root=<root>", all file names in the patch are prepended
with <root>.  If a "-p" value was given, the paths are stripped _before_
prepending <root>.

Wished for by HPA.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Only lightly tested.

 Documentation/git-apply.txt |    6 +++++-
 builtin-apply.c             |   24 ++++++++++++++++++++++++
 t/t4128-apply-root.sh       |   32 ++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 1 deletions(-)
 create mode 100755 t/t4128-apply-root.sh

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index c5ee636..7c51830 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
 	  [-pNUM] [-CNUM] [--inaccurate-eof] [--recount] [--cached]
 	  [--whitespace=<nowarn|warn|fix|error|error-all>]
-	  [--exclude=PATH] [--verbose] [<patch>...]
+	  [--exclude=PATH] [--root=<root>] [--verbose] [<patch>...]
 
 DESCRIPTION
 -----------
@@ -182,6 +182,10 @@ behavior:
 	by inspecting the patch (e.g. after editing the patch without
 	adjusting the hunk headers appropriately).
 
+--root=<root>::
+	Prepend <root> to all filenames.  If a "-p" argument was passed, too,
+	it is applied before prepending the new root.
+
 Configuration
 -------------
 
diff --git a/builtin-apply.c b/builtin-apply.c
index 9fcfe39..d56d913 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -58,6 +58,8 @@ static int whitespace_error;
 static int squelch_whitespace_errors = 5;
 static int applied_after_fixing_ws;
 static const char *patch_input_file;
+static const char *root;
+static int root_len;
 
 static void parse_whitespace_option(const char *option)
 {
@@ -340,6 +342,8 @@ static char *find_name(const char *line, char *def, int p_value, int terminate)
 				 */
 				strbuf_remove(&name, 0, cp - name.buf);
 				free(def);
+				if (root)
+					strbuf_insert(&name, 0, root, root_len);
 				return strbuf_detach(&name, NULL);
 			}
 		}
@@ -378,6 +382,14 @@ static char *find_name(const char *line, char *def, int p_value, int terminate)
 		free(def);
 	}
 
+	if (root) {
+		char *ret = xmalloc(root_len + len + 1);
+		strcpy(ret, root);
+		memcpy(ret + root_len, start, len);
+		ret[root_len + len] = '\0';
+		return ret;
+	}
+
 	return xmemdupz(start, len);
 }
 
@@ -3240,6 +3252,18 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 			options |= RECOUNT;
 			continue;
 		}
+		if (!strncmp(arg, "--root=", strlen("--root="))) {
+			arg += strlen("--root=");
+			root_len = strlen(arg);
+			if (root_len && arg[root_len + 1] != '/') {
+				char *new_root;
+				root = new_root = xmalloc(root_len + 2);
+				strcpy(new_root, arg);
+				strcpy(new_root + root_len++, "/");
+			} else
+				root = arg;
+			continue;
+		}
 		if (0 < prefix_length)
 			arg = prefix_filename(prefix, prefix_length, arg);
 
diff --git a/t/t4128-apply-root.sh b/t/t4128-apply-root.sh
new file mode 100755
index 0000000..80b5af2
--- /dev/null
+++ b/t/t4128-apply-root.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description='apply same filename'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+
+	mkdir -p some/sub/dir &&
+	echo Hello > some/sub/dir/file &&
+	git add some/sub/dir/file
+
+'
+
+cat > patch << EOF
+diff a/bla/blub/dir/file b/bla/blub/dir/file
+--- a/bla/blub/dir/file
++++ b/bla/blub/dir/file
+@@ -1,1 +1,1 @@
+-Hello
++Bello
+EOF
+
+test_expect_success 'apply --root -p --index' '
+
+	git apply --root=some/sub -p3 --index patch &&
+	test Bello = $(git show :some/sub/dir/file) &&
+	test Bello = $(cat some/sub/dir/file)
+
+'
+
+test_done
-- 
1.5.6.1.297.g148d9
