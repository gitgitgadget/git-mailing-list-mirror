From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Thu, 7 Jul 2005 14:58:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507071456570.25104@g5.osdl.org>
References: <20050703234629.GF13848@pasky.ji.cz> <42CBC822.30701@didntduck.org>
 <20050707144501.GG19781@pasky.ji.cz> <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org> <7vbr5ejso2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 00:02:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqeRB-0003UT-NQ
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 00:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVGGWBB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 18:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVGGWA7
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 18:00:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7106 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261916AbVGGV7L (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2005 17:59:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j67LwwjA015814
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 7 Jul 2005 14:58:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j67LwvjT028069;
	Thu, 7 Jul 2005 14:58:57 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr5ejso2.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 7 Jul 2005, Junio C Hamano wrote:
> 
> (1) Would it make sense to have an extra flag to "rev-list
>     --objects" to make it list all the objects reachable from
>     commits listed in its output, even when some of them are
>     unchanged from UNINTERESTING commits?  Right now, a pack
>     produced from "rev-list --objects A ^B" does not have enough
>     information to reproduce the tree associated with commit A.

Well, that would certainly be possible. Just having a flag that disables 
"mark_tree_uninteresting()" would do it.

> (2) When "showing --objects", it lists the top-level tree node
>     with no name, which makes it indistinguishable from commit
>     objects by pack-objects, probably impacting the delta logic.
>     Would something like the following patch make sense, to name
>     such node "."; giving full-path not just the basename to
>     all named nodes would be even better, though.

It doesn't impact the delta algorithm, because the objects are sorted by 
type first, so it never mixes up trees and commits.

But if you wanted to, something like this would be cleaner than your 
suggestion..

		Linus

diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -154,7 +154,7 @@ static void show_commit_list(struct comm
 	while (list) {
 		struct commit *commit = pop_most_recent_commit(&list, SEEN);
 
-		p = process_tree(commit->tree, p, "");
+		p = process_tree(commit->tree, p, "tree");
 		if (process_commit(commit) == STOP)
 			break;
 	}
@@ -386,7 +386,7 @@ static struct commit *get_commit_referen
 			mark_tree_uninteresting(tree);
 			return NULL;
 		}
-		add_pending_object(object, "");
+		add_pending_object(object, "tree");
 		return NULL;
 	}
 
@@ -401,7 +401,7 @@ static struct commit *get_commit_referen
 			mark_blob_uninteresting(blob);
 			return NULL;
 		}
-		add_pending_object(object, "");
+		add_pending_object(object, "blob");
 		return NULL;
 	}
 	die("%s is unknown object", name);
