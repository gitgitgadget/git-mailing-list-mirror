From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH 2/2] Make git-tag a builtin.
Date: Wed, 11 Jul 2007 20:54:13 +0200
Message-ID: <46952755.2050307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?windows-1252?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 20:54:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8hKY-0000RB-JV
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 20:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757286AbXGKSyV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 11 Jul 2007 14:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757145AbXGKSyU
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 14:54:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:35616 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbXGKSyS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 14:54:18 -0400
Received: by ug-out-1314.google.com with SMTP id j3so179096ugf
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 11:54:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=qpTY2HkdixPagrrjWTBISbozKbZ9kMR8SULowQ92CDW+fTaKMKYqXyPVrsQtkFzF0Fzx3JZIWZ250ZJRI0AsSiqaXpMfRndsdQIc1cgOzKYDlEoynFgPP14f9NwmKPCKXiJJnhYfirKAuOL9fgfxQxdNI/WQkUhnlX60FsBUgxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=G9GgPJJYNzHKzGKKnak12fhhYzCCL1H534fm9YiuHRPyJOynTw6sb3bQ8qiBg1KlzpwdnwiT63DDWNWd2wECCdGpgXhiyMWXR5vPH7NHxpj9rOZOO68JWPxZd+VPkJuJZYkl6DodeA3x5DThrcHygawTY58Ncs1waOUH2hz0XRw=
Received: by 10.66.236.13 with SMTP id j13mr621132ugh.1184180057152;
        Wed, 11 Jul 2007 11:54:17 -0700 (PDT)
Received: from ?192.168.0.194? ( [212.145.102.186])
        by mx.google.com with ESMTPS id m1sm423571ugc.2007.07.11.11.54.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Jul 2007 11:54:16 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52188>

This replaces the script "git-tag.sh" with "builtin-tag.c".
It is based in a previous work on it from Kristian H=F8gsberg.

There are some minor changes in the behaviour of "git tag" here:
"git tag -v" now can get more than one tag to verify, like "git tag -d"=
 did,
"git tag" with no arguments prints all tags, more like "git branch" doe=
s, and
the template for the edited message adds an empty line, like in "git co=
mmit".

The program is now calling to the script "git verify-tag" for verify,
something that should be changed porting it to C and calling its functi=
ons
directly from builtin-tag.c.

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---

  As said, "git verify-tag" should be replaced with "git tag" for
  verify tags, since both do the same job.  The builtin "git mktag"
  is another candidate to be replaced with "git tag", however
  it is now an essential part of the "plumbing" family doing
  a neat thing not easily replaceable.

  The function launch_editor is copied and modified from the initial wo=
rk
  from Kristian on builtin-commit.c, so we expect share that code on
  both builtins when it is finnished.

 Makefile      |    3 +-
 builtin-tag.c |  430 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 builtin.h     |    1 +
 git-tag.sh    |  205 ---------------------------
 git.c         |    1 +
 5 files changed, 434 insertions(+), 206 deletions(-)
 create mode 100644 builtin-tag.c
 delete mode 100755 git-tag.sh

diff --git a/Makefile b/Makefile
index d7541b4..f0da8f7 100644
--- a/Makefile
+++ b/Makefile
@@ -207,7 +207,7 @@ SCRIPT_SH =3D \
 	git-pull.sh git-rebase.sh git-rebase--interactive.sh \
 	git-repack.sh git-request-pull.sh git-reset.sh \
 	git-sh-setup.sh \
-	git-tag.sh git-verify-tag.sh \
+	git-verify-tag.sh \
 	git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh \
@@ -376,6 +376,7 @@ BUILTIN_OBJS =3D \
 	builtin-show-branch.o \
 	builtin-stripspace.o \
 	builtin-symbolic-ref.o \
+	builtin-tag.o \
 	builtin-tar-tree.o \
 	builtin-unpack-objects.o \
 	builtin-update-index.o \
diff --git a/builtin-tag.c b/builtin-tag.c
new file mode 100644
index 0000000..1824379
--- /dev/null
+++ b/builtin-tag.c
@@ -0,0 +1,430 @@
+/*
+ * Builtin "git tag"
+ *
+ * Copyright (c) 2007 Kristian H=C3=9Egsberg <krh@redhat.com>,
+ *                    Carlos Rica <jasampler@gmail.com>
+ * Based on git-tag.sh and mktag.c by Linus Torvalds.
+ */
+
+#include "cache.h"
+#include "builtin.h"
+#include "refs.h"
+#include "tag.h"
+#include "run-command.h"
+
+static const char builtin_tag_usage[] =3D
+  "git-tag [-n [<num>]] -l [<pattern>] | [-a | -s | -u <key-id>] [-f |=
 -d | -v] [-m <msg>] <tagname> [<head>]";
+
+static char signingkey[1000];
+static int lines;
+
+static void launch_editor(const char *path, char **buffer, unsigned lo=
ng *len)
+{
+	const char *editor, *terminal;
+	struct child_process child;
+	const char *args[3];
+	int fd;
+
+	editor =3D getenv("VISUAL");
+	if (!editor)
+		editor =3D getenv("EDITOR");
+
+	terminal =3D getenv("TERM");
+	if (!editor && (!terminal || !strcmp(terminal, "dumb"))) {
+		fprintf(stderr,
+		"Terminal is dumb but no VISUAL nor EDITOR defined.\n"
+		"Please supply the message using either -m or -F option.\n");
+		exit(1);
+	}
+
+	if (!editor)
+		editor =3D "vi";
+
+	memset(&child, 0, sizeof(child));
+	child.argv =3D args;
+	args[0] =3D editor;
+	args[1] =3D path;
+	args[2] =3D NULL;
+
+	if (run_command(&child))
+		die("could not launch editor %s.", editor);
+
+	fd =3D open(path, O_RDONLY);
+	if (fd =3D=3D -1)
+		die("could not read %s.", path);
+	if (read_pipe(fd, buffer, len))
+		die("could not read message file '%s': %s",
+		    path, strerror(errno));
+	close(fd);
+}
+
+#define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
+
+static int show_reference(const char *refname, const unsigned char *sh=
a1,
+			  int flag, void *cb_data)
+{
+	const char *pattern =3D cb_data;
+
+	if (!fnmatch(pattern, refname, 0)) {
+		int i;
+		unsigned long size;
+		enum object_type type;
+		char *buf, *sp, *eol;
+		size_t len;
+
+		if (!lines) {
+			printf("%s\n", refname);
+			return 0;
+		}
+		printf("%-15s ", refname);
+
+		sp =3D buf =3D read_sha1_file(sha1, &type, &size);
+		if (!buf || !size)
+			return 0;
+		/* skip header */
+		while (sp + 1 < buf + size &&
+				!(sp[0] =3D=3D '\n' && sp[1] =3D=3D '\n'))
+			sp++;
+		/* only take up to "lines" lines, and strip the signature */
+		for (i =3D 0, sp +=3D 2; i < lines && sp < buf + size &&
+				prefixcmp(sp, PGP_SIGNATURE "\n");
+				i++) {
+			if (i)
+				printf("\n    ");
+			eol =3D memchr(sp, '\n', size - (sp - buf));
+			len =3D eol ? eol - sp : size - (sp - buf);
+			fwrite(sp, len, 1, stdout);
+			if (!eol)
+				break;
+			sp =3D eol + 1;
+		}
+		putchar('\n');
+		free(buf);
+	}
+
+	return 0;
+}
+
+static int list_tags(const char *pattern)
+{
+	char *newpattern;
+
+	if (pattern =3D=3D NULL)
+		pattern =3D "";
+
+	/* prepend/append * to the shell pattern: */
+	newpattern =3D xmalloc(strlen(pattern) + 3);
+	sprintf(newpattern, "*%s*", pattern);
+
+	for_each_tag_ref(show_reference, (void *) newpattern);
+
+	free(newpattern);
+
+	return 0;
+}
+
+
+static int delete_tags(const char **argv)
+{
+	const char **p;
+	char ref[PATH_MAX];
+	int had_error =3D 0;
+	unsigned char sha1[20];
+
+	for (p =3D argv; *p; p++) {
+		if (snprintf(ref, sizeof ref, "refs/tags/%s", *p) > sizeof ref)
+			die("tag name '%s' too long.", *p);
+		if (!resolve_ref(ref, sha1, 1, NULL)) {
+			fprintf(stderr, "tag '%s' not found.\n", *p);
+			had_error =3D 1;
+			continue;
+		}
+
+		if (delete_ref(ref, sha1))
+			had_error =3D 1;
+		else
+			printf("Deleted tag '%s'\n", *p);
+	}
+
+	return had_error;
+}
+
+static int run_verify_tag_command(unsigned char *sha1)
+{
+	int ret;
+	const char *argv_verify_tag[] =3D {"git-verify-tag",
+					"-v", "SHA1_HEX", NULL};
+	argv_verify_tag[2] =3D sha1_to_hex(sha1);
+
+	ret =3D run_command_v_opt(argv_verify_tag, 0);
+
+	if (ret <=3D -10000)
+		die("unable to run %s\n", argv_verify_tag[0]);
+	return -ret;
+}
+
+static int verify_tags(const char **argv)
+{
+	const char **p;
+	char ref[PATH_MAX];
+	int had_error =3D 0;
+	unsigned char sha1[20];
+
+	for (p =3D argv; *p; p++) {
+		if (snprintf(ref, sizeof ref, "refs/tags/%s", *p) > sizeof ref)
+			die("tag name '%s' too long.", *p);
+
+		if (!resolve_ref(ref, sha1, 1, NULL)) {
+			fprintf(stderr, "tag '%s' not found.\n", *p);
+			had_error =3D 1;
+			continue;
+		}
+		if (run_verify_tag_command(sha1))
+			had_error =3D 1;
+	}
+
+	return had_error;
+}
+
+static int do_sign(char *buffer, size_t size, size_t max)
+{
+	struct child_process gpg;
+	const char *args[4];
+	char *bracket;
+	int len;
+
+	if (signingkey[0] =3D=3D '\0') {
+		strlcpy(signingkey, git_committer_info(1), sizeof signingkey);
+		bracket =3D strchr(signingkey, '>');
+		if (bracket)
+			bracket[1] =3D '\0';
+	}
+
+	memset(&gpg, 0, sizeof(gpg));
+	gpg.argv =3D args;
+	gpg.in =3D -1;
+	gpg.out =3D -1;
+	args[0] =3D "gpg";
+	args[1] =3D "-bsau";
+	args[2] =3D signingkey;
+	args[3] =3D NULL;
+
+	if (start_command(&gpg))
+		die("could not run gpg.");
+
+	write_or_die(gpg.in, buffer, size);
+	close(gpg.in);
+	gpg.close_in =3D 0;
+	len =3D read_in_full(gpg.out, buffer + size, max - size);
+
+	finish_command(&gpg);
+
+	return size + len;
+}
+
+static const char tag_template[] =3D
+	"\n"
+	"#\n"
+	"# Write a tag message\n"
+	"#\n";
+
+static int git_tag_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "user.signingkey")) {
+		if (!value)
+			die("user.signingkey without value");
+		strlcpy(signingkey, value, sizeof signingkey);
+		return 0;
+	}
+
+	return git_default_config(var, value);
+}
+
+#define MAX_SIGNATURE_LENGTH 1024
+/* message must be NULL or allocated, it will be reallocated and freed=
 */
+static void create_tag(const unsigned char *object, const char *tag,
+		       char *message, int sign, unsigned char *result)
+{
+	enum object_type type;
+	char header_buf[1024], *buffer;
+	int header_len, max_size;
+	unsigned long size;
+
+	type =3D sha1_object_info(object, NULL);
+	if (type <=3D 0)
+	    die("bad object type.");
+
+	header_len =3D snprintf(header_buf, sizeof header_buf,
+			  "object %s\n"
+			  "type %s\n"
+			  "tag %s\n"
+			  "tagger %s\n\n",
+			  sha1_to_hex(object),
+			  typename(type),
+			  tag,
+			  git_committer_info(1));
+
+	if (header_len >=3D sizeof header_buf)
+		die("tag header too big.");
+
+	if (!message) {
+		char *path;
+		int fd;
+
+		/* write the template message before editing: */
+		path =3D xstrdup(git_path("TAG_EDITMSG"));
+		fd =3D open(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
+		if (fd < 0)
+			die("could not create file %s.", path);
+		write_or_die(fd, tag_template, strlen(tag_template));
+		close(fd);
+
+		launch_editor(path, &buffer, &size);
+
+		unlink(path);
+		free(path);
+	}
+	else {
+		buffer =3D message;
+		size =3D strlen(message);
+	}
+
+	size =3D stripspace(buffer, size, 1);
+
+	if (!message && !size)
+		die("no tag message?");
+
+	/* insert the header and add the '\n' if needed: */
+	max_size =3D header_len + size + (sign ? MAX_SIGNATURE_LENGTH : 0) + =
1;
+	buffer =3D xrealloc(buffer, max_size);
+	if (size)
+		buffer[size++] =3D '\n';
+	memmove(buffer + header_len, buffer, size);
+	memcpy(buffer, header_buf, header_len);
+	size +=3D header_len;
+
+	if (sign)
+		size =3D do_sign(buffer, size, max_size);
+
+	if (write_sha1_file(buffer, size, tag_type, result) < 0)
+		die("unable to write tag file");
+	free(buffer);
+}
+
+int cmd_tag(int argc, const char **argv, const char *prefix)
+{
+	unsigned char object[20], prev[20];
+	int annotate =3D 0, sign =3D 0, force =3D 0;
+	char *message =3D NULL;
+	char ref[PATH_MAX];
+	const char *object_ref, *tag;
+	int i, fd;
+	struct ref_lock *lock;
+
+	git_config(git_tag_config);
+
+	for (i =3D 1; i < argc; i++) {
+		const char *arg =3D argv[i];
+
+		if (arg[0] !=3D '-')
+			break;
+		if (!strcmp(arg, "-a")) {
+			annotate =3D 1;
+			continue;
+		}
+		if (!strcmp(arg, "-s")) {
+			annotate =3D 1;
+			sign =3D 1;
+			continue;
+		}
+		if (!strcmp(arg, "-f")) {
+			force =3D 1;
+			continue;
+		}
+		if (!strcmp(arg, "-n")) {
+			if (i + 1 =3D=3D argc || *argv[i + 1] =3D=3D '-')
+				/* no argument */
+				lines =3D 1;
+			else
+				lines =3D isdigit(*argv[++i]) ?
+					atoi(argv[i]) : 1;
+			continue;
+		}
+		if (!strcmp(arg, "-m")) {
+			annotate =3D 1;
+			i++;
+			if  (i =3D=3D argc)
+				die("option -m needs an argument.");
+			message =3D xstrdup(argv[i]);
+			continue;
+		}
+		if (!strcmp(arg, "-F")) {
+			unsigned long len;
+			annotate =3D 1;
+			i++;
+			if  (i =3D=3D argc)
+				die("option -F needs an argument.");
+
+			fd =3D open(argv[i], O_RDONLY);
+			if (fd < 0)
+				die("cannot open %s", argv[1]);
+
+			len =3D 1024;
+			message =3D xmalloc(len);
+			if (read_pipe(fd, &message, &len))
+				die("cannot read %s", argv[1]);
+			message =3D xrealloc(message, len + 1);
+			message[len] =3D '\0';
+			continue;
+		}
+		if (!strcmp(arg, "-u")) {
+			annotate =3D 1;
+			sign =3D 1;
+			i++;
+			if  (i =3D=3D argc)
+				die("option -u needs an argument.");
+			strlcpy(signingkey, argv[i], sizeof signingkey);
+			continue;
+		}
+		if (!strcmp(arg, "-l")) {
+			return list_tags(argv[i + 1]);
+		}
+		if (!strcmp(arg, "-d")) {
+			return delete_tags(argv + i + 1);
+		}
+		if (!strcmp(arg, "-v")) {
+			return verify_tags(argv + i + 1);
+		}
+		usage(builtin_tag_usage);
+	}
+
+	if (i =3D=3D argc)
+		return list_tags(NULL);
+	tag =3D argv[i++];
+
+	object_ref =3D i < argc ? argv[i] : "HEAD";
+
+	if (get_sha1(object_ref, object))
+		die("Failed to resolve '%s' as a valid ref.", object_ref);
+
+	if (snprintf(ref, sizeof ref, "refs/tags/%s", tag) > sizeof ref)
+		die("tag '%s' too long.", tag);
+	if (check_ref_format(ref))
+		die("'%s' is not a valid tag name.", tag);
+
+	if (!resolve_ref(ref, prev, 1, NULL))
+		hashclr(prev);
+	else if (!force)
+		die("tag '%s' already exists", tag);
+
+	if (annotate)
+		create_tag(object, tag, message, sign, object);
+
+	lock =3D lock_any_ref_for_update(ref, prev, 0);
+	if (!lock)
+		die("%s: cannot lock the ref", ref);
+	if (write_ref_sha1(lock, object, NULL) < 0)
+		die("%s: cannot update the ref", ref);
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 4cc228d..ac7417f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -70,6 +70,7 @@ extern int cmd_show(int argc, const char **argv, cons=
t char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *pr=
efix);
 extern int cmd_stripspace(int argc, const char **argv, const char *pre=
fix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *p=
refix);
+extern int cmd_tag(int argc, const char **argv, const char *prefix);
 extern int cmd_tar_tree(int argc, const char **argv, const char *prefi=
x);
 extern int cmd_unpack_objects(int argc, const char **argv, const char =
*prefix);
 extern int cmd_update_index(int argc, const char **argv, const char *p=
refix);
diff --git a/git-tag.sh b/git-tag.sh
deleted file mode 100755
index 1c25d88..0000000
--- a/git-tag.sh
+++ /dev/null
@@ -1,205 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2005 Linus Torvalds
-
-USAGE=3D'[-n [<num>]] -l [<pattern>] | [-a | -s | -u <key-id>] [-f | -=
d | -v] [-m <msg>] <tagname> [<head>]'
-SUBDIRECTORY_OK=3D'Yes'
-. git-sh-setup
-
-message_given=3D
-annotate=3D
-signed=3D
-force=3D
-message=3D
-username=3D
-list=3D
-verify=3D
-LINES=3D0
-while case "$#" in 0) break ;; esac
-do
-    case "$1" in
-    -a)
-	annotate=3D1
-	shift
-	;;
-    -s)
-	annotate=3D1
-	signed=3D1
-	shift
-	;;
-    -f)
-	force=3D1
-	shift
-	;;
-    -n)
-        case "$#,$2" in
-	1,* | *,-*)
-		LINES=3D1 	# no argument
-		;;
-	*)	shift
-		LINES=3D$(expr "$1" : '\([0-9]*\)')
-		[ -z "$LINES" ] && LINES=3D1 # 1 line is default when -n is used
-		;;
-	esac
-	shift
-	;;
-    -l)
-	list=3D1
-	shift
-	case $# in
-	0)	PATTERN=3D
-		;;
-	*)
-		PATTERN=3D"$1"	# select tags by shell pattern, not re
-		shift
-		;;
-	esac
-	git rev-parse --symbolic --tags | sort |
-	    while read TAG
-	    do
-	        case "$TAG" in
-		*$PATTERN*) ;;
-		*)	    continue ;;
-		esac
-		[ "$LINES" -le 0 ] && { echo "$TAG"; continue ;}
-		OBJTYPE=3D$(git cat-file -t "$TAG")
-		case $OBJTYPE in
-		tag)
-			ANNOTATION=3D$(git cat-file tag "$TAG" |
-				sed -e '1,/^$/d' |
-				sed -n -e "
-					/^-----BEGIN PGP SIGNATURE-----\$/q
-					2,\$s/^/    /
-					p
-					${LINES}q
-				")
-			printf "%-15s %s\n" "$TAG" "$ANNOTATION"
-			;;
-		*)      echo "$TAG"
-			;;
-		esac
-	    done
-	;;
-    -m)
-	annotate=3D1
-	shift
-	message=3D"$1"
-	if test "$#" =3D "0"; then
-	    die "error: option -m needs an argument"
-	else
-	    message=3D"$1"
-	    message_given=3D1
-	    shift
-	fi
-	;;
-    -F)
-	annotate=3D1
-	shift
-	if test "$#" =3D "0"; then
-	    die "error: option -F needs an argument"
-	else
-	    message=3D"$(cat "$1")"
-	    message_given=3D1
-	    shift
-	fi
-	;;
-    -u)
-	annotate=3D1
-	signed=3D1
-	shift
-	if test "$#" =3D "0"; then
-	    die "error: option -u needs an argument"
-	else
-	    username=3D"$1"
-	    shift
-	fi
-	;;
-    -d)
-	shift
-	had_error=3D0
-	for tag
-	do
-		cur=3D$(git show-ref --verify --hash -- "refs/tags/$tag") || {
-			echo >&2 "Seriously, what tag are you talking about?"
-			had_error=3D1
-			continue
-		}
-		git update-ref -m 'tag: delete' -d "refs/tags/$tag" "$cur" || {
-			had_error=3D1
-			continue
-		}
-		echo "Deleted tag $tag."
-	done
-	exit $had_error
-	;;
-    -v)
-	shift
-	tag_name=3D"$1"
-	tag=3D$(git show-ref --verify --hash -- "refs/tags/$tag_name") ||
-		die "Seriously, what tag are you talking about?"
-	git-verify-tag -v "$tag"
-	exit $?
-	;;
-    -*)
-        usage
-	;;
-    *)
-	break
-	;;
-    esac
-done
-
-[ -n "$list" ] && exit 0
-
-name=3D"$1"
-[ "$name" ] || usage
-prev=3D0000000000000000000000000000000000000000
-if git show-ref --verify --quiet -- "refs/tags/$name"
-then
-    test -n "$force" || die "tag '$name' already exists"
-    prev=3D`git rev-parse "refs/tags/$name"`
-fi
-shift
-git check-ref-format "tags/$name" ||
-	die "we do not like '$name' as a tag name."
-
-object=3D$(git rev-parse --verify --default HEAD "$@") || exit 1
-type=3D$(git cat-file -t $object) || exit 1
-tagger=3D$(git-var GIT_COMMITTER_IDENT) || exit 1
-
-test -n "$username" ||
-	username=3D$(git repo-config user.signingkey) ||
-	username=3D$(expr "z$tagger" : 'z\(.*>\)')
-
-trap 'rm -f "$GIT_DIR"/TAG_TMP* "$GIT_DIR"/TAG_FINALMSG "$GIT_DIR"/TAG=
_EDITMSG' 0
-
-if [ "$annotate" ]; then
-    if [ -z "$message_given" ]; then
-        ( echo "#"
-          echo "# Write a tag message"
-          echo "#" ) > "$GIT_DIR"/TAG_EDITMSG
-        ${VISUAL:-${EDITOR:-vi}} "$GIT_DIR"/TAG_EDITMSG || exit
-    else
-        printf '%s\n' "$message" >"$GIT_DIR"/TAG_EDITMSG
-    fi
-
-    grep -v '^#' <"$GIT_DIR"/TAG_EDITMSG |
-    git stripspace >"$GIT_DIR"/TAG_FINALMSG
-
-    [ -s "$GIT_DIR"/TAG_FINALMSG -o -n "$message_given" ] || {
-	echo >&2 "No tag message?"
-	exit 1
-    }
-
-    ( printf 'object %s\ntype %s\ntag %s\ntagger %s\n\n' \
-	"$object" "$type" "$name" "$tagger";
-      cat "$GIT_DIR"/TAG_FINALMSG ) >"$GIT_DIR"/TAG_TMP
-    rm -f "$GIT_DIR"/TAG_TMP.asc "$GIT_DIR"/TAG_FINALMSG
-    if [ "$signed" ]; then
-	gpg -bsa -u "$username" "$GIT_DIR"/TAG_TMP &&
-	cat "$GIT_DIR"/TAG_TMP.asc >>"$GIT_DIR"/TAG_TMP ||
-	die "failed to sign the tag with GPG."
-    fi
-    object=3D$(git-mktag < "$GIT_DIR"/TAG_TMP)
-fi
-
-git update-ref "refs/tags/$name" "$object" "$prev"
diff --git a/git.c b/git.c
index a647f9c..eb9e5ca 100644
--- a/git.c
+++ b/git.c
@@ -363,6 +363,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
 		{ "stripspace", cmd_stripspace },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
+		{ "tag", cmd_tag, RUN_SETUP },
 		{ "tar-tree", cmd_tar_tree },
 		{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
 		{ "update-index", cmd_update_index, RUN_SETUP },
--=20
1.5.0
