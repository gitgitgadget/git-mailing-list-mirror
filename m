From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Implement git remote rename
Date: Mon,  3 Nov 2008 19:26:18 +0100
Message-ID: <1225736778-12556-1-git-send-email-vmiklos@frugalware.org>
References: <7v63nh1sc7.fsf@gitster.siamese.dyndns.org>
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 19:26:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx48O-0004lB-Jy
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 19:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbYKCSZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 13:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbYKCSZ0
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 13:25:26 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46755 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbYKCSZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 13:25:25 -0500
Received: from vmobile.example.net (dsl5401C51D.pool.t-online.hu [84.1.197.29])
	by yugo.frugalware.org (Postfix) with ESMTPA id 94184446CCD;
	Mon,  3 Nov 2008 19:25:22 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 57E398B393; Mon,  3 Nov 2008 19:26:18 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <7v63nh1sc7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99971>

The new rename subcommand does the followings:

1) Renames the remote.foo configuration section to remote.bar

2) Updates the remote.bar.fetch refspecs

3) Updates the branch.*.remote settings

4) Renames the tracking branches: renames the normal refs and rewrites
   the symrefs to point to the new refs.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Fri, Oct 24, 2008 at 04:33:28PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Hmm, remote_get() can read from all three supported places that you
> can define remotes.  Could you explain what happens if the old remote
> is read from say $GIT_DIR/remotes/origin and you are renaming it to
> "upstream" with "git remote rename origin upstream"?

Currently it dies because it can't rename config section 'remote.origin'
to 'remote.upstream'.

> I suspect that if you record where you read the configuration from in
> "struct remote" and add necessary code to remove the original when
> rename.old is *not* coming from in-config definition, you would make
> it possible for repositories initialized with older git that has
> either $GIT_DIR/branches/origin or $GIT_DIR/remotes/origin to be
> migrated to the in-config format using "git remote rename origin
> origin".

Yes, that's possible. I think the patch is already large enough that it
would be better to do it as a separate patch, but I like the idea.

One important step is that currently we have to care about the
remote.upstream.fetch variable, but once migration is supported, we have
to pay attention to remote.upstream.url/push as well.

In the meantime here is an updated patch which applies on top of
mv/maint-branch-m-symref. However, it is not meant for 'maint', of
course. :)

The old version did not "rename" (in fact it is not just a rename but it
replaces origin with upstream in the contents) symrefs properly, now the
testcases are extended to check for this, too.

 Documentation/git-remote.txt |    6 ++
 builtin-remote.c             |  153 ++++++++++++++++++++++++++++++++++++++++++
 t/t5505-remote.sh            |   15 ++++
 3 files changed, 174 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index bb99810..7b227b3 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git remote' [-v | --verbose]
 'git remote add' [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>
+'git remote rename' <old> <new>
 'git remote rm' <name>
 'git remote show' [-n] <name>
 'git remote prune' [-n | --dry-run] <name>
@@ -61,6 +62,11 @@ only makes sense in bare repositories.  If a remote uses mirror
 mode, furthermore, `git push` will always behave as if `\--mirror`
 was passed.
 
+'rename'::
+
+Rename the remote named <old> to <new>. All remote tracking branches and
+configuration settings for the remote are updated.
+
 'rm'::
 
 Remove the remote named <name>. All remote tracking branches and
diff --git a/builtin-remote.c b/builtin-remote.c
index e396a3a..1ca6cdb 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -10,6 +10,7 @@
 static const char * const builtin_remote_usage[] = {
 	"git remote",
 	"git remote add <name> <url>",
+	"git remote rename <old> <new>",
 	"git remote rm <name>",
 	"git remote show <name>",
 	"git remote prune <name>",
@@ -329,6 +330,156 @@ static int add_branch_for_removal(const char *refname,
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
+	struct string_list_item *item;
+	int flag;
+	unsigned char orig_sha1[20];
+	const char *symref;
+
+	strbuf_addf(&buf, "refs/remotes/%s", rename->old);
+	if(!prefixcmp(refname, buf.buf)) {
+		item = string_list_append(xstrdup(refname), rename->remote_branches);
+		symref = resolve_ref(refname, orig_sha1, 1, &flag);
+		if (flag & REF_ISSYMREF)
+			item->util = xstrdup(symref);
+		else
+			item->util = NULL;
+	}
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
+	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT, buf3 = STRBUF_INIT;
+	struct string_list remote_branches = { NULL, 0, 0, 0 };
+	struct rename_info rename;
+	int i;
+
+	if (argc != 3)
+		usage_with_options(builtin_remote_usage, options);
+
+	rename.old = argv[1];
+	rename.new = argv[2];
+	rename.remote_branches = &remote_branches;
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
+	/*
+	 * First remove symrefs, then rename the rest, finally create
+	 * the new symrefs.
+	 */
+	for_each_ref(read_remote_branches, &rename);
+	for (i = 0; i < remote_branches.nr; i++) {
+		struct string_list_item *item = remote_branches.items + i;
+		int flag = 0;
+		unsigned char sha1[20];
+		const char *symref;
+
+		symref = resolve_ref(item->string, sha1, 1, &flag);
+		if (!(flag & REF_ISSYMREF))
+			continue;
+		if (delete_ref(item->string, NULL, REF_NODEREF))
+			die("deleting '%s' failed", item->string);
+	}
+	for (i = 0; i < remote_branches.nr; i++) {
+		struct string_list_item *item = remote_branches.items + i;
+
+		if (item->util)
+			continue;
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
+	for (i = 0; i < remote_branches.nr; i++) {
+		struct string_list_item *item = remote_branches.items + i;
+
+		if (!item->util)
+			continue;
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, item->string);
+		strbuf_splice(&buf, strlen("refs/remotes/"), strlen(rename.old),
+				rename.new, strlen(rename.new));
+		strbuf_reset(&buf2);
+		strbuf_addstr(&buf2, item->util);
+		strbuf_splice(&buf2, strlen("refs/remotes/"), strlen(rename.old),
+				rename.new, strlen(rename.new));
+		strbuf_reset(&buf3);
+		strbuf_addf(&buf3, "remote: renamed %s to %s",
+				item->string, buf.buf);
+		if (create_symref(buf.buf, buf2.buf, buf3.buf))
+			die("creating '%s' failed", buf.buf);
+	}
+	return 0;
+}
+
 static int remove_branches(struct string_list *branches)
 {
 	int i, result = 0;
@@ -695,6 +846,8 @@ int cmd_remote(int argc, const char **argv, const char *prefix)
 		result = show_all();
 	else if (!strcmp(argv[0], "add"))
 		result = add(argc, argv);
+	else if (!strcmp(argv[0], "rename"))
+		result = mv(argc, argv);
 	else if (!strcmp(argv[0], "rm"))
 		result = rm(argc, argv);
 	else if (!strcmp(argv[0], "show"))
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index c4380c7..0c956ba 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -328,4 +328,19 @@ test_expect_success 'reject adding remote with an invalid name' '
 
 '
 
+# The first three test if the tracking branches are properly renamed,
+# the last two ones check if the config is updated.
+
+test_expect_success 'rename a remote' '
+
+	git clone one four &&
+	(cd four &&
+	 git remote rename origin upstream &&
+	 rmdir .git/refs/remotes/origin &&
+	 test "$(git symbolic-ref refs/remotes/upstream/HEAD)" = "refs/remotes/upstream/master" &&
+	 test "$(git rev-parse upstream/master)" = "$(git rev-parse master)" &&
+	 test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/remotes/upstream/*" &&
+	 test "$(git config branch.master.remote)" = "upstream")
+
+'
 test_done
-- 
1.6.0.2
