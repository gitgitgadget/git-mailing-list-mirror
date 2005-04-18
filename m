From: Paul Jackson <pj@sgi.com>
Subject: Re: using git directory cache code in darcs?
Date: Sun, 17 Apr 2005 19:56:00 -0700
Organization: SGI
Message-ID: <20050417195600.6894e576.pj@sgi.com>
References: <20050416132231.GJ2551@abridgegame.org>
	<Pine.LNX.4.58.0504161531470.7211@ppc970.osdl.org>
	<20050417121712.GA22772@abridgegame.org>
	<Pine.LNX.4.58.0504170916080.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: droundy@abridgegame.org, git@vger.kernel.org, darcs-devel@darcs.net
X-From: git-owner@vger.kernel.org Mon Apr 18 04:52:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNMND-0003Xb-IT
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 04:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVDRC4Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 22:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVDRC4Z
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 22:56:25 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:54710 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261625AbVDRC4U (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 22:56:20 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3I3JnIp024629;
	Sun, 17 Apr 2005 20:19:49 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3I2u5lU15574896;
	Sun, 17 Apr 2005 19:56:05 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504170916080.7211@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus wrote:
> But then I'd really suggest that you use "git" itself, not any
> "libgit". Ie you take _all_ the plumbing as real programs, and instead of
> trying to link against individual routines, you'd _script_ it.

I think you've got this upside down, Linus.

Trying to make the executable 'git' commands the bottom layer of the
user implementation stack forces inefficiencies on higher layers
of the stack, and thus encourages stupid workarounds and cheats in
an effort to speed things up.

I'd encourage you to invite someone to provide a libgit.

Such work should _start_ with proposing and gaining acceptance on the
API - the calls, the arguments, the types, the rough idea of the
semantics. The actual coding is the easy part.  One is not slave to the
agreed API when coding.  The API will continue to evolve, but if the
originally accepted proposal was sound, the evolution will be at a
modest rate, with few incompatibilities introduced.

If several operations should be done as a unit, to preserve the
integrity of the .git data or to provide sane results, then libgit need
only provide such pre-packaged units, not the incomplete fragments from
which they are composed.  That is, the libgit calls could quite possibly
be at roughly the same semantic level as your git commands.  One could
even code up some of the libgit calls, in early versions of libgit, by
simply invoking the corresponding git command.  But, eventually, all the
git commands should be recoded on top of the libgit library, and the
libgit library become the canonical user interface to git, on which all
else is layered.

One typical way that this choice manifests itself is in the strace
output from doing some ordinary git command from a C program that is
implementing an SCM system on top of git.  Forcing every operation to be
done via a separate git command execution mushrooms the number of kernel
system calls a hundred fold, or two hundred fold if some dang fool uses
system(3S) to invoke the git command.  What might have been a handful of
calls to stat/open/read/write/close a file turns into a mini-shell
session.  That way lies insanity, or at least painful inefficiency, and
the usual parade of bugs, stupid coding tricks and painful user
interfaces that follow in the wake.

The recommended layering of such user facilities is well known, with a C
library at the bottom.  Granted, the history of source code management
tools provides few examples of this recommended layering.

On top of this library go plugin modules for the fancier scripting
languages that accept such.  Swig can be used to aid this construction,
for Tcl, Python, Perl, Guile, Java, Ruby, Mzscheme, PHP, Ocaml, Pike,
C#, Chicken Allegro CL, Modula-3, Javascript and Eiffel.  Though I
personally have not worked with Swig enough to gain success with it.
The only such modules I've done were handcoded Python modules.

Also on top of this library one provides a set of command line utilities
or one multiplexed 'git foo ...' command, for use at shell prompts.  Or
the command line utilities can be coded in one of the above higher level
scripting languages, using in turn the git library plugin.  However many
of these scripting languages bring runtime requirements that are not
universally satisfied on all target systems, so are a poor choice for
this purpose.

If I am recalling correctly, from the days when I regularly used bk, one
of the things that Larry did right with bk, which RCS and SCCS did not
do right before then, was to provide a low level library to his storage
- a cleanroom recoded variant of SCCS in his case.

Implementing production source control systems on top of a set of
executable commands is a pain in the arse.  An all too familiar pain.

I'd repeat my encouragement that you invite someone to provide such a
libgit, however since I have other commitments for the next month at
least, so can't volunteer right away, if ever, it is more appropriate
that I shut up now, under the old "put up code or be quiet" rule.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
