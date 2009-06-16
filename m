From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 0/7] Foreign VCS support
Date: Tue, 16 Jun 2009 08:37:12 -0400
Message-ID: <20090616123712.GA3954@arf.padd.com>
References: <alpine.LNX.2.00.0905271328160.2147@iabervon.org> <20090615162641.GA14735@padd.com> <alpine.LNX.2.00.0906151429220.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jun 16 14:43:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGY0r-0007y9-Q9
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 14:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633AbZFPMnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 08:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753003AbZFPMnb
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 08:43:31 -0400
Received: from marge.padd.com ([99.188.165.110]:51367 "EHLO marge.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647AbZFPMna (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 08:43:30 -0400
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jun 2009 08:43:30 EDT
Received: from arf.padd.com (pool-71-111-229-253.rlghnc.dsl-w.verizon.net [71.111.229.253])
	by marge.padd.com (Postfix) with ESMTPSA id 1C389121A2A2;
	Tue, 16 Jun 2009 05:37:17 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 347B93E4160; Tue, 16 Jun 2009 08:37:12 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0906151429220.2147@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121680>

barkalow@iabervon.org wrote on Mon, 15 Jun 2009 14:50 -0400:
> On Mon, 15 Jun 2009, Pete Wyckoff wrote:
[..]
> Sorry about that; I've been using the api version (because calling the 
> command-line client with the frequency necessary to fetch stuff upsets our 
> P4 admins). I keep meaning to write those methods, but I forgot. It 
> shouldn't be too hard to write them if you want to use them. The 
> _p4_call_* ones should call p4 and parse the output; the other two can be 
> empty because the tree gets written in the filesystem in the call that is 
> implemented. Note that these methods are only used in export (at least 
> currently).

I shall concentrate on the API version for now too, lest my admins
get testy.

> > Next, it took me a while to discover the format of the remote entry.
> > Can you think of a way that "git remote add ..." could just work?
> > How to tell it the "vcs = p4" setting at add time, for instance?
> 
> Setting the vcs in add is pretty simple, but setting the necessary other 
> options would be tricky.

I'll try to help with a bit of documentation at least once this
appears to work.

> > [remote "upstream"]
> >         url = foo
> >         codeline = //depot/path/to/project
> >         fetch = +refs/p4/*:refs/remotes/upstream/*
> >         port = my-p4-server:1666
> >         vcs = p4
> > 
> > The command "git remote show upstream" complains about "foo" in the url.
> > Looking at your patches, the only place that sets remote->foreign_vcs is
> > remote's handle_config().  This isn't going to work for "git remote show
> > upstream" which calls transport_get() with a NULL remote.
> 
> I'm not sure why it does that. It actually has the remote, and it uses the 
> urls from the remote, but it fails to pass the remote to transport_get(). 
> I think it should (with the other changes in this series) be:
> 
> transport = transport_get(states->remote, NULL);
> 
> where transport_get() gets the remote and figures out the url, rather than 
> having different code for trying to determine it.

Agreed, looks harmless.

> Great. Does you p4 depot have integrates? Does it have tricky integrates? 
> I've got some support for it, but it's not nearly as elaborate as what the 
> perl people wrote to convert their depot. I've tested it pretty thoroughly 
> with tidy history, but I know there are problems with the case where 
> someone integrates a file into the project from their sandbox.

Oh does it have integrates.  :)

Running the p4 filelog command on its own takes 15 min.
Each file has at least one "branch from" and a bunch of "branch
into" lines.  Older files in the repo have some "copy into" lines
too.

And there are plenty with the two-rev "branch from" case that
provoked a comment in your code.  I don't understand it either.
Here's a snippet:

//depot/path/to/project/dir/foo.txt
... #1 change 555 branch on 2001/02/03 by x@y (ktext) 'Branch oldproj @444'
... ... branch into //depot/path/to/branch1/dir/foo.txt#1
... ... branch into //depot/path/to/branch2/dir/foo.txt#1
... ... branch into //depot/path/to/branch3/dir/foo.txt#1
... ... branch from //depot/oldproj/dir/main/foo.txt#1,#28

The name and the "into" branches are in current use.  The last
"from" branch is the historic location from where everything was
moved recently.  Note the extra "main/" directory in there.  This
pattern is common throughout the historic depot format, but it
confuses get_related_file(), which complains and returns NULL.

I don't particularly want to maintain this historic codeline
information, even if vcs-p4 could figure it out.  Is there a way
just to import the history of the file without having it be part of
a discovered codeline?  Perhaps always call get_codeline() and let
me use ignore_codelines to skip the oldproj ones by hand?  I do want
git to know about the "branch1" and similar, though, eventually.

I do set findbranches = false to avoid the big lookup in the list
operation, for now at least.  

You have some extra lines in "list" that duplicate codelines[0]:

-                       git_config(handle_config, remote);
-
-                       ALLOC_GROW(env, env_nr + 1, env_alloc);
-                       env[env_nr++] = NULL;
-

		-- Pete
