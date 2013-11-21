From: Torsten =?iso-8859-1?q?B=F6gershausen?= <tboegi@web.de>
Subject: [PATCH v6 05/10] git fetch-pack: Add --diag-url
Date: Thu, 21 Nov 2013 21:40:48 +0100
Message-ID: <201311212140.49698.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 21 21:41:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjb3b-0000XK-U6
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 21:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044Ab3KUUk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 15:40:56 -0500
Received: from mout.web.de ([212.227.15.14]:61285 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752020Ab3KUUkz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 15:40:55 -0500
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0Lmcf9-1VAG2Q3XL1-00aCwM for <git@vger.kernel.org>; Thu,
 21 Nov 2013 21:40:54 +0100
X-Provags-ID: V03:K0:TbdI4BVPV5kaiVYEg1RQ+QpRqpjvqUEpJo2fjQFLIvl2uGVnGvW
 3kFw/EAmBSKBkqE5E870CK0N5xL7pP58XiBtLMLM1GtVqr8D/b3m6XCDNjJ/FltzafTlpPE
 eZtYKFvS+0eS+XSi3eUiRQCyt0tPZH+ETvu1ysCh9jad2LSQR2F3dXqxbxmHWNPgxqZTAlC
 v7j5VsiNhYIaLDdqwT5Mg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238146>

The main purpose is to trace the URL parser called by git_connect() in
connect.c

The main features of the parser can be listed as this:
- parse out host and path for URLs with a scheme (git:// file:// ssh://)
- parse host names embedded by [] correctly
- extract the port number, if present
- seperate URLs like "file" (which are local)
  from URLs like "host:repo" which should use ssh

Add the new parameter "--diag-url" to "git fetch-pack",
which prints the value for protocol, host and path to stderr and exits.
---
 builtin/fetch-pack.c  | 14 ++++++++++---
 connect.c             | 27 ++++++++++++++++++++++++
 connect.h             |  1 +
 fetch-pack.h          |  1 +
 t/t5500-fetch-pack.sh | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index c8e8582..758b5ac 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -7,7 +7,7 @@
 static const char fetch_pack_usage[] =
 "git fetch-pack [--all] [--stdin] [--quiet|-q] [--keep|-k] [--thin] "
 "[--include-tag] [--upload-pack=<git-upload-pack>] [--depth=<n>] "
-"[--no-progress] [-v] [<host>:]<directory> [<refs>...]";
+"[--no-progress] [--diag-url] [-v] [<host>:]<directory> [<refs>...]";
 
 static void add_sought_entry_mem(struct ref ***sought, int *nr, int *alloc,
 				 const char *name, int namelen)
@@ -81,6 +81,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			args.stdin_refs = 1;
 			continue;
 		}
+		if (!strcmp("--diag-url", arg)) {
+			args.diag_url = 1;
+			continue;
+		}
 		if (!strcmp("-v", arg)) {
 			args.verbose = 1;
 			continue;
@@ -146,10 +150,14 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		fd[0] = 0;
 		fd[1] = 1;
 	} else {
+		int flags = args.verbose ? CONNECT_VERBOSE : 0;
+		if (args.diag_url)
+			flags |= CONNECT_DIAG_URL;
 		conn = git_connect(fd, dest, args.uploadpack,
-				   args.verbose ? CONNECT_VERBOSE : 0);
+				   flags);
+		if (!conn)
+			return args.diag_url ? 0 : 1;
 	}
-
 	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL);
 
 	ref = fetch_pack(&args, fd, conn, ref, dest,
diff --git a/connect.c b/connect.c
index a6cf345..1b93b4d 100644
--- a/connect.c
+++ b/connect.c
@@ -236,6 +236,19 @@ enum protocol {
 	PROTO_GIT
 };
 
+static const char *prot_name(enum protocol protocol) {
+	switch (protocol) {
+		case PROTO_LOCAL:
+			return "file";
+		case PROTO_SSH:
+			return "ssh";
+		case PROTO_GIT:
+			return "git";
+		default:
+			return "unkown protocol";
+	}
+}
+
 static enum protocol get_protocol(const char *name)
 {
 	if (!strcmp(name, "ssh"))
@@ -670,6 +683,20 @@ struct child_process *git_connect(int fd[2], const char *url,
 	signal(SIGCHLD, SIG_DFL);
 
 	protocol = parse_connect_url(url, &host, &port, &path);
+	if (flags & CONNECT_DIAG_URL) {
+		fprintf(stderr, "Diag: url=%s\n", url ? url : "NULL");
+		fprintf(stderr, "Diag: protocol=%s\n", prot_name(protocol));
+		fprintf(stderr, "Diag: host=%s", host ? host : "NULL");
+		if (port)
+			fprintf(stderr, ":%s\n", port);
+		else
+			fprintf(stderr, "\n");
+		fprintf(stderr, "Diag: path=%s\n", path ? path : "NULL");
+		free(host);
+		free(port);
+		free(path);
+		return NULL;
+	}
 
 	if (protocol == PROTO_GIT) {
 		/* These underlying connection commands die() if they
diff --git a/connect.h b/connect.h
index 64fb7db..527d58a 100644
--- a/connect.h
+++ b/connect.h
@@ -2,6 +2,7 @@
 #define CONNECT_H
 
 #define CONNECT_VERBOSE       (1u << 0)
+#define CONNECT_DIAG_URL      (1u << 1)
 extern struct child_process *git_connect(int fd[2], const char *url, const char *prog, int flags);
 extern int finish_connect(struct child_process *conn);
 extern int git_connection_is_socket(struct child_process *conn);
diff --git a/fetch-pack.h b/fetch-pack.h
index 461cbf3..20ccc12 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -14,6 +14,7 @@ struct fetch_pack_args {
 		use_thin_pack:1,
 		fetch_all:1,
 		stdin_refs:1,
+		diag_url:1,
 		verbose:1,
 		no_progress:1,
 		include_tag:1,
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index d87ddf7..9136f2a 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -531,5 +531,62 @@ test_expect_success 'shallow fetch with tags does not break the repository' '
 		git fsck
 	)
 '
+check_prot_path() {
+	> actual &&
+	(git fetch-pack --diag-url "$1" 2>&1 1>stdout) | grep -v host= >actual &&
+	echo "Diag: url=$1" >expected &&
+	echo "Diag: protocol=$2" >>expected &&
+	echo "Diag: path=$3" >>expected &&
+	test_cmp expected actual
+}
+
+check_prot_host_path() {
+	> actual &&
+	git fetch-pack --diag-url "$1" 2>actual &&
+	echo "Diag: url=$1" >expected &&
+	echo "Diag: protocol=$2" >>expected &&
+	echo "Diag: host=$3" >>expected &&
+	echo "Diag: path=$4" >>expected &&
+	test_cmp expected actual
+}
+
+for r in repo re:po re/po
+do
+	# git or ssh with scheme
+	for p in "ssh+git" "git+ssh" git ssh
+	do
+		for h in host host:12 [::1] [::1]:23
+		do
+			if $(echo $p | grep ssh >/dev/null 2>/dev/null); then
+				hh=$(echo $h | tr -d "[]")
+				pp=ssh
+			else
+				hh=$h
+				pp=$p
+			fi
+			test_expect_success "fetch-pack $p://$h/$r" '
+				check_prot_host_path $p://$h/$r $pp "$hh" "/$r"
+			'
+			# "/~" -> "~" conversion for git
+			test_expect_success "fetch-pack $p://$h/~$r" '
+				check_prot_host_path $p://$h/~$r $pp "$hh" "~$r"
+			'
+		done
+	done
+	# file with scheme
+	for p in file
+	do
+		for h in "" host host:12 [::1] [::1]:23
+		do
+			test_expect_success "fetch-pack $p://$h/$r" '
+				check_prot_path $p://$h/$r $p "/$r"
+			'
+			# No "/~" -> "~" conversion for file
+			test_expect_success "fetch-pack $p://$h/~$r" '
+				check_prot_path $p://$h/~$r $p "/~$r"
+			'
+		done
+	done
+done
 
 test_done
-- 
1.8.4.457.g424cb08
