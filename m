From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Implement git remote mv
Date: Wed, 22 Oct 2008 02:23:14 +0200
Message-ID: <1224634994-1664-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 02:23:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsRVv-0007Si-Dp
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 02:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbYJVAWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 20:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbYJVAWf
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 20:22:35 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:48564 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbYJVAWe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 20:22:34 -0400
Received: from vmobile.example.net (catv-80-98-230-81.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTPA id CFF86446CCD;
	Wed, 22 Oct 2008 02:22:31 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 703AE148F2; Wed, 22 Oct 2008 02:23:14 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98825>

The new rename subcommand does the followings:

1) Renames the remote.foo configuration section to remote.bar

2) Updates the remote.bar.fetch refspecs

3) Updates the branch.*.remote settings

4) Renames the tracking branches.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/git-remote.txt |    6 +++
 builtin-remote.c             |  102 ++++++++++++++++++++++++++++++++++++++++++
 t/t5505-remote.sh            |   14 ++++++
 3 files changed, 122 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index bb99810..4b5542a 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git remote' [-v | --verbose]
 'git remote add' [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>
+'git remote mv' <old> <new>
 'git remote rm' <name>
 'git remote show' [-n] <name>
 'git remote prune' [-n | --dry-run] <name>
@@ -61,6 +62,11 @@ only makes sense in bare repositories.  If a remote uses mirror
 mode, furthermore, `git push` will always behave as if `\--mirror`
 was passed.
 
+'mv'::
+
+Rename the remote named <old> to <new>. All remote tracking branches and
+configuration settings for the remote are updated.
+
 'rm'::
 
 Remove the remote named <name>. All remote tracking branches and
diff --git a/builtin-remote.c b/builtin-remote.c
index 6b3325d..4a23738 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -10,6 +10,7 @@
 static const char * const builtin_remote_usage[] = {
 	"git remote",
 	"git remote add <name> <url>",
+	"git remote mv <old> <new>",
 	"git remote rm <name>",
 	"git remote show <name>",
 	"git remote prune <name>",
@@ -329,6 +330,105 @@ static int add_branch_for_removal(const char *refname,
 	return 0;
 }
 
+struct rename_info {
+	const char *old;
+	const char *new;
+	struct string_list *remote_branches;
+};
+
+static int read_remote_branches(const char *refname,
+	const unsigned char *sha1, int flags, void *cb_data)
+{
+	struct rename_info *rename = cb_data;
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addf(&buf, "refs/remotes/%s", rename->old);
+	if(!prefixcmp(refname, buf.buf))
+		string_list_append(xstrdup(refname), rename->remote_branches);
+
+	return 0;
+}
+
+static int mv(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+	struct remote *oldremote, *newremote;
+	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
+	struct string_list remote_branches = { NULL, 0, 0, 0 };
+	struct rename_info rename = { argv[1], argv[2], &remote_branches };
+	int i;
+
+	if (argc != 3)
+		usage_with_options(builtin_remote_usage, options);
+
+	oldremote = remote_get(rename.old);
+	if (!oldremote)
+		die("No such remote: %s", rename.old);
+
+	newremote = remote_get(rename.new);
+	if (newremote && (newremote->url_nr > 1 || newremote->fetch_refspec_nr))
+		die("remote %s already exists.", rename.new);
+
+	strbuf_addf(&buf, "refs/heads/test:refs/remotes/%s/test", rename.new);
+	if (!valid_fetch_refspec(buf.buf))
+		die("'%s' is not a valid remote name", rename.new);
+
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "remote.%s", rename.old);
+	strbuf_addf(&buf2, "remote.%s", rename.new);
+	if (git_config_rename_section(buf.buf, buf2.buf) < 1)
+		return error("Could not rename config section '%s' to '%s'",
+				buf.buf, buf2.buf);
+
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "remote.%s.fetch", rename.new);
+	if (git_config_set_multivar(buf.buf, NULL, NULL, 1))
+		return error("Could not remove config section '%s'", buf.buf);
+	for (i = 0; i < oldremote->fetch_refspec_nr; i++) {
+		char *ptr;
+
+		strbuf_reset(&buf2);
+		strbuf_addstr(&buf2, oldremote->fetch_refspec[i]);
+		ptr = strstr(buf2.buf, rename.old);
+		if (ptr)
+			strbuf_splice(&buf2, ptr-buf2.buf, strlen(rename.old),
+					rename.new, strlen(rename.new));
+		if (git_config_set_multivar(buf.buf, buf2.buf, "^$", 0))
+			return error("Could not append '%s'", buf.buf);
+	}
+
+	read_branches();
+	for (i = 0; i < branch_list.nr; i++) {
+		struct string_list_item *item = branch_list.items + i;
+		struct branch_info *info = item->util;
+		if (info->remote && !strcmp(info->remote, rename.old)) {
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "branch.%s.remote", item->string);
+			if (git_config_set(buf.buf, rename.new)) {
+				return error("Could not set '%s'", buf.buf);
+			}
+		}
+	}
+
+	for_each_ref(read_remote_branches, &rename);
+	for (i = 0; i < remote_branches.nr; i++) {
+		struct string_list_item *item = remote_branches.items + i;
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, item->string);
+		strbuf_splice(&buf, strlen("refs/remotes/"), strlen(rename.old),
+				rename.new, strlen(rename.new));
+		strbuf_reset(&buf2);
+		strbuf_addf(&buf2, "remote: renamed %s to %s",
+				item->string, buf.buf);
+		if (rename_ref(item->string, buf.buf, buf2.buf))
+			die("renaming '%s' failed", item->string);
+	}
+
+	return 0;
+}
+
 static int remove_branches(struct string_list *branches)
 {
 	int i, result = 0;
@@ -696,6 +796,8 @@ int cmd_remote(int argc, const char **argv, const char *prefix)
 		result = show_all();
 	else if (!strcmp(argv[0], "add"))
 		result = add(argc, argv);
+	else if (!strcmp(argv[0], "mv"))
+		result = mv(argc, argv);
 	else if (!strcmp(argv[0], "rm"))
 		result = rm(argc, argv);
 	else if (!strcmp(argv[0], "show"))
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index c449663..9b11fd3 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -324,4 +324,18 @@ test_expect_success 'reject adding remote with an invalid name' '
 
 '
 
+# The first three tests if the config is properly updated, the last one
+# checks if the branches are renamed.
+
+test_expect_success 'rename a remote' '
+
+	git clone one four &&
+	(cd four &&
+	 git remote mv origin upstream &&
+	 git remote show |grep -q upstream &&
+	 git config remote.upstream.fetch |grep -q upstream &&
+	 test $(git config branch.master.remote) = "upstream" &&
+	 git for-each-ref|grep -q refs/remotes/upstream)
+
+'
 test_done
-- 
1.6.0.2
