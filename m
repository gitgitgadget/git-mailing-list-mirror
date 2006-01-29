From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] rev-list: omit duplicated parents.
Date: Sun, 29 Jan 2006 15:30:02 -0800
Message-ID: <7vmzhehath.fsf_-_@assigned-by-dhcp.cox.net>
References: <43DC8DDF.6080904@yahoo.it>
	<7vmzhekcz3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Mon Jan 30 00:30:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3Lzo-0004t8-3r
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 00:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWA2XaI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 18:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWA2XaI
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 18:30:08 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:19652 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932077AbWA2XaH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2006 18:30:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060129232902.FPZW15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 Jan 2006 18:29:02 -0500
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <7vmzhekcz3.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 29 Jan 2006 12:15:12 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15248>

Showing the same parent more than once for a commit does not
make much sense downstream, so stop it.

This can happen with an incorrectly made merge commit that
merges the same parent twice, but can happen in an otherwise
sane development history while squishing the history by taking
into account only commits that touch specified paths.

For example,

	$ git rev-list --max-count=1 --parents addafaf -- rev-list.c

would have to show this commit ancestry graph:

                  .---o---.
                 /         \
                .---*---o---.
               /    93b74bc  \
   ---*---o---o-----o---o-----o addafaf
      d8f6b34  \             /
                .---o---o---.
                 \         /
                  .---*---.
                      3815f42

where 5 independent development tracks, only two of which have
changes in the specified paths since they forked.  The last
change for the other three development tracks was done by the
same commit before they forked, and we were showing that three
times.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

    Junio C Hamano <junkio@cox.net> writes:

    > I think it probably is a bug...
    > ...
    > Let me wait for a while to hear Linus contradicts me, though...

    I've considered doing this only when path is specified, but
    instead decided to do so for all commits.  I recall there
    are commits in the kernel archive created somehow with the
    same parent listed twice, and the downstream tools would
    have the same trouble if we didn't.

 rev-list.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

d6d9f494403a4e77d17244ece43005eec51200d3
diff --git a/rev-list.c b/rev-list.c
index 0b142c1..93ea41b 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -12,6 +12,7 @@
 #define COUNTED		(1u << 2)
 #define SHOWN		(1u << 3)
 #define TREECHANGE	(1u << 4)
+#define TMP_MARK	(1u << 5) /* for isolated cases; clean after use */
 
 static const char rev_list_usage[] =
 "git-rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
@@ -72,9 +73,21 @@ static void show_commit(struct commit *c
 	if (show_parents) {
 		struct commit_list *parents = commit->parents;
 		while (parents) {
-			printf(" %s", sha1_to_hex(parents->item->object.sha1));
+			struct object *o = &(parents->item->object);
 			parents = parents->next;
+			if (o->flags & TMP_MARK)
+				continue;
+			printf(" %s", sha1_to_hex(o->sha1));
+			o->flags |= TMP_MARK;
 		}
+		/* TMP_MARK is a general purpose flag that can
+		 * be used locally, but the user should clean
+		 * things up after it is done with them.
+		 */
+		for (parents = commit->parents;
+		     parents;
+		     parents = parents->next)
+			parents->item->object.flags &= ~TMP_MARK;
 	}
 	if (commit_format == CMIT_FMT_ONELINE)
 		putchar(' ');
-- 
1.1.5.g9843f
