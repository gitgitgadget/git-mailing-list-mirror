From: marcnarc@xiplink.com
Subject: [PATCH 4/6] Teach "git remote" about remote.default.
Date: Thu,  5 Jul 2012 18:11:15 -0400
Message-ID: <1341526277-17055-5-git-send-email-marcnarc@xiplink.com>
References: <1341526277-17055-1-git-send-email-marcnarc@xiplink.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com, Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 00:11:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmuH3-0006Qz-G4
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 00:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756875Ab2GEWLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 18:11:25 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:23284 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755616Ab2GEWLW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jul 2012 18:11:22 -0400
Received: from xiplink.com (rincewind.xiplink.com [192.168.1.166])
	by farnsworth.xiplink.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id q65MBE0D004223;
	Thu, 5 Jul 2012 18:11:16 -0400
X-Mailer: git-send-email 1.7.11.1
In-Reply-To: <1341526277-17055-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201068>

From: Marc Branchaud <marcnarc@xiplink.com>

The "rename" and "rm" commands now handle the case where the remote being
changed is the default remote.

If the "add" command is used to add the repo's first remote, that remote
becomes the default remote.

Also added a "default" command to get or set the default remote:
 "git remote default" (with no parameter) displays the current default remote.
 "git remote default <remo>" checks if <remo> is a configured remote and if
 so changes remote.default to <remo>.

(The test in t5528 had to be changed because now "git push" when
push.default=matching succeeds with "Everything up-to-date".  It used to
fail with "No configured push destination".)

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---
 builtin/remote.c        | 29 ++++++++++++++++++++++
 t/t5505-remote.sh       | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
 t/t5512-ls-remote.sh    |  8 ++++++-
 t/t5528-push-default.sh |  4 ++--
 4 files changed, 102 insertions(+), 3 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 920262d..ac98765 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -12,6 +12,7 @@ static const char * const builtin_remote_usage[] = {
 	"git remote add [-t <branch>] [-m <master>] [-f] [--tags|--no-tags] [--mirror=<fetch|push>] <name> <url>",
 	"git remote rename <old> <new>",
 	"git remote rm <name>",
+	"git remote default [name]",
 	"git remote set-head <name> (-a | -d | <branch>)",
 	"git remote [-v | --verbose] show [-n] <name>",
 	"git remote prune [-n | --dry-run] <name>",
@@ -198,6 +199,9 @@ static int add(int argc, const char **argv)
 	if (!valid_fetch_refspec(buf2.buf))
 		die(_("'%s' is not a valid remote name"), name);
 
+	if (remote_count() == 1)
+		git_config_set("remote.default", name);
+
 	strbuf_addf(&buf, "remote.%s.url", name);
 	if (git_config_set(buf.buf, url))
 		return 1;
@@ -656,6 +660,10 @@ static int mv(int argc, const char **argv)
 		return error(_("Could not rename config section '%s' to '%s'"),
 				buf.buf, buf2.buf);
 
+	if (!strcmp(oldremote->name, remote_get_default_name())) {
+		git_config_set("remote.default", newremote->name);
+	}
+
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.fetch", rename.new);
 	if (git_config_set_multivar(buf.buf, NULL, NULL, 1))
@@ -798,6 +806,10 @@ static int rm(int argc, const char **argv)
 	if (git_config_rename_section(buf.buf, NULL) < 1)
 		return error(_("Could not remove config section '%s'"), buf.buf);
 
+	if (!strcmp(remote->name, remote_get_default_name())) {
+		git_config_set("remote.default", NULL);
+	}
+
 	read_branches();
 	for (i = 0; i < branch_list.nr; i++) {
 		struct string_list_item *item = branch_list.items + i;
@@ -845,6 +857,21 @@ static int rm(int argc, const char **argv)
 	return result;
 }
 
+static int deflt(int argc, const char **argv)
+{
+	if (argc < 2)
+		printf_ln("%s", remote_get_default_name());
+	else {
+		const char *name = argv[1];
+		if (remote_is_configured(name)) {
+			git_config_set("remote.default", name);
+			printf_ln(_("Default remote set to '%s'."), name);
+		} else
+			return error(_("No remote named '%s'."), name);
+	}
+	return 0;
+}
+
 static void clear_push_info(void *util, const char *string)
 {
 	struct push_info *info = util;
@@ -1582,6 +1609,8 @@ int cmd_remote(int argc, const char **argv, const char *prefix)
 		result = mv(argc, argv);
 	else if (!strcmp(argv[0], "rm"))
 		result = rm(argc, argv);
+	else if (!strcmp(argv[0], "default"))
+		result = deflt(argc, argv);
 	else if (!strcmp(argv[0], "set-head"))
 		result = set_head(argc, argv);
 	else if (!strcmp(argv[0], "set-branches"))
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index e8af615..d9070cd 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -77,6 +77,15 @@ test_expect_success 'add another remote' '
 )
 '
 
+test_expect_success 'add first remote sets default' '
+(
+	test_create_repo default-first-remote &&
+	cd default-first-remote &&
+	git remote add first /path/to/first &&
+	test "$(git config --get remote.default)" = first
+)
+'
+
 test_expect_success 'remote forces tracking branches' '
 (
 	cd test &&
@@ -107,6 +116,16 @@ test_expect_success 'remove remote' '
 )
 '
 
+test_expect_success 'remove default remote' '
+(
+	git clone one no-default
+	cd no-default &&
+	test "$(git config --get remote.default)" = origin   # Sanity check
+	git remote rm origin &&
+	test_must_fail git config --get remote.default
+)
+'
+
 test_expect_success 'remove remote protects local branches' '
 (
 	cd test &&
@@ -662,6 +681,16 @@ test_expect_success 'rename a remote with name prefix of other remote' '
 
 '
 
+test_expect_success 'rename the default remote' '
+	git clone one default-rename &&
+	(cd default-rename &&
+		test "$(git config --get remote.default)" = origin   # Sanity?
+		git remote rename origin tyrion
+		test "$(git config --get remote.default)" = tyrion
+	)
+
+'
+
 cat > remotes_origin << EOF
 URL: $(pwd)/one
 Push: refs/heads/master:refs/heads/upstream
@@ -997,4 +1026,39 @@ test_expect_success 'remote set-url --delete baz' '
 	cmp expect actual
 '
 
+test_expect_success 'remote default' '
+(
+	git clone -o up one default
+	cd default &&
+	test "$(git remote default)" = up
+)
+'
+
+test_expect_success 'remote default (none)' '
+(
+	test_create_repo default-none &&
+	cd default-none &&
+	test "$(git remote default)" = origin
+)
+'
+
+test_expect_success 'remote default set' '
+(
+	test_create_repo default-set &&
+	cd default-set &&
+	git remote add A /foo-A &&
+	git remote add B /foo-A &&
+	git remote default B &&
+	test "$(git remote default)" = B
+)
+'
+
+test_expect_success 'remote default bad' '
+(
+	git clone one default-bad &&
+	cd default-bad &&
+	test_must_fail git remote default NonExistant
+)
+'
+
 test_done
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 6764d51..853b045 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -40,7 +40,13 @@ test_expect_success 'ls-remote self' '
 '
 
 test_expect_success 'dies when no remote specified and no default remotes found' '
-	test_must_fail git ls-remote
+	test_create_repo no-remotes &&
+	(
+		cd no-remotes &&
+		test_must_fail git ls-remote &&
+		test_config remote.default blop &&
+		test_must_fail git ls-remote
+	)
 '
 
 test_expect_success 'use "origin" when no remote specified' '
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index 4736da8..6a08998 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -71,10 +71,10 @@ test_expect_success '"upstream" does not push when remotes do not match' '
 	test_must_fail git push parent2
 '
 
-test_expect_success 'push from/to new branch with upstream, matching and simple' '
+test_expect_success 'push from/to new remoteless branch with upstream, matching and simple' '
 	git checkout -b new-branch &&
 	test_push_failure simple &&
-	test_push_failure matching &&
+	test_push_success matching master &&
 	test_push_failure upstream
 '
 
-- 
1.7.11.1
