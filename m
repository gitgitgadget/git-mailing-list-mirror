From: Junio C Hamano <junkio@cox.net>
Subject: Re: Add "git-update-ref" to update the HEAD (or other) ref
Date: Sun, 25 Sep 2005 16:27:44 -0700
Message-ID: <7vhdc8n2xb.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0509251134480.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Mon Sep 26 01:28:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJfuW-0000o1-Dj
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 01:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbVIYX1t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 19:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbVIYX1t
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 19:27:49 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:29950 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751553AbVIYX1s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2005 19:27:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050925232746.PKZ29747.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 25 Sep 2005 19:27:46 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509251134480.3308@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 25 Sep 2005 11:43:05 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9293>

Linus Torvalds <torvalds@osdl.org> writes:

> +	 * FIXME!

Is something like the one at the end acceptable?

I'd like to take these patches in two stages (I am not asking
you for a resend):

 - Drop the emulated symlink part from the update-ref.c; have it
   graduate to "master" branch and use it in existing scripts.

 - Take the read_ref() change, along with a patch to re-add the
   emulated symlink part to update-ref.c (after making its
   interpretation to match that of read_ref() -- which requires
   the prefix to be exactly "ref: " five bytes); keep it in "pu"
   branch a bit longer.


---
diff --git a/update-ref.c b/update-ref.c
--- a/update-ref.c
+++ b/update-ref.c
@@ -97,11 +97,13 @@ int main(int argc, char **argv)
 	}
 
 	/*
-	 * FIXME!
-	 *
-	 * We should re-read the old ref here, and re-verify that it
+	 * We re-read the old ref here, and re-verify that it
 	 * matches "oldsha1". Otherwise there's a small race.
 	 */
+	if (!resolve_ref(git_path("%s", refname), oldsha1))
+		die("Cannot verify ref: %s", refname); 
+	if (memcmp(oldsha1, currsha1, 20))
+		die("Ref %s changed to %s", refname, sha1_to_hex(oldsha1));
 
 	if (rename(lockpath, path) < 0) {
 		unlink(lockpath);
