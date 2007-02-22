From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-bundle: assorted fixes
Date: Thu, 22 Feb 2007 19:14:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702221913250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702220157130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Levedahl <mdl123@verizon.net>, junkio@cox.net,
	Nicolas Pitre <nico@cam.org>,
	Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 22 19:15:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKITI-0005DX-LO
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 19:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbXBVSOS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 13:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbXBVSOS
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 13:14:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:52186 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751609AbXBVSOR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 13:14:17 -0500
Received: (qmail invoked by alias); 22 Feb 2007 18:14:15 -0000
X-Provags-ID: V01U2FsdGVkX1+gjrkfAiGgnsIyIdoztiU7UILD6Z+Y2e1cWRlz4U
	/IGw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0702220157130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40365>


This patch fixes issues mentioned by Junio, Nico and Simon:

- I forgot to convert the usage string when removing the "--" from
  the subcommands,
- a style fix in the bundle_header,
- use xread() instead of read(),
- use write_or_die() instead of write(),
- make the bundle header extensible,
- fail if the whitespace after a sha1 of a reference is missing,
- close() the fds passed to a subprocess,
- in verify_bundle(), do not use "rev-list --stdin", but rather
  pass the revs directly (avoiding a fork()),
- fix a corrupted comment in show_object(), and
- fix the size check in index_pack.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-bundle.c |  107 ++++++++++++++++++++++++++++++------------------------
 index-pack.c     |    5 ++-
 2 files changed, 63 insertions(+), 49 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index 4bd596a..521bbda 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -13,7 +13,7 @@
  * bundle supporting git-fetch, git-pull, and git-ls-remote
  */
 
-static const char *bundle_usage="git-bundle (--create <bundle> <git-rev-list args> | --verify <bundle> | --list-heads <bundle> [refname]... | --unbundle <bundle> [refname]... )";
+static const char *bundle_usage="git-bundle (create <bundle> <git-rev-list args> | verify <bundle> | list-heads <bundle> [refname]... | unbundle <bundle> [refname]... )";
 
 static const char bundle_signature[] = "# v2 git bundle\n";
 
@@ -39,7 +39,8 @@ static void add_to_ref_list(const unsigned char *sha1, const char *name,
 }
 
 struct bundle_header {
-	struct ref_list prerequisites, references;
+	struct ref_list prerequisites;
+	struct ref_list references;
 };
 
 /* this function returns the length of the string */
@@ -47,7 +48,7 @@ static int read_string(int fd, char *buffer, int size)
 {
 	int i;
 	for (i = 0; i < size - 1; i++) {
-		int count = read(fd, buffer + i, 1);
+		int count = xread(fd, buffer + i, 1);
 		if (count < 0)
 			return error("Read error: %s", strerror(errno));
 		if (count == 0) {
@@ -75,18 +76,25 @@ static int read_header(const char *path, struct bundle_header *header) {
 	}
 	while (read_string(fd, buffer, sizeof(buffer)) > 0
 			&& buffer[0] != '\n') {
-		int offset = buffer[0] == '-' ? 1 : 0;
+		int is_prereq = buffer[0] == '-';
+		int offset = is_prereq ? 1 : 0;
 		int len = strlen(buffer);
 		unsigned char sha1[20];
-		struct ref_list *list = offset ? &header->prerequisites
+		struct ref_list *list = is_prereq ? &header->prerequisites
 			: &header->references;
-		if (get_sha1_hex(buffer + offset, sha1)) {
-			close(fd);
-			return error("invalid SHA1: %s", buffer);
-		}
+		char delim;
+
 		if (buffer[len - 1] == '\n')
 			buffer[len - 1] = '\0';
-		add_to_ref_list(sha1, buffer + 41 + offset, list);
+		if (get_sha1_hex(buffer + offset, sha1)) {
+			warn("unrecognized header: %s", buffer);
+			continue;
+		}
+		delim = buffer[40 + offset];
+		if (!isspace(delim) && (delim != '\0' || !is_prereq))
+			die ("invalid header: %s", buffer);
+		add_to_ref_list(sha1, isspace(delim) ?
+				buffer + 41 + offset : "", list);
 	}
 	return fd;
 }
@@ -127,20 +135,28 @@ static int fork_with_pipe(const char **argv, int *in, int *out)
 			dup2(fdin[0], 0);
 			close(fdin[0]);
 			close(fdin[1]);
-		} else if (in)
+		} else if (in) {
 			dup2(*in, 0);
+			close(*in);
+		}
 		if (needs_out) {
 			dup2(fdout[1], 1);
 			close(fdout[0]);
 			close(fdout[1]);
-		} else if (out)
+		} else if (out) {
 			dup2(*out, 1);
+			close(*out);
+		}
 		exit(execv_git_cmd(argv));
 	}
 	if (needs_in)
 		close(fdin[0]);
+	else if (in)
+		close(*in);
 	if (needs_out)
 		close(fdout[1]);
+	else if (out)
+		close(*out);
 	return pid;
 }
 
@@ -151,29 +167,28 @@ static int verify_bundle(struct bundle_header *header)
 	 * to be verbose about the errors
 	 */
 	struct ref_list *p = &header->prerequisites;
-	const char *argv[5] = {"rev-list", "--stdin", "--not", "--all", NULL};
-	int pid, in, out, i, ret = 0;
+	char **argv;
+	int pid, out, i, ret = 0;
 	char buffer[1024];
 
-	in = out = -1;
-	pid = fork_with_pipe(argv, &in, &out);
+	argv = xmalloc((p->nr + 4) * sizeof(const char *));
+	argv[0] = "rev-list";
+	argv[1] = "--not";
+	argv[2] = "--all";
+	for (i = 0; i < p->nr; i++)
+		argv[i + 3] = xstrdup(sha1_to_hex(p->list[i].sha1));
+	argv[p->nr + 3] = NULL;
+	out = -1;
+	pid = fork_with_pipe((const char **)argv, NULL, &out);
 	if (pid < 0)
 		return error("Could not fork rev-list");
-	if (!fork()) {
-		for (i = 0; i < p->nr; i++) {
-			write(in, sha1_to_hex(p->list[i].sha1), 40);
-			write(in, "\n", 1);
-		}
-		close(in);
-		exit(0);
-	}
-	close(in);
-	while (read_string(out, buffer, sizeof(buffer)) > 0) {
-		if (ret++ == 0)
-			error ("The bundle requires the following commits you lack:");
-		fprintf(stderr, "%s", buffer);
-	}
+	while (read_string(out, buffer, sizeof(buffer)) > 0)
+		; /* do nothing */
 	close(out);
+	for (i = 0; i < p->nr; i++)
+		free(argv[i + 3]);
+	free(argv);
+
 	while (waitpid(pid, &i, 0) < 0)
 		if (errno != EINTR)
 			return -1;
@@ -205,8 +220,8 @@ static int list_heads(struct bundle_header *header, int argc, const char **argv)
 
 static void show_commit(struct commit *commit)
 {
-	write(1, sha1_to_hex(commit->object.sha1), 40);
-	write(1, "\n", 1);
+	write_or_die(1, sha1_to_hex(commit->object.sha1), 40);
+	write_or_die(1, "\n", 1);
 	if (commit->parents) {
 		free_commit_list(commit->parents);
 		commit->parents = NULL;
@@ -216,15 +231,15 @@ static void show_commit(struct commit *commit)
 static void show_object(struct object_array_entry *p)
 {
 	/* An object with name "foo\n0000000..." can be used to
-	 *          * confuse downstream git-pack-objects very badly.
-	 *                   */
+	 * confuse downstream git-pack-objects very badly.
+	 */
 	const char *ep = strchr(p->name, '\n');
 	int len = ep ? ep - p->name : strlen(p->name);
-	write(1, sha1_to_hex(p->item->sha1), 40);
-	write(1, " ", 1);
+	write_or_die(1, sha1_to_hex(p->item->sha1), 40);
+	write_or_die(1, " ", 1);
 	if (len)
-		write(1, p->name, len);
-	write(1, "\n", 1);
+		write_or_die(1, p->name, len);
+	write_or_die(1, "\n", 1);
 }
 
 static int create_bundle(struct bundle_header *header, const char *path,
@@ -243,7 +258,7 @@ static int create_bundle(struct bundle_header *header, const char *path,
 		return error("Could not write to '%s'", path);
 
 	/* write signature */
-	write(bundle_fd, bundle_signature, strlen(bundle_signature));
+	write_or_die(bundle_fd, bundle_signature, strlen(bundle_signature));
 
 	/* write prerequisites */
 	memcpy(argv_boundary + 2, argv + 1, argc * sizeof(const char *));
@@ -256,7 +271,7 @@ static int create_bundle(struct bundle_header *header, const char *path,
 		return -1;
 	while ((i = read_string(out, buffer, sizeof(buffer))) > 0)
 		if (buffer[0] == '-')
-			write(bundle_fd, buffer, i);
+			write_or_die(bundle_fd, buffer, i);
 	while ((i = waitpid(pid, &status, 0)) < 0)
 		if (errno != EINTR)
 			return error("rev-list died");
@@ -279,16 +294,16 @@ static int create_bundle(struct bundle_header *header, const char *path,
 			char *ref;
 			if (dwim_ref(e->name, strlen(e->name), sha1, &ref) != 1)
 				continue;
-			write(bundle_fd, sha1_to_hex(e->item->sha1), 40);
-			write(bundle_fd, " ", 1);
-			write(bundle_fd, ref, strlen(ref));
-			write(bundle_fd, "\n", 1);
+			write_or_die(bundle_fd, sha1_to_hex(e->item->sha1), 40);
+			write_or_die(bundle_fd, " ", 1);
+			write_or_die(bundle_fd, ref, strlen(ref));
+			write_or_die(bundle_fd, "\n", 1);
 			free(ref);
 		}
 	}
 
 	/* end header */
-	write(bundle_fd, "\n", 1);
+	write_or_die(bundle_fd, "\n", 1);
 
 	/* write pack */
 	argv_pack[0] = "pack-objects";
@@ -301,7 +316,6 @@ static int create_bundle(struct bundle_header *header, const char *path,
 	if (pid < 0)
 		return error("Could not spawn pack-objects");
 	close(1);
-	close(bundle_fd);
 	dup2(in, 1);
 	close(in);
 	prepare_revision_walk(&revs);
@@ -327,7 +341,6 @@ static int unbundle(struct bundle_header *header, int bundle_fd,
 	pid = fork_with_pipe(argv_index_pack, &bundle_fd, &dev_null);
 	if (pid < 0)
 		return error("Could not spawn index-pack");
-	close(bundle_fd);
 	while (waitpid(pid, &status, 0) < 0)
 		if (errno != EINTR)
 			return error("index-pack died");
diff --git a/index-pack.c b/index-pack.c
index 5ccf4c4..365f8f3 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -457,8 +457,9 @@ static void parse_pack_objects(unsigned char *sha1)
 	/* If input_fd is a file, we should have reached its end now. */
 	if (fstat(input_fd, &st))
 		die("cannot fstat packfile: %s", strerror(errno));
-	if (input_fd && S_ISREG(st.st_mode) && st.st_size != consumed_bytes)
-		die("pack has junk at the end: 0%o, %d, %d %d", st.st_mode, (int)st.st_size, (int)consumed_bytes, input_fd);
+	if (S_ISREG(st.st_mode) &&
+			lseek(input_fd, 0, SEEK_CUR) - input_len != st.st_size)
+		die("pack has junk at the end");
 
 	if (!nr_deltas)
 		return;
-- 
1.5.0.1.2213.g94bc-dirty
