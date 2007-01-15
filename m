From: Yann Dirson <ydirson@altern.org>
Subject: Rebasing stgit stacks
Date: Mon, 15 Jan 2007 21:24:12 +0100
Message-ID: <20070115202412.GE9761@nan92-1-81-57-214-146.fbx.proxad.net>
References: <8b65902a0701091335u160c6dfl81a523e4cd5adbee@mail.gmail.com> <8b65902a0701091341v5983c113tc5cd32c6c4c57719@mail.gmail.com> <20070109224125.GF17093@nan92-1-81-57-214-146.fbx.proxad.net> <8b65902a0701150526j5a954529xf45b2d0348a77573@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 15 21:50:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6YNa-0000pO-4A
	for gcvg-git@gmane.org; Mon, 15 Jan 2007 21:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbXAOUY1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 15:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbXAOUY1
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 15:24:27 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:43554 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751462AbXAOUY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 15:24:26 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 0DE94554EC;
	Mon, 15 Jan 2007 21:24:21 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 5F3D51F03A; Mon, 15 Jan 2007 21:24:12 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <8b65902a0701150526j5a954529xf45b2d0348a77573@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36880>

On Mon, Jan 15, 2007 at 02:26:36PM +0100, Guilhem Bonnefille wrote:
> >What you should have done is moving your stack base from your old
> >origin branch to remotes/trunk - something that StGIT does not support
> >yet from command-line, but I've done this manually in the past
> >(migrating an StGIT stack after re-running a full git-cvsimport after
> >the original cvs branch got corrupted).

I have started work on implementing "stg pull --to <newbase>", but I'm
facing some issues.

 "stg pull", after popping all patches, currently calls "git pull",
 which indeed has 2 roles:

- running "git fetch" on the parent branch
- updating the head of the stack (which matches the base since
  no patch is applied), by relying on git-pull to fast-forward the
  stack head

The latter is, unless I miss something:

- overkill when what we want is just to move the head to another place

- problematic when the parent branch is one that would be tracker with
"+" in the remote pull line (eg. "next", "pu", or an stgit stack).  In
that case, although "git fetch" refuses to update the parent head
because it would not be a fast-forward, git-pull then attempt to do a
merge, which completely breaks expectations.

What my implementation of "pull --to" does is just moving the head
with the following code added to git.py:

def move_branch(tree_id):
    """Move HEAD to another commit
    """
    __set_head(tree_id)
    switch(tree_id)

    if os.path.isfile(os.path.join(basedir.get(), 'MERGE_HEAD')):
        os.remove(os.path.join(basedir.get(), 'MERGE_HEAD'))


That only partly works - that is, it works if I add the expected "+"
in the remote refspec line (or if I add an explicit refspec on
command-line).  There is surely a way for "stg clone" to detect the
parent is an stgit stack, and we can possibly have the clone operation
setup things right from the start.  I remember someone suggesting that
such branches advertise their status so git-clone itself would add
this - not sure this is planned for 1.5.0, though.

Even when this fully works, I'm reluctant to leave things that way,
because would be easy to forget the --to, and get a broken stack, with
"stg diff" being confused enough to happily show this:

|bar$ stg diff; echo $?
|* Unmerged path file
|0


I would be of the opinion to stop calling "git pull" entirely, and use
"git fetch and the git.move_branch show above.  Unless I hear about
better ideas, my next patch set will be along those lines.

Best regards,
-- 
Yann.
