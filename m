From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCHv3 1/2] config: add '--names-only' option to list only variable names
Date: Mon, 10 Aug 2015 11:46:06 +0200
Message-ID: <1439199967-9655-2-git-send-email-szeder@ira.uka.de>
References: <1439199967-9655-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 11:46:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjfI-0001Gm-ID
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548AbbHJJqj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2015 05:46:39 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:50849 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754652AbbHJJqi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 05:46:38 -0400
Received: from x590c3bfd.dyn.telefonica.de ([89.12.59.253] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1ZOjf6-0006Y1-KU; Mon, 10 Aug 2015 11:46:35 +0200
X-Mailer: git-send-email 2.5.0.245.gff6622b
In-Reply-To: <1439199967-9655-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1439199995.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275585>

'git config' can only show values or name-value pairs, so if a shell
script needs the names of set config variables it has to run 'git confi=
g
--list' or '--get-regexp' and parse the output to separate config
variable names from their values.  However, such a parsing can't cope
with multi-line values.  Though 'git config' can produce null-terminate=
d
output for newline-safe parsing, that's of no use in such a case, becas=
e
shells can't cope with null characters.

Even our own bash completion script suffers from these issues.

Help the completion script, and shell scripts in general, by introducin=
g
the '--names-only' option to modify the output of '--list' and
'--get-regexp' to list only the names of config variables, so they don'=
t
have to perform error-prone post processing to separate variable names
from their values anymore.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/git-config.txt           | 10 +++++++---
 builtin/config.c                       | 14 ++++++++++++--
 contrib/completion/git-completion.bash |  1 +
 t/t1300-repo-config.sh                 | 22 ++++++++++++++++++++++
 4 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.tx=
t
index 02ec096faa..ba76097c06 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -14,13 +14,13 @@ SYNOPSIS
 'git config' [<file-option>] [type] --replace-all name value [value_re=
gex]
 'git config' [<file-option>] [type] [-z|--null] --get name [value_rege=
x]
 'git config' [<file-option>] [type] [-z|--null] --get-all name [value_=
regex]
-'git config' [<file-option>] [type] [-z|--null] --get-regexp name_rege=
x [value_regex]
+'git config' [<file-option>] [type] [-z|--null] [--names-only] --get-r=
egexp name_regex [value_regex]
 'git config' [<file-option>] [type] [-z|--null] --get-urlmatch name UR=
L
 'git config' [<file-option>] --unset name [value_regex]
 'git config' [<file-option>] --unset-all name [value_regex]
 'git config' [<file-option>] --rename-section old_name new_name
 'git config' [<file-option>] --remove-section name
-'git config' [<file-option>] [-z|--null] -l | --list
+'git config' [<file-option>] [-z|--null] [--names-only] -l | --list
 'git config' [<file-option>] --get-color name [default]
 'git config' [<file-option>] --get-colorbool name [stdout-is-tty]
 'git config' [<file-option>] -e | --edit
@@ -159,7 +159,7 @@ See also <<FILES>>.
=20
 -l::
 --list::
-	List all variables set in config file.
+	List all variables set in config file, along with their values.
=20
 --bool::
 	'git config' will ensure that the output is "true" or "false"
@@ -190,6 +190,10 @@ See also <<FILES>>.
 	output without getting confused e.g. by values that
 	contain line breaks.
=20
+--names-only::
+	Output only the names of config variables for `--list` or
+	`--get-regexp`.
+
 --get-colorbool name [stdout-is-tty]::
=20
 	Find the color setting for `name` (e.g. `color.diff`) and output
diff --git a/builtin/config.c b/builtin/config.c
index 7188405f7e..307980ab50 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -13,6 +13,7 @@ static char *key;
 static regex_t *key_regexp;
 static regex_t *regexp;
 static int show_keys;
+static int omit_values;
 static int use_key_regexp;
 static int do_all;
 static int do_not_match;
@@ -78,6 +79,7 @@ static struct option builtin_config_options[] =3D {
 	OPT_BIT(0, "path", &types, N_("value is a path (file or directory nam=
e)"), TYPE_PATH),
 	OPT_GROUP(N_("Other")),
 	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")=
),
+	OPT_BOOL(0, "names-only", &omit_values, N_("names only")),
 	OPT_BOOL(0, "includes", &respect_includes, N_("respect include direct=
ives on lookup")),
 	OPT_END(),
 };
@@ -91,7 +93,7 @@ static void check_argc(int argc, int min, int max) {
=20
 static int show_all_config(const char *key_, const char *value_, void =
*cb)
 {
-	if (value_)
+	if (!omit_values && value_)
 		printf("%s%c%s%c", key_, delim, value_, term);
 	else
 		printf("%s%c", key_, term);
@@ -117,6 +119,10 @@ static int format_config(struct strbuf *buf, const=
 char *key_, const char *value
 		strbuf_addstr(buf, key_);
 		must_print_delim =3D 1;
 	}
+	if (omit_values) {
+		strbuf_addch(buf, term);
+		return 0;
+	}
 	if (types =3D=3D TYPE_INT)
 		sprintf(value, "%"PRId64,
 			git_config_int64(key_, value_ ? value_ : ""));
@@ -549,7 +555,11 @@ int cmd_config(int argc, const char **argv, const =
char *prefix)
 		default:
 			usage_with_options(builtin_config_usage, builtin_config_options);
 		}
-
+	if (omit_values &&
+	    !(actions =3D=3D ACTION_LIST || actions =3D=3D ACTION_GET_REGEXP)=
) {
+		error("--names-only is only applicable to --list or --get-regexp");
+		usage_with_options(builtin_config_usage, builtin_config_options);
+	}
 	if (actions =3D=3D ACTION_LIST) {
 		check_argc(argc, 0, 0);
 		if (git_config_with_options(show_all_config, NULL,
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index c97c648d7e..6eaab141e2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1887,6 +1887,7 @@ _git_config ()
 			--get --get-all --get-regexp
 			--add --unset --unset-all
 			--remove-section --rename-section
+			--names-only
 			"
 		return
 		;;
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 66dd28644f..97e9e76efc 100755
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
+test_expect_success '--names-only --list' '
+	git config --names-only --list >output &&
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
+test_expect_success '--names-only --get-regexp' '
+	git config --names-only --get-regexp in >output &&
+	test_cmp expect output
+'
+
+cat > expect << EOF
 wow2 for me
 wow4 for you
 EOF
--=20
2.5.0.245.gff6622b
