From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/7] Foreign VCS support
Date: Tue, 16 Jun 2009 13:29:22 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0906161121590.2147@iabervon.org>
References: <alpine.LNX.2.00.0905271328160.2147@iabervon.org> <20090615162641.GA14735@padd.com> <alpine.LNX.2.00.0906151429220.2147@iabervon.org> <20090616123712.GA3954@arf.padd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 19:29:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGcTW-0003Jx-51
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 19:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760844AbZFPR3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 13:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760494AbZFPR3V
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 13:29:21 -0400
Received: from iabervon.org ([66.92.72.58]:55357 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760864AbZFPR3U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 13:29:20 -0400
Received: (qmail 18521 invoked by uid 1000); 16 Jun 2009 17:29:22 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Jun 2009 17:29:22 -0000
In-Reply-To: <20090616123712.GA3954@arf.padd.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121692>

On Tue, 16 Jun 2009, Pete Wyckoff wrote:

> barkalow@iabervon.org wrote on Mon, 15 Jun 2009 14:50 -0400:
> > On Mon, 15 Jun 2009, Pete Wyckoff wrote:
> [..]
> > Sorry about that; I've been using the api version (because calling the 
> > command-line client with the frequency necessary to fetch stuff upsets our 
> > P4 admins). I keep meaning to write those methods, but I forgot. It 
> > shouldn't be too hard to write them if you want to use them. The 
> > _p4_call_* ones should call p4 and parse the output; the other two can be 
> > empty because the tree gets written in the filesystem in the call that is 
> > implemented. Note that these methods are only used in export (at least 
> > currently).
> 
> I shall concentrate on the API version for now too, lest my admins
> get testy.

That's probably wise. The non-API version is fine if connections are 
cheap, and just connecting to the server is cheap, but tunneling each 
connection over ssh is not cheap.

> > > Next, it took me a while to discover the format of the remote entry.
> > > Can you think of a way that "git remote add ..." could just work?
> > > How to tell it the "vcs = p4" setting at add time, for instance?
> > 
> > Setting the vcs in add is pretty simple, but setting the necessary other 
> > options would be tricky.
> 
> I'll try to help with a bit of documentation at least once this
> appears to work.

What the options are should be accurately documented already in 
Documentation/git-vcs-p4.txt (unless I forgot stuff). It's just getting 
things set reasonably through a program that's tough. Also note that you 
can set a bunch of stuff globally, most likely, and just a few things 
per-remote (or per-repo).

> > Great. Does you p4 depot have integrates? Does it have tricky integrates? 
> > I've got some support for it, but it's not nearly as elaborate as what the 
> > perl people wrote to convert their depot. I've tested it pretty thoroughly 
> > with tidy history, but I know there are problems with the case where 
> > someone integrates a file into the project from their sandbox.
> 
> Oh does it have integrates.  :)
> 
> Running the p4 filelog command on its own takes 15 min.
> Each file has at least one "branch from" and a bunch of "branch
> into" lines.  Older files in the repo have some "copy into" lines
> too.
> 
> And there are plenty with the two-rev "branch from" case that
> provoked a comment in your code.  I don't understand it either.
> Here's a snippet:
> 
> //depot/path/to/project/dir/foo.txt
> ... #1 change 555 branch on 2001/02/03 by x@y (ktext) 'Branch oldproj @444'
> ... ... branch into //depot/path/to/branch1/dir/foo.txt#1
> ... ... branch into //depot/path/to/branch2/dir/foo.txt#1
> ... ... branch into //depot/path/to/branch3/dir/foo.txt#1
> ... ... branch from //depot/oldproj/dir/main/foo.txt#1,#28
>
> The name and the "into" branches are in current use.  The last
> "from" branch is the historic location from where everything was
> moved recently.  Note the extra "main/" directory in there.  This
> pattern is common throughout the historic depot format, but it
> confuses get_related_file(), which complains and returns NULL.

So you've got a per-project mainline, which is integrated into branches. 
My depot used to have mainlines, but eventually ditched them in favor of 
only having branches, where 1.2 integrates into 1.3, and 1.3 integrates 
into 1.4, and so on.

I'm surprised that the "main" is confusing get_related_file(); I'd think 
that it would decide that //depot/oldproj/dir/main/foo.txt is foo.txt in 
the codeline //depot/oldproj/dir/main/.

> I don't particularly want to maintain this historic codeline
> information, even if vcs-p4 could figure it out.  Is there a way
> just to import the history of the file without having it be part of
> a discovered codeline?  Perhaps always call get_codeline() and let
> me use ignore_codelines to skip the oldproj ones by hand?  I do want
> git to know about the "branch1" and similar, though, eventually.

In general, I just write my fetch rules so that the old codelines get 
discovered and imported (so that the history is there), but then they 
aren't fetched. That is, they're junk in refs/p4/* (which lets git keep 
track of the fact that it imported them), but they don't end up in 
refs/remotes/origin/*.

> I do set findbranches = false to avoid the big lookup in the list
> operation, for now at least.  
> 
> You have some extra lines in "list" that duplicate codelines[0]:
> 
> -                       git_config(handle_config, remote);
> -
> -                       ALLOC_GROW(env, env_nr + 1, env_alloc);
> -                       env[env_nr++] = NULL;
> -

Oops, good catch; I refactored that stuff but forgot to remove some of the 
duplication.

	-Daniel
*This .sig left intentionally blank*
