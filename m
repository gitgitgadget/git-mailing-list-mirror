From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/5] Always obtain fetch-pack arguments from struct fetch_pack_args
Date: Wed, 19 Sep 2007 00:49:35 -0400
Message-ID: <20070919044935.GC17107@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 06:50:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXrVf-00072u-TZ
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 06:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbXISEtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 00:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbXISEtk
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 00:49:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38744 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbXISEtj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 00:49:39 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IXrVH-0006xD-0D; Wed, 19 Sep 2007 00:49:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F071420FBAE; Wed, 19 Sep 2007 00:49:35 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58679>

Copying the arguments from a fetch_pack_args into static globals
within the builtin-fetch-pack module is error-prone and may lead
rise to cases where arguments supplied via the struct from the
new fetch_pack() API may not be honored by the implementation.

Here we reorganize all of the static globals into a single static
struct fetch_pack_args instance and use memcpy() to move the data
from the caller supplied structure into the globals before we
execute our pack fetching implementation.  This strategy is more
robust to additions and deletions of properties.

As keep_pack is a single bit we have also introduced lock_pack to
mean not only download and store the packfile via index-pack but
also to lock it against repacking by creating a .keep file when
the packfile itself is stored.  The caller must remove the .keep
file when it is safe to do so.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fetch-pack.c |  111 +++++++++++++++++++++-----------------------------
 fetch-pack.h         |    9 +++-
 transport.c          |    9 +---
 3 files changed, 55 insertions(+), 74 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 2977a94..77eb181 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -8,15 +8,11 @@
 #include "sideband.h"
 #include "fetch-pack.h"
 
-static int keep_pack;
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
 static int unpack_limit = 100;
-static int quiet;
-static int verbose;
-static int fetch_all;
-static int depth;
-static int no_progress;
+static struct fetch_pack_args args;
+
 static const char fetch_pack_usage[] =
 "git-fetch-pack [--all] [--quiet|-q] [--keep|-k] [--thin] [--upload-pack=<git-upload-pack>] [--depth=<n>] [--no-progress] [-v] [<host>:]<directory> [<refs>...]";
 static const char *uploadpack = "git-upload-pack";
@@ -181,7 +177,7 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 				     (use_sideband == 2 ? " side-band-64k" : ""),
 				     (use_sideband == 1 ? " side-band" : ""),
 				     (use_thin_pack ? " thin-pack" : ""),
-				     (no_progress ? " no-progress" : ""),
+				     (args.no_progress ? " no-progress" : ""),
 				     " ofs-delta");
 		else
 			packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
@@ -189,13 +185,13 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 	}
 	if (is_repository_shallow())
 		write_shallow_commits(fd[1], 1);
-	if (depth > 0)
-		packet_write(fd[1], "deepen %d", depth);
+	if (args.depth > 0)
+		packet_write(fd[1], "deepen %d", args.depth);
 	packet_flush(fd[1]);
 	if (!fetching)
 		return 1;
 
-	if (depth > 0) {
+	if (args.depth > 0) {
 		char line[1024];
 		unsigned char sha1[20];
 		int len;
@@ -226,7 +222,7 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 	retval = -1;
 	while ((sha1 = get_rev())) {
 		packet_write(fd[1], "have %s\n", sha1_to_hex(sha1));
-		if (verbose)
+		if (args.verbose)
 			fprintf(stderr, "have %s\n", sha1_to_hex(sha1));
 		in_vain++;
 		if (!(31 & ++count)) {
@@ -244,7 +240,7 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 
 			do {
 				ack = get_ack(fd[0], result_sha1);
-				if (verbose && ack)
+				if (args.verbose && ack)
 					fprintf(stderr, "got ack %d %s\n", ack,
 							sha1_to_hex(result_sha1));
 				if (ack == 1) {
@@ -263,7 +259,7 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 			} while (ack);
 			flushes--;
 			if (got_continue && MAX_IN_VAIN < in_vain) {
-				if (verbose)
+				if (args.verbose)
 					fprintf(stderr, "giving up\n");
 				break; /* give up */
 			}
@@ -271,7 +267,7 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 	}
 done:
 	packet_write(fd[1], "done\n");
-	if (verbose)
+	if (args.verbose)
 		fprintf(stderr, "done\n");
 	if (retval != 0) {
 		multi_ack = 0;
@@ -280,7 +276,7 @@ done:
 	while (flushes || multi_ack) {
 		int ack = get_ack(fd[0], result_sha1);
 		if (ack) {
-			if (verbose)
+			if (args.verbose)
 				fprintf(stderr, "got ack (%d) %s\n", ack,
 					sha1_to_hex(result_sha1));
 			if (ack == 1)
@@ -317,7 +313,7 @@ static int mark_complete(const char *path, const unsigned char *sha1, int flag,
 static void mark_recent_complete_commits(unsigned long cutoff)
 {
 	while (complete && cutoff <= complete->item->date) {
-		if (verbose)
+		if (args.verbose)
 			fprintf(stderr, "Marking %s as complete\n",
 				sha1_to_hex(complete->item->object.sha1));
 		pop_most_recent_commit(&complete, COMPLETE);
@@ -332,7 +328,7 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
 	struct ref *ref, *next;
 	struct ref *fastarray[32];
 
-	if (nr_match && !fetch_all) {
+	if (nr_match && !args.fetch_all) {
 		if (ARRAY_SIZE(fastarray) < nr_match)
 			return_refs = xcalloc(nr_match, sizeof(struct ref *));
 		else {
@@ -348,8 +344,8 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
 		if (!memcmp(ref->name, "refs/", 5) &&
 		    check_ref_format(ref->name + 5))
 			; /* trash */
-		else if (fetch_all &&
-			 (!depth || prefixcmp(ref->name, "refs/tags/") )) {
+		else if (args.fetch_all &&
+			 (!args.depth || prefixcmp(ref->name, "refs/tags/") )) {
 			*newtail = ref;
 			ref->next = NULL;
 			newtail = &ref->next;
@@ -365,7 +361,7 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
 		free(ref);
 	}
 
-	if (!fetch_all) {
+	if (!args.fetch_all) {
 		int i;
 		for (i = 0; i < nr_match; i++) {
 			ref = return_refs[i];
@@ -408,7 +404,7 @@ static int everything_local(struct ref **refs, int nr_match, char **match)
 		}
 	}
 
-	if (!depth) {
+	if (!args.depth) {
 		for_each_ref(mark_complete, NULL);
 		if (cutoff)
 			mark_recent_complete_commits(cutoff);
@@ -442,7 +438,7 @@ static int everything_local(struct ref **refs, int nr_match, char **match)
 		o = lookup_object(remote);
 		if (!o || !(o->flags & COMPLETE)) {
 			retval = 0;
-			if (!verbose)
+			if (!args.verbose)
 				continue;
 			fprintf(stderr,
 				"want %s (%s)\n", sha1_to_hex(remote),
@@ -451,7 +447,7 @@ static int everything_local(struct ref **refs, int nr_match, char **match)
 		}
 
 		hashcpy(ref->new_sha1, local);
-		if (!verbose)
+		if (!args.verbose)
 			continue;
 		fprintf(stderr,
 			"already have %s (%s)\n", sha1_to_hex(remote),
@@ -502,14 +498,14 @@ static int get_pack(int xd[2], char **pack_lockfile)
 	char keep_arg[256];
 	char hdr_arg[256];
 	const char **av;
-	int do_keep = keep_pack;
+	int do_keep = args.keep_pack;
 	int keep_pipe[2];
 
 	side_pid = setup_sideband(fd, xd);
 
 	av = argv;
 	*hdr_arg = 0;
-	if (unpack_limit) {
+	if (!args.keep_pack && unpack_limit) {
 		struct pack_header header;
 
 		if (read_pack_header(fd[0], &header))
@@ -527,11 +523,11 @@ static int get_pack(int xd[2], char **pack_lockfile)
 			die("fetch-pack: pipe setup failure: %s", strerror(errno));
 		*av++ = "index-pack";
 		*av++ = "--stdin";
-		if (!quiet && !no_progress)
+		if (!args.quiet && !args.no_progress)
 			*av++ = "-v";
-		if (use_thin_pack)
+		if (args.use_thin_pack)
 			*av++ = "--fix-thin";
-		if (keep_pack > 1 || unpack_limit) {
+		if (args.lock_pack || unpack_limit) {
 			int s = sprintf(keep_arg,
 					"--keep=fetch-pack %d on ", getpid());
 			if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
@@ -541,7 +537,7 @@ static int get_pack(int xd[2], char **pack_lockfile)
 	}
 	else {
 		*av++ = "unpack-objects";
-		if (quiet)
+		if (args.quiet)
 			*av++ = "-q";
 	}
 	if (*hdr_arg)
@@ -599,17 +595,17 @@ static struct ref *do_fetch_pack(int fd[2],
 	if (is_repository_shallow() && !server_supports("shallow"))
 		die("Server does not support shallow clients");
 	if (server_supports("multi_ack")) {
-		if (verbose)
+		if (args.verbose)
 			fprintf(stderr, "Server supports multi_ack\n");
 		multi_ack = 1;
 	}
 	if (server_supports("side-band-64k")) {
-		if (verbose)
+		if (args.verbose)
 			fprintf(stderr, "Server supports side-band-64k\n");
 		use_sideband = 2;
 	}
 	else if (server_supports("side-band")) {
-		if (verbose)
+		if (args.verbose)
 			fprintf(stderr, "Server supports side-band\n");
 		use_sideband = 1;
 	}
@@ -622,7 +618,7 @@ static struct ref *do_fetch_pack(int fd[2],
 		goto all_done;
 	}
 	if (find_common(fd, sha1, ref) < 0)
-		if (keep_pack != 1)
+		if (!args.keep_pack)
 			/* When cloning, it is not unusual to have
 			 * no common commit.
 			 */
@@ -674,22 +670,6 @@ static int fetch_pack_config(const char *var, const char *value)
 
 static struct lock_file lock;
 
-void setup_fetch_pack(struct fetch_pack_args *args)
-{
-	uploadpack = args->uploadpack;
-	quiet = args->quiet;
-	keep_pack = args->keep_pack;
-	if (args->unpacklimit >= 0)
-		unpack_limit = args->unpacklimit;
-	if (args->keep_pack)
-		unpack_limit = 0;
-	use_thin_pack = args->use_thin_pack;
-	fetch_all = args->fetch_all;
-	verbose = args->verbose;
-	depth = args->depth;
-	no_progress = args->no_progress;
-}
-
 int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, ret, nr_heads;
@@ -710,40 +690,40 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 
 		if (*arg == '-') {
 			if (!prefixcmp(arg, "--upload-pack=")) {
-				uploadpack = arg + 14;
+				args.uploadpack = arg + 14;
 				continue;
 			}
 			if (!prefixcmp(arg, "--exec=")) {
-				uploadpack = arg + 7;
+				args.uploadpack = arg + 7;
 				continue;
 			}
 			if (!strcmp("--quiet", arg) || !strcmp("-q", arg)) {
-				quiet = 1;
+				args.quiet = 1;
 				continue;
 			}
 			if (!strcmp("--keep", arg) || !strcmp("-k", arg)) {
-				keep_pack++;
-				unpack_limit = 0;
+				args.lock_pack = args.keep_pack;
+				args.keep_pack = 1;
 				continue;
 			}
 			if (!strcmp("--thin", arg)) {
-				use_thin_pack = 1;
+				args.use_thin_pack = 1;
 				continue;
 			}
 			if (!strcmp("--all", arg)) {
-				fetch_all = 1;
+				args.fetch_all = 1;
 				continue;
 			}
 			if (!strcmp("-v", arg)) {
-				verbose = 1;
+				args.verbose = 1;
 				continue;
 			}
 			if (!prefixcmp(arg, "--depth=")) {
-				depth = strtol(arg + 8, NULL, 0);
+				args.depth = strtol(arg + 8, NULL, 0);
 				continue;
 			}
 			if (!strcmp("--no-progress", arg)) {
-				no_progress = 1;
+				args.no_progress = 1;
 				continue;
 			}
 			usage(fetch_pack_usage);
@@ -756,8 +736,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	if (!dest)
 		usage(fetch_pack_usage);
 
-	ref = fetch_pack(dest, nr_heads, heads, NULL);
-
+	ref = fetch_pack(&args, dest, nr_heads, heads, NULL);
 	ret = !ref;
 
 	while (ref) {
@@ -769,7 +748,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-struct ref *fetch_pack(const char *dest,
+struct ref *fetch_pack(struct fetch_pack_args *my_args,
+		const char *dest,
 		int nr_heads,
 		char **heads,
 		char **pack_lockfile)
@@ -780,13 +760,14 @@ struct ref *fetch_pack(const char *dest,
 	struct ref *ref;
 	struct stat st;
 
-	if (depth > 0) {
+	memcpy(&args, my_args, sizeof(args));
+	if (args.depth > 0) {
 		if (stat(git_path("shallow"), &st))
 			st.st_mtime = 0;
 	}
 
 	pid = git_connect(fd, (char *)dest, uploadpack,
-                          verbose ? CONNECT_VERBOSE : 0);
+                          args.verbose ? CONNECT_VERBOSE : 0);
 	if (pid < 0)
 		return NULL;
 	if (heads && nr_heads)
@@ -809,7 +790,7 @@ struct ref *fetch_pack(const char *dest,
 			}
 	}
 
-	if (!ret && depth > 0) {
+	if (!ret && args.depth > 0) {
 		struct cache_time mtime;
 		char *shallow = git_path("shallow");
 		int fd;
diff --git a/fetch-pack.h b/fetch-pack.h
index ad13076..a7888ea 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -8,14 +8,17 @@ struct fetch_pack_args
 	int depth;
 	unsigned quiet:1,
 		keep_pack:1,
+		lock_pack:1,
 		use_thin_pack:1,
 		fetch_all:1,
 		verbose:1,
 		no_progress:1;
 };
 
-void setup_fetch_pack(struct fetch_pack_args *args);
-
-struct ref *fetch_pack(const char *dest, int nr_heads, char **heads, char **pack_lockfile);
+struct ref *fetch_pack(struct fetch_pack_args *args,
+		const char *dest,
+		int nr_heads,
+		char **heads,
+		char **pack_lockfile);
 
 #endif
diff --git a/transport.c b/transport.c
index d8458dc..85f5b1e 100644
--- a/transport.c
+++ b/transport.c
@@ -314,21 +314,18 @@ static int fetch_refs_via_pack(struct transport *transport,
 	struct fetch_pack_args args;
 	int i;
 
+	memset(&args, 0, sizeof(args));
 	args.uploadpack = data->uploadpack;
-	args.quiet = 0;
 	args.keep_pack = data->keep;
+	args.lock_pack = 1;
 	args.unpacklimit = data->unpacklimit;
 	args.use_thin_pack = data->thin;
-	args.fetch_all = 0;
 	args.verbose = transport->verbose;
 	args.depth = data->depth;
-	args.no_progress = 0;
-
-	setup_fetch_pack(&args);
 
 	for (i = 0; i < nr_heads; i++)
 		origh[i] = heads[i] = xstrdup(to_fetch[i]->name);
-	refs = fetch_pack(dest, nr_heads, heads, &transport->pack_lockfile);
+	refs = fetch_pack(&args, dest, nr_heads, heads, &transport->pack_lockfile);
 
 	for (i = 0; i < nr_heads; i++)
 		free(origh[i]);
-- 
1.5.3.1.195.gadd6
