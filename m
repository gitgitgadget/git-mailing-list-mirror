From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] send-pack: reword non-fast-forward error message.
Date: Thu, 22 Dec 2005 12:41:16 -0800
Message-ID: <7vu0d0j24z.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0512220048360.13453@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vd5jqvsn1.fsf@assigned-by-dhcp.cox.net> <43AA79EB.6040800@op5.se>
	<7vek45lyor.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 22 21:41:28 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpXFZ-0001ld-CX
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 21:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbVLVUlS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 15:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965190AbVLVUlS
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 15:41:18 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:25772 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S965185AbVLVUlS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 15:41:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051222203937.WTSP26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Dec 2005 15:39:37 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <7vek45lyor.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 22 Dec 2005 11:27:32 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13968>

Junio C Hamano <junkio@cox.net> writes:

> Andreas Ericsson <ae@op5.se> writes:
>
>> Junio C Hamano wrote:
>>> In a sense, both are "pull first?" situation, and it probably is
>>> more confusing to give different messages to the user in these
>>> two cases.  From the end-user point of view they are the same
>>> "remote is not strict subset.".
>>
>> In non-git'ish, does this mean "you're not up to date, so pull before 
>> pushing" ? If so, why not say so? I'm sure it could prevent a fair few 
>> problems for users (not least those new to scm's).

That is reasonable.  How about this?

-- >8 --
Wnen refusing to push a head, we said cryptic "remote 'branch'
object X does not exist on local" or "remote ref 'branch' is not
a strict subset of local ref 'branch'".  That was gittish.

Since the most likely reason this happens is because the pushed
head was not up-to-date, clarify the error message to say that
straight, and suggest pulling first.

First noticed by Johannes and seconded by Andreas.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 send-pack.c |   30 ++++++++++++++----------------
 1 files changed, 14 insertions(+), 16 deletions(-)

69310a34cb6dcca32b08cf3ea9e91ab19354a874
diff --git a/send-pack.c b/send-pack.c
index 5bc2f01..0d41f9a 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -231,23 +231,21 @@ static int send_pack(int in, int out, in
 		if (!force_update &&
 		    !is_zero_sha1(ref->old_sha1) &&
 		    !ref->force) {
-			if (!has_sha1_file(ref->old_sha1)) {
-				error("remote '%s' object %s does not "
-				      "exist on local",
-				      ref->name, sha1_to_hex(ref->old_sha1));
-				ret = -2;
-				continue;
-			}
-
-			/* We assume that local is fsck-clean.  Otherwise
-			 * you _could_ have an old tag which points at
-			 * something you do not have, which may or may not
-			 * be a commit.
-			 */
-			if (!ref_newer(ref->peer_ref->new_sha1,
+			if (!has_sha1_file(ref->old_sha1) ||
+			    !ref_newer(ref->peer_ref->new_sha1,
 				       ref->old_sha1)) {
-				error("remote ref '%s' is not a strict "
-				      "subset of local ref '%s'.", ref->name,
+				/* We do not have the remote ref, or
+				 * we know that the remote ref is not
+				 * an ancestor of what we are trying to
+				 * push.  Either way this can be losing
+				 * commits at the remote end and likely
+				 * we were not up to date to begin with.
+				 */
+				error("remote '%s' is not a strict "
+				      "subset of local ref '%s'. "
+				      "maybe you are not up-to-date and "
+				      "need to pull first?",
+				      ref->name,
 				      ref->peer_ref->name);
 				ret = -2;
 				continue;
-- 
1.0.GIT
