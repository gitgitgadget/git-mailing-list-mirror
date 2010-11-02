From: Paul Drews <paul.drews@intel.com>
Subject: Re: rebase not honoring core.worktree pointing elsewhere
Date: Tue, 2 Nov 2010 16:26:49 +0000 (UTC)
Message-ID: <loom.20101102T165800-486@post.gmane.org>
References: <loom.20101101T182113-378@post.gmane.org> <AANLkTi=ejRcnz+83zc2Z-6etUGMsBSw1FFUY0JNFRFGB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 02 17:27:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDJhX-0001rE-5e
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 17:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008Ab0KBQ1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 12:27:05 -0400
Received: from lo.gmane.org ([80.91.229.12]:38619 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094Ab0KBQ1D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 12:27:03 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PDJhN-0001lx-CQ
	for git@vger.kernel.org; Tue, 02 Nov 2010 17:27:01 +0100
Received: from jfdmzpr02-ext.jf.intel.com ([134.134.137.71])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 17:27:01 +0100
Received: from paul.drews by jfdmzpr02-ext.jf.intel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 17:27:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 134.134.137.71 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.3) Gecko/20100403 Fedora/3.6.3-4.fc13 Firefox/3.6.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160540>

Nguyen Thai Ngoc Duy <pclouds <at> gmail.com> writes:

> First of all, core.worktree should not matter because GIT_DIR has not
> been set (No don't trust core.worktree documentation, it's equivalent
> to --work-tree in "man git"). You need to set GIT_DIR (or --git-dir).
> That's a bug I'm working on.
> 
> Then, yes, rebase should be updated to use worktree even if it's
> outside cwd. I'm not sure how to do it properly in git-rebase.sh
> though.  The requirement "require_work_tree" can be loosen a bit.

Thanks,
I can confirm that the following works:

() have /abs/path/to/wheregitis/.git
() have /abs/path/to/wherefilesare
() export GIT_DIR=/abs/path/to/wheregitis/.git
() DO NOT have core.worktree (or related items) set
() cd /abs/path/to/wherefilesare
() git rebase master

This is a bit more dangerous than running git commands in GIT_DIR and pointing
core.worktree elsewhere, since I could make the error of (1) leaving GIT_DIR
unintentionally still set when doing something else, or (2) running git commands
outside the (unmarked) root of the worktree.  Still... it works.

BTW, the impetus for this is a big integrated cross-compilation build system
that has a nasty habit of deleting and re-creating a chroot environment
containing the directory structures including the work tree.  If the ".git"
dir is at the "normal" place "inside" the work tree, it gets deleted along
with all the work I have done.  Not good, which is why I want to keep the
".git" somewhere else that's safe.  Solutions to this:

(preferred) core.worktree pointing into worktree elsewhere, run all git
commands from GIT_DIR.  Would be great if rebase worked under these
circumstances.

(best fallback) no core.worktree, export GIT_DIR pointing elsewhere, run all
git commands from unmarked root of worktree.

(complex) A complex scenario pushing and pulling stuff between a git repo
inside the worktree and another git clone outside the worktree.

(implementation dependent) Having the ".git" dir inside the worktree be a
symbolic link to a dir somewhere outside the work tree.  Keeps the actual ".git"
contents safe from deletion.  Works so far, but this is Tampering With The
Implementation in a way that is likely to fail down the road somewhere,
e.g., if an internal script does cd to the GIT_DIR, then cd relative to
that to try to get back into somewhere else in the work tree.
