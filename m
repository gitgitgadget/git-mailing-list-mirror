From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 1/5] Teach the --all option to 'git fetch'
Date: Mon, 09 Nov 2009 21:09:56 +0100
Message-ID: <4AF87714.9050606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 09 21:10:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7aYx-00083q-7B
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 21:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753781AbZKIUJz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Nov 2009 15:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753681AbZKIUJz
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 15:09:55 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:52529 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334AbZKIUJy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 15:09:54 -0500
Received: by ewy3 with SMTP id 3so3511647ewy.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 12:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=z+ay+fP/KhssdKp8VE0xBRJTqNUxgRKed924Dbq/nAI=;
        b=BiFhjVGHfxPGocoWOthHO0bUXQMiNQidihWk2BP1ZpPrFhV/Kz3d9ohsSUh0u1LInX
         Lv7YuG6YuXhz+vrQOTy+IYKCFAqJcT4eFKK5oizv8VBT8AP+m6pAf+AKVk8FTmTSMKsb
         sxEUbXO6gyumGjzkW5krKDjQqxZs0f4GNQ0aI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=TPkGdNwMgfZEmenL5BRNS0/ST3/wDD6C5L1J0FglbVrexBUcbyz3rI1Ar5UBM8TpWY
         RQhWEaMcIyu77w/1yh5jgc2Pc9URdA83wclZpWmEOo+6MYdHZKTXIAjyA7AkKGs4xpfM
         BPWjgKdVEuLCCm534Q9BV9REeYEtyHn2/K44w=
Received: by 10.213.0.138 with SMTP id 10mr9542299ebb.56.1257797398572;
        Mon, 09 Nov 2009 12:09:58 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 5sm76599eyh.10.2009.11.09.12.09.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 12:09:57 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132514>

'git remote' is meant for managing remotes and 'git fetch' is meant
for actually fetching data from remote repositories. Therefore, it is
not logical that you must use 'git remote update' to fetch from
more than one repository at once.

Add the --all option to 'git fetch', to tell it to attempt to fetch
from all remotes. Also, if --all is not given, the <repository>
argument is allowed to be the name of a group, to allow fetching
from all repositories in the group.

Other options except -v and -q are silently ignored.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 Documentation/fetch-options.txt    |    3 +
 Documentation/git-fetch.txt        |   12 +++-
 Documentation/pull-fetch-param.txt |    7 ++
 builtin-fetch.c                    |  150 ++++++++++++++++++++++++++++=
+++----
 t/t5506-remote-groups.sh           |   21 +++++-
 t/t5514-fetch-multiple.sh          |   76 ++++++++++++++++++
 6 files changed, 247 insertions(+), 22 deletions(-)
 create mode 100755 t/t5514-fetch-multiple.sh

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
index 2886874..93d73c3 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -1,3 +1,6 @@
+--all::
+	Fetch all remotes.
+
 -a::
 --append::
 	Append ref names and object names of fetched refs to the
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index f2483d6..3616466 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -10,11 +10,15 @@ SYNOPSIS
 --------
 'git fetch' <options> <repository> <refspec>...
=20
+'git fetch' <options> <group>
+
+'git fetch' --all <options>
+
=20
 DESCRIPTION
 -----------
-Fetches named heads or tags from another repository, along with
-the objects necessary to complete them.
+Fetches named heads or tags from one or more other repositories,
+along with the objects necessary to complete them.
=20
 The ref names and their object names of fetched refs are stored
 in `.git/FETCH_HEAD`.  This information is left for a later merge
@@ -28,6 +32,10 @@ pointed by remote tags that it does not yet have, th=
en fetch
 those missing tags.  If the other end has tags that point at
 branches you are not interested in, you will not get them.
=20
+'git fetch' can fetch from either a single named repository, or
+or from several repositories at once if <group> is given and
+there is a remotes.<group> entry in the configuration file.
+(See linkgit:git-config[1]).
=20
 OPTIONS
 -------
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fe=
tch-param.txt
index f9811f2..712b91a 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -4,6 +4,13 @@
 	(see the section <<URLS,GIT URLS>> below) or the name
 	of a remote (see the section <<REMOTES,REMOTES>> below).
=20
+ifndef::git-pull[]
+<group>::
+	A name referring to a list of repositories as the value
+	of remotes.<group> in the configuration file.
+	(See linkgit:git-config[1]).
+endif::git-pull[]
+
 <refspec>::
 	The format of a <refspec> parameter is an optional plus
 	`{plus}`, followed by the source ref <src>, followed
diff --git a/builtin-fetch.c b/builtin-fetch.c
index a35a6f8..2bf51cc 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -14,6 +14,8 @@
=20
 static const char * const builtin_fetch_usage[] =3D {
 	"git fetch [options] [<repository> <refspec>...]",
+	"git fetch [options] <group>",
+	"git fetch --all [options]",
 	NULL
 };
=20
@@ -23,7 +25,7 @@ enum {
 	TAGS_SET =3D 2
 };
=20
-static int append, force, keep, update_head_ok, verbosity;
+static int all, append, force, keep, update_head_ok, verbosity;
 static int tags =3D TAGS_DEFAULT;
 static const char *depth;
 static const char *upload_pack;
@@ -32,6 +34,8 @@ static struct transport *transport;
=20
 static struct option builtin_fetch_options[] =3D {
 	OPT__VERBOSITY(&verbosity),
+	OPT_BOOLEAN(0, "all", &all,
+		    "fetch from all remotes"),
 	OPT_BOOLEAN('a', "append", &append,
 		    "append to .git/FETCH_HEAD instead of overwriting"),
 	OPT_STRING(0, "upload-pack", &upload_pack, "PATH",
@@ -680,27 +684,89 @@ static void set_option(const char *name, const ch=
ar *value)
 			name, transport->url);
 }
=20
-int cmd_fetch(int argc, const char **argv, const char *prefix)
+static int get_one_remote_for_fetch(struct remote *remote, void *priv)
+{
+	struct string_list *list =3D priv;
+	string_list_append(remote->name, list);
+	return 0;
+}
+
+struct remote_group_data {
+	const char *name;
+	struct string_list *list;
+};
+
+static int get_remote_group(const char *key, const char *value, void *=
priv)
+{
+	struct remote_group_data *g =3D priv;
+
+	if (!prefixcmp(key, "remotes.") &&
+			!strcmp(key + 8, g->name)) {
+		/* split list by white space */
+		int space =3D strcspn(value, " \t\n");
+		while (*value) {
+			if (space > 1) {
+				string_list_append(xstrndup(value, space),
+						   g->list);
+			}
+			value +=3D space + (value[space] !=3D '\0');
+			space =3D strcspn(value, " \t\n");
+		}
+	}
+
+	return 0;
+}
+
+static int add_remote_or_group(const char *name, struct string_list *l=
ist)
+{
+	int prev_nr =3D list->nr;
+	struct remote_group_data g =3D { name, list };
+
+	git_config(get_remote_group, &g);
+	if (list->nr =3D=3D prev_nr) {
+		struct remote *remote;
+		if (!remote_is_configured(name))
+			return 0;
+		remote =3D remote_get(name);
+		string_list_append(remote->name, list);
+	}
+	return 1;
+}
+
+static int fetch_multiple(struct string_list *list)
+{
+	int i, result =3D 0;
+	const char *argv[] =3D { "fetch", NULL, NULL, NULL, NULL };
+	int argc =3D 1;
+
+	if (verbosity >=3D 2)
+		argv[argc++] =3D "-v";
+	if (verbosity >=3D 1)
+		argv[argc++] =3D "-v";
+	else if (verbosity < 0)
+		argv[argc++] =3D "-q";
+
+	for (i =3D 0; i < list->nr; i++) {
+		const char *name =3D list->items[i].string;
+		argv[argc] =3D name;
+		if (verbosity >=3D 0)
+			printf("Fetching %s\n", name);
+		if (run_command_v_opt(argv, RUN_GIT_CMD)) {
+			error("Could not fetch %s", name);
+			result =3D 1;
+		}
+	}
+
+	return result;
+}
+
+static int fetch_one(struct remote *remote, int argc, const char **arg=
v)
 {
-	struct remote *remote;
 	int i;
 	static const char **refs =3D NULL;
 	int ref_nr =3D 0;
 	int exit_code;
=20
-	/* Record the command line for the reflog */
-	strbuf_addstr(&default_rla, "fetch");
-	for (i =3D 1; i < argc; i++)
-		strbuf_addf(&default_rla, " %s", argv[i]);
-
-	argc =3D parse_options(argc, argv, prefix,
-			     builtin_fetch_options, builtin_fetch_usage, 0);
-
-	if (argc =3D=3D 0)
-		remote =3D remote_get(NULL);
-	else
-		remote =3D remote_get(argv[0]);
-
 	if (!remote)
 		die("Where do you want to fetch from today?");
=20
@@ -716,10 +782,10 @@ int cmd_fetch(int argc, const char **argv, const =
char *prefix)
 	if (depth)
 		set_option(TRANS_OPT_DEPTH, depth);
=20
-	if (argc > 1) {
+	if (argc > 0) {
 		int j =3D 0;
 		refs =3D xcalloc(argc + 1, sizeof(const char *));
-		for (i =3D 1; i < argc; i++) {
+		for (i =3D 0; i < argc; i++) {
 			if (!strcmp(argv[i], "tag")) {
 				char *ref;
 				i++;
@@ -746,3 +812,51 @@ int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
 	transport =3D NULL;
 	return exit_code;
 }
+
+int cmd_fetch(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	struct string_list list =3D { NULL, 0, 0, 0 };
+	struct remote *remote;
+	int result =3D 0;
+
+	/* Record the command line for the reflog */
+	strbuf_addstr(&default_rla, "fetch");
+	for (i =3D 1; i < argc; i++)
+		strbuf_addf(&default_rla, " %s", argv[i]);
+
+	argc =3D parse_options(argc, argv, prefix,
+			     builtin_fetch_options, builtin_fetch_usage, 0);
+
+	if (all) {
+		if (argc =3D=3D 1)
+			die("fetch --all does not take a repository argument");
+		else if (argc > 1)
+			die("fetch --all does not make sense with refspecs");
+		(void) for_each_remote(get_one_remote_for_fetch, &list);
+		result =3D fetch_multiple(&list);
+	} else if (argc =3D=3D 0) {
+		/* No arguments -- use default remote */
+		remote =3D remote_get(NULL);
+		result =3D fetch_one(remote, argc, argv);
+	} else {
+		/* Single remote or group */
+		(void) add_remote_or_group(argv[0], &list);
+		if (list.nr > 1) {
+			/* More than one remote */
+			if (argc > 1)
+				die("Fetching a group and specifying refspecs does not make sense"=
);
+			result =3D fetch_multiple(&list);
+		} else {
+			/* Zero or one remotes */
+			remote =3D remote_get(argv[0]);
+			result =3D fetch_one(remote, argc-1, argv+1);
+		}
+	}
+
+	/* All names were strdup()ed or strndup()ed */
+	list.strdup_strings =3D 1;
+	string_list_clear(&list, 0);
+
+	return result;
+}
diff --git a/t/t5506-remote-groups.sh b/t/t5506-remote-groups.sh
index 2a1806b..b7b7dda 100755
--- a/t/t5506-remote-groups.sh
+++ b/t/t5506-remote-groups.sh
@@ -51,7 +51,7 @@ test_expect_success 'nonexistant group produces error=
' '
 	! repo_fetched two
 '
=20
-test_expect_success 'updating group updates all members' '
+test_expect_success 'updating group updates all members (remote update=
)' '
 	mark group-all &&
 	update_repos &&
 	git config --add remotes.all one &&
@@ -61,7 +61,15 @@ test_expect_success 'updating group updates all memb=
ers' '
 	repo_fetched two
 '
=20
-test_expect_success 'updating group does not update non-members' '
+test_expect_success 'updating group updates all members (fetch)' '
+	mark fetch-group-all &&
+	update_repos &&
+	git fetch all &&
+	repo_fetched one &&
+	repo_fetched two
+'
+
+test_expect_success 'updating group does not update non-members (remot=
e update)' '
 	mark group-some &&
 	update_repos &&
 	git config --add remotes.some one &&
@@ -70,6 +78,15 @@ test_expect_success 'updating group does not update =
non-members' '
 	! repo_fetched two
 '
=20
+test_expect_success 'updating group does not update non-members (fetch=
)' '
+	mark fetch-group-some &&
+	update_repos &&
+	git config --add remotes.some one &&
+	git remote update some &&
+	repo_fetched one &&
+	! repo_fetched two
+'
+
 test_expect_success 'updating remote name updates that remote' '
 	mark remote-name &&
 	update_repos &&
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
new file mode 100755
index 0000000..25244bf
--- /dev/null
+++ b/t/t5514-fetch-multiple.sh
@@ -0,0 +1,76 @@
+#!/bin/sh
+
+test_description=3D'fetch --all works correctly'
+
+. ./test-lib.sh
+
+setup_repository () {
+	mkdir "$1" && (
+	cd "$1" &&
+	git init &&
+	>file &&
+	git add file &&
+	test_tick &&
+	git commit -m "Initial" &&
+	git checkout -b side &&
+	>elif &&
+	git add elif &&
+	test_tick &&
+	git commit -m "Second" &&
+	git checkout master
+	)
+}
+
+test_expect_success setup '
+	setup_repository one &&
+	setup_repository two &&
+	(
+		cd two && git branch another
+	) &&
+	git clone --mirror two three
+	git clone one test
+'
+
+cat > test/expect << EOF
+  one/master
+  one/side
+  origin/HEAD -> origin/master
+  origin/master
+  origin/side
+  three/another
+  three/master
+  three/side
+  two/another
+  two/master
+  two/side
+EOF
+
+test_expect_success 'git fetch --all' '
+	(cd test &&
+	 git remote add one ../one &&
+	 git remote add two ../two &&
+	 git remote add three ../three &&
+	 git fetch --all &&
+	 git branch -r > output &&
+	 test_cmp expect output)
+'
+
+test_expect_success 'git fetch --all should continue if a remote has e=
rrors' '
+	(git clone one test2 &&
+	 cd test2 &&
+	 git remote add bad ../non-existing &&
+	 git remote add one ../one &&
+	 git remote add two ../two &&
+	 git remote add three ../three &&
+	 test_must_fail git fetch --all &&
+	 git branch -r > output &&
+	 test_cmp ../test/expect output)
+'
+
+test_expect_success 'git fetch --all does not allow non-option argumen=
ts' '
+	(cd test &&
+	 test_must_fail git fetch --all origin &&
+	 test_must_fail git fetch --all origin master)
+'
+
+test_done
--=20
1.6.5.1.69.g36942
