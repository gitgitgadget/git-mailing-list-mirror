From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add git-bundle: move objects and references by archive
Date: Thu, 22 Feb 2007 01:59:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702220157130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Levedahl <mdl123@verizon.net>, junkio@cox.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 22 01:59:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HK2Ir-0004W7-Nv
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 01:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945927AbXBVA7S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 19:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945931AbXBVA7S
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 19:59:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:42302 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1945927AbXBVA7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 19:59:16 -0500
Received: (qmail invoked by alias); 22 Feb 2007 00:59:14 -0000
X-Provags-ID: V01U2FsdGVkX18OId82qTEO+V89uY1JgXukEjxjcLZBq2qJ9OLeCr
	OZ5w==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40332>


Some workflows require use of repositories on machines that cannot be 
connected, preventing use of git-fetch / git-push to transport objects and 
references between the repositories.

git-bundle provides an alternate transport mechanism, effectively allowing 
git-fetch and git-pull to operate using sneakernet transport. `git-bundle 
create` allows the user to create a bundle containing one or more branches 
or tags, but with specified basis assumed to exist on the target 
repository. At the receiving end, git-bundle acts like git-fetch-pack, 
allowing the user to invoke git-fetch or git-pull using the bundle file as 
the URL. git-fetch and git-ls-remote determine they have a bundle URL by 
checking that the URL points to a file, but are otherwise unchanged in 
operation with bundles.

The original patch was done by Mark Levedahl <mdl123@verizon.net>.

It was updated to make git-bundle a builtin, and get rid of the tar 
format: now, the first line is supposed to say "# v2 git bundle", the next 
lines either contain a prerequisite ("-" followed by the hash of the 
needed commit), or a ref (the hash of a commit, followed by the name of 
the ref), and finally the pack. As a result, the bundle argument can be 
"-" now.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This patch should apply cleanly to "next".

	Mark, could you test on cygwin?

 .gitignore                   |    1 +
 Documentation/cmd-list.perl  |    1 +
 Documentation/git-bundle.txt |  139 +++++++++++++++
 Makefile                     |    1 +
 builtin-bundle.c             |  389 ++++++++++++++++++++++++++++++++++++++++++
 builtin.h                    |    1 +
 git-fetch.sh                 |    7 +
 git-ls-remote.sh             |    7 +-
 git.c                        |    1 +
 index-pack.c                 |    4 +-
 t/t5510-fetch.sh             |   28 +++-
 11 files changed, 575 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/git-bundle.txt
 create mode 100644 builtin-bundle.c

diff --git a/.gitignore b/.gitignore
index f15155d..4d3c66d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -13,6 +13,7 @@ git-archive
 git-bisect
 git-blame
 git-branch
+git-bundle
 git-cat-file
 git-check-ref-format
 git-checkout
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index a2d6268..f61c77a 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -70,6 +70,7 @@ git-archive                             mainporcelain
 git-bisect                              mainporcelain
 git-blame                               ancillaryinterrogators
 git-branch                              mainporcelain
+git-bundle                              mainporcelain
 git-cat-file                            plumbinginterrogators
 git-checkout-index                      plumbingmanipulators
 git-checkout                            mainporcelain
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
new file mode 100644
index 0000000..4ea9e85
--- /dev/null
+++ b/Documentation/git-bundle.txt
@@ -0,0 +1,139 @@
+git-bundle(1)
+=============
+
+NAME
+----
+git-bundle - Move objects and refs by archive
+
+
+SYNOPSIS
+--------
+'git-bundle' create <file> [git-rev-list args]
+'git-bundle' verify <file>
+'git-bundle' list-heads <file> [refname...]
+'git-bundle' unbundle <file> [refname...]
+
+DESCRIPTION
+-----------
+
+Some workflows require that one or more branches of development on one
+machine be replicated on another machine, but the two machines cannot
+be directly connected so the interactive git protocols (git, ssh,
+rsync, http) cannot be used.  This command provides suport for
+git-fetch and git-pull to operate by packaging objects and references
+in an archive at the originating machine, then importing those into
+another repository using gitlink:git-fetch[1] and gitlink:git-pull[1]
+after moving the archive by some means (i.e., by sneakernet).  As no
+direct connection between repositories exists, the user must specify a
+basis for the bundle that is held by the destination repository: the
+bundle assumes that all objects in the basis are already in the
+destination repository.
+
+OPTIONS
+-------
+
+create <file>::
+       Used to create a bundle named 'file'.  This requires the
+       git-rev-list arguments to define the bundle contents.
+
+verify <file>::
+       Used to check that a bundle file is valid and will apply
+       cleanly to the current repository.  This includes checks on the
+       bundle format itself as well as checking that the prerequisite
+       commits exist and are fully linked in the current repository.
+       git-bundle prints a list of missing commits, if any, and exits
+       with non-zero status.
+
+list-heads <file>::
+       Lists the references defined in the bundle.  If followed by a
+       list of references, only references matching those given are
+       printed out.
+
+unbundle <file>::
+       Passes the objects in the bundle to gitlink:git-index-pack[1]
+       for storage in the repository, then prints the names of all
+       defined references. If a reflist is given, only references
+       matching those in the given list are printed. This command is
+       really plumbing, intended to be called only by
+       gitlink:git-fetch[1].
+
+[git-rev-list-args...]::
+       A list of arguments, accepatble to git-rev-parse and
+       git-rev-list, that specify the specific objects and references
+       to transport.  For example, "master~10..master" causes the
+       current master reference to be packaged along with all objects
+       added since its 10th ancestor commit.  There is no explicit
+       limit to the number of references and objects that may be
+       packaged.
+
+
+[refname...]::
+       A list of references used to limit the references reported as
+       available. This is principally of use to git-fetch, which
+       expects to recieve only those references asked for and not
+       necessarily everything in the pack (in this case, git-bundle is
+       acting like gitlink:git-fetch-pack[1]).
+
+SPECIFYING REFERENCES
+---------------------
+
+git-bundle will only package references that are shown by
+git-show-ref: this includes heads, tags, and remote heads.  References
+such as master~1 cannot be packaged, but are perfectly suitable for
+defining the basis.  More than one reference may be packaged, and more
+than one basis can be specified.  The objects packaged are those not
+contained in the union of the given bases.  Each basis can be
+specified explicitly (e.g., ^master~10), or implicitly (e.g.,
+master~10..master, master --since=10.days.ago).
+
+It is very important that the basis used be held by the destination.
+It is ok to err on the side of conservatism, causing the bundle file
+to contain objects already in the destination as these are ignored
+when unpacking at the destination.
+
+EXAMPLE
+-------
+
+Assume two repositories exist as R1 on machine A, and R2 on machine B.
+For whatever reason, direct connection between A and B is not allowed,
+but we can move data from A to B via some mechanism (CD, email, etc).
+We want to update R2 with developments made on branch master in R1.
+We set a tag in R1 (lastR2bundle) after the previous such transport,
+and move it afterwards to help build the bundle.
+
+in R1 on A:
+$ git-bundle create mybundle master ^lastR2bundle
+$ git tag -f lastR2bundle master
+
+(move mybundle from A to B by some mechanism)
+
+in R2 on B:
+$ git-bundle verify mybundle
+$ git-fetch mybundle  refspec
+
+where refspec is refInBundle:localRef
+
+
+Also, with something like this in your config:
+
+[remote "bundle"]
+    url = /home/me/tmp/file.bdl
+    fetch = refs/heads/*:refs/remotes/origin/*
+
+You can first sneakernet the bundle file to ~/tmp/file.bdl and
+then these commands:
+
+$ git ls-remote bundle
+$ git fetch bundle
+$ git pull bundle
+
+would treat it as if it is talking with a remote side over the
+network.
+
+Author
+------
+Written by Mark Levedahl <mdl123@verizon.net>
+
+GIT
+---
+Part of the gitlink:git[7] suite
diff --git a/Makefile b/Makefile
index 56bb0b8..03a7f4a 100644
--- a/Makefile
+++ b/Makefile
@@ -276,6 +276,7 @@ BUILTIN_OBJS = \
 	builtin-archive.o \
 	builtin-blame.o \
 	builtin-branch.o \
+	builtin-bundle.o \
 	builtin-cat-file.o \
 	builtin-checkout-index.o \
 	builtin-check-ref-format.o \
diff --git a/builtin-bundle.c b/builtin-bundle.c
new file mode 100644
index 0000000..4bd596a
--- /dev/null
+++ b/builtin-bundle.c
@@ -0,0 +1,389 @@
+#include "cache.h"
+#include "object.h"
+#include "commit.h"
+#include "diff.h"
+#include "revision.h"
+#include "list-objects.h"
+#include "exec_cmd.h"
+
+/*
+ * Basic handler for bundle files to connect repositories via sneakernet.
+ * Invocation must include action.
+ * This function can create a bundle or provide information on an existing
+ * bundle supporting git-fetch, git-pull, and git-ls-remote
+ */
+
+static const char *bundle_usage="git-bundle (--create <bundle> <git-rev-list args> | --verify <bundle> | --list-heads <bundle> [refname]... | --unbundle <bundle> [refname]... )";
+
+static const char bundle_signature[] = "# v2 git bundle\n";
+
+struct ref_list {
+	unsigned int nr, alloc;
+	struct {
+		unsigned char sha1[20];
+		char *name;
+	} *list;
+};
+
+static void add_to_ref_list(const unsigned char *sha1, const char *name,
+		struct ref_list *list)
+{
+	if (list->nr + 1 >= list->alloc) {
+		list->alloc = alloc_nr(list->nr + 1);
+		list->list = xrealloc(list->list,
+				list->alloc * sizeof(list->list[0]));
+	}
+	memcpy(list->list[list->nr].sha1, sha1, 20);
+	list->list[list->nr].name = xstrdup(name);
+	list->nr++;
+}
+
+struct bundle_header {
+	struct ref_list prerequisites, references;
+};
+
+/* this function returns the length of the string */
+static int read_string(int fd, char *buffer, int size)
+{
+	int i;
+	for (i = 0; i < size - 1; i++) {
+		int count = read(fd, buffer + i, 1);
+		if (count < 0)
+			return error("Read error: %s", strerror(errno));
+		if (count == 0) {
+			i--;
+			break;
+		}
+		if (buffer[i] == '\n')
+			break;
+	}
+	buffer[i + 1] = '\0';
+	return i + 1;
+}
+
+/* returns an fd */
+static int read_header(const char *path, struct bundle_header *header) {
+	char buffer[1024];
+	int fd = open(path, O_RDONLY);
+
+	if (fd < 0)
+		return error("could not open '%s'", path);
+	if (read_string(fd, buffer, sizeof(buffer)) < 0 ||
+			strcmp(buffer, bundle_signature)) {
+		close(fd);
+		return error("'%s' does not look like a v2 bundle file", path);
+	}
+	while (read_string(fd, buffer, sizeof(buffer)) > 0
+			&& buffer[0] != '\n') {
+		int offset = buffer[0] == '-' ? 1 : 0;
+		int len = strlen(buffer);
+		unsigned char sha1[20];
+		struct ref_list *list = offset ? &header->prerequisites
+			: &header->references;
+		if (get_sha1_hex(buffer + offset, sha1)) {
+			close(fd);
+			return error("invalid SHA1: %s", buffer);
+		}
+		if (buffer[len - 1] == '\n')
+			buffer[len - 1] = '\0';
+		add_to_ref_list(sha1, buffer + 41 + offset, list);
+	}
+	return fd;
+}
+
+/* if in && *in >= 0, take that as input file descriptor instead */
+static int fork_with_pipe(const char **argv, int *in, int *out)
+{
+	int needs_in, needs_out;
+	int fdin[2], fdout[2], pid;
+
+	needs_in = in && *in < 0;
+	if (needs_in) {
+		if (pipe(fdin) < 0)
+			return error("could not setup pipe");
+		*in = fdin[1];
+	}
+
+	needs_out = out && *out < 0;
+	if (needs_out) {
+		if (pipe(fdout) < 0)
+			return error("could not setup pipe");
+		*out = fdout[0];
+	}
+
+	if ((pid = fork()) < 0) {
+		if (needs_in) {
+			close(fdin[0]);
+			close(fdin[1]);
+		}
+		if (needs_out) {
+			close(fdout[0]);
+			close(fdout[1]);
+		}
+		return error("could not fork");
+	}
+	if (!pid) {
+		if (needs_in) {
+			dup2(fdin[0], 0);
+			close(fdin[0]);
+			close(fdin[1]);
+		} else if (in)
+			dup2(*in, 0);
+		if (needs_out) {
+			dup2(fdout[1], 1);
+			close(fdout[0]);
+			close(fdout[1]);
+		} else if (out)
+			dup2(*out, 1);
+		exit(execv_git_cmd(argv));
+	}
+	if (needs_in)
+		close(fdin[0]);
+	if (needs_out)
+		close(fdout[1]);
+	return pid;
+}
+
+static int verify_bundle(struct bundle_header *header)
+{
+	/*
+	 * Do fast check, then if any prereqs are missing then go line by line
+	 * to be verbose about the errors
+	 */
+	struct ref_list *p = &header->prerequisites;
+	const char *argv[5] = {"rev-list", "--stdin", "--not", "--all", NULL};
+	int pid, in, out, i, ret = 0;
+	char buffer[1024];
+
+	in = out = -1;
+	pid = fork_with_pipe(argv, &in, &out);
+	if (pid < 0)
+		return error("Could not fork rev-list");
+	if (!fork()) {
+		for (i = 0; i < p->nr; i++) {
+			write(in, sha1_to_hex(p->list[i].sha1), 40);
+			write(in, "\n", 1);
+		}
+		close(in);
+		exit(0);
+	}
+	close(in);
+	while (read_string(out, buffer, sizeof(buffer)) > 0) {
+		if (ret++ == 0)
+			error ("The bundle requires the following commits you lack:");
+		fprintf(stderr, "%s", buffer);
+	}
+	close(out);
+	while (waitpid(pid, &i, 0) < 0)
+		if (errno != EINTR)
+			return -1;
+	if (!ret && (!WIFEXITED(i) || WEXITSTATUS(i)))
+		return error("At least one prerequisite is lacking.");
+
+	return ret;
+}
+
+static int list_heads(struct bundle_header *header, int argc, const char **argv)
+{
+	int i;
+	struct ref_list *r = &header->references;
+
+	for (i = 0; i < r->nr; i++) {
+		if (argc > 1) {
+			int j;
+			for (j = 1; j < argc; j++)
+				if (!strcmp(r->list[i].name, argv[j]))
+					break;
+			if (j == argc)
+				continue;
+		}
+		printf("%s %s\n", sha1_to_hex(r->list[i].sha1),
+				r->list[i].name);
+	}
+	return 0;
+}
+
+static void show_commit(struct commit *commit)
+{
+	write(1, sha1_to_hex(commit->object.sha1), 40);
+	write(1, "\n", 1);
+	if (commit->parents) {
+		free_commit_list(commit->parents);
+		commit->parents = NULL;
+	}
+}
+
+static void show_object(struct object_array_entry *p)
+{
+	/* An object with name "foo\n0000000..." can be used to
+	 *          * confuse downstream git-pack-objects very badly.
+	 *                   */
+	const char *ep = strchr(p->name, '\n');
+	int len = ep ? ep - p->name : strlen(p->name);
+	write(1, sha1_to_hex(p->item->sha1), 40);
+	write(1, " ", 1);
+	if (len)
+		write(1, p->name, len);
+	write(1, "\n", 1);
+}
+
+static int create_bundle(struct bundle_header *header, const char *path,
+		int argc, const char **argv)
+{
+	int bundle_fd = -1;
+	const char **argv_boundary = xmalloc((argc + 3) * sizeof(const char *));
+	const char **argv_pack = xmalloc(4 * sizeof(const char *));
+	int pid, in, out, i, status;
+	char buffer[1024];
+	struct rev_info revs;
+
+	bundle_fd = (!strcmp(path, "-") ? 1 :
+			open(path, O_CREAT | O_WRONLY, 0666));
+	if (bundle_fd < 0)
+		return error("Could not write to '%s'", path);
+
+	/* write signature */
+	write(bundle_fd, bundle_signature, strlen(bundle_signature));
+
+	/* write prerequisites */
+	memcpy(argv_boundary + 2, argv + 1, argc * sizeof(const char *));
+	argv_boundary[0] = "rev-list";
+	argv_boundary[1] = "--boundary";
+	argv_boundary[argc + 1] = NULL;
+	out = -1;
+	pid = fork_with_pipe(argv_boundary, NULL, &out);
+	if (pid < 0)
+		return -1;
+	while ((i = read_string(out, buffer, sizeof(buffer))) > 0)
+		if (buffer[0] == '-')
+			write(bundle_fd, buffer, i);
+	while ((i = waitpid(pid, &status, 0)) < 0)
+		if (errno != EINTR)
+			return error("rev-list died");
+	if (!WIFEXITED(status) || WEXITSTATUS(status))
+		return error("rev-list died %d", WEXITSTATUS(status));
+
+	/* write references */
+	save_commit_buffer = 0;
+	init_revisions(&revs, NULL);
+	revs.tag_objects = 1;
+	revs.tree_objects = 1;
+	revs.blob_objects = 1;
+	argc = setup_revisions(argc, argv, &revs, NULL);
+	if (argc > 1)
+		return error("unrecognized argument: %s'", argv[1]);
+	for (i = 0; i < revs.pending.nr; i++) {
+		struct object_array_entry *e = revs.pending.objects + i;
+		if (!(e->item->flags & UNINTERESTING)) {
+			unsigned char sha1[20];
+			char *ref;
+			if (dwim_ref(e->name, strlen(e->name), sha1, &ref) != 1)
+				continue;
+			write(bundle_fd, sha1_to_hex(e->item->sha1), 40);
+			write(bundle_fd, " ", 1);
+			write(bundle_fd, ref, strlen(ref));
+			write(bundle_fd, "\n", 1);
+			free(ref);
+		}
+	}
+
+	/* end header */
+	write(bundle_fd, "\n", 1);
+
+	/* write pack */
+	argv_pack[0] = "pack-objects";
+	argv_pack[1] = "--all-progress";
+	argv_pack[2] = "--stdout";
+	argv_pack[3] = NULL;
+	in = -1;
+	out = bundle_fd;
+	pid = fork_with_pipe(argv_pack, &in, &out);
+	if (pid < 0)
+		return error("Could not spawn pack-objects");
+	close(1);
+	close(bundle_fd);
+	dup2(in, 1);
+	close(in);
+	prepare_revision_walk(&revs);
+	traverse_commit_list(&revs, show_commit, show_object);
+	close(1);
+	while (waitpid(pid, &status, 0) < 0)
+		if (errno != EINTR)
+			return -1;
+	if (!WIFEXITED(status) || WEXITSTATUS(status))
+		return error ("pack-objects died");
+	return 0;
+}
+
+static int unbundle(struct bundle_header *header, int bundle_fd,
+		int argc, const char **argv)
+{
+	const char *argv_index_pack[] = {"index-pack", "--stdin", NULL};
+	int pid, status, dev_null;
+
+	if (verify_bundle(header))
+		return -1;
+	dev_null = open("/dev/null", O_WRONLY);
+	pid = fork_with_pipe(argv_index_pack, &bundle_fd, &dev_null);
+	if (pid < 0)
+		return error("Could not spawn index-pack");
+	close(bundle_fd);
+	while (waitpid(pid, &status, 0) < 0)
+		if (errno != EINTR)
+			return error("index-pack died");
+	if (!WIFEXITED(status) || WEXITSTATUS(status))
+		return error("index-pack exited with status %d",
+				WEXITSTATUS(status));
+	return list_heads(header, argc, argv);
+}
+
+int cmd_bundle(int argc, const char **argv, const char *prefix)
+{
+	struct bundle_header header;
+	int nongit = 0;
+	const char *cmd, *bundle_file;
+	int bundle_fd = -1;
+	char buffer[PATH_MAX];
+
+	if (argc < 3)
+		usage(bundle_usage);
+
+	cmd = argv[1];
+	bundle_file = argv[2];
+	argc -= 2;
+	argv += 2;
+
+	prefix = setup_git_directory_gently(&nongit);
+	if (prefix && bundle_file[0] != '/') {
+		snprintf(buffer, sizeof(buffer), "%s/%s", prefix, bundle_file);
+		bundle_file = buffer;
+	}
+
+	memset(&header, 0, sizeof(header));
+	if (strcmp(cmd, "create") &&
+			!(bundle_fd = read_header(bundle_file, &header)))
+		return 1;
+
+	if (!strcmp(cmd, "verify")) {
+		close(bundle_fd);
+		if (verify_bundle(&header))
+			return 1;
+		fprintf(stderr, "%s is okay\n", bundle_file);
+		return 0;
+	}
+	if (!strcmp(cmd, "list-heads")) {
+		close(bundle_fd);
+		return !!list_heads(&header, argc, argv);
+	}
+	if (!strcmp(cmd, "create")) {
+		if (nongit)
+			die("Need a repository to create a bundle.");
+		return !!create_bundle(&header, bundle_file, argc, argv);
+	} else if (!strcmp(cmd, "unbundle")) {
+		if (nongit)
+			die("Need a repository to unbundle.");
+		return !!unbundle(&header, bundle_fd, argc, argv);
+	} else
+		usage(bundle_usage);
+}
+
diff --git a/builtin.h b/builtin.h
index 57e8741..528074b 100644
--- a/builtin.h
+++ b/builtin.h
@@ -19,6 +19,7 @@ extern int cmd_apply(int argc, const char **argv, const char *prefix);
 extern int cmd_archive(int argc, const char **argv, const char *prefix);
 extern int cmd_blame(int argc, const char **argv, const char *prefix);
 extern int cmd_branch(int argc, const char **argv, const char *prefix);
+extern int cmd_bundle(int argc, const char **argv, const char *prefix);
 extern int cmd_cat_file(int argc, const char **argv, const char *prefix);
 extern int cmd_checkout_index(int argc, const char **argv, const char *prefix);
 extern int cmd_check_ref_format(int argc, const char **argv, const char *prefix);
diff --git a/git-fetch.sh b/git-fetch.sh
index 5d3fec0..5ae0d28 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -388,9 +388,16 @@ fetch_main () {
     ( : subshell because we muck with IFS
       IFS=" 	$LF"
       (
+	if test -f "$remote" ; then
+	    test -n "$shallow_depth" &&
+		die "shallow clone with bundle is not supported"
+	    git-bundle unbundle "$remote" $rref ||
+	    echo failed "$remote"
+	else
 	  git-fetch-pack --thin $exec $keep $shallow_depth $no_progress \
 		"$remote" $rref ||
 	  echo failed "$remote"
+	fi
       ) |
       (
 	trap '
diff --git a/git-ls-remote.sh b/git-ls-remote.sh
index 8ea5c5e..a6ed99a 100755
--- a/git-ls-remote.sh
+++ b/git-ls-remote.sh
@@ -89,8 +89,13 @@ rsync://* )
 	;;
 
 * )
-	git-peek-remote $exec "$peek_repo" ||
+	if test -f "$peek_repo" ; then
+		git bundle list-heads "$peek_repo" ||
 		echo "failed	slurping"
+	else
+		git-peek-remote $exec "$peek_repo" ||
+		echo "failed	slurping"
+	fi
 	;;
 esac |
 sort -t '	' -k 2 |
diff --git a/git.c b/git.c
index 83f3d90..a184d47 100644
--- a/git.c
+++ b/git.c
@@ -229,6 +229,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "archive", cmd_archive },
 		{ "blame", cmd_blame, RUN_SETUP },
 		{ "branch", cmd_branch, RUN_SETUP },
+		{ "bundle", cmd_bundle },
 		{ "cat-file", cmd_cat_file, RUN_SETUP },
 		{ "checkout-index", cmd_checkout_index, RUN_SETUP },
 		{ "check-ref-format", cmd_check_ref_format },
diff --git a/index-pack.c b/index-pack.c
index fa9a0e7..5ccf4c4 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -457,8 +457,8 @@ static void parse_pack_objects(unsigned char *sha1)
 	/* If input_fd is a file, we should have reached its end now. */
 	if (fstat(input_fd, &st))
 		die("cannot fstat packfile: %s", strerror(errno));
-	if (S_ISREG(st.st_mode) && st.st_size != consumed_bytes)
-		die("pack has junk at the end");
+	if (input_fd && S_ISREG(st.st_mode) && st.st_size != consumed_bytes)
+		die("pack has junk at the end: 0%o, %d, %d %d", st.st_mode, (int)st.st_size, (int)consumed_bytes, input_fd);
 
 	if (!nr_deltas)
 		return;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 50c6485..fa76662 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -35,7 +35,9 @@ test_expect_success "clone and setup child repos" '
 		echo "URL: ../two/.git/"
 		echo "Pull: refs/heads/master:refs/heads/two"
 		echo "Pull: refs/heads/one:refs/heads/one"
-	} >.git/remotes/two
+	} >.git/remotes/two &&
+	cd .. &&
+	git clone . bundle
 '
 
 test_expect_success "fetch test" '
@@ -81,4 +83,28 @@ test_expect_success 'fetch following tags' '
 
 '
 
+test_expect_success 'create bundle 1' '
+	cd "$D" &&
+	echo >file updated again by origin &&
+	git commit -a -m "tip" &&
+	git bundle create bundle1 master^..master
+'
+
+test_expect_success 'create bundle 2' '
+	cd "$D" &&
+	git bundle create bundle2 master~2..master
+'
+
+test_expect_failure 'unbundle 1' '
+	cd "$D/bundle" &&
+	git checkout -b some-branch &&
+	git fetch "$D/bundle1" master:master
+'
+
+test_expect_success 'unbundle 2' '
+	cd "$D/bundle" &&
+	git fetch ../bundle2 master:master &&
+	test "tip" = "$(git log -1 --pretty=oneline master | cut -b42-)"
+'
+
 test_done
-- 
1.5.0.1.616.gc6c4-dirty
