From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Teach rev-list since..til notation.
Date: Thu, 04 Aug 2005 02:34:31 -0700
Message-ID: <7vpssu2ggo.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.58.0508030944210.3258@g5.osdl.org>
	<Pine.LNX.4.63.0508031849270.24318@wgmdd8.biozentrum.uni-wuerzburg.de>
	<200508031908.22562.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.58.0508031102590.3258@g5.osdl.org>
	<7vek9a8uy9.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508031641270.3258@g5.osdl.org>
	<7vy87i46il.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508032236470.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Aug 05 19:22:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from mail-relay.eunet.no ([193.71.71.242])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E15tN-0000lv-D4
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 19:21:57 +0200
Received: from vger.kernel.org (vger.kernel.org [12.107.209.244])
	by mail-relay.eunet.no (8.13.1/8.13.1/GN) with ESMTP id j749aqNH041375
	for <gcvg-git@gmane.org>; Thu, 4 Aug 2005 11:36:54 +0200 (CEST)
	(envelope-from git-owner@vger.kernel.org)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbVHDJeh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 05:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbVHDJeh
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 05:34:37 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:37274 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262450AbVHDJed (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 05:34:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050804093432.YWUC12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 4 Aug 2005 05:34:32 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0508032236470.3258@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 3 Aug 2005 22:42:06 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The King Penguin says:

    Now, for extra bonus points, maybe you should make "git-rev-list" also
    understand the "rev..rev" format (which you can't do with just the
    get_sha1() interface, since it expands into more).

The faithful servant makes it so.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 rev-list.c |   38 ++++++++++++++++++++++++++++++--------
 1 files changed, 30 insertions(+), 8 deletions(-)

f22d271a469b65760f73dc483aeb2448619e0ff1
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -457,6 +457,15 @@ static struct commit *get_commit_referen
 	die("%s is unknown object", name);
 }
 
+static void handle_one_commit(struct commit *com, struct commit_list **lst)
+{
+	if (!com || com->object.flags & SEEN)
+		return;
+	com->object.flags |= SEEN;
+	commit_list_insert(com, lst);
+}
+
+
 int main(int argc, char **argv)
 {
 	struct commit_list *list = NULL;
@@ -465,6 +474,7 @@ int main(int argc, char **argv)
 	for (i = 1 ; i < argc; i++) {
 		int flags;
 		char *arg = argv[i];
+		char *dotdot;
 		struct commit *commit;
 
 		if (!strncmp(arg, "--max-count=", 12)) {
@@ -523,21 +533,33 @@ int main(int argc, char **argv)
 			continue;
 		}
 
+		if (show_breaks && !merge_order)
+			usage(rev_list_usage);
+
 		flags = 0;
+		dotdot = strstr(arg, "..");
+		if (dotdot) {
+			char *next = dotdot + 2;
+			struct commit *exclude = NULL;
+			struct commit *include = NULL;
+			*dotdot = 0;
+			exclude = get_commit_reference(arg, UNINTERESTING);
+			include = get_commit_reference(next, 0);
+			if (exclude && include) {
+				limited = 1;
+				handle_one_commit(exclude, &list);
+				handle_one_commit(include, &list);
+				continue;
+			}
+			*next = '.';
+		}
 		if (*arg == '^') {
 			flags = UNINTERESTING;
 			arg++;
 			limited = 1;
 		}
-		if (show_breaks && !merge_order)
-			usage(rev_list_usage);
 		commit = get_commit_reference(arg, flags);
-		if (!commit)
-			continue;
-		if (commit->object.flags & SEEN)
-			continue;
-		commit->object.flags |= SEEN;
-		commit_list_insert(commit, &list);
+		handle_one_commit(commit, &list);
 	}
 
 	if (!merge_order) {		
