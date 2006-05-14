From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Branch relationships (was:Re: git diff: support "-U" and "--unified" options properly)
Date: Sun, 14 May 2006 22:49:17 +0200
Message-ID: <200605142249.17508.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.64.0605131317200.3866@g5.osdl.org> <200605141457.17314.Josef.Weidendorfer@gmx.de> <7v7j4o33wc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 14 22:51:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfNYI-0001rE-Eg
	for gcvg-git@gmane.org; Sun, 14 May 2006 22:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWENUux (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 16:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWENUux
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 16:50:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:26859 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751293AbWENUuw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 16:50:52 -0400
Received: (qmail invoked by alias); 14 May 2006 20:50:50 -0000
Received: from p54968B53.dip0.t-ipconnect.de (EHLO noname) [84.150.139.83]
  by mail.gmx.net (mp030) with SMTP; 14 May 2006 22:50:50 +0200
X-Authenticated: #352111
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.1
In-Reply-To: <7v7j4o33wc.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19980>

On Sunday 14 May 2006 19:36, Junio C Hamano wrote:
> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:
> 
> > On Saturday 13 May 2006 23:22, you wrote:
> >>  * remotes/ information from .git/config (js/fetchconfig)
> >> ...
> >>    [branch "master"]
> >> 	remote = "ko-private"

I still do not understand the semantic of this line.
Is this supposed to do "git pull ko-private" as default pull
action and "git push ko-private" as default push?

So using

>   ; my private build areas on the kernel.org machines
>    [remote "ko-private"]
>         url = "x86-64-build.kernel.org:git"
>         url = "i386-build.kernel.org:git"
>         push = master:origin
> ...

specifies that "git push" should push to both URLs?
This is really confusing: Is the remote "ko-private" now at
"x86-64-build.kernel.org:git" or at "i386-build.kernel.org:git" ?

Probably its better to have
  [branch "master"]
    push-remote = "ko-private-x86-64 ko-private-i386"
and entries for 2 remotes.

Neverless, I missed the info "Which branch should be merged in a default
pull after fetching the given branches from remote". I understand that
this is not needed in your workflow, as you have no upstream.

> >  [branch "ko-master"]
> >     tracksremote = "master of ko-private"
> >
> > This also would specify that we are not allowed to commit on "ko-master".
> 
> For my workflow, it is "master of ko"; your notation expresses
> the same constraints more explicitly by being more special
> purpose

Why is this more special purpose?
IMHO the only difference is that your proposal puts this information into
the remote, and I am putting it to the branch as attribute.

I chose it this way because I always thought that the Pull-lines in .git/remotes
where only about giving a default fetch action, ie. they are optionally. But
even if I do not want to have a remote branch fetched on default, I want to put
the information "XXX of remote RRR is the upstream of local YYY" into some place
to be able to do a pull when on that branch. 

> : "This tracks that one so never touch it any way other 
> than fetching into it" (we may not even allow checking out
> "ko-master" -- I dunno).  
> 
> One issue you might want to think about is it is far more
> efficient to fetch multiple branches from the same git://... URL
> is than fetching them one by one.  The push has exactly the same
> property.

Perhaps an option "when pulling into this branch from a remote, also fetch
all branches tracked from this remote", or another one "when fetching/pulling
into this branch, update all other branches, too".

> Another thing is the above talks only about constraints, and the
> user has to go all over the config file to find "xxx to
> ko-private" in order to figure out what happens when he says
> "pull ko-private".

I wasn't intending to change the current semantics of the remote section,
which specifies what to do when pulling/fetching/pushing from/into this
remote.

But you are right; this could get inconsistent. Better find a way to
not be able to specify an inconsistent config in the first place.

However, such an inconsistent config is already possible today:

 [remote "r1"]
    fetch = master:master
 [remote "r2"]
    fetch = master:master

This is not really better than

 [branch "master"]
    tracksremote "master of r1"
 [remote "r1"]
    fetch = "notmaster:master"

We already print out a warning when updating a branch tracking a remote
is not a fast-forward.
So I would leave it as it is, and allow both ways.

This all would be mood if we use refs/remotes consequently: existance of
a branch "refs/remotes/r1/master" implicitly specifies that this is
a branch tracking a remote, where the remote is named "r1" and the
remote branch is "master". 

With

 [core]
   useSeparateRemote ; bool

 [r1]
   url = ...
   fetch = master branch2 branch3

a "git fetch r1" would track given remote branches in "remotes/r1/<branch>",
and a

 [branch "master"]
   origin = "remotes/r1/master"

would work even without the "fetch" line in the remote section.
Here, we can allow both ways without getting inconsistent, as we implicitly
have

 [branch "remotes/r1/master"]
   tracksremote = "master of r1"

Regarding syntax: Instead of the "... of ..." values I would prefer two keys
"remotebranch"/"remote".

Josef
