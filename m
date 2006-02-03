From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] get_sha1_1: allow octopus^12 to be properly parsed.
Date: Thu, 02 Feb 2006 23:48:36 -0800
Message-ID: <7virrwj31n.fsf_-_@assigned-by-dhcp.cox.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005EFE7FF@hdsmsx401.amr.corp.intel.com>
	<Pine.LNX.4.64.0602022139190.3462@g5.osdl.org>
	<7vbqxpj6qs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux@horizon.com
X-From: git-owner@vger.kernel.org Fri Feb 03 08:48:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4vgP-0004qX-UX
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 08:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWBCHsj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 02:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWBCHsj
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 02:48:39 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:17370 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932293AbWBCHsi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2006 02:48:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060203074624.IBYD17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Feb 2006 02:46:24 -0500
To: git@vger.kernel.org
In-Reply-To: <7vbqxpj6qs.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 02 Feb 2006 22:28:43 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15533>

We probably thought anybody who does more than 9 parents in an
Octopus is insane when this was initially done, but there is no
inherent reason to limit the number of independent topic
branches that happen to mature at the same time.

Our commit-tree allows up to 16 already, so at least we should
prepare to handle what we can produce, if only to be consistent.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Junio C Hamano <junkio@cox.net> writes:

 > That reminds me of another practical limit I've known but did
 > nothing about for quite some time (you may not even remember
 > doing that parser anymore).  This does not work for Len's merge:
 >
 > 	$ git rev-parse --verify funmerge^10
 >
 > You could do a 16-way merge but 12-way is already hitting
 > usability limit, depending on what you would want to do with
 > them.  For example, you cannot easily decompose the topic
 > branches out of that merge, like this:
 >
 > 	$ git checkout -b redo-3549 funmerge^2     ;# works
 >       $ git checkout -b redo-pnpacpi funmerge^12 ;# doesn't

 sha1_name.c |   39 ++++++++++++++++-----------------------
 1 files changed, 16 insertions(+), 23 deletions(-)

6c7e009d38da459545bd2eed63e7624f81cea90f
diff --git a/sha1_name.c b/sha1_name.c
index ba0747c..fa85d8a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -388,43 +388,36 @@ static int peel_onion(const char *name, 
 
 static int get_sha1_1(const char *name, int len, unsigned char *sha1)
 {
-	int parent, ret;
+	int ret, has_suffix;
 	const char *cp;
 
-	/* foo^[0-9] or foo^ (== foo^1); we do not do more than 9 parents. */
-	if (len > 2 && name[len-2] == '^' &&
-	    name[len-1] >= '0' && name[len-1] <= '9') {
-		parent = name[len-1] - '0';
-		len -= 2;
-	}
-	else if (len > 1 && name[len-1] == '^') {
-		parent = 1;
-		len--;
-	} else
-		parent = -1;
-
-	if (parent >= 0)
-		return get_parent(name, len, sha1, parent);
-
 	/* "name~3" is "name^^^",
-	 * "name~12" is "name^^^^^^^^^^^^", and
 	 * "name~" and "name~0" are name -- not "name^0"!
+	 * "name^" is not "name^0"; it is "name^1".
 	 */
-	parent = 0;
+	has_suffix = 0;
 	for (cp = name + len - 1; name <= cp; cp--) {
 		int ch = *cp;
 		if ('0' <= ch && ch <= '9')
 			continue;
-		if (ch != '~')
-			parent = -1;
+		if (ch == '~' || ch == '^')
+			has_suffix = ch;
 		break;
 	}
-	if (!parent && *cp == '~') {
+
+	if (has_suffix) {
+		int num = 0;
 		int len1 = cp - name;
 		cp++;
 		while (cp < name + len)
-			parent = parent * 10 + *cp++ - '0';
-		return get_nth_ancestor(name, len1, sha1, parent);
+			num = num * 10 + *cp++ - '0';
+		if (has_suffix == '^') {
+			if (!num && len1 == len - 1)
+				num = 1;
+			return get_parent(name, len1, sha1, num);
+		}
+		/* else if (has_suffix == '~') -- goes without saying */
+		return get_nth_ancestor(name, len1, sha1, num);
 	}
 
 	ret = peel_onion(name, len, sha1);
-- 
1.1.6.gb1a9
