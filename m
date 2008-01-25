From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Add support for host aliases in config files
Date: Fri, 25 Jan 2008 14:53:34 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801251436060.13593@iabervon.org>
References: <alpine.LNX.1.00.0801251336080.13593@iabervon.org> <m3fxwlagbu.fsf@localhost.localdomain> <alpine.LNX.1.00.0801251355490.13593@iabervon.org> <200801252033.13142.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 20:54:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIUcx-00089D-IQ
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 20:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbYAYTxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 14:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbYAYTxj
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 14:53:39 -0500
Received: from iabervon.org ([66.92.72.58]:55931 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753101AbYAYTxi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 14:53:38 -0500
Received: (qmail 27893 invoked by uid 1000); 25 Jan 2008 19:53:34 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Jan 2008 19:53:34 -0000
In-Reply-To: <200801252033.13142.jnareb@gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71731>

On Fri, 25 Jan 2008, Jakub Narebski wrote:

> On Friday, 25 January 2008, Daniel Barkalow wrote:
> > On Fri, 25 Jan 2008, Jakub Narebski wrote:
> >> Daniel Barkalow <barkalow@iabervon.org> writes:
> >> 
> >>> This allows users with different preferences for access methods to the
> >>> same remote repositories to rewrite each other's URLs to get the
> >>> desired access.
> >> 
> >> [...]
> >>> +host.<name>.base::
> >>> +	The base URL which should be used for this particular
> >>> +	host. This can be used by a user who has a better access
> >>> +	method to a repository than other users to make use of the
> >>> +	preferable path despite getting URLs from other users using
> >>> +	more commonly-available methods. Alternatively, a user who
> >>> +	only has less privileged access to a repository than the usual
> >>> +	audience can use this mechanism to replace disallowed methods
> >>> +	with public ones.
> >>> +
> >>> +host.<name>.alias::
> >>> +	Additional base URLs which refer to this host. If a URL
> >>> +	matches this, any access to it will use the URL formed with
> >>> +	the corresponding base URL instead of the given URL.
> >>> +
> >> 
> >> From this I could not get how those configuration are meant to be
> >> used. Perhaps some usage example?
> > 
> > [host "kernel"]
> >         base = git://git.kernel.org/pub/
> >         alias = git+ssh://master.kernel.org/pub/
> >         alias = master.kernel.org:/pub/
> > 
> >> BTW. wouldn't the same be solved better by enabling remote.<name>.url
> >> to be multi-valued, first working for fetch, all URLs for push?
> 
> Ah, thanks. I have misunderstood the above description (hint, hint!)...

Yup, that's why I need to talk it through. It made perfect sense to me, 
but I'd had the problem in the first place and wrote the code...

> > The real point is actually for when you're dealing with URLs on the 
> > command line which you've cut-and-paste from email or other things. For 
> > example, the patches in the -mm quilt series say where the git trees are, 
> > but they're all like 
> > "git+ssh://master.kernel.org/pub/scm/linux/kernel/git/dtor/input.git", 
> > which is ideal for people (like Andrew) who have accounts on master, but 
> > requires manual fixing for people (like me) who don't.
> > 
> > With the above config, I can do:
> > 
> > git fetch git+ssh://master.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
> 
> Couldn't you just configure "kernel" remote, and use "git fetch kernel"
> instead?

Note the .../dtor/input.git at the end. There are another 50-odd different 
URLs in -mm that start git+ssh://master.kernel.org/pub/ where I have to 
use git://git.kernel.org/pub/ instead, and it's not a fixed set.

> > and it actually fetches
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
> >
> > which actually works for me.
> 
> So this config variable is actually about _rewriting_ URLs, rather than
> having multiple _alternate_ URLs to fetch from. IMHO either the
> documentation above should be (re)written better (there is time, as we
> are in feature freeze), or the example mentioned above should be added
> (but where?).

Maybe we should have a "host.<name>.*" section that explains the 
collection of configuration options as a group? Like:

----------
host.<name>.*::
	These options provide a way to rewrite URLs when there is a
	pattern of URLs with a common prefix which should be replaced
	with a different prefix. For every 'alias' prefix given, any
	URL git receives that starts with that prefix will be
	rewritten to have the 'base' prefix instead. In cases where
	some site serves a large number of repositories, and serves
	them with multiple access methods, and some users need to use
	different access methods, this feature allows people to
	specify any of the equivalent URLs and have git automatically
	rewrite the URL to the best alternative for the particular
	user, even for a never-before-seen repository on the site.

host.<name>.base::
	The base URL which should be used for this particular
	host.

host.<name>.alias::
	Additional base URLs which refer to this host. If a URL
	matches this, any access to it will use the URL formed with
	the corresponding base URL instead of the given URL.
----------

	-Daniel
*This .sig left intentionally blank*
