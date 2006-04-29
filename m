From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH/RFC] Extended SHA1 -- "rev^#" syntax to mean "all parents"
Date: Sat, 29 Apr 2006 02:45:24 -0700
Message-ID: <7vaca490ln.fsf@assigned-by-dhcp.cox.net>
References: <7virosalxb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Apr 29 11:45:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZm1B-0007xg-33
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 11:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWD2Jp0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Apr 2006 05:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbWD2Jp0
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 05:45:26 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:5567 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750832AbWD2JpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Apr 2006 05:45:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060429094525.ZRYS18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 29 Apr 2006 05:45:25 -0400
To: git@vger.kernel.org
In-Reply-To: <7virosalxb.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 29 Apr 2006 00:19:28 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19299>

A short-hand "rev^#" is understood to be "all parents of the
named commit" with this patch.  So you can do

	git show v1.0.0^#

to view the parents of a merge commit,

	gitk ^v1.0.0^# v1.0.4

to view the log between two revs (including the bottom one), and

	git diff --cc v1.1.0 v1.0.0^#

to inspect what got changed from the merge parents of v1.0.0 to v1.1.0.

This might be just my shiny new toy that is not very useful in
practice.  I needed it to do the multi-tree diff on Len's
infamous 12-way Octopus; typing "diff --cc funmerge funmerge^1
funmerge^2 funmerge^3 ..." was too painful.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 revision.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index f2a9f25..194f35b 100644
--- a/revision.c
+++ b/revision.c
@@ -477,6 +477,36 @@ static void handle_all(struct rev_info *
 	for_each_ref(handle_one_ref);
 }
 
+static int add_parents_only(struct rev_info *revs, const char *arg, int flags)
+{
+	unsigned char sha1[20];
+	struct object *it;
+	struct commit *commit;
+	struct commit_list *parents;
+
+	if (*arg == '^') {
+		flags ^= UNINTERESTING;
+		arg++;
+	}
+	if (get_sha1(arg, sha1))
+		return 0;
+	while (1) {
+		it = get_reference(revs, arg, sha1, 0);
+		if (strcmp(it->type, tag_type))
+			break;
+		memcpy(sha1, ((struct tag*)it)->tagged->sha1, 20);
+	}
+	if (strcmp(it->type, commit_type))
+		return 0;
+	commit = (struct commit *)it;
+	for (parents = commit->parents; parents; parents = parents->next) {
+		it = &parents->item->object;
+		it->flags |= flags;
+		add_pending_object(revs, it, arg);
+	}
+	return 1;
+}
+
 void init_revisions(struct rev_info *revs)
 {
 	memset(revs, 0, sizeof(*revs));
@@ -746,6 +776,13 @@ int setup_revisions(int argc, const char
 			}
 			*dotdot = '.';
 		}
+		dotdot = strstr(arg, "^#");
+		if (dotdot && !dotdot[2]) {
+			*dotdot = 0;
+			if (add_parents_only(revs, arg, flags))
+				continue;
+			*dotdot = '^';
+		}
 		local_flags = 0;
 		if (*arg == '^') {
 			local_flags = UNINTERESTING;
-- 
1.3.1.ga0c5
