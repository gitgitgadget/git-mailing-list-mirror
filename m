From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] send-pack: do not give up when remote has insanely large number of refs.
Date: Wed, 22 Feb 2006 01:51:12 -0800
Message-ID: <7v1wxvsovj.fsf_-_@assigned-by-dhcp.cox.net>
References: <1140547568.5509.21.camel@orbit.scot.redhat.com>
	<7vwtfotaq3.fsf@assigned-by-dhcp.cox.net>
	<7virr8t82n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 10:52:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBqfQ-0008Iy-Te
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 10:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbWBVJwO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 04:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbWBVJwO
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 04:52:14 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:28569 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932571AbWBVJwN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 04:52:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060222094748.BPTK17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Feb 2006 04:47:48 -0500
To: "Stephen C. Tweedie" <sct@redhat.com>
In-Reply-To: <7virr8t82n.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 21 Feb 2006 18:56:32 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16595>

Stephen C. Tweedie noticed that we give up running rev-list when
we see too many refs on the remote side.  Limit the number of
negative references we give to rev-list and continue.

Not sending any negative references to rev-list is very bad --
we may be pushing a ref that is new to the other end.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

  Junio C Hamano <junkio@cox.net> writes:

  > That is, something like this.
  > -- >8 --
  > Do not give up...

  Ah, crap.  Sorry about that.  This one has been tested at least.

 send-pack.c |   38 ++++++++++++++++++++++++++++----------
 1 files changed, 28 insertions(+), 10 deletions(-)

797656e58ddbd82ac461a5142ed726db3a4d0ac0
diff --git a/send-pack.c b/send-pack.c
index 990be3f..b58bbab 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -37,26 +37,44 @@ static void exec_pack_objects(void)
 
 static void exec_rev_list(struct ref *refs)
 {
+	struct ref *ref;
 	static char *args[1000];
-	int i = 0;
+	int i = 0, j;
 
 	args[i++] = "rev-list";	/* 0 */
 	args[i++] = "--objects";	/* 1 */
-	while (refs) {
-		char *buf = malloc(100);
-		if (i > 900)
+
+	/* First send the ones we care about most */
+	for (ref = refs; ref; ref = ref->next) {
+		if (900 < i)
 			die("git-rev-list environment overflow");
-		if (!is_zero_sha1(refs->old_sha1) &&
-		    has_sha1_file(refs->old_sha1)) {
+		if (!is_zero_sha1(ref->new_sha1)) {
+			char *buf = malloc(100);
 			args[i++] = buf;
-			snprintf(buf, 50, "^%s", sha1_to_hex(refs->old_sha1));
+			snprintf(buf, 50, "%s", sha1_to_hex(ref->new_sha1));
 			buf += 50;
+			if (!is_zero_sha1(ref->old_sha1) &&
+			    has_sha1_file(ref->old_sha1)) {
+				args[i++] = buf;
+				snprintf(buf, 50, "^%s",
+					 sha1_to_hex(ref->old_sha1));
+			}
 		}
-		if (!is_zero_sha1(refs->new_sha1)) {
+	}
+
+	/* Then a handful of the remainder
+	 * NEEDSWORK: we would be better off if used the newer ones first.
+	 */
+	for (ref = refs, j = i + 16;
+	     i < 900 && i < j && ref;
+	     ref = ref->next) {
+		if (is_zero_sha1(ref->new_sha1) &&
+		    !is_zero_sha1(ref->old_sha1) &&
+		    has_sha1_file(ref->old_sha1)) {
+			char *buf = malloc(42);
 			args[i++] = buf;
-			snprintf(buf, 50, "%s", sha1_to_hex(refs->new_sha1));
+			snprintf(buf, 42, "^%s", sha1_to_hex(ref->old_sha1));
 		}
-		refs = refs->next;
 	}
 	args[i] = NULL;
 	execv_git_cmd(args);
-- 
1.2.2.g882e
