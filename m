From: Junio C Hamano <junkio@cox.net>
Subject: Re: Pure renames/copies
Date: Mon, 21 Nov 2005 11:50:07 -0800
Message-ID: <7vacfxrdao.fsf@assigned-by-dhcp.cox.net>
References: <87hda61a80.fsf@gmail.com>
	<Pine.LNX.4.64.0511211020130.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 20:51:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeHg7-0005Zb-Qe
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 20:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbVKUTuL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 14:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbVKUTuK
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 14:50:10 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:28055 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932428AbVKUTuI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 14:50:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051121194927.LOOJ20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 21 Nov 2005 14:49:27 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12474>

Linus Torvalds <torvalds@osdl.org> writes:

> Of course, arguably "-M100" should really do this optimization for you. 
> Junio?

Probably something like this would suffice.

-- >8 --
Subject: rename detection with -M100 means "exact renames only".

When the user is interested in pure renames, there is no point
doing the similarity scores.  This changes the score argument
parsing to special case -M100 (otherwise, it is a precision
scaled value 0 <= v < 1 and would mean 0.1, not 1.0 --- if you
do mean 0.1, you can say -M1), and optimizes the diffcore_rename
transformation to only look at pure renames in that case.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

diff --git a/diff.c b/diff.c
index 0391e8c..0f839c1 100644
--- a/diff.c
+++ b/diff.c
@@ -853,6 +853,10 @@ static int parse_num(const char **cp_p)
 	}
 	*cp_p = cp;
 
+	/* special case: -M100 would mean 1.0 not 0.1 */
+	if (num == 100 && scale == 1000)
+		return MAX_SCORE;
+
 	/* user says num divided by scale and we say internally that
 	 * is MAX_SCORE * num / scale.
 	 */
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 6a9d95d..dba965c 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -307,6 +307,9 @@ void diffcore_rename(struct diff_options
 	if (rename_count == rename_dst_nr)
 		goto cleanup;
 
+	if (minimum_score == MAX_SCORE)
+		goto cleanup;
+
 	num_create = (rename_dst_nr - rename_count);
 	num_src = rename_src_nr;
 	mx = xmalloc(sizeof(*mx) * num_create * num_src);
