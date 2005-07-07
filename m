From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Thu, 07 Jul 2005 12:57:17 -0700
Message-ID: <7vbr5ejso2.fsf@assigned-by-dhcp.cox.net>
References: <20050703234629.GF13848@pasky.ji.cz>
	<42CBC822.30701@didntduck.org> <20050707144501.GG19781@pasky.ji.cz>
	<7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071158220.3293@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 07 22:02:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqcZL-0002uU-8z
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 22:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbVGGUBM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 16:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVGGT6r
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 15:58:47 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:21978 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262289AbVGGT50 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2005 15:57:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050707195719.VVDL18672.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 7 Jul 2005 15:57:19 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org> (Linus Torvalds's message of "Thu, 7 Jul 2005 12:04:58 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I have two questions on "rev-list --objects".

(1) Would it make sense to have an extra flag to "rev-list
    --objects" to make it list all the objects reachable from
    commits listed in its output, even when some of them are
    unchanged from UNINTERESTING commits?  Right now, a pack
    produced from "rev-list --objects A ^B" does not have enough
    information to reproduce the tree associated with commit A.

(2) When "showing --objects", it lists the top-level tree node
    with no name, which makes it indistinguishable from commit
    objects by pack-objects, probably impacting the delta logic.
    Would something like the following patch make sense, to name
    such node "."; giving full-path not just the basename to
    all named nodes would be even better, though.

---
# - master: git-format-patch: Prepare patches for e-mail submission.
# + (working tree)
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -179,7 +179,10 @@ static void show_commit_list(struct comm
 		die("unknown pending object %s (%s)", sha1_to_hex(obj->sha1), name);
 	}
 	while (objects) {
-		printf("%s %s\n", sha1_to_hex(objects->item->sha1), objects->name);
+		const char *name = objects->name;
+		if (!*name && objects->item->type == tree_type)
+			name = ".";
+		printf("%s %s\n", sha1_to_hex(objects->item->sha1), name);
 		objects = objects->next;
 	}
 }
