From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 1/3] git-gui: Adapt discovery of oguilib to execdir 'libexec/git-core'
Date: Sun,  3 Aug 2008 11:35:03 +0200
Message-ID: <1217756103.48957bc76eda2@webmail.nextra.at>
References: <1217177383-25272-1-git-send-email-prohaska@zib.de> <1217177383-25272-2-git-send-email-prohaska@zib.de> <20080727212405.GA10075@spearce.org> <AF6C526A-57ED-4386-A4CF-5260D82026B7@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Aug 03 11:36:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPa0a-0007lv-Bw
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 11:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861AbYHCJfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 05:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752862AbYHCJfJ
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 05:35:09 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:49234 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbYHCJfH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 05:35:07 -0400
Received: from webmail01.si.eunet.at (webmail01.srv.eunet.at [193.154.180.195])
	by smtp2.srv.eunet.at (Postfix) with ESMTPS id 22B1FBEE2D;
	Sun,  3 Aug 2008 11:35:04 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by webmail01.si.eunet.at (8.13.1/8.13.1) with ESMTP id m739Z38s007827;
	Sun, 3 Aug 2008 11:35:03 +0200
Received: from 77.117.130.90 ([77.117.130.90]) 
	by webmail.nextra.at (IMP) with HTTP 
	for <johsixt@mbox.eunet.at>; Sun,  3 Aug 2008 11:35:03 +0200
In-Reply-To: <AF6C526A-57ED-4386-A4CF-5260D82026B7@zib.de>
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 77.117.130.90
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91220>

Zitat von Steffen Prohaska <prohaska@zib.de>:
>
> On Jul 27, 2008, at 11:24 PM, Shawn O. Pearce wrote:
>
> > Steffen Prohaska <prohaska@zib.de> wrote:
> >> The new execdir has is two levels below the root directory, while
> >> the old execdir 'bin' was only one level below.  This commit
> >> adapts the discovery of oguilib that uses relative paths
> >> accordingly.
> > ...
> >> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> >> index 940677c..baccd57 100755
> >> --- a/git-gui/git-gui.sh
> >> +++ b/git-gui/git-gui.sh
> >> @@ -52,7 +52,9 @@ catch {rename send {}} ; # What an evil concept...
> >> set oguilib {@@GITGUI_LIBDIR@@}
> >> set oguirel {@@GITGUI_RELATIVE@@}
> >> if {$oguirel eq {1}} {
> >> -	set oguilib [file dirname [file dirname [file normalize $argv0]]]
> >> +	set oguilib [file dirname \
> >> +	             [file dirname \
> >> +	              [file dirname [file normalize $argv0]]]]
> >> 	set oguilib [file join $oguilib share git-gui lib]
> >
> > Hmmph.  This actually comes up incorrectly on my system.  The issue
> > appears to be `git --exec-path` gives me $prefix/libexec/git-core,
> > and git-gui installs its library into $prefix/libexec/share, which
> > is wrong.  It should have gone to $prefix/share.
>
> I am not seeing this problem because I am installing using the
> toplevel makefile, which sets and exports sharedir to $prefix/share.
>
>
> > I wonder if this is better.  Your other two patches seem fine.
> >
> > --8<--
> > [PATCH] git-gui: Correct installation of library to be $prefix/share
> >
> > We always wanted the library for git-gui to install into the
> > $prefix/share directory, not $prefix/libexec/share.  All of
> > the files in our library are platform independent and may
> > be reused across systems, like any other content stored in
> > the share directory.
> >
> > Our computation of where our library should install to was broken
> > when git itself started installing to $prefix/libexec/git-core,
> > which was one level down from where we expected it to be.
> >
> > Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> > ---
> > Makefile |    3 +++
> > 1 files changed, 3 insertions(+), 0 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index b19fb2d..f72ab6c 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -32,6 +32,9 @@ endif
> > ifndef gitexecdir
> > 	gitexecdir := $(shell git --exec-path)
> > endif
> > +ifeq (git-core,$(notdir $(gitexecdir)))
> > +	gitexecdir := $(patsubst %/,%,$(dir $(gitexecdir)))
> > +endif
>
> But gitexecdir has the correct value, no?  gitexecdir is used
> at several places in the makefile.  It seems wrong to strip
> 'git-core' from gitexecdir.  But I must admit that I do not
> understand all the details of git-gui's Makefile.  So maybe
> you know better.
>
> Isn't only the computation of sharedir based on gitexecdir wrong?
>
> > ifndef sharedir
> > 	sharedir := $(dir $(gitexecdir))share
>
>
> and could be replaced with this (instead of your patch):
>
>   ifndef sharedir
> +ifeq (git-core,$(notdir $(gitexecdir)))
> +       sharedir := $(dir $(patsubst %/,%,$(dir $(gitexecdir))))share
> +else
>          sharedir := $(dir $(gitexecdir))share
>   endif
> +endif

This is not good enough in my environment. I run git-gui effectivly with

   wish $prefix/libexec/git-core/git-gui

(and I have $PATH set up to contain $bindir, but not $gitexecdir), and this
needs the original hunk with the three [file dirname ... ], because $argv0
points to $prefix/libexec/git-core/git-gui.

I thought I understood what's going on, but I don't anymore.

Mybe the relative discovery of oguilib must be conditional on the "git-core"
part as well, just like you discover sharedir?

-- Hannes
