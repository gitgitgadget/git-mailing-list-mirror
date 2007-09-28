From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] fetch/push: readd rsync support
Date: Fri, 28 Sep 2007 06:07:19 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709280606530.28395@racer.site>
References: <Pine.LNX.4.64.0709280602580.28395@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, Daniel Barkalow <barkalow@iabervon.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 07:08:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib85b-0003fv-50
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 07:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756483AbXI1FI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 01:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756423AbXI1FI2
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 01:08:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:57072 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752695AbXI1FI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 01:08:27 -0400
Received: (qmail invoked by alias); 28 Sep 2007 05:08:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp006) with SMTP; 28 Sep 2007 07:08:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX189HshbfPM9Tgx9uBYH7vorAD8E1Iq1AqdKoJ8sTq
	sbsSRL2Xz77ReU
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709280602580.28395@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59364>


We lost rsync support when transitioning from shell to C.  Support it
again (even if the transport is technically deprecated, some people just
do not have any chance to use anything else).

Also, add a test to t5510.  Since rsync transport is not configured by
default on most machines, and especially not such that you can
write to rsync://127.0.0.1$(pwd)/, it is disabled by default; you can
enable it by setting the environment variable TEST_RSYNC.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Maybe this should be moved into transport-rsync.c...

 t/t5510-fetch.sh |   35 ++++++
 transport.c      |  333 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 367 insertions(+), 1 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 439430f..73a4e3c 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -153,4 +153,39 @@ test_expect_success 'bundle should be able to create a full history' '
 
 '
 
+test "$TEST_RSYNC" && {
+test_expect_success 'fetch via rsync' '
+	git pack-refs &&
+	mkdir rsynced &&
+	cd rsynced &&
+	git init &&
+	git fetch rsync://127.0.0.1$(pwd)/../.git master:refs/heads/master &&
+	git gc --prune &&
+	test $(git rev-parse master) = $(cd .. && git rev-parse master) &&
+	git fsck --full
+'
+
+test_expect_success 'push via rsync' '
+	mkdir ../rsynced2 &&
+	(cd ../rsynced2 &&
+	 git init) &&
+	git push rsync://127.0.0.1$(pwd)/../rsynced2/.git master &&
+	cd ../rsynced2 &&
+	git gc --prune &&
+	test $(git rev-parse master) = $(cd .. && git rev-parse master) &&
+	git fsck --full
+'
+
+test_expect_success 'push via rsync' '
+	cd .. &&
+	mkdir rsynced3 &&
+	(cd rsynced3 &&
+	 git init) &&
+	git push --all rsync://127.0.0.1$(pwd)/rsynced3/.git &&
+	cd rsynced3 &&
+	test $(git rev-parse master) = $(cd .. && git rev-parse master) &&
+	git fsck --full
+'
+}
+
 test_done
diff --git a/transport.c b/transport.c
index 4f9cddc..d50a311 100644
--- a/transport.c
+++ b/transport.c
@@ -6,6 +6,334 @@
 #include "fetch-pack.h"
 #include "walker.h"
 #include "bundle.h"
+#include "dir.h"
+#include "refs.h"
+
+/* rsync support */
+
+/*
+ * We copy packed-refs and refs/ into a temporary file, then read the
+ * loose refs recursively (sorting whenever possible), and then inserting
+ * those packed refs that are not yet in the list (not validating, but
+ * assuming that the file is sorted).
+ *
+ * Appears refactoring this from refs.c is too cumbersome.
+ */
+
+static int direntry_cmp(const void *a, const void *b)
+{
+	const struct dirent *d1 = a;
+	const struct dirent *d2 = b;
+
+	return strcmp(d1->d_name, d2->d_name);
+}
+
+/*
+ * path is assumed to point to a buffer of PATH_MAX bytes, and
+ * path + name_offset is expected to point to "refs/".
+ */
+
+static int read_loose_refs(char *path, int name_offset, struct ref **tail)
+{
+	DIR *dir = opendir(path);
+	struct dirent *de;
+	struct {
+		struct dirent *entries;
+		int nr, alloc;
+	} list;
+	int i, pathlen;
+
+	if (!dir)
+		return -1;
+
+	memset (&list, 0, sizeof(list));
+
+	while ((de = readdir(dir))) {
+		if (de->d_name[0] == '.' && (de->d_name[1] == '\0' ||
+				(de->d_name[1] == '.' &&
+				 de->d_name[2] == '\0')))
+			continue;
+		if (list.nr >= list.alloc) {
+			list.alloc = alloc_nr(list.nr);
+			list.entries = xrealloc(list.entries,
+				list.alloc * sizeof(*de));
+		}
+		list.entries[list.nr++] = *de;
+	}
+	closedir(dir);
+
+	/* sort the list */
+
+	qsort(list.entries, list.nr, sizeof(*de), direntry_cmp);
+
+	pathlen = strlen(path);
+	path[pathlen] = '/';
+
+	for (i = 0; i < list.nr; i++) {
+		strlcpy(path + pathlen + 1, list.entries[i].d_name,
+				PATH_MAX - pathlen - 1);
+		if (read_loose_refs(path, name_offset, tail)) {
+			int fd = open(path, O_RDONLY);
+			char buffer[40];
+			struct ref *next;
+
+			if (fd < 0)
+				continue;
+			next = alloc_ref(strlen(path + name_offset));
+			if (read_in_full(fd, buffer, 40) != 40 ||
+					get_sha1_hex(buffer, next->old_sha1)) {
+				free(next);
+				continue;
+			}
+			close(fd);
+			strcpy(next->name, path + name_offset);
+			(*tail)->next = next;
+			*tail = next;
+		}
+	}
+
+	path[pathlen] = '\0';
+
+	free(list.entries);
+	return 0;
+}
+
+/* insert the packed refs for which no loose refs were found */
+
+static void insert_packed_refs(const char *packed_refs, struct ref **list)
+{
+	FILE *f = fopen(packed_refs, "r");
+	static char buffer[PATH_MAX];
+
+	if (!f)
+		return;
+
+	for (;;) {
+		int cmp, len;
+
+		if (!fgets(buffer, sizeof(buffer), f)) {
+			fclose(f);
+			return;
+		}
+
+		if (hexval(buffer[0]) & 0x10)
+			continue;
+		len = strlen(buffer);
+		if (buffer[len - 1] == '\n')
+			buffer[--len] = '\0';
+		if (len < 41)
+			continue;
+		while ((*list)->next &&
+				(cmp = strcmp(buffer + 41,
+				      (*list)->next->name)) > 0)
+			list = &(*list)->next;
+		if (!(*list)->next || cmp < 0) {
+			struct ref *next = alloc_ref(len - 40);
+			buffer[40] = '\0';
+			if (get_sha1_hex(buffer, next->old_sha1)) {
+				warning ("invalid SHA-1: %s", buffer);
+				free(next);
+				continue;
+			}
+			strcpy(next->name, buffer + 41);
+			next->next = (*list)->next;
+			(*list)->next = next;
+			list = &(*list)->next;
+		}
+	}
+}
+
+static struct ref *get_refs_via_rsync(const struct transport *transport)
+{
+	char buffer[PATH_MAX];
+	struct strbuf buf = STRBUF_INIT;
+	struct ref dummy, *result = &dummy;
+	struct child_process rsync;
+	const char *args[5];
+	char *temp_dir;
+
+	/* copy the refs to the temporary directory */
+
+	temp_dir = mkdtemp(git_path("rsync-refs-XXXXXX"));
+	if (temp_dir == NULL)
+		die ("Could not make temporary directory");
+	temp_dir = strcpy(buffer, temp_dir);
+
+	strbuf_addstr(&buf, transport->url);
+	strbuf_addstr(&buf, "/refs");
+
+	memset(&rsync, 0, sizeof(rsync));
+	rsync.argv = args;
+	rsync.stdout_to_stderr = 1;
+	args[0] = "rsync";
+	args[1] = transport->verbose ? "-rv" : "-r";
+	args[2] = buf.buf;
+	args[3] = temp_dir;
+	args[4] = NULL;
+
+	if (run_command(&rsync))
+		die ("Could not run rsync to get refs");
+
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, transport->url);
+	strbuf_addstr(&buf, "/packed-refs");
+
+	args[2] = buf.buf;
+
+	if (run_command(&rsync))
+		die ("Could not run rsync to get refs");
+
+	/* read the copied refs */
+
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, temp_dir);
+	strbuf_addstr(&buf, "/refs");
+	read_loose_refs(buf.buf, strlen(buf.buf) - 4, &result);
+
+	result = &dummy;
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, temp_dir);
+	strbuf_addstr(&buf, "/packed-refs");
+	insert_packed_refs(buf.buf, &result);
+
+	if (remove_dir_recursively(temp_dir, strlen(temp_dir), 0))
+		warning ("Could not remove temporary directory %s.", temp_dir);
+
+	return dummy.next;
+}
+
+static int fetch_objs_via_rsync(struct transport *transport,
+				 int nr_objs, struct ref **to_fetch)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct child_process rsync;
+	const char *args[8];
+
+	strbuf_addstr(&buf, transport->url);
+	strbuf_addstr(&buf, "/objects/");
+
+	memset(&rsync, 0, sizeof(rsync));
+	rsync.argv = args;
+	rsync.stdout_to_stderr = 1;
+	args[0] = "rsync";
+	args[1] = transport->verbose ? "-rv" : "-r";
+	args[2] = "--ignore-existing";
+	args[3] = "--exclude";
+	args[4] = "info";
+	args[5] = buf.buf;
+	args[6] = get_object_directory();
+	args[7] = NULL;
+
+	/* NEEDSWORK: handle one level of alternates */
+	return run_command(&rsync);
+}
+
+static int write_one_ref(const char *name, const unsigned char *sha1,
+		int flags, void *data)
+{
+	struct strbuf *buf = data;
+	int len = buf->len;
+	FILE *f;
+
+	if (flags && prefixcmp(name, "refs/heads/") &&
+			prefixcmp(name, "refs/tags/"))
+		return 0;
+
+	strbuf_addstr(buf, name);
+	if (safe_create_leading_directories(buf->buf) ||
+			!(f = fopen(buf->buf, "w")) ||
+			!fwrite(sha1_to_hex(sha1), 40, 1, f) ||
+			fputc('\n', f) == EOF ||
+			fclose(f))
+		return error("problems writing temporary file %s", buf->buf);
+	strbuf_setlen(buf, len);
+	return 0;
+}
+
+static int write_refs_to_temp_dir(struct strbuf *temp_dir,
+		int refspec_nr, const char **refspec)
+{
+	int i;
+
+	for (i = 0; i < refspec_nr; i++) {
+		unsigned char sha1[20];
+		char *ref;
+
+		if (dwim_ref(refspec[i], strlen(refspec[i]), sha1, &ref) != 1)
+			return error("Could not get ref %s", refspec[i]);
+
+		if (write_one_ref(ref, sha1, 0, temp_dir)) {
+			free(ref);
+			return -1;
+		}
+		free(ref);
+	}
+	return 0;
+}
+
+static int rsync_transport_push(struct transport *transport,
+		int refspec_nr, const char **refspec, int flags) {
+	char buffer[PATH_MAX];
+	struct strbuf buf = STRBUF_INIT;
+	int result = 0, i;
+	struct child_process rsync;
+	const char *args[8];
+	char *temp_dir;
+
+	/* first push the objects */
+
+	strbuf_addstr(&buf, transport->url);
+	strbuf_addch(&buf, '/');
+
+	memset(&rsync, 0, sizeof(rsync));
+	rsync.argv = args;
+	rsync.stdout_to_stderr = 1;
+	args[0] = "rsync";
+	args[1] = transport->verbose ? "-av" : "-a";
+	args[2] = "--ignore-existing";
+	args[3] = "--exclude";
+	args[4] = "info";
+	args[5] = get_object_directory();;
+	args[6] = buf.buf;
+	args[7] = NULL;
+
+	if (run_command(&rsync))
+		return error("Could not push objects to %s", transport->url);
+
+	/* copy the refs to the temporary directory; they could be packed. */
+
+	temp_dir = mkdtemp(git_path("rsync-refs-XXXXXX"));
+	if (temp_dir == NULL)
+		die ("Could not make temporary directory");
+	temp_dir = strcpy(buffer, temp_dir);
+
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, temp_dir);
+	strbuf_addch(&buf, '/');
+
+	if (flags & TRANSPORT_PUSH_ALL) {
+		if (for_each_ref(write_one_ref, &buf))
+			return -1;
+	} else if (write_refs_to_temp_dir(&buf, refspec_nr, refspec))
+		return -1;
+
+	i = (flags & TRANSPORT_PUSH_FORCE) ? 2 : 3;
+	args[i++] = buf.buf;
+	args[i++] = transport->url;
+	args[i++] = NULL;
+	if (run_command(&rsync))
+		result = error("Could not push to %s", transport->url);
+
+	if (remove_dir_recursively(temp_dir, strlen(temp_dir), 0))
+		warning ("Could not remove temporary directory %s.", temp_dir);
+
+	return result;
+}
+
+static int disconnect_rsync(struct transport *transport)
+{
+	return 0;
+}
 
 /* Generic functions for using commit walkers */
 
@@ -402,7 +730,10 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	ret->url = url;
 
 	if (!prefixcmp(url, "rsync://")) {
-		/* not supported; don't populate any ops */
+		ret->get_refs_list = get_refs_via_rsync;
+		ret->fetch = fetch_objs_via_rsync;
+		ret->push = rsync_transport_push;
+		ret->disconnect = disconnect_rsync;
 
 	} else if (!prefixcmp(url, "http://")
 	        || !prefixcmp(url, "https://")
-- 
1.5.3.2.1102.g9487
