From: Jan Holesovsky <kendy@suse.cz>
Subject: [PATCH] RFC: git lazy clone proof-of-concept
Date: Fri, 8 Feb 2008 18:28:43 +0100
Message-ID: <200802081828.43849.kendy@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 08 18:29:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNX2n-0007bj-R4
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 18:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761455AbYBHR2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 12:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761438AbYBHR2u
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 12:28:50 -0500
Received: from styx.suse.cz ([82.119.242.94]:40378 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761393AbYBHR2r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 12:28:47 -0500
Received: from ben.suse.cz (ben.suse.cz [10.20.1.143])
	by mail.suse.cz (Postfix) with ESMTP id 704946280EF;
	Fri,  8 Feb 2008 18:28:44 +0100 (CET)
User-Agent: KMail/1.9.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73117>

Hi,

This is my attempt to implement the 'lazy clone' I've read about a bit in the
git mailing list archive, but did not see implemented anywhere - the clone
that fetches a minimal amount of data with the possibility to download the
rest later (transparently!) when necessary.  I am sorry to send it as a huge
patch, not as a series of patches, but as I don't know if I chose a way that is
acceptable for you [I'm new to the git code ;-)], I'd like to hear some
feedback first, and then I'll split it into smaller pieces for easier
integration - if OK.

Background:

Currently we are evaluating the usage of git for OpenOffice.org as one of the
candidates (SVN is the other one), see

  http://wiki.services.openoffice.org/wiki/SCM_Migration

I've provided a git import of OOo with the entire history; the problem is that
the pack has 2.5G, so it's not too convenient to download for casual
developers that just want to try it.  Shallow clone is not a possibility - we
don't get patches through mailing lists, so we need the pull/push, and also
thanks to the OOo development cycle, we have too many living heads which
causes the shallow clone to download about 1.5G even with --depth 1.  Lazy
clone sounded like the right idea to me.  With this proof-of-concept
implementation, just about 550M from the 2.5G is downloaded, which is still
about twice as much in comparison with downloading a tarball, but bearable.

The principle:

During the initial clone, just the commit objects are downloaded.  Then, any
time an object is requested, it is downloaded from the remote repository if
not available locally.  To make this usable and performing, when a tree is
requested, it is downloaded together with all the subtrees and blobs at which
it points.  Every subsequent pull (of stuff newer than what was cloned) is
supposed to use the normal git mechanisms.

Protocol extensions:

I've extended the git protocol in 2 ways:
- added the 'commits-only' flag that is used during the clone to get a pack
  containing just the commit objects, nothing else
- added the 'exact-objects' flag that allows to request just few objects
  exactly specified by the client

A bit more detailed description:

Here I use the term 'remote alternate' as the remote repository from which the
objects are downloaded when not locally available.

- fetch-pack.h
- builtin-fetch-pack.c
  Added --commits-only, --exact-objects, and --stdin options.
  --commits-only and --exact-objects trigger the protocol extensions described
  above, --stdin allows fetch-pack to get the list of refs or objects on stdin
  instead of the command line
- transport.h
- transport.c
- builtin-fetch.c
  Added --commits-only option that is passed to fetch-pack
- builtin-unpack-objects.c
- index-pack.c
  Added --ignore-remote-alternates option which will avoid fetching remote
  objects, to avoid a cycle in downloading the missing objects.
- cache.h
  Export the function that disables fetching remote objects.
- git-clone.sh
  Added handling of -s even in the case when the git:// protocol is used to
  activate the 'remote alternates' and thus get a lazy clone.  The info where
  to get the missing objects from is stored in the
  objects/info/remote_alternates file.
- sha1_file.c
  The core of the changes.  When an object is requested, usage of 'remote
  alternates' is on, and it is not present locally, it is downloaded.
- upload-pack.c
  Extended so that just the commit objects, or the exact objects are returned.

Limitations/FIXMEs/TODOs:

Currently there can be just one 'remote alternate' in the
objects/info/remote_alternates file.  I'm not sure if it makes sense at all to
provide the possibility to have more of them.

Some operations are too slow, like the annotate, and thus unusable [though not
disabled for the patient ones ;-)].

Not too much tested ;-), maybe I'm leaking memory somewhere, better error
handling in case the pack is not available should be introduced, maybe the
names of the variables/functions/commands is not the best chosen, etc.

Every fetch-pack gets list of refs from the server even for the exact-objects
case which is unnecessary - we know what objects we want, this just wastes
bandwidth.

The new options are not documented.


So - comments, ideas, questions appreciated, any help with polishing
this/getting this in is appreciated even more ;-)

Regards,
Jan

Signed-off-by: Jan Holesovsky <kendy@suse.cz>
---
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index e68e015..69b4226 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -17,7 +17,7 @@ static struct fetch_pack_args args = {
 };
 
 static const char fetch_pack_usage[] =
-"git-fetch-pack [--all] [--quiet|-q] [--keep|-k] [--thin] [--upload-pack=<git-upload-pack>] [--depth=<n>] [--no-progress] [-v] [<host>:]<directory> [<refs>...]";
+"git-fetch-pack [--all] [--quiet|-q] [--keep|-k] [--thin] [--upload-pack=<git-upload-pack>] [--depth=<n>] [--no-progress] [--commits-only] [--exact-objects] [-v] [--stdin] [<host>:]<directory> [<refs>...|<sha1>...]";
 
 #define COMPLETE	(1U << 0)
 #define COMMON		(1U << 1)
@@ -141,6 +141,34 @@ static const unsigned char* get_rev(void)
 	return commit->object.sha1;
 }
 
+static void send_want(int fd[2], const char *remote, int full_info)
+{
+	if (full_info)
+		packet_write(fd[1], "want %s%s%s%s%s%s%s%s%s\n",
+				remote,
+				(multi_ack ? " multi_ack" : ""),
+				(use_sideband == 2 ? " side-band-64k" : ""),
+				(use_sideband == 1 ? " side-band" : ""),
+				(args.use_thin_pack ? " thin-pack" : ""),
+				(args.no_progress ? " no-progress" : ""),
+				(args.commits_only ? " commits-only" : ""),
+				(args.exact_objects ? " exact-objects" : ""),
+				" ofs-delta");
+	else
+		packet_write(fd[1], "want %s\n", remote);
+}
+
+static void get_exact_objects(int fd[2], int nr_match, char **match)
+{
+	int i;
+
+	/* send all the objects as we got them on the command line */
+	for (i = 0; i < nr_match; i++)
+		send_want(fd, match[i], !i);
+
+	packet_flush(fd[1]);
+}
+
 static int find_common(int fd[2], unsigned char *result_sha1,
 		       struct ref *refs)
 {
@@ -172,17 +200,7 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 			continue;
 		}
 
-		if (!fetching)
-			packet_write(fd[1], "want %s%s%s%s%s%s%s\n",
-				     sha1_to_hex(remote),
-				     (multi_ack ? " multi_ack" : ""),
-				     (use_sideband == 2 ? " side-band-64k" : ""),
-				     (use_sideband == 1 ? " side-band" : ""),
-				     (args.use_thin_pack ? " thin-pack" : ""),
-				     (args.no_progress ? " no-progress" : ""),
-				     " ofs-delta");
-		else
-			packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
+		send_want(fd, sha1_to_hex(remote), !fetching);
 		fetching++;
 	}
 	if (is_repository_shallow())
@@ -523,11 +541,15 @@ static int get_pack(int xd[2], char **pack_lockfile)
 				strcpy(keep_arg + s, "localhost");
 			*av++ = keep_arg;
 		}
+		if (args.exact_objects)
+			*av++ = "--ignore-remote-alternates";
 	}
 	else {
 		*av++ = "unpack-objects";
 		if (args.quiet)
 			*av++ = "-q";
+		if (args.exact_objects)
+			*av++ = "--ignore-remote-alternates";
 	}
 	if (*hdr_arg)
 		*av++ = hdr_arg;
@@ -556,6 +578,7 @@ static struct ref *do_fetch_pack(int fd[2],
 	unsigned char sha1[20];
 
 	get_remote_heads(fd[0], &ref, 0, NULL, 0);
+
 	if (is_repository_shallow() && !server_supports("shallow"))
 		die("Server does not support shallow clients");
 	if (server_supports("multi_ack")) {
@@ -573,20 +596,36 @@ static struct ref *do_fetch_pack(int fd[2],
 			fprintf(stderr, "Server supports side-band\n");
 		use_sideband = 1;
 	}
-	if (!ref) {
-		packet_flush(fd[1]);
-		die("no matching remote head");
+	if (!server_supports("remote-alternates") &&
+			(args.commits_only || args.exact_objects)) {
+		if (args.verbose)
+			fprintf(stderr, "Server does not support remote "
+					"alternates, ignoring %s%s\n",
+					(args.commits_only?
+						"--commits-only ": ""),
+					(args.exact_objects? "--exact-objects": ""));
+		args.commits_only = 0;
+		args.exact_objects = 0;
 	}
-	if (everything_local(&ref, nr_match, match)) {
-		packet_flush(fd[1]);
-		goto all_done;
+
+	if (args.exact_objects)
+		get_exact_objects(fd, nr_match, match);
+	else {
+		if (!ref) {
+			packet_flush(fd[1]);
+			die("no matching remote head");
+		}
+		if (everything_local(&ref, nr_match, match)) {
+			packet_flush(fd[1]);
+			goto all_done;
+		}
+		if (find_common(fd, sha1, ref) < 0)
+			if (!args.keep_pack)
+				/* When cloning, it is not unusual to have
+				 * no common commit.
+				 */
+				fprintf(stderr, "warning: no common commits\n");
 	}
-	if (find_common(fd, sha1, ref) < 0)
-		if (!args.keep_pack)
-			/* When cloning, it is not unusual to have
-			 * no common commit.
-			 */
-			fprintf(stderr, "warning: no common commits\n");
 
 	if (get_pack(fd, pack_lockfile))
 		die("git-fetch-pack: fetch failed.");
@@ -647,12 +686,72 @@ static void fetch_pack_setup(void)
 	did_setup = 1;
 }
 
+static void read_from_stdin(int *num, char ***records)
+{
+	char buffer[4096];
+	size_t records_num, leftover;
+	ssize_t ret;
+
+	*num = 0;
+	leftover = 0;
+
+	records_num = 4096;
+	(*records) = xmalloc(records_num * sizeof(char *));
+
+	do {
+		char *p, *last;
+
+		ret = xread(0 /*stdin*/, buffer + leftover,
+				sizeof(buffer) - leftover);
+		if (ret < 0)
+			die("read error on input: %s", strerror(errno));
+
+		last = buffer;
+		for (p = buffer; p < buffer + leftover + ret; p++)
+			if ((!*p || *p == '\n') && (p != last)) {
+				if (*num >= records_num) {
+					records_num *= 2;
+					(*records) = xrealloc(*records,
+							      records_num * sizeof(char*));
+				}
+
+				if (p - last > 0) {
+					(*records)[*num] =
+						strndup(last, p - last);
+					(*num)++;
+				}
+				last = p + 1;
+			}
+
+		leftover = p - last;
+		if (leftover >= sizeof(buffer))
+			die("input line too long");
+		if (leftover < 0)
+			leftover = 0;
+
+		memmove(buffer, last, leftover);
+	} while (ret > 0);
+
+	if (leftover) {
+		if (*num >= records_num) {
+			records_num *= 2;
+			(*records) = xrealloc(*records,
+					      records_num * sizeof(char*));
+		}
+
+		(*records)[*num] = strndup(buffer, leftover);
+		(*num)++;
+	}
+}
+
 int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, ret, nr_heads;
 	struct ref *ref;
 	char *dest = NULL, **heads;
+	int from_stdin;
 
+	from_stdin = 0;
 	nr_heads = 0;
 	heads = NULL;
 	for (i = 1; i < argc; i++) {
@@ -696,6 +795,19 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 				args.no_progress = 1;
 				continue;
 			}
+			if (!strcmp("--commits-only", arg)) {
+				args.commits_only = 1;
+				continue;
+			}
+			if (!strcmp("--exact-objects", arg)) {
+				args.exact_objects = 1;
+				disable_remote_alternates();
+				continue;
+			}
+			if (!strcmp("--stdin", arg)) {
+				from_stdin = 1;
+				continue;
+			}
 			usage(fetch_pack_usage);
 		}
 		dest = (char *)arg;
@@ -706,14 +818,18 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	if (!dest)
 		usage(fetch_pack_usage);
 
+	if (from_stdin)
+		read_from_stdin(&nr_heads, &heads);
+
 	ref = fetch_pack(&args, dest, nr_heads, heads, NULL);
 	ret = !ref;
 
-	while (ref) {
-		printf("%s %s\n",
-		       sha1_to_hex(ref->old_sha1), ref->name);
-		ref = ref->next;
-	}
+	if (!args.exact_objects)
+		while (ref) {
+			printf("%s %s\n",
+					sha1_to_hex(ref->old_sha1), ref->name);
+			ref = ref->next;
+		}
 
 	return ret;
 }
@@ -746,7 +862,7 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 	close(fd[1]);
 	ret = finish_connect(conn);
 
-	if (!ret && nr_heads) {
+	if (!ret && nr_heads && !args.exact_objects) {
 		/* If the heads to pull were given, we should have
 		 * consumed all of them by matching the remote.
 		 * Otherwise, 'git-fetch remote no-such-ref' would
diff --git a/builtin-fetch.c b/builtin-fetch.c
index 320e235..858384a 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -22,7 +22,7 @@ enum {
 	TAGS_SET = 2
 };
 
-static int append, force, keep, update_head_ok, verbose, quiet;
+static int append, force, keep, update_head_ok, verbose, quiet, commits_only;
 static int tags = TAGS_DEFAULT;
 static const char *depth;
 static const char *upload_pack;
@@ -45,6 +45,8 @@ static struct option builtin_fetch_options[] = {
 		    "allow updating of HEAD ref"),
 	OPT_STRING(0, "depth", &depth, "DEPTH",
 		   "deepen history of shallow clone"),
+	OPT_BOOLEAN(0, "commits-only", &commits_only,
+		    "fetch just the commit objects, leave the tree, blob, and tag objects for later"),
 	OPT_END()
 };
 
@@ -602,6 +604,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		set_option(TRANS_OPT_KEEP, "yes");
 	if (depth)
 		set_option(TRANS_OPT_DEPTH, depth);
+	if (commits_only)
+		set_option(TRANS_OPT_COMMITS_ONLY, "yes");
 
 	if (!transport->url)
 		die("Where do you want to fetch from today?");
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 1e51865..58d8a41 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -10,7 +10,7 @@
 #include "progress.h"
 
 static int dry_run, quiet, recover, has_errors;
-static const char unpack_usage[] = "git-unpack-objects [-n] [-q] [-r] < pack-file";
+static const char unpack_usage[] = "git-unpack-objects [-n] [-q] [-r] [--ignore-remote-alternates] < pack-file";
 
 /* We always read in 4kB chunks. */
 static unsigned char buffer[4096];
@@ -359,6 +359,10 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 				recover = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--ignore-remote-alternates")) {
+				disable_remote_alternates();
+				continue;
+			}
 			if (!prefixcmp(arg, "--pack_header=")) {
 				struct pack_header *hdr;
 				char *c;
diff --git a/cache.h b/cache.h
index 549f4bb..def7459 100644
--- a/cache.h
+++ b/cache.h
@@ -480,6 +480,8 @@ extern struct alternate_object_database {
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
 
+extern void disable_remote_alternates(void);
+
 struct pack_window {
 	struct pack_window *next;
 	unsigned char *base;
diff --git a/fetch-pack.h b/fetch-pack.h
index a7888ea..0c3b13f 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -12,7 +12,9 @@ struct fetch_pack_args
 		use_thin_pack:1,
 		fetch_all:1,
 		verbose:1,
-		no_progress:1;
+		no_progress:1,
+		commits_only:1,
+		exact_objects:1;
 };
 
 struct ref *fetch_pack(struct fetch_pack_args *args,
diff --git a/git-clone.sh b/git-clone.sh
index b4e858c..208e9fc 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -115,7 +115,7 @@ Perhaps git-update-server-info needs to be run there?"
 quiet=
 local=no
 use_local_hardlink=yes
-local_shared=no
+shared=no
 unset template
 no_checkout=
 upload_pack=
@@ -143,7 +143,7 @@ do
 	--no-hardlinks)
 		use_local_hardlink=no ;;
 	-s|--shared)
-		local_shared=yes ;;
+		shared=yes ;;
 	--template)
 		shift; template="--template=$1" ;;
 	-q|--quiet)
@@ -288,7 +288,7 @@ yes)
 	( cd "$repo/objects" ) ||
 		die "cannot chdir to local '$repo/objects'."
 
-	if test "$local_shared" = yes
+	if test "$shared" = yes
 	then
 		mkdir -p "$GIT_DIR/objects/info"
 		echo "$repo/objects" >>"$GIT_DIR/objects/info/alternates"
@@ -364,11 +364,22 @@ yes)
 		fi
 		;;
 	*)
+		commits_only=
+		if test "$shared" = yes
+		then
+			commits_only="--commits-only"
+		fi
 		case "$upload_pack" in
-		'') git-fetch-pack --all -k $quiet $depth $no_progress "$repo";;
-		*) git-fetch-pack --all -k $quiet "$upload_pack" $depth $no_progress "$repo" ;;
+		'') git-fetch-pack --all -k $quiet $depth $no_progress $commits_only "$repo";;
+		*) git-fetch-pack --all -k $quiet "$upload_pack" $depth $no_progress $commits_only "$repo" ;;
 		esac >"$GIT_DIR/CLONE_HEAD" ||
 			die "fetch-pack from '$repo' failed."
+		if test "$shared" = yes
+		then
+			# Must be done after the fetch
+			mkdir -p "$GIT_DIR/objects/info"
+			echo "$repo" >> "$GIT_DIR/objects/info/remote_alternates"
+		fi
 		;;
 	esac
 	;;
diff --git a/index-pack.c b/index-pack.c
index 9fd6982..f2e6b7a 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -9,7 +9,7 @@
 #include "progress.h"
 
 static const char index_pack_usage[] =
-"git-index-pack [-v] [-o <index-file>] [{ ---keep | --keep=<msg> }] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
+"git-index-pack [-v] [-o <index-file>] [{ ---keep | --keep=<msg> }] [--ignore-remote-alternates] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
 
 struct object_entry
 {
@@ -746,6 +746,8 @@ int main(int argc, char **argv)
 					pack_idx_off32_limit = strtoul(c+1, &c, 0);
 				if (*c || pack_idx_off32_limit & 0x80000000)
 					die("bad %s", arg);
+			} else if (!strcmp(arg, "--ignore-remote-alternates")) {
+				disable_remote_alternates();
 			} else
 				usage(index_pack_usage);
 			continue;
diff --git a/sha1_file.c b/sha1_file.c
index 66a4e00..7d60be0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -14,6 +14,7 @@
 #include "tag.h"
 #include "tree.h"
 #include "refs.h"
+#include "run-command.h"
 
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
@@ -411,6 +412,205 @@ static char *find_sha1_file(const unsigned char *sha1, struct stat *st)
 	return NULL;
 }
 
+static char *remote_alternates = NULL;
+static int has_remote_alt_feature = -1;
+
+void disable_remote_alternates(void)
+{
+	has_remote_alt_feature = 0;
+}
+
+static int has_remote_alternates(void)
+{
+	/* FIXME: does it make sense to support more URLs inside
+	 * remote_alternates? */
+	struct stat st;
+	const char remote_alt_file_name[] = "info/remote_alternates";
+	char path[PATH_MAX + 1 + sizeof remote_alt_file_name];
+	int fd;
+	char *map, *p;
+	size_t mapsz;
+
+	if (has_remote_alt_feature != -1)
+		return has_remote_alt_feature;
+
+	has_remote_alt_feature = 0;
+
+	sprintf(path, "%s/%s", get_object_directory(),
+			remote_alt_file_name);
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return has_remote_alt_feature;
+	else if (fstat(fd, &st) || (st.st_size == 0)) {
+		close(fd);
+		return has_remote_alt_feature;
+	}
+
+	mapsz = xsize_t(st.st_size);
+	map = xmmap(NULL, mapsz, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+
+	/* we support just one remote alternate for now,
+	 * so read just the first entry */
+	for (p = map; (p < map + mapsz) && (*p != '\n'); p++)
+		;
+
+	remote_alternates = strndup(map, p - map);
+
+	munmap(map, mapsz);
+
+	if (remote_alternates && remote_alternates[0])
+		has_remote_alt_feature = 1;
+
+	return has_remote_alt_feature;
+}
+
+struct sha1_list {
+	unsigned char sha1[20];
+	struct sha1_list *next;
+};
+
+static int has_sha1_file_locally(const unsigned char *sha1);
+
+static int async_dump_objects(int fd, void *data)
+{
+	FILE *out = NULL;
+	struct sha1_list *list;
+
+	out = fdopen(fd, "w");
+
+	list = (struct sha1_list *)data;
+	while (list) {
+		if (!has_sha1_file_locally(list->sha1))
+			fprintf(out, "%s\n", sha1_to_hex(list->sha1));
+
+		list = list->next;
+	}
+
+	fflush(out);
+	return 0;
+}
+
+static int fetch_remote_sha1s(struct sha1_list *objects)
+{
+	struct async dump_objects;
+	struct child_process fetch_pack;
+	const char *argv[20];
+	int argc = 0;
+	int err;
+
+	if (!objects)
+		return 0;
+
+	/* this will fill the stdin of fetch-pack */
+	dump_objects.proc = async_dump_objects;
+	dump_objects.data = objects;
+
+	if (start_async(&dump_objects))
+		die("unable to send data to fetch-pack");
+
+	argv[argc++] = "fetch-pack";
+	argv[argc++] = "--stdin";
+	argv[argc++] = "--exact-objects";
+	argv[argc++] = remote_alternates;
+	argv[argc] = NULL;
+
+	memset(&fetch_pack, 0, sizeof(fetch_pack));
+	fetch_pack.in = dump_objects.out;
+	fetch_pack.out = 1;
+	fetch_pack.err = 2;
+	fetch_pack.git_cmd = 1;
+	fetch_pack.argv = argv;
+
+	err = run_command(&fetch_pack);
+
+	/* TODO better error handling - is the object really missing, or
+	 * was it just a temporary network error? */
+	if (err) {
+		fprintf(stderr, "error %d while calling fetch-pack\n", err);
+		return 0;
+	}
+
+	return 1;
+}
+
+static struct sha1_list *remote_list = NULL;
+
+static int fill_remote_list(const unsigned char *sha1,
+		const char *base, int baselen,
+		const char *pathname, unsigned mode, int stage)
+{
+	if (!has_sha1_file_locally(sha1)) {
+		struct sha1_list *item;
+
+		item = xmalloc(sizeof(*item));
+		hashcpy(item->sha1, sha1);
+		item->next = remote_list;
+
+		remote_list = item;
+	}
+
+	return 0;
+}
+
+static int fetch_remote_sha1s_recursive(struct sha1_list *objects)
+{
+	struct sha1_list *list;
+	int ret = 0;
+
+	/* first of all, fetch the missing objects */
+	if (!fetch_remote_sha1s(objects))
+		return 0;
+
+	remote_list = NULL;
+
+	list = objects;
+	while (list) {
+		struct tree *tree;
+
+		tree = parse_tree_indirect(list->sha1);
+		if (tree) {
+			read_tree_recursive(tree, "", 0, 0, NULL,
+					fill_remote_list);
+		}
+
+		list = list->next;
+	}
+
+	list = remote_list;
+	if (!list)
+		return 1; /* hooray, we have everything */
+
+	ret = fetch_remote_sha1s_recursive(list);
+
+	while (list) {
+		struct sha1_list *item;
+
+		item = list;
+		list = list->next;
+
+		free(item);
+	}
+
+	return ret;
+}
+
+static int download_remote_sha1(const unsigned char *sha1)
+{
+	struct sha1_list item;
+	int ret;
+
+	if (!has_remote_alternates())
+		return 0;
+
+	hashcpy(item.sha1, sha1);
+	item.next = NULL;
+
+	ret = fetch_remote_sha1s_recursive(&item);
+
+	return ret;
+}
+
 static unsigned int pack_used_ctr;
 static unsigned int pack_mmap_calls;
 static unsigned int peak_pack_open_windows;
@@ -1880,7 +2080,7 @@ int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
 	return 0;
 }
 
-void *read_sha1_file(const unsigned char *sha1, enum object_type *type,
+static void *read_sha1_file_locally(const unsigned char *sha1, enum object_type *type,
 		     unsigned long *size)
 {
 	unsigned long mapsize;
@@ -1897,6 +2097,7 @@ void *read_sha1_file(const unsigned char *sha1, enum object_type *type,
 	buf = read_packed_sha1(sha1, type, size);
 	if (buf)
 		return buf;
+
 	map = map_sha1_file(sha1, &mapsize);
 	if (map) {
 		buf = unpack_sha1_file(map, mapsize, type, size, sha1);
@@ -1907,6 +2108,21 @@ void *read_sha1_file(const unsigned char *sha1, enum object_type *type,
 	return read_packed_sha1(sha1, type, size);
 }
 
+void *read_sha1_file(const unsigned char *sha1, enum object_type *type,
+		     unsigned long *size)
+{
+	void *result;
+
+	result = read_sha1_file_locally(sha1, type, size);
+
+	/* if it's remote, and we don't have it yet, dowload it now and try
+	 * again */
+	if (!result && has_remote_alternates() && download_remote_sha1(sha1))
+		result = read_sha1_file_locally(sha1, type, size);
+
+	return result;
+}
+
 void *read_object_with_reference(const unsigned char *sha1,
 				 const char *required_type_name,
 				 unsigned long *size,
@@ -2306,7 +2522,7 @@ int has_sha1_pack(const unsigned char *sha1, const char **ignore_packed)
 	return find_pack_entry(sha1, &e, ignore_packed);
 }
 
-int has_sha1_file(const unsigned char *sha1)
+static int has_sha1_file_locally(const unsigned char *sha1)
 {
 	struct stat st;
 	struct pack_entry e;
@@ -2316,6 +2532,18 @@ int has_sha1_file(const unsigned char *sha1)
 	return find_sha1_file(sha1, &st) ? 1 : 0;
 }
 
+int has_sha1_file(const unsigned char *sha1)
+{
+	if (has_sha1_file_locally(sha1))
+		return 1;
+
+	/* download it if necessary */
+	if (has_remote_alternates() && download_remote_sha1(sha1))
+		return has_sha1_file_locally(sha1);
+
+	return 0;
+}
+
 int index_pipe(unsigned char *sha1, int fd, const char *type, int write_object)
 {
 	struct strbuf buf;
diff --git a/transport.c b/transport.c
index babaa21..918c390 100644
--- a/transport.c
+++ b/transport.c
@@ -562,6 +562,7 @@ static int close_bundle(struct transport *transport)
 struct git_transport_data {
 	unsigned thin : 1;
 	unsigned keep : 1;
+	unsigned commits_only : 1;
 	int depth;
 	const char *uploadpack;
 	const char *receivepack;
@@ -589,6 +590,9 @@ static int set_git_option(struct transport *connection,
 		else
 			data->depth = atoi(value);
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_COMMITS_ONLY)) {
+		data->commits_only = !!value;
+		return 0;
 	}
 	return 1;
 }
@@ -629,6 +633,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.use_thin_pack = data->thin;
 	args.verbose = transport->verbose > 0;
 	args.depth = data->depth;
+	args.commits_only = data->commits_only;
 
 	for (i = 0; i < nr_heads; i++)
 		origh[i] = heads[i] = xstrdup(to_fetch[i]->name);
diff --git a/transport.h b/transport.h
index 6fb4526..4076186 100644
--- a/transport.h
+++ b/transport.h
@@ -53,6 +53,10 @@ struct transport *transport_get(struct remote *, const char *);
 /* Limit the depth of the fetch if not null */
 #define TRANS_OPT_DEPTH "depth"
 
+/* Download only the commit objects, let the tree, blob and tag objects for
+ * later */
+#define TRANS_OPT_COMMITS_ONLY "commits-only"
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
diff --git a/upload-pack.c b/upload-pack.c
index 7e04311..2d047ec 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -27,7 +27,7 @@ static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=n
 static unsigned long oldest_have;
 
 static int multi_ack, nr_our_refs;
-static int use_thin_pack, use_ofs_delta, no_progress;
+static int use_thin_pack, use_ofs_delta, no_progress, commits_only, exact_objects;
 static struct object_array have_obj;
 static struct object_array want_obj;
 static unsigned int timeout;
@@ -106,9 +106,15 @@ static int do_rev_list(int fd, void *create_full_pack)
 	if (create_full_pack)
 		use_thin_pack = 0; /* no point doing it */
 	init_revisions(&revs, NULL);
-	revs.tag_objects = 1;
-	revs.tree_objects = 1;
-	revs.blob_objects = 1;
+	if (!commits_only) {
+		revs.tag_objects = 1;
+		revs.tree_objects = 1;
+		revs.blob_objects = 1;
+	} else {
+		revs.tag_objects = 0;
+		revs.tree_objects = 0;
+		revs.blob_objects = 0;
+	}
 	if (use_thin_pack)
 		revs.edge_hint = 1;
 
@@ -135,6 +141,20 @@ static int do_rev_list(int fd, void *create_full_pack)
 	return 0;
 }
 
+static int dump_want_objects(int fd, void *data)
+{
+	int i;
+	pack_pipe = fdopen(fd, "w");
+
+	for (i = 0; i < want_obj.nr; i++) {
+		struct object *o = want_obj.objects[i].item;
+		fprintf(pack_pipe, "%s\n", sha1_to_hex(o->sha1));
+	}
+
+	fflush(pack_pipe);
+	return 0;
+}
+
 static void create_pack_file(void)
 {
 	struct async rev_list;
@@ -148,7 +168,10 @@ static void create_pack_file(void)
 	const char *argv[10];
 	int arg = 0;
 
-	rev_list.proc = do_rev_list;
+	if (!exact_objects)
+		rev_list.proc = do_rev_list;
+	else
+		rev_list.proc = dump_want_objects;
 	/* .data is just a boolean: any non-NULL value will do */
 	rev_list.data = create_full_pack ? &rev_list : NULL;
 	if (start_async(&rev_list))
@@ -489,6 +512,10 @@ static void receive_needs(void)
 			use_sideband = DEFAULT_PACKET_MAX;
 		if (strstr(line+45, "no-progress"))
 			no_progress = 1;
+		if (strstr(line+45, "commits-only"))
+			commits_only = 1;
+		if (strstr(line+45, "exact-objects"))
+			exact_objects = 1;
 
 		/* We have sent all our refs already, and the other end
 		 * should have chosen out of them; otherwise they are
@@ -498,9 +525,15 @@ static void receive_needs(void)
 		 * asks for something like "master~10" (symbolic)...
 		 * would it make sense?  I don't know.
 		 */
-		o = lookup_object(sha1_buf);
-		if (!o || !(o->flags & OUR_REF))
-			die("git-upload-pack: not our ref %s", line+5);
+		if (!exact_objects) {
+			o = lookup_object(sha1_buf);
+			if (!o || !(o->flags & OUR_REF))
+				die("git-upload-pack: not our ref %s", line+5);
+		} else {
+			o = lookup_unknown_object(sha1_buf);
+			if (!o)
+				die("git-upload-pack: not an object %s", line+5);
+		}
 		if (!(o->flags & WANTED)) {
 			o->flags |= WANTED;
 			add_object_array(o, NULL, &want_obj);
@@ -557,7 +590,7 @@ static void receive_needs(void)
 static int send_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
-		" side-band-64k ofs-delta shallow no-progress";
+		" side-band-64k ofs-delta shallow no-progress remote-alternates";
 	struct object *o = parse_object(sha1);
 
 	if (!o)
@@ -588,7 +621,8 @@ static void upload_pack(void)
 	packet_flush(1);
 	receive_needs();
 	if (want_obj.nr) {
-		get_common_commits();
+		if (!exact_objects)
+			get_common_commits();
 		create_pack_file();
 	}
 }
