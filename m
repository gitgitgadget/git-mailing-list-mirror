From: Jeff King <peff@peff.net>
Subject: [PATCH] disable grafts during fetch/push/bundle
Date: Tue, 4 Mar 2014 12:48:07 -0500
Message-ID: <20140304174806.GA11561@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 18:48:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKtRv-0002PX-QU
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 18:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbaCDRsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 12:48:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:32873 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750990AbaCDRsK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 12:48:10 -0500
Received: (qmail 4883 invoked by uid 102); 4 Mar 2014 17:48:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Mar 2014 11:48:09 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Mar 2014 12:48:07 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243361>

When we are creating a pack to send to a remote, we should
make sure that we are not respecting grafts or replace refs.
Otherwise, we may end up sending a broken pack to the other
side that does not contain all objects (either omitting them
entirely, or using objects that the other side does not have
as delta bases).

We already make an attempt to do the right thing in several
places by turning off read_replace_refs. However, we missed
at least one case (during bundle creation), and we do
nothing anywhere to handle grafts.

This patch introduces a new function to disable both grafts
and replace refs both for the current process and for its
children. We add a call anywhere that packs objects for
sending: "bundle create", upload-pack, and push.

This may seem like a rather heavy hammer, as we could just
teach pack-objects not to respect grafts. But this catches
more possible failures:

  1. We may actually feed pack-objects with the results of
     rev-list (e.g., bundle creation does this).

  2. We may be negotiating the HAVEs and WANTs with the
     other side, and our view should be consistent with what
     we feed pack-objects.

  3. It may be useful to let pack-objects use grafts in some
     instances, as evidenced by --keep-true-parents.

Signed-off-by: Jeff King <peff@peff.net>
---
This is motivated by a real-world case of somebody trying to push to
GitHub with a graft on their local end.

I suspect many other spots that use "read_replace_refs = 0" probably
want to disable grafts, too (e.g., fsck and index-pack) but I do not
know of any particular breakage offhand.

I am tempted to say that not using --keep-true-parents is insane, and it
should be the default, but perhaps there is some case I'm missing.

Note that disabling grafts here just turns off .git/info/grafts, which
explicitly leaves the shallow file enabled (even though it ends up in
the same graft list). I'm assuming that the shallow file is handled
properly where it's appropriate, and it would not want to be included in
any of this disabling (certainly fetch/push should be handling it
explicitly already).

 builtin/push.c                   |  1 +
 bundle.c                         |  2 +
 cache.h                          |  1 +
 commit.c                         |  5 +++
 commit.h                         |  1 +
 environment.c                    | 22 ++++++++++
 t/t6051-replace-grafts-remote.sh | 94 ++++++++++++++++++++++++++++++++++++++++
 upload-pack.c                    |  2 +-
 8 files changed, 127 insertions(+), 1 deletion(-)
 create mode 100755 t/t6051-replace-grafts-remote.sh

diff --git a/builtin/push.c b/builtin/push.c
index 0e50ddb..448dcb5 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -527,6 +527,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	disable_grafts_and_replace_refs();
 	packet_trace_identity("push");
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
diff --git a/bundle.c b/bundle.c
index e99065c..37b00a6 100644
--- a/bundle.c
+++ b/bundle.c
@@ -248,6 +248,8 @@ int create_bundle(struct bundle_header *header, const char *path,
 	struct child_process rls;
 	FILE *rls_fout;
 
+	disable_grafts_and_replace_refs();
+
 	bundle_to_stdout = !strcmp(path, "-");
 	if (bundle_to_stdout)
 		bundle_fd = 1;
diff --git a/cache.h b/cache.h
index db223e8..f538cc2 100644
--- a/cache.h
+++ b/cache.h
@@ -410,6 +410,7 @@ extern const char *get_git_work_tree(void);
 extern const char *read_gitfile(const char *path);
 extern const char *resolve_gitdir(const char *suspect);
 extern void set_git_work_tree(const char *tree);
+extern void disable_grafts_and_replace_refs(void);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
diff --git a/commit.c b/commit.c
index 6bf4fe0..886dbfe 100644
--- a/commit.c
+++ b/commit.c
@@ -114,6 +114,11 @@ static unsigned long parse_commit_date(const char *buf, const char *tail)
 static struct commit_graft **commit_graft;
 static int commit_graft_alloc, commit_graft_nr;
 
+int commit_grafts_loaded(void)
+{
+	return !!commit_graft_nr;
+}
+
 static int commit_graft_pos(const unsigned char *sha1)
 {
 	int lo, hi;
diff --git a/commit.h b/commit.h
index 16d9c43..dde0618 100644
--- a/commit.h
+++ b/commit.h
@@ -186,6 +186,7 @@ typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
 struct commit_graft *read_graft_line(char *buf, int len);
 int register_commit_graft(struct commit_graft *, int);
 struct commit_graft *lookup_commit_graft(const unsigned char *sha1);
+int commit_grafts_loaded(void);
 
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2, int cleanup);
 extern struct commit_list *get_merge_bases_many(struct commit *one, int n, struct commit **twos, int cleanup);
diff --git a/environment.c b/environment.c
index 4a3437d..b960293 100644
--- a/environment.c
+++ b/environment.c
@@ -284,3 +284,25 @@ const char *get_commit_output_encoding(void)
 {
 	return git_commit_encoding ? git_commit_encoding : "UTF-8";
 }
+
+/*
+ * In theory we could just set the environment variables to disable these
+ * features, but we may have lazily read them already. So we set the
+ * environment to cover further reads of them by ourselves or child processes,
+ * and also make sure to clear any state set by already reading them.
+ *
+ * Note that this covers the time between program start and when we first read
+ * a variable. Once you have actually loaded the grafts themselves into memory,
+ * it is too late (they are intermingled with shallow information). This should
+ * be OK, but let's die() as a fallback.
+ */
+void disable_grafts_and_replace_refs(void)
+{
+	setenv(NO_REPLACE_OBJECTS_ENVIRONMENT, "1", 1);
+	read_replace_refs = 0;
+	setenv(GRAFT_ENVIRONMENT, "/dev/null", 1);
+	git_graft_file = "/dev/null";
+
+	if (commit_grafts_loaded())
+		die("BUG: tried to disable grafts too late");
+}
diff --git a/t/t6051-replace-grafts-remote.sh b/t/t6051-replace-grafts-remote.sh
new file mode 100755
index 0000000..67f122d
--- /dev/null
+++ b/t/t6051-replace-grafts-remote.sh
@@ -0,0 +1,94 @@
+#!/bin/sh
+
+test_description='test interaction replace and grafts with fetch/push/bundles
+
+We have a simple divergent history like this:
+
+  A--B master
+   \
+    C--D  other
+
+In our remote, we have A and B, but not C or D.
+
+In our main repository, we create a graft or replace ref to look like this:
+
+  A--C--B
+
+The remote will claim to have B, but we must be sure to continue to send C; it
+is an ancestor of B only in our graft/replace view, not in reality.
+'
+. ./test-lib.sh
+
+make_repo () {
+	rm -rf "$1" &&
+	git init --bare "$1" &&
+	git push remote "$2"
+}
+
+replace () {
+	test_when_finished git replace -d "$1" &&
+	git replace "$1" "$2"
+}
+
+graft () {
+	test_when_finished "rm -f .git/info/grafts" &&
+	echo "$1 $2" >.git/info/grafts
+}
+
+test_expect_success 'create commits' '
+	test_commit A &&
+	test_commit B &&
+	git checkout -b other A &&
+	test_commit C &&
+	test_commit D &&
+	A=$(git rev-parse --verify A) &&
+	B=$(git rev-parse --verify B) &&
+	C=$(git rev-parse --verify C) &&
+	D=$(git rev-parse --verify D)
+'
+
+test_expect_success 'create replace object' '
+	git cat-file commit B >commit.in &&
+	sed "s/$A/$C/" <commit.in >commit.out &&
+	replace=$(git hash-object -w -t commit commit.out)
+'
+
+test_expect_success 'push with replace object' '
+	make_repo remote B &&
+	replace "$B" "$replace" &&
+	git push remote D
+'
+
+test_expect_success 'fetch with replace object' '
+	make_repo remote B &&
+	replace "$B" "$replace" &&
+	(cd remote && git fetch .. D)
+'
+
+test_expect_success 'bundle with replace object' '
+	make_repo remote B &&
+	replace "$B" "$replace" &&
+	git bundle create foo.bundle ^B D &&
+	(cd remote && git fetch ../foo.bundle D)
+'
+
+test_expect_success 'push with graft' '
+	make_repo remote B &&
+	graft "$B" "$C" &&
+	git push remote D
+'
+
+test_expect_success 'fetch with graft' '
+	make_repo remote B &&
+	graft "$B" "$C" &&
+	(cd remote && git fetch .. D)
+'
+
+test_expect_success 'bundle with graft' '
+	make_repo remote B &&
+	graft "$B" "$C" &&
+	git bundle create foo.bundle ^B D &&
+	(cd remote && git fetch ../foo.bundle D)
+'
+
+test_done
diff --git a/upload-pack.c b/upload-pack.c
index 0c44f6b..a72e4fa 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -796,7 +796,7 @@ int main(int argc, char **argv)
 
 	packet_trace_identity("upload-pack");
 	git_extract_argv0_path(argv[0]);
-	read_replace_refs = 0;
+	disable_grafts_and_replace_refs();
 
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
-- 
1.8.5.2.500.g8060133
