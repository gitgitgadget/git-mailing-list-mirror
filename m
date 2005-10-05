From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] upload-pack: Do not choke on too many heads request.
Date: Wed, 05 Oct 2005 14:51:33 -0700
Message-ID: <7vslvfiqe2.fsf@assigned-by-dhcp.cox.net>
References: <20051005191300.GC17475@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 23:53:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENHAo-0005gD-6C
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 23:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbVJEVvf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 17:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbVJEVvf
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 17:51:35 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:36490 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S965072AbVJEVve (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 17:51:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051005215128.QAEZ4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Oct 2005 17:51:28 -0400
To: Andy Isaacson <adi@hexapodia.org>
In-Reply-To: <20051005191300.GC17475@hexapodia.org> (Andy Isaacson's message
	of "Wed, 5 Oct 2005 12:13:00 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9737>

Cloning from a repository with more than 256 refs (heads and tags
included) will choke, because upload-pack has a built-in limit of
feeding not more than MAX_NEEDS (currently 256) heads to underlying
git-rev-list.  This is a problem when cloning a repository with many
tags, like http://www.linux-mips.org/pub/scm/linux.git, which has 290+
tags.

This commit introduces a new flag, --all, to git-rev-list, to include
all refs in the repository.  Updated upload-pack detects requests that
ask more than MAX_NEEDS refs, and sends everything back instead.

We may probably want to tweak the definitions of MAX_NEEDS and
MAX_HAS, but that is a separate topic.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

  Andy Isaacson <adi@hexapodia.org> writes:

  > Trying to do a local clone of the linux-mips.org git repo:
  >
  > % git clone /home/adi/linux/git/lmo/linux foo
  > defaulting to local storage area
  > fatal: I'm only doing a max of 256 requests
  > % git -v
  > git version 0.99.8.GIT
  >
  > I got git/lmo/linux from http://www.linux-mips.org/pub/scm/linux.git.
  >
  > Am I doing something wrong, or what?

  You are not doing anything wrong.  Please try this patch.

 rev-list.c    |   21 +++++++++++++++++++++
 rev-parse.c   |    1 +
 upload-pack.c |   50 ++++++++++++++++++++++++++++++++++----------------
 3 files changed, 56 insertions(+), 16 deletions(-)

applies-to: dc721a63b8221995616e3013de11e71d94da01ef
e091eb93258f05a58bc5d1c60f058f5f57dd92b6
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "refs.h"
 #include "tag.h"
 #include "commit.h"
 #include "tree.h"
@@ -489,6 +490,22 @@ static void handle_one_commit(struct com
 	commit_list_insert(com, lst);
 }
 
+/* for_each_ref() callback does not allow user data -- Yuck. */
+static struct commit_list **global_lst;
+
+static int include_one_commit(const char *path, const unsigned char *sha1)
+{
+	struct commit *com = get_commit_reference(path, 0);
+	handle_one_commit(com, global_lst);
+	return 0;
+}
+
+static void handle_all(struct commit_list **lst)
+{
+	global_lst = lst;
+	for_each_ref(include_one_commit);
+	global_lst = NULL;
+}
 
 int main(int argc, char **argv)
 {
@@ -542,6 +559,10 @@ int main(int argc, char **argv)
 			bisect_list = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--all")) {
+			handle_all(&list);
+			continue;
+		}
 		if (!strcmp(arg, "--objects")) {
 			tag_objects = 1;
 			tree_objects = 1;
diff --git a/rev-parse.c b/rev-parse.c
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -32,6 +32,7 @@ static int revs_count = 0;
 static int is_rev_argument(const char *arg)
 {
 	static const char *rev_args[] = {
+		"--all",
 		"--bisect",
 		"--header",
 		"--max-age=",
diff --git a/upload-pack.c b/upload-pack.c
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -30,10 +30,18 @@ static void create_pack_file(void)
 
 	if (!pid) {
 		int i;
-		int args = nr_has + nr_needs + 5;
-		char **argv = xmalloc(args * sizeof(char *));
-		char *buf = xmalloc(args * 45);
-		char **p = argv;
+		int args;
+		char **argv;
+		char *buf;
+		char **p;
+
+		if (MAX_NEEDS <= nr_needs)
+			args = nr_has + 10;
+		else
+			args = nr_has + nr_needs + 5;
+		argv = xmalloc(args * sizeof(char *));
+		buf = xmalloc(args * 45);
+		p = argv;
 
 		dup2(fd[1], 1);
 		close(0);
@@ -41,10 +49,14 @@ static void create_pack_file(void)
 		close(fd[1]);
 		*p++ = "git-rev-list";
 		*p++ = "--objects";
-		for (i = 0; i < nr_needs; i++) {
-			*p++ = buf;
-			memcpy(buf, sha1_to_hex(needs_sha1[i]), 41);
-			buf += 41;
+		if (MAX_NEEDS <= nr_needs)
+			*p++ = "--all";
+		else {
+			for (i = 0; i < nr_needs; i++) {
+				*p++ = buf;
+				memcpy(buf, sha1_to_hex(needs_sha1[i]), 41);
+				buf += 41;
+			}
 		}
 		for (i = 0; i < nr_has; i++) {
 			*p++ = buf;
@@ -129,18 +141,24 @@ static int receive_needs(void)
 
 	needs = 0;
 	for (;;) {
+		unsigned char dummy[20], *sha1_buf;
 		len = packet_read_line(0, line, sizeof(line));
 		if (!len)
 			return needs;
 
-		/*
-		 * This is purely theoretical right now: git-fetch-pack only
-		 * ever asks for a single HEAD
-		 */
-		if (needs >= MAX_NEEDS)
-			die("I'm only doing a max of %d requests", MAX_NEEDS);
-		if (strncmp("want ", line, 5) || get_sha1_hex(line+5, needs_sha1[needs]))
-			die("git-upload-pack: protocol error, expected to get sha, not '%s'", line);
+		sha1_buf = dummy;
+		if (needs == MAX_NEEDS) {
+			fprintf(stderr,
+				"warning: supporting only a max of %d requests. "
+				"sending everything instead.\n",
+				MAX_NEEDS);
+		}
+		else if (needs < MAX_NEEDS)
+			sha1_buf = needs_sha1[needs];
+
+		if (strncmp("want ", line, 5) || get_sha1_hex(line+5, sha1_buf))
+			die("git-upload-pack: protocol error, "
+			    "expected to get sha, not '%s'", line);
 		needs++;
 	}
 }
---
0.99.8.GIT
