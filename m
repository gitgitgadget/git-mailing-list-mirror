X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Bug in merge-recursive in virtual commit corner case
Date: Thu, 7 Dec 2006 03:35:31 -0500
Message-ID: <20061207083531.GA22701@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 08:35:51 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33559>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsEjI-0002Al-5f for gcvg-git@gmane.org; Thu, 07 Dec
 2006 09:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031847AbWLGIfg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 03:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031855AbWLGIfg
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 03:35:36 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58660 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1031847AbWLGIff (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 03:35:35 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GsEj6-0003TT-KF for git@vger.kernel.org; Thu, 07 Dec 2006 03:35:32 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 C197620FB6E; Thu,  7 Dec 2006 03:35:31 -0500 (EST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

So I managed to create a fairly complex set of branches which are all
merged back against each other at various points in time.  Two of
them have 3 merge bases according to git-merge-base.  Tonight I
tried to merge them together, but received the following wonderful
error from git-merge-recursive:

  fatal: unable to read source tree (4b825dc642cb6eb9a060e54bf8d69288fbee4904)

For those in the know, that's the empty tree.  This particular
repository does not have the empty tree anywhere in it, which is
why we can't read the object: it doesn't exist, and shouldn't exist.

Running `git-mktree </dev/null` to create the empty tree worked;
git-merge-recursive ran through and cleanly merged the two branches.
But the empty tree still shouldn't be in my repository, so a future
git-prune is just going to whack it again.  Yes, I know, I could
anchor it with a ref (.git/refs/empty-tree) but I shouldn't need
to use git-mktree and git-update-ref just to use git-merge-recursive.

I found the above error message in tree-diff.c's diff_tree_sha1
function.  I threw in debugging and found that the new tree was
the root tree of one branch and the base was the root tree of some
other revision.

Apparently the empty tree is being created in merge-recursive.c:

   1219     if (merged_common_ancestors == NULL) {
   1220         /* if there is no common ancestor, make an empty tree */
   1221         struct tree *tree = xcalloc(1, sizeof(struct tree));
   1222
   1223         tree->object.parsed = 1;
   1224         tree->object.type = OBJ_TREE;
   1225         hash_sha1_file(NULL, 0, tree_type, tree->object.sha1);
   1226         merged_common_ancestors = make_virtual_commit(tree, "ancestor");
   1227     }

So basically this code crashes if its ever used in a repository
that hasn't had a need for the empty tree before.  :-(

I've been unable to create an isolated test case.  I can't publish
the repository that I caused the case in either.

I'm not quite sure what the fix should be here: patch diff_tree_sha1
to know when it gets the empty tree, or create the object in
merge-recursive.c?

-- 
