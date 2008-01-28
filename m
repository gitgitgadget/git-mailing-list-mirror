From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] prefix_path(): disallow absolute paths
Date: Mon, 28 Jan 2008 15:05:42 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801281503350.23907@racer.site>
References: <47975FE6.4050709@viscovery.net> <1201463731-1963-1-git-send-email-shawn.bohrer@gmail.com> <alpine.LSU.1.00.0801272043040.23907@racer.site> <7v3asiyk2i.fsf@gitster.siamese.dyndns.org> <20080128003404.GA18276@lintop> <7vodb6wtix.fsf@gitster.siamese.dyndns.org>
 <479D805E.3000209@viscovery.net> <7vprvmuykw.fsf@gitster.siamese.dyndns.org> <479D9ADE.6010003@viscovery.net> <alpine.LSU.1.00.0801281210440.23907@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jan 28 16:07:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJVZO-0005b9-TM
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 16:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761090AbYA1PGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 10:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755299AbYA1PGF
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 10:06:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:51992 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761524AbYA1PGC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 10:06:02 -0500
Received: (qmail invoked by alias); 28 Jan 2008 15:06:00 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp047) with SMTP; 28 Jan 2008 16:06:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19rO70zFwFrI+MsS2suTK0basX56COW/82JjjrWaV
	Cvt+VQtqWL69D7
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0801281210440.23907@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71892>


Without this fix, "git ls-files --others /" would list _all_ files,
except for those tracked in the current repository.  Worse, "git clean /"
would start removing them.

Noticed by Johannes Sixt.

Incidentally, it fixes some strange code in builtin-mv.c by yours truly,
where a slash was added to "dst" but then ignored, and instead taken from
the source path.  This triggered the new check for absolute paths.

A test in t3101 started failing, too, because it tested ls-tree with
not-really-absolute paths (expecting the leading "/" to be ignored).
Those paths were changed to relative paths.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 28 Jan 2008, Johannes Schindelin wrote:

	> The failure of t3101 has something to do with ls-tree filtering 
	> out invalid paths; I maintain that this behaviour is wrong to 
	> begin with.

	This patch fixes the test.

	But as this fix illustrates, it is a change in semantics: where 
	earlier

		git ls-tree /README

	was allowed, it is no longer.

	Comments?

 builtin-mv.c               |    4 ++--
 setup.c                    |    2 ++
 t/t3101-ls-tree-dirname.sh |    2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin-mv.c b/builtin-mv.c
index 990e213..94f6dd2 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -164,7 +164,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				}
 
 				dst = add_slash(dst);
-				dst_len = strlen(dst) - 1;
+				dst_len = strlen(dst);
 
 				for (j = 0; j < last - first; j++) {
 					const char *path =
@@ -172,7 +172,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 					source[argc + j] = path;
 					destination[argc + j] =
 						prefix_path(dst, dst_len,
-							path + length);
+							path + length + 1);
 					modes[argc + j] = INDEX;
 				}
 				argc += last - first;
diff --git a/setup.c b/setup.c
index 2174e78..5a4aadc 100644
--- a/setup.c
+++ b/setup.c
@@ -13,6 +13,8 @@ const char *get_current_prefix()
 const char *prefix_path(const char *prefix, int len, const char *path)
 {
 	const char *orig = path;
+	if (is_absolute_path(path))
+		die("no absolute paths allowed: '%s'", path);
 	for (;;) {
 		char c;
 		if (*path != '.')
diff --git a/t/t3101-ls-tree-dirname.sh b/t/t3101-ls-tree-dirname.sh
index 39fe267..cc5b982 100755
--- a/t/t3101-ls-tree-dirname.sh
+++ b/t/t3101-ls-tree-dirname.sh
@@ -120,7 +120,7 @@ EOF
 # having 1.txt and path3
 test_expect_success \
     'ls-tree filter odd names' \
-    'git ls-tree $tree 1.txt /1.txt //1.txt path3/1.txt /path3/1.txt //path3//1.txt path3 /path3/ path3// >current &&
+    'git ls-tree $tree 1.txt ./1.txt .//1.txt path3/1.txt ./path3/1.txt .//path3//1.txt path3 ./path3/ path3// >current &&
      cat >expected <<\EOF &&
 100644 blob X	1.txt
 100644 blob X	path3/1.txt
-- 
1.5.4.rc5.15.g8231f
