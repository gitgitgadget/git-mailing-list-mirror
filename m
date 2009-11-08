From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH] Teach the --all option to 'git fetch'
Date: Sun, 08 Nov 2009 09:34:45 +0100
Message-ID: <4AF682A5.5020500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 08 09:34:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N73Ee-0001s5-9h
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 09:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025AbZKHIeo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Nov 2009 03:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752860AbZKHIeo
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 03:34:44 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:7298 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbZKHIen (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 03:34:43 -0500
Received: by ey-out-2122.google.com with SMTP id 9so13752eyd.19
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 00:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=/Dar7d+WZb6IO1AMf9AgLoCc0U+9JClfrxZBPWShHJg=;
        b=i67O8Ksxc7p9WP/tSfWJ03jP3w0prgq2XWvu7eaY5FqU1Ee8GTQ3VVY2V1cnyecNKB
         FF78RMqTxI6Ix3D0BkrUb1ef1NYvMEolNcPWsYL58NY63WtOAt3LKNBG45S5x0853UW7
         V+dN9Y9jCeIlb9nGxkGxpw7TOUwjfR5fWqftc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=u/Vr1Q48qH40609IxgLdr0mKVo6grBl5BySTIFfBF1ow9C/FncOKUYlgoXt9L7jVRw
         IT8q4aVSfbO/Q5fB0i8vuqdH+xktGPaZLrFR3kLa+nLxDoi+/QmngxY5CAeWzJ6zsT2A
         xI3zt1CHP9SasmtPFtVzcv7se0NCHX4yJj1nU=
Received: by 10.213.0.216 with SMTP id 24mr1707592ebc.10.1257669287008;
        Sun, 08 Nov 2009 00:34:47 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 10sm3047455eyz.3.2009.11.08.00.34.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Nov 2009 00:34:46 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132388>

'git remote' is meant for managing remotes and 'git fetch' is meant
for actually fetching data from remote repositories. Therefore, it is
not logical that you must use 'git remote update' to fetch from
several repositories at once. (Junio called 'git remote update'
a "half-baked UI experiment that failed" in topic 130891 in Gmane.)

Add the --all option to 'git fetch', to tell it to attempt to fetch
from all remotes. (The configuration variable skipDefaultUpdate for
the remote will NOT be consulted.)

Other options except -v and -q are silently ignored.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
See=20

  http://thread.gmane.org/gmane.comp.version-control.git/130819/focus=3D=
130891

for a previous discussion.

My implementation is deliberately minimal:

* There is no way to configure that certain remotes should be skipped b=
y
  the --all option. I have never used skipDefaultUpdate with 'git remot=
e
  update'. If there is a real need for that feature, it can easily be a=
dded.
  (But it should not use the existing skipDefaultUpdate configuration
  variable, as the name does not make sense for 'git fetch --all'.)

* All options except -q and -v are silently ignored. It might be useful
  to support some more options if there is a real need for them.
  (Perhaps --keep or --no-tags?)

 Documentation/git-fetch.txt |    5 +++
 builtin-fetch.c             |   80 +++++++++++++++++++++++++++++++++++=
++-----
 t/t5514-fetch-all.sh        |   76 +++++++++++++++++++++++++++++++++++=
+++++
 3 files changed, 151 insertions(+), 10 deletions(-)
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
index a35a6f8..c1c3c46 100644
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
@@ -680,7 +683,53 @@ static void set_option(const char *name, const cha=
r *value)
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
+static int fetch_all(int argc)
+{
+	int i, result =3D 0;
+	struct string_list list =3D { NULL, 0, 0, 0 };
+	const char *argv[] =3D { "fetch", NULL, NULL, NULL, NULL };
+
+	if (argc =3D=3D 1)
+		die("fetch --all does not take a repository argument");
+	else if (argc > 1)
+		die("fetch --all does not make sense with refspecs");
+
+	argc =3D 1;
+	if (verbosity >=3D 2)
+		argv[argc++] =3D "-v";
+	if (verbosity >=3D 1)
+		argv[argc++] =3D "-v";
+	else if (verbosity < 0)
+		argv[argc++] =3D "-q";
+
+	result =3D for_each_remote(get_one_remote_for_fetch, &list);
+
+	for (i =3D 0; i < list.nr; i++) {
+		const char *name =3D list.items[i].string;
+		argv[argc] =3D name;
+		if (verbosity >=3D 0)
+			printf("Fetching %s\n", name);
+		if (run_command_v_opt(argv, RUN_GIT_CMD)) {
+			error("Could not fetch %s", name);
+			result =3D 1;
+		}
+	}
+
+	/* all names were strdup()ed or strndup()ed */
+	list.strdup_strings =3D 1;
+	string_list_clear(&list, 0);
+
+	return result;
+}
+
+static int fetch_one(int argc, const char **argv)
 {
 	struct remote *remote;
 	int i;
@@ -688,14 +737,6 @@ int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
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
 	if (argc =3D=3D 0)
 		remote =3D remote_get(NULL);
 	else
@@ -746,3 +787,22 @@ int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
 	transport =3D NULL;
 	return exit_code;
 }
+
+int cmd_fetch(int argc, const char **argv, const char *prefix)
+{
+	int i;
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
+		return fetch_all(argc);
+	} else {
+		return fetch_one(argc, argv);
+	}
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
