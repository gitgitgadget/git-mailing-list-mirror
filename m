From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/7] Foreign VCS support
Date: Mon, 15 Jun 2009 14:50:16 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0906151429220.2147@iabervon.org>
References: <alpine.LNX.2.00.0905271328160.2147@iabervon.org> <20090615162641.GA14735@padd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 20:50:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGHGI-0002Vr-4c
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 20:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765012AbZFOSuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 14:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764721AbZFOSuQ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 14:50:16 -0400
Received: from iabervon.org ([66.92.72.58]:39502 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761282AbZFOSuP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 14:50:15 -0400
Received: (qmail 4842 invoked by uid 1000); 15 Jun 2009 18:50:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Jun 2009 18:50:16 -0000
In-Reply-To: <20090615162641.GA14735@padd.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121620>

On Mon, 15 Jun 2009, Pete Wyckoff wrote:

> barkalow@iabervon.org wrote on Wed, 27 May 2009 14:15 -0400:
> > This is a newly-generated and reorganized replacement for db/foreign-scm. 
> > It applies to recent next.
> 
> I finally got a chance to look at this new version.  If you have
> updates somewhere, let me know.  I had to fix up some merge issues
> to put it on top of 1.6.3.2.

Yeah, I haven't really looked at it since I posted it.

> First, I'd prefer to use the non-P4-API version, but it doesn't
> link:
> 
> vcs-p4/vcs-p4.o: In function `p4_integrate':
> /u/petew/src/git/vcs-p4/vcs-p4.c:405: undefined reference to `_p4_call_unknown'
> vcs-p4/vcs-p4.o: In function `p4_resolve':
> /u/petew/src/git/vcs-p4/vcs-p4.c:412: undefined reference to `_p4_call_unknown'
> vcs-p4/vcs-p4.o: In function `p4_edit':
> /u/petew/src/git/vcs-p4/vcs-p4.c:423: undefined reference to `_p4_call_unknown'
> vcs-p4/vcs-p4.o: In function `p4_submit':
> /u/petew/src/git/vcs-p4/vcs-p4.c:479: undefined reference to `_p4_call_form_io'
> vcs-p4/vcs-p4.o: In function `export_p4':
> /u/petew/src/git/vcs-p4/vcs-p4.c:1008: undefined reference to `p4_write_tree'
> /u/petew/src/git/vcs-p4/vcs-p4.c:1031: undefined reference to `p4_release_tree'

Sorry about that; I've been using the api version (because calling the 
command-line client with the frequency necessary to fetch stuff upsets our 
P4 admins). I keep meaning to write those methods, but I forgot. It 
shouldn't be too hard to write them if you want to use them. The 
_p4_call_* ones should call p4 and parse the output; the other two can be 
empty because the tree gets written in the filesystem in the call that is 
implemented. Note that these methods are only used in export (at least 
currently).

> Next, it took me a while to discover the format of the remote entry.
> Can you think of a way that "git remote add ..." could just work?
> How to tell it the "vcs = p4" setting at add time, for instance?

Setting the vcs in add is pretty simple, but setting the necessary other 
options would be tricky.

> [remote "upstream"]
>         url = foo
>         codeline = //depot/path/to/project
>         fetch = +refs/p4/*:refs/remotes/upstream/*
>         port = my-p4-server:1666
>         vcs = p4
> 
> The command "git remote show upstream" complains about "foo" in the url.
> Looking at your patches, the only place that sets remote->foreign_vcs is
> remote's handle_config().  This isn't going to work for "git remote show
> upstream" which calls transport_get() with a NULL remote.

I'm not sure why it does that. It actually has the remote, and it uses the 
urls from the remote, but it fails to pass the remote to transport_get(). 
I think it should (with the other changes in this series) be:

transport = transport_get(states->remote, NULL);

where transport_get() gets the remote and figures out the url, rather than 
having different code for trying to determine it.

> Maybe use urls of the form "vcs-p4://depot/path/to/project".  Might
> solve both issues.

For a proper URL, it should be vcs-p4:///depot/path/to/project; but the 
semantics of the "url" attribute aren't right for the codeline here, where 
the same project can consist of content from different locations added 
together as different branches. That's why I went with a vcs-p4-specific 
option instead of using the url at all.

Also, SVN will want to have some part specify the vcs-helper, and still 
have different URL methods for the location(s) to interact with.

> It does work, and I have added two unrelated parts of the p4 repo in
> the same git.  I'm going to try some much larger scale tests soon.

Great. Does you p4 depot have integrates? Does it have tricky integrates? 
I've got some support for it, but it's not nearly as elaborate as what the 
perl people wrote to convert their depot. I've tested it pretty thoroughly 
with tidy history, but I know there are problems with the case where 
someone integrates a file into the project from their sandbox.

	-Daniel
*This .sig left intentionally blank*
