From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Referring to a submodule state recorded in a supermodule
 from within the submodule
Date: Wed, 5 Nov 2008 15:45:03 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0811051522480.19665@iabervon.org>
References: <200811051824.28374.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 05 21:46:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxpGi-0000D9-Lu
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 21:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbYKEUpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 15:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752846AbYKEUpI
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 15:45:08 -0500
Received: from iabervon.org ([66.92.72.58]:45579 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752852AbYKEUpG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 15:45:06 -0500
Received: (qmail 12584 invoked by uid 1000); 5 Nov 2008 20:45:03 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Nov 2008 20:45:03 -0000
In-Reply-To: <200811051824.28374.johan@herland.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100181>

On Wed, 5 Nov 2008, Johan Herland wrote:

> Hi,
> 
> I have a stand-alone project, "foo", that I work on myself. The "foo" 
> project is included as a submodule in two other projects, "bar" 
> and "baz", that I don't have any direct affiliation with.
> 
> Semi-regularly, I like to keep tabs on bar and baz, to see what versions 
> of foo they are using, what changes they have made to foo, and if there 
> are things I could pick up from them, or maybe even things they could 
> learn from eachother.
> 
> Doing this currently is quite tedious:
> 1. Clone/Fetch bar and initialize/update its foo submodule
> 2. Clone/Fetch baz and initialize/update its foo submodule
> 3. Set up remotes bar_foo and baz_foo in my main foo repo,
>    pointing to bar/foo and baz/foo, respectively. Fetch.
> 4. Create tags bar_foo_current and baz_foo_current pointing
>    to the foo SHA1 sum recorded in baz and baz, respectively.
> 5. Start comparing bar_foo_current and baz_foo_current to
>    eachother, and to my own master branch.

Set up remotes in your foo:

[remote "bar"]
	url = ...
	fetch = refs/heads/*:refs/remotes/bar/*
[remote "bar-foo"]
	url = ...
	fetch = refs/heads/*:refs/remotes/in-bar/*

You should be able to do "git fetch bar" (you really don't want to merge 
this, but git is fine with unrelated histories in the same repo...);
"git fetch bar-foo".

Then I'd expect "git log master..bar/master:foo" to work [*1*].

bar/master is the commit in the superproject, "foo" is the path in its 
tree that reaches the submodule, so "bar/master:foo" is whatever's there, 
which turns out to be a commit, which is the commit you're interested in.

I think the only annoying things are that you need to find out from 
bar/master:.gitmodules what to fetch as the branch that's related to your 
local project, and you need to do two fetches each time, and you have to 
download the whole superproject state in order to find out one reference 
from it. (But this also lets you look at the history of which versions 
they incorporated over time, so you can see "they adopted something at one 
point, rolled back for a while, cherry-picked a change, and then updated 
to a version with the feature fixed.")

[*1*] This may not actually work; I don't know if we give up on 
interpreting a object name when we're looking for a commit and start to 
see a path. I'm pretty sure that git will not understand 
"refs/remotes/bar/master:path/to/foo:Makefile" (which could name the 
Makefile in the root directory of the commit in the path/to/foo location 
in the current value of bar/master, but will actually look for a 
"foo:Makefile" filename; it probably ought to work with a '/' before the 
second ':', though, since that is unambiguous)

	-Daniel
*This .sig left intentionally blank*
