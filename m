From: Shawn Pearce <spearce@spearce.org>
Subject: Re: VCS comparison table
Date: Tue, 24 Oct 2006 02:23:48 -0400
Message-ID: <20061024062348.GA9947@spearce.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <45349162.90001@op5.se> <453536AE.6060601@utoronto.ca> <200610172301.27101.jnareb@gmail.com> <45354AD0.1020107@utoronto.ca> <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE> <vpq4ptz2uh8.fsf@ecrins.imag.fr> <453DAC87.8050203@research.canon.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 08:24:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcFhm-0007yw-Kl
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 08:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbWJXGXz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 02:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbWJXGXz
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 02:23:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:28381 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1752066AbWJXGXy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 02:23:54 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GcFhV-0001JS-Ah; Tue, 24 Oct 2006 02:23:49 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 53A5B21269E; Tue, 24 Oct 2006 02:23:48 -0400 (EDT)
To: Lachlan Patrick <loki@research.canon.com.au>
Content-Disposition: inline
In-Reply-To: <453DAC87.8050203@research.canon.com.au>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29930>

Lachlan Patrick <loki@research.canon.com.au> wrote:
> Can I ask the git folks what Sean meant in the above about a 'command'.
> Are you talking about shell scripts? Is 'git' the only program you need?

'git' is actually two things:

  1) Its a wrapper command which executes 'git-foo' if you call it
     with 'foo' as its first parameter.  It searches for 'git-foo'
     in the GIT_EXEC_PATH environment variable, which has a default
     set at compile time, usually to the directory you are going to
     install Git into.

  2) Its most of the core Git plumbing.  There are currently around 48
     'builtin' commands.  These are things which 'git' knows how to do
     without executing another program.  If you look at the installation
     these 48 builtin commands are just hardlinks back to 'git'.  For
     example 'git-update-index' is really just a hardlink back to 'git'
     and 'git' knows to perform the update index logic when its called
     as either 'git-update-index' or as 'git update-index'.

We're moving more towards #2, but there are still a large number
of commands which fall into #1.
 
> AFAIK, 'bzr' is the sole program in Bazaar, and everything is done with
> command line options to bzr. Is that true of git?

No.  In Git at least half of the things Git can do are not builtin to
'git' and thus require exec()'ing an external program (e.g. git-fetch).
However these often appear as though they are command line options to
'git' as 'git fetch' just means exec 'git-fetch' (by #1 above).

On the other hand there are a wide range of tools which are more or
less the same thing, just with different options applied to them.
All of the diff programs, log, whatchanged, show - these are all
just variations on a theme.  Their individual implementations are
very tiny as they all use the same library code.

> To what extent is git
> tied to a [programmable] shell?

Git is still very much tied to a shell.  For example 'git commit'
is really the shell script 'git-commit'.  This is a rather long
shell script and it does a lot of things for the user; not having
it would make Git useless to for most people.  It also has not been
rewritten in C.  There is a roadmap however to convert it to C to
help remove the programmable shell requirement and people have been
slowly performing the (rather tedious) conversion work.

> I've heard someone say there's no
> Windows version of git for some reason, can someone elaborate?

Git runs on Cygwin.  But there's no native Win32 (without Cygwin)
version of Git because:

 - Git uses POSIX APIs and expects POSIX behavior from the OS its
   running on.  Without a compatability layer to make Windows act
   like UNIX Git won't run.  Cygwin happens to be a really good
   compatability layer.

 - Git requires a Bourne shell for many of its important tools,
   such as 'git commit'.  Windows lacks such a program, at least
   out of the box, but its in Cygwin.

 - Git relies on a helper program called 'merge' to perform three
   way file merges.  This tool may or may not be ported to native
   Win32 (I don't know) but it is in Cygwin.

 - Git requires some libraries for certain features, such as libexpat
   or libcurl.  I don't know if these are available for native Win32
   but they are available on Cygwin.

 - Windows isn't the primary target platform for many of the Git
   contributors.  Some consider the fact that it even runs there
   at all a minor miracle, and that's only possible due to the hard
   work the Cygwin folks have done.

 - ... I'm sure there's other reasons ...

-- 
Shawn.
