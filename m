From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v5 1/3] Teach revision walking machinery to walk multiple
	times sequencially
Date: Mon, 13 Feb 2012 10:27:30 +0100
Message-ID: <20120213092730.GB15585@t1405.greatnet.de>
References: <20120213092541.GA15585@t1405.greatnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fredrik Gustafsson <iveqy@iveqy.com>,
	Jens Lehmann <jens.lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 10:34:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwsIc-0001Br-V4
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 10:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756417Ab2BMJeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 04:34:14 -0500
Received: from darksea.de ([83.133.111.250]:42038 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751865Ab2BMJeN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 04:34:13 -0500
Received: (qmail 15622 invoked by uid 1000); 13 Feb 2012 10:27:30 +0100
Content-Disposition: inline
In-Reply-To: <20120213092541.GA15585@t1405.greatnet.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190619>

Previously it was not possible to iterate revisions twice using the
revision walking api. We add a reset_revision_walk() which clears the
used flags. This allows us to do multiple sequencial revision walks.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 .gitignore                                       |    1 +
 Documentation/technical/api-revision-walking.txt |    5 ++
 Makefile                                         |    1 +
 object.c                                         |   11 ++++
 object.h                                         |    2 +
 revision.c                                       |    5 ++
 revision.h                                       |    1 +
 submodule.c                                      |    2 +
 t/t0062-revision-walking.sh                      |   33 +++++++++++
 test-revision-walking.c                          |   66 ++++++++++++++++++++++
 10 files changed, 127 insertions(+), 0 deletions(-)
 create mode 100755 t/t0062-revision-walking.sh
 create mode 100644 test-revision-walking.c

diff --git a/.gitignore b/.gitignore
index 3b7680e..2f09842 100644
--- a/.gitignore
+++ b/.gitignore
@@ -184,6 +184,7 @@
 /test-obj-pool
 /test-parse-options
 /test-path-utils
+/test-revision-walking
 /test-run-command
 /test-sha1
 /test-sigchain
diff --git a/Documentation/technical/api-revision-walking.txt b/Documentation/technical/api-revision-walking.txt
index 996da05..b7d0d9a 100644
--- a/Documentation/technical/api-revision-walking.txt
+++ b/Documentation/technical/api-revision-walking.txt
@@ -56,6 +56,11 @@ function.
 	returning a `struct commit *` each time you call it. The end of the
 	revision list is indicated by returning a NULL pointer.
 
+`reset_revision_walk`::
+
+	Reset the flags used by the revision walking api. You can use
+	this to do multiple sequencial revision walks.
+
 Data structures
 ---------------
 
diff --git a/Makefile b/Makefile
index c457c34..bff686f 100644
--- a/Makefile
+++ b/Makefile
@@ -472,6 +472,7 @@ TEST_PROGRAMS_NEED_X += test-mktemp
 TEST_PROGRAMS_NEED_X += test-obj-pool
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-path-utils
+TEST_PROGRAMS_NEED_X += test-revision-walking
 TEST_PROGRAMS_NEED_X += test-run-command
 TEST_PROGRAMS_NEED_X += test-sha1
 TEST_PROGRAMS_NEED_X += test-sigchain
diff --git a/object.c b/object.c
index 6b06297..6291ce9 100644
--- a/object.c
+++ b/object.c
@@ -275,3 +275,14 @@ void object_array_remove_duplicates(struct object_array *array)
 		array->nr = dst;
 	}
 }
+
+void clear_object_flags(unsigned flags)
+{
+	int i;
+	struct object *obj;
+
+	for (i=0; i < obj_hash_size; i++) {
+		if ((obj = obj_hash[i]) && obj->flags & flags)
+			obj->flags &= ~flags;
+	}
+}
diff --git a/object.h b/object.h
index b6618d9..6a97b6b 100644
--- a/object.h
+++ b/object.h
@@ -76,4 +76,6 @@ void add_object_array(struct object *obj, const char *name, struct object_array
 void add_object_array_with_mode(struct object *obj, const char *name, struct object_array *array, unsigned mode);
 void object_array_remove_duplicates(struct object_array *);
 
+void clear_object_flags(unsigned flags);
+
 #endif /* OBJECT_H */
diff --git a/revision.c b/revision.c
index c97d834..77ce6bd 100644
--- a/revision.c
+++ b/revision.c
@@ -2061,6 +2061,11 @@ static void set_children(struct rev_info *revs)
 	}
 }
 
+void reset_revision_walk()
+{
+	clear_object_flags(SEEN | ADDED | SHOWN);
+}
+
 int prepare_revision_walk(struct rev_info *revs)
 {
 	int nr = revs->pending.nr;
diff --git a/revision.h b/revision.h
index b8e9223..3535733 100644
--- a/revision.h
+++ b/revision.h
@@ -192,6 +192,7 @@ extern void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ct
 				 const char * const usagestr[]);
 extern int handle_revision_arg(const char *arg, struct rev_info *revs,int flags,int cant_be_filename);
 
+extern void reset_revision_walk();
 extern int prepare_revision_walk(struct rev_info *revs);
 extern struct commit *get_revision(struct rev_info *revs);
 extern char *get_revision_mark(const struct rev_info *revs, const struct commit *commit);
diff --git a/submodule.c b/submodule.c
index 9a28060..645ff5d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -404,6 +404,7 @@ int check_submodule_needs_pushing(unsigned char new_sha1[20], const char *remote
 	while ((commit = get_revision(&rev)) && !needs_pushing)
 		commit_need_pushing(commit, &needs_pushing);
 
+	reset_revision_walk();
 	free(sha1_copy);
 	strbuf_release(&remotes_arg);
 
@@ -741,6 +742,7 @@ static int find_first_merges(struct object_array *result, const char *path,
 		if (in_merge_bases(b, &commit, 1))
 			add_object_array(o, NULL, &merges);
 	}
+	reset_revision_walk();
 
 	/* Now we've got all merges that contain a and b. Prune all
 	 * merges that contain another found merge and save them in
diff --git a/t/t0062-revision-walking.sh b/t/t0062-revision-walking.sh
new file mode 100755
index 0000000..3d98eb8
--- /dev/null
+++ b/t/t0062-revision-walking.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Heiko Voigt
+#
+
+test_description='Test revision walking api'
+
+. ./test-lib.sh
+
+cat >run_twice_expected <<-EOF
+1st
+ > add b
+ > add a
+2nd
+ > add b
+ > add a
+EOF
+
+test_expect_success 'setup' '
+	echo a > a &&
+	git add a &&
+	git commit -m "add a" &&
+	echo b > b &&
+	git add b &&
+	git commit -m "add b"
+'
+
+test_expect_success 'revision walking can be done twice' '
+	test-revision-walking run-twice > run_twice_actual
+	test_cmp run_twice_expected run_twice_actual
+'
+
+test_done
diff --git a/test-revision-walking.c b/test-revision-walking.c
new file mode 100644
index 0000000..27ad597
--- /dev/null
+++ b/test-revision-walking.c
@@ -0,0 +1,66 @@
+/*
+ * test-revision-walking.c: test revision walking API.
+ *
+ * (C) 2012 Heiko Voigt <hvoigt@hvoigt.net>
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "cache.h"
+#include "commit.h"
+#include "diff.h"
+#include "revision.h"
+
+static void print_commit(struct commit *commit)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct pretty_print_context ctx = {0};
+	ctx.date_mode = DATE_NORMAL;
+	format_commit_message(commit, " %m %s", &sb, &ctx);
+	printf("%s\n", sb.buf);
+	strbuf_release(&sb);
+}
+
+static int run_revision_walk()
+{
+	struct rev_info rev;
+	struct commit *commit;
+	const char *argv[] = {NULL, "--all", NULL};
+	int argc = ARRAY_SIZE(argv) - 1;
+	int got_revision = 0;
+
+	init_revisions(&rev, NULL);
+	setup_revisions(argc, argv, &rev, NULL);
+	if (prepare_revision_walk(&rev))
+		die("revision walk setup failed");
+
+	while ((commit = get_revision(&rev)) != NULL) {
+		print_commit(commit);
+		got_revision = 1;
+	}
+
+	reset_revision_walk();
+	return got_revision;
+}
+
+int main(int argc, char **argv)
+{
+	if (argc < 2)
+		return 1;
+
+	if (!strcmp(argv[1], "run-twice")) {
+		printf("1st\n");
+		if (!run_revision_walk())
+			return 1;
+		printf("2nd\n");
+		if (!run_revision_walk())
+			return 1;
+
+		return 0;
+	}
+
+	fprintf(stderr, "check usage\n");
+	return 1;
+}
-- 
1.7.9.114.gead08
