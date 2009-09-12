From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] don't dereference NULL upon fdopen failure
Date: Sat, 12 Sep 2009 11:16:59 +0200
Message-ID: <87my5034l0.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 12 11:17:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmOjL-0003Zx-DZ
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 11:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbZILJRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 05:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbZILJRF
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 05:17:05 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:34657 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751987AbZILJRE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 05:17:04 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 5A001818083
	for <git@vger.kernel.org>; Sat, 12 Sep 2009 11:17:01 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 65918818103
	for <git@vger.kernel.org>; Sat, 12 Sep 2009 11:16:59 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 4A5C035A3A; Sat, 12 Sep 2009 11:16:59 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128243>

While making today's write_in_full -> write_str_in_full changes,
I noticed some unchecked fdopen uses.  A few were already checked,
but several others were not.  The patch below changes each unchecked
one to xfdopen.

>From 0cbde9e065a309f75a44a32f7ecc7453e0d482cf Mon Sep 17 00:00:00 2001
From: Jim Meyering <meyering@redhat.com>
Date: Sat, 12 Sep 2009 10:43:27 +0200
Subject: [PATCH] don't dereference NULL upon fdopen failure

* builtin-add.c (edit_patch): Use xfdopen instead.
* builtin-mailsplit.c (split_one): Likewise.
* bundle.c (create_bundle): Likewise.
* transport-helper.c (get_helper, fetch_with_fetch): Likewise.
(get_refs_list): Likewise.
* upload-pack.c (do_rev_list, create_pack_file): Likewise.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 builtin-add.c       |    2 +-
 builtin-mailsplit.c |    2 +-
 bundle.c            |    2 +-
 transport-helper.c  |    6 +++---
 upload-pack.c       |    4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index a571473..cb6e590 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -198,7 +198,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	out = open(file, O_CREAT | O_WRONLY, 0644);
 	if (out < 0)
 		die ("Could not open '%s' for writing.", file);
-	rev.diffopt.file = fdopen(out, "w");
+	rev.diffopt.file = xfdopen(out, "w");
 	rev.diffopt.close_file = 1;
 	if (run_diff_files(&rev, 0))
 		die ("Could not write patch");
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index ee6ca0e..dfe5b15 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -64,7 +64,7 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
 	fd = open(name, O_WRONLY | O_CREAT | O_EXCL, 0666);
 	if (fd < 0)
 		die_errno("cannot open output file '%s'", name);
-	output = fdopen(fd, "w");
+	output = xfdopen(fd, "w");

 	/* Copy it out, while searching for a line that begins with
 	 * "From " and having something that looks like a date format.
diff --git a/bundle.c b/bundle.c
index e4b2aa9..df95e15 100644
--- a/bundle.c
+++ b/bundle.c
@@ -234,7 +234,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 	rls.git_cmd = 1;
 	if (start_command(&rls))
 		return -1;
-	rls_fout = fdopen(rls.out, "r");
+	rls_fout = xfdopen(rls.out, "r");
 	while (fgets(buffer, sizeof(buffer), rls_fout)) {
 		unsigned char sha1[20];
 		if (buffer[0] == '-') {
diff --git a/transport-helper.c b/transport-helper.c
index 832d81f..f57e84c 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -39,7 +39,7 @@ static struct child_process *get_helper(struct transport *transport)

 	write_str_in_full(helper->in, "capabilities\n");

-	file = fdopen(helper->out, "r");
+	file = xfdopen(helper->out, "r");
 	while (1) {
 		if (strbuf_getline(&buf, file, '\n') == EOF)
 			exit(128); /* child died, message supplied already */
@@ -71,7 +71,7 @@ static int fetch_with_fetch(struct transport *transport,
 			    int nr_heads, const struct ref **to_fetch)
 {
 	struct child_process *helper = get_helper(transport);
-	FILE *file = fdopen(helper->out, "r");
+	FILE *file = xfdopen(helper->out, "r");
 	int i;
 	struct strbuf buf = STRBUF_INIT;

@@ -124,7 +124,7 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)

 	write_str_in_full(helper->in, "list\n");

-	file = fdopen(helper->out, "r");
+	file = xfdopen(helper->out, "r");
 	while (1) {
 		char *eov, *eon;
 		if (strbuf_getline(&buf, file, '\n') == EOF)
diff --git a/upload-pack.c b/upload-pack.c
index b3471e4..38ddac2 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -108,7 +108,7 @@ static int do_rev_list(int fd, void *create_full_pack)
 	int i;
 	struct rev_info revs;

-	pack_pipe = fdopen(fd, "w");
+	pack_pipe = xfdopen(fd, "w");
 	init_revisions(&revs, NULL);
 	revs.tag_objects = 1;
 	revs.tree_objects = 1;
@@ -255,7 +255,7 @@ static void create_pack_file(void)

 	/* pass on revisions we (don't) want */
 	if (!shallow_nr) {
-		FILE *pipe_fd = fdopen(pack_objects.in, "w");
+		FILE *pipe_fd = xfdopen(pack_objects.in, "w");
 		if (!create_full_pack) {
 			int i;
 			for (i = 0; i < want_obj.nr; i++)
--
1.6.5.rc0.190.g15871
