From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Windows support
Date: Wed, 25 Jul 2007 23:36:05 -0400
Message-ID: <20070726033605.GP32566@spearce.org>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com> <693D0FFF-B271-4781-BCE2-3BF00C8BF426@zib.de> <316a20a40707250958w1fe9f6fdn41d75ca704aeb9cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Stephen Cuppett <cuppett@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 05:36:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDu9A-0000vO-Ax
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 05:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757779AbXGZDgL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 23:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757724AbXGZDgL
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 23:36:11 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38855 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757587AbXGZDgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 23:36:09 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IDu8p-0006OW-6Z; Wed, 25 Jul 2007 23:35:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 886BB20FBAE; Wed, 25 Jul 2007 23:36:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <316a20a40707250958w1fe9f6fdn41d75ca704aeb9cd@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53756>

Stephen Cuppett <cuppett@gmail.com> wrote:
> On 7/25/07, Steffen Prohaska <prohaska@zib.de> wrote:
> 
> >Is it just that windows developer hate cygwin because it's to
> >complex to install or is there any severe limitation?
> >functionality? stability? performance?
> 
> I actually have no problems with cygwin and find it works pretty well
> with git repositories.  Starting the xserver to run git-gui is pretty
> annoying though.

I've never even tried to run it that way.  I know the Cygwin packages
have two different Tcl/Tk binaries: one that is actually a hacked
up native Tcl/Tk (which uses native Win32 graphics) and one that
is a straightup recompile of the UNIX Tcl/Tk (which uses X11 only).
I only have the native Win32 Tcl/Tk installed, and thus run native
graphics.

An advantage of the native Tcl/Tk is just that, its native.
A downside is it is native.  It doesn't use the Cygwin APIs for exec,
it directly goes through CreateProcess().  It doesn't use the Cygwin
APIs for file IO, it goes directly through the native Win32 stuff.
Which means it sometimes has a difficult time with Cygwin paths.
There are a few places in git-gui where I run `cygpath -w` just to
handle this.

I've also recently tested git-gui under the ActiveState Tcl
distribution.  It ran, but for reasons unknown to me (I didn't
research it yet) the .git/info/exclude rules didn't apply when
git-gui spawned a `git ls-files --others` helper process.

I have considered doing a starkit of git-gui, msys based git
executables/dlls, and the ActiveState Tcl engine.  That should give
users a single git-gui.exe that they can just download and launch,
no installation required.  Haven't started it yet, partly because
I haven't finished removing the need for shell scripts to support
git-gui.  I'm almost there, especially with Daniel Barkalow's work
on a native C fetch.

> Windows-based development teams are going to expect
> easy access to those kinds of tooling.  Otherwise, the champion will
> be pushing a type of workflow change that would hinder adoption anyway
> and leave a sour taste for a long time.

I agree.  They also want this thing called "explorer integration" or
something like that.  I've never had good luck with cra^H^H^Hpackages
that install themselves into the Windows explorer UI.  I would
probably never develop such a thing myself.

> I don't know if the performance problems are cygwin or not.  More
> knowledgeable people might be able to answer, it's just what I'm
> observing right now.  It could be more fundamental to the types of
> access being performed en masse on inode-based versus NTFS systems.

As Linus described its NTFS/Windows that is horrid here, and not
really Cygwin.  Linux is just fast.  Almost all modern UNIXes are.
At least when compared to the Windows kernel running on a crappy
4500 RPM IDE drive that is also hampered with a virus scanner that
wants to scan 12 GiB of data every 30 minutes, even when the volume
has only 8 GiB of files on it.  ;-)

Git is fast.  Its faster than SVN on the same hardware.  Even under
Windows.  About the only thing that I think is "slow" is two areas:

  * status.  Doing lstat() on 8,000+ files takes a little while.
  Hooking into the OS' native file monitoring facility and having
  that tell us which files are stat-dirty would reduce the need
  for these massive lstat() runs.

  * for-each-ref.  Opening 400 ref files to read their current SHA-1
  values is not fast on Windows.  More aggressively packing refs
  (at least on Windows) may actually be worthwhile.  Another option
  might be to have the same process that is watching the OS' file
  monitoring interface cache the ref values, so we can get to them
  via say shared memory or a pipe instead of file IO.

Neither feature is really necessary on a good UNIX however, as most
kernel development teams have just made sure their system has good
file IO throughput.  Oh, and they don't have to run virus scanners
that get higher IO priority than everything else.

-- 
Shawn.
