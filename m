From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [RFC PATCH 1/2] rm: don't fail when removing populated submodules
Date: Wed, 04 Jul 2012 22:44:11 +0200
Message-ID: <4FF4AB1B.60805@web.de>
References: <4FF4AAE7.40604@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 22:44:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmWQv-0007XZ-Qa
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 22:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755095Ab2GDUoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jul 2012 16:44:16 -0400
Received: from mout.web.de ([212.227.15.3]:52359 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754245Ab2GDUoP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2012 16:44:15 -0400
Received: from [192.168.178.48] ([91.3.155.233]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MK2JZ-1SlhU13v53-001Bzs; Wed, 04 Jul 2012 22:44:13
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <4FF4AAE7.40604@web.de>
X-Provags-ID: V02:K0:84itke6s4KfBUuI9Sauh43yY2WglzwuGp2BScj0m/vy
 2MTdPuZcSkwA6OXymZiXlmZFVq6jW1NANhW1ceC+b4QL2GKqjE
 2D7rsKuC1pm8QPi+zqv8EUZarAb5+N2mfOFqJurBN9se+CRu3t
 lnShdELGDaAhjghEp3IyxhViVEK3oKW8zQo1HnD5Jr9AUh68N2
 qOYxdjT+iDey2/gU+bGfw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201016>

Currently using "git rm" on a populated submodule produces this error:
	fatal: git rm: '<submodule path>': Is a directory
Using it on an unpopulated submodule removes the empty directory silently
and removes the gitlink from the index, while it doesn't do the latter
when the submodule is populated but errors out.

While the error technically correct (the submodule directory can't be
removed because it still contains the checked out work tree) rm could do
better because it knows it is a submodule. It should remove the gitlink
from the index no matter if it is populated or not. Also not being able to
remove a submodule directory isn't an error but should only issue a
warning to inform the user about that fact while removing the gitlink from
the index nonetheless.

Change "git rm" so it only issues a warning if a populated submodule
cannot be removed. Also apply the same policy as for regular files and
require forcing when the submodules HEAD is different than what is
recorded in the index. To achieve that the list storing to be deleted
files and submodules is extended by a boolean recording if the entry is a
submodule or not to reuse that information in the removal phase.

While this changes behavior of "git rm", it only fixes an error where it
never worked properly.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 builtin/rm.c  | 34 +++++++++++++++++-----------
 t/t3600-rm.sh | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 13 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 90c8a50..1c73dcf 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -17,7 +17,10 @@ static const char * const builtin_rm_usage[] = {

 static struct {
 	int nr, alloc;
-	const char **name;
+	struct {
+		const char *name;
+		char is_submodule;
+	} *entry;
 } list;

 static int check_local_mod(unsigned char *head, int index_only)
@@ -37,7 +40,7 @@ static int check_local_mod(unsigned char *head, int index_only)
 		struct stat st;
 		int pos;
 		struct cache_entry *ce;
-		const char *name = list.name[i];
+		const char *name = list.entry[i].name;
 		unsigned char sha1[20];
 		unsigned mode;
 		int local_changes = 0;
@@ -54,11 +57,11 @@ static int check_local_mod(unsigned char *head, int index_only)
 			/* It already vanished from the working tree */
 			continue;
 		}
-		else if (S_ISDIR(st.st_mode)) {
+		else if (S_ISDIR(st.st_mode) && !S_ISGITLINK(ce->ce_mode)) {
 			/* if a file was removed and it is now a
 			 * directory, that is the same as ENOENT as
 			 * far as git is concerned; we do not track
-			 * directories.
+			 * directories unless they are submodules.
 			 */
 			continue;
 		}
@@ -173,8 +176,9 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		struct cache_entry *ce = active_cache[i];
 		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen))
 			continue;
-		ALLOC_GROW(list.name, list.nr + 1, list.alloc);
-		list.name[list.nr++] = ce->name;
+		ALLOC_GROW(list.entry, list.nr + 1, list.alloc);
+		list.entry[list.nr].name = ce->name;
+		list.entry[list.nr++].is_submodule = S_ISGITLINK(ce->ce_mode);
 	}

 	if (pathspec) {
@@ -222,7 +226,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	 * the index unless all of them succeed.
 	 */
 	for (i = 0; i < list.nr; i++) {
-		const char *path = list.name[i];
+		const char *path = list.entry[i].name;
 		if (!quiet)
 			printf("rm '%s'\n", path);

@@ -244,13 +248,17 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (!index_only) {
 		int removed = 0;
 		for (i = 0; i < list.nr; i++) {
-			const char *path = list.name[i];
-			if (!remove_path(path)) {
-				removed = 1;
-				continue;
+			const char *path = list.entry[i].name;
+			if (!list.entry[i].is_submodule) {
+				if (!remove_path(path)) {
+					removed = 1;
+					continue;
+				}
+				if (!removed)
+					die_errno("git rm: '%s'", path);
+			} else {
+				rmdir_or_warn(path);
 			}
-			if (!removed)
-				die_errno("git rm: '%s'", path);
 		}
 	}

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 9fd28bc..2af8bb9 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -262,4 +262,75 @@ test_expect_success 'rm removes subdirectories recursively' '
 	! test -d dir
 '

+cat >expect <<EOF
+D  submod
+EOF
+
+test_expect_success 'rm removes empty submodules from work tree' '
+	mkdir submod &&
+	git update-index --add --cacheinfo 160000 $(git rev-parse HEAD) submod &&
+	git config -f .gitmodules submodule.sub.url ./. &&
+	git config -f .gitmodules submodule.sub.path submod &&
+	git submodule init &&
+	git add .gitmodules &&
+	git commit -m "add submodule" &&
+	git rm submod &&
+	test ! -e submod &&
+	git status -s -uno > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rm leaves work tree of populated submodules alone' '
+	git reset --hard &&
+	git submodule update &&
+	git rm submod &&
+	test -d submod &&
+	test -f submod/.git &&
+	git status -s -uno > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rm of a populated submodule with different HEAD requires forcing' '
+	git reset --hard &&
+	git submodule update &&
+	(cd submod &&
+		git checkout HEAD^
+	) &&
+	test_must_fail git rm submod &&
+	git status -s -uno > actual &&
+	git rm --force submod &&
+	test -s actual &&
+	test -d submod &&
+	test -f submod/.git &&
+	git status -s -uno > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rm of a populated submodule with modifications succeeds' '
+	git reset --hard &&
+	git submodule update &&
+	(cd submod &&
+		echo X >empty
+	) &&
+	git rm submod &&
+	test -d submod &&
+	test -f submod/.git &&
+	git status -s -uno > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rm of a populated submodule with untracked files succeeds' '
+	git reset --hard &&
+	git submodule update &&
+	(cd submod &&
+		echo X >untracked
+	) &&
+	git rm submod &&
+	test -d submod &&
+	test -f submod/.git &&
+	git status -s -uno > actual &&
+	test_cmp expect actual &&
+	rm submod/untracked
+'
+
 test_done
-- 
1.7.11.1.105.g9f6831b
