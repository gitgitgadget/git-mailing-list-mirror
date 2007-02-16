From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: GIT 1.5.0 binary installer available.
Date: Fri, 16 Feb 2007 00:06:15 -0500
Message-ID: <20070216050615.GC28894@spearce.org>
References: <45D44FD5.72299A3A@eudaptics.com> <45D48FF5.2060800@xs4all.nl> <Pine.LNX.4.63.0702151954480.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070215201249.GA27526@spearce.org> <Pine.LNX.4.63.0702160517390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 16 06:06:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHvIj-0004Ha-Dk
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 06:06:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423214AbXBPFGU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 00:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423245AbXBPFGU
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 00:06:20 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44511 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423244AbXBPFGT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 00:06:19 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HHvIL-0005YB-53; Fri, 16 Feb 2007 00:06:05 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0454B20FBAE; Fri, 16 Feb 2007 00:06:15 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702160517390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39887>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 15 Feb 2007, Shawn O. Pearce wrote:
> > Do post, when ready.  ;-)
> 
> @@ -291,6 +291,11 @@ proc ask_popup {msg} {
>  ##
>  ## repository setup
>  
> +if { [is_Windows] && ![is_Cygwin] } {
> +	set repo_dir [tk_chooseDirectory -title "Choose a Git repository" -mustexist 1]
> +	cd $repo_dir
> +}
> +
>  if {   [catch {set _gitdir $env(GIT_DIR)}]
>  	&& [catch {set _gitdir [exec git rev-parse --git-dir]} err]} {
>  	catch {wm withdraw .}
> -- snap --

OK.  I'm thinking though that this should go below the context that
appears below it.  The reason is, a "Desktop Icon" for git-gui embeds
the repository path in it by setting up GIT_DIR, so that the user
returns to the same repository when launching through that icon.
In other words, maybe only prompt the user to select the directory
if $env(GIT_DIR) was not set?
 
> However, I am still wondering what to make of the silly behaviour I 
> observed earlier: the PATH was forgotten either by "sh" being called from 
> "cmd", or by "wish84" being called from "sh".

I think I can answer this: Tcl (and thus wish too) on Windows does
not pass its environment onto its children.  If you poke around
git-gui some and look for is_Cygwin you will find some of the places
where we exec something like git-fetch we actually wrap it up in
a login shell, so the user's environment can be correctly loaded
before git-fetch starts.

I think I have also noticed that setting env(PATH) has no effect
on how Tcl searches for an executable when it tries to exec it.
The search path appears to only be settable *before* Tcl begins.

Unfortunately these quirks are also in the Cygwin version of
Tcl, as apparently on Windows even the Cygwin version of Tcl uses
CreateProcess to execute children, rather than the POSIX fork/exec
that comes with Cygwin.

> But the strangest part about it: if I replaced the program names with 
> their absolute path, then the command line options would _not_ be ignored. 
> Strange.

Really strange that command line options get ignored, but the
command still runs?  What's up with that?  Ohhhhhh, its one of
those new-fangled operating systems that's based on New Technology
Technology, isn't it?[*1*].

> If I get that fsck up fixed, I'd like to work with Han-Wen on enhancing 
> his installer (which is nice!) with wish, bash, perl, and a shortcut to 
> git-gui in Start Menu/Git/Git GUI.

That will really shine when git-gui learns how to do the magic of
git-clone.  Maybe in a week or two (basically when I get to it),
or sooner if someone is interested in doing that themselves.
 
> BTW any news on the integration of gitk in git-gui?

None to report.  I've talked with Paul about it by email only
slightly, but he has reportedly been busy with other tasks and
has not had any time lately for gitk, so the conversation wasn't
very detailed.

There's some complicating factors to embedding git-gui into gitk,
and vice-versa.  I haven't dug into gitk's UI code but I suspect
it assumes the main graph window is ".", and that the repository
has commits to display.  So I'm not sure how it would react on an
empty repository (initial commit case), nor do I want gitk's UI to
startup when running git-citool.

Likewise git-gui currently assumes the main commit window is "."
(except in the case of "git gui blame").

Both programs assume a lot of globals.  We probably have some
duplicate names for different variables.

Over the next month or two one goal for me with git-gui is to
refactor some of it into multiple files, and to use namespaces
to seperate the different modules from each other.  This way the
branch control UI's globals aren't in the same namespace as the
commit window's UI globals.  That would help with embedding git-gui
into gitk.

But from a user interface perspective I'm not sure that's the best
thing to do.  I cannot quite wrap my head around what a melded
git-gui and gitk would look like.  git-gui's primary focus is
viewing the status of the working directory, switching branches,
merging, transport (fetch/push) and making commits.  gitk's primary
focus is looking at history.  I don't know about you, but I commit,
push, fetch and merge a hellva lot more than I look at history.

One problem that I had with the last version of qgit that I looked at
was creating commits was sort of a secondary operation in the UI.
It very much felt like that feature was bolted onto the side,
and was a second class citizen.  The primary focus of the UI was
showing the graphical history.  Which is fine if that's what your
primary task is.  But its not for everyone I know.


[*1*] If you didn't get that joke, you must not have had enough
chances to poke fun at Microsoft's marketing materials for Windows
2000, which the company claimed is based on "Windows NT technology".
Or you did not know that the NT used to stand for "New Technology".
Yea, it was a lame joke.  ;-)

-- 
Shawn.
