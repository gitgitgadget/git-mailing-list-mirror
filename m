From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH 1/2] Allow passing of configuration parameters in the
	command line
Date: Fri, 26 Mar 2010 23:53:57 +0100
Message-ID: <20100326225356.GA6797@blimp.localdomain>
References: <7v7hp1kzbn.fsf@alter.siamese.dyndns.org> <fcaeb9bf1003250811g777b2881l332e6f61456d699@mail.gmail.com> <25yNvbuAivZlBuEJoRhXtfoEc7HEZorM5qOrwgQKk7FER_fdzljyMQ@cipher.nrlssc.navy.mil> <81b0412b1003251611h62222eabw247ec59678c198ad@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Mar 26 23:54:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvIPw-0005Ud-04
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 23:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462Ab0CZWyK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Mar 2010 18:54:10 -0400
Received: from mout3.freenet.de ([195.4.92.93]:49337 "EHLO mout3.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751807Ab0CZWyI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 18:54:08 -0400
Received: from [195.4.92.24] (helo=14.mx.freenet.de)
	by mout3.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.72 #2)
	id 1NvIPh-0005vK-F5; Fri, 26 Mar 2010 23:54:01 +0100
Received: from p57b1a08b.dip0.t-ipconnect.de ([87.177.160.139]:57192 helo=tigra.home)
	by 14.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.72 #2)
	id 1NvIPh-0000Tx-1l; Fri, 26 Mar 2010 23:54:01 +0100
Received: from blimp.localdomain (blimp.home [192.168.0.79])
	by tigra.home (Postfix) with ESMTP id A262A277DF;
	Fri, 26 Mar 2010 23:53:57 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 283D836D28; Fri, 26 Mar 2010 23:53:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <81b0412b1003251611h62222eabw247ec59678c198ad@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143293>

The values passed this way will override whatever is defined
in the config files.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

I replaced strndup with xstrndup, and calloc with xcalloc. A common wor=
karound
for broken flexarray support has got a small hint, and that typo got fi=
xed
too. A test for CamelCase config key added.

This patch replaces the one I sent earlier.

Alex Riesen, Fri, Mar 26, 2010 00:11:51 +0100:
> On Thu, Mar 25, 2010 at 17:27, Brandon Casey
> <brandon.casey.ctr@nrlssc.navy.mil> wrote:
> > On 03/25/2010 10:11 AM, Nguyen Thai Ngoc Duy wrote:
> >> 2010/3/25 Junio C Hamano <gitster@pobox.com>:
> >>> * ar/config-from-command-line (2010-03-19) 1 commit
> >>> =A0- Allow passing of configuration parameters in the command lin=
e
> >> This breaks my build on Solaris because it uses strndup, which is =
not available.
> >
> > A quick glance at ar/config-from.. also detected an unchecked callo=
c().
> >
> > Alex, any reason xcalloc wasn't used?
>=20
> Just missed it. Long time away from Git sources.
>=20

Done.

> > Would the code be simpler if strbufs were used? =A0Then you wouldn'=
t need to duplicate
> > the skip_space and trailing_space functionality provided in the str=
buf library, and
> > would just need a new function named strbuf_tolower.
>=20
> But this indeed makes sense. Promise to take a look at it after some =
sleep.

Done, but... It does make the code more readable, but I don't like strb=
uf
anymore. It has grown ugly. A lot of allocations, reallocations and cop=
ying
around. It may be efficient, but I found it hard to convince myself tha=
t it
is. And it should fragment heap a lot (doesn't matter much in this part=
icular
case but it may be an issue somewhere. Not all heaps are as robust as g=
libc's
one).

This patch is separate, and I didn't strbuf_tolower thing: the only oth=
er place
in whole project which lowcases a string is in mailmap, and doesn't loo=
k like
it can profit from conversion to strbuf (just look for tolower in mailm=
ap.c).

> > Also, should config_parametes_tail be spelled config_parameters_tai=
l?
>=20

Done

 Documentation/git.txt  |    7 +++++
 builtin/config.c       |    6 +++-
 cache.h                |    2 +
 config.c               |   71 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 git.c                  |    9 ++++++
 t/t1300-repo-config.sh |    8 +++++
 6 files changed, 102 insertions(+), 1 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 4e00b31..0fc5cfe 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git' [--version] [--exec-path[=3DGIT_EXEC_PATH]] [--html-path]
     [-p|--paginate|--no-pager] [--no-replace-objects]
     [--bare] [--git-dir=3DGIT_DIR] [--work-tree=3DGIT_WORK_TREE]
+    [-c name=3Dvalue]
     [--help] COMMAND [ARGS]
=20
 DESCRIPTION
@@ -220,6 +221,12 @@ displayed. See linkgit:git-help[1] for more inform=
ation,
 because `git --help ...` is converted internally into `git
 help ...`.
=20
+-c <name>=3D<value>::
+	Pass a configuration parameter to the command. The value
+	given will override values from configuration files.
+	The <name> is expected in the same format as listed by
+	'git config' (subkeys separated by dots).
+
 --exec-path::
 	Path to wherever your core git programs are installed.
 	This can also be controlled by setting the GIT_EXEC_PATH
diff --git a/builtin/config.c b/builtin/config.c
index 4bc46b1..f3d1660 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -197,7 +197,11 @@ static int get_value(const char *key_, const char =
*regex_)
 		git_config_from_file(show_config, system_wide, NULL);
 	if (do_all && global)
 		git_config_from_file(show_config, global, NULL);
-	git_config_from_file(show_config, local, NULL);
+	if (do_all)
+		git_config_from_file(show_config, local, NULL);
+	git_config_from_parameters(show_config, NULL);
+	if (!do_all && !seen)
+		git_config_from_file(show_config, local, NULL);
 	if (!do_all && !seen && global)
 		git_config_from_file(show_config, global, NULL);
 	if (!do_all && !seen && system_wide)
diff --git a/cache.h b/cache.h
index 2928107..f5fa79e 100644
--- a/cache.h
+++ b/cache.h
@@ -936,6 +936,8 @@ extern int update_server_info(int);
 typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
+extern int git_config_parse_parameter(const char *text);
+extern int git_config_from_parameters();
 extern int git_config(config_fn_t fn, void *);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_config_int(const char *, const char *);
diff --git a/config.c b/config.c
index 6963fbe..83ebe0c 100644
--- a/config.c
+++ b/config.c
@@ -18,6 +18,62 @@ static int zlib_compression_seen;
=20
 const char *config_exclusive_filename =3D NULL;
=20
+struct config_item
+{
+	struct config_item *next;
+	char *value;
+	char name[1 /* NUL */];
+};
+static struct config_item *config_parameters;
+static struct config_item **config_parameters_tail =3D &config_paramet=
ers;
+
+static void lowercase(char *p)
+{
+	for (; *p; ++p)
+		*p =3D tolower(*p);
+}
+static char *skip_space(const char *p)
+{
+	for (; *p; ++p)
+		if (!isspace(*p))
+			break;
+	return (char *)p;
+}
+static char *trailing_space(const char *begin, const char *p)
+{
+	while (p-- > begin)
+		if (!isspace(*p))
+			break;
+	return (char *)p + 1;
+}
+
+int git_config_parse_parameter(const char *text)
+{
+	struct config_item *ct;
+	const char *name;
+	const char *val;
+	name =3D skip_space(text);
+	text =3D val =3D strchr(name, '=3D');
+	if (!text)
+		text =3D name + strlen(name);
+	text =3D trailing_space(name, text);
+	if (text <=3D name)
+		return -1;
+	ct =3D xcalloc(1, sizeof(struct config_item) + (text - name));
+	memcpy(ct->name, name, text - name);
+	lowercase(ct->name);
+	if (!val)
+		ct->value =3D NULL;
+	else {
+		val =3D skip_space(++val /* skip "=3D" */);
+		text =3D trailing_space(val, val + strlen(val));
+		ct->value =3D xstrndup(val, text - val);
+	}
+	*config_parameters_tail =3D ct;
+	config_parameters_tail =3D &ct->next;
+	return 0;
+}
+
 static int get_next_char(void)
 {
 	int c;
@@ -699,6 +755,15 @@ int git_config_global(void)
 	return !git_env_bool("GIT_CONFIG_NOGLOBAL", 0);
 }
=20
+int git_config_from_parameters(config_fn_t fn, void *data)
+{
+	const struct config_item *ct;
+	for (ct =3D config_parameters; ct; ct =3D ct->next)
+		if (fn(ct->name, ct->value, data) < 0)
+			return -1;
+	return 0;
+}
+
 int git_config(config_fn_t fn, void *data)
 {
 	int ret =3D 0, found =3D 0;
@@ -730,6 +795,12 @@ int git_config(config_fn_t fn, void *data)
 		found +=3D 1;
 	}
 	free(repo_config);
+
+	if (config_parameters) {
+		ret +=3D git_config_from_parameters(fn, data);
+		found +=3D 1;
+	}
+
 	if (found =3D=3D 0)
 		return -1;
 	return ret;
diff --git a/git.c b/git.c
index 6bae305..99f0363 100644
--- a/git.c
+++ b/git.c
@@ -8,6 +8,7 @@ const char git_usage_string[] =3D
 	"git [--version] [--exec-path[=3DGIT_EXEC_PATH]] [--html-path]\n"
 	"           [-p|--paginate|--no-pager] [--no-replace-objects]\n"
 	"           [--bare] [--git-dir=3DGIT_DIR] [--work-tree=3DGIT_WORK_TR=
EE]\n"
+	"           [-c name=3Dvalue\n"
 	"           [--help] COMMAND [ARGS]";
=20
 const char git_more_info_string[] =3D
@@ -130,6 +131,14 @@ static int handle_options(const char ***argv, int =
*argc, int *envchanged)
 			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 0);
 			if (envchanged)
 				*envchanged =3D 1;
+		} else if (!strcmp(cmd, "-c")) {
+			if (*argc < 2) {
+				fprintf(stderr, "-c expects a configuration string\n" );
+				usage(git_usage_string);
+			}
+			git_config_parse_parameter((*argv)[1]);
+			(*argv)++;
+			(*argc)--;
 		} else {
 			fprintf(stderr, "Unknown option: %s\n", cmd);
 			usage(git_usage_string);
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index f11f98c..64f0508 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -824,4 +824,12 @@ test_expect_success 'check split_cmdline return' "
 	test_must_fail git merge master
 	"
=20
+test_expect_success 'git -c "key=3Dvalue" support' '
+	test "z$(git -c name=3Dvalue config name)" =3D zvalue &&
+	test "z$(git -c core.name=3Dvalue config core.name)" =3D zvalue &&
+	test "z$(git -c CamelCase=3Dvalue config camelcase)" =3D zvalue &&
+	test "z$(git -c flag config --bool flag)" =3D ztrue &&
+	test_must_fail git -c core.name=3Dvalue config name
+'
+
 test_done
--=20
1.7.0.3.309.g532f0
