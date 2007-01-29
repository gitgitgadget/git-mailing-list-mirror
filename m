From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: More precise tag following
Date: Mon, 29 Jan 2007 05:31:37 -0500
Message-ID: <20070129103137.GA1500@spearce.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org> <Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org> <7vzm84gmei.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org> <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net> <20070129061807.GA4634@spearce.org> <7v8xfm87cz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jan 29 11:32:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBTo5-00081T-08
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 11:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506AbXA2Kby (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 05:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752500AbXA2Kbx
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 05:31:53 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58697 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbXA2Kbo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 05:31:44 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HBTmq-0005rd-79; Mon, 29 Jan 2007 05:30:56 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 13F0120FBAE; Mon, 29 Jan 2007 05:31:38 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v8xfm87cz.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38073>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > If you are curious its been pushed to repo.or.cz:
> >
> >   git://repo.or.cz/git-gui.git
> 
> I think it is not a big deal for git-gui which is for active
> developers and not primarily for archaeologists, but it does not
> seem to like to be invoked inside a bare repository.

Yes.  git-gui does some bad things.  On Mac OS X and Windows
it lets you setup a "shortcut".  This bastard thing is a batch
file/script which basically sets the GIT_DIR environment variable,
then starts git-gui.  So it assumes that the GIT_DIR its getting
is somehow connected to a working directory of sorts.

I actually have plans to cleanup some of git-gui's internals so that
its easier to specify what it can do, and cannot do, during startup,
then configure the UI from that.  For example, one should not be
allowed to commit in a bare repository, or merge, but fetch and
push are still OK.  So is browsing, creating and deleting branches.
Or editing options (.git/config).

I think the cleanup is easier than it sounds; a lot of the UI is
already parameterized based on [appname], which is 'git-gui' or
'git-citool', depending on the name it was invoked as.  This just
needs to carry through a little bit more.
 
> Also it becomes very tempting to somehow have this "file
> browser" selection UI as "tree browser" that can wander around
> to view an arbitrary tree in the commit history.  The boundary
> between git-gui and gitk would start to blurrrrrr.....

Indeed.  The main entrypoint is "new_browser $committish".  I don't
care what $committish is, just so long as git-blame would understand
it.  It could actually be a treeish, but blame would obviously
choke when you open a file and we won't get annotation data.

I just need to hook up some smarter UI to let you select the
committish in question.  Then comes things like wanting to extract
any given file to the local filesystem (e.g. "git show b:file >c"),
etc.

As for the line blurring between git-gui and gitk, yea, its heading
there.  Originally I set out to say "git-gui is for making changes
and transport, gitk is for history browsing".  With this addition of
a tree browser and incremental blame viewer, I'm finding it hard to
not add some sort of commit viewer when you double click a commit
in the blame output.

I *really* do not want to redo what gitk does.  Paul, et.al. have
done an excellent job with gitk[*1*].  Its currently 6,324 lines.
git-gui is another 5,654 lines.  I don't think we want them redoing
each other's work.  It would be better if Paul and I could find a
way to meld the two into a single process.

-- 
Shawn.
