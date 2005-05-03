From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] fsck-cache segfaults on a tag referring to a missing
 object.
Date: Tue, 03 May 2005 01:28:11 -0700
Message-ID: <7vzmvcww6c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 10:22:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSsfX-0000lu-JR
	for gcvg-git@gmane.org; Tue, 03 May 2005 10:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVECI2T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 04:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVECI2T
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 04:28:19 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:50367 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261423AbVECI2O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 04:28:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050503082811.EXIH16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 3 May 2005 04:28:11 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I do not understand the comment about ignoring tag reachability
in check_connectivity(), but fsck_tag() fails to notice that a
parsing of tag may have failed in the parse_object() call in
fsck_sha1() before it is called, in which case it can get a tag
object with NULL in the tagged field and segfault.  Here is a
patch to fix this.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

P.S. Since this is probably more urgent than other fixes I've
been bugging you about, I am sending this via e-mail, not as a
GIT pull request, but I have a couple more update there, along
with updated HEAD.

--- a/fsck-cache.c
+++ b/fsck-cache.c
@@ -136,6 +136,12 @@ static int fsck_tag(struct tag *tag)
 	if (!show_tags)
 		return 0;
 
+	if (!tag->tagged) {
+		printf("bad referenced object in tag %s\n",
+		       sha1_to_hex(tag->object.sha1));
+		return 0;
+	}
+
 	printf("tagged %s %s",
 	       tag->tagged->type,
 	       sha1_to_hex(tag->tagged->sha1));


----------------------------------------------------------------

