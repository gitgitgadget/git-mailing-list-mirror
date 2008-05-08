From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: gitk and git-gui with --git-dir and GIT_DIR
Date: Thu, 8 May 2008 19:30:54 -0400
Message-ID: <20080508233054.GY29038@spearce.org>
References: <fvv3e4$i00$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Fri May 09 01:31:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuFaX-0007xa-7d
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 01:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753969AbYEHXa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 19:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753649AbYEHXa7
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 19:30:59 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47399 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518AbYEHXa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 19:30:57 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JuFZV-0006fo-Te; Thu, 08 May 2008 19:30:46 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A2CD220FBAE; Thu,  8 May 2008 19:30:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <fvv3e4$i00$1@ger.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81577>

Michael J Gruber <michaeljgruber+gmane@fastmail.fm> wrote:
> I want to track a tree where I should not store a ".git" dir. (You may 
> as well assume I don't have direct write access.) So, the ".git" dir is 
> somewhere else in the filesystem, actually named something like "repo.git".
...
> git-gui::
> For non-bare repos it expects git-dirs of the form "path/.git" and bails 
> out otherwise. Even when I rename my git dir to such a path things do 
> not work: all tracked files are reported missing. This happens even when 
> I call git-gui from the actual work tree, i.e. when git diff would work!
> It seems as if git-gui is CDing to "path" when git-dir is "path/.git", 
> no matter what $PWD, core.worktree or GIT_WORK_TREE say. I don't see why 
> this should be desired behaviour.

Oops.

git-gui assumes the working directory is at $GIT_DIR/.. because
earlier versions of git-gui created these "shortcut" things on
Windows that were actually just MS-DOS batch scripts to execute
git-gui in a specific directory.  It did that by basically doing
this:

  set GIT_DIR=/path/to/tree/.git
  git-gui

and when a user double-clicked the file in Windows Explorer the
directory we wanted to move to was taken from $GIT_DIR/.. and
that was that.

Another reason we had this oddity of the work tree being the parent
of the repository was due to a setting of GIT_DIR environment
variable in Tcl/Tk not carring down into a git Cygwin binary
on Windows.  It may just have been a bug in the Tcl/Tk or in the
Cygwin library at one point, I'm not sure, but I don't think we
are seeing it anymore.

Now apparently that poorly implemented feature is killing us in
this other case where we want to run with a GIT_DIR in one place
and a worktree in another.

There's actually a bunch of code in git-gui.sh to enforce this
stupid rule.  Maybe we can just delete it.  Hmm, no.  In the
current Windows shortcut code (which actually creates a proper
Windows shortcut file with an icon) we assume the directory we
want to start in is $GIT_DIR/.. again.  *sigh*

So its fixable, but its some level of effort to correct these
bad assumptions and/or stupid rules.


-- 
Shawn.
