X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: "stgit clean" has problems with removed generated files
Date: Thu, 23 Nov 2006 17:11:35 +0100
Message-ID: <20061123161135.GK5443@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 23 Nov 2006 16:12:53 +0000 (UTC)
Cc: GIT list <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32145>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnHBh-0007t5-6Q for gcvg-git@gmane.org; Thu, 23 Nov
 2006 17:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756194AbWKWQM3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 11:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757399AbWKWQM3
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 11:12:29 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:29057 "EHLO
 smtp1-g19.free.fr") by vger.kernel.org with ESMTP id S1756194AbWKWQM3 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 11:12:29 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp1-g19.free.fr (Postfix) with ESMTP id B85409B596;
 Thu, 23 Nov 2006 17:12:25 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000) id 6E7981F066;
 Thu, 23 Nov 2006 17:11:35 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

I recently encountered a problem with "stgit clean", but it really is a
generic issue, which can also impact other subcommands.

In a kernel tree, the precise problem I had is due to generated files
committed by error in an upstream branch (a BSP from a well-known
vendor, indeed ;).  The first patch in my stgir stack does some cleanup
by removing them from git control (so that "make dep" does not cause
them to change every so often).

Now when I want to run "stg clean" for applied patches, stgit first
wants to pop the whole stack, including that patch, which triggers the
following error:

fatal: Untracked working tree file 'include/asm-arm/constants.h' would be                                                                                                              overwritten by merge.                                                                                                                                                                  stg clean: git-read-tree failed (local changes maybe?)                                                                                                                                 


Obviously, removing all such files by hand allows to run "stg clean", as
does (floating and) popping that patch and deleting it, or running "stg clean
--unappplied".  The 1st approach is intrusive, and forces the user to
rerun "make dep", which is not very friendy; the 2nd one is too error-prone for
an operation that ought to be risk-less (delete has no --undo).  The 3rd option
is probably the best, but is surely not so intuitive.

The root issue seems to be that stgit has problem with such generated
files, ie., files that were removed from version-control, but can still
legitimately exist in the tree.  Dealing with them could possibly be
done (eg. allowing to back them up, and restore them when pushing the
annoying patch), but is not a trivial issue (eg. we still need to guard
the user against real conflicts).

At least we could put a notice about this case in the doc, so users
don't get too surprised.


I could think of several (non-exclusive) possibilities to deal with the
precise problem I got, which should allow.

First, when cleaning patches, we could first look up which patches are
to be removed, and only pop the necessary ones.

Second, we could generalize the "clean" subcommand to accept arbitrary
ranges, not only the "applied" and "unapplied" ones.  A special case
would be "stg clean that-patch", which would be a secure version of "stg
delete".

BTW, maybe it would those make sense to allowthose special ranges in
most places a range is valid.


Best regards,
-- 
