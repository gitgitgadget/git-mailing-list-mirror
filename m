From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH] remote: add new sync command
Date: Mon,  7 Nov 2011 18:07:12 +0200
Message-ID: <1320682032-12698-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 17:07:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNRjT-0000oj-74
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 17:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135Ab1KGQHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 11:07:30 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51884 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806Ab1KGQH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 11:07:29 -0500
Received: by bke11 with SMTP id 11so3731259bke.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 08:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=5cbEdgB0FS02Z+lkzxFzZfr0h/LgWklBwk5cpw0rbPo=;
        b=Tc2Xx5v1mATQeS9VhESBgicaqV99c/4JW5Qulvb/L6LfHEiyLov6Llsm72kFWXNVLR
         iEwxuNmEjaXvSbAi10avrgOiIXlpD5QBUJaUhPOkxUk1XEdozQXws+eGK1eKIlil1I+3
         tlzmVKFdW1oNJlRCV4gp3LQjWIV/jDQhJXfL8=
Received: by 10.204.156.133 with SMTP id x5mr19922608bkw.87.1320682047367;
        Mon, 07 Nov 2011 08:07:27 -0800 (PST)
Received: from localhost (cs27007082.pp.htv.fi. [89.27.7.82])
        by mx.google.com with ESMTPS id x14sm18020521bkf.10.2011.11.07.08.07.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 08:07:25 -0800 (PST)
X-Mailer: git-send-email 1.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184990>

This is useful to mirror all the branches in the current repo to
another.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-remote.txt |   17 +++++++
 builtin/remote.c             |  108 ++++++++++++++++++++++++++++++++++++++++++
 t/t5505-remote.sh            |   15 ++++++
 3 files changed, 140 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 5a8c506..643fc8b 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -21,6 +21,7 @@ SYNOPSIS
 'git remote' [-v | --verbose] 'show' [-n] <name>
 'git remote prune' [-n | --dry-run] <name>
 'git remote' [-v | --verbose] 'update' [-p | --prune] [(<group> | <remote>)...]
+'git remote sync' <name> [-a | --all] [-n | --new] [-p | --prune] [-f | --force] [--dry-run]
 
 DESCRIPTION
 -----------
@@ -169,6 +170,22 @@ be updated.  (See linkgit:git-config[1]).
 +
 With `--prune` option, prune all the remotes that are updated.
 
+'sync'::
+
+Synchronizes local branches with certain remote. This is useful to backup all
+the branches in a local repository to a remote one, regardless of what upstream
+is configured for each branch.
++
+With `--prune`, remote branches will be deleted if they are not also locally.
++
+With `--new`, local branches that are not yet in the remote will be pushed too.
++
+With `--all`, basically both `--prune` and `--new` will be selected.
++
+With `--force`, existing branches will be forced to update, like `git push
+--force`.
++
+With `--dry-run`, all the changes will be reported, but not really happen.
 
 DISCUSSION
 ----------
diff --git a/builtin/remote.c b/builtin/remote.c
index e1285be..b3b9b19 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -64,6 +64,11 @@ static const char * const builtin_remote_update_usage[] = {
 	NULL
 };
 
+static const char * const builtin_remote_sync_usage[] = {
+	"git remote sync <name> [-a|--all] [-n|--new] [-p|--prune] [<options>]",
+	NULL
+};
+
 static const char * const builtin_remote_seturl_usage[] = {
 	"git remote set-url [--push] <name> <newurl> [<oldurl>]",
 	"git remote set-url --add <name> <newurl>",
@@ -1492,6 +1497,107 @@ static int set_url(int argc, const char **argv)
 	return 0;
 }
 
+struct action {
+	struct string_list *list;
+	int type;
+};
+
+static int ref_cb(const char *refname,
+	const unsigned char *sha1, int flags, void *cb_data)
+{
+	struct action *action = cb_data;
+	struct string_list_item *item;
+	if (strcmp(refname, "HEAD") == 0)
+		return 0;
+	item = string_list_insert(action->list, refname);
+	item->util = (void *)((long)item->util | action->type);
+	return 0;
+}
+
+static int for_each_in_remote_ref(const char *name, each_ref_fn fn, void *cb_data)
+{
+	char prefix[1000];
+	sprintf(prefix, "refs/remotes/%s/", name);
+	return for_each_ref_in(prefix, fn, cb_data);
+}
+
+static int do_sync(int argc, const char **argv)
+{
+	const char *remotename;
+	struct string_list list;
+	struct action action;
+	struct remote *remote;
+	struct transport *transport;
+	int i, r, nonff;
+	char **refspec;
+	int refspec_nr = 0;
+	int prune = 0, new = 0, all = 0, flags = 0;
+
+	struct option options[] = {
+		OPT_BOOLEAN('p', "prune", &prune, "prune remote branches"),
+		OPT_BOOLEAN('n', "new", &new, "push new branches"),
+		OPT_BOOLEAN('a', "all", &all, "synchronize everything"),
+		OPT_BIT(0, "dry-run", &flags, "dry run", TRANSPORT_PUSH_DRY_RUN),
+		OPT_BIT('f', "force", &flags, "force updates", TRANSPORT_PUSH_FORCE),
+		OPT_END()
+	};
+	argc = parse_options(argc, argv, NULL, options, builtin_remote_sync_usage,
+			     PARSE_OPT_KEEP_ARGV0);
+	if (argc < 2 || argc > 2)
+		usage_with_options(builtin_remote_sync_usage, options);
+
+	if (all)
+		prune = new = 1;
+
+	remotename = argv[1];
+	if (!remote_is_configured(remotename))
+		die("No such remote '%s'", remotename);
+
+	memset(&list, 0, sizeof(list));
+
+	action.list = &list;
+
+	action.type = 1;
+	for_each_in_remote_ref(remotename, ref_cb, &action);
+
+	action.type = 2;
+	for_each_branch_ref(ref_cb, &action);
+
+	refspec = xmalloc(sizeof(*refspec) * list.nr);
+
+	for (i = 0; i < list.nr; i++) {
+		const char *str = list.items[i].string;
+		char *t = NULL;
+
+		switch ((long)list.items[i].util) {
+		case 1:
+			if (prune)
+				asprintf(&t, ":%s", str);
+			break;
+		case 2:
+			if (new)
+				t = strdup(str);
+			break;
+		case 3:
+			t = strdup(str);
+			break;
+		}
+		if (t)
+			refspec[refspec_nr++] = t;
+	}
+
+	remote = remote_get(remotename);
+	transport = transport_get(remote, NULL);
+	r = transport_push(transport, refspec_nr, (const char **)refspec, flags, &nonff);
+
+	for (i = 0; i < refspec_nr; i++)
+		free(refspec[i]);
+
+	string_list_clear(&list, 0);
+
+	return r;
+}
+
 static int get_one_entry(struct remote *remote, void *priv)
 {
 	struct string_list *list = priv;
@@ -1581,6 +1687,8 @@ int cmd_remote(int argc, const char **argv, const char *prefix)
 		result = prune(argc, argv);
 	else if (!strcmp(argv[0], "update"))
 		result = update(argc, argv);
+	else if (!strcmp(argv[0], "sync"))
+		result = do_sync(argc, argv);
 	else {
 		error("Unknown subcommand: %s", argv[0]);
 		usage_with_options(builtin_remote_usage, options);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index e8af615..13378c5 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -997,4 +997,19 @@ test_expect_success 'remote set-url --delete baz' '
 	cmp expect actual
 '
 
+test_expect_success 'remote sync' '
+	setup_repository sync-origin &&
+	(cd sync-origin &&
+	 git branch another &&
+	 git config receive.denyCurrentBranch ignore) &&
+	git clone sync-origin sync &&
+	(cd sync &&
+	 git branch -a > /tmp/a &&
+	 git remote sync origin &&
+	 git commit --allow-empty -m "Test" &&
+	 git checkout side &&
+	 git commit --allow-empty -m "Test" &&
+	 git remote sync -a origin)
+'
+
 test_done
-- 
1.7.7
