X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 15:30:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612011510290.3695@woody.osdl.org>
References: <20061130170625.GH18810@admingilde.org> <200612012306.41410.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0612011423100.3695@woody.osdl.org> <200612012355.03493.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 1 Dec 2006 23:32:40 +0000 (UTC)
Cc: sf <sf@b-i-t.de>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612012355.03493.Josef.Weidendorfer@gmx.de>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32986>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqHrf-00053C-6Z for gcvg-git@gmane.org; Sat, 02 Dec
 2006 00:32:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162357AbWLAXbd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 18:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162338AbWLAXbL
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 18:31:11 -0500
Received: from smtp.osdl.org ([65.172.181.25]:49611 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1162273AbWLAXa7 (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 18:30:59 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB1NUXjQ015953
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Fri, 1
 Dec 2006 15:30:33 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB1NUWhZ031920; Fri, 1 Dec
 2006 15:30:32 -0800
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org



On Fri, 1 Dec 2006, Josef Weidendorfer wrote:
> 
> What about my other argument for a submodule namespace:
> You want to be able to move the relative root path of a submodule
> inside of your supermodule, but yet want to have a unique name
> for the submodule:
> - to be able to just clone a submodule without having to know
> the current position in HEAD

Umm? I don't get the issue. A submodule is a git repo in its own right, 
and you clone it exactly like you'd clone any other repo. It _does_ have a 
HEAD. It has it's own branches. It has everything.

So when you clone a submodule, you always get all those branches. The 
supermodule will not _point_ to them all (the branches are local to the 
submodule, and _will_ depend on things like "which upstreams module am I 
tracking"), but they'll have to be there, exactly _because_ the submodule 
has an existence and is tracked on its own.

In the trivial case where the submodule doesn't even _have_ any external 
existence at all (ie it's always maintained as _just_ a submodule, it 
would probably tend to have just one branch, and a clone would get 
whatever that branch is), but that's just a degenerate special case of the 
much richer "this submodule actually has a life of its own" case.

> - more practically, e.g. to be able to name a submodule
> independent from any current commit you are on in the supermodule,
> e.g. to be able to store some meta information about a submodule:

The current commit within the supermodule would be _totally_ invisible to 
the submodule.

Of course, if HEAD _differs_ from that commit within the supermodule, then 
a "git diff" (when done from within the supermodule) should show that, but 
again, that's actually only as seen from the _supermodule_. 

> - "Where is the official upstream of this submodule?"

That's entirely a question for the submodule. You cannot ask that question 
within the confines of the supermodule, because it's not even a relevant 
question in that context. Two different supermodule repositories may well 
decide to get their submodules from difference places, just because they 
got cloned from different places (or even just for practical reasons like 
"that other site is closer to me").

So the official upstream of a submodule must NOT be encoded inside the 
supermodule (or at least not within its _objects_). Exactly because the 
upstream location is not a "global" thing - it's per-repository, and thus 
must not be encoded in the global data (ie the objects).

It should be be encoded in some _ephemeral_ place, eg in the ".git/config" 
file or in a ".git/remotes/origin"-like file (either in the supermodule or 
the submodule, and I would seriously suggest you do it within in the 
submodule itself, because you'll want it exactly when you decide to work 
on the submodule and upgrade _that_).

> - "Should git allow to commit rewind actions of this submodule
>    in the supermodule?" (which, AFAICS, exactly has the same
>    problems as publishing a rewound branch: you will get into
>    merge hell when you want to pull upstream changes into the
>    supermodule)

The only thing that a submodule must NOT be allowed to do on its own is 
pruning (and it's distant cousin "git repack -d"). You must always prune 
from the supermodule, because the submodule cannot really know on its own 
what references point into it.

(There are alternatives. One alternative is to never allow rewinding - or 
deletion - of branches in a submodule, and thus solve the problem that 
way. That is the easier solution, because it also means that a "clone" of 
a supermodule can just recursively clone the submodules independently 
_without_ having to worry about reachability, but it's really _really_ 
draconian).

> - "Should this submodule be checked out?"

This, I think, requires too much configuration to say separately for every 
possible submodule, so I would suggest that the way to make that decision 
is:

 - "git clone" by default will fetch and check out all submodules (and 
   obviously they have to be described some way outside of the object 
   database, just so that you don't have to parse the _whole_ history of 
   the _whole_ supermodule just to find all possible submodules. So the 
   supermodule _will_ need some "list of submodules and where to get them" 
   in a config file or other).

 - add a flag (possibly just re-use the current "-n" flag) that disables 
   that recursive fetching of submodules entirely.

 - have a way to fetch individual submodules one-by-one (that capacity 
   obviously has to be there anyway, since the "recursive" git clone has 
   to be able to do it, so this is likely just "git clone" again, with 
   just logic added to say "when you clone something and are _already_ 
   within a superproject, the clonee becomes a subproject automatically"

I dunno. And I'd also like to point out that things don't have to all work 
fully before we can do at least some cases of this. For example, if the 
initial version just always clones everything, big deal. I'm not saying 
that we have to have support for things like this on "Day 1", I'm just 
saying that I think people will want to be able to not fetch and check out 
everything, so the design should _allow_ for it.

(But I also think that as long as submodules are independent enough, the 
"design" part should fall out on its own, and it just becomes a "small 
matter of programming" to actually get it to work).

