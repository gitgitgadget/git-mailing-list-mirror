From: Junio C Hamano <junkio@cox.net>
Subject: Re: git diff: support "-U" and "--unified" options properly
Date: Sun, 14 May 2006 10:36:03 -0700
Message-ID: <7v7j4o33wc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605131317200.3866@g5.osdl.org>
	<Pine.LNX.4.64.0605131404391.3866@g5.osdl.org>
	<7vpsihsjq6.fsf@assigned-by-dhcp.cox.net>
	<200605141457.17314.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 14 19:36:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfKVj-0006bh-Nn
	for gcvg-git@gmane.org; Sun, 14 May 2006 19:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWENRgD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 13:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWENRgD
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 13:36:03 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:58508 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751496AbWENRgB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 May 2006 13:36:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060514173600.JOPD15447.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 14 May 2006 13:36:00 -0400
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200605141457.17314.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Sun, 14 May 2006 14:57:17 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19971>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> On Saturday 13 May 2006 23:22, you wrote:
>>  * remotes/ information from .git/config (js/fetchconfig)
>> ...
>>    [branch "master"]
>> 	remote = "ko-private"
>
> Why is this line needed? In this example, what is the relationship
> of local "master" with the remote? I think it is enough to specify
> the local upstream branch:
>
>  [branch "master"]
>     origin = "ko-master"

I confused you by not describing the flow. 

There are four repositories involved:

 a. siamese:/git (my local development repo)
 b. x86-64.kernel.org:~/git (my kernel.org build repo)
 c. i386.kernel.org:~/git   (ditto but for i386)
 d. kernel.org:/pub/scm/git/git.git (public distribution point)

The workflow is:

 1. maint/master/next/pu are prepared on a.

 2. maint/master/next/pu are pushed to b. and c. as
    maint/origin/next/pu.  b. and c. always have their "master"
    checked out.

 3. I go to b. and c., and "pull . origin" to start my build
    there on all four branches.

 4. When things go well, I come back to a.

 5. Then maint/master/next/pu are pushed to d. without renaming.

 6. To keep track of what have been pushed, maint/master/next/pu
    from d. are fetched to a., with ko- prefixed.  There is no
    "when on this branch" involved in this step.  Regardless of
    which branch I currently on, the fetch goes fine.  I never
    check out ko-* branches on a, nor merge from ko-* branches.

 7. Go back to step 1 and start the next cycle.  ko-maint, ko-master
    and ko-next reminds me not to rewind maint/master/next while I
    shuffle the changes to discard botched commits beyond them.

> So we need
>
>  [branch "ko-master"]
>     tracksremote = "master of ko-private"
>
> This also would specify that we are not allowed to commit on "ko-master".

For my workflow, it is "master of ko"; your notation expresses
the same constraints more explicitly by being more special
purpose: "This tracks that one so never touch it any way other
than fetching into it" (we may not even allow checking out
"ko-master" -- I dunno).  

One issue you might want to think about is it is far more
efficient to fetch multiple branches from the same git://... URL
is than fetching them one by one.  The push has exactly the same
property.

Another thing is the above talks only about constraints, and the
user has to go all over the config file to find "xxx to
ko-private" in order to figure out what happens when he says
"pull ko-private".

>> ...
>>    [remote "ko"]
>>    	url = "kernel.org:/pub/scm/git/git.git"
>>       push = master:master
>> ...

>> 	fetch = master:ko-master
>

> These specifications more or less are independent from the above,
> as it specifies the defaults when fetching/pushing to the specified remote.

Not really; and what you introduced can conflict with [remote]
specification.  If you have [branch "ko-master"] that says it
tracks remote "master" from "ko" repository, your [remote "ko"]
should have not say "fetch = foobla:ko-master", so in that sense
it is redundant and inviting later inconsistency.  The only
information you added with "tracksremote" is the branch is used
to track what is on remote (implying we'd better not touch it
ourselves), so I'd say this would make sense

	[branch "ko-master"]
        	tracksremote ; bool!
	[remote "ko"]
        	url = git://git.kernel.org/pub/scm/git/git.git
        	fetch = master:ko-master

or alternatively this would:

	[branch "ko-master"]
		tracksremote = "master of ko"
	[remote "ko"]
        	url = git://git.kernel.org/pub/scm/git/git.git
