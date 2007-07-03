From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/2] Remove obsolete commit-walkers
Date: Tue, 3 Jul 2007 01:28:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707030128110.14638@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jul 03 07:28:22 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5aw1-0006s9-PK
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 07:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbXGCF2T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 01:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751744AbXGCF2T
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 01:28:19 -0400
Received: from iabervon.org ([66.92.72.58]:3424 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750712AbXGCF2R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 01:28:17 -0400
Received: (qmail 11874 invoked by uid 1000); 3 Jul 2007 05:28:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Jul 2007 05:28:16 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51459>

Removes the commit-walkers that are no longer useful, as well as
library code that was only used by ssh-fetch/push.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Makefile      |   20 +----
 local-fetch.c |  254 ---------------------------------------------------------
 rsh.c         |   83 -------------------
 rsh.h         |    7 --
 ssh-fetch.c   |  166 -------------------------------------
 ssh-pull.c    |    4 -
 ssh-push.c    |    4 -
 ssh-upload.c  |  143 --------------------------------
 8 files changed, 4 insertions(+), 677 deletions(-)
 delete mode 100644 local-fetch.c
 delete mode 100644 rsh.c
 delete mode 100644 rsh.h
 delete mode 100644 ssh-fetch.c
 delete mode 100644 ssh-pull.c
 delete mode 100644 ssh-push.c
 delete mode 100644 ssh-upload.c

diff --git a/Makefile b/Makefile
index 4ea5e45..705dde5 100644
--- a/Makefile
+++ b/Makefile
@@ -239,14 +239,14 @@ endif
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS = \
 	git-convert-objects$X git-fetch-pack$X \
-	git-hash-object$X git-index-pack$X git-local-fetch$X \
+	git-hash-object$X git-index-pack$X \
 	git-fast-import$X \
 	git-daemon$X \
 	git-merge-index$X git-mktag$X git-mktree$X git-patch-id$X \
 	git-peek-remote$X git-receive-pack$X \
 	git-send-pack$X git-shell$X \
-	git-show-index$X git-ssh-fetch$X \
-	git-ssh-upload$X git-unpack-file$X \
+	git-show-index$X \
+	git-unpack-file$X \
 	git-update-server-info$X \
 	git-upload-pack$X \
 	git-pack-redundant$X git-var$X \
@@ -274,9 +274,6 @@ ifndef NO_TCLTK
 OTHER_PROGRAMS += gitk-wish
 endif
 
-# Backward compatibility -- to be removed after 1.0
-PROGRAMS += git-ssh-pull$X git-ssh-push$X
-
 # Set paths to tools early so that they can be used for version tests.
 ifndef SHELL_PATH
 	SHELL_PATH = /bin/sh
@@ -884,14 +881,6 @@ endif
 git-%$X: %.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
-ssh-pull.o: ssh-fetch.c
-ssh-push.o: ssh-upload.c
-git-local-fetch$X: fetch.o
-git-ssh-fetch$X: rsh.o fetch.o
-git-ssh-upload$X: rsh.o
-git-ssh-pull$X: rsh.o fetch.o
-git-ssh-push$X: rsh.o
-
 git-imap-send$X: imap-send.o $(LIB_FILE)
 
 http.o http-fetch.o http-push.o: http.h
@@ -1103,8 +1092,7 @@ check-docs::
 		git-merge-octopus | git-merge-ours | git-merge-recursive | \
 		git-merge-resolve | git-merge-stupid | \
 		git-add--interactive | git-fsck-objects | git-init-db | \
-		git-repo-config | git-fetch--tool | \
-		git-ssh-pull | git-ssh-push ) continue ;; \
+		git-repo-config | git-fetch--tool ) continue ;; \
 		esac ; \
 		test -f "Documentation/$$v.txt" || \
 		echo "no doc: $$v"; \
diff --git a/local-fetch.c b/local-fetch.c
deleted file mode 100644
index bf7ec6c..0000000
--- a/local-fetch.c
+++ /dev/null
@@ -1,254 +0,0 @@
-/*
- * Copyright (C) 2005 Junio C Hamano
- */
-#include "cache.h"
-#include "commit.h"
-#include "fetch.h"
-
-static int use_link;
-static int use_symlink;
-static int use_filecopy = 1;
-static int commits_on_stdin;
-
-static const char *path; /* "Remote" git repository */
-
-void prefetch(unsigned char *sha1)
-{
-}
-
-static struct packed_git *packs;
-
-static void setup_index(unsigned char *sha1)
-{
-	struct packed_git *new_pack;
-	char filename[PATH_MAX];
-	strcpy(filename, path);
-	strcat(filename, "/objects/pack/pack-");
-	strcat(filename, sha1_to_hex(sha1));
-	strcat(filename, ".idx");
-	new_pack = parse_pack_index_file(sha1, filename);
-	new_pack->next = packs;
-	packs = new_pack;
-}
-
-static int setup_indices(void)
-{
-	DIR *dir;
-	struct dirent *de;
-	char filename[PATH_MAX];
-	unsigned char sha1[20];
-	sprintf(filename, "%s/objects/pack/", path);
-	dir = opendir(filename);
-	if (!dir)
-		return -1;
-	while ((de = readdir(dir)) != NULL) {
-		int namelen = strlen(de->d_name);
-		if (namelen != 50 ||
-		    !has_extension(de->d_name, ".pack"))
-			continue;
-		get_sha1_hex(de->d_name + 5, sha1);
-		setup_index(sha1);
-	}
-	closedir(dir);
-	return 0;
-}
-
-static int copy_file(const char *source, char *dest, const char *hex,
-		     int warn_if_not_exists)
-{
-	safe_create_leading_directories(dest);
-	if (use_link) {
-		if (!link(source, dest)) {
-			pull_say("link %s\n", hex);
-			return 0;
-		}
-		/* If we got ENOENT there is no point continuing. */
-		if (errno == ENOENT) {
-			if (!warn_if_not_exists)
-				return -1;
-			return error("does not exist %s", source);
-		}
-	}
-	if (use_symlink) {
-		struct stat st;
-		if (stat(source, &st)) {
-			if (!warn_if_not_exists && errno == ENOENT)
-				return -1;
-			return error("cannot stat %s: %s", source,
-				     strerror(errno));
-		}
-		if (!symlink(source, dest)) {
-			pull_say("symlink %s\n", hex);
-			return 0;
-		}
-	}
-	if (use_filecopy) {
-		int ifd, ofd, status = 0;
-
-		ifd = open(source, O_RDONLY);
-		if (ifd < 0) {
-			if (!warn_if_not_exists && errno == ENOENT)
-				return -1;
-			return error("cannot open %s", source);
-		}
-		ofd = open(dest, O_WRONLY | O_CREAT | O_EXCL, 0666);
-		if (ofd < 0) {
-			close(ifd);
-			return error("cannot open %s", dest);
-		}
-		status = copy_fd(ifd, ofd);
-		close(ofd);
-		if (status)
-			return error("cannot write %s", dest);
-		pull_say("copy %s\n", hex);
-		return 0;
-	}
-	return error("failed to copy %s with given copy methods.", hex);
-}
-
-static int fetch_pack(const unsigned char *sha1)
-{
-	struct packed_git *target;
-	char filename[PATH_MAX];
-	if (setup_indices())
-		return -1;
-	target = find_sha1_pack(sha1, packs);
-	if (!target)
-		return error("Couldn't find %s: not separate or in any pack",
-			     sha1_to_hex(sha1));
-	if (get_verbosely) {
-		fprintf(stderr, "Getting pack %s\n",
-			sha1_to_hex(target->sha1));
-		fprintf(stderr, " which contains %s\n",
-			sha1_to_hex(sha1));
-	}
-	sprintf(filename, "%s/objects/pack/pack-%s.pack",
-		path, sha1_to_hex(target->sha1));
-	copy_file(filename, sha1_pack_name(target->sha1),
-		  sha1_to_hex(target->sha1), 1);
-	sprintf(filename, "%s/objects/pack/pack-%s.idx",
-		path, sha1_to_hex(target->sha1));
-	copy_file(filename, sha1_pack_index_name(target->sha1),
-		  sha1_to_hex(target->sha1), 1);
-	install_packed_git(target);
-	return 0;
-}
-
-static int fetch_file(const unsigned char *sha1)
-{
-	static int object_name_start = -1;
-	static char filename[PATH_MAX];
-	char *hex = sha1_to_hex(sha1);
-	char *dest_filename = sha1_file_name(sha1);
-
-	if (object_name_start < 0) {
-		strcpy(filename, path); /* e.g. git.git */
-		strcat(filename, "/objects/");
-		object_name_start = strlen(filename);
-	}
-	filename[object_name_start+0] = hex[0];
-	filename[object_name_start+1] = hex[1];
-	filename[object_name_start+2] = '/';
-	strcpy(filename + object_name_start + 3, hex + 2);
-	return copy_file(filename, dest_filename, hex, 0);
-}
-
-int fetch(unsigned char *sha1)
-{
-	if (has_sha1_file(sha1))
-		return 0;
-	else
-		return fetch_file(sha1) && fetch_pack(sha1);
-}
-
-int fetch_ref(char *ref, unsigned char *sha1)
-{
-	static int ref_name_start = -1;
-	static char filename[PATH_MAX];
-	static char hex[41];
-	int ifd;
-
-	if (ref_name_start < 0) {
-		sprintf(filename, "%s/refs/", path);
-		ref_name_start = strlen(filename);
-	}
-	strcpy(filename + ref_name_start, ref);
-	ifd = open(filename, O_RDONLY);
-	if (ifd < 0) {
-		close(ifd);
-		return error("cannot open %s", filename);
-	}
-	if (read_in_full(ifd, hex, 40) != 40 || get_sha1_hex(hex, sha1)) {
-		close(ifd);
-		return error("cannot read from %s", filename);
-	}
-	close(ifd);
-	pull_say("ref %s\n", sha1_to_hex(sha1));
-	return 0;
-}
-
-static const char local_pull_usage[] =
-"git-local-fetch [-c] [-t] [-a] [-v] [-w filename] [--recover] [-l] [-s] [-n] [--stdin] commit-id path";
-
-/*
- * By default we only use file copy.
- * If -l is specified, a hard link is attempted.
- * If -s is specified, then a symlink is attempted.
- * If -n is _not_ specified, then a regular file-to-file copy is done.
- */
-int main(int argc, const char **argv)
-{
-	int commits;
-	const char **write_ref = NULL;
-	char **commit_id;
-	int arg = 1;
-
-	setup_git_directory();
-	git_config(git_default_config);
-
-	while (arg < argc && argv[arg][0] == '-') {
-		if (argv[arg][1] == 't')
-			get_tree = 1;
-		else if (argv[arg][1] == 'c')
-			get_history = 1;
-		else if (argv[arg][1] == 'a') {
-			get_all = 1;
-			get_tree = 1;
-			get_history = 1;
-		}
-		else if (argv[arg][1] == 'l')
-			use_link = 1;
-		else if (argv[arg][1] == 's')
-			use_symlink = 1;
-		else if (argv[arg][1] == 'n')
-			use_filecopy = 0;
-		else if (argv[arg][1] == 'v')
-			get_verbosely = 1;
-		else if (argv[arg][1] == 'w')
-			write_ref = &argv[++arg];
-		else if (!strcmp(argv[arg], "--recover"))
-			get_recover = 1;
-		else if (!strcmp(argv[arg], "--stdin"))
-			commits_on_stdin = 1;
-		else
-			usage(local_pull_usage);
-		arg++;
-	}
-	if (argc < arg + 2 - commits_on_stdin)
-		usage(local_pull_usage);
-	if (commits_on_stdin) {
-		commits = pull_targets_stdin(&commit_id, &write_ref);
-	} else {
-		commit_id = (char **) &argv[arg++];
-		commits = 1;
-	}
-	path = argv[arg];
-
-	if (pull(commits, commit_id, write_ref, path))
-		return 1;
-
-	if (commits_on_stdin)
-		pull_targets_free(commits, commit_id, write_ref);
-
-	return 0;
-}
diff --git a/rsh.c b/rsh.c
deleted file mode 100644
index 5754a23..0000000
--- a/rsh.c
+++ /dev/null
@@ -1,83 +0,0 @@
-#include "cache.h"
-#include "rsh.h"
-#include "quote.h"
-
-#define COMMAND_SIZE 4096
-
-int setup_connection(int *fd_in, int *fd_out, const char *remote_prog,
-		     char *url, int rmt_argc, char **rmt_argv)
-{
-	char *host;
-	char *path;
-	int sv[2];
-	char command[COMMAND_SIZE];
-	char *posn;
-	int sizen;
-	int of;
-	int i;
-	pid_t pid;
-
-	if (!strcmp(url, "-")) {
-		*fd_in = 0;
-		*fd_out = 1;
-		return 0;
-	}
-
-	host = strstr(url, "//");
-	if (host) {
-		host += 2;
-		path = strchr(host, '/');
-	} else {
-		host = url;
-		path = strchr(host, ':');
-		if (path)
-			*(path++) = '\0';
-	}
-	if (!path) {
-		return error("Bad URL: %s", url);
-	}
-	/* $GIT_RSH <host> "env GIT_DIR=<path> <remote_prog> <args...>" */
-	sizen = COMMAND_SIZE;
-	posn = command;
-	of = 0;
-	of |= add_to_string(&posn, &sizen, "env ", 0);
-	of |= add_to_string(&posn, &sizen, GIT_DIR_ENVIRONMENT "=", 0);
-	of |= add_to_string(&posn, &sizen, path, 1);
-	of |= add_to_string(&posn, &sizen, " ", 0);
-	of |= add_to_string(&posn, &sizen, remote_prog, 1);
-
-	for ( i = 0 ; i < rmt_argc ; i++ ) {
-		of |= add_to_string(&posn, &sizen, " ", 0);
-		of |= add_to_string(&posn, &sizen, rmt_argv[i], 1);
-	}
-
-	of |= add_to_string(&posn, &sizen, " -", 0);
-
-	if ( of )
-		return error("Command line too long");
-
-	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sv))
-		return error("Couldn't create socket");
-
-	pid = fork();
-	if (pid < 0)
-		return error("Couldn't fork");
-	if (!pid) {
-		const char *ssh, *ssh_basename;
-		ssh = getenv("GIT_SSH");
-		if (!ssh) ssh = "ssh";
-		ssh_basename = strrchr(ssh, '/');
-		if (!ssh_basename)
-			ssh_basename = ssh;
-		else
-			ssh_basename++;
-		close(sv[1]);
-		dup2(sv[0], 0);
-		dup2(sv[0], 1);
-		execlp(ssh, ssh_basename, host, command, NULL);
-	}
-	close(sv[0]);
-	*fd_in = sv[1];
-	*fd_out = sv[1];
-	return 0;
-}
diff --git a/rsh.h b/rsh.h
deleted file mode 100644
index ee2f499..0000000
--- a/rsh.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef RSH_H
-#define RSH_H
-
-int setup_connection(int *fd_in, int *fd_out, const char *remote_prog,
-		     char *url, int rmt_argc, char **rmt_argv);
-
-#endif
diff --git a/ssh-fetch.c b/ssh-fetch.c
deleted file mode 100644
index bdf51a7..0000000
--- a/ssh-fetch.c
+++ /dev/null
@@ -1,166 +0,0 @@
-#ifndef COUNTERPART_ENV_NAME
-#define COUNTERPART_ENV_NAME "GIT_SSH_UPLOAD"
-#endif
-#ifndef COUNTERPART_PROGRAM_NAME
-#define COUNTERPART_PROGRAM_NAME "git-ssh-upload"
-#endif
-#ifndef MY_PROGRAM_NAME
-#define MY_PROGRAM_NAME "git-ssh-fetch"
-#endif
-
-#include "cache.h"
-#include "commit.h"
-#include "rsh.h"
-#include "fetch.h"
-#include "refs.h"
-
-static int fd_in;
-static int fd_out;
-
-static unsigned char remote_version;
-static unsigned char local_version = 1;
-
-static int prefetches;
-
-static struct object_list *in_transit;
-static struct object_list **end_of_transit = &in_transit;
-
-void prefetch(unsigned char *sha1)
-{
-	char type = 'o';
-	struct object_list *node;
-	if (prefetches > 100) {
-		fetch(in_transit->item->sha1);
-	}
-	node = xmalloc(sizeof(struct object_list));
-	node->next = NULL;
-	node->item = lookup_unknown_object(sha1);
-	*end_of_transit = node;
-	end_of_transit = &node->next;
-	/* XXX: what if these writes fail? */
-	write_in_full(fd_out, &type, 1);
-	write_in_full(fd_out, sha1, 20);
-	prefetches++;
-}
-
-static char conn_buf[4096];
-static size_t conn_buf_posn;
-
-int fetch(unsigned char *sha1)
-{
-	int ret;
-	signed char remote;
-	struct object_list *temp;
-
-	if (hashcmp(sha1, in_transit->item->sha1)) {
-		/* we must have already fetched it to clean the queue */
-		return has_sha1_file(sha1) ? 0 : -1;
-	}
-	prefetches--;
-	temp = in_transit;
-	in_transit = in_transit->next;
-	if (!in_transit)
-		end_of_transit = &in_transit;
-	free(temp);
-
-	if (conn_buf_posn) {
-		remote = conn_buf[0];
-		memmove(conn_buf, conn_buf + 1, --conn_buf_posn);
-	} else {
-		if (xread(fd_in, &remote, 1) < 1)
-			return -1;
-	}
-	/* fprintf(stderr, "Got %d\n", remote); */
-	if (remote < 0)
-		return remote;
-	ret = write_sha1_from_fd(sha1, fd_in, conn_buf, 4096, &conn_buf_posn);
-	if (!ret)
-		pull_say("got %s\n", sha1_to_hex(sha1));
-	return ret;
-}
-
-static int get_version(void)
-{
-	char type = 'v';
-	if (write_in_full(fd_out, &type, 1) != 1 ||
-	    write_in_full(fd_out, &local_version, 1)) {
-		return error("Couldn't request version from remote end");
-	}
-	if (xread(fd_in, &remote_version, 1) < 1) {
-		return error("Couldn't read version from remote end");
-	}
-	return 0;
-}
-
-int fetch_ref(char *ref, unsigned char *sha1)
-{
-	signed char remote;
-	char type = 'r';
-	int length = strlen(ref) + 1;
-	if (write_in_full(fd_out, &type, 1) != 1 ||
-	    write_in_full(fd_out, ref, length) != length)
-		return -1;
-
-	if (read_in_full(fd_in, &remote, 1) != 1)
-		return -1;
-	if (remote < 0)
-		return remote;
-	if (read_in_full(fd_in, sha1, 20) != 20)
-		return -1;
-	return 0;
-}
-
-static const char ssh_fetch_usage[] =
-  MY_PROGRAM_NAME
-  " [-c] [-t] [-a] [-v] [--recover] [-w ref] commit-id url";
-int main(int argc, char **argv)
-{
-	const char *write_ref = NULL;
-	char *commit_id;
-	char *url;
-	int arg = 1;
-	const char *prog;
-
-	prog = getenv("GIT_SSH_PUSH");
-	if (!prog) prog = "git-ssh-upload";
-
-	setup_git_directory();
-	git_config(git_default_config);
-
-	while (arg < argc && argv[arg][0] == '-') {
-		if (argv[arg][1] == 't') {
-			get_tree = 1;
-		} else if (argv[arg][1] == 'c') {
-			get_history = 1;
-		} else if (argv[arg][1] == 'a') {
-			get_all = 1;
-			get_tree = 1;
-			get_history = 1;
-		} else if (argv[arg][1] == 'v') {
-			get_verbosely = 1;
-		} else if (argv[arg][1] == 'w') {
-			write_ref = argv[arg + 1];
-			arg++;
-		} else if (!strcmp(argv[arg], "--recover")) {
-			get_recover = 1;
-		}
-		arg++;
-	}
-	if (argc < arg + 2) {
-		usage(ssh_fetch_usage);
-		return 1;
-	}
-	commit_id = argv[arg];
-	url = argv[arg + 1];
-
-	if (setup_connection(&fd_in, &fd_out, prog, url, arg, argv + 1))
-		return 1;
-
-	if (get_version())
-		return 1;
-
-	if (pull(1, &commit_id, &write_ref, url))
-		return 1;
-
-	return 0;
-}
diff --git a/ssh-pull.c b/ssh-pull.c
deleted file mode 100644
index 868ce4d..0000000
--- a/ssh-pull.c
+++ /dev/null
@@ -1,4 +0,0 @@
-#define COUNTERPART_ENV_NAME "GIT_SSH_PUSH"
-#define COUNTERPART_PROGRAM_NAME "git-ssh-push"
-#define MY_PROGRAM_NAME "git-ssh-pull"
-#include "ssh-fetch.c"
diff --git a/ssh-push.c b/ssh-push.c
deleted file mode 100644
index a562df1..0000000
--- a/ssh-push.c
+++ /dev/null
@@ -1,4 +0,0 @@
-#define COUNTERPART_ENV_NAME "GIT_SSH_PULL"
-#define COUNTERPART_PROGRAM_NAME "git-ssh-pull"
-#define MY_PROGRAM_NAME "git-ssh-push"
-#include "ssh-upload.c"
diff --git a/ssh-upload.c b/ssh-upload.c
deleted file mode 100644
index 20c35f0..0000000
--- a/ssh-upload.c
+++ /dev/null
@@ -1,143 +0,0 @@
-#ifndef COUNTERPART_ENV_NAME
-#define COUNTERPART_ENV_NAME "GIT_SSH_FETCH"
-#endif
-#ifndef COUNTERPART_PROGRAM_NAME
-#define COUNTERPART_PROGRAM_NAME "git-ssh-fetch"
-#endif
-#ifndef MY_PROGRAM_NAME
-#define MY_PROGRAM_NAME "git-ssh-upload"
-#endif
-
-#include "cache.h"
-#include "rsh.h"
-#include "refs.h"
-
-static unsigned char local_version = 1;
-static unsigned char remote_version;
-
-static int verbose;
-
-static int serve_object(int fd_in, int fd_out) {
-	ssize_t size;
-	unsigned char sha1[20];
-	signed char remote;
-
-	size = read_in_full(fd_in, sha1, 20);
-	if (size < 0) {
-		perror("git-ssh-upload: read ");
-		return -1;
-	}
-	if (!size)
-		return -1;
-
-	if (verbose)
-		fprintf(stderr, "Serving %s\n", sha1_to_hex(sha1));
-
-	remote = 0;
-
-	if (!has_sha1_file(sha1)) {
-		fprintf(stderr, "git-ssh-upload: could not find %s\n",
-			sha1_to_hex(sha1));
-		remote = -1;
-	}
-
-	if (write_in_full(fd_out, &remote, 1) != 1)
-		return 0;
-
-	if (remote < 0)
-		return 0;
-
-	return write_sha1_to_fd(fd_out, sha1);
-}
-
-static int serve_version(int fd_in, int fd_out)
-{
-	if (xread(fd_in, &remote_version, 1) < 1)
-		return -1;
-	write_in_full(fd_out, &local_version, 1);
-	return 0;
-}
-
-static int serve_ref(int fd_in, int fd_out)
-{
-	char ref[PATH_MAX];
-	unsigned char sha1[20];
-	int posn = 0;
-	signed char remote = 0;
-	do {
-		if (posn >= PATH_MAX || xread(fd_in, ref + posn, 1) < 1)
-			return -1;
-		posn++;
-	} while (ref[posn - 1]);
-
-	if (verbose)
-		fprintf(stderr, "Serving %s\n", ref);
-
-	if (get_ref_sha1(ref, sha1))
-		remote = -1;
-	if (write_in_full(fd_out, &remote, 1) != 1)
-		return 0;
-	if (remote)
-		return 0;
-	write_in_full(fd_out, sha1, 20);
-        return 0;
-}
-
-
-static void service(int fd_in, int fd_out) {
-	char type;
-	ssize_t retval;
-	do {
-		retval = xread(fd_in, &type, 1);
-		if (retval < 1) {
-			if (retval < 0)
-				perror("git-ssh-upload: read ");
-			return;
-		}
-		if (type == 'v' && serve_version(fd_in, fd_out))
-			return;
-		if (type == 'o' && serve_object(fd_in, fd_out))
-			return;
-		if (type == 'r' && serve_ref(fd_in, fd_out))
-			return;
-	} while (1);
-}
-
-static const char ssh_push_usage[] =
-	MY_PROGRAM_NAME " [-c] [-t] [-a] [-w ref] commit-id url";
-
-int main(int argc, char **argv)
-{
-	int arg = 1;
-        char *commit_id;
-        char *url;
-	int fd_in, fd_out;
-	const char *prog;
-	unsigned char sha1[20];
-	char hex[41];
-
-	prog = getenv(COUNTERPART_ENV_NAME);
-	if (!prog) prog = COUNTERPART_PROGRAM_NAME;
-
-	setup_git_directory();
-
-	while (arg < argc && argv[arg][0] == '-') {
-		if (argv[arg][1] == 'w')
-			arg++;
-                arg++;
-        }
-	if (argc < arg + 2)
-		usage(ssh_push_usage);
-	commit_id = argv[arg];
-	url = argv[arg + 1];
-	if (get_sha1(commit_id, sha1))
-		die("Not a valid object name %s", commit_id);
-	memcpy(hex, sha1_to_hex(sha1), sizeof(hex));
-	argv[arg] = hex;
-
-	if (setup_connection(&fd_in, &fd_out, prog, url, arg, argv + 1))
-		return 1;
-
-	service(fd_in, fd_out);
-	return 0;
-}
-- 
1.5.2.2.1391.gcad2-dirty
