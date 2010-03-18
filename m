From: Andreas Gruenbacher <agruen@suse.de>
Subject: [PATCH 0/9] Multiple remotes without conflicts
Date: Thu, 18 Mar 2010 12:52:43 +0100
Message-ID: <cover.1268913163.git.agruen@suse.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 18 12:56:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsEKa-0002C7-TD
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 12:56:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842Ab0CRLz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 07:55:27 -0400
Received: from cantor2.suse.de ([195.135.220.15]:50439 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648Ab0CRLz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 07:55:26 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 6CF8A86EE4
	for <git@vger.kernel.org>; Thu, 18 Mar 2010 12:55:25 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142459>

Hello,

I'm still trying to find a simple and painless way of sharing the object
store among multiple repositories: the idea is to have a "parent"
repository which contains the actual object store, and a number of
"child" repositories which link to that object store.  The obvious
problem is garbage collection: we can only garbage collect the parent
once it has all refs of all its children.

One way of ensuring that is to make each child a "remote" of the parent,
and to fetch all remotes first.  This works for branches, but not for
tags or for the reflog.

The problem with tags is that they all share the same namespace (they
are fetched with +refs/tags/*:refs/tags/*).  The obvious fix seems to be
to use a different refspec for tags, but with the built-in default
refspec, tags are then fetched twice (for example, with
+refs/*:refs/remotes/<remote>/*, refs/tags/foo is fetched as
refs/remotes/<remote>/tags/foo as well as refs/tags/foo).  Also, when
tags are included in refspecs, automatic tag fetching and the --tags and
--no-tags options break.

This patch series fixes this, and makes refspecs which match tags work
in a reasonable way.  (There may be problems with pruning still; I did
not look into that, yet.)

The other issue is that the "parent" won't know about things
referenced in the child's reflog.  This is not an issue for the setup I
have in mind because the children won't have reflogs (they will only be
accessed remotely), so I have not addressed this so far.

Here is an example for setting up a shared object store:

	TOP=$PWD
	mkdir ab a b

	cd $TOP/ab
	git init --bare
	for x in a b; do
		git remote add $x ../$x
		git config --unset remote.$x.fetch
		git config --add remote.$x.fetch "+refs/*:refs/remotes/$x/*"
	done

	for x in a b; do
		cd $TOP/$x
		git init
		git config gc.auto 0
		rm -r .git/objects
		ln -s ../../ab/objects .git/objects
	done

Comments welcome!

Thanks,
Andreas

---

Andreas Gruenbacher (9):
  fetch: Check for a "^{}" suffix with suffixcmp()
  fetch: Properly initialize refspec on stack
  fetch: Fix minor memory leak
  fetch: Move deepening fetch check into builtin/fetch.c
  fetch: Move loop checking which refs we have already
  fetch: Check if all objects exist after fetching
  fetch: Use the same ref map for all branches and tags
  fetch: Don't fetch tags twice
  fetch: Make automatic tag following work with arbitrary refspecs

 builtin/fetch.c |  430 ++++++++++++++++++++++++++++++++-----------------------
 cache.h         |    4 +-
 transport.c     |   38 ++----
 3 files changed, 264 insertions(+), 208 deletions(-)
