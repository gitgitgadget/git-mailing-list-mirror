From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH/RFC 1/3] Teach mv to move submodules together with their work
 trees
Date: Wed, 03 Apr 2013 21:56:08 +0200
Message-ID: <515C8958.4080704@web.de>
References: <515C88FE.9020203@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>,
	Peter Collingbourne <peter@pcc.me.uk>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 03 21:59:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNTqd-00068P-KV
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 21:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374Ab3DCT70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 15:59:26 -0400
Received: from mout.web.de ([212.227.17.11]:58822 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756543Ab3DCT7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 15:59:25 -0400
Received: from [192.168.178.41] ([79.193.80.178]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0MEmbK-1UQH4s34Y6-00FYIq; Wed, 03 Apr 2013 21:56:09
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <515C88FE.9020203@web.de>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:K/yUQwTx9rnmGZ7LA/B1Vnk9bJJWpEbDeIe+jYQtE8T
 SonxTMdmEqYXNn336Cw/6RQ+07jpbglz+syc8YnqS03834Hs3h
 N/xlidLFoO7ju1GxVBRNvyVc/Rby64oQ4EcrEe1g2rUgywqzQD
 hRyJiuYlYXEzbGs5vS1H6pMnck0iXyl6h4pGPcPKrpCuqy9vBL
 iYF/5X2pMlno046v193eg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219966>

Currently the attempt to use "git mv" on a submodule errors out with:
  fatal: source directory is empty, source=<src>, destination=<dest>
The reason is that mv searches for the submodule with a trailing slash in
the index, which it doesn't find (because it is stored without a trailing
slash). As it doesn't find any index entries inside the submodule it
claims the directory would be empty even though it isn't.

Fix that by searching for the name without a trailing slash and continue
if it is a submodule. Then rename() will move the submodule work tree just
like it moves a file.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 builtin/mv.c  | 99 +++++++++++++++++++++++++++++++----------------------------
 t/t7001-mv.sh | 34 ++++++++++++++++++++
 2 files changed, 86 insertions(+), 47 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 034fec9..361028d 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -117,55 +117,60 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				&& lstat(dst, &st) == 0)
 			bad = _("cannot move directory over file");
 		else if (src_is_dir) {
-			const char *src_w_slash = add_slash(src);
-			int len_w_slash = length + 1;
-			int first, last;
-
-			modes[i] = WORKING_DIRECTORY;
-
-			first = cache_name_pos(src_w_slash, len_w_slash);
-			if (first >= 0)
-				die (_("Huh? %.*s is in index?"),
-						len_w_slash, src_w_slash);
-
-			first = -1 - first;
-			for (last = first; last < active_nr; last++) {
-				const char *path = active_cache[last]->name;
-				if (strncmp(path, src_w_slash, len_w_slash))
-					break;
-			}
-			free((char *)src_w_slash);
-
-			if (last - first < 1)
-				bad = _("source directory is empty");
-			else {
-				int j, dst_len;
-
-				if (last - first > 0) {
-					source = xrealloc(source,
-							(argc + last - first)
-							* sizeof(char *));
-					destination = xrealloc(destination,
-							(argc + last - first)
-							* sizeof(char *));
-					modes = xrealloc(modes,
-							(argc + last - first)
-							* sizeof(enum update_mode));
+			int first = cache_name_pos(src, length);
+			if (first >= 0) {
+				if (!S_ISGITLINK(active_cache[first]->ce_mode))
+					die (_("Huh? Directory %s is in index and no submodule?"), src);
+			} else {
+				const char *src_w_slash = add_slash(src);
+				int last, len_w_slash = length + 1;
+
+				modes[i] = WORKING_DIRECTORY;
+
+				first = cache_name_pos(src_w_slash, len_w_slash);
+				if (first >= 0)
+					die (_("Huh? %.*s is in index?"),
+							len_w_slash, src_w_slash);
+
+				first = -1 - first;
+				for (last = first; last < active_nr; last++) {
+					const char *path = active_cache[last]->name;
+					if (strncmp(path, src_w_slash, len_w_slash))
+						break;
 				}
-
-				dst = add_slash(dst);
-				dst_len = strlen(dst);
-
-				for (j = 0; j < last - first; j++) {
-					const char *path =
-						active_cache[first + j]->name;
-					source[argc + j] = path;
-					destination[argc + j] =
-						prefix_path(dst, dst_len,
-							path + length + 1);
-					modes[argc + j] = INDEX;
+				free((char *)src_w_slash);
+
+				if (last - first < 1)
+					bad = _("source directory is empty");
+				else {
+					int j, dst_len;
+
+					if (last - first > 0) {
+						source = xrealloc(source,
+								(argc + last - first)
+								* sizeof(char *));
+						destination = xrealloc(destination,
+								(argc + last - first)
+								* sizeof(char *));
+						modes = xrealloc(modes,
+								(argc + last - first)
+								* sizeof(enum update_mode));
+					}
+
+					dst = add_slash(dst);
+					dst_len = strlen(dst);
+
+					for (j = 0; j < last - first; j++) {
+						const char *path =
+							active_cache[first + j]->name;
+						source[argc + j] = path;
+						destination[argc + j] =
+							prefix_path(dst, dst_len,
+								path + length + 1);
+						modes[argc + j] = INDEX;
+					}
+					argc += last - first;
 				}
-				argc += last - first;
 			}
 		} else if (cache_name_pos(src, length) < 0)
 			bad = _("not under version control");
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index a845b15..4c57f61 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -255,4 +255,38 @@ test_expect_success SYMLINKS 'git mv should overwrite file with a symlink' '

 rm -f moved symlink

+test_expect_success 'setup submodule' '
+	git commit -m initial &&
+	git reset --hard &&
+	git submodule add ./. sub &&
+	echo content >file &&
+	git add file &&
+	git commit -m "added sub and file"
+'
+
+test_expect_success 'git mv cannot move a submodule in a file' '
+	test_must_fail git mv sub file
+'
+
+test_expect_success 'git mv moves a submodule with a .git directory and no .gitmodules' '
+	entry="$(git ls-files --stage sub | cut -f 1)" &&
+	git rm .gitmodules &&
+	(
+		cd sub &&
+		rm -f .git &&
+		cp -a ../.git/modules/sub .git &&
+		GIT_WORK_TREE=. git config --unset core.worktree
+	) &&
+	mkdir mod &&
+	git mv sub mod/sub &&
+	! test -e sub &&
+	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
+	(
+		cd mod/sub &&
+		git status
+	) &&
+	git update-index --refresh &&
+	git diff-files --quiet
+'
+
 test_done
-- 
1.8.2.377.g1bdb7d0
