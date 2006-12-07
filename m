X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Bug in merge-recursive in virtual commit corner case
Date: Thu, 07 Dec 2006 01:13:54 -0800
Message-ID: <7vmz60ukz1.fsf@assigned-by-dhcp.cox.net>
References: <20061207083531.GA22701@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 09:14:04 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061207083531.GA22701@spearce.org> (Shawn Pearce's message of
	"Thu, 7 Dec 2006 03:35:31 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33562>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsFKK-00066t-0A for gcvg-git@gmane.org; Thu, 07 Dec
 2006 10:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031881AbWLGJN4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 04:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031879AbWLGJN4
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 04:13:56 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:50283 "EHLO
 fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1031877AbWLGJNz (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 04:13:55 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061207091354.QZXP2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>; Thu, 7
 Dec 2006 04:13:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id vlDJ1V00B1kojtg0000000; Thu, 07 Dec 2006
 04:13:19 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> I found the above error message in tree-diff.c's diff_tree_sha1
> function.  I threw in debugging and found that the new tree was
> the root tree of one branch and the base was the root tree of some
> other revision.
>
> Apparently the empty tree is being created in merge-recursive.c:
>
>    1219     if (merged_common_ancestors == NULL) {
>    1220         /* if there is no common ancestor, make an empty tree */
>    1221         struct tree *tree = xcalloc(1, sizeof(struct tree));
>    1222
>    1223         tree->object.parsed = 1;
>    1224         tree->object.type = OBJ_TREE;
>    1225         hash_sha1_file(NULL, 0, tree_type, tree->object.sha1);
>    1226         merged_common_ancestors = make_virtual_commit(tree, "ancestor");
>    1227     }
>
> So basically this code crashes if its ever used in a repository
> that hasn't had a need for the empty tree before.  :-(

I hit the same issue when I integrated Johannes's in-core merge;
I originally used hash_sha1_file() but that results in objects
that are supposed to be in the virtual parent unreadable when
merging the real children.  The key is to use write_sha1_file()
to actually create the needed objects, and trust later prune to
remove them.

Replace it with write_sha1_file() and you should be fine, I
think.
