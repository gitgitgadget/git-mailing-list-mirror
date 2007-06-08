From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH] Port git-tag.sh to C.
Date: Fri,  8 Jun 2007 17:38:50 -0400
Message-ID: <1181338730800-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 23:39:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwmAe-0004Rj-25
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 23:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089AbXFHVi7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 8 Jun 2007 17:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753595AbXFHVi6
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 17:38:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46393 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750969AbXFHVi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 17:38:57 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l58LcuHe030993
	for <git@vger.kernel.org>; Fri, 8 Jun 2007 17:38:56 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l58Lcu3j012296;
	Fri, 8 Jun 2007 17:38:56 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l58LctQq031188;
	Fri, 8 Jun 2007 17:38:55 -0400
X-Mailer: git-send-email 1.5.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49507>

A more or less straight-forward port of git-tag.sh to C.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---

There's two behavioral changes here: git tag with no arguments behaves =
like
git branch with no arguments; it lists all tags.  The other change is
an empty line in the tag message template to make it look more like the
commit message template.

cheers,
Kristian
=20

 Makefile      |    3 +-
 builtin-tag.c |  364 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 builtin.h     |    1 +
 git-tag.sh    |  183 -----------------------------
 git.c         |    1 +
 5 files changed, 368 insertions(+), 184 deletions(-)
 create mode 100644 builtin-tag.c
 delete mode 100755 git-tag.sh

diff --git a/Makefile b/Makefile
index 0f75955..bb1bed1 100644
--- a/Makefile
+++ b/Makefile
@@ -205,7 +205,7 @@ SCRIPT_SH =3D \
 	git-pull.sh git-rebase.sh \
 	git-repack.sh git-request-pull.sh git-reset.sh \
 	git-sh-setup.sh \
-	git-tag.sh git-verify-tag.sh \
+	git-verify-tag.sh \
 	git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh \
@@ -372,6 +372,7 @@ BUILTIN_OBJS =3D \
 	builtin-show-branch.o \
 	builtin-stripspace.o \
 	builtin-symbolic-ref.o \
+	builtin-tag.o \
 	builtin-tar-tree.o \
 	builtin-unpack-objects.o \
 	builtin-update-index.o \
diff --git a/builtin-tag.c b/builtin-tag.c
new file mode 100644
index 0000000..06eafc0
--- /dev/null
+++ b/builtin-tag.c
@@ -0,0 +1,364 @@
+/*
+ * Builtin "git tag"
+ *
+ * Copyright (c) 2007 Kristian H=C3=B8gsberg <krh@redhat.com>
+ * Based on git-tag.sh and mktag.c by Linus Torvalds.
+ */
+
+#include "cache.h"
+#include "refs.h"
+#include "commit.h"
+#include "builtin.h"
+#include "tag.h"
+#include "run-command.h"
+
+static const char builtin_tag_usage[] =3D
+  "git-tag [-n [<num>]] -l [<pattern>] | [-a | -s | -u <key-id>] [-f |=
 -d | -v] [-m <msg>] <tagname> [<head>]";
+
+static char signingkey[1000];
+
+static int launch_editor(const char *path, const char *template,
+			  char *buffer, size_t size)
+{
+	struct child_process child;
+	const char *editor;
+	const char *args[3];
+	char *eol;
+	int len, fd, blank_lines, i, j;
+
+	fd =3D open(path, O_CREAT | O_TRUNC | O_WRONLY, 0644);
+	if (fd < 0)
+		die("could not create file %s.", path);
+
+	len =3D strlen(template);
+	write_or_die(fd, template, len);
+	close(fd);
+
+	editor =3D getenv("VISUAL");
+	if (!editor)
+		editor =3D getenv("EDITOR");
+	if (!editor)
+		editor =3D "vi";
+	   =20
+	memset(&child, 0, sizeof(child));
+	child.argv =3D args;
+	args[0] =3D editor;
+	args[1] =3D path;
+	args[2] =3D NULL;
+
+	if (run_command(&child))
+		die("could not launch editor %s.", editor);
+
+	fd =3D open(path, O_RDONLY, 0644);
+	if (fd =3D=3D -1)
+		die("could not read %s.", path);
+	len =3D read_in_full(fd, buffer, size);
+	if (len < 0)
+		die("failed to read '%s', %m", path);
+	close(fd);
+
+	blank_lines =3D 1;
+	for (i =3D 0, j =3D 0; i < len; i++) {
+		if (blank_lines > 0 && buffer[i] =3D=3D '#') {
+			eol =3D strchr(buffer + i, '\n');
+			if (!eol)
+				break;
+
+			i =3D eol - buffer;
+			continue;
+		}
+
+		if (buffer[i] =3D=3D '\n') {
+			blank_lines++;
+			if (blank_lines > 1)
+				continue;
+		} else {
+			if (blank_lines > 2)
+				buffer[j++] =3D '\n';
+			blank_lines =3D 0;
+		}
+
+		buffer[j++] =3D buffer[i];
+	}
+
+	if (buffer[j - 1] !=3D '\n')
+		buffer[j++] =3D '\n';
+
+	unlink(path);
+
+	return j;
+}
+
+static int show_reference(const char *refname, const unsigned char *sh=
a1,
+			  int flag, void *cb_data)
+{
+	const char *pattern =3D cb_data;
+
+	if (pattern =3D=3D NULL || !fnmatch(pattern, refname, 0))
+		printf("%s\n", refname);
+
+	return 0;
+}
+
+static int list_tags(const char *pattern)
+{
+	for_each_tag_ref(show_reference, (void *) pattern);
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
+		if (!delete_ref(ref, sha1))
+			printf("Deleted tag '%s'\n", *p);
+	}
+		=09
+	return had_error;
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
+
+		printf("FIXME: verify tag '%s'\n", *p);
+	}
+
+	return had_error;
+}
+
+static int do_sign(char *buffer, size_t size, size_t max)
+{
+	struct child_process gpg;
+	const char *args[5];
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
+	args[1] =3D "-bsa";
+	args[2] =3D "-u";
+	args[3] =3D signingkey;
+	args[4] =3D NULL;
+	=09
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
+int git_tag_config(const char *var, const char *value)
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
+int cmd_tag(int argc, const char **argv, const char *prefix)
+{
+	char buffer[4096];
+	unsigned char object[20], prev[20], result[20];
+	int annotate =3D 0, is_signed =3D 0, force =3D 0, lines =3D 0;
+	const char *message =3D NULL;
+	char ref[PATH_MAX];
+	const char *object_ref, *tag;
+	int i, body, header, total, fd;
+	enum object_type type;
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
+			is_signed =3D 1;
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
+				/* FIXME, fallback to 1 on invalid integer */
+				lines =3D atoi(argv[i + 1]);
+			continue;
+		}
+		if (!strcmp(arg, "-m")) {
+			annotate =3D 1;
+			i++;
+			if  (i =3D=3D argc)
+				die("option -m needs an argument.");
+			message =3D argv[i];
+			continue;
+		}
+		if (!strcmp(arg, "-F")) {
+			annotate =3D 1;
+			i++;
+			if  (i =3D=3D argc)
+				die("option -F needs an argument.");
+
+			fd =3D open(argv[i], O_RDONLY);
+			if (fd < 0)
+				die("cannot open %s", argv[1]);
+
+			message =3D xmalloc(4096);
+			if (read_in_full(fd, (char *) message, 4096) < 0)
+				die("cannot read %s", argv[1]);
+			continue;
+		}
+		if (!strcmp(arg, "-u")) {
+			annotate =3D 1;
+			is_signed =3D 1;
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
+	if (i < argc)
+		object_ref =3D argv[i];
+	else
+		object_ref =3D "HEAD";
+
+	if (get_sha1(object_ref, object))
+		die("Failed to resolve '%s' as a valid ref.", object_ref);
+
+	if (snprintf(ref, sizeof ref, "refs/tags/%s", tag) > sizeof ref)
+		die("tag '%s' too long.", tag);
+	if (check_ref_format(ref))
+		die("'%s' is not a valid tag name.", tag);
+	if (resolve_ref(ref, prev, 1, NULL)) {
+		if (!force)
+			die("tag '%s' already exists", tag);
+	} else {
+		hashclr(prev);
+	}
+
+	type =3D sha1_object_info(object, NULL);
+	if (type <=3D 0)
+	    die("bad object type.");
+
+	header =3D snprintf(buffer, sizeof buffer,
+			  "object %s\n"
+			  "type %s\n"
+			  "tag %s\n"
+			  "tagger %s\n\n",
+			  sha1_to_hex(object),
+			  typename(type),
+			  tag,
+			  git_committer_info(1));
+
+	if (annotate && message =3D=3D NULL)
+		body =3D launch_editor(git_path("TAGMSG"), tag_template,
+				     buffer + header, sizeof buffer - header);
+	else if (annotate)
+		body =3D snprintf(buffer + header, sizeof buffer - header,
+				"%s\n", message);
+	else
+		body =3D 0;
+
+	if (annotate && body =3D=3D 0)
+		die("no tag message?");
+
+	if (header + body > sizeof buffer)
+		die("tag message too big.");
+
+	if (is_signed)
+		total =3D do_sign(buffer, header + body, sizeof buffer);
+	else
+		total =3D header + body;
+
+	if (write_sha1_file(buffer, total, tag_type, result) < 0)
+		die("unable to write tag file");
+
+	lock =3D lock_any_ref_for_update(ref, prev, 0);
+	if (!lock)
+		die("%s: cannot lock the ref", ref);
+	if (write_ref_sha1(lock, result, NULL) < 0)
+		die("%s: cannot update the ref", ref);
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 39290d1..91166e1 100644
--- a/builtin.h
+++ b/builtin.h
@@ -72,6 +72,7 @@ extern int cmd_show(int argc, const char **argv, cons=
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
index 37cee97..0000000
--- a/git-tag.sh
+++ /dev/null
@@ -1,183 +0,0 @@
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
-	;;
-    -s)
-	annotate=3D1
-	signed=3D1
-	;;
-    -f)
-	force=3D1
-	;;
-    -n)
-        case $2 in
-	-*)	LINES=3D1 	# no argument
-		;;
-	*)	shift
-		LINES=3D$(expr "$1" : '\([0-9]*\)')
-		[ -z "$LINES" ] && LINES=3D1 # 1 line is default when -n is used
-		;;
-	esac
-	;;
-    -l)
-	list=3D1
-	shift
-	PATTERN=3D"$1"	# select tags by shell pattern, not re
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
-		tag)	ANNOTATION=3D$(git cat-file tag "$TAG" |
-				       sed -e '1,/^$/d' \
-					   -e '/^-----BEGIN PGP SIGNATURE-----$/Q' )
-			printf "%-15s %s\n" "$TAG" "$ANNOTATION" |
-			  sed -e '2,$s/^/    /' \
-			      -e "${LINES}q"
-			;;
-		*)      echo "$TAG"
-			;;
-		esac
-	    done
-	;;
-    -m)
-    	annotate=3D1
-	shift
-	message=3D"$1"
-	if test "$#" =3D "0"; then
-	    die "error: option -m needs an argument"
-	else
-	    message_given=3D1
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
-	fi
-	;;
-    -u)
-	annotate=3D1
-	signed=3D1
-	shift
-	username=3D"$1"
-	;;
-    -d)
-    	shift
-	had_error=3D0
-	for tag
-	do
-		cur=3D$(git-show-ref --verify --hash -- "refs/tags/$tag") || {
-			echo >&2 "Seriously, what tag are you talking about?"
-			had_error=3D1
-			continue
-		}
-		git-update-ref -m 'tag: delete' -d "refs/tags/$tag" "$cur" || {
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
-	tag=3D$(git-show-ref --verify --hash -- "refs/tags/$tag_name") ||
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
-    shift
-done
-
-[ -n "$list" ] && exit 0
-
-name=3D"$1"
-[ "$name" ] || usage
-prev=3D0000000000000000000000000000000000000000
-if git-show-ref --verify --quiet -- "refs/tags/$name"
-then
-    test -n "$force" || die "tag '$name' already exists"
-    prev=3D`git rev-parse "refs/tags/$name"`
-fi
-shift
-git-check-ref-format "tags/$name" ||
-	die "we do not like '$name' as a tag name."
-
-object=3D$(git-rev-parse --verify --default HEAD "$@") || exit 1
-type=3D$(git-cat-file -t $object) || exit 1
-tagger=3D$(git-var GIT_COMMITTER_IDENT) || exit 1
-
-test -n "$username" ||
-	username=3D$(git-repo-config user.signingkey) ||
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
-    git-stripspace >"$GIT_DIR"/TAG_FINALMSG
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
-
diff --git a/git.c b/git.c
index 29b55a1..c9c20fb 100644
--- a/git.c
+++ b/git.c
@@ -285,6 +285,7 @@ static void handle_internal_command(int argc, const=
 char **argv, char **envp)
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
 		{ "stripspace", cmd_stripspace },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
+		{ "tag", cmd_tag, RUN_SETUP },
 		{ "tar-tree", cmd_tar_tree },
 		{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
 		{ "update-index", cmd_update_index, RUN_SETUP },
--=20
1.5.2.1.134.g447c2
