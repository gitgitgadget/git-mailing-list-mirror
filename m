From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH/RFC 8/8] Make git-am a builtin
Date: Tue, 13 Jun 2006 22:22:06 +0200
Organization: Chalmers
Message-ID: <448F1E6E.8000003@etek.chalmers.se>
References: <448EF791.7070504@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Tue Jun 13 22:22:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqFP3-0006Zx-9z
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 22:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWFMUWO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 13 Jun 2006 16:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWFMUWO
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 16:22:14 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:17342 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932222AbWFMUWM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 16:22:12 -0400
Received: from [192.168.0.82] (213.66.93.165) by pne-smtpout1-sn2.hy.skanova.net (7.2.072.1)
        id 448977B3000E742F; Tue, 13 Jun 2006 22:22:07 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.4) Gecko/20060603 Thunderbird/1.5.0.4 Mnenhy/0.7.4.666
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <448EF791.7070504@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21812>

Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
---

Being able to switch index-file on the fly would reduce the number of
system() calls.
A way to check if the index/working dir is dirty would also help.

 Makefile     |    6 -
 builtin-am.c |  664 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 builtin.h    |    1=20
 git-am.sh    |  427 -------------------------------------
 git.c        |    3=20
 5 files changed, 670 insertions(+), 431 deletions(-)

diff --git a/Makefile b/Makefile
index 4b30ca0..e9b372e 100644
--- a/Makefile
+++ b/Makefile
@@ -122,7 +122,7 @@ SCRIPT_SH =3D \
 	git-repack.sh git-request-pull.sh git-reset.sh \
 	git-resolve.sh git-revert.sh git-sh-setup.sh \
 	git-tag.sh git-verify-tag.sh \
-	git-applymbox.sh git-applypatch.sh git-am.sh \
+	git-applymbox.sh git-applypatch.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh \
 	git-lost-found.sh git-quiltimport.sh
@@ -166,7 +166,7 @@ PROGRAMS =3D \
 BUILT_INS =3D git-log$X git-whatchanged$X git-show$X git-update-ref$X =
\
 	git-count-objects$X git-diff$X git-push$X git-mailsplit$X \
 	git-grep$X git-add$X git-rm$X git-rev-list$X git-stripspace$X \
-	git-check-ref-format$X git-rev-parse$X git-mailinfo$X \
+	git-check-ref-format$X git-rev-parse$X git-mailinfo$X git-am$X \
 	git-init-db$X git-tar-tree$X git-upload-tar$X git-format-patch$X \
 	git-ls-files$X git-ls-tree$X git-get-tar-commit-id$X \
 	git-read-tree$X git-commit-tree$X git-write-tree$X \
@@ -220,7 +220,7 @@ LIB_OBJS =3D \
 BUILTIN_OBJS =3D \
 	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-p=
ush.o \
 	builtin-grep.o builtin-add.o builtin-rev-list.o builtin-check-ref-for=
mat.o \
-	builtin-rm.o builtin-init-db.o builtin-rev-parse.o \
+	builtin-rm.o builtin-init-db.o builtin-rev-parse.o builtin-am.o \
 	builtin-tar-tree.o builtin-upload-tar.o builtin-update-index.o \
 	builtin-ls-files.o builtin-ls-tree.o builtin-write-tree.o \
 	builtin-read-tree.o builtin-commit-tree.o builtin-mailinfo.o \
diff --git a/builtin-am.c b/builtin-am.c
new file mode 100644
index 0000000..d9e7ac5
--- /dev/null
+++ b/builtin-am.c
@@ -0,0 +1,664 @@
+/*
+ * GIT - The information manager from hell
+ *
+ * Copyright (C) Lukas Sandstr=C3=B6m, 2006
+ */
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <errno.h>
+#include <dirent.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdarg.h>
+#include <sys/wait.h>
+
+#include "git-compat-util.h"
+#include "cache.h"
+#include "builtin.h"
+
+static char builtin_am_usage[] =3D "[--signoff] [--dotest=3D<dir>] [--=
utf8] [--binary] [--3way] "
+				 "[--interactive] [--whitespace=3D<option>] <mbox>...\n"
+				 "or, when resuming [--skip | --resolved]";
+
+static int binary, interactive, threeway, signoff, utf8, keep_subject,=
 resolved, skip, resume;
+static char whitespace[40] =3D "--whitespace=3Dwarn", **env;
+static const char **mbox, *dotest, *resolvmsg;
+
+#define PATCH_PREC 4
+
+#define AGAIN 0
+#define SKIP 1
+#define YES 2
+
+//ugly hack to be able to change the index file
+extern char *git_index_file;
+
+static int rm_rf(const char* path)
+{
+	char cmd[PATH_MAX + 10];
+	snprintf(cmd, sizeof(cmd), "rm -rf %s", path);
+	return system(cmd);
+}
+
+static int mkdir_p(const char *path)
+{
+	char p[PATH_MAX], n, *l;
+
+	strcpy(p, path);
+	while ((l =3D strchr(p, '/'))) {
+		n =3D *l;
+		*l =3D '\0';
+		if (access(p, F_OK) && mkdir(p, 0777))
+			return -1;
+		*l =3D n;
+	}
+	return mkdir(p, 0777);
+}
+
+static int fcat(char *file, char *fmt, ...)
+{
+	va_list args;
+	int ret;
+	FILE *f;
+
+	file =3D mkpath("%s/%s", dotest, file);
+	if ((f =3D fopen(file, "r")) =3D=3D NULL) {
+		perror(file);
+		die("Couldn't open file %s", file);
+	}
+	va_start(args, fmt);
+	ret =3D vfscanf(f, fmt, args);
+	va_end(args);
+	fclose(f);
+	return ret;
+}
+
+static int fecho(char *file, char *fmt, ...)
+{
+	va_list args;
+	int ret;
+	FILE *f;
+
+	file =3D mkpath("%s/%s", dotest, file);
+	if ((f =3D fopen(file, "w")) =3D=3D NULL) {
+		perror(file);
+		die("Couldn't open file %s/%s", dotest, file);
+	}
+	va_start(args, fmt);
+	ret =3D vfprintf(f, fmt, args);
+	va_end(args);
+	fclose(f);
+	return ret;
+}
+
+static FILE* get_output(char *cmd, int *status)
+{
+	char c[2000];
+	FILE *ret;
+	int s;
+
+	snprintf(c, sizeof(c), "%s > \"%s/outtmp\"", cmd, dotest);
+	s =3D system(c);
+	if (status)
+		*status =3D s;
+	if ((ret =3D fopen(mkpath("%s/outtmp", dotest), "r")) =3D=3D NULL)
+		die("cmd: %s\nOpen \"%s\" failed.", c, mkpath("%s/outtmp", dotest));
+	unlink(mkpath("%s/outtmp", dotest));
+	return ret;
+}
+
+static int has_zero_output(char *cmd)
+{
+	struct stat s;
+
+	system(mkpath("%s > %s/zerotmp", cmd, dotest));
+	stat(mkpath("%s/zerotmp", dotest), &s);
+	unlink(mkpath("%s/zerotmp", dotest));
+	return s.st_size =3D=3D 0;
+}
+
+static int go_next(int this) {
+	unlink(mkpath("%s/%0*d", dotest, PATCH_PREC, this));
+	unlink(mkpath("%s/msg", dotest));
+	unlink(mkpath("%s/msg-clean", dotest));
+	unlink(mkpath("%s/patch", dotest));
+	unlink(mkpath("%s/info", dotest));
+	fecho("next", "%d", this + 1);
+	return this + 1;
+}
+
+static void stop_here(int this)
+{
+	fecho("next","%d\n", this);
+	exit(1);
+}
+
+static void stop_here_user_resolve(int this)
+{
+	char cmdline[1000] =3D "git am";
+	int pos =3D 6; /* "git am" */
+
+	if (resolvmsg !=3D NULL) {
+		printf("%s", resolvmsg);
+		stop_here(this);
+	}
+
+	if (interactive)
+		pos +=3D sprintf(cmdline + pos, " -i");
+	if (threeway)
+		pos +=3D sprintf(cmdline + pos, " -3");
+	if (strcmp(".dotest", dotest))
+		pos +=3D sprintf(cmdline + pos, " -d=3D%s", dotest);
+
+	printf("When you have resolved this problem run \"git am %s --resolve=
d\".\n", cmdline);
+	printf("If you would prefer to skip this patch, instead run \"%s --sk=
ip\".\n", cmdline);
+
+	stop_here(this);
+}
+
+static int fall_back_3way()
+{
+	char cmd[1000];
+	char tmp_index[PATH_MAX], old_index[PATH_MAX] =3D "";
+	int ret =3D -1;
+
+	snprintf(cmd, sizeof(cmd), "git-apply -z --index-info \"%s/patch\""
+			" > %s/patch-merge-index-info 2> /dev/null", dotest, dotest);
+	if (!system(cmd)) {
+		snprintf(tmp_index, sizeof(tmp_index),"%s/patch-merge-tmp-index", do=
test);
+		if (getenv(INDEX_ENVIRONMENT))
+			strcpy(old_index, getenv(INDEX_ENVIRONMENT));
+		setenv(INDEX_ENVIRONMENT, tmp_index, 1);
+
+		snprintf(cmd, sizeof(cmd), "git-update-index -z --index-info <\"%s/p=
atch-merge-index-info\"", dotest);
+		if (!system(cmd)) {
+#if 1
+			system(mkpath("git-write-tree > \"%s/patch-merge-base\"", dotest));
+			snprintf(cmd, sizeof(cmd), "git-apply %s --cached < \"%s/patch\"", =
binary ? "--allow-binary-replacement":"", dotest);
+			if (!system(cmd)) {
+				char his_tree[41], orig_tree[41];
+				printf("Using index info to reconstruct a base tree...\n");
+				system(mkpath("git-write-tree > \"%s/his-tree\"", dotest));
+				fcat("his-tree", "%40s", his_tree);
+				fcat("patch-merge-base", "%40s", orig_tree);
+
+				printf("Falling back to patching base and 3-way merge...\n");
+
+				if (*old_index)
+					setenv(INDEX_ENVIRONMENT, old_index, 1);
+				else
+					unsetenv(INDEX_ENVIRONMENT);
+				if (!system(mkpath("git-merge-resolve %s -- HEAD %s", orig_tree, h=
is_tree)))
+					return 0;
+			}
+		}
+#else
+			unsigned char orig_tree[20], his_tree[20];
+
+			// We need a way to switch the index file on the fly for this to wo=
rk
+
+			char *opts[] =3D { "git-apply", "--allow-binary-replacement", "--ca=
ched", NULL, NULL };
+			char **opt =3D &opts[0];
+			char patch[PATH_MAX];
+			int optc =3D ARRAY_SIZE(opts) - 1;
+
+			opts[optc - 1] =3D strncpy(patch, mkpath("%s/patch", dotest), sizeo=
f(patch));
+			if (!binary) {
+				opts[1] =3D "git-apply";
+				opt++; optc--;
+			}
+			write_tree(orig_tree, 0, NULL);
+			if (!cmd_apply(optc, (const char**)opt, env)) {
+				printf("Using index info to reconstruct a base tree...\n");
+				write_tree(his_tree, 0, NULL);
+
+				snprintf(cmd, sizeof(cmd), "git-merge-resolve %s -- HEAD %s", sha1=
_to_hex(orig_tree),
+					 sha1_to_hex(his_tree));
+				ret =3D system(cmd);
+			}
+		}
+		if (*old_index)
+			setenv(INDEX_ENVIRONMENT, old_index, 1);
+		else
+			unsetenv(INDEX_ENVIRONMENT);
+#endif
+		if (!ret)
+			return 0;
+	}
+	if (!access(mkpath("%s/rr-cache/.", get_git_dir()), F_OK))
+		system("git-rerere");
+	die("Failed to merge in the changes.");
+}
+
+static int go_interactive(void)
+{
+	int action =3D AGAIN;
+
+	if (!isatty(0))
+		die("Cannot be interactive without stdin connected to a terminal.");
+
+	while (action =3D=3D AGAIN) {
+		char line[1000];
+		FILE *cmt;
+
+		printf("Commit Body is:\n--------------------------\n");
+		cmt =3D fopen(mkpath("%s/final-commit", dotest), "r");
+		while (fgets(line, sizeof(line), cmt))
+			fputs(line, stdout);
+		fclose(cmt);
+		printf("--------------------------\nApply? [y]es/[n]o/[e]dit/[v]iew =
patch/[a]ccept all ");
+
+		fgets(line, sizeof(line), stdin);
+		switch (line[0]) {
+			case 'y':
+			case 'Y':
+				action =3D YES;
+				break;
+			case 'a':
+			case 'A':
+				action =3D YES;
+				interactive =3D 0;
+				break;
+			case 'n':
+			case 'N':
+				action =3D SKIP;
+				break;
+			case 'e':
+			case 'E':
+				system(mkpath("\"${VISUAL:-${EDITOR:-vi}}\" \"%s/final-commit\"", =
dotest));
+				action =3D AGAIN;
+				break;
+			case 'v':
+			case 'V':
+				system(mkpath("LESS=3D-S ${PAGER:-less} \"%s/patch\"", dotest));
+				action =3D AGAIN;
+				break;
+			default:
+				action =3D AGAIN;
+				break;
+		}
+	}
+	return action;
+}
+
+static int commit(char *subject)
+{
+	unsigned char sha1[20];
+	char commit[41], parent[41], cmd[1000];
+	FILE *f;
+	int status;
+
+	if (!write_tree(sha1, 0, NULL)) {
+		printf("Wrote tree %s\n", sha1_to_hex(sha1));
+		f =3D get_output("git-rev-parse --verify HEAD", &status);
+		if (!status) {
+			fgets(parent, 41, f);
+			fclose(f);
+			snprintf(cmd, sizeof(cmd), "git-commit-tree %s -p %s <\"%s/final-co=
mmit\"",
+				 sha1_to_hex(sha1), parent, dotest);
+			f =3D get_output(cmd, &status);
+			if (!status) {
+				//git-update-ref -m "am: $SUBJECT" HEAD $commit $parent
+				char *opts[] =3D { "git-update-ref", "-m", NULL, "HEAD", NULL, NUL=
L, NULL };
+				const char **opt =3D (const char**)&opts[0];
+				fgets(commit, 41, f);
+				fclose(f);
+				printf("Committed: %s\n", commit);
+				snprintf(cmd, sizeof(cmd), "am: %s", subject);
+				opts[2] =3D cmd;
+				opts[4] =3D commit;
+				opts[5] =3D parent;
+				if (!cmd_update_ref(ARRAY_SIZE(opts) - 1, opt, env))
+					return 0;
+			}
+		}
+	}
+	return -1;
+}
+
+int cmd_am(int argc, const char **argv, char **envp)
+{
+	int i, this, last, apply_status, action;
+	char sign[1000] =3D "";
+
+	env =3D envp;
+
+	for (i =3D 1; i < argc; i++) {
+		const char *arg =3D argv[i];
+
+		if (arg[0] !=3D '-')
+			break;
+		if (!strcmp(arg, "--")) {
+			i++;
+			break;
+		}
+		if (!strcmp(arg, "-i") || !strcmp(arg, "--interactive")) {
+			interactive =3D 1;
+			continue;
+		}
+		if (!strcmp(arg, "-b") || !strcmp(arg, "--binary")) {
+			binary =3D 1;
+			continue;
+		}
+		if (!strcmp(arg, "-3") || !strcmp(arg, "--3way")) {
+			threeway =3D 1;
+			continue;
+		}
+		if (!strcmp(arg, "-s") || !strcmp(arg, "--signoff")) {
+			signoff =3D 1;
+			continue;
+		}
+		if (!strcmp(arg, "--skip")) {
+			skip =3D 1;
+			continue;
+		}
+		if (!strcmp(arg, "-u") || !strcmp(arg, "--utf8")) {
+			utf8 =3D 1;
+			continue;
+		}
+		if (!strcmp(arg, "-k") || !strcmp(arg, "--keep")) {
+			keep_subject =3D 1;
+			continue;
+		}
+		if (!strcmp(arg, "-r") || !strcmp(arg, "--resolved")) {
+			resolved =3D 1;
+			continue;
+		}
+		if (!strncmp(arg, "--whitespace=3D", 13)) {
+			strncpy(whitespace, arg, sizeof(whitespace));
+			continue;
+		}
+		if (!strncmp(arg, "--resolvemsg=3D", 13)) {
+			resolvmsg =3D arg + 13;
+			continue;
+		}
+		if (!strncmp(arg, "--dotest", 8)) {
+			if (arg[8] =3D=3D '=3D')
+				dotest =3D arg + 9;
+			else {
+				i++;
+				if (argv[i] =3D=3D NULL)
+					die(builtin_am_usage);
+				dotest =3D argv[i];
+			}
+			continue;
+		}
+		usage(builtin_am_usage);
+	}
+	mbox =3D argv + i;
+
+	if (!dotest)
+		dotest =3D ".dotest";
+
+	/* Cleanup old .dotest */
+	if (mbox && !access(dotest, F_OK))
+		if (fcat("next", "%d", &this) && fcat("last", "%d",  &last))
+			if (this > last)
+				rm_rf(dotest);
+
+	if (!access(dotest, F_OK)) {
+		if (mbox !=3D NULL)
+			die("previous dotest directory \"%s\" still exists but mbox given."=
, dotest);
+		resume =3D 1;
+	} else {
+		if (skip || resolved)
+			die("Resolve operation not in progress, we are not resuming.");
+
+		if (mkdir_p(dotest))
+			die("Unable to create directory %s.", dotest);
+
+		if ((last =3D split_mbox(mbox, dotest, 1 /*allow bare*/, PATCH_PREC,=
 0 /*skip*/)) =3D=3D -1) {
+			rm_rf(dotest);
+			die("split_mbox failed");
+		}
+
+		/*
+		  -b, -s, -u, -k and --whitespace flags are kept for the
+		  resuming session after a patch failure.
+		  -3 and -i can and must be given when resuming.
+		*/
+		fecho("binary", "%d\n", binary);
+		fecho("whitespace", "%s\n", whitespace);
+		fecho("sign", "%d\n", signoff);
+		fecho("utf8", "%d\n", utf8);
+		fecho("keep", "%d\n", keep_subject);
+		fecho("next", "%d\n", 1);
+		fecho("last", "%d\n", last);
+	}
+
+	if (!resolved) {
+		/* Make sure we have a clean index */
+		char buf[PATH_MAX];
+		int status =3D 0;
+		FILE *f;
+
+		if ((f =3D get_output("git-diff-index --name-only HEAD", &status)) =3D=
=3D NULL || status)
+			die("Command: \"git-diff-index --name-only HEAD\" failed");
+
+		if ((status =3D fgetc(f)) !=3D EOF) {
+			ungetc(status, f);
+			fprintf(stderr, "Dirty index: cannot apply patches. Dirty files:\n"=
);
+			while (fgets(buf, sizeof(buf), f))
+				fprintf(stderr, "%s", buf);
+			return 1;
+		}
+		fclose(f);
+	}
+
+	/* Read back saved state */
+	fcat("binary", "%d", &binary);
+	fcat("utf8", "%d", &utf8);
+	fcat("keep", "%d", &keep_subject);
+	fcat("whitespace", "%40[^\n]", whitespace);
+	fcat("sign", "%d", &signoff);
+	fcat("last", "%d", &last);
+	fcat("next", "%d", &this);
+
+	if (this > last) {
+		printf("Nothing to do.\n");
+		rm_rf(dotest);
+		return 0;
+	}
+
+	if (signoff) {
+		int off =3D snprintf(sign, sizeof(sign), "Signed-off-by: %s <%s>",
+				   getenv("GIT_COMMITTER_NAME"), getenv("GIT_COMMITTER_EMAIL"));
+		if (off > sizeof(sign))
+			die ("Impossibly long committer identifier");
+	}
+
+	if (skip) {
+		this++;
+		resume =3D 0;
+	}
+
+	while (this <=3D last) {
+		char patch_no[PATCH_PREC + 1];
+		char name[1000];
+		char email[1000];
+		char date[1000];
+		char s[1000] =3D "[PATCH] ", *subject =3D &s[0];
+
+		snprintf(patch_no, sizeof(patch_no), "%0*d", PATCH_PREC, this);
+
+		if (access(mkpath("%s/%s", dotest, patch_no), F_OK)) {
+			resume =3D 0;
+			this =3D go_next(this);
+			continue;
+		}
+
+		/*
+		  If we are not resuming, parse and extract the patch information
+		  into separate files:
+		  - info records the authorship and title
+		  - msg is the rest of commit log message
+		  - patch is the patch body.
+
+		 When we are resuming, these files are either already prepared
+		 by the user, or the user can tell us to do so by --resolved flag.
+		*/
+		if (!resume) {
+			FILE *out, *in;
+			char msg_path[PATH_MAX];
+
+			if ((out =3D fopen(mkpath("%s/info", dotest), "w")) =3D=3D NULL) {
+				perror(mkpath("%s/info", dotest));
+				die("fopen failed");
+			}
+			if ((in =3D fopen(mkpath("%s/%s", dotest, patch_no), "r")) =3D=3D N=
ULL) {
+				perror(mkpath("%s/%s", dotest, patch_no));
+				die("fopen failed");
+			}
+
+			snprintf(msg_path, sizeof(msg_path), "%s/msg", dotest);
+			if (mailinfo(in, out, keep_subject, utf8 ? git_commit_encoding : NU=
LL,
+			    msg_path, mkpath("%s/patch",dotest)))
+				    stop_here(this);
+			fclose(in);
+			fclose(out);
+
+			in =3D fopen(msg_path, "r");
+			out =3D fopen(mkpath("%s/msg-clean", dotest), "w");
+			stripspace(in, out);
+			fclose(in);
+			fclose(out);
+		}
+
+		fcat("info", "Author: %1000[^\n]\nEmail: %1000s\n"
+		     "Subject: %992[^\n]\nDate: %1000[^\n]\n\n",
+		     name, email, subject + 8 /*[PATCH] */, date);
+
+		if (!keep_subject)
+			subject =3D subject + 8; /*[PATCH] */
+
+		if (email =3D=3D NULL || !strcmp(email, "")) {
+			printf("Patch does not have a valid e-mail address.\n");
+			stop_here(this);
+		}
+
+		if (!resume) { /* Prepare the commit-message and the patch */
+			char c, *t;
+			char line[1000];
+			char last_signoff[1000] =3D "";
+			FILE *cmt, *msg;
+
+			/* Find the last Signed-off line */
+			msg =3D fopen(mkpath("%s/msg-clean", dotest), "r");
+			while ((fgets(line, sizeof(line), msg))) {
+				if ((t =3D strstr(line, "Signed-off-by: ")))
+					strncpy(last_signoff, t, sizeof(last_signoff));
+			}
+			if ((t =3D strrchr(last_signoff, '>')))
+				*++t =3D '\0';
+
+			/* Write the commit-mesage */
+			cmt =3D fopen(mkpath("%s/final-commit", dotest), "w");
+			fprintf(cmt, "%s\n", subject);
+
+			rewind(msg);
+			if ((c =3D fgetc(msg)) !=3D EOF) {
+				fprintf(cmt, "\n");
+				ungetc(c, msg);
+			}
+			while (fgets(line, sizeof(line), msg))
+				fputs(line, cmt);
+
+			/* Add a signoff */
+			if (signoff && strcmp(last_signoff, sign)) {
+				if (!strcmp(last_signoff, ""))
+					fputc('\n', cmt);
+				fputs(sign, cmt);
+			}
+			fclose(cmt);
+			fclose(msg);
+		} else
+			if (resolved && interactive)
+				/* This is used only for interactive view option. */
+				system(mkpath("git-diff-index -p --cached HEAD >\"%s/patch\"", dot=
est));
+
+		resume =3D 0;
+		if (interactive)
+			action =3D go_interactive();
+		else
+			action =3D YES;
+
+		if (action =3D=3D SKIP) {
+			this =3D go_next(this);
+			continue;
+		}
+
+		if (!access(mkpath("%s/hooks/applypatch-msg", get_git_dir()), X_OK))
+			if (system(mkpath("%s/hooks/applypatch-msg %s/final-commit", get_gi=
t_dir(), dotest)))
+				stop_here(this);
+
+		printf("\nApplying %s\n\n", subject);
+
+		if (!resolved) {
+			/*git-apply $binary --index $ws "$dotest/patch" */
+			char patch[PATH_MAX];
+			char *opts[6] =3D { "git-apply", "--allow-binary-replacement", "--i=
ndex", NULL, NULL, NULL };
+			char **opt =3D &opts[0];
+			int optc =3D 5;
+
+			if (!binary) {
+				opts[1] =3D "git-apply";
+				opt++; optc--;
+			}
+			opts[3] =3D whitespace;
+			snprintf(patch, sizeof(patch), "%s/patch", dotest);
+			opts[4] =3D patch;
+			apply_status =3D cmd_apply(optc, (const char**)opt, envp);
+		} else {
+			/* Resolved means the user did all the hard work, and
+			   we do not have to do any patch application.  Just
+			   trust what the user has in the index file and the
+			   working tree.*/
+			resolved =3D 0;
+
+			if (has_zero_output("git-diff-index --cached --name-only HEAD")) {
+				printf("No changes - did you forget update-index?\n");
+				stop_here_user_resolve(this);
+			}
+			if (!has_zero_output("git-ls-files -u")) {
+				printf("You still have unmerged paths in your index,\n"
+					"did you forget update-index?");
+				stop_here_user_resolve(this);
+			}
+			apply_status =3D 0;
+		}
+
+		if (apply_status && threeway) {
+			fall_back_3way();
+			/* Applying the patch to an earlier tree and merging the
+			   result may have produced the same tree as ours. */
+			if (has_zero_output("git-diff-index --cached --name-only HEAD")) {
+				printf("No changes -- Patch already applied.\n");
+				this =3D go_next(this);
+				continue;
+			}
+			/* We have merged successfully */
+			apply_status =3D 0;
+		}
+
+		if (apply_status) {
+			printf("Patch failed at %s\n.", patch_no);
+			stop_here_user_resolve(this);
+		}
+
+		if (!access(mkpath("%s/hooks/pre-applypatch", get_git_dir()), X_OK))
+			if (system(mkpath("%s/hooks/pre-applypatch", get_git_dir())))
+				stop_here(this);
+
+		if (commit(subject) =3D=3D -1)
+			stop_here(this);
+
+		if (!access(mkpath("%s/hooks/post-applypatch", get_git_dir()), X_OK)=
)
+			system(mkpath("%s/hooks/post-applypatch", get_git_dir()));
+
+		this =3D go_next(this);
+	}
+	rm_rf(dotest);
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index c1f3395..8771e36 100644
--- a/builtin.h
+++ b/builtin.h
@@ -49,6 +49,7 @@ extern int cmd_cat_file(int argc, const=20
 extern int cmd_rev_parse(int argc, const char **argv, char **envp);
 extern int cmd_update_index(int argc, const char **argv, char **envp);
 extern int cmd_update_ref(int argc, const char **argv, char **envp);
+extern int cmd_am(int argc, const char **argv, char **envp);
=20
 extern int cmd_write_tree(int argc, const char **argv, char **envp);
 extern int write_tree(unsigned char *sha1, int missing_ok, const char =
*prefix);
diff --git a/git-am.sh b/git-am.sh
deleted file mode 100755
index 4232e27..0000000
--- a/git-am.sh
+++ /dev/null
@@ -1,427 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2005, 2006 Junio C Hamano
-
-USAGE=3D'[--signoff] [--dotest=3D<dir>] [--utf8] [--binary] [--3way]
-  [--interactive] [--whitespace=3D<option>] <mbox>...
-  or, when resuming [--skip | --resolved]'
-. git-sh-setup
-
-git var GIT_COMMITTER_IDENT >/dev/null || exit
-
-stop_here () {
-    echo "$1" >"$dotest/next"
-    exit 1
-}
-
-stop_here_user_resolve () {
-    if [ -n "$resolvemsg" ]; then
-	    echo "$resolvemsg"
-	    stop_here $1
-    fi
-    cmdline=3D$(basename $0)
-    if test '' !=3D "$interactive"
-    then
-        cmdline=3D"$cmdline -i"
-    fi
-    if test '' !=3D "$threeway"
-    then
-        cmdline=3D"$cmdline -3"
-    fi
-    if test '.dotest' !=3D "$dotest"
-    then
-        cmdline=3D"$cmdline -d=3D$dotest"
-    fi
-    echo "When you have resolved this problem run \"$cmdline --resolve=
d\"."
-    echo "If you would prefer to skip this patch, instead run \"$cmdli=
ne --skip\"."
-
-    stop_here $1
-}
-
-go_next () {
-	rm -f "$dotest/$msgnum" "$dotest/msg" "$dotest/msg-clean" \
-		"$dotest/patch" "$dotest/info"
-	echo "$next" >"$dotest/next"
-	this=3D$next
-}
-
-fall_back_3way () {
-    O_OBJECT=3D`cd "$GIT_OBJECT_DIRECTORY" && pwd`
-
-    rm -fr "$dotest"/patch-merge-*
-    mkdir "$dotest/patch-merge-tmp-dir"
-
-    # First see if the patch records the index info that we can use.
-    if git-apply -z --index-info "$dotest/patch" \
-	>"$dotest/patch-merge-index-info" 2>/dev/null &&
-	GIT_INDEX_FILE=3D"$dotest/patch-merge-tmp-index" \
-	git-update-index -z --index-info <"$dotest/patch-merge-index-info" &&
-	GIT_INDEX_FILE=3D"$dotest/patch-merge-tmp-index" \
-	git-write-tree >"$dotest/patch-merge-base+" &&
-	# index has the base tree now.
-	GIT_INDEX_FILE=3D"$dotest/patch-merge-tmp-index" \
-	git-apply $binary --cached <"$dotest/patch"
-    then
-	echo Using index info to reconstruct a base tree...
-	mv "$dotest/patch-merge-base+" "$dotest/patch-merge-base"
-	mv "$dotest/patch-merge-tmp-index" "$dotest/patch-merge-index"
-    fi
-
-    test -f "$dotest/patch-merge-index" &&
-    his_tree=3D$(GIT_INDEX_FILE=3D"$dotest/patch-merge-index" git-writ=
e-tree) &&
-    orig_tree=3D$(cat "$dotest/patch-merge-base") &&
-    rm -fr "$dotest"/patch-merge-* || exit 1
-
-    echo Falling back to patching base and 3-way merge...
-
-    # This is not so wrong.  Depending on which base we picked,
-    # orig_tree may be wildly different from ours, but his_tree
-    # has the same set of wildly different changes in parts the
-    # patch did not touch, so resolve ends up cancelling them,
-    # saying that we reverted all those changes.
-
-    git-merge-resolve $orig_tree -- HEAD $his_tree || {
-	    if test -d "$GIT_DIR/rr-cache"
-	    then
-		git-rerere
-	    fi
-	    echo Failed to merge in the changes.
-	    exit 1
-    }
-}
-
-prec=3D4
-dotest=3D.dotest sign=3D utf8=3D keep=3D skip=3D interactive=3D resolv=
ed=3D binary=3D ws=3D resolvemsg=3D
-
-while case "$#" in 0) break;; esac
-do
-	case "$1" in
-	-d=3D*|--d=3D*|--do=3D*|--dot=3D*|--dote=3D*|--dotes=3D*|--dotest=3D*=
)
-	dotest=3D`expr "$1" : '-[^=3D]*=3D\(.*\)'`; shift ;;
-	-d|--d|--do|--dot|--dote|--dotes|--dotest)
-	case "$#" in 1) usage ;; esac; shift
-	dotest=3D"$1"; shift;;
-
-	-i|--i|--in|--int|--inte|--inter|--intera|--interac|--interact|\
-	--interacti|--interactiv|--interactive)
-	interactive=3Dt; shift ;;
-
-	-b|--b|--bi|--bin|--bina|--binar|--binary)
-	binary=3Dt; shift ;;
-
-	-3|--3|--3w|--3wa|--3way)
-	threeway=3Dt; shift ;;
-	-s|--s|--si|--sig|--sign|--signo|--signof|--signoff)
-	sign=3Dt; shift ;;
-	-u|--u|--ut|--utf|--utf8)
-	utf8=3Dt; shift ;;
-	-k|--k|--ke|--kee|--keep)
-	keep=3Dt; shift ;;
-
-	-r|--r|--re|--res|--reso|--resol|--resolv|--resolve|--resolved)
-	resolved=3Dt; shift ;;
-
-	--sk|--ski|--skip)
-	skip=3Dt; shift ;;
-
-	--whitespace=3D*)
-	ws=3D$1; shift ;;
-
-	--resolvemsg=3D*)
-	resolvemsg=3D$(echo "$1" | sed -e "s/^--resolvemsg=3D//"); shift ;;
-
-	--)
-	shift; break ;;
-	-*)
-	usage ;;
-	*)
-	break ;;
-	esac
-done
-
-# If the dotest directory exists, but we have finished applying all th=
e
-# patches in them, clear it out.
-if test -d "$dotest" &&
-   last=3D$(cat "$dotest/last") &&
-   next=3D$(cat "$dotest/next") &&
-   test $# !=3D 0 &&
-   test "$next" -gt "$last"
-then
-   rm -fr "$dotest"
-fi
-
-if test -d "$dotest"
-then
-	test ",$#," =3D ",0," ||
-	die "previous dotest directory $dotest still exists but mbox given."
-	resume=3Dyes
-else
-	# Make sure we are not given --skip nor --resolved
-	test ",$skip,$resolved," =3D ,,, ||
-		die "Resolve operation not in progress, we are not resuming."
-
-	# Start afresh.
-	mkdir -p "$dotest" || exit
-
-	git-mailsplit -d"$prec" -o"$dotest" -b -- "$@" > "$dotest/last" ||  {
-		rm -fr "$dotest"
-		exit 1
-	}
-
-	# -b, -s, -u, -k and --whitespace flags are kept for the
-	# resuming session after a patch failure.
-	# -3 and -i can and must be given when resuming.
-	echo "$binary" >"$dotest/binary"
-	echo " $ws" >"$dotest/whitespace"
-	echo "$sign" >"$dotest/sign"
-	echo "$utf8" >"$dotest/utf8"
-	echo "$keep" >"$dotest/keep"
-	echo 1 >"$dotest/next"
-fi
-
-case "$resolved" in
-'')
-	files=3D$(git-diff-index --cached --name-only HEAD) || exit
-	if [ "$files" ]; then
-	   echo "Dirty index: cannot apply patches (dirty: $files)" >&2
-	   exit 1
-	fi
-esac
-
-if test "$(cat "$dotest/binary")" =3D t
-then
-	binary=3D--allow-binary-replacement
-fi
-if test "$(cat "$dotest/utf8")" =3D t
-then
-	utf8=3D-u
-fi
-if test "$(cat "$dotest/keep")" =3D t
-then
-	keep=3D-k
-fi
-ws=3D`cat "$dotest/whitespace"`
-if test "$(cat "$dotest/sign")" =3D t
-then
-	SIGNOFF=3D`git-var GIT_COMMITTER_IDENT | sed -e '
-			s/>.*/>/
-			s/^/Signed-off-by: /'
-		`
-else
-	SIGNOFF=3D
-fi
-
-last=3D`cat "$dotest/last"`
-this=3D`cat "$dotest/next"`
-if test "$skip" =3D t
-then
-	this=3D`expr "$this" + 1`
-	resume=3D
-fi
-
-if test "$this" -gt "$last"
-then
-	echo Nothing to do.
-	rm -fr "$dotest"
-	exit
-fi
-
-while test "$this" -le "$last"
-do
-	msgnum=3D`printf "%0${prec}d" $this`
-	next=3D`expr "$this" + 1`
-	test -f "$dotest/$msgnum" || {
-		resume=3D
-		go_next
-		continue
-	}
-
-	# If we are not resuming, parse and extract the patch information
-	# into separate files:
-	#  - info records the authorship and title
-	#  - msg is the rest of commit log message
-	#  - patch is the patch body.
-	#
-	# When we are resuming, these files are either already prepared
-	# by the user, or the user can tell us to do so by --resolved flag.
-	case "$resume" in
-	'')
-		git-mailinfo $keep $utf8 "$dotest/msg" "$dotest/patch" \
-			<"$dotest/$msgnum" >"$dotest/info" ||
-			stop_here $this
-		git-stripspace < "$dotest/msg" > "$dotest/msg-clean"
-		;;
-	esac
-
-	GIT_AUTHOR_NAME=3D"$(sed -n '/^Author/ s/Author: //p' "$dotest/info")=
"
-	GIT_AUTHOR_EMAIL=3D"$(sed -n '/^Email/ s/Email: //p' "$dotest/info")"
-	GIT_AUTHOR_DATE=3D"$(sed -n '/^Date/ s/Date: //p' "$dotest/info")"
-
-	if test -z "$GIT_AUTHOR_EMAIL"
-	then
-		echo "Patch does not have a valid e-mail address."
-		stop_here $this
-	fi
-
-	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
-
-	SUBJECT=3D"$(sed -n '/^Subject/ s/Subject: //p' "$dotest/info")"
-	case "$keep_subject" in -k)  SUBJECT=3D"[PATCH] $SUBJECT" ;; esac
-
-	case "$resume" in
-	'')
-	    if test '' !=3D "$SIGNOFF"
-	    then
-		LAST_SIGNED_OFF_BY=3D`
-		    sed -ne '/^Signed-off-by: /p' \
-		    "$dotest/msg-clean" |
-		    tail -n 1
-		`
-		ADD_SIGNOFF=3D`
-		    test "$LAST_SIGNED_OFF_BY" =3D "$SIGNOFF" || {
-		    test '' =3D "$LAST_SIGNED_OFF_BY" && echo
-		    echo "$SIGNOFF"
-		}`
-	    else
-		ADD_SIGNOFF=3D
-	    fi
-	    {
-		echo "$SUBJECT"
-		if test -s "$dotest/msg-clean"
-		then
-			echo
-			cat "$dotest/msg-clean"
-		fi
-		if test '' !=3D "$ADD_SIGNOFF"
-		then
-			echo "$ADD_SIGNOFF"
-		fi
-	    } >"$dotest/final-commit"
-	    ;;
-	*)
-		case "$resolved$interactive" in
-		tt)
-			# This is used only for interactive view option.
-			git-diff-index -p --cached HEAD >"$dotest/patch"
-			;;
-		esac
-	esac
-
-	resume=3D
-	if test "$interactive" =3D t
-	then
-	    test -t 0 ||
-	    die "cannot be interactive without stdin connected to a terminal.=
"
-	    action=3Dagain
-	    while test "$action" =3D again
-	    do
-		echo "Commit Body is:"
-		echo "--------------------------"
-		cat "$dotest/final-commit"
-		echo "--------------------------"
-		printf "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all "
-		read reply
-		case "$reply" in
-		[yY]*) action=3Dyes ;;
-		[aA]*) action=3Dyes interactive=3D ;;
-		[nN]*) action=3Dskip ;;
-		[eE]*) "${VISUAL:-${EDITOR:-vi}}" "$dotest/final-commit"
-		       action=3Dagain ;;
-		[vV]*) action=3Dagain
-		       LESS=3D-S ${PAGER:-less} "$dotest/patch" ;;
-		*)     action=3Dagain ;;
-		esac
-	    done
-	else
-	    action=3Dyes
-	fi
-
-	if test $action =3D skip
-	then
-		go_next
-		continue
-	fi
-
-	if test -x "$GIT_DIR"/hooks/applypatch-msg
-	then
-		"$GIT_DIR"/hooks/applypatch-msg "$dotest/final-commit" ||
-		stop_here $this
-	fi
-
-	echo
-	echo "Applying '$SUBJECT'"
-	echo
-
-	case "$resolved" in
-	'')
-		git-apply $binary --index $ws "$dotest/patch"
-		apply_status=3D$?
-		;;
-	t)
-		# Resolved means the user did all the hard work, and
-		# we do not have to do any patch application.  Just
-		# trust what the user has in the index file and the
-		# working tree.
-		resolved=3D
-		changed=3D"$(git-diff-index --cached --name-only HEAD)"
-		if test '' =3D "$changed"
-		then
-			echo "No changes - did you forget update-index?"
-			stop_here_user_resolve $this
-		fi
-		unmerged=3D$(git-ls-files -u)
-		if test -n "$unmerged"
-		then
-			echo "You still have unmerged paths in your index"
-			echo "did you forget update-index?"
-			stop_here_user_resolve $this
-		fi
-		apply_status=3D0
-		;;
-	esac
-
-	if test $apply_status =3D 1 && test "$threeway" =3D t
-	then
-		if (fall_back_3way)
-		then
-		    # Applying the patch to an earlier tree and merging the
-		    # result may have produced the same tree as ours.
-		    changed=3D"$(git-diff-index --cached --name-only HEAD)"
-		    if test '' =3D "$changed"
-		    then
-			    echo No changes -- Patch already applied.
-			    go_next
-			    continue
-		    fi
-		    # clear apply_status -- we have successfully merged.
-		    apply_status=3D0
-		fi
-	fi
-	if test $apply_status !=3D 0
-	then
-		echo Patch failed at $msgnum.
-		stop_here_user_resolve $this
-	fi
-
-	if test -x "$GIT_DIR"/hooks/pre-applypatch
-	then
-		"$GIT_DIR"/hooks/pre-applypatch || stop_here $this
-	fi
-
-	tree=3D$(git-write-tree) &&
-	echo Wrote tree $tree &&
-	parent=3D$(git-rev-parse --verify HEAD) &&
-	commit=3D$(git-commit-tree $tree -p $parent <"$dotest/final-commit") =
&&
-	echo Committed: $commit &&
-	git-update-ref -m "am: $SUBJECT" HEAD $commit $parent ||
-	stop_here $this
-
-	if test -x "$GIT_DIR"/hooks/post-applypatch
-	then
-		"$GIT_DIR"/hooks/post-applypatch
-	fi
-
-	go_next
-done
-
-rm -fr "$dotest"
diff --git a/git.c b/git.c
index 652e3c4..b9261e4 100644
--- a/git.c
+++ b/git.c
@@ -184,7 +184,8 @@ static void handle_internal_command(int=20
 		{ "mailinfo", cmd_mailinfo },
 		{ "stripspace", cmd_stripspace },
 		{ "update-index", cmd_update_index },
-		{ "update-ref", cmd_update_ref }
+		{ "update-ref", cmd_update_ref },
+		{ "am", cmd_am }
 	};
 	int i;
=20
--=20
1.4.0
