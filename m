From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: [PATCH 1/4] config: disallow relative include paths from blobs
Date: Wed, 19 Feb 2014 00:58:52 +0200
Message-ID: <1392764335-13274-1-git-send-email-kirill@shutemov.name>
Cc: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
	"Kirill A. Shutemov" <kirill@shutemov.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 23:59:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFtdb-0007wD-DG
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 23:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079AbaBRW7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 17:59:19 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:43054 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753551AbaBRW7P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 17:59:15 -0500
Received: from node.shutemov.name (80.220.224.16) by jenni2.inet.fi (8.5.140.03)
        id 52775C9908E42625; Wed, 19 Feb 2014 00:59:11 +0200
Received: by node.shutemov.name (Postfix, from userid 1000)
	id EA3D541203; Wed, 19 Feb 2014 00:59:07 +0200 (EET)
X-Mailer: git-send-email 1.8.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242370>

From: Jeff King <peff@peff.net>

When we see a relative config include like:

  [include]
  path = foo

we make it relative to the containing directory of the file
that contains the snippet. This makes no sense for config
read from a blob, as it is not on the filesystem.  Something
like "HEAD:some/path" could have a relative path within the
tree, but:

  1. It would not be part of include.path, which explicitly
     refers to the filesystem.

  2. It would need different parsing rules anyway to
     determine that it is a tree path.

The current code just uses the "name" field, which is wrong.
Let's split that into "name" and "path" fields, use the
latter for relative includes, and fill in only the former
for blobs.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
---
 config.c                  | 10 ++++++----
 t/t1305-config-include.sh | 16 ++++++++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index d969a5aefc2b..b295310d3c22 100644
--- a/config.c
+++ b/config.c
@@ -21,6 +21,7 @@ struct config_source {
 		} buf;
 	} u;
 	const char *name;
+	const char *path;
 	int die_on_error;
 	int linenr;
 	int eof;
@@ -97,12 +98,12 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 	if (!is_absolute_path(path)) {
 		char *slash;
 
-		if (!cf || !cf->name)
+		if (!cf || !cf->path)
 			return error("relative config includes must come from files");
 
-		slash = find_last_dir_sep(cf->name);
+		slash = find_last_dir_sep(cf->path);
 		if (slash)
-			strbuf_add(&buf, cf->name, slash - cf->name + 1);
+			strbuf_add(&buf, cf->path, slash - cf->path + 1);
 		strbuf_addstr(&buf, path);
 		path = buf.buf;
 	}
@@ -1040,7 +1041,7 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 		struct config_source top;
 
 		top.u.file = f;
-		top.name = filename;
+		top.name = top.path = filename;
 		top.die_on_error = 1;
 		top.do_fgetc = config_file_fgetc;
 		top.do_ungetc = config_file_ungetc;
@@ -1062,6 +1063,7 @@ int git_config_from_buf(config_fn_t fn, const char *name, const char *buf,
 	top.u.buf.len = len;
 	top.u.buf.pos = 0;
 	top.name = name;
+	top.path = NULL;
 	top.die_on_error = 0;
 	top.do_fgetc = config_buf_fgetc;
 	top.do_ungetc = config_buf_ungetc;
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index a70707620f14..6edd38b39a0b 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -122,6 +122,22 @@ test_expect_success 'relative includes from command line fail' '
 	test_must_fail git -c include.path=one config test.one
 '
 
+test_expect_success 'absolute includes from blobs work' '
+	echo "[test]one = 1" >one &&
+	echo "[include]path=$(pwd)/one" >blob &&
+	blob=$(git hash-object -w blob) &&
+	echo 1 >expect &&
+	git config --blob=$blob test.one >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'relative includes from blobs fail' '
+	echo "[test]one = 1" >one &&
+	echo "[include]path=one" >blob &&
+	blob=$(git hash-object -w blob) &&
+	test_must_fail git config --blob=$blob test.one
+'
+
 test_expect_success 'include cycles are detected' '
 	cat >.gitconfig <<-\EOF &&
 	[test]value = gitconfig
-- 
1.9.0.rc3
