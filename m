From: Junio C Hamano <junkio@cox.net>
Subject: Reworked read-tree.
Date: Thu, 01 Sep 2005 00:10:43 -0700
Message-ID: <7vpsrt1cwc.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0509010009350.23242@iabervon.org>
	<7vll2h4bc8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0509010138370.23242@iabervon.org>
	<7vvf1l1env.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 01 09:11:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAjDl-0004YA-H8
	for gcvg-git@gmane.org; Thu, 01 Sep 2005 09:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbVIAHKq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Sep 2005 03:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbVIAHKq
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Sep 2005 03:10:46 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:46051 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932548AbVIAHKp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2005 03:10:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050901071045.DUNM3588.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Sep 2005 03:10:45 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <7vvf1l1env.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 31 Aug 2005 23:32:36 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7994>

Daniel, I do not know what your current status is, but I think
you need something like this.

I was scratching my head figuring out why it passes all the t/
tests but couldn't do a simple 'git-read-tree HEAD'.

---
diff --git a/tree.c b/tree.c
--- a/tree.c
+++ b/tree.c
@@ -224,10 +224,12 @@ struct tree *parse_tree_indirect(const u
 		if (obj->type == tree_type)
 			return (struct tree *) obj;
 		else if (obj->type == commit_type)
-			return ((struct commit *) obj)->tree;
+			obj = (struct object *)(((struct commit *) obj)->tree);
 		else if (obj->type == tag_type)
-			obj = ((struct tag *) obj)->tagged;
+			obj = deref_tag(obj);
 		else
 			return NULL;
+		if (!obj->parsed)
+			parse_object(obj->sha1);
 	} while (1);
 }
