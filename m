From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/6] lock_ref_sha1(): check D/F conflict with packed ref when creating.
Date: Sat, 30 Sep 2006 15:30:43 -0700
Message-ID: <7vfye99ecs.fsf@assigned-by-dhcp.cox.net>
References: <20060930220158.d331bb7c.chriscool@tuxfamily.org>
	<7vmz8hccxl.fsf@assigned-by-dhcp.cox.net>
	<7v1wptc7ou.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Oct 01 00:31:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTnMX-00031M-9K
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 00:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbWI3Was (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Sep 2006 18:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWI3Was
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 18:30:48 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:30105 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751523AbWI3War (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Sep 2006 18:30:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060930223046.HBDU12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Sat, 30 Sep 2006 18:30:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UmWm1V00W1kojtg0000000
	Sat, 30 Sep 2006 18:30:49 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28158>

This makes the ref locking codepath to notice if an existing ref
overlaps with the ref we are creating.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 refs.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index 157de43..2bfa92a 100644
--- a/refs.c
+++ b/refs.c
@@ -588,6 +588,30 @@ static struct ref_lock *lock_ref_sha1_ba
 			orig_ref, strerror(errno));
 		goto error_return;
 	}
+	if (is_null_sha1(lock->old_sha1)) {
+		/* The ref did not exist and we are creating it.
+		 * Make sure there is no existing ref that is packed
+		 * whose name begins with our refname, nor a ref whose
+		 * name is a proper prefix of our refname.
+		 */
+		int namlen = strlen(ref); /* e.g. 'foo/bar' */
+		struct ref_list *list = get_packed_refs();
+		while (list) {
+			/* list->name could be 'foo' or 'foo/bar/baz' */
+			int len = strlen(list->name);
+			int cmplen = (namlen < len) ? namlen : len;
+			const char *lead = (namlen < len) ? list->name : ref;
+
+			if (!strncmp(ref, list->name, cmplen) &&
+			    lead[cmplen] == '/') {
+				error("'%s' exists; cannot create '%s'",
+				      list->name, ref);
+				goto error_return;
+			}
+			list = list->next;
+		}
+	}
+
 	lock->lk = xcalloc(1, sizeof(struct lock_file));
 
 	lock->ref_name = xstrdup(ref);
-- 
1.4.2.1.g5a98f
