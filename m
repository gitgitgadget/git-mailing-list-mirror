From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Pull efficiently from a dumb git store.
Date: Thu, 07 Jul 2005 16:16:47 -0700
Message-ID: <7vll4ifbq8.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050703234629.GF13848@pasky.ji.cz>
	<42CBC822.30701@didntduck.org> <20050707144501.GG19781@pasky.ji.cz>
	<7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071158220.3293@g5.osdl.org>
	<20050707221443.GB7151@pasky.ji.cz>
	<Pine.LNX.4.58.0507071549330.25104@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 01:17:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dqfc4-0003h9-Lk
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 01:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVGGXQ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 19:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVGGXQ4
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 19:16:56 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:45791 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261476AbVGGXQy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2005 19:16:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050707231649.ZACQ18672.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 7 Jul 2005 19:16:49 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org> (Linus Torvalds's message of "Thu, 7 Jul 2005 15:52:28 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The git-update-dumb-server-script command statically prepares
additional information to describe what the server side has, so
that a smart client can pull things efficiently even via a
transport such as static-file-only HTTP.

The files prepared by the command is $GIT_DIR/info/server, which
is a tar archive that contains the following files:

    rev-cache   -- commit ancestry chain, append only to help
	           rsync mirroring.
    inventory   -- list of refs and their SHA1.
    pack        -- list of available prepackaged packs.
    server.sha1 -- sha1sum output for the above three files (optional).

A smart client git-dumb-pull-script works in the following way:

 - First it slurps these files, and then .idx files that
   corresponds to the packs described in "pack".

 - Then it finds the commits that it wants from the server by
   looking at "inventory" to find various heads, and "rev-cache" to
   find commits that is missing from the client, and "pack" to
   figure out downloading which packs is the most efficient way to
   fill what is missing from its repository.  This is done with
   the help of the git-dumb-pull-resolve command.

 - Then it slurps the pack files.

 - The git-http-pull / git-local-pull command walks the commit
   chain in an old-fashioned way and downloads unpacked objects
   to fill the rest.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Makefile                      |   10 +
 dumb-pull-resolve.c           |  239 +++++++++++++++++++++++++++++++++
 git-dumb-pull-script          |  129 ++++++++++++++++++
 git-update-dumb-server-script |   47 ++++++
 rev-cache.c                   |  300 +++++++++++++++++++++++++++++++++++++++++
 rev-cache.h                   |   31 ++++
 show-rev-cache.c              |   18 ++
 update-dumb-server.c          |  153 +++++++++++++++++++++
 8 files changed, 925 insertions(+), 2 deletions(-)
 create mode 100644 dumb-pull-resolve.c
 create mode 100755 git-dumb-pull-script
 create mode 100755 git-update-dumb-server-script
 create mode 100644 rev-cache.c
 create mode 100644 rev-cache.h
 create mode 100644 show-rev-cache.c
 create mode 100644 update-dumb-server.c

a880bc7300f070aca3a255828b48390cb9793245
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -31,7 +31,8 @@ SCRIPTS=git git-apply-patch-script git-m
 	git-fetch-script git-status-script git-commit-script \
 	git-log-script git-shortlog git-cvsimport-script git-diff-script \
 	git-reset-script git-add-script git-checkout-script git-clone-script \
-	gitk git-cherry git-rebase-script git-relink-script git-repack-script
+	gitk git-cherry git-rebase-script git-relink-script git-repack-script \
+	git-dumb-pull-script git-update-dumb-server-script
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
@@ -44,7 +45,8 @@ PROG=   git-update-cache git-diff-files 
 	git-diff-stages git-rev-parse git-patch-id git-pack-objects \
 	git-unpack-objects git-verify-pack git-receive-pack git-send-pack \
 	git-prune-packed git-fetch-pack git-upload-pack git-clone-pack \
-	git-show-index
+	git-show-index git-update-dumb-server git-show-rev-cache \
+	git-dumb-pull-resolve
 
 all: $(PROG)
 
@@ -58,6 +60,9 @@ LIB_FILE=libgit.a
 LIB_H=cache.h object.h blob.h tree.h commit.h tag.h delta.h epoch.h csum-file.h \
 	pack.h pkt-line.h refs.h
 
+LIB_H += rev-cache.h
+LIB_OBJS += rev-cache.o
+
 LIB_H += strbuf.h
 LIB_OBJS += strbuf.o
 
@@ -153,6 +158,7 @@ object.o: $(LIB_H)
 read-cache.o: $(LIB_H)
 sha1_file.o: $(LIB_H)
 usage.o: $(LIB_H)
+rev-cache.o: $(LIB_H)
 strbuf.o: $(LIB_H)
 gitenv.o: $(LIB_H)
 entry.o: $(LIB_H)
diff --git a/dumb-pull-resolve.c b/dumb-pull-resolve.c
new file mode 100644
--- /dev/null
+++ b/dumb-pull-resolve.c
@@ -0,0 +1,239 @@
+#include "cache.h"
+#include "rev-cache.h"
+
+static const char *dumb_pull_resolve_usage =
+"git-dumb_pull_resolve <tmpdir> (<remote> <local>)...";
+
+static struct inventory {
+	struct inventory *next;
+	unsigned char sha1[20];
+	char name[1]; /* more; 1 is for terminating NUL */
+} *inventory;
+
+static struct inventory *find_inventory(const char *name)
+{
+	struct inventory *e = inventory;
+	while (e && strcmp(e->name, name))
+		e = e->next;
+	return e;
+}
+
+static void read_inventory(const char *path)
+{
+	FILE *fp;
+	char buf[1024];
+
+	fp = fopen(path, "r");
+	if (!fp)
+		die("cannot open %s", path);
+	while (fgets(buf, sizeof(buf), fp)) {
+		struct inventory *e; 
+		int len = strlen(buf);
+		if (buf[len-1] != '\n')
+			die("malformed inventory file");
+		buf[--len] = 0;
+		e = xmalloc(sizeof(*e) + len - 41);
+		strcpy(e->name, buf + 41);
+		get_sha1_hex(buf, e->sha1);
+		e->next = inventory;
+		inventory = e;
+	}
+	fclose(fp);
+}
+
+#define MAX_PACKS 0
+static struct pack {
+	struct pack *next;
+	unsigned int *map;
+	unsigned long pack_size;
+	unsigned long index_size;
+	unsigned char ix;
+	unsigned long fill;
+	char name[1]; /* more; 1 is for terminating NUL */
+} *pack;
+
+static void map_pack_idx(const char *path, const char *tmpdir)
+{
+	FILE *fp;
+	char buf[1024];
+	int num_pack = 0;
+
+	fp = fopen(path, "r");
+	if (!fp)
+		die("cannot open %s", path);
+	while (fgets(buf, sizeof(buf), fp)) {
+		struct pack *e;
+		int len;
+		int fd;
+		struct stat st;
+		char path[PATH_MAX];
+		char *cp;
+
+		cp = strchr(buf, ' ');
+		if (!cp || !*++cp)
+			die("malformed pack file");
+
+		len = strlen(cp);
+		if (cp[len-1] != '\n')
+			die("malformed pack file");
+		cp[--len] = 0;
+		
+		if (MAX_PACKS && MAX_PACKS < num_pack) {
+			error("cannot handle too many packs.  ignoring %s",
+			      cp);
+			continue;
+		}
+
+		e = xmalloc(sizeof(*e) + len);
+		strcpy(e->name, cp);
+		e->pack_size = strtoul(buf, NULL, 10);
+
+		sprintf(path, "%s/%s", tmpdir, cp);
+		len = strlen(path);
+		strcpy(path + len - 5, ".idx");
+		fd = open(path, O_RDONLY);
+		if (fd < 0)
+			goto ignore_entry;
+		if (fstat(fd, &st)) {
+			close(fd);
+			goto ignore_entry;
+		}
+		e->index_size = st.st_size;
+		e->map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+		close(fd);
+		if (e->map == MAP_FAILED)
+			die("cannot map %s", path);
+		e->next = pack;
+		e->ix = num_pack++;
+		pack = e;
+		continue;
+	ignore_entry:
+		free(e);
+	}
+	fclose(fp);
+}
+
+static int find_in_pack_idx(const unsigned char *sha1, struct pack *e)
+{
+	unsigned int *level1_ofs = e->map;
+	int hi = ntohl(level1_ofs[*sha1]);
+	int lo = ((*sha1 == 0x0) ? 0 : ntohl(level1_ofs[*sha1 - 1]));
+	void *index = e->map + 256;
+
+	do {
+		int mi = (lo + hi) / 2;
+		int cmp = memcmp(index + 24 * mi + 4, sha1, 20);
+		if (!cmp)
+			return 1;
+		if (0 < cmp)
+			hi = mi;
+		else
+			lo = mi+1;
+	} while (lo < hi);
+	return 0;
+}
+
+static void mark_needed(const unsigned char *sha1)
+{
+	struct rev_cache *rc;
+	struct rev_list_elem *rle;
+	int pos;
+
+	if (has_sha1_file(sha1))
+		return;
+	pos = find_rev_cache(sha1);
+	if (pos < 0)
+		die("rev-cache does not match inventory");
+	rc = rev_cache[pos];
+	rc->work = 1;
+	for (rle = rc->parents; rle; rle= rle->next)
+		mark_needed(rle->ri->sha1);
+}
+
+static struct rev_cache *needed;
+static unsigned long num_needed;
+
+static void link_needed(void)
+{
+	/* Link needed ones for quick traversal */
+	int i;
+	num_needed = 0;
+	for (i = 0; i < nr_revs; i++) {
+		struct rev_cache *rc = rev_cache[i];
+		if (rc->work) {
+			rc->work_ptr = needed;
+			needed = rc;
+			num_needed++;
+		}
+	}
+}
+
+/* Currently this part is stupid, FIXME */
+static void find_optimum_packs(void)
+{
+	struct rev_cache *rc;
+	struct pack *e;
+	unsigned long hits, total;
+
+	hits = total = 0;
+	for (rc = needed; rc; rc = rc->work_ptr)
+		rc->work = 0;
+
+	for (e = pack; e; e = e->next) {
+		e->fill = 0;
+		for (rc = needed; rc; rc = rc->work_ptr)
+			if (!rc->work && find_in_pack_idx(rc->sha1, e)) {
+				rc->work = 1<<(e->ix);
+				e->fill++;
+				hits++;
+			}
+		if (e->fill) {
+			fprintf(stderr, "use %s to fill %lu\n",
+				e->name, e->fill);
+			total += e->pack_size;
+		}
+	}
+
+	fprintf(stderr, "# needed %lu, hits %lu, total %lu\n",
+		num_needed, hits, total);
+	for (e = pack; e; e = e->next)
+		if (e->fill)
+			printf("%s\n", e->name);
+}
+
+int main(int ac, char **av)
+{
+	int i;
+	char path[PATH_MAX];
+	const char *tmpdir;
+
+	if (ac < 4 || ac % 2)
+		usage(dumb_pull_resolve_usage);
+
+	tmpdir = av[1];
+	ac--; av++;
+
+	sprintf(path, "%s/inventory", tmpdir);
+	read_inventory(path);
+
+	sprintf(path, "%s/rev-cache", tmpdir);
+	read_rev_cache(path, NULL, 0);
+
+	for (i = 1; i < ac; i += 2) {
+		/* av[i] is a remote branch name */
+		struct inventory *e = find_inventory(av[i]);
+		if (!e) {
+			error("cannot find branch %s", av[i]);
+			continue;
+		}
+		mark_needed(e->sha1);
+	}
+
+	link_needed();
+
+	sprintf(path, "%s/pack", tmpdir);
+	map_pack_idx(path, tmpdir);
+
+	find_optimum_packs();
+	return 0;
+}
diff --git a/git-dumb-pull-script b/git-dumb-pull-script
new file mode 100755
--- /dev/null
+++ b/git-dumb-pull-script
@@ -0,0 +1,129 @@
+#!/bin/sh
+
+: ${GIT_DIR=.git}
+: ${GIT_OBJECT_DIRECTORY="${GIT_DIR}/objects"}
+
+usage () {
+	echo >&2 "* git dumb-pull <url> ( <remote-name> <local-name> ) ..."
+	exit 1
+}
+
+error () {
+	echo >&2 "* git-dumb-pull: $*"
+	exit 1
+}
+
+download_one() {
+	# $1 - URL
+	# $2 - Local target
+	case "$1" in
+	file://* )
+		path=/$(expr "$1" : 'file:/*\(.*\)')
+		cp "$path" "$2" || rm -f "$2"
+		;;
+	http://* | https://* )
+		wget -O "$2" "$1" || rm -f "$2"
+		;;
+	esac
+}
+
+case "$#" in
+0)
+	usage;;
+esac
+url="$1"; shift
+
+case "$url" in
+http://* | https://*)
+	use_url="$url"
+	cmd='git-http-pull -a -v'
+	;;
+file://*)
+	use_url=/$(expr "$url" : 'file:/*\(.*\)')
+	cmd='git-local-pull -a -l -v'
+	;;
+*)
+	error "Unknown url scheme $url"
+	;;
+esac
+
+# The rest of arguments are remote and local names
+case $#,$(expr "$#" % 2) in
+0,* | 1,* | *,1)
+	error "Need one or more branch name pairs." ;;
+esac
+
+tmp=.git-dumb-pull-$$
+mkdir "$tmp" || error "cannot create temporary directory"
+trap "rm -fr $tmp" 0 1 2 3 15
+
+# Failing to download is not fatal.  It just means the server is
+# dumber than we thought ;-)
+if download_one "$url/info/server" $tmp/server
+then
+	infofiles='inventory pack rev-cache'
+	(
+	  cd $tmp &&
+	  tar xvf server $infofiles || exit 1
+	  if tar xf server server.sha1
+	  then
+		sha1sum -c server.sha1 || {
+		    # did we fail because we did not have sha1sum command?
+		    case "$?" in
+		    127)
+		        : ;; # the command did not exist.
+		    *)
+		        false ;;
+		    esac
+		}
+	  else
+	  	echo >&2 "* warning: server file lacks sha1 checksum"
+	  fi &&
+	  rm -f server.sha1
+	) || exit
+fi
+
+if test -f $tmp/pack
+then
+	while read pack_size pack
+	do
+		case "$pack" in
+		*/*)
+			echo >&2 "* malformed pack $pack"
+			continue
+			;;
+		esac
+
+		idx=$(expr "$pack" : '\(.*\)\.pack$').idx
+		# It is possible, even likely, that we already have that
+		# index file and associated pack file.
+		if test -f "${GIT_OBJECT_DIRECTORY}/pack/$pack" &&
+		   test -f "${GIT_OBJECT_DIRECTORY}/pack/$idx"
+		then
+			continue
+		fi
+		download_one "$url/objects/pack/$idx" "$tmp/$idx"
+	done <$tmp/pack
+
+	git-dumb-pull-resolve $tmp "$@" |
+	while read pack
+	do
+		echo >&2 "* $pack"
+		download_one "$url/objects/pack/$pack" "$tmp/$pack"
+		if test -f "$tmp/$pack" && git-verify-pack "$tmp/$pack"
+		then
+			idx=$(expr "$pack" : '\(.*\)\.pack$').idx
+			mv "$tmp/$pack" "$tmp/$idx" \
+				"${GIT_OBJECT_DIRECTORY}/pack/"
+		fi
+	done
+fi
+
+while case "$#" in 0) break ;; esac
+do
+	remote="$1" local="$2"
+	$cmd -w "$local" "$remote" "$use_url"
+
+	shift
+	shift
+done
diff --git a/git-update-dumb-server-script b/git-update-dumb-server-script
new file mode 100755
--- /dev/null
+++ b/git-update-dumb-server-script
@@ -0,0 +1,47 @@
+#!/bin/sh
+#
+# Copyright (c) 2005, Junio C Hamano
+#
+
+: ${GIT_DIR=.git}
+: ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
+export GIT_DIR GIT_OBJECT_DIRECTORY
+
+infofiles='inventory pack rev-cache'
+
+usage () {
+	echo >&2 "* git update-dumb-server"
+	exit 1
+}
+
+# Allow 10MB plain SHA1 files to be accumulated before we repack.
+max_plain_size=10240
+
+plain_size=$(
+{
+	du -sk "$GIT_OBJECT_DIRECTORY/" "$GIT_OBJECT_DIRECTORY/pack/" |
+	sed -e 's/^[ 	]*\([0-9][0-9]*\)[ 	].*/\1/'
+	echo ' - p'
+} | dc) &&
+
+if test $max_plain_size -lt $plain_size >/dev/null
+then
+	git-repack-script && git-prune-packed
+fi &&
+
+git-update-dumb-server &&
+
+files=$infofiles
+cd "$GIT_DIR/info" &&
+if sha1sum $infofiles >server.sha1
+then
+	files="$files server.sha1"
+else
+	rm -f server.sha1
+	echo >&2 "* warning: creating server file without sha1sum"
+fi &&
+tar cf server $files &&
+
+# We leave rev-cache there for later runs.
+rm -f server.sha1 inventory pack
+
diff --git a/rev-cache.c b/rev-cache.c
new file mode 100644
--- /dev/null
+++ b/rev-cache.c
@@ -0,0 +1,300 @@
+#include "refs.h"
+#include "cache.h"
+#include "rev-cache.h"
+
+struct rev_cache **rev_cache;
+int nr_revs, alloc_revs;
+
+struct rev_list_elem *rle_free;
+
+#define BATCH_SIZE 512
+
+int find_rev_cache(const unsigned char *sha1)
+{
+	int lo = 0, hi = nr_revs;
+	while (lo < hi) {
+		int mi = (lo + hi) / 2;
+		struct rev_cache *ri = rev_cache[mi];
+		int cmp = memcmp(sha1, ri->sha1, 20);
+		if (!cmp)
+			return mi;
+		if (cmp < 0)
+			hi = mi;
+		else
+			lo = mi + 1;
+	}
+	return -lo - 1;
+}
+
+static struct rev_list_elem *alloc_list_elem(void)
+{
+	struct rev_list_elem *rle;
+	if (!rle_free) {
+		int i;
+
+		rle = xmalloc(sizeof(*rle) * BATCH_SIZE);
+		for (i = 0; i < BATCH_SIZE - 1; i++) {
+			rle[i].ri = NULL;
+			rle[i].next = &rle[i + 1];
+		}
+		rle[BATCH_SIZE - 1].ri = NULL; 
+		rle[BATCH_SIZE - 1].next = NULL; 
+		rle_free = rle;
+	}
+	rle = rle_free;
+	rle_free = rle->next;
+	return rle;
+}
+
+static struct rev_cache *create_rev_cache(const unsigned char *sha1)
+{
+	struct rev_cache *ri;
+	int pos = find_rev_cache(sha1);
+
+	if (0 <= pos)
+		return rev_cache[pos];
+	pos = -pos - 1;
+	if (alloc_revs <= ++nr_revs) {
+		alloc_revs = alloc_nr(alloc_revs);
+		rev_cache = xrealloc(rev_cache, sizeof(ri) * alloc_revs);
+	}
+	if (pos < nr_revs)
+		memmove(rev_cache + pos + 1, rev_cache + pos,
+			(nr_revs - pos - 1) * sizeof(ri));
+	ri = xcalloc(1, sizeof(*ri));
+	memcpy(ri->sha1, sha1, 20);
+	rev_cache[pos] = ri;
+	return ri;
+}
+
+static unsigned char last_sha1[20];
+
+static void write_one_rev_cache(FILE *rev_cache_file, struct rev_cache *ri)
+{
+	unsigned char flag;
+	struct rev_list_elem *rle;
+
+	if (ri->written)
+		return;
+
+	if (ri->parsed) {
+
+		/* We use last_sha1 compression only for the first parent;
+		 * otherwise the resulting rev-cache would lose the parent
+		 * order information.
+		 */
+		if (ri->parents &&
+		    !memcmp(ri->parents->ri->sha1, last_sha1, 20))
+			flag = (ri->num_parents - 1) | 0x80;
+		else
+			flag = ri->num_parents;
+
+		fwrite(ri->sha1, 20, 1, rev_cache_file);
+		fwrite(&flag, 1, 1, rev_cache_file);
+		for (rle = ri->parents; rle; rle = rle->next) {
+			if (flag & 0x80 && rle == ri->parents)
+				continue;
+			fwrite(rle->ri->sha1, 20, 1, rev_cache_file);
+		}
+		memcpy(last_sha1, ri->sha1, 20);
+		ri->written = 1;
+	}
+	/* recursively write children depth first */
+	for (rle = ri->children; rle; rle = rle->next)
+		write_one_rev_cache(rev_cache_file, rle->ri);
+}
+
+void write_rev_cache(const char *path)
+{
+	/* write the following commit ancestry information in
+	 * $GIT_DIR/info/rev-cache.
+	 *
+	 * The format is:
+	 * 20-byte SHA1 (commit ID)
+	 * 1-byte flag:
+	 * - bit 0-6 records "number of parent commit SHA1s to
+	 *   follow" (i.e. up to 127 children can be listed).
+	 * - when the bit 7 is on, then "the entry immediately
+	 *   before this entry is one of the parents of this
+         *   commit".
+	 * N x 20-byte SHA1 (parent commit IDs)
+	 */
+	FILE *rev_cache_file;
+	int i;
+	struct rev_cache *ri;
+
+	rev_cache_file = fopen(path, "a");
+	if (!rev_cache_file)
+		die("cannot append to rev cache file.");
+
+	memset(last_sha1, 0, 20);
+
+	/* Go through available rev_cache structures, starting from
+	 * parentless ones first, so that we would get most out of
+	 * last_sha1 optimization by the depth first behaviour of
+	 * write_one_rev_cache().
+	 */
+	for (i = 0; i < nr_revs; i++) {
+		ri = rev_cache[i];
+		if (ri->num_parents)
+			continue;
+		write_one_rev_cache(rev_cache_file, ri);
+	}
+	/* Then the rest */
+	for (i = 0; i < nr_revs; i++) {
+		ri = rev_cache[i];
+		write_one_rev_cache(rev_cache_file, ri);
+	}
+
+	fclose(rev_cache_file);
+}
+
+static void add_parent(struct rev_cache *child,
+		       const unsigned char *parent_sha1)
+{
+	struct rev_cache *parent = create_rev_cache(parent_sha1);
+	struct rev_list_elem *e = alloc_list_elem();
+
+	/* Keep the parent list ordered in the same way the commit
+	 * object records them.
+	 */
+	e->ri = parent;
+	e->next = NULL;
+	if (!child->parents_tail)
+		child->parents = e;
+	else
+		child->parents_tail->next = e;
+	child->parents_tail = e;
+	child->num_parents++;
+	
+	/* There is no inherent order of the children so we just
+	 * LIFO them together.
+	 */
+	e = alloc_list_elem();
+	e->next = parent->children;
+	parent->children = e;
+	e->ri = child;
+	parent->num_children++;
+}
+
+int read_rev_cache(const char *path, FILE *dumpfile, int dry_run)
+{
+	unsigned char *map;
+	int fd;
+	struct stat st;
+	unsigned long ofs, len;
+	struct rev_cache *ri = NULL;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return 0;
+	if (fstat(fd, &st)) {
+		close(fd);
+		return -1;
+	}
+	map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (map == MAP_FAILED) {
+		close(fd);
+		return -1;
+	}
+	close(fd);
+
+	memset(last_sha1, 0, 20);
+	ofs = 0;
+	len = st.st_size;
+	while (ofs < len) {
+		unsigned char sha1[20];
+		int flag, cnt, i;
+		if (len < ofs + 21)
+			die("rev-cache too short"); 
+		memcpy(sha1, map + ofs, 20);
+		flag = map[ofs + 20];
+		ofs += 21;
+		cnt = (flag & 0x7f) + ((flag & 0x80) != 0);
+		if (len < ofs + (flag & 0x7f) * 20)
+			die("rev-cache too short to have %d more parents",
+			    (flag & 0x7f));
+		if (dumpfile)
+			fprintf(dumpfile, "%s", sha1_to_hex(sha1));
+		if (!dry_run) {
+			ri = create_rev_cache(sha1);
+			ri->written = 1;
+			ri->parsed = 1;
+			if (!ri)
+				die("cannot create rev-cache for %s",
+				    sha1_to_hex(sha1));
+		}
+		i = 0;
+		if (flag & 0x80) {
+			if (!dry_run)
+				add_parent(ri, last_sha1);
+			if (dumpfile)
+				fprintf(dumpfile, " %s",
+					sha1_to_hex(last_sha1));
+			i++;
+		}
+		while (i++ < cnt) {
+			if (!dry_run)
+				add_parent(ri, map + ofs);
+			if (dumpfile)
+				fprintf(dumpfile, " %s",
+					sha1_to_hex(last_sha1));
+			ofs += 20;
+		}
+		if (dumpfile)
+			fprintf(dumpfile, "\n");
+		memcpy(last_sha1, sha1, 20);
+	}
+	if (ofs != len)
+		die("rev-cache truncated?");
+	munmap(map, len);
+	return 0;
+}
+
+int record_rev_cache(const unsigned char *sha1)
+{
+	unsigned char parent[20];
+	char type[20];
+	unsigned long size, ofs;
+	unsigned int cnt, i;
+	void *buf;
+	struct rev_cache *ri;
+
+	buf = read_sha1_file(sha1, type, &size);
+	if (!buf)
+		return 1; /* unavailable */
+	if (strcmp(type, "commit")) {
+		/* could be a tag or tree */
+		free(buf);
+		return 1;
+	}
+	ri = create_rev_cache(sha1);
+	if (ri->parsed)
+		return 0;
+
+	cnt = 0;
+	ofs = 46; /* "tree " + hex-sha1 + "\n" */
+	while (!memcmp(buf + ofs, "parent ", 7) &&
+	       !get_sha1_hex(buf + ofs + 7, parent)) {
+		ofs += 48;
+		cnt++;
+	}
+	if (cnt * 48 + 46 != ofs) {
+		free(buf);
+		return error("internal error in record_rev_cache");
+	}
+
+	ri = create_rev_cache(sha1);
+	ri->parsed = 1;
+
+	for (i = 0; i < cnt; i++) {
+		unsigned char parent_sha1[20];
+		
+		ofs = 46 + i * 48 + 7;
+		get_sha1_hex(buf + ofs, parent_sha1);
+		add_parent(ri, parent_sha1);
+		record_rev_cache(parent_sha1);
+	}
+	free(buf);
+	return 0;
+}
diff --git a/rev-cache.h b/rev-cache.h
new file mode 100644
--- /dev/null
+++ b/rev-cache.h
@@ -0,0 +1,31 @@
+#ifndef REV_CACHE_H
+#define REV_CACHE_H
+
+#define REV_CACHE_PATH "info/rev-cache"
+
+extern struct rev_cache {
+	struct rev_cache *head_list;
+	struct rev_list_elem *children;
+	struct rev_list_elem *parents;
+	struct rev_list_elem *parents_tail;
+	unsigned short num_parents;
+	unsigned short num_children;
+	unsigned int written : 1;
+	unsigned int parsed : 1;
+	unsigned int work : 30;
+	void *work_ptr;
+	unsigned char sha1[20];
+} **rev_cache;
+extern int nr_revs, alloc_revs;
+
+struct rev_list_elem {
+	struct rev_list_elem *next;
+	struct rev_cache *ri;
+};
+
+extern int find_rev_cache(const unsigned char *);
+extern int read_rev_cache(const char *, FILE *, int);
+extern int record_rev_cache(const unsigned char *);
+extern void write_rev_cache(const char *);
+
+#endif
diff --git a/show-rev-cache.c b/show-rev-cache.c
new file mode 100644
--- /dev/null
+++ b/show-rev-cache.c
@@ -0,0 +1,18 @@
+#include "cache.h"
+#include "rev-cache.h"
+
+static char *dump_rev_cache_usage =
+"git-dump-rev-cache <rev-cache-file>";
+
+int main(int ac, char **av)
+{
+	while (1 < ac && av[0][1] == '-') {
+		/* do flags here */
+		break;
+		ac--; av++;
+	}
+	if (ac != 2)
+		usage(dump_rev_cache_usage);
+
+	return read_rev_cache(av[1], stdout, 1);
+}
diff --git a/update-dumb-server.c b/update-dumb-server.c
new file mode 100644
--- /dev/null
+++ b/update-dumb-server.c
@@ -0,0 +1,153 @@
+#include "refs.h"
+#include "cache.h"
+#include "rev-cache.h"
+
+static FILE *inventory_file;
+static int verbose = 0;
+
+static int do_refs(const char *path, const unsigned char *sha1)
+{
+	/* path is like .git/refs/heads/master */
+	int pfxlen = 10; /* strlen(".git/refs/") */
+	fprintf(inventory_file, "%s %s\n", sha1_to_hex(sha1), path + pfxlen);
+	if (verbose)
+		fprintf(stderr, "inventory %s %s\n",
+			sha1_to_hex(sha1), path + pfxlen);
+	record_rev_cache(sha1);
+	return 0;
+}
+
+static int inventory(void)
+{
+	/* write names of $GIT_DIR/refs/?*?/?* files in
+	 * $GIT_DIR/info/inventory, and find the ancestry
+	 * information.
+	 */
+	char path[PATH_MAX];
+
+	strcpy(path, git_path("info/inventory"));
+	safe_create_leading_directories(path);
+	inventory_file = fopen(path, "w");
+	if (!inventory_file)
+		die("cannot create inventory file.");
+	for_each_ref(do_refs);
+	fclose(inventory_file);
+	return 0;
+}
+
+static int compare_pack_size(const void *a_, const void *b_)
+{
+	struct packed_git *const*a = a_;
+	struct packed_git *const*b = b_;
+	if ((*a)->pack_size < (*b)->pack_size)
+		return 1;
+	else if ((*a)->pack_size == (*b)->pack_size)
+		return 0;
+	return -1;
+}
+
+static int write_packs(void)
+{
+	/* write names of pack files under $GIT_OBJECT_DIRECTORY/pack
+	 * into $GIT_DIR/info/packs.
+	 */
+	struct packed_git *p;
+	char path[PATH_MAX];
+	FILE *packs_file;
+	int pfxlen = strlen(".git/objects/pack/");
+	struct packed_git **list;
+	int cnt, i;
+
+	for (cnt = 0, p = packed_git; p; p = p->next)
+		cnt++;
+	list = xmalloc(sizeof(*list) * cnt);
+	for (i = 0, p = packed_git; p; p = p->next)
+		list[i++] = p;
+	qsort(list, cnt, sizeof(*list), compare_pack_size);
+
+	strcpy(path, git_path("info/pack"));
+	safe_create_leading_directories(path);
+	packs_file = fopen(path, "w");
+	if (!packs_file)
+		return -1;
+	for (i = 0; i < cnt; i++) {
+		p = list[i];
+		fprintf(packs_file, "%lu %s\n",
+			p->pack_size, p->pack_name + pfxlen);
+		if (verbose)
+			fprintf(stderr, "pack %lu %s\n",
+				p->pack_size,
+				p->pack_name + pfxlen);
+	}
+	free(list);
+	fclose(packs_file);
+	return 0;
+}
+
+static int inventory_packs(void)
+{
+	struct packed_git *p;
+
+	for (p = packed_git; p; p = p->next) {
+		int nth, lim;
+		lim = num_packed_objects(p);
+		for (nth = 0; nth < lim; nth++) {
+			unsigned char sha1[20];
+			char type[20];
+			if (nth_packed_object_sha1(p, nth, sha1)) {
+				error("cannot read %dth object from pack %s",
+				      nth, p->pack_name);
+				continue;
+			}
+			if (sha1_object_info(sha1, type, NULL)) {
+				error("cannot find type of %s", sha1_to_hex(sha1));
+				continue;
+			}
+			if (strcmp(type, "commit"))
+				continue;
+			record_rev_cache(sha1);
+		}
+	}
+	return 0;
+}
+
+static const char *update_dumb_server_usage =
+"git-update-dumb-server [-v] [-a]";
+
+int main(int ac, char **av)
+{
+	char path[PATH_MAX];
+	int all_commits = 0;
+
+	while (1 < ac && av[1][0] == '-') {
+		if (!strcmp(av[1], "-v"))
+			verbose = 1;
+		else if (!strcmp(av[1], "-a"))
+			all_commits = 1;
+		else
+			usage(update_dumb_server_usage);
+		ac--; av++;
+	}
+
+	/* read existing rev-cache if any */
+	strcpy(path, git_path(REV_CACHE_PATH));
+	read_rev_cache(path, verbose ? stderr : NULL, 0);
+
+	/* read refs directory and find commit ancentry information */
+	inventory();
+
+	/* 
+	 * prepare info/pack file.
+	 * Note that we do prepare_packed_git() in case we ran in
+	 * an headless repository.
+	 */
+	prepare_packed_git();
+	write_packs();
+
+	if (all_commits)
+		inventory_packs();
+
+	/* update the rev-cache database by appending newly found one to it */
+	write_rev_cache(path);
+	return 0;
+}
------------
