From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Simplify "reverse-diff" logic in the diff core.
Date: Fri, 20 May 2005 09:54:07 -0700
Message-ID: <7vfywhu9cg.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vacmquet3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505200806150.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 18:55:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZAlH-0006qu-7w
	for gcvg-git@gmane.org; Fri, 20 May 2005 18:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVETQyl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 12:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVETQyi
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 12:54:38 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:38835 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261498AbVETQyM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 12:54:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050520165408.WEEM7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 20 May 2005 12:54:08 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505200806150.2206@ppc970.osdl.org> (Linus
 Torvalds's message of "Fri, 20 May 2005 08:20:21 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Instead of swapping the arguments just before output, this patch
makes the swapping happen on the input side of the diff core,
when "reverse-diff" is in effect.  This greatly simplifies the
logic, but more importantly it is necessary for upcoming "copy
detection" work.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff.c |   38 +++++++++++++++-----------------------
1 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -350,15 +350,6 @@ static void run_external_diff(const char
 	int status;
 	static int atexit_asked = 0;
 
-	if (reverse_diff) {
-		struct diff_spec *tmp_spec;
-		tmp_spec = one; one = two; two = tmp_spec;
-		if (other) {
-			const char *tmp;
-			tmp = name; name = other; other = tmp;
-		}
-	}
-
 	if (!matches_pathspec(name) && (!other || !matches_pathspec(other)))
 		return;
 
@@ -765,11 +756,12 @@ void diff_addremove(int addremove, unsig
 	char concatpath[PATH_MAX];
 	struct diff_spec spec[2], *one, *two;
 
+	if (reverse_diff)
+		addremove = (addremove == '+' ? '-' : '+');
+
 	if (0 <= diff_raw_output) {
 		if (!path)
 			path = "";
-		if (reverse_diff)
-			addremove = (addremove == '+' ? '-' : '+');
 		printf("%c%06o %s %s %s%s%c",
 		       addremove,
 		       mode,
@@ -806,24 +798,24 @@ void diff_change(unsigned old_mode, unsi
 	char concatpath[PATH_MAX];
 	struct diff_spec spec[2];
 
+	if (reverse_diff) {
+		unsigned tmp;
+		const unsigned char *tmp_c;
+		tmp = old_mode; old_mode = new_mode; new_mode = tmp;
+		tmp_c = old_sha1; old_sha1 = new_sha1; new_sha1 = tmp_c;
+	}
+
 	if (0 <= diff_raw_output) {
 		char old_hex[41];
 		strcpy(old_hex, sha1_to_hex(old_sha1));
 
 		if (!path)
 			path = "";
-		if (reverse_diff)
-			printf("*%06o->%06o %s %s->%s %s%s%c",
-			       new_mode, old_mode,
-			       git_object_type(new_mode),
-			       sha1_to_hex(new_sha1), old_hex,
-			       base, path, diff_raw_output);
-		else
-			printf("*%06o->%06o %s %s->%s %s%s%c",
-			       old_mode, new_mode,
-			       git_object_type(new_mode),
-			       old_hex, sha1_to_hex(new_sha1),
-			       base, path, diff_raw_output);
+		printf("*%06o->%06o %s %s->%s %s%s%c",
+		       old_mode, new_mode,
+		       git_object_type(new_mode),
+		       old_hex, sha1_to_hex(new_sha1),
+		       base, path, diff_raw_output);
 		return;
 	}
 	if (S_ISDIR(new_mode))
------------------------------------------------

