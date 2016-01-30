From: Jeff King <peff@peff.net>
Subject: [PATCH] transport: drop support for git-over-rsync
Date: Sat, 30 Jan 2016 02:21:26 -0500
Message-ID: <20160130072126.GA14696@sigill.intra.peff.net>
References: <20160130051133.GA21973@dcvr.yhbt.net>
 <20160130054141.GB1677@sigill.intra.peff.net>
 <20160130063036.GC1677@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jan 30 08:22:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPPrG-0006a8-Ab
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 08:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbcA3HVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 02:21:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:34768 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751179AbcA3HV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 02:21:29 -0500
Received: (qmail 20333 invoked by uid 102); 30 Jan 2016 07:21:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 30 Jan 2016 02:21:29 -0500
Received: (qmail 7085 invoked by uid 107); 30 Jan 2016 07:21:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 30 Jan 2016 02:21:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Jan 2016 02:21:26 -0500
Content-Disposition: inline
In-Reply-To: <20160130063036.GC1677@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285103>

On Sat, Jan 30, 2016 at 01:30:36AM -0500, Jeff King wrote:

> I guess that doesn't handle subsequent fetches. But
> really...git-over-rsync is just an awful protocol. Nobody should be
> using it. Having looked at it in more detail, I'm more in favor than
> ever of removing it.

So here it is. I think this hasn't happened before simply because nobody
bothered. I tried to dig up relevant discussions; see below.

Also, it's Friday night and I'm reading (and enjoying!) 10-year-old
discussions on the git mailing list. That's got to be worth some kind of
nerd cred.

-- >8 --
Subject: transport: drop support for git-over-rsync

The git-over-rsync protocol is inefficient and broken, and
has been for a long time. It transfers way more objects than
it needs (grabbing all of the remote's "objects/",
regardless of which objects we need). It does its own ad-hoc
parsing of loose and packed refs from the remote, but
doesn't properly override packed refs with loose ones,
leading to garbage results (e.g., expecting the other side
to have an object pointed to by a stale packed-refs entry,
or complaining that the other side has two copies of the
refs[1]).

This latter breakage means that nobody could have
successfully pulled from a moderately active repository
since cd547b4 (fetch/push: readd rsync support, 2007-10-01).

We never made an official deprecation notice in the release
notes for git's rsync protocol, but the tutorial has marked
it as such since 914328a (Update tutorial., 2005-08-30).
And on the mailing list as far back as Oct 2005, we can find
Junio mentioning it as having "been deprecated for quite
some time."[2,3,4]. So it was old news then; cogito had
deprecated the transport in July of 2005[5] (though it did
come back briefly when Linus broke git-http-pull!).

Of course some people professed their love of rsync through
2006, but Linus clarified in his usual gentle manner[6]:

  > Thanks!  This is why I still use rsync, even though
  > everybody and their mother tells me "Linus says rsync is
  > deprecated."

  No. You're using rsync because you're actively doing
  something _wrong_.

The deprecation sentiment was reinforced in 2008, with a
mention that cloning via rsync is broken (with no fix)[7].

Even the commit porting rsync over to C from shell (cd547b4)
lists it as deprecated! So between the 10 years of informal
warnings, and the fact that it has been severely broken
since 2007, it's probably safe to simply remove it without
further deprecation warnings.

[1] http://article.gmane.org/gmane.comp.version-control.git/285101
[2] http://article.gmane.org/gmane.comp.version-control.git/10093
[3] http://article.gmane.org/gmane.comp.version-control.git/17734
[4] http://article.gmane.org/gmane.comp.version-control.git/18911
[5] http://article.gmane.org/gmane.comp.version-control.git/5617
[6] http://article.gmane.org/gmane.comp.version-control.git/19354
[7] http://article.gmane.org/gmane.comp.version-control.git/103635

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt           |   2 +-
 Documentation/git-bundle.txt       |   2 +-
 Documentation/git-clone.txt        |   3 +-
 Documentation/git-repack.txt       |   2 +-
 Documentation/git.txt              |   2 -
 Documentation/gitcore-tutorial.txt |  18 +-
 Documentation/gittutorial.txt      |   2 +-
 Documentation/urls.txt             |   6 +-
 t/t5510-fetch.sh                   |  36 ----
 transport.c                        | 332 +------------------------------------
 10 files changed, 10 insertions(+), 395 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 877cbc8..65fe684 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2088,7 +2088,7 @@ pack.indexVersion::
 	larger than 2 GB.
 +
 If you have an old Git that does not understand the version 2 `*.idx` file,
-cloning or fetching over a non native protocol (e.g. "http" and "rsync")
+cloning or fetching over a non native protocol (e.g. "http")
 that will copy both `*.pack` file and corresponding `*.idx` file from the
 other side may give you a repository that cannot be accessed with your
 older version of Git. If the `*.pack` file is smaller than 2 GB, however,
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 0417562..3a8120c 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -20,7 +20,7 @@ DESCRIPTION
 Some workflows require that one or more branches of development on one
 machine be replicated on another machine, but the two machines cannot
 be directly connected, and therefore the interactive Git protocols (git,
-ssh, rsync, http) cannot be used.  This command provides support for
+ssh, http) cannot be used.  This command provides support for
 'git fetch' and 'git pull' to operate by packaging objects and references
 in an archive at the originating machine, then importing those into
 another repository using 'git fetch' and 'git pull'
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 789b668..b7c467a 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -115,8 +115,7 @@ objects from the source repository into a pack in the cloned repository.
 --quiet::
 -q::
 	Operate quietly.  Progress is not reported to the standard
-	error stream. This flag is also passed to the `rsync'
-	command when given.
+	error stream.
 
 --verbose::
 -v::
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 0e0bd36..af230d0 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -133,7 +133,7 @@ By default, the command passes `--delta-base-offset` option to
 'git pack-objects'; this typically results in slightly smaller packs,
 but the generated packs are incompatible with versions of Git older than
 version 1.4.4. If you need to share your repository with such ancient Git
-versions, either directly or via the dumb http or rsync protocol, then you
+versions, either directly or via the dumb http protocol, then you
 need to set the configuration variable `repack.UseDeltaBaseOffset` to
 "false" and repack. Access from old Git versions over the native protocol
 is unaffected by this option as the conversion is performed on the fly
diff --git a/Documentation/git.txt b/Documentation/git.txt
index bff6302..6524f4a 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1123,8 +1123,6 @@ of clones and fetches.
 	  - `ssh`: git over ssh (including `host:path` syntax,
 	    `git+ssh://`, etc).
 
-	  - `rsync`: git over rsync
-
 	  - `http`: git over http, both "smart http" and "dumb http".
 	    Note that this does _not_ include `https`; if you want both,
 	    you should specify both as `http:https`.
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 36e9ab3..15b3bfa 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -710,7 +710,7 @@ files).
 Again, this can all be simplified with
 
 ----------------
-$ git clone rsync://rsync.kernel.org/pub/scm/git/git.git/ my-git
+$ git clone git://git.kernel.org/pub/scm/git/git.git/ my-git
 $ cd my-git
 $ git checkout
 ----------------
@@ -1011,20 +1011,6 @@ $ git fetch <remote-repository>
 One of the following transports can be used to name the
 repository to download from:
 
-Rsync::
-	`rsync://remote.machine/path/to/repo.git/`
-+
-Rsync transport is usable for both uploading and downloading,
-but is completely unaware of what git does, and can produce
-unexpected results when you download from the public repository
-while the repository owner is uploading into it via `rsync`
-transport.  Most notably, it could update the files under
-`refs/` which holds the object name of the topmost commits
-before uploading the files in `objects/` -- the downloader would
-obtain head commit object name while that object itself is still
-not available in the repository.  For this reason, it is
-considered deprecated.
-
 SSH::
 	`remote.machine:/path/to/repo.git/` or
 +
@@ -1430,7 +1416,7 @@ while, depending on how active your project is.
 
 When a repository is synchronized via `git push` and `git pull`
 objects packed in the source repository are usually stored
-unpacked in the destination, unless rsync transport is used.
+unpacked in the destination.
 While this allows you to use different packing strategies on
 both ends, it also means you may need to repack both
 repositories every once in a while.
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index b00c67d..b3b58d3 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -451,7 +451,7 @@ perform clones and pulls using the ssh protocol:
 bob$ git clone alice.org:/home/alice/project myrepo
 -------------------------------------
 
-Alternatively, Git has a native protocol, or can use rsync or http;
+Alternatively, Git has a native protocol, or can use http;
 see linkgit:git-pull[1] for details.
 
 Git can also be used in a CVS-like mode, with a central repository
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 9ccb246..b05da95 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -7,9 +7,8 @@ Depending on the transport protocol, some of this information may be
 absent.
 
 Git supports ssh, git, http, and https protocols (in addition, ftp,
-and ftps can be used for fetching and rsync can be used for fetching
-and pushing, but these are inefficient and deprecated; do not use
-them).
+and ftps can be used for fetching, but this is inefficient and
+deprecated; do not use it).
 
 The native transport (i.e. git:// URL) does no authentication and
 should be used with caution on unsecured networks.
@@ -20,7 +19,6 @@ The following syntaxes may be used with them:
 - git://host.xz{startsb}:port{endsb}/path/to/repo.git/
 - http{startsb}s{endsb}://host.xz{startsb}:port{endsb}/path/to/repo.git/
 - ftp{startsb}s{endsb}://host.xz{startsb}:port{endsb}/path/to/repo.git/
-- rsync://host.xz/path/to/repo.git/
 
 An alternative scp-like syntax may also be used with the ssh protocol:
 
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 9203a65..0c10c85 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -314,42 +314,6 @@ test_expect_success 'bundle should be able to create a full history' '
 
 '
 
-! rsync --help > /dev/null 2> /dev/null &&
-say 'Skipping rsync tests because rsync was not found' || {
-test_expect_success 'fetch via rsync' '
-	git pack-refs &&
-	mkdir rsynced &&
-	(cd rsynced &&
-	 git init --bare &&
-	 git fetch "rsync:../.git" master:refs/heads/master &&
-	 git gc --prune &&
-	 test $(git rev-parse master) = $(cd .. && git rev-parse master) &&
-	 git fsck --full)
-'
-
-test_expect_success 'push via rsync' '
-	mkdir rsynced2 &&
-	(cd rsynced2 &&
-	 git init) &&
-	(cd rsynced &&
-	 git push "rsync:../rsynced2/.git" master) &&
-	(cd rsynced2 &&
-	 git gc --prune &&
-	 test $(git rev-parse master) = $(cd .. && git rev-parse master) &&
-	 git fsck --full)
-'
-
-test_expect_success 'push via rsync' '
-	mkdir rsynced3 &&
-	(cd rsynced3 &&
-	 git init) &&
-	git push --all "rsync:rsynced3/.git" &&
-	(cd rsynced3 &&
-	 test $(git rev-parse master) = $(cd .. && git rev-parse master) &&
-	 git fsck --full)
-'
-}
-
 test_expect_success 'fetch with a non-applying branch.<name>.merge' '
 	git config branch.master.remote yeti &&
 	git config branch.master.merge refs/heads/bigfoot &&
diff --git a/transport.c b/transport.c
index 67f3666..9da4e89 100644
--- a/transport.c
+++ b/transport.c
@@ -17,133 +17,6 @@
 #include "sha1-array.h"
 #include "sigchain.h"
 
-/* rsync support */
-
-/*
- * We copy packed-refs and refs/ into a temporary file, then read the
- * loose refs recursively (sorting whenever possible), and then inserting
- * those packed refs that are not yet in the list (not validating, but
- * assuming that the file is sorted).
- *
- * Appears refactoring this from refs.c is too cumbersome.
- */
-
-static int str_cmp(const void *a, const void *b)
-{
-	const char *s1 = a;
-	const char *s2 = b;
-
-	return strcmp(s1, s2);
-}
-
-/* path->buf + name_offset is expected to point to "refs/" */
-
-static int read_loose_refs(struct strbuf *path, int name_offset,
-		struct ref **tail)
-{
-	DIR *dir = opendir(path->buf);
-	struct dirent *de;
-	struct {
-		char **entries;
-		int nr, alloc;
-	} list;
-	int i, pathlen;
-
-	if (!dir)
-		return -1;
-
-	memset (&list, 0, sizeof(list));
-
-	while ((de = readdir(dir))) {
-		if (is_dot_or_dotdot(de->d_name))
-			continue;
-		ALLOC_GROW(list.entries, list.nr + 1, list.alloc);
-		list.entries[list.nr++] = xstrdup(de->d_name);
-	}
-	closedir(dir);
-
-	/* sort the list */
-
-	qsort(list.entries, list.nr, sizeof(char *), str_cmp);
-
-	pathlen = path->len;
-	strbuf_addch(path, '/');
-
-	for (i = 0; i < list.nr; i++, strbuf_setlen(path, pathlen + 1)) {
-		strbuf_addstr(path, list.entries[i]);
-		if (read_loose_refs(path, name_offset, tail)) {
-			int fd = open(path->buf, O_RDONLY);
-			char buffer[40];
-			struct ref *next;
-
-			if (fd < 0)
-				continue;
-			next = alloc_ref(path->buf + name_offset);
-			if (read_in_full(fd, buffer, 40) != 40 ||
-					get_oid_hex(buffer, &next->old_oid)) {
-				close(fd);
-				free(next);
-				continue;
-			}
-			close(fd);
-			(*tail)->next = next;
-			*tail = next;
-		}
-	}
-	strbuf_setlen(path, pathlen);
-
-	for (i = 0; i < list.nr; i++)
-		free(list.entries[i]);
-	free(list.entries);
-
-	return 0;
-}
-
-/* insert the packed refs for which no loose refs were found */
-
-static void insert_packed_refs(const char *packed_refs, struct ref **list)
-{
-	FILE *f = fopen(packed_refs, "r");
-	static char buffer[PATH_MAX];
-
-	if (!f)
-		return;
-
-	for (;;) {
-		int cmp = 0; /* assigned before used */
-		int len;
-
-		if (!fgets(buffer, sizeof(buffer), f)) {
-			fclose(f);
-			return;
-		}
-
-		if (!isxdigit(buffer[0]))
-			continue;
-		len = strlen(buffer);
-		if (len && buffer[len - 1] == '\n')
-			buffer[--len] = '\0';
-		if (len < 41)
-			continue;
-		while ((*list)->next &&
-				(cmp = strcmp(buffer + 41,
-				      (*list)->next->name)) > 0)
-			list = &(*list)->next;
-		if (!(*list)->next || cmp < 0) {
-			struct ref *next = alloc_ref(buffer + 41);
-			buffer[40] = '\0';
-			if (get_oid_hex(buffer, &next->old_oid)) {
-				warning ("invalid SHA-1: %s", buffer);
-				free(next);
-				continue;
-			}
-			next->next = (*list)->next;
-			(*list)->next = next;
-			list = &(*list)->next;
-		}
-	}
-}
-
 static void set_upstreams(struct transport *transport, struct ref *refs,
 	int pretend)
 {
@@ -192,205 +65,6 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 	}
 }
 
-static const char *rsync_url(const char *url)
-{
-	if (!starts_with(url, "rsync://"))
-		skip_prefix(url, "rsync:", &url);
-	return url;
-}
-
-static struct ref *get_refs_via_rsync(struct transport *transport, int for_push)
-{
-	struct strbuf buf = STRBUF_INIT, temp_dir = STRBUF_INIT;
-	struct ref dummy = {NULL}, *tail = &dummy;
-	struct child_process rsync = CHILD_PROCESS_INIT;
-	const char *args[5];
-	int temp_dir_len;
-
-	if (for_push)
-		return NULL;
-
-	/* copy the refs to the temporary directory */
-
-	strbuf_addstr(&temp_dir, git_path("rsync-refs-XXXXXX"));
-	if (!mkdtemp(temp_dir.buf))
-		die_errno ("Could not make temporary directory");
-	temp_dir_len = temp_dir.len;
-
-	strbuf_addstr(&buf, rsync_url(transport->url));
-	strbuf_addstr(&buf, "/refs");
-
-	rsync.argv = args;
-	rsync.stdout_to_stderr = 1;
-	args[0] = "rsync";
-	args[1] = (transport->verbose > 1) ? "-rv" : "-r";
-	args[2] = buf.buf;
-	args[3] = temp_dir.buf;
-	args[4] = NULL;
-
-	if (run_command(&rsync))
-		die ("Could not run rsync to get refs");
-
-	strbuf_reset(&buf);
-	strbuf_addstr(&buf, rsync_url(transport->url));
-	strbuf_addstr(&buf, "/packed-refs");
-
-	args[2] = buf.buf;
-
-	if (run_command(&rsync))
-		die ("Could not run rsync to get refs");
-
-	/* read the copied refs */
-
-	strbuf_addstr(&temp_dir, "/refs");
-	read_loose_refs(&temp_dir, temp_dir_len + 1, &tail);
-	strbuf_setlen(&temp_dir, temp_dir_len);
-
-	tail = &dummy;
-	strbuf_addstr(&temp_dir, "/packed-refs");
-	insert_packed_refs(temp_dir.buf, &tail);
-	strbuf_setlen(&temp_dir, temp_dir_len);
-
-	if (remove_dir_recursively(&temp_dir, 0))
-		warning ("Error removing temporary directory %s.",
-				temp_dir.buf);
-
-	strbuf_release(&buf);
-	strbuf_release(&temp_dir);
-
-	return dummy.next;
-}
-
-static int fetch_objs_via_rsync(struct transport *transport,
-				int nr_objs, struct ref **to_fetch)
-{
-	struct child_process rsync = CHILD_PROCESS_INIT;
-
-	rsync.stdout_to_stderr = 1;
-	argv_array_push(&rsync.args, "rsync");
-	argv_array_push(&rsync.args, (transport->verbose > 1) ? "-rv" : "-r");
-	argv_array_push(&rsync.args, "--ignore-existing");
-	argv_array_push(&rsync.args, "--exclude");
-	argv_array_push(&rsync.args, "info");
-	argv_array_pushf(&rsync.args, "%s/objects/", rsync_url(transport->url));
-	argv_array_push(&rsync.args, get_object_directory());
-
-	/* NEEDSWORK: handle one level of alternates */
-	return run_command(&rsync);
-}
-
-static int write_one_ref(const char *name, const struct object_id *oid,
-			 int flags, void *data)
-{
-	struct strbuf *buf = data;
-	int len = buf->len;
-
-	/* when called via for_each_ref(), flags is non-zero */
-	if (flags && !starts_with(name, "refs/heads/") &&
-			!starts_with(name, "refs/tags/"))
-		return 0;
-
-	strbuf_addstr(buf, name);
-	if (safe_create_leading_directories(buf->buf) ||
-	    write_file_gently(buf->buf, "%s", oid_to_hex(oid)))
-		return error("problems writing temporary file %s: %s",
-			     buf->buf, strerror(errno));
-	strbuf_setlen(buf, len);
-	return 0;
-}
-
-static int write_refs_to_temp_dir(struct strbuf *temp_dir,
-				  int refspec_nr, const char **refspec)
-{
-	int i;
-
-	for (i = 0; i < refspec_nr; i++) {
-		struct object_id oid;
-		char *ref;
-
-		if (dwim_ref(refspec[i], strlen(refspec[i]), oid.hash, &ref) != 1)
-			return error("Could not get ref %s", refspec[i]);
-
-		if (write_one_ref(ref, &oid, 0, temp_dir)) {
-			free(ref);
-			return -1;
-		}
-		free(ref);
-	}
-	return 0;
-}
-
-static int rsync_transport_push(struct transport *transport,
-		int refspec_nr, const char **refspec, int flags)
-{
-	struct strbuf buf = STRBUF_INIT, temp_dir = STRBUF_INIT;
-	int result = 0, i;
-	struct child_process rsync = CHILD_PROCESS_INIT;
-	const char *args[10];
-
-	if (flags & TRANSPORT_PUSH_MIRROR)
-		return error("rsync transport does not support mirror mode");
-
-	/* first push the objects */
-
-	strbuf_addstr(&buf, rsync_url(transport->url));
-	strbuf_addch(&buf, '/');
-
-	rsync.argv = args;
-	rsync.stdout_to_stderr = 1;
-	i = 0;
-	args[i++] = "rsync";
-	args[i++] = "-a";
-	if (flags & TRANSPORT_PUSH_DRY_RUN)
-		args[i++] = "--dry-run";
-	if (transport->verbose > 1)
-		args[i++] = "-v";
-	args[i++] = "--ignore-existing";
-	args[i++] = "--exclude";
-	args[i++] = "info";
-	args[i++] = get_object_directory();
-	args[i++] = buf.buf;
-	args[i++] = NULL;
-
-	if (run_command(&rsync))
-		return error("Could not push objects to %s",
-				rsync_url(transport->url));
-
-	/* copy the refs to the temporary directory; they could be packed. */
-
-	strbuf_addstr(&temp_dir, git_path("rsync-refs-XXXXXX"));
-	if (!mkdtemp(temp_dir.buf))
-		die_errno ("Could not make temporary directory");
-	strbuf_addch(&temp_dir, '/');
-
-	if (flags & TRANSPORT_PUSH_ALL) {
-		if (for_each_ref(write_one_ref, &temp_dir))
-			return -1;
-	} else if (write_refs_to_temp_dir(&temp_dir, refspec_nr, refspec))
-		return -1;
-
-	i = 2;
-	if (flags & TRANSPORT_PUSH_DRY_RUN)
-		args[i++] = "--dry-run";
-	if (!(flags & TRANSPORT_PUSH_FORCE))
-		args[i++] = "--ignore-existing";
-	args[i++] = temp_dir.buf;
-	args[i++] = rsync_url(transport->url);
-	args[i++] = NULL;
-	if (run_command(&rsync))
-		result = error("Could not push to %s",
-				rsync_url(transport->url));
-
-	if (remove_dir_recursively(&temp_dir, 0))
-		warning ("Could not remove temporary directory %s.",
-				temp_dir.buf);
-
-	strbuf_release(&buf);
-	strbuf_release(&temp_dir);
-
-	return result;
-}
-
 struct bundle_transport_data {
 	int fd;
 	struct bundle_header header;
@@ -984,11 +658,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	if (helper) {
 		transport_helper_init(ret, helper);
 	} else if (starts_with(url, "rsync:")) {
-		transport_check_allowed("rsync");
-		ret->get_refs_list = get_refs_via_rsync;
-		ret->fetch = fetch_objs_via_rsync;
-		ret->push = rsync_transport_push;
-		ret->smart_options = NULL;
+		die("git-over-rsync is no longer supported");
 	} else if (url_is_local_not_ssh(url) && is_file(url) && is_bundle(url, 1)) {
 		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
 		transport_check_allowed("file");
-- 
2.7.0.485.g87653c0
