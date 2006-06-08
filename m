From: =?UTF-8?B?S3Jpc3RpYW4gSMO4Z3NiZXJn?= <krh@bitplanet.net>
Subject: [PATCH] Implement git-branch and git-merge-base as built-ins.
Date: Thu, 08 Jun 2006 13:49:46 -0400
Message-ID: <4488633A.5060409@bitplanet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Jun 08 19:51:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoOen-0001Yw-OX
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 19:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbWFHRuy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 8 Jun 2006 13:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbWFHRuy
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 13:50:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39557 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964908AbWFHRux (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jun 2006 13:50:53 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k58HoonY011742
	for <git@vger.kernel.org>; Thu, 8 Jun 2006 13:50:50 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [172.16.52.156])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k58Hon9K012815
	for <git@vger.kernel.org>; Thu, 8 Jun 2006 13:50:49 -0400
Received: from [127.0.0.1] (sebastian-int.corp.redhat.com [172.16.52.221])
	by pobox.corp.redhat.com (8.12.8/8.12.8) with ESMTP id k58HomTn002072
	for <git@vger.kernel.org>; Thu, 8 Jun 2006 13:50:49 -0400
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
To: git <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21502>

This patch is more or less a straight port of git-branch from shell
script to C.  Branch deletion uses git-merge-base to check if it is saf=
e
to delete a branch, so I changed merge-base.c to export this functional=
ity
as a for_each_merge_base() iterator.  As a side effect, git-merge-base =
is
now also a built-in command.

---

6b90d7b7af4bf577ccfeebef1f736e75631b052d
 Makefile         |   13 +++--
 builtin-branch.c |  154 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 builtin.h        |    2 +
 commit.h         |    5 ++
 git-branch.sh    |  120 ------------------------------------------
 git.c            |    4 +
 merge-base.c     |   34 ++++++++----
 7 files changed, 194 insertions(+), 138 deletions(-)

diff --git a/Makefile b/Makefile
index 5373986..a709e40 100644
--- a/Makefile
+++ b/Makefile
@@ -113,7 +113,7 @@ SPARSE_FLAGS =3D -D__BIG_ENDIAN__ -D__powe
 ### --- END CONFIGURATION SECTION ---
=20
 SCRIPT_SH =3D \
-	git-bisect.sh git-branch.sh git-checkout.sh \
+	git-bisect.sh git-checkout.sh \
 	git-cherry.sh git-clean.sh git-clone.sh git-commit.sh \
 	git-fetch.sh \
 	git-format-patch.sh git-ls-remote.sh \
@@ -155,7 +155,7 @@ PROGRAMS =3D \
 	git-diff-index$X git-diff-stages$X \
 	git-diff-tree$X git-fetch-pack$X git-fsck-objects$X \
 	git-hash-object$X git-index-pack$X git-init-db$X git-local-fetch$X \
-	git-ls-files$X git-ls-tree$X git-mailinfo$X git-merge-base$X \
+	git-ls-files$X git-ls-tree$X git-mailinfo$X \
 	git-merge-index$X git-mktag$X git-mktree$X git-pack-objects$X git-pat=
ch-id$X \
 	git-peek-remote$X git-prune-packed$X git-read-tree$X \
 	git-receive-pack$X git-rev-parse$X \
@@ -170,7 +170,8 @@ PROGRAMS =3D \
=20
 BUILT_INS =3D git-log$X git-whatchanged$X git-show$X \
 	git-count-objects$X git-diff$X git-push$X \
-	git-grep$X git-add$X git-rev-list$X git-check-ref-format$X
+	git-grep$X git-add$X git-rev-list$X git-check-ref-format$X \
+	git-branch$X git-merge-base$X
=20
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS =3D $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -214,11 +215,13 @@ LIB_OBJS =3D \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
 	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
+	merge-base.o \
 	$(DIFF_OBJS)
=20
 BUILTIN_OBJS =3D \
-	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-p=
ush.o \
-	builtin-grep.o builtin-add.o builtin-rev-list.o builtin-check-ref-for=
mat.o
+	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o \
+	builtin-push.o builtin-grep.o builtin-add.o builtin-rev-list.o \
+	builtin-check-ref-format.o builtin-branch.o
=20
 GITLIBS =3D $(LIB_FILE) $(XDIFF_LIB)
 LIBS =3D $(GITLIBS) -lz
diff --git a/builtin-branch.c b/builtin-branch.c
new file mode 100644
index 0000000..c7776a3
--- /dev/null
+++ b/builtin-branch.c
@@ -0,0 +1,154 @@
+/*
+ * Builtin "git branch"
+ *
+ * Copyright (c) 2006 Kristian H=C3=B8gsberg <krh@redhat.com>
+ * Based on git-branch.sh by Junio C Hamano.
+ */
+
+#include "cache.h"
+#include "refs.h"
+#include "commit.h"
+#include "builtin.h"
+
+static const char builtin_branch_usage[] =3D
+	"git-branch [(-d | -D) <branchname>] | [[-f] <branchname> [<start-poi=
nt>]] | -r";
+
+
+static int remote_only =3D 0;
+static const char *head;
+static unsigned char head_sha1[20];
+
+static int find_sha1(struct commit *commit, void *data)
+{
+	return !memcmp(data, commit->object.sha1, sizeof commit->object.sha1)=
;
+}
+
+static void delete_branches(int argc, const char **argv, int force)
+{
+	struct commit *rev1, *rev2;
+	unsigned char sha1[20];
+	const char *p, *name;
+	int i;
+
+	for (i =3D 0; i < argc; i++) {
+		if (!strcmp(head, argv[i]))
+			die("Cannot delete the branch you are currently on.");
+
+		name =3D git_path("refs/heads/%s", argv[i]);
+		p =3D resolve_ref(name, sha1, 1);
+		if (p =3D=3D NULL)
+			die("Branch '%s' not found.", argv[i]);
+
+		rev1 =3D lookup_commit_reference(sha1);
+		rev2 =3D lookup_commit_reference(head_sha1);
+		if (!rev1 || !rev2)
+			die("Couldn't look up commit objects.");
+
+		/* This checks wether the merge bases of branch and
+		 * HEAD contains branch -- which means that the HEAD
+		 * contains everything in both.
+		 */
+
+		if (!force &&
+		    !for_each_merge_base(rev1, rev2, find_sha1, sha1)) {
+			fprintf(stderr,
+				"The branch '%s' is not a strict subset of your current HEAD.\n"
+				"If you are sure you want to delete it, run 'git branch -D %s'.\n"=
,
+				argv[i], argv[i]);
+			exit(1);
+		}
+
+		unlink(name);
+		printf("Deleted branch %s.\n", argv[i]);
+	}
+}
+
+static int show_reference(const char *refname, const unsigned char *sh=
a1)
+{
+	int is_head =3D !strcmp(refname, head);
+
+	printf("%c %s\n", (is_head ? '*' : ' '), refname);
+
+	return 0;
+}
+
+static void create_branch (const char *name, const char *start, int fo=
rce)
+{
+	unsigned char sha1[20];
+	char ref[500];
+
+	snprintf (ref, sizeof ref, "heads/%s", name);
+	if (check_ref_format(ref))
+		die("'%s' is not a valid branch name.", name);
+
+	if (resolve_ref(git_path("refs/%s", ref), sha1, 1)) {
+		if (!force)
+			die("A branch named '%s' already exists.", name);
+		else if (!strcmp(head, name))
+			die("Cannot force update the current branch.");
+	}
+
+	if (get_sha1(start, sha1))
+		die("Not a valid branch point: '%s'", start);
+
+	if (write_ref_sha1_unlocked(ref, sha1))
+		die("Failed to create branch: %s.", strerror(errno));
+}
+
+int cmd_branch(int argc, const char **argv, char **envp)
+{
+	int delete =3D 0, force_delete =3D 0, force_create =3D 0;
+	int i, prefix_length;
+	const char *p;
+
+	setup_git_directory();
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
+		die(builtin_branch_usage);
+	}
+
+	prefix_length =3D strlen(git_path("refs/heads/"));
+	p =3D resolve_ref(git_path("HEAD"), head_sha1, 0);
+	if (!p)
+		die("Failed to resolve HEAD as a valid ref");
+	head =3D strdup(p + prefix_length);
+
+	if (delete)
+		delete_branches(argc - i, argv + i, force_delete);
+	else if (i =3D=3D argc && remote_only)
+		for_each_remote_ref(show_reference);
+	else if (i =3D=3D argc)
+		for_each_branch_ref(show_reference);
+	else if (argc - i =3D=3D 1)
+		create_branch (argv[i], head, force_create);
+	else
+		create_branch (argv[i], argv[i + 1], force_create);
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 78275ea..0105358 100644
--- a/builtin.h
+++ b/builtin.h
@@ -28,5 +28,7 @@ extern int cmd_grep(int argc, const char
 extern int cmd_add(int argc, const char **argv, char **envp);
 extern int cmd_rev_list(int argc, const char **argv, char **envp);
 extern int cmd_check_ref_format(int argc, const char **argv, char **en=
vp);
+extern int cmd_branch(int argc, const char **argv, char **envp);
+extern int cmd_merge_base(int argc, const char **argv, char **envp);
=20
 #endif
diff --git a/commit.h b/commit.h
index 8d7514c..b1a518a 100644
--- a/commit.h
+++ b/commit.h
@@ -104,4 +104,9 @@ struct commit_graft *read_graft_line(cha
 int register_commit_graft(struct commit_graft *, int);
 int read_graft_file(const char *graft_file);
=20
+/* merge-base.c */
+int for_each_merge_base(struct commit *rev1, struct commit *rev2,
+			int (*fn)(struct commit *commit, void *data),
+			void  *data);
+
 #endif /* COMMIT_H */
diff --git a/git-branch.sh b/git-branch.sh
deleted file mode 100755
index 134e68c..0000000
--- a/git-branch.sh
+++ /dev/null
@@ -1,120 +0,0 @@
-#!/bin/sh
-
-USAGE=3D'[(-d | -D) <branchname>] | [[-f] <branchname> [<start-point>]=
] | -r'
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
-	branch=3D$(cat "$GIT_DIR/refs/heads/$branch_name") &&
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
-	rm -f "$GIT_DIR/refs/heads/$branch_name"
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
-if [ -e "$GIT_DIR/refs/heads/$branchname" ]
-then
-	if test '' =3D "$force"
-	then
-		die "$branchname already exists."
-	elif test "$branchname" =3D "$headref"
-	then
-		die "cannot force-update the current branch."
-	fi
-fi
-git update-ref "refs/heads/$branchname" $rev
diff --git a/git.c b/git.c
index 7db5cc1..fb66c0e 100644
--- a/git.c
+++ b/git.c
@@ -53,7 +53,9 @@ static void handle_internal_command(int=20
 		{ "grep", cmd_grep },
 		{ "add", cmd_add },
 		{ "rev-list", cmd_rev_list },
-		{ "check-ref-format", cmd_check_ref_format }
+		{ "check-ref-format", cmd_check_ref_format },
+		{ "branch", cmd_branch },
+		{ "merge-base", cmd_merge_base }
 	};
 	int i;
=20
diff --git a/merge-base.c b/merge-base.c
index 4856ca0..0aa6ed4 100644
--- a/merge-base.c
+++ b/merge-base.c
@@ -1,6 +1,6 @@
-#include <stdlib.h>
 #include "cache.h"
 #include "commit.h"
+#include "builtin.h"
=20
 #define PARENT1 1
 #define PARENT2 2
@@ -167,16 +167,16 @@ static void mark_reachable_commits(struc
 	}
 }
=20
-static int merge_base(struct commit *rev1, struct commit *rev2)
+int for_each_merge_base(struct commit *rev1, struct commit *rev2,
+			int (*fn)(struct commit *commit, void *data),
+			void *data)
 {
 	struct commit_list *list =3D NULL;
 	struct commit_list *result =3D NULL;
 	struct commit_list *tmp =3D NULL;
=20
-	if (rev1 =3D=3D rev2) {
-		printf("%s\n", sha1_to_hex(rev1->object.sha1));
-		return 0;
-	}
+	if (rev1 =3D=3D rev2)=20
+		return fn(rev1, data);
=20
 	parse_commit(rev1);
 	parse_commit(rev2);
@@ -220,12 +220,13 @@ static int merge_base(struct commit *rev
=20
 	while (result) {
 		struct commit *commit =3D result->item;
+		int retval;
 		result =3D result->next;
 		if (commit->object.flags & UNINTERESTING)
 			continue;
-		printf("%s\n", sha1_to_hex(commit->object.sha1));
-		if (!show_all)
-			return 0;
+		retval =3D fn(commit, data);
+		if (retval)
+			return retval;
 		commit->object.flags |=3D UNINTERESTING;
 	}
 	return 0;
@@ -234,7 +235,13 @@ static int merge_base(struct commit *rev
 static const char merge_base_usage[] =3D
 "git-merge-base [--all] <commit-id> <commit-id>";
=20
-int main(int argc, char **argv)
+static int print_merge_base(struct commit *commit, void *data)
+{
+	printf("%s\n", sha1_to_hex(commit->object.sha1));
+	return show_all ? 0 : 1;
+}
+
+int cmd_merge_base(int argc, const char **argv, char **envp)
 {
 	struct commit *rev1, *rev2;
 	unsigned char rev1key[20], rev2key[20];
@@ -243,7 +250,7 @@ int main(int argc, char **argv)
 	git_config(git_default_config);
=20
 	while (1 < argc && argv[1][0] =3D=3D '-') {
-		char *arg =3D argv[1];
+		const char *arg =3D argv[1];
 		if (!strcmp(arg, "-a") || !strcmp(arg, "--all"))
 			show_all =3D 1;
 		else
@@ -260,5 +267,8 @@ int main(int argc, char **argv)
 	rev2 =3D lookup_commit_reference(rev2key);
 	if (!rev1 || !rev2)
 		return 1;
-	return merge_base(rev1, rev2);
+
+	for_each_merge_base(rev1, rev2, print_merge_base, NULL);
+
+	return 0;
 }

6b90d7b7af4bf577ccfeebef1f736e75631b052d
diff --git a/Makefile b/Makefile
index 5373986..a709e40 100644
--- a/Makefile
+++ b/Makefile
@@ -113,7 +113,7 @@ SPARSE_FLAGS =3D -D__BIG_ENDIAN__ -D__powe
 ### --- END CONFIGURATION SECTION ---
=20
 SCRIPT_SH =3D \
-	git-bisect.sh git-branch.sh git-checkout.sh \
+	git-bisect.sh git-checkout.sh \
 	git-cherry.sh git-clean.sh git-clone.sh git-commit.sh \
 	git-fetch.sh \
 	git-format-patch.sh git-ls-remote.sh \
@@ -155,7 +155,7 @@ PROGRAMS =3D \
 	git-diff-index$X git-diff-stages$X \
 	git-diff-tree$X git-fetch-pack$X git-fsck-objects$X \
 	git-hash-object$X git-index-pack$X git-init-db$X git-local-fetch$X \
-	git-ls-files$X git-ls-tree$X git-mailinfo$X git-merge-base$X \
+	git-ls-files$X git-ls-tree$X git-mailinfo$X \
 	git-merge-index$X git-mktag$X git-mktree$X git-pack-objects$X git-pat=
ch-id$X \
 	git-peek-remote$X git-prune-packed$X git-read-tree$X \
 	git-receive-pack$X git-rev-parse$X \
@@ -170,7 +170,8 @@ PROGRAMS =3D \
=20
 BUILT_INS =3D git-log$X git-whatchanged$X git-show$X \
 	git-count-objects$X git-diff$X git-push$X \
-	git-grep$X git-add$X git-rev-list$X git-check-ref-format$X
+	git-grep$X git-add$X git-rev-list$X git-check-ref-format$X \
+	git-branch$X git-merge-base$X
=20
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS =3D $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -214,11 +215,13 @@ LIB_OBJS =3D \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
 	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
+	merge-base.o \
 	$(DIFF_OBJS)
=20
 BUILTIN_OBJS =3D \
-	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-p=
ush.o \
-	builtin-grep.o builtin-add.o builtin-rev-list.o builtin-check-ref-for=
mat.o
+	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o \
+	builtin-push.o builtin-grep.o builtin-add.o builtin-rev-list.o \
+	builtin-check-ref-format.o builtin-branch.o
=20
 GITLIBS =3D $(LIB_FILE) $(XDIFF_LIB)
 LIBS =3D $(GITLIBS) -lz
diff --git a/builtin-branch.c b/builtin-branch.c
new file mode 100644
index 0000000..c7776a3
--- /dev/null
+++ b/builtin-branch.c
@@ -0,0 +1,154 @@
+/*
+ * Builtin "git branch"
+ *
+ * Copyright (c) 2006 Kristian H=C3=B8gsberg <krh@redhat.com>
+ * Based on git-branch.sh by Junio C Hamano.
+ */
+
+#include "cache.h"
+#include "refs.h"
+#include "commit.h"
+#include "builtin.h"
+
+static const char builtin_branch_usage[] =3D
+	"git-branch [(-d | -D) <branchname>] | [[-f] <branchname> [<start-poi=
nt>]] | -r";
+
+
+static int remote_only =3D 0;
+static const char *head;
+static unsigned char head_sha1[20];
+
+static int find_sha1(struct commit *commit, void *data)
+{
+	return !memcmp(data, commit->object.sha1, sizeof commit->object.sha1)=
;
+}
+
+static void delete_branches(int argc, const char **argv, int force)
+{
+	struct commit *rev1, *rev2;
+	unsigned char sha1[20];
+	const char *p, *name;
+	int i;
+
+	for (i =3D 0; i < argc; i++) {
+		if (!strcmp(head, argv[i]))
+			die("Cannot delete the branch you are currently on.");
+
+		name =3D git_path("refs/heads/%s", argv[i]);
+		p =3D resolve_ref(name, sha1, 1);
+		if (p =3D=3D NULL)
+			die("Branch '%s' not found.", argv[i]);
+
+		rev1 =3D lookup_commit_reference(sha1);
+		rev2 =3D lookup_commit_reference(head_sha1);
+		if (!rev1 || !rev2)
+			die("Couldn't look up commit objects.");
+
+		/* This checks wether the merge bases of branch and
+		 * HEAD contains branch -- which means that the HEAD
+		 * contains everything in both.
+		 */
+
+		if (!force &&
+		    !for_each_merge_base(rev1, rev2, find_sha1, sha1)) {
+			fprintf(stderr,
+				"The branch '%s' is not a strict subset of your current HEAD.\n"
+				"If you are sure you want to delete it, run 'git branch -D %s'.\n"=
,
+				argv[i], argv[i]);
+			exit(1);
+		}
+
+		unlink(name);
+		printf("Deleted branch %s.\n", argv[i]);
+	}
+}
+
+static int show_reference(const char *refname, const unsigned char *sh=
a1)
+{
+	int is_head =3D !strcmp(refname, head);
+
+	printf("%c %s\n", (is_head ? '*' : ' '), refname);
+
+	return 0;
+}
+
+static void create_branch (const char *name, const char *start, int fo=
rce)
+{
+	unsigned char sha1[20];
+	char ref[500];
+
+	snprintf (ref, sizeof ref, "heads/%s", name);
+	if (check_ref_format(ref))
+		die("'%s' is not a valid branch name.", name);
+
+	if (resolve_ref(git_path("refs/%s", ref), sha1, 1)) {
+		if (!force)
+			die("A branch named '%s' already exists.", name);
+		else if (!strcmp(head, name))
+			die("Cannot force update the current branch.");
+	}
+
+	if (get_sha1(start, sha1))
+		die("Not a valid branch point: '%s'", start);
+
+	if (write_ref_sha1_unlocked(ref, sha1))
+		die("Failed to create branch: %s.", strerror(errno));
+}
+
+int cmd_branch(int argc, const char **argv, char **envp)
+{
+	int delete =3D 0, force_delete =3D 0, force_create =3D 0;
+	int i, prefix_length;
+	const char *p;
+
+	setup_git_directory();
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
+		die(builtin_branch_usage);
+	}
+
+	prefix_length =3D strlen(git_path("refs/heads/"));
+	p =3D resolve_ref(git_path("HEAD"), head_sha1, 0);
+	if (!p)
+		die("Failed to resolve HEAD as a valid ref");
+	head =3D strdup(p + prefix_length);
+
+	if (delete)
+		delete_branches(argc - i, argv + i, force_delete);
+	else if (i =3D=3D argc && remote_only)
+		for_each_remote_ref(show_reference);
+	else if (i =3D=3D argc)
+		for_each_branch_ref(show_reference);
+	else if (argc - i =3D=3D 1)
+		create_branch (argv[i], head, force_create);
+	else
+		create_branch (argv[i], argv[i + 1], force_create);
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 78275ea..0105358 100644
--- a/builtin.h
+++ b/builtin.h
@@ -28,5 +28,7 @@ extern int cmd_grep(int argc, const char
 extern int cmd_add(int argc, const char **argv, char **envp);
 extern int cmd_rev_list(int argc, const char **argv, char **envp);
 extern int cmd_check_ref_format(int argc, const char **argv, char **en=
vp);
+extern int cmd_branch(int argc, const char **argv, char **envp);
+extern int cmd_merge_base(int argc, const char **argv, char **envp);
=20
 #endif
diff --git a/commit.h b/commit.h
index 8d7514c..b1a518a 100644
--- a/commit.h
+++ b/commit.h
@@ -104,4 +104,9 @@ struct commit_graft *read_graft_line(cha
 int register_commit_graft(struct commit_graft *, int);
 int read_graft_file(const char *graft_file);
=20
+/* merge-base.c */
+int for_each_merge_base(struct commit *rev1, struct commit *rev2,
+			int (*fn)(struct commit *commit, void *data),
+			void  *data);
+
 #endif /* COMMIT_H */
diff --git a/git-branch.sh b/git-branch.sh
deleted file mode 100755
index 134e68c..0000000
--- a/git-branch.sh
+++ /dev/null
@@ -1,120 +0,0 @@
-#!/bin/sh
-
-USAGE=3D'[(-d | -D) <branchname>] | [[-f] <branchname> [<start-point>]=
] | -r'
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
-	branch=3D$(cat "$GIT_DIR/refs/heads/$branch_name") &&
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
-	rm -f "$GIT_DIR/refs/heads/$branch_name"
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
-if [ -e "$GIT_DIR/refs/heads/$branchname" ]
-then
-	if test '' =3D "$force"
-	then
-		die "$branchname already exists."
-	elif test "$branchname" =3D "$headref"
-	then
-		die "cannot force-update the current branch."
-	fi
-fi
-git update-ref "refs/heads/$branchname" $rev
diff --git a/git.c b/git.c
index 7db5cc1..fb66c0e 100644
--- a/git.c
+++ b/git.c
@@ -53,7 +53,9 @@ static void handle_internal_command(int=20
 		{ "grep", cmd_grep },
 		{ "add", cmd_add },
 		{ "rev-list", cmd_rev_list },
-		{ "check-ref-format", cmd_check_ref_format }
+		{ "check-ref-format", cmd_check_ref_format },
+		{ "branch", cmd_branch },
+		{ "merge-base", cmd_merge_base }
 	};
 	int i;
=20
diff --git a/merge-base.c b/merge-base.c
index 4856ca0..0aa6ed4 100644
--- a/merge-base.c
+++ b/merge-base.c
@@ -1,6 +1,6 @@
-#include <stdlib.h>
 #include "cache.h"
 #include "commit.h"
+#include "builtin.h"
=20
 #define PARENT1 1
 #define PARENT2 2
@@ -167,16 +167,16 @@ static void mark_reachable_commits(struc
 	}
 }
=20
-static int merge_base(struct commit *rev1, struct commit *rev2)
+int for_each_merge_base(struct commit *rev1, struct commit *rev2,
+			int (*fn)(struct commit *commit, void *data),
+			void *data)
 {
 	struct commit_list *list =3D NULL;
 	struct commit_list *result =3D NULL;
 	struct commit_list *tmp =3D NULL;
=20
-	if (rev1 =3D=3D rev2) {
-		printf("%s\n", sha1_to_hex(rev1->object.sha1));
-		return 0;
-	}
+	if (rev1 =3D=3D rev2)=20
+		return fn(rev1, data);
=20
 	parse_commit(rev1);
 	parse_commit(rev2);
@@ -220,12 +220,13 @@ static int merge_base(struct commit *rev
=20
 	while (result) {
 		struct commit *commit =3D result->item;
+		int retval;
 		result =3D result->next;
 		if (commit->object.flags & UNINTERESTING)
 			continue;
-		printf("%s\n", sha1_to_hex(commit->object.sha1));
-		if (!show_all)
-			return 0;
+		retval =3D fn(commit, data);
+		if (retval)
+			return retval;
 		commit->object.flags |=3D UNINTERESTING;
 	}
 	return 0;
@@ -234,7 +235,13 @@ static int merge_base(struct commit *rev
 static const char merge_base_usage[] =3D
 "git-merge-base [--all] <commit-id> <commit-id>";
=20
-int main(int argc, char **argv)
+static int print_merge_base(struct commit *commit, void *data)
+{
+	printf("%s\n", sha1_to_hex(commit->object.sha1));
+	return show_all ? 0 : 1;
+}
+
+int cmd_merge_base(int argc, const char **argv, char **envp)
 {
 	struct commit *rev1, *rev2;
 	unsigned char rev1key[20], rev2key[20];
@@ -243,7 +250,7 @@ int main(int argc, char **argv)
 	git_config(git_default_config);
=20
 	while (1 < argc && argv[1][0] =3D=3D '-') {
-		char *arg =3D argv[1];
+		const char *arg =3D argv[1];
 		if (!strcmp(arg, "-a") || !strcmp(arg, "--all"))
 			show_all =3D 1;
 		else
@@ -260,5 +267,8 @@ int main(int argc, char **argv)
 	rev2 =3D lookup_commit_reference(rev2key);
 	if (!rev1 || !rev2)
 		return 1;
-	return merge_base(rev1, rev2);
+
+	for_each_merge_base(rev1, rev2, print_merge_base, NULL);
+
+	return 0;
 }
