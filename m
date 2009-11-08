From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [RFC/PATCH 1/4] Teach the --all option to 'git fetch'
Date: Sun, 08 Nov 2009 16:45:42 +0100
Message-ID: <4AF6E7A6.5060209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 08 16:45:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N79xe-00022K-Ke
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 16:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940AbZKHPpm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Nov 2009 10:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753901AbZKHPpm
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 10:45:42 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:46659 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbZKHPpk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 10:45:40 -0500
Received: by ewy3 with SMTP id 3so2429578ewy.37
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 07:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=j6XtnoXLxXZGf4VY8jJiamQSTQY8ug36ff5neUmKjuk=;
        b=EF05q9r/APs/MhG0NH6UGEp7OhkTgFghmdR6ANcuGZMAiT0d6eTYOD/xjNtGyQk6op
         l6Ioxc6ibmw4gLBnn0K4xNyq7n/qt0VNQnpRc9r+1/xtSD962U+r9SxuGh89MdGWU6dH
         P8sgCFA4UEDkfOqLtCgGWg1oBRzFsJPvtpoP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=qrUo90bcl6IrqKcxlXMP85mgYI2d/O0PBDqoUve52yF/t9dJ8pC3BkSBP5cCrVelCy
         JwOHVtN+ssajDrhMiFsKqVT4alp4SYN77pmtmxd0LMHxkCo84a4Xap4cUQgEtwQiVgKx
         ezg8EAS2+RPZi6VwiPvTyu9hZJ4ojdY3Lp5Pk=
Received: by 10.213.0.198 with SMTP id 6mr2017099ebc.84.1257695143743;
        Sun, 08 Nov 2009 07:45:43 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 10sm3824480eyz.3.2009.11.08.07.45.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Nov 2009 07:45:43 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132404>

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
 Documentation/git-fetch.txt |    5 ++
 builtin-fetch.c             |  149 +++++++++++++++++++++++++++++++++++=
++-----
 t/t5514-fetch-all.sh        |   76 ++++++++++++++++++++++
 3 files changed, 212 insertions(+), 18 deletions(-)
 create mode 100755 t/t5514-fetch-all.sh

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index f2483d6..9172454 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -10,6 +10,8 @@ SYNOPSIS
 --------
 'git fetch' <options> <repository> <refspec>...
=20
+'git fetch' --all <options>
+
=20
 DESCRIPTION
 -----------
@@ -31,6 +33,9 @@ branches you are not interested in, you will not get =
them.
=20
 OPTIONS
 -------
+--all::
+	Fetch all remotes.
+
 include::fetch-options.txt[]
=20
 include::pull-fetch-param.txt[]
diff --git a/builtin-fetch.c b/builtin-fetch.c
index a35a6f8..a520c1b 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -14,6 +14,7 @@
=20
 static const char * const builtin_fetch_usage[] =3D {
 	"git fetch [options] [<repository> <refspec>...]",
+	"git fetch --all [options]",
 	NULL
 };
=20
@@ -23,7 +24,7 @@ enum {
 	TAGS_SET =3D 2
 };
=20
-static int append, force, keep, update_head_ok, verbosity;
+static int all, append, force, keep, update_head_ok, verbosity;
 static int tags =3D TAGS_DEFAULT;
 static const char *depth;
 static const char *upload_pack;
@@ -32,6 +33,8 @@ static struct transport *transport;
=20
 static struct option builtin_fetch_options[] =3D {
 	OPT__VERBOSITY(&verbosity),
+	OPT_BOOLEAN(0, "all", &all,
+		    "fetch from all remotes"),
 	OPT_BOOLEAN('a', "append", &append,
 		    "append to .git/FETCH_HEAD instead of overwriting"),
 	OPT_STRING(0, "upload-pack", &upload_pack, "PATH",
@@ -680,27 +683,89 @@ static void set_option(const char *name, const ch=
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
@@ -716,10 +781,10 @@ int cmd_fetch(int argc, const char **argv, const =
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
@@ -746,3 +811,51 @@ int cmd_fetch(int argc, const char **argv, const c=
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
diff --git a/t/t5514-fetch-all.sh b/t/t5514-fetch-all.sh
new file mode 100755
index 0000000..25244bf
--- /dev/null
+++ b/t/t5514-fetch-all.sh
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
