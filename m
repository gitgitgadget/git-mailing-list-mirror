From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Do not call fetch() when we have it.
Date: Sun, 01 May 2005 17:10:40 -0700
Message-ID: <7voebuqygv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 02:05:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSORJ-00085w-PS
	for gcvg-git@gmane.org; Mon, 02 May 2005 02:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVEBAL1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 20:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVEBAL1
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 20:11:27 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:48076 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261523AbVEBAKn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 20:10:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050502001039.FHNG12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 1 May 2005 20:10:39 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Currently pull() calls fetch() without checking whether we have
the wanted object but all of the existing fetch()
implementations perform this check and return success
themselves.  This patch moves the check to the caller.

I will be sending a trivial git-local-pull which depends on
this in the next message.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

http-pull.c |    4 ----
pull.c      |   17 ++++++++++++-----
rpull.c     |    2 --
3 files changed, 12 insertions(+), 11 deletions(-)

# - date handling: handle "AM"/"PM" on time
# + working-tree
--- k/http-pull.c
+++ l/http-pull.c
@@ -53,10 +53,6 @@ int fetch(unsigned char *sha1)
 	char *url;
 	char *posn;
 
-	if (has_sha1_file(sha1)) {
-		return 0;
-	}
-
 	local = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
 
 	if (local < 0)
--- k/pull.c
+++ l/pull.c
@@ -8,6 +8,13 @@ int get_tree = 0;
 int get_history = 0;
 int get_all = 0;
 
+static int make_sure_we_have_it(unsigned char *sha1)
+{
+	if (has_sha1_file(sha1))
+		return 0;
+	return fetch(sha1);	
+}
+
 static int process_tree(unsigned char *sha1)
 {
 	struct tree *tree = lookup_tree(sha1);
@@ -17,7 +24,7 @@ static int process_tree(unsigned char *s
 		return -1;
 
 	for (entries = tree->entries; entries; entries = entries->next) {
-		if (fetch(entries->item.tree->object.sha1))
+		if (make_sure_we_have_it(entries->item.tree->object.sha1))
 			return -1;
 		if (entries->directory) {
 			if (process_tree(entries->item.tree->object.sha1))
@@ -31,14 +38,14 @@ static int process_commit(unsigned char 
 {
 	struct commit *obj = lookup_commit(sha1);
 
-	if (fetch(sha1))
+	if (make_sure_we_have_it(sha1))
 		return -1;
 
 	if (parse_commit(obj))
 		return -1;
 
 	if (get_tree) {
-		if (fetch(obj->tree->object.sha1))
+		if (make_sure_we_have_it(obj->tree->object.sha1))
 			return -1;
 		if (process_tree(obj->tree->object.sha1))
 			return -1;
@@ -50,7 +57,7 @@ static int process_commit(unsigned char 
 		for (; parents; parents = parents->next) {
 			if (has_sha1_file(parents->item->object.sha1))
 				continue;
-			if (fetch(parents->item->object.sha1)) {
+			if (make_sure_we_have_it(parents->item->object.sha1)) {
 				/* The server might not have it, and
 				 * we don't mind. 
 				 */
@@ -70,7 +77,7 @@ int pull(char *target)
 	retval = get_sha1_hex(target, sha1);
 	if (retval)
 		return retval;
-	retval = fetch(sha1);
+	retval = make_sure_we_have_it(sha1);
 	if (retval)
 		return retval;
 	return process_commit(sha1);
--- k/rpull.c
+++ l/rpull.c
@@ -14,8 +14,6 @@ static int fd_out;
 
 int fetch(unsigned char *sha1)
 {
-	if (has_sha1_file(sha1))
-		return 0;
 	write(fd_out, sha1, 20);
 	return write_sha1_from_fd(sha1, fd_in);
 }

