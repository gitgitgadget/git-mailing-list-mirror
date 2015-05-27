From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/2] config: add options to list only variable names
Date: Wed, 27 May 2015 22:07:19 +0200
Message-ID: <1432757240-4445-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 22:07:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxhcA-0006uj-Ly
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 22:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753650AbbE0UHl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2015 16:07:41 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:36898 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753635AbbE0UHk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2015 16:07:40 -0400
Received: from x590c2e9c.dyn.telefonica.de ([89.12.46.156] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1Yxhbw-0006X1-5n; Wed, 27 May 2015 22:07:34 +0200
X-Mailer: git-send-email 2.4.2.347.ge926c0d
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1432757254.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270077>

Recenty I created a multi-line branch description with '.' and '=3D'
characters on one of the lines, and noticed that fragments of that line
show up when completing set variable names for 'git config', e.g.:

  $ git config --get branch.b.description
  Branch description to fool the completion script with a
  second line containing dot . and equals =3D characters.
  $ git config --unset <TAB>
  ...
  second line containing dot . and equals
  ...

The completion script runs 'git config --list' and processes its output=
 to
strip the values and keep only the variable names.  It does so by looki=
ng
for lines containing '.' and '=3D' and outputting everything before the=
 '=3D',
which was fooled by my multi-line branch description.

A similar issue exists with aliases and pretty format aliases with
multi-line values, but in that case 'git config --get-regexp' is run an=
d
subsequent lines don't have to contain either '.' or '=3D' to fool the
completion script.

Though 'git config' can produce null-terminated output for newline-safe
parsing, that's of no use in this case, becase we can't cope with nulls=
 in
the shell.

Help the completion script by introducing the '--list-names' and
'--get-names-regexp' options, the "names-only" equivalents of '--list' =
and
'--get-regexp', so it doesn't have to separate variable names from thei=
r
values anymore.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/git-config.txt           | 10 +++++++++-
 builtin/config.c                       | 22 ++++++++++++++++++----
 contrib/completion/git-completion.bash |  4 ++--
 t/t1300-repo-config.sh                 | 22 ++++++++++++++++++++++
 4 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.tx=
t
index 02ec096..e0d27d5 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -16,11 +16,12 @@ SYNOPSIS
 'git config' [<file-option>] [type] [-z|--null] --get-all name [value_=
regex]
 'git config' [<file-option>] [type] [-z|--null] --get-regexp name_rege=
x [value_regex]
 'git config' [<file-option>] [type] [-z|--null] --get-urlmatch name UR=
L
+'git config' [<file-option>] [-z|--null] --get-name-regexp name_regex
 'git config' [<file-option>] --unset name [value_regex]
 'git config' [<file-option>] --unset-all name [value_regex]
 'git config' [<file-option>] --rename-section old_name new_name
 'git config' [<file-option>] --remove-section name
-'git config' [<file-option>] [-z|--null] -l | --list
+'git config' [<file-option>] [-z|--null] -l | --list | --list-name
 'git config' [<file-option>] --get-color name [default]
 'git config' [<file-option>] --get-colorbool name [stdout-is-tty]
 'git config' [<file-option>] -e | --edit
@@ -96,6 +97,10 @@ OPTIONS
 	in which section and variable names are lowercased, but subsection
 	names are not.
=20
+--get-name-regexp::
+	Like --get-regexp, but shows only matching variable names, not its
+	values.
+
 --get-urlmatch name URL::
 	When given a two-part name section.key, the value for
 	section.<url>.key whose <url> part matches the best to the
@@ -161,6 +166,9 @@ See also <<FILES>>.
 --list::
 	List all variables set in config file.
=20
+--list-name::
+	List the names of all variables set in config file.
+
 --bool::
 	'git config' will ensure that the output is "true" or "false"
=20
diff --git a/builtin/config.c b/builtin/config.c
index 7188405..38bcf83 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -13,6 +13,7 @@ static char *key;
 static regex_t *key_regexp;
 static regex_t *regexp;
 static int show_keys;
+static int show_only_keys;
 static int use_key_regexp;
 static int do_all;
 static int do_not_match;
@@ -43,6 +44,8 @@ static int respect_includes =3D -1;
 #define ACTION_GET_COLOR (1<<13)
 #define ACTION_GET_COLORBOOL (1<<14)
 #define ACTION_GET_URLMATCH (1<<15)
+#define ACTION_LIST_NAMES (1<<16)
+#define ACTION_GET_NAME_REGEXP (1<<17)
=20
 #define TYPE_BOOL (1<<0)
 #define TYPE_INT (1<<1)
@@ -60,6 +63,7 @@ static struct option builtin_config_options[] =3D {
 	OPT_BIT(0, "get", &actions, N_("get value: name [value-regex]"), ACTI=
ON_GET),
 	OPT_BIT(0, "get-all", &actions, N_("get all values: key [value-regex]=
"), ACTION_GET_ALL),
 	OPT_BIT(0, "get-regexp", &actions, N_("get values for regexp: name-re=
gex [value-regex]"), ACTION_GET_REGEXP),
+	OPT_BIT(0, "get-name-regexp", &actions, N_("get names for regexp: nam=
e-regex"), ACTION_GET_NAME_REGEXP),
 	OPT_BIT(0, "get-urlmatch", &actions, N_("get value specific for the U=
RL: section[.var] URL"), ACTION_GET_URLMATCH),
 	OPT_BIT(0, "replace-all", &actions, N_("replace all matching variable=
s: name value [value_regex]"), ACTION_REPLACE_ALL),
 	OPT_BIT(0, "add", &actions, N_("add a new variable: name value"), ACT=
ION_ADD),
@@ -68,6 +72,7 @@ static struct option builtin_config_options[] =3D {
 	OPT_BIT(0, "rename-section", &actions, N_("rename section: old-name n=
ew-name"), ACTION_RENAME_SECTION),
 	OPT_BIT(0, "remove-section", &actions, N_("remove a section: name"), =
ACTION_REMOVE_SECTION),
 	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
+	OPT_BIT(0, "list-names", &actions, N_("list all variable names"), ACT=
ION_LIST_NAMES),
 	OPT_BIT('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
 	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot=
 [default]"), ACTION_GET_COLOR),
 	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slo=
t [stdout-is-tty]"), ACTION_GET_COLORBOOL),
@@ -91,7 +96,7 @@ static void check_argc(int argc, int min, int max) {
=20
 static int show_all_config(const char *key_, const char *value_, void =
*cb)
 {
-	if (value_)
+	if (!show_only_keys && value_)
 		printf("%s%c%s%c", key_, delim, value_, term);
 	else
 		printf("%s%c", key_, term);
@@ -165,7 +170,14 @@ static int collect_config(const char *key_, const =
char *value_, void *cb)
=20
 	ALLOC_GROW(values->items, values->nr + 1, values->alloc);
=20
-	return format_config(&values->items[values->nr++], key_, value_);
+	if (show_only_keys) {
+		struct strbuf *buf =3D &values->items[values->nr++];
+		strbuf_init(buf, 0);
+		strbuf_addstr(buf, key_);
+		strbuf_addch(buf, term);
+		return 0;
+	} else
+		return format_config(&values->items[values->nr++], key_, value_);
 }
=20
 static int get_value(const char *key_, const char *regex_)
@@ -550,7 +562,8 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
 			usage_with_options(builtin_config_usage, builtin_config_options);
 		}
=20
-	if (actions =3D=3D ACTION_LIST) {
+	if (actions =3D=3D ACTION_LIST || actions =3D=3D ACTION_LIST_NAMES) {
+		show_only_keys =3D (actions =3D=3D ACTION_LIST_NAMES);
 		check_argc(argc, 0, 0);
 		if (git_config_with_options(show_all_config, NULL,
 					    &given_config_source,
@@ -631,8 +644,9 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
 		check_argc(argc, 1, 2);
 		return get_value(argv[0], argv[1]);
 	}
-	else if (actions =3D=3D ACTION_GET_REGEXP) {
+	else if (actions =3D=3D ACTION_GET_REGEXP || actions =3D=3D ACTION_GE=
T_NAME_REGEXP) {
 		show_keys =3D 1;
+		show_only_keys =3D (actions =3D=3D ACTION_GET_NAME_REGEXP);
 		use_key_regexp =3D 1;
 		do_all =3D 1;
 		check_argc(argc, 1, 2);
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index bfc74e9..6abbd56 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1883,8 +1883,8 @@ _git_config ()
 	--*)
 		__gitcomp "
 			--system --global --local --file=3D
-			--list --replace-all
-			--get --get-all --get-regexp
+			--list --list-names --replace-all
+			--get --get-all --get-regexp --get-name-regexp
 			--add --unset --unset-all
 			--remove-section --rename-section
 			"
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 66dd286..fa83944 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -353,6 +353,18 @@ test_expect_success '--list without repo produces =
empty output' '
 '
=20
 cat > expect << EOF
+beta.noindent
+nextsection.nonewline
+123456.a123
+version.1.2.3eX.alpha
+EOF
+
+test_expect_success 'working --list-names' '
+	git config --list-names > output &&
+	test_cmp expect output
+'
+
+cat > expect << EOF
 beta.noindent sillyValue
 nextsection.nonewline wow2 for me
 EOF
@@ -363,6 +375,16 @@ test_expect_success '--get-regexp' '
 '
=20
 cat > expect << EOF
+beta.noindent
+nextsection.nonewline
+EOF
+
+test_expect_success '--get-name-regexp' '
+	git config --get-name-regexp in >output &&
+	test_cmp expect output
+'
+
+cat > expect << EOF
 wow2 for me
 wow4 for you
 EOF
--=20
2.4.2.347.ge926c0d
