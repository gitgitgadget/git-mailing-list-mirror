From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/3] Move bundle specific stuff into bundle.[ch]
Date: Tue, 17 Jul 2007 23:49:23 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707172346450.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 00:50:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAvrr-0003rK-Qg
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 00:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758322AbXGQWtr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 18:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756370AbXGQWtr
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 18:49:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:34717 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755411AbXGQWtp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 18:49:45 -0400
Received: (qmail invoked by alias); 17 Jul 2007 22:49:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp019) with SMTP; 18 Jul 2007 00:49:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+pTcNiUt6pgfbMp0MlTShb2SUXTfzJqbY2tkiy2+
	YK+m047j92JpLp
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52809>


The transport specific stuff was moved into libgit.a, and the
bundle specific stuff will not be left behind.

This is a big code move, with one exception: the function
unbundle() no longer outputs the list of refs.  You have to call
list_bundle_refs() yourself for that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	FWIW this patch series is based on the bf_series branch of
	git://iabervon.org/~barkalow/git.git, revision a204e4b4.

 Makefile         |    2 +-
 builtin-bundle.c |  330 +-----------------------------------------------------
 bundle.c         |  310 ++++++++++++++++++++++++++++++++++++++++++++++++++
 bundle.h         |   25 ++++
 4 files changed, 342 insertions(+), 325 deletions(-)
 create mode 100644 bundle.c
 create mode 100644 bundle.h

diff --git a/Makefile b/Makefile
index 335be8f..a389ee7 100644
--- a/Makefile
+++ b/Makefile
@@ -318,7 +318,7 @@ LIB_OBJS = \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
 	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o \
-	transport.o
+	transport.o bundle.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/builtin-bundle.c b/builtin-bundle.c
index 306ad29..22d03a3 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -1,10 +1,5 @@
 #include "cache.h"
-#include "object.h"
-#include "commit.h"
-#include "diff.h"
-#include "revision.h"
-#include "list-objects.h"
-#include "run-command.h"
+#include "bundle.h"
 
 /*
  * Basic handler for bundle files to connect repositories via sneakernet.
@@ -15,320 +10,6 @@
 
 static const char *bundle_usage="git-bundle (create <bundle> <git-rev-list args> | verify <bundle> | list-heads <bundle> [refname]... | unbundle <bundle> [refname]... )";
 
-static const char bundle_signature[] = "# v2 git bundle\n";
-
-struct ref_list {
-	unsigned int nr, alloc;
-	struct ref_list_entry {
-		unsigned char sha1[20];
-		char *name;
-	} *list;
-};
-
-static void add_to_ref_list(const unsigned char *sha1, const char *name,
-		struct ref_list *list)
-{
-	if (list->nr + 1 >= list->alloc) {
-		list->alloc = alloc_nr(list->nr + 1);
-		list->list = xrealloc(list->list,
-				list->alloc * sizeof(list->list[0]));
-	}
-	memcpy(list->list[list->nr].sha1, sha1, 20);
-	list->list[list->nr].name = xstrdup(name);
-	list->nr++;
-}
-
-struct bundle_header {
-	struct ref_list prerequisites;
-	struct ref_list references;
-};
-
-/* this function returns the length of the string */
-static int read_string(int fd, char *buffer, int size)
-{
-	int i;
-	for (i = 0; i < size - 1; i++) {
-		ssize_t count = xread(fd, buffer + i, 1);
-		if (count < 0)
-			return error("Read error: %s", strerror(errno));
-		if (count == 0) {
-			i--;
-			break;
-		}
-		if (buffer[i] == '\n')
-			break;
-	}
-	buffer[i + 1] = '\0';
-	return i + 1;
-}
-
-/* returns an fd */
-static int read_header(const char *path, struct bundle_header *header) {
-	char buffer[1024];
-	int fd = open(path, O_RDONLY);
-
-	if (fd < 0)
-		return error("could not open '%s'", path);
-	if (read_string(fd, buffer, sizeof(buffer)) < 0 ||
-			strcmp(buffer, bundle_signature)) {
-		close(fd);
-		return error("'%s' does not look like a v2 bundle file", path);
-	}
-	while (read_string(fd, buffer, sizeof(buffer)) > 0
-			&& buffer[0] != '\n') {
-		int is_prereq = buffer[0] == '-';
-		int offset = is_prereq ? 1 : 0;
-		int len = strlen(buffer);
-		unsigned char sha1[20];
-		struct ref_list *list = is_prereq ? &header->prerequisites
-			: &header->references;
-		char delim;
-
-		if (buffer[len - 1] == '\n')
-			buffer[len - 1] = '\0';
-		if (get_sha1_hex(buffer + offset, sha1)) {
-			warning("unrecognized header: %s", buffer);
-			continue;
-		}
-		delim = buffer[40 + offset];
-		if (!isspace(delim) && (delim != '\0' || !is_prereq))
-			die ("invalid header: %s", buffer);
-		add_to_ref_list(sha1, isspace(delim) ?
-				buffer + 41 + offset : "", list);
-	}
-	return fd;
-}
-
-static int list_refs(struct ref_list *r, int argc, const char **argv)
-{
-	int i;
-
-	for (i = 0; i < r->nr; i++) {
-		if (argc > 1) {
-			int j;
-			for (j = 1; j < argc; j++)
-				if (!strcmp(r->list[i].name, argv[j]))
-					break;
-			if (j == argc)
-				continue;
-		}
-		printf("%s %s\n", sha1_to_hex(r->list[i].sha1),
-				r->list[i].name);
-	}
-	return 0;
-}
-
-#define PREREQ_MARK (1u<<16)
-
-static int verify_bundle(struct bundle_header *header, int verbose)
-{
-	/*
-	 * Do fast check, then if any prereqs are missing then go line by line
-	 * to be verbose about the errors
-	 */
-	struct ref_list *p = &header->prerequisites;
-	struct rev_info revs;
-	const char *argv[] = {NULL, "--all"};
-	struct object_array refs;
-	struct commit *commit;
-	int i, ret = 0, req_nr;
-	const char *message = "Repository lacks these prerequisite commits:";
-
-	init_revisions(&revs, NULL);
-	for (i = 0; i < p->nr; i++) {
-		struct ref_list_entry *e = p->list + i;
-		struct object *o = parse_object(e->sha1);
-		if (o) {
-			o->flags |= PREREQ_MARK;
-			add_pending_object(&revs, o, e->name);
-			continue;
-		}
-		if (++ret == 1)
-			error(message);
-		error("%s %s", sha1_to_hex(e->sha1), e->name);
-	}
-	if (revs.pending.nr != p->nr)
-		return ret;
-	req_nr = revs.pending.nr;
-	setup_revisions(2, argv, &revs, NULL);
-
-	memset(&refs, 0, sizeof(struct object_array));
-	for (i = 0; i < revs.pending.nr; i++) {
-		struct object_array_entry *e = revs.pending.objects + i;
-		add_object_array(e->item, e->name, &refs);
-	}
-
-	prepare_revision_walk(&revs);
-
-	i = req_nr;
-	while (i && (commit = get_revision(&revs)))
-		if (commit->object.flags & PREREQ_MARK)
-			i--;
-
-	for (i = 0; i < req_nr; i++)
-		if (!(refs.objects[i].item->flags & SHOWN)) {
-			if (++ret == 1)
-				error(message);
-			error("%s %s", sha1_to_hex(refs.objects[i].item->sha1),
-				refs.objects[i].name);
-		}
-
-	for (i = 0; i < refs.nr; i++)
-		clear_commit_marks((struct commit *)refs.objects[i].item, -1);
-
-	if (verbose) {
-		struct ref_list *r;
-
-		r = &header->references;
-		printf("The bundle contains %d ref%s\n",
-		       r->nr, (1 < r->nr) ? "s" : "");
-		list_refs(r, 0, NULL);
-		r = &header->prerequisites;
-		printf("The bundle requires these %d ref%s\n",
-		       r->nr, (1 < r->nr) ? "s" : "");
-		list_refs(r, 0, NULL);
-	}
-	return ret;
-}
-
-static int list_heads(struct bundle_header *header, int argc, const char **argv)
-{
-	return list_refs(&header->references, argc, argv);
-}
-
-static int create_bundle(struct bundle_header *header, const char *path,
-		int argc, const char **argv)
-{
-	int bundle_fd = -1;
-	const char **argv_boundary = xmalloc((argc + 4) * sizeof(const char *));
-	const char **argv_pack = xmalloc(5 * sizeof(const char *));
-	int i, ref_count = 0;
-	char buffer[1024];
-	struct rev_info revs;
-	struct child_process rls;
-
-	bundle_fd = (!strcmp(path, "-") ? 1 :
-			open(path, O_CREAT | O_EXCL | O_WRONLY, 0666));
-	if (bundle_fd < 0)
-		return error("Could not create '%s': %s", path, strerror(errno));
-
-	/* write signature */
-	write_or_die(bundle_fd, bundle_signature, strlen(bundle_signature));
-
-	/* init revs to list objects for pack-objects later */
-	save_commit_buffer = 0;
-	init_revisions(&revs, NULL);
-
-	/* write prerequisites */
-	memcpy(argv_boundary + 3, argv + 1, argc * sizeof(const char *));
-	argv_boundary[0] = "rev-list";
-	argv_boundary[1] = "--boundary";
-	argv_boundary[2] = "--pretty=oneline";
-	argv_boundary[argc + 2] = NULL;
-	memset(&rls, 0, sizeof(rls));
-	rls.argv = argv_boundary;
-	rls.out = -1;
-	rls.git_cmd = 1;
-	if (start_command(&rls))
-		return -1;
-	while ((i = read_string(rls.out, buffer, sizeof(buffer))) > 0) {
-		unsigned char sha1[20];
-		if (buffer[0] == '-') {
-			write_or_die(bundle_fd, buffer, i);
-			if (!get_sha1_hex(buffer + 1, sha1)) {
-				struct object *object = parse_object(sha1);
-				object->flags |= UNINTERESTING;
-				add_pending_object(&revs, object, buffer);
-			}
-		} else if (!get_sha1_hex(buffer, sha1)) {
-			struct object *object = parse_object(sha1);
-			object->flags |= SHOWN;
-		}
-	}
-	if (finish_command(&rls))
-		return error("rev-list died");
-
-	/* write references */
-	argc = setup_revisions(argc, argv, &revs, NULL);
-	if (argc > 1)
-		return error("unrecognized argument: %s'", argv[1]);
-
-	for (i = 0; i < revs.pending.nr; i++) {
-		struct object_array_entry *e = revs.pending.objects + i;
-		unsigned char sha1[20];
-		char *ref;
-
-		if (e->item->flags & UNINTERESTING)
-			continue;
-		if (dwim_ref(e->name, strlen(e->name), sha1, &ref) != 1)
-			continue;
-		/*
-		 * Make sure the refs we wrote out is correct; --max-count and
-		 * other limiting options could have prevented all the tips
-		 * from getting output.
-		 */
-		if (!(e->item->flags & SHOWN)) {
-			warning("ref '%s' is excluded by the rev-list options",
-				e->name);
-			continue;
-		}
-		ref_count++;
-		write_or_die(bundle_fd, sha1_to_hex(e->item->sha1), 40);
-		write_or_die(bundle_fd, " ", 1);
-		write_or_die(bundle_fd, ref, strlen(ref));
-		write_or_die(bundle_fd, "\n", 1);
-		free(ref);
-	}
-	if (!ref_count)
-		die ("Refusing to create empty bundle.");
-
-	/* end header */
-	write_or_die(bundle_fd, "\n", 1);
-
-	/* write pack */
-	argv_pack[0] = "pack-objects";
-	argv_pack[1] = "--all-progress";
-	argv_pack[2] = "--stdout";
-	argv_pack[3] = "--thin";
-	argv_pack[4] = NULL;
-	memset(&rls, 0, sizeof(rls));
-	rls.argv = argv_pack;
-	rls.in = -1;
-	rls.out = bundle_fd;
-	rls.git_cmd = 1;
-	if (start_command(&rls))
-		return error("Could not spawn pack-objects");
-	for (i = 0; i < revs.pending.nr; i++) {
-		struct object *object = revs.pending.objects[i].item;
-		if (object->flags & UNINTERESTING)
-			write(rls.in, "^", 1);
-		write(rls.in, sha1_to_hex(object->sha1), 40);
-		write(rls.in, "\n", 1);
-	}
-	if (finish_command(&rls))
-		return error ("pack-objects died");
-	return 0;
-}
-
-static int unbundle(struct bundle_header *header, int bundle_fd,
-		int argc, const char **argv)
-{
-	const char *argv_index_pack[] = {"index-pack",
-		"--fix-thin", "--stdin", NULL};
-	struct child_process ip;
-
-	if (verify_bundle(header, 0))
-		return -1;
-	memset(&ip, 0, sizeof(ip));
-	ip.argv = argv_index_pack;
-	ip.in = bundle_fd;
-	ip.no_stdout = 1;
-	ip.git_cmd = 1;
-	if (run_command(&ip))
-		return error("index-pack died");
-	return list_heads(header, argc, argv);
-}
-
 int cmd_bundle(int argc, const char **argv, const char *prefix)
 {
 	struct bundle_header header;
@@ -352,8 +33,8 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 	}
 
 	memset(&header, 0, sizeof(header));
-	if (strcmp(cmd, "create") &&
-			(bundle_fd = read_header(bundle_file, &header)) < 0)
+	if (strcmp(cmd, "create") && (bundle_fd =
+				read_bundle_header(bundle_file, &header)) < 0)
 		return 1;
 
 	if (!strcmp(cmd, "verify")) {
@@ -365,7 +46,7 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 	}
 	if (!strcmp(cmd, "list-heads")) {
 		close(bundle_fd);
-		return !!list_heads(&header, argc, argv);
+		return !!list_bundle_refs(&header, argc, argv);
 	}
 	if (!strcmp(cmd, "create")) {
 		if (nongit)
@@ -374,7 +55,8 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 	} else if (!strcmp(cmd, "unbundle")) {
 		if (nongit)
 			die("Need a repository to unbundle.");
-		return !!unbundle(&header, bundle_fd, argc, argv);
+		return !!unbundle(&header, bundle_fd) ||
+			list_bundle_refs(&header, argc, argv);
 	} else
 		usage(bundle_usage);
 }
diff --git a/bundle.c b/bundle.c
new file mode 100644
index 0000000..659b61d
--- /dev/null
+++ b/bundle.c
@@ -0,0 +1,310 @@
+#include "cache.h"
+#include "bundle.h"
+#include "object.h"
+#include "commit.h"
+#include "diff.h"
+#include "revision.h"
+#include "list-objects.h"
+#include "run-command.h"
+
+static const char bundle_signature[] = "# v2 git bundle\n";
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
+/* this function returns the length of the string */
+static int read_string(int fd, char *buffer, int size)
+{
+	int i;
+	for (i = 0; i < size - 1; i++) {
+		ssize_t count = xread(fd, buffer + i, 1);
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
+int read_bundle_header(const char *path, struct bundle_header *header) {
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
+		int is_prereq = buffer[0] == '-';
+		int offset = is_prereq ? 1 : 0;
+		int len = strlen(buffer);
+		unsigned char sha1[20];
+		struct ref_list *list = is_prereq ? &header->prerequisites
+			: &header->references;
+		char delim;
+
+		if (buffer[len - 1] == '\n')
+			buffer[len - 1] = '\0';
+		if (get_sha1_hex(buffer + offset, sha1)) {
+			warning("unrecognized header: %s", buffer);
+			continue;
+		}
+		delim = buffer[40 + offset];
+		if (!isspace(delim) && (delim != '\0' || !is_prereq))
+			die ("invalid header: %s", buffer);
+		add_to_ref_list(sha1, isspace(delim) ?
+				buffer + 41 + offset : "", list);
+	}
+	return fd;
+}
+
+int create_bundle(struct bundle_header *header, const char *path,
+		int argc, const char **argv)
+{
+	int bundle_fd = -1;
+	const char **argv_boundary = xmalloc((argc + 4) * sizeof(const char *));
+	const char **argv_pack = xmalloc(5 * sizeof(const char *));
+	int i, ref_count = 0;
+	char buffer[1024];
+	struct rev_info revs;
+	struct child_process rls;
+
+	bundle_fd = (!strcmp(path, "-") ? 1 :
+			open(path, O_CREAT | O_EXCL | O_WRONLY, 0666));
+	if (bundle_fd < 0)
+		return error("Could not create '%s': %s", path, strerror(errno));
+
+	/* write signature */
+	write_or_die(bundle_fd, bundle_signature, strlen(bundle_signature));
+
+	/* init revs to list objects for pack-objects later */
+	save_commit_buffer = 0;
+	init_revisions(&revs, NULL);
+
+	/* write prerequisites */
+	memcpy(argv_boundary + 3, argv + 1, argc * sizeof(const char *));
+	argv_boundary[0] = "rev-list";
+	argv_boundary[1] = "--boundary";
+	argv_boundary[2] = "--pretty=oneline";
+	argv_boundary[argc + 2] = NULL;
+	memset(&rls, 0, sizeof(rls));
+	rls.argv = argv_boundary;
+	rls.out = -1;
+	rls.git_cmd = 1;
+	if (start_command(&rls))
+		return -1;
+	while ((i = read_string(rls.out, buffer, sizeof(buffer))) > 0) {
+		unsigned char sha1[20];
+		if (buffer[0] == '-') {
+			write_or_die(bundle_fd, buffer, i);
+			if (!get_sha1_hex(buffer + 1, sha1)) {
+				struct object *object = parse_object(sha1);
+				object->flags |= UNINTERESTING;
+				add_pending_object(&revs, object, buffer);
+			}
+		} else if (!get_sha1_hex(buffer, sha1)) {
+			struct object *object = parse_object(sha1);
+			object->flags |= SHOWN;
+		}
+	}
+	if (finish_command(&rls))
+		return error("rev-list died");
+
+	/* write references */
+	argc = setup_revisions(argc, argv, &revs, NULL);
+	if (argc > 1)
+		return error("unrecognized argument: %s'", argv[1]);
+
+	for (i = 0; i < revs.pending.nr; i++) {
+		struct object_array_entry *e = revs.pending.objects + i;
+		unsigned char sha1[20];
+		char *ref;
+
+		if (e->item->flags & UNINTERESTING)
+			continue;
+		if (dwim_ref(e->name, strlen(e->name), sha1, &ref) != 1)
+			continue;
+		/*
+		 * Make sure the refs we wrote out is correct; --max-count and
+		 * other limiting options could have prevented all the tips
+		 * from getting output.
+		 */
+		if (!(e->item->flags & SHOWN)) {
+			warning("ref '%s' is excluded by the rev-list options",
+				e->name);
+			continue;
+		}
+		ref_count++;
+		write_or_die(bundle_fd, sha1_to_hex(e->item->sha1), 40);
+		write_or_die(bundle_fd, " ", 1);
+		write_or_die(bundle_fd, ref, strlen(ref));
+		write_or_die(bundle_fd, "\n", 1);
+		free(ref);
+	}
+	if (!ref_count)
+		die ("Refusing to create empty bundle.");
+
+	/* end header */
+	write_or_die(bundle_fd, "\n", 1);
+
+	/* write pack */
+	argv_pack[0] = "pack-objects";
+	argv_pack[1] = "--all-progress";
+	argv_pack[2] = "--stdout";
+	argv_pack[3] = "--thin";
+	argv_pack[4] = NULL;
+	memset(&rls, 0, sizeof(rls));
+	rls.argv = argv_pack;
+	rls.in = -1;
+	rls.out = bundle_fd;
+	rls.git_cmd = 1;
+	if (start_command(&rls))
+		return error("Could not spawn pack-objects");
+	for (i = 0; i < revs.pending.nr; i++) {
+		struct object *object = revs.pending.objects[i].item;
+		if (object->flags & UNINTERESTING)
+			write(rls.in, "^", 1);
+		write(rls.in, sha1_to_hex(object->sha1), 40);
+		write(rls.in, "\n", 1);
+	}
+	if (finish_command(&rls))
+		return error ("pack-objects died");
+	return 0;
+}
+
+static int list_refs(struct ref_list *r, int argc, const char **argv)
+{
+	int i;
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
+int list_bundle_refs(struct bundle_header *header, int argc, const char **argv)
+{
+	return list_refs(&header->references, argc, argv);
+}
+
+#define PREREQ_MARK (1u<<16)
+
+int verify_bundle(struct bundle_header *header, int verbose)
+{
+	/*
+	 * Do fast check, then if any prereqs are missing then go line by line
+	 * to be verbose about the errors
+	 */
+	struct ref_list *p = &header->prerequisites;
+	struct rev_info revs;
+	const char *argv[] = {NULL, "--all"};
+	struct object_array refs;
+	struct commit *commit;
+	int i, ret = 0, req_nr;
+	const char *message = "Repository lacks these prerequisite commits:";
+
+	init_revisions(&revs, NULL);
+	for (i = 0; i < p->nr; i++) {
+		struct ref_list_entry *e = p->list + i;
+		struct object *o = parse_object(e->sha1);
+		if (o) {
+			o->flags |= PREREQ_MARK;
+			add_pending_object(&revs, o, e->name);
+			continue;
+		}
+		if (++ret == 1)
+			error(message);
+		error("%s %s", sha1_to_hex(e->sha1), e->name);
+	}
+	if (revs.pending.nr != p->nr)
+		return ret;
+	req_nr = revs.pending.nr;
+	setup_revisions(2, argv, &revs, NULL);
+
+	memset(&refs, 0, sizeof(struct object_array));
+	for (i = 0; i < revs.pending.nr; i++) {
+		struct object_array_entry *e = revs.pending.objects + i;
+		add_object_array(e->item, e->name, &refs);
+	}
+
+	prepare_revision_walk(&revs);
+
+	i = req_nr;
+	while (i && (commit = get_revision(&revs)))
+		if (commit->object.flags & PREREQ_MARK)
+			i--;
+
+	for (i = 0; i < req_nr; i++)
+		if (!(refs.objects[i].item->flags & SHOWN)) {
+			if (++ret == 1)
+				error(message);
+			error("%s %s", sha1_to_hex(refs.objects[i].item->sha1),
+				refs.objects[i].name);
+		}
+
+	for (i = 0; i < refs.nr; i++)
+		clear_commit_marks((struct commit *)refs.objects[i].item, -1);
+
+	if (verbose) {
+		struct ref_list *r;
+
+		r = &header->references;
+		printf("The bundle contains %d ref%s\n",
+		       r->nr, (1 < r->nr) ? "s" : "");
+		list_refs(r, 0, NULL);
+		r = &header->prerequisites;
+		printf("The bundle requires these %d ref%s\n",
+		       r->nr, (1 < r->nr) ? "s" : "");
+		list_refs(r, 0, NULL);
+	}
+	return ret;
+}
+
+int unbundle(struct bundle_header *header, int bundle_fd)
+{
+	const char *argv_index_pack[] = {"index-pack",
+		"--fix-thin", "--stdin", NULL};
+	struct child_process ip;
+
+	if (verify_bundle(header, 0))
+		return -1;
+	memset(&ip, 0, sizeof(ip));
+	ip.argv = argv_index_pack;
+	ip.in = bundle_fd;
+	ip.no_stdout = 1;
+	ip.git_cmd = 1;
+	if (run_command(&ip))
+		return error("index-pack died");
+	return 0;
+}
+
+
diff --git a/bundle.h b/bundle.h
new file mode 100644
index 0000000..e2aedd6
--- /dev/null
+++ b/bundle.h
@@ -0,0 +1,25 @@
+#ifndef BUNDLE_H
+#define BUNDLE_H
+
+struct ref_list {
+	unsigned int nr, alloc;
+	struct ref_list_entry {
+		unsigned char sha1[20];
+		char *name;
+	} *list;
+};
+
+struct bundle_header {
+	struct ref_list prerequisites;
+	struct ref_list references;
+};
+
+int read_bundle_header(const char *path, struct bundle_header *header);
+int create_bundle(struct bundle_header *header, const char *path,
+		int argc, const char **argv);
+int verify_bundle(struct bundle_header *header, int verbose);
+int unbundle(struct bundle_header *header, int bundle_fd);
+int list_bundle_refs(struct bundle_header *header,
+		int argc, const char **argv);
+
+#endif
-- 
1.5.3.rc1.16.g9d6f-dirty
