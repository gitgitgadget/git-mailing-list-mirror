From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH, resend] Allow passing of configuration parameters in the
	command line
Date: Sat, 20 Mar 2010 17:05:43 +0100
Message-ID: <20100320160543.GA18709@blimp.localdomain>
References: <7vbpejkmo5.fsf@alter.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 17:06:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt1BU-0003wO-HQ
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 17:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753259Ab0CTQFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 12:05:52 -0400
Received: from mout1.freenet.de ([195.4.92.91]:35501 "EHLO mout1.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753003Ab0CTQFv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 12:05:51 -0400
Received: from [195.4.92.17] (helo=7.mx.freenet.de)
	by mout1.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.72 #2)
	id 1Nt1BK-0003lV-Nr; Sat, 20 Mar 2010 17:05:46 +0100
Received: from p57b18c71.dip0.t-ipconnect.de ([87.177.140.113]:48089 helo=tigra.home)
	by 7.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.72 #2)
	id 1Nt1BK-0005wH-C7; Sat, 20 Mar 2010 17:05:46 +0100
Received: from blimp.localdomain (blimp.home [192.168.0.79])
	by tigra.home (Postfix) with ESMTP id 016D5277DF;
	Sat, 20 Mar 2010 17:05:43 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 97FF236D28; Sat, 20 Mar 2010 17:05:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vbpejkmo5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142725>

The values passed this way will override whatever is defined
in the config files.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 Documentation/git.txt  |    7 +++++
 builtin/config.c       |    6 +++-
 cache.h                |    2 +
 config.c               |   71 ++++++++++++++++++++++++++++++++++++++++++++++++
 git.c                  |    9 ++++++
 t/t1300-repo-config.sh |    7 +++++
 6 files changed, 101 insertions(+), 1 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 35c0c79..755fa4d 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git' [--version] [--exec-path[=GIT_EXEC_PATH]] [--html-path]
     [-p|--paginate|--no-pager] [--no-replace-objects]
     [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE]
+    [-c name=value]
     [--help] COMMAND [ARGS]
 
 DESCRIPTION
@@ -219,6 +220,12 @@ displayed. See linkgit:git-help[1] for more information,
 because `git --help ...` is converted internally into `git
 help ...`.
 
+-c <name>=<value>::
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
@@ -197,7 +197,11 @@ static int get_value(const char *key_, const char *regex_)
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
index 89f6a40..4a0c75d 100644
--- a/cache.h
+++ b/cache.h
@@ -932,6 +932,8 @@ extern int update_server_info(int);
 typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
+extern int git_config_parse_parameter(const char *text);
+extern int git_config_from_parameters();
 extern int git_config(config_fn_t fn, void *);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_config_int(const char *, const char *);
diff --git a/config.c b/config.c
index 6963fbe..2376ae9 100644
--- a/config.c
+++ b/config.c
@@ -18,6 +18,62 @@ static int zlib_compression_seen;
 
 const char *config_exclusive_filename = NULL;
 
+struct config_item
+{
+	struct config_item *next;
+	char *value;
+	char name[1];
+};
+static struct config_item *config_parameters;
+static struct config_item **config_parametes_tail = &config_parameters;
+
+static void lowercase(char *p)
+{
+	for (; *p; ++p)
+		*p = tolower(*p);
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
+	name = skip_space(text);
+	text = val = strchr(name, '=');
+	if (!text)
+		text = name + strlen(name);
+	text = trailing_space(name, text);
+	if (text <= name)
+		return -1;
+	ct = calloc(1, sizeof(struct config_item) + (text - name));
+	memcpy(ct->name, name, text - name);
+	lowercase(ct->name);
+	if (!val)
+		ct->value = NULL;
+	else {
+		val = skip_space(++val /* skip "=" */);
+		text = trailing_space(val, val + strlen(val));
+		ct->value = strndup(val, text - val);
+	}
+	*config_parametes_tail = ct;
+	config_parametes_tail = &ct->next;
+	return 0;
+}
+
 static int get_next_char(void)
 {
 	int c;
@@ -699,6 +755,15 @@ int git_config_global(void)
 	return !git_env_bool("GIT_CONFIG_NOGLOBAL", 0);
 }
 
+int git_config_from_parameters(config_fn_t fn, void *data)
+{
+	const struct config_item *ct;
+	for (ct = config_parameters; ct; ct = ct->next)
+		if (fn(ct->name, ct->value, data) < 0)
+			return -1;
+	return 0;
+}
+
 int git_config(config_fn_t fn, void *data)
 {
 	int ret = 0, found = 0;
@@ -730,6 +795,12 @@ int git_config(config_fn_t fn, void *data)
 		found += 1;
 	}
 	free(repo_config);
+
+	if (config_parameters) {
+		ret += git_config_from_parameters(fn, data);
+		found += 1;
+	}
+
 	if (found == 0)
 		return -1;
 	return ret;
diff --git a/git.c b/git.c
index 6bae305..99f0363 100644
--- a/git.c
+++ b/git.c
@@ -8,6 +8,7 @@ const char git_usage_string[] =
 	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [--html-path]\n"
 	"           [-p|--paginate|--no-pager] [--no-replace-objects]\n"
 	"           [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE]\n"
+	"           [-c name=value\n"
 	"           [--help] COMMAND [ARGS]";
 
 const char git_more_info_string[] =
@@ -130,6 +131,14 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 0);
 			if (envchanged)
 				*envchanged = 1;
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
index f11f98c..d7c5501 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -824,4 +824,11 @@ test_expect_success 'check split_cmdline return' "
 	test_must_fail git merge master
 	"
 
+test_expect_success 'git -c "key=value" support' '
+	test "z$(git -c name=value config name)" = zvalue &&
+	test "z$(git -c core.name=value config core.name)" = zvalue &&
+	test "z$(git -c flag config --bool flag)" = ztrue &&
+	test_must_fail git -c core.name=value config name
+'
+
 test_done
-- 
1.7.0.2.318.g49250
