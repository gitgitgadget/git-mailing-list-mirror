From: Linus Torvalds <torvalds@osdl.org>
Subject: Improve git-peek-remote
Date: Tue, 4 Jul 2006 12:29:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607041222110.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Jul 04 21:29:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxqaJ-0005gb-Gi
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 21:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWGDT3S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 15:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWGDT3S
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 15:29:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58541 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932339AbWGDT3R (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 15:29:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k64JTDnW029716
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 4 Jul 2006 12:29:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k64JTAsx012065;
	Tue, 4 Jul 2006 12:29:12 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23311>


This makes git-peek-remote able to basically do everything that 
git-ls-remote does (but obviously just for the native protocol, so no 
http[s]: or rsync: support).

The default behaviour is the same, but you can now give a mixture of 
"--refs", "--tags" and "--heads" flags, where "--refs" forces 
git-peek-remote to only show real refs (ie none of the fakey tag lookups, 
but also not the special pseudo-refs like HEAD and MERGE_HEAD).

The "--tags" and "--heads" flags respectively limit the output to just 
regular tags and heads, of course.

You can still also ask to limit them by name too.

You can combine the flags, so

	git peek-remote --refs --tags .

will show all local _true_ tags, without the generated tag lookups 
(compare the output without the "--refs" flag).

And "--tags --heads" will show both tags and heads, but will avoid (for 
example) any special refs outside of the standard locations.

I'm also planning on adding a "--ignore-local" flag that allows us to ask 
it to ignore any refs that we already have in the local tree, but that's 
an independent thing.

All this is obviously gearing up to making "git fetch" cheaper.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

 cache.h       |    6 +++++-
 connect.c     |   35 +++++++++++++++++++++++++++++++----
 peek-remote.c |   28 +++++++++++++++++++++-------
 send-pack.c   |    2 +-
 4 files changed, 58 insertions(+), 13 deletions(-)

diff --git a/cache.h b/cache.h
index 84770bf..7b5c91c 100644
--- a/cache.h
+++ b/cache.h
@@ -322,13 +322,17 @@ struct ref {
 	char name[FLEX_ARRAY]; /* more */
 };
 
+#define REF_NORMAL	(1u << 0)
+#define REF_HEADS	(1u << 1)
+#define REF_TAGS	(1u << 2)
+
 extern int git_connect(int fd[2], char *url, const char *prog);
 extern int finish_connect(pid_t pid);
 extern int path_match(const char *path, int nr, char **match);
 extern int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 		      int nr_refspec, char **refspec, int all);
 extern int get_ack(int fd, unsigned char *result_sha1);
-extern struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match, int ignore_funny);
+extern struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match, unsigned int flags);
 extern int server_supports(const char *feature);
 
 extern struct packed_git *parse_pack_index(unsigned char *sha1);
diff --git a/connect.c b/connect.c
index 9a87bd9..4422a0d 100644
--- a/connect.c
+++ b/connect.c
@@ -12,11 +12,40 @@ #include <signal.h>
 
 static char *server_capabilities = NULL;
 
+static int check_ref(const char *name, int len, unsigned int flags)
+{
+	if (!flags)
+		return 1;
+
+	if (len > 45 || memcmp(name, "refs/", 5))
+		return 0;
+
+	/* Skip the "refs/" part */
+	name += 5;
+	len -= 5;
+
+	/* REF_NORMAL means that we don't want the magic fake tag refs */
+	if ((flags & REF_NORMAL) && check_ref_format(name) < 0)
+		return 0;
+
+	/* REF_HEADS means that we want regular branch heads */
+	if ((flags & REF_HEADS) && !memcmp(name, "heads/", 6))
+		return 1;
+
+	/* REF_TAGS means that we want tags */
+	if ((flags & REF_TAGS) && !memcmp(name, "tags/", 5))
+		return 1;
+
+	/* All type bits clear means that we are ok with anything */
+	return !(flags & ~REF_NORMAL);
+}
+
 /*
  * Read all the refs from the other end
  */
 struct ref **get_remote_heads(int in, struct ref **list,
-			      int nr_match, char **match, int ignore_funny)
+			      int nr_match, char **match,
+			      unsigned int flags)
 {
 	*list = NULL;
 	for (;;) {
@@ -43,10 +72,8 @@ struct ref **get_remote_heads(int in, st
 			server_capabilities = strdup(name + name_len + 1);
 		}
 
-		if (ignore_funny && 45 < len && !memcmp(name, "refs/", 5) &&
-		    check_ref_format(name + 5))
+		if (!check_ref(name, name_len, flags))
 			continue;
-
 		if (nr_match && !path_match(name, nr_match, match))
 			continue;
 		ref = xcalloc(1, sizeof(*ref) + len - 40);
diff --git a/fetch-pack.c b/fetch-pack.c
diff --git a/peek-remote.c b/peek-remote.c
index a90cf22..2b30980 100644
--- a/peek-remote.c
+++ b/peek-remote.c
@@ -7,11 +7,11 @@ static const char peek_remote_usage[] =
 "git-peek-remote [--exec=upload-pack] [host:]directory";
 static const char *exec = "git-upload-pack";
 
-static int peek_remote(int fd[2])
+static int peek_remote(int fd[2], unsigned flags)
 {
 	struct ref *ref;
 
-	get_remote_heads(fd[0], &ref, 0, NULL, 0);
+	get_remote_heads(fd[0], &ref, 0, NULL, flags);
 	packet_flush(fd[1]);
 
 	while (ref) {
@@ -28,6 +28,7 @@ int main(int argc, char **argv)
 	int fd[2];
 	pid_t pid;
 	int nongit = 0;
+	unsigned flags = 0;
 
 	setup_git_directory_gently(&nongit);
 
@@ -35,22 +36,35 @@ int main(int argc, char **argv)
 		char *arg = argv[i];
 
 		if (*arg == '-') {
-			if (!strncmp("--exec=", arg, 7))
+			if (!strncmp("--exec=", arg, 7)) {
 				exec = arg + 7;
-			else
-				usage(peek_remote_usage);
-			continue;
+				continue;
+			}
+			if (!strcmp("--tags", arg)) {
+				flags |= REF_TAGS;
+				continue;
+			}
+			if (!strcmp("--heads", arg)) {
+				flags |= REF_HEADS;
+				continue;
+			}
+			if (!strcmp("--refs", arg)) {
+				flags |= REF_NORMAL;
+				continue;
+			}
+			usage(peek_remote_usage);
 		}
 		dest = arg;
 		break;
 	}
+
 	if (!dest || i != argc - 1)
 		usage(peek_remote_usage);
 
 	pid = git_connect(fd, dest, exec);
 	if (pid < 0)
 		return 1;
-	ret = peek_remote(fd);
+	ret = peek_remote(fd, flags);
 	close(fd[0]);
 	close(fd[1]);
 	finish_connect(pid);
diff --git a/send-pack.c b/send-pack.c
index af93b11..4019a4b 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -239,7 +239,7 @@ static int send_pack(int in, int out, in
 	int expect_status_report = 0;
 
 	/* No funny business with the matcher */
-	remote_tail = get_remote_heads(in, &remote_refs, 0, NULL, 1);
+	remote_tail = get_remote_heads(in, &remote_refs, 0, NULL, REF_NORMAL);
 	get_local_heads();
 
 	/* Does the other end support the reporting? */
