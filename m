From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] Make git-branch a builtin
Date: Mon, 23 Oct 2006 23:40:26 +0200
Message-ID: <11616396262982-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: junkio@cox.net, krh@redhat.com
X-From: git-owner@vger.kernel.org Mon Oct 23 23:40:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc7XP-0007Lu-SQ
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 23:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbWJWVkn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 17:40:43 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbWJWVkn
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 17:40:43 -0400
Received: from mail44.e.nsc.no ([193.213.115.44]:23277 "EHLO mail44.e.nsc.no")
	by vger.kernel.org with ESMTP id S1752025AbWJWVkl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 17:40:41 -0400
Received: from localhost.localdomain (ti231210a080-7372.bb.online.no [80.213.28.208])
	by mail44.nsc.no (8.13.8/8.13.5) with ESMTP id k9NLeSQu007649;
	Mon, 23 Oct 2006 23:40:28 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.3.1.g9164-dirty
Date: Mon, 23 Oct 2006 23:27:45 +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29887>

This replaces git-branch.sh with builtin-branch.c

The changes is basically a patch from Kristian H=F8gsberg, updated
to apply onto current 'next'

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Makefile         |    3 +-
 builtin-branch.c |  217 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 builtin.h        |    1 +
 git-branch.sh    |  131 --------------------------------
 git.c            |    1 +
 5 files changed, 221 insertions(+), 132 deletions(-)

diff --git a/Makefile b/Makefile
index 36b9e06..e249d34 100644
--- a/Makefile
+++ b/Makefile
@@ -158,7 +158,7 @@ BASIC_CFLAGS =3D
 BASIC_LDFLAGS =3D
=20
 SCRIPT_SH =3D \
-	git-bisect.sh git-branch.sh git-checkout.sh \
+	git-bisect.sh git-checkout.sh \
 	git-cherry.sh git-clean.sh git-clone.sh git-commit.sh \
 	git-fetch.sh \
 	git-ls-remote.sh \
@@ -270,6 +270,7 @@ BUILTIN_OBJS =3D \
 	builtin-annotate.o \
 	builtin-apply.o \
 	builtin-archive.o \
+	builtin-branch.o \
 	builtin-cat-file.o \
 	builtin-checkout-index.o \
 	builtin-check-ref-format.o \
diff --git a/builtin-branch.c b/builtin-branch.c
new file mode 100755
index 0000000..3105efd
--- /dev/null
+++ b/builtin-branch.c
@@ -0,0 +1,217 @@
+/*
+ * Builtin "git branch"
+ *
+ * Copyright (c) 2006 Kristian H=F8gsberg <krh@redhat.com>
+ * Based on git-branch.sh by Junio C Hamano.
+ */
+
+#include "cache.h"
+#include "refs.h"
+#include "commit.h"
+#include "builtin.h"
+
+static const char builtin_branch_usage[] =3D
+"git-branch [(-d | -D) <branchname>] | [[-f] <branchname> [<start-poin=
t>]] | -r";
+
+
+static const char *head;
+static unsigned char head_sha1[20];
+
+static int in_merge_bases(const unsigned char *sha1,
+			  struct commit *rev1,
+			  struct commit *rev2)
+{
+	struct commit_list *bases, *b;
+	int ret =3D 0;
+
+	bases =3D get_merge_bases(rev1, rev2, 1);
+	for (b =3D bases; b; b =3D b->next) {
+		if (!hashcmp(sha1, b->item->object.sha1)) {
+			ret =3D 1;
+			break;
+		}
+	}
+
+	free_commit_list(bases);
+	return ret;
+}
+
+static void delete_branches(int argc, const char **argv, int force)
+{
+	struct commit *rev, *head_rev;
+	unsigned char sha1[20];
+	const char *name;
+	int i;
+
+	head_rev =3D lookup_commit_reference(head_sha1);
+	for (i =3D 0; i < argc; i++) {
+		if (!strcmp(head, argv[i]))
+			die("Cannot delete the branch you are currently on.");
+
+		name =3D xstrdup(mkpath("refs/heads/%s", argv[i]));
+		if (!resolve_ref(name, sha1, 1, NULL))
+			die("Branch '%s' not found.", argv[i]);
+
+		rev =3D lookup_commit_reference(sha1);
+		if (!rev || !head_rev)
+			die("Couldn't look up commit objects.");
+
+		/* This checks whether the merge bases of branch and
+		 * HEAD contains branch -- which means that the HEAD
+		 * contains everything in both.
+		 */
+
+		if (!force &&
+		    !in_merge_bases(sha1, rev, head_rev)) {
+			fprintf(stderr,
+				"The branch '%s' is not a strict subset of your current HEAD.\n"
+				"If you are sure you want to delete it, run 'git branch -D %s'.\n"=
,
+				argv[i], argv[i]);
+			exit(1);
+		}
+
+		if (delete_ref(name, sha1))
+			printf("Error deleting branch '%s'\n", argv[i]);
+		else
+			printf("Deleted branch %s.\n", argv[i]);
+		=09
+		free(name);
+	}
+}
+
+static int ref_index, ref_alloc;
+static char **ref_list;
+
+static int append_ref(const char *refname, const unsigned char *sha1, =
int flags,=20
+		void *cb_data)
+{
+	if (ref_index >=3D ref_alloc) {
+		ref_alloc =3D ref_alloc > 0 ? ref_alloc * 2 : 16;
+		ref_list =3D xrealloc(ref_list, ref_alloc * sizeof(char *));
+	}
+
+	ref_list[ref_index++] =3D xstrdup(refname);
+
+	return 0;
+}
+
+static int ref_cmp(const void *r1, const void *r2)
+{
+	return strcmp(*(char **)r1, *(char **)r2);
+}
+
+static void print_ref_list(int remote_only)
+{
+	int i;
+
+	if (remote_only)
+		for_each_remote_ref(append_ref, NULL);
+	else
+		for_each_branch_ref(append_ref, NULL);
+
+	qsort(ref_list, ref_index, sizeof(char *), ref_cmp);
+
+	for (i =3D 0; i < ref_index; i++) {
+		if (!strcmp(ref_list[i], head))
+			printf("* %s\n", ref_list[i]);
+		else
+			printf("  %s\n", ref_list[i]);
+	}
+}
+
+static void create_branch(const char *name, const char *start,
+			  int force, int reflog)
+{
+	struct ref_lock *lock;
+	unsigned char sha1[20];
+	char ref[PATH_MAX], msg[PATH_MAX + 20];
+
+	snprintf(ref, sizeof ref, "refs/heads/%s", name);
+	if (check_ref_format(ref))
+		die("'%s' is not a valid branch name.", name);
+
+	if (resolve_ref(ref, sha1, 1, NULL)) {
+		if (!force)
+			die("A branch named '%s' already exists.", name);
+		else if (!strcmp(head, name))
+			die("Cannot force update the current branch.");
+	}
+
+	if (get_sha1(start, sha1))
+		die("Not a valid branch point: '%s'.", start);
+
+	lock =3D lock_any_ref_for_update(ref, NULL);
+	if (!lock)
+		die("Failed to lock ref for update: %s.", strerror(errno));
+	=09
+	if (reflog){
+		log_all_ref_updates =3D 1;
+		snprintf(msg, sizeof msg, "branch: Created from %s", start);
+	}
+
+	if (write_ref_sha1(lock, sha1, msg) < 0)
+		die("Failed to write ref: %s.", strerror(errno));
+}
+
+int cmd_branch(int argc, const char **argv, const char *prefix)
+{
+	int delete =3D 0, force_delete =3D 0, force_create =3D 0, remote_only=
 =3D 0;
+	int reflog =3D 0;
+	int i, prefix_length;
+
+	git_config(git_default_config);
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
+		if (!strcmp(arg, "-d")) {
+			delete =3D 1;
+			continue;
+		}
+		if (!strcmp(arg, "-D")) {
+			delete =3D 1;
+			force_delete =3D 1;
+			continue;
+		}
+		if (!strcmp(arg, "-f")) {
+			force_create =3D 1;
+			continue;
+		}
+		if (!strcmp(arg, "-r")) {
+			remote_only =3D 1;
+			continue;
+		}
+		if (!strcmp(arg, "-l")) {
+			reflog =3D 1;
+			continue;
+		}
+		usage(builtin_branch_usage);
+	}
+
+	head =3D xstrdup(resolve_ref("HEAD", head_sha1, 0, NULL));
+	if (!head)
+		die("Failed to resolve HEAD as a valid ref.");
+	if (strncmp(head, "refs/heads/", 11))
+		die("HEAD not found below refs/heads!");
+	=09
+	head +=3D 11;
+=09
+	if (delete)
+		delete_branches(argc - i, argv + i, force_delete);
+	else if (i =3D=3D argc)
+		print_ref_list(remote_only);
+	else if (i =3D=3D argc - 1)
+		create_branch(argv[i], head, force_create, reflog);
+	else if (i =3D=3D argc - 2)
+		create_branch(argv[i], argv[i + 1], force_create, reflog);
+	else
+		usage(builtin_branch_usage);
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 9683a7c..144d299 100644
--- a/builtin.h
+++ b/builtin.h
@@ -15,6 +15,7 @@ extern int write_tree(unsigned char *sha
 extern int cmd_add(int argc, const char **argv, const char *prefix);
 extern int cmd_annotate(int argc, const char **argv, const char *prefi=
x);
 extern int cmd_apply(int argc, const char **argv, const char *prefix);
+extern int cmd_branch(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_archive(int argc, const char **argv, const char *prefix=
);
 extern int cmd_cat_file(int argc, const char **argv, const char *prefi=
x);
 extern int cmd_checkout_index(int argc, const char **argv, const char =
*prefix);
diff --git a/git-branch.sh b/git-branch.sh
deleted file mode 100755
index 4379a07..0000000
--- a/git-branch.sh
+++ /dev/null
@@ -1,131 +0,0 @@
-#!/bin/sh
-
-USAGE=3D'[-l] [(-d | -D) <branchname>] | [[-f] <branchname> [<start-po=
int>]] | -r'
-LONG_USAGE=3D'If no arguments, show available branches and mark curren=
t branch with a star.
-If one argument, create a new branch <branchname> based off of current=
 HEAD.
-If two arguments, create a new branch <branchname> based off of <start=
-point>.'
-
-SUBDIRECTORY_OK=3D'Yes'
-. git-sh-setup
-
-headref=3D$(git-symbolic-ref HEAD | sed -e 's|^refs/heads/||')
-
-delete_branch () {
-    option=3D"$1"
-    shift
-    for branch_name
-    do
-	case ",$headref," in
-	",$branch_name,")
-	    die "Cannot delete the branch you are on." ;;
-	,,)
-	    die "What branch are you on anyway?" ;;
-	esac
-	branch=3D$(git-show-ref --verify --hash -- "refs/heads/$branch_name")=
 &&
-	    branch=3D$(git-rev-parse --verify "$branch^0") ||
-		die "Seriously, what branch are you talking about?"
-	case "$option" in
-	-D)
-	    ;;
-	*)
-	    mbs=3D$(git-merge-base -a "$branch" HEAD | tr '\012' ' ')
-	    case " $mbs " in
-	    *' '$branch' '*)
-		# the merge base of branch and HEAD contains branch --
-		# which means that the HEAD contains everything in both.
-		;;
-	    *)
-		echo >&2 "The branch '$branch_name' is not a strict subset of your c=
urrent HEAD.
-If you are sure you want to delete it, run 'git branch -D $branch_name=
'."
-		exit 1
-		;;
-	    esac
-	    ;;
-	esac
-	git update-ref -d "refs/heads/$branch_name" "$branch"
-	echo "Deleted branch $branch_name."
-    done
-    exit 0
-}
-
-ls_remote_branches () {
-    git-rev-parse --symbolic --all |
-    sed -ne 's|^refs/\(remotes/\)|\1|p' |
-    sort
-}
-
-force=3D
-create_log=3D
-while case "$#,$1" in 0,*) break ;; *,-*) ;; *) break ;; esac
-do
-	case "$1" in
-	-d | -D)
-		delete_branch "$@"
-		exit
-		;;
-	-r)
-		ls_remote_branches
-		exit
-		;;
-	-f)
-		force=3D"$1"
-		;;
-	-l)
-		create_log=3D"yes"
-		;;
-	--)
-		shift
-		break
-		;;
-	-*)
-		usage
-		;;
-	esac
-	shift
-done
-
-case "$#" in
-0)
-	git-rev-parse --symbolic --branches |
-	sort |
-	while read ref
-	do
-		if test "$headref" =3D "$ref"
-		then
-			pfx=3D'*'
-		else
-			pfx=3D' '
-		fi
-		echo "$pfx $ref"
-	done
-	exit 0 ;;
-1)
-	head=3DHEAD ;;
-2)
-	head=3D"$2^0" ;;
-esac
-branchname=3D"$1"
-
-rev=3D$(git-rev-parse --verify "$head") || exit
-
-git-check-ref-format "heads/$branchname" ||
-	die "we do not like '$branchname' as a branch name."
-
-prev=3D''
-if git-show-ref --verify --quiet -- "refs/heads/$branchname"
-then
-	if test '' =3D "$force"
-	then
-		die "$branchname already exists."
-	elif test "$branchname" =3D "$headref"
-	then
-		die "cannot force-update the current branch."
-	fi
-	prev=3D`git rev-parse --verify "refs/heads/$branchname"`
-fi
-if test "$create_log" =3D 'yes'
-then
-	mkdir -p $(dirname "$GIT_DIR/logs/refs/heads/$branchname")
-	touch "$GIT_DIR/logs/refs/heads/$branchname"
-fi
-git update-ref -m "branch: Created from $head" "refs/heads/$branchname=
" "$rev" "$prev"
diff --git a/git.c b/git.c
index 308252a..671b212 100644
--- a/git.c
+++ b/git.c
@@ -222,6 +222,7 @@ static void handle_internal_command(int=20
 		{ "annotate", cmd_annotate, },
 		{ "apply", cmd_apply },
 		{ "archive", cmd_archive },
+		{ "branch", cmd_branch },
 		{ "cat-file", cmd_cat_file, RUN_SETUP },
 		{ "checkout-index", cmd_checkout_index, RUN_SETUP },
 		{ "check-ref-format", cmd_check_ref_format },
--=20
1.4.3.1.g9164-dirty
