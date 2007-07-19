From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH] Make git tag a builtin.
Date: Fri, 20 Jul 2007 01:42:28 +0200
Message-ID: <469FF6E4.9010501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 20 01:43:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBfeF-00049j-9Y
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 01:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758206AbXGSXnD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 19 Jul 2007 19:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758117AbXGSXnC
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 19:43:02 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:34774 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757642AbXGSXnA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 19:43:00 -0400
Received: by ug-out-1314.google.com with SMTP id j3so516227ugf
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 16:42:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=VMOVjTRN6PxvsxaDeP0b1d2JIigEnAHFVMRxZo9+aCCsvy+aAA30lzLGyr1UY4yw8JVUfKWbVJf4TP88stOfKsj0kHiMK7kGKzaVz7op3E4KDdXiAnvLfZXVxohuj0O+0435z5pY44Bww0hwBD9aqF62vDUEnKlVgv5DUkotimw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=KlqBm0aIrAOLnclTUxWtUc4bhRZzd6yB0xA79OugIYlEkxrnJFUwpQwYQdSGn+N0bJbOWDIG+obg5OsR+y32rNmLWD4+ThBgZ16jDBx6hgR4ehxGnzPqlN3LcvS7FZaHzj3sUSgrk+n2/6O8s8Ywz5OPftk80Gno6jYsPBhzLZM=
Received: by 10.67.119.5 with SMTP id w5mr1514420ugm.1184888577740;
        Thu, 19 Jul 2007 16:42:57 -0700 (PDT)
Received: from ?192.168.0.194? ( [212.145.102.186])
        by mx.google.com with ESMTPS id d23sm2588850nfh.2007.07.19.16.42.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Jul 2007 16:42:55 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53036>

This replaces the script "git-tag.sh" with "builtin-tag.c".

The existing test suite for "git tag" guarantees the compatibility
with the features provided by the script version.

There are some minor changes in the behaviour of "git tag" here:
"git tag -v" now can get more than one tag to verify, like "git tag -d"=
 does,
"git tag" with no arguments prints all tags, more like "git branch" doe=
s,
and "git tag -n" also prints all tags with annotations (without needing=
 -l).
Tests and documentation were also updated to reflect these changes.

The program is currently calling the script "git verify-tag" for verify=
=2E
This can be changed porting it to C and calling its functions directly
from builtin-tag.c.

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---

   This patch is a resend including the suggestions and corrections
   commented by Junio in the previous proposal for builtin-tag.c:
   http://article.gmane.org/gmane.comp.version-control.git/52246

   In this version, a bit of refactoring was also done grouping the com=
mon
   code between the previous functions delete_tags() and verify_tags().

   The function launch_editor will be moved to another file
   (editor.c is the suggested name), along with other tools
   for editing and reading text files, in order to share its code
   wiht other builtins like the upcoming builtin-commit.c from Kristian=
=2E

 Documentation/git-tag.txt                 |    8 +-
 Makefile                                  |    3 +-
 builtin-tag.c                             |  450 +++++++++++++++++++++=
++++++++
 builtin.h                                 |    1 +
 git-tag.sh =3D> contrib/examples/git-tag.sh |    0
 git.c                                     |    1 +
 t/t7004-tag.sh                            |   88 +++++-
 7 files changed, 538 insertions(+), 13 deletions(-)
 create mode 100644 builtin-tag.c
 rename git-tag.sh =3D> contrib/examples/git-tag.sh (100%)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index aee2c1b..119117f 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git-tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]  <name> =
[<head>]
 'git-tag' -d <name>...
 'git-tag' [-n [<num>]] -l [<pattern>]
-'git-tag' -v <name>
+'git-tag' -v <name>...

 DESCRIPTION
 -----------
@@ -23,7 +23,7 @@ Unless `-f` is given, the tag must not yet exist in

 If one of `-a`, `-s`, or `-u <key-id>` is passed, the command
 creates a 'tag' object, and requires the tag message.  Unless
-`-m <msg>` is given, an editor is started for the user to type
+`-m <msg>` or `-F <file>` is given, an editor is started for the user =
to type
 in the tag message.

 Otherwise just the SHA1 object name of the commit object is
@@ -59,15 +59,17 @@ OPTIONS
 	Delete existing tags with the given names.

 -v::
-	Verify the gpg signature of given the tag
+	Verify the gpg signature of the given tag names.

 -n <num>::
 	<num> specifies how many lines from the annotation, if any,
 	are printed when using -l.
 	The default is not to print any annotation lines.
+	If no number is given to `-n`, only the first line is printed.

 -l <pattern>::
 	List tags with names that match the given pattern (or all if no patte=
rn is given).
+	Typing "git tag" without arguments, also lists all tags.

 -m <msg>::
 	Use the given tag message (instead of prompting)
diff --git a/Makefile b/Makefile
index 73b487f..8db6646 100644
--- a/Makefile
+++ b/Makefile
@@ -206,7 +206,7 @@ SCRIPT_SH =3D \
 	git-pull.sh git-rebase.sh git-rebase--interactive.sh \
 	git-repack.sh git-request-pull.sh git-reset.sh \
 	git-sh-setup.sh \
-	git-tag.sh git-verify-tag.sh \
+	git-verify-tag.sh \
 	git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh \
@@ -361,6 +361,7 @@ BUILTIN_OBJS =3D \
 	builtin-show-branch.o \
 	builtin-stripspace.o \
 	builtin-symbolic-ref.o \
+	builtin-tag.o \
 	builtin-tar-tree.o \
 	builtin-unpack-objects.o \
 	builtin-update-index.o \
diff --git a/builtin-tag.c b/builtin-tag.c
new file mode 100644
index 0000000..507f510
--- /dev/null
+++ b/builtin-tag.c
@@ -0,0 +1,450 @@
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
 -d | -v] [-m <msg> | -F <file>] <tagname> [<head>]";
+
+static char signingkey[1000];
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
+		die("There was a problem with the editor %s.", editor);
+
+	fd =3D open(path, O_RDONLY);
+	if (fd < 0)
+		die("could not open '%s': %s", path, strerror(errno));
+	if (read_fd(fd, buffer, len)) {
+		free(*buffer);
+		die("could not read message file '%s': %s",
+						path, strerror(errno));
+	}
+	close(fd);
+}
+
+struct tag_filter {
+	const char *pattern;
+	int lines;
+};
+
+#define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
+
+static int show_reference(const char *refname, const unsigned char *sh=
a1,
+			  int flag, void *cb_data)
+{
+	struct tag_filter *filter =3D cb_data;
+
+	if (!fnmatch(filter->pattern, refname, 0)) {
+		int i;
+		unsigned long size;
+		enum object_type type;
+		char *buf, *sp, *eol;
+		size_t len;
+
+		if (!filter->lines) {
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
+		for (i =3D 0, sp +=3D 2; i < filter->lines && sp < buf + size &&
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
+static int list_tags(const char *pattern, int lines)
+{
+	struct tag_filter filter;
+	char *newpattern;
+
+	if (pattern =3D=3D NULL)
+		pattern =3D "";
+
+	/* prepend/append * to the shell pattern: */
+	newpattern =3D xmalloc(strlen(pattern) + 3);
+	sprintf(newpattern, "*%s*", pattern);
+
+	filter.pattern =3D newpattern;
+	filter.lines =3D lines;
+
+	for_each_tag_ref(show_reference, (void *) &filter);
+
+	free(newpattern);
+
+	return 0;
+}
+
+typedef int (*func_tag)(const char *name, const char *ref,
+				const unsigned char *sha1);
+
+static int do_tag_names(const char **argv, func_tag fn)
+{
+	const char **p;
+	char ref[PATH_MAX];
+	int had_error =3D 0;
+	unsigned char sha1[20];
+
+	for (p =3D argv; *p; p++) {
+		if (snprintf(ref, sizeof(ref), "refs/tags/%s", *p)
+					>=3D sizeof(ref)) {
+			error("tag name too long: %.*s...", 50, *p);
+			had_error =3D 1;
+			continue;
+		}
+		if (!resolve_ref(ref, sha1, 1, NULL)) {
+			error("tag '%s' not found.", *p);
+			had_error =3D 1;
+			continue;
+		}
+		if (fn(*p, ref, sha1))
+			had_error =3D 1;
+	}
+	return had_error;
+}
+
+static int delete_tag(const char *name, const char *ref,
+				const unsigned char *sha1)
+{
+	if (delete_ref(ref, sha1))
+		return 1;
+	printf("Deleted tag '%s'\n", name);
+	return 0;
+}
+
+static int verify_tag(const char *name, const char *ref,
+				const unsigned char *sha1)
+{
+	const char *argv_verify_tag[] =3D {"git-verify-tag",
+					"-v", "SHA1_HEX", NULL};
+	argv_verify_tag[2] =3D sha1_to_hex(sha1);
+
+	if (run_command_v_opt(argv_verify_tag, 0))
+		return error("could not verify the tag '%s'", name);
+	return 0;
+}
+
+static ssize_t do_sign(char *buffer, size_t size, size_t max)
+{
+	struct child_process gpg;
+	const char *args[4];
+	char *bracket;
+	int len;
+
+	if (!*signingkey) {
+		if (strlcpy(signingkey, git_committer_info(1),
+				sizeof(signingkey)) >=3D sizeof(signingkey))
+			return error("committer info too long.");
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
+		return error("could not run gpg.");
+
+	write_or_die(gpg.in, buffer, size);
+	close(gpg.in);
+	gpg.close_in =3D 0;
+	len =3D read_in_full(gpg.out, buffer + size, max - size);
+
+	finish_command(&gpg);
+
+	if (len =3D=3D max - size)
+		return error("could not read the entire signature from gpg.");
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
+		if (strlcpy(signingkey, value, sizeof(signingkey))
+						>=3D sizeof(signingkey))
+			die("user.signingkey value too long");
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
+	header_len =3D snprintf(header_buf, sizeof(header_buf),
+			  "object %s\n"
+			  "type %s\n"
+			  "tag %s\n"
+			  "tagger %s\n\n",
+			  sha1_to_hex(object),
+			  typename(type),
+			  tag,
+			  git_committer_info(1));
+
+	if (header_len >=3D sizeof(header_buf))
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
+			die("could not create file '%s': %s",
+						path, strerror(errno));
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
+	if (sign) {
+		size =3D do_sign(buffer, size, max_size);
+		if (size < 0)
+			die("unable to sign the tag");
+	}
+
+	if (write_sha1_file(buffer, size, tag_type, result) < 0)
+		die("unable to write tag file");
+	free(buffer);
+}
+
+int cmd_tag(int argc, const char **argv, const char *prefix)
+{
+	unsigned char object[20], prev[20];
+	int annotate =3D 0, sign =3D 0, force =3D 0, lines =3D 0;
+	char *message =3D NULL;
+	char ref[PATH_MAX];
+	const char *object_ref, *tag;
+	int i;
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
+			if (i =3D=3D argc)
+				die("option -m needs an argument.");
+			message =3D xstrdup(argv[i]);
+			continue;
+		}
+		if (!strcmp(arg, "-F")) {
+			unsigned long len;
+			int fd;
+
+			annotate =3D 1;
+			i++;
+			if (i =3D=3D argc)
+				die("option -F needs an argument.");
+
+			if (!strcmp(argv[i], "-"))
+				fd =3D 0;
+			else {
+				fd =3D open(argv[i], O_RDONLY);
+				if (fd < 0)
+					die("could not open '%s': %s",
+						argv[i], strerror(errno));
+			}
+			len =3D 1024;
+			message =3D xmalloc(len);
+			if (read_fd(fd, &message, &len)) {
+				free(message);
+				die("cannot read %s", argv[i]);
+			}
+			continue;
+		}
+		if (!strcmp(arg, "-u")) {
+			annotate =3D 1;
+			sign =3D 1;
+			i++;
+			if (i =3D=3D argc)
+				die("option -u needs an argument.");
+			if (strlcpy(signingkey, argv[i], sizeof(signingkey))
+							>=3D sizeof(signingkey))
+				die("argument to option -u too long");
+			continue;
+		}
+		if (!strcmp(arg, "-l")) {
+			return list_tags(argv[i + 1], lines);
+		}
+		if (!strcmp(arg, "-d")) {
+			return do_tag_names(argv + i + 1, delete_tag);
+		}
+		if (!strcmp(arg, "-v")) {
+			return do_tag_names(argv + i + 1, verify_tag);
+		}
+		usage(builtin_tag_usage);
+	}
+
+	if (i =3D=3D argc) {
+		if (annotate)
+			usage(builtin_tag_usage);
+		return list_tags(NULL, lines);
+	}
+	tag =3D argv[i++];
+
+	object_ref =3D i < argc ? argv[i] : "HEAD";
+	if (i + 1 < argc)
+		die("too many params");
+
+	if (get_sha1(object_ref, object))
+		die("Failed to resolve '%s' as a valid ref.", object_ref);
+
+	if (snprintf(ref, sizeof(ref), "refs/tags/%s", tag) >=3D sizeof(ref))
+		die("tag name too long: %.*s...", 50, tag);
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
diff --git a/git-tag.sh b/contrib/examples/git-tag.sh
similarity index 100%
rename from git-tag.sh
rename to contrib/examples/git-tag.sh
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
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 17de2a9..a0be164 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -5,7 +5,7 @@

 test_description=3D'git-tag

-Basic tests for operations with tags.'
+Tests for operations with tags.'

 . ./test-lib.sh

@@ -16,11 +16,15 @@ tag_exists () {
 }

 # todo: git tag -l now returns always zero, when fixed, change this te=
st
-test_expect_success 'listing all tags in an empty tree should succeed'=
 \
-	'git tag -l'
+test_expect_success 'listing all tags in an empty tree should succeed'=
 '
+	git tag -l &&
+	git tag
+'

-test_expect_success 'listing all tags in an empty tree should output n=
othing' \
-	'test `git-tag -l | wc -l` -eq 0'
+test_expect_success 'listing all tags in an empty tree should output n=
othing' '
+	test `git-tag -l | wc -l` -eq 0 &&
+	test `git-tag | wc -l` -eq 0
+'

 test_expect_failure 'looking for a tag in an empty tree should fail' \
 	'tag_exists mytag'
@@ -49,11 +53,15 @@ test_expect_success 'creating a tag using default H=
EAD should succeed' '
 	git tag mytag
 '

-test_expect_success 'listing all tags if one exists should succeed' \
-	'git-tag -l'
+test_expect_success 'listing all tags if one exists should succeed' '
+	git-tag -l &&
+	git-tag
+'

-test_expect_success 'listing all tags if one exists should output that=
 tag' \
-	'test `git-tag -l` =3D mytag'
+test_expect_success 'listing all tags if one exists should output that=
 tag' '
+	test `git-tag -l` =3D mytag &&
+	test `git-tag` =3D mytag
+'

 # pattern matching:

@@ -165,6 +173,8 @@ test_expect_success 'listing all tags should print =
them ordered' '
 	git tag v1.0 &&
 	git tag t210 &&
 	git tag -l > actual &&
+	git diff expect actual &&
+	git tag > actual &&
 	git diff expect actual
 '

@@ -264,6 +274,10 @@ test_expect_failure \
 	'trying to verify a non-annotated and non-signed tag should fail' \
 	'git-tag -v non-annotated-tag'

+test_expect_failure \
+	'trying to verify many non-annotated or unknown tags, should fail' \
+	'git-tag -v unknown-tag1 non-annotated-tag unknown-tag2'
+
 # creating annotated tags:

 get_tag_msg () {
@@ -306,6 +320,18 @@ test_expect_success \
 	git diff expect actual
 '

+cat >inputmsg <<EOF
+A message from the
+standard input
+EOF
+get_tag_header stdin-annotated-tag $commit commit $time >expect
+cat inputmsg >>expect
+test_expect_success 'creating an annotated tag with -F - should succee=
d' '
+	git-tag -F - stdin-annotated-tag <inputmsg &&
+	get_tag_msg stdin-annotated-tag >actual &&
+	git diff expect actual
+'
+
 # blank and empty messages:

 get_tag_header empty-annotated-tag $commit commit $time >expect
@@ -551,6 +577,12 @@ test_expect_success \
 	! git-tag -v file-annotated-tag
 '

+test_expect_success \
+	'trying to verify two annotated non-signed tags should fail' '
+	tag_exists annotated-tag file-annotated-tag &&
+	! git-tag -v annotated-tag file-annotated-tag
+'
+
 # creating and verifying signed tags:

 gpg --version >/dev/null
@@ -589,9 +621,47 @@ test_expect_success 'creating a signed tag with -m=
 message should succeed' '
 	git diff expect actual
 '

+cat >sigmsgfile <<EOF
+Another signed tag
+message in a file.
+EOF
+get_tag_header file-signed-tag $commit commit $time >expect
+cat sigmsgfile >>expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success \
+	'creating a signed tag with -F messagefile should succeed' '
+	git-tag -s -F sigmsgfile file-signed-tag &&
+	get_tag_msg file-signed-tag >actual &&
+	git diff expect actual
+'
+
+cat >siginputmsg <<EOF
+A signed tag message from
+the standard input
+EOF
+get_tag_header stdin-signed-tag $commit commit $time >expect
+cat siginputmsg >>expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success 'creating a signed tag with -F - should succeed' '
+	git-tag -s -F - stdin-signed-tag <siginputmsg &&
+	get_tag_msg stdin-signed-tag >actual &&
+	git diff expect actual
+'
+
 test_expect_success 'verifying a signed tag should succeed' \
 	'git-tag -v signed-tag'

+test_expect_success 'verifying two signed tags in one command should s=
ucceed' \
+	'git-tag -v signed-tag file-signed-tag'
+
+test_expect_success \
+	'verifying many signed and non-signed tags should fail' '
+	! git-tag -v signed-tag annotated-tag &&
+	! git-tag -v file-annotated-tag file-signed-tag &&
+	! git-tag -v annotated-tag file-signed-tag file-annotated-tag &&
+	! git-tag -v signed-tag annotated-tag file-signed-tag
+'
+
 test_expect_success 'verifying a forged tag should fail' '
 	forged=3D$(git cat-file tag signed-tag |
 		sed -e "s/signed-tag/forged-tag/" |
--=20
1.5.0
