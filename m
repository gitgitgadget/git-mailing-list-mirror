From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH] tag: support configuring --sort via .gitconfig
Date: Wed,  9 Jul 2014 14:21:00 -0700
Message-ID: <1404940860-4004-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 23:21:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4zJD-0007bE-Ev
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 23:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756090AbaGIVVn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 17:21:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:62506 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755850AbaGIVVl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 17:21:41 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 09 Jul 2014 14:16:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,633,1400050800"; 
   d="scan'208,217";a="570805203"
Received: from jekeller-desk1.jf.intel.com (HELO jekeller-desk1.amr.corp.intel.com) ([134.134.173.156])
  by orsmga002.jf.intel.com with ESMTP; 09 Jul 2014 14:21:20 -0700
X-Mailer: git-send-email 2.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253153>

Add support for configuring default sort ordering for git tags. Command
line option will override this configured value, using the exact same
syntax.

Cc: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Documentation/config.txt  |  7 +++++++
 Documentation/git-tag.txt |  3 ++-
 builtin/tag.c             | 47 +++++++++++++++++++++++++++++++++++++++=
+-------
 t/t7004-tag.sh            | 21 +++++++++++++++++++++
 4 files changed, 70 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1d718bdb9662..0152582445b0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2354,6 +2354,13 @@ submodule.<name>.ignore::
 	"--ignore-submodules" option. The 'git submodule' commands are not
 	affected by this setting.
=20
+tag.sort::
+	This variable is used to control the sort ordering of tags when
+	displayed via linkgit:git-tag[5]. The current supported types are
+	"refname" for lexicographic order (default) or "version:refname" or
+	"v:refname" for tag names treated as versions. You may prepend a "-" =
to
+	reverse the sort ordering.
+
 tar.umask::
 	This variable can be used to restrict the permission bits of
 	tar archive entries.  The default is 0002, which turns off the
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index b424a1bc48bb..b338260f9f63 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -99,7 +99,7 @@ OPTIONS
 	Sort in a specific order. Supported type is "refname"
 	(lexicographic order), "version:refname" or "v:refname" (tag
 	names are treated as versions). Prepend "-" to reverse sort
-	order.
+	order. See configuration variable tag.sort for more details.
=20
 --column[=3D<options>]::
 --no-column::
@@ -317,6 +317,7 @@ include::date-formats.txt[]
 SEE ALSO
 --------
 linkgit:git-check-ref-format[1].
+linkgit:git-config[1].
=20
 GIT
 ---
diff --git a/builtin/tag.c b/builtin/tag.c
index ef765563388c..e8ada8b716ee 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -18,6 +18,8 @@
 #include "sha1-array.h"
 #include "column.h"
=20
+static char *configured_tag_sort;
+
 static const char * const git_tag_usage[] =3D {
 	N_("git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [=
<head>]"),
 	N_("git tag -d <tagname>..."),
@@ -346,9 +348,28 @@ static const char tag_template_nocleanup[] =3D
 	"Lines starting with '%c' will be kept; you may remove them"
 	" yourself if you want to.\n");
=20
+static void set_configured_tag_sort(const char *key)
+{
+	free(configured_tag_sort);
+	configured_tag_sort =3D xstrdup(key);
+}
+
+static const char *get_configured_tag_sort(void)
+{
+	if (configured_tag_sort)
+		return configured_tag_sort;
+	return "refname";
+}
+
 static int git_tag_config(const char *var, const char *value, void *cb=
)
 {
-	int status =3D git_gpg_config(var, value, cb);
+	int status;
+
+	if (!strcmp(var, "tag.sort")) {
+		set_configured_tag_sort(value);
+	}
+
+	status =3D git_gpg_config(var, value, cb);
 	if (status)
 		return status;
 	if (starts_with(var, "column."))
@@ -519,9 +540,9 @@ static int parse_opt_points_at(const struct option =
*opt __attribute__((unused)),
 	return 0;
 }
=20
-static int parse_opt_sort(const struct option *opt, const char *arg, i=
nt unset)
+static int parse_sort_string(const char *arg)
 {
-	int *sort =3D opt->value;
+	int sort =3D 0;
 	int flags =3D 0;
=20
 	if (*arg =3D=3D '-') {
@@ -529,16 +550,26 @@ static int parse_opt_sort(const struct option *op=
t, const char *arg, int unset)
 		arg++;
 	}
 	if (starts_with(arg, "version:")) {
-		*sort =3D VERCMP_SORT;
+		sort =3D VERCMP_SORT;
 		arg +=3D 8;
 	} else if (starts_with(arg, "v:")) {
-		*sort =3D VERCMP_SORT;
+		sort =3D VERCMP_SORT;
 		arg +=3D 2;
 	} else
-		*sort =3D STRCMP_SORT;
+		sort =3D STRCMP_SORT;
 	if (strcmp(arg, "refname"))
 		die(_("unsupported sort specification %s"), arg);
-	*sort |=3D flags;
+	sort |=3D flags;
+
+	return sort;
+}
+
+static int parse_opt_sort(const struct option *opt, const char *arg, i=
nt unset)
+{
+	int *sort =3D opt->value;
+
+	*sort =3D parse_sort_string(arg);
+
 	return 0;
 }
=20
@@ -606,6 +637,8 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
=20
 	memset(&opt, 0, sizeof(opt));
=20
+	sort =3D parse_sort_string(get_configured_tag_sort());
+
 	argc =3D parse_options(argc, argv, prefix, options, git_tag_usage, 0)=
;
=20
 	if (keyid) {
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index e4ab0f5b6419..1e8300f6ed7c 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1423,6 +1423,27 @@ EOF
 	test_cmp expect actual
 '
=20
+test_expect_success 'configured lexical sort' '
+	git config tag.sort "v:refname" &&
+	git tag -l "foo*" >actual &&
+	cat >expect <<EOF &&
+foo1.3
+foo1.6
+foo1.10
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'option override configured sort' '
+	git tag -l --sort=3D-refname "foo*" >actual &&
+	cat >expect <<EOF &&
+foo1.6
+foo1.3
+foo1.10
+EOF
+	test_cmp expect actual
+'
+
 run_with_limited_stack () {
 	(ulimit -s 64 && "$@")
 }
--=20
2.0.0
