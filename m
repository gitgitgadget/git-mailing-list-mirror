From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v3 1/5] Teach mv to move submodules together with their work
 trees
Date: Tue, 30 Jul 2013 21:49:25 +0200
Message-ID: <51F818C5.9070507@web.de>
References: <51F8187F.7040603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 30 21:49:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4FvI-00077v-5y
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 21:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757122Ab3G3Tt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 15:49:28 -0400
Received: from mout.web.de ([212.227.15.14]:52629 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755523Ab3G3Tt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 15:49:27 -0400
Received: from [192.168.178.41] ([79.193.94.161]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0Mcnuz-1Un09X0LGD-00Hyd1 for <git@vger.kernel.org>;
 Tue, 30 Jul 2013 21:49:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51F8187F.7040603@web.de>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:a4Ia18tM1HQ+KKMYnsCU+KIrSWJErPa5yrfi7yY29eDUh20kv/r
 bW6SoGTH5AqjO57NDiWNQBt+tcjz4qD+2trKfpplSC944URMpEEvVVmdIHk1dLxItgDjHc6
 Le2SNSohkJhki15uG5Qls0BKOCWkI7tYcJvKQvMyJSPFrsrYvnZFh1bpQFwDIygoVsMnZ6Q
 7FS5aQygcCqZdEIIqG45g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231383>

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
index 16ce99b..1d3ef63 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -118,55 +118,60 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
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
index 101816e..15c18b6 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -259,4 +259,38 @@ test_expect_success SYMLINKS 'check moved symlink' '

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
1.8.4.rc0.199.g7079aac
