From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 4/4] Teach git-http-fetch the --stdin switch
Date: Thu, 27 Jul 2006 23:56:22 +0200
Message-ID: <20060727215622.24240.56894.stgit@machine>
References: <20060727215326.24240.20118.stgit@machine>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 23:56:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6DqM-0006lX-7G
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 23:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWG0V40 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 17:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWG0V40
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 17:56:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:30414 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751328AbWG0V4Z (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 17:56:25 -0400
Received: (qmail 24898 invoked from network); 27 Jul 2006 23:56:22 +0200
Received: from localhost (HELO ?62.24.88.241?) (xpasky@127.0.0.1)
  by localhost with SMTP; 27 Jul 2006 23:56:22 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060727215326.24240.20118.stgit@machine>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24351>

Speeds up things quite a lot when fetching tags with Cogito.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-http-fetch.txt |    8 ++++++-
 http-fetch.c                     |   45 ++++++++++++++++++++++++--------------
 2 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index bc1a132..bea522e 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -8,7 +8,7 @@ git-http-fetch - downloads a remote git 
 
 SYNOPSIS
 --------
-'git-http-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] <commit> <url>
+'git-http-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [--stdin] <commit> <url>
 
 DESCRIPTION
 -----------
@@ -32,6 +32,12 @@ commit-id::
 -w <filename>::
         Writes the commit-id into the filename under $GIT_DIR/refs/<filename> on
         the local end after the transfer is complete.
+ 
+--stdin::
+	Instead of a commit id on the commandline (which is not expected in this
+	case), 'git-http-fetch' excepts lines on stdin in the format
+
+		<commit-id>['\t'<filename-as-in--w>]
 
 Author
 ------
diff --git a/http-fetch.c b/http-fetch.c
index bc67db1..1aad39b 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -36,6 +36,8 @@ #endif
 #define PREV_BUF_SIZE 4096
 #define RANGE_HEADER_SIZE 30
 
+static int commits_on_stdin = 0;
+
 static int got_alternates = -1;
 static int corrupt_object_found = 0;
 
@@ -43,7 +45,7 @@ static struct curl_slist *no_pragma_head
 
 struct alt_base
 {
-	char *base;
+	const char *base;
 	int path_len;
 	int got_indices;
 	struct packed_git *packs;
@@ -81,7 +83,7 @@ struct object_request
 };
 
 struct alternates_request {
-	char *base;
+	const char *base;
 	char *url;
 	struct buffer *buffer;
 	struct active_request_slot *slot;
@@ -142,7 +144,7 @@ static size_t fwrite_sha1_file(void *ptr
 	return size;
 }
 
-static void fetch_alternates(char *base);
+static void fetch_alternates(const char *base);
 
 static void process_object_response(void *callback_data);
 
@@ -507,7 +509,7 @@ static void process_alternates_response(
 		(struct alternates_request *)callback_data;
 	struct active_request_slot *slot = alt_req->slot;
 	struct alt_base *tail = alt;
-	char *base = alt_req->base;
+	const char *base = alt_req->base;
 	static const char null_byte = '\0';
 	char *data;
 	int i = 0;
@@ -612,7 +614,7 @@ static void process_alternates_response(
 	got_alternates = 1;
 }
 
-static void fetch_alternates(char *base)
+static void fetch_alternates(const char *base)
 {
 	struct buffer buffer;
 	char *url;
@@ -1185,7 +1187,7 @@ int fetch_ref(char *ref, unsigned char *
         char *url;
         char hex[42];
         struct buffer buffer;
-	char *base = alt->base;
+	const char *base = alt->base;
 	struct active_request_slot *slot;
 	struct slot_results results;
         buffer.size = 41;
@@ -1214,11 +1216,12 @@ int fetch_ref(char *ref, unsigned char *
         return 0;
 }
 
-int main(int argc, char **argv)
+int main(int argc, const char **argv)
 {
-	const char *write_ref = NULL;
-	char *commit_id;
-	char *url;
+	int commits;
+	const char **write_ref = NULL;
+	char **commit_id;
+	const char *url;
 	char *path;
 	int arg = 1;
 	int rc = 0;
@@ -1238,19 +1241,26 @@ int main(int argc, char **argv)
 		} else if (argv[arg][1] == 'v') {
 			get_verbosely = 1;
 		} else if (argv[arg][1] == 'w') {
-			write_ref = argv[arg + 1];
+			write_ref = &argv[arg + 1];
 			arg++;
 		} else if (!strcmp(argv[arg], "--recover")) {
 			get_recover = 1;
+		} else if (!strcmp(argv[arg], "--stdin")) {
+			commits_on_stdin = 1;
 		}
 		arg++;
 	}
-	if (argc < arg + 2) {
-		usage("git-http-fetch [-c] [-t] [-a] [-v] [--recover] [-w ref] commit-id url");
+	if (argc < arg + 2 - commits_on_stdin) {
+		usage("git-http-fetch [-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url");
 		return 1;
 	}
-	commit_id = argv[arg];
-	url = argv[arg + 1];
+	if (commits_on_stdin) {
+		commits = pull_targets_stdin(&commit_id, &write_ref);
+	} else {
+		commit_id = (char **) &argv[arg++];
+		commits = 1;
+	}
+	url = argv[arg];
 
 	http_init();
 
@@ -1268,13 +1278,16 @@ int main(int argc, char **argv)
 			alt->path_len = strlen(path);
 	}
 
-	if (pull(1, &commit_id, &write_ref, url))
+	if (pull(commits, commit_id, write_ref, url))
 		rc = 1;
 
 	http_cleanup();
 
 	curl_slist_free_all(no_pragma_header);
 
+	if (commits_on_stdin)
+		pull_targets_free(commits, commit_id, write_ref);
+
 	if (corrupt_object_found) {
 		fprintf(stderr,
 "Some loose object were found to be corrupt, but they might be just\n"
