From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT overlay repositories
Date: Wed, 13 Jul 2005 15:35:35 -0700
Message-ID: <7vmzoqqqq0.fsf@assigned-by-dhcp.cox.net>
References: <42D5578D.3000301@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Thu Jul 14 10:58:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from mail-relay.eunet.no ([193.71.71.242])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DszYB-0008MI-S7
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 10:58:36 +0200
Received: from vger.kernel.org (vger.kernel.org [12.107.209.244])
	by mail-relay.eunet.no (8.13.1/8.13.1/GN) with ESMTP id j6DMd7G5027057
	for <gcvg-git@gmane.org>; Thu, 14 Jul 2005 00:39:07 +0200 (CEST)
	(envelope-from git-owner@vger.kernel.org)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbVGMWio (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 18:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbVGMWgG
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 18:36:06 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:33191 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262836AbVGMWfh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 18:35:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050713223536.NBL7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 13 Jul 2005 18:35:36 -0400
To: James Ketrenos <jketreno@linux.intel.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

James Ketrenos <jketreno@linux.intel.com> writes:

> Start with two repositories, let's call them Repo-A and Repo-B.  Repo-A
> is hosted on some server somewhere and contains lots of code 
> (let's say its a kernel source repository).  Repo-B is only adding a 
> small amount of changes to the repo (for argument sake, let's say the 
> IPW2100 and IPW2200 projects) on top of what is already provided by Repo-A. 
>
> For several reasons, we would like users to be able to get just the 
> differences between Repo-A and Repo-B from me.

I have done something like this in late April - early May when I
ran git-jc repository.  I took the then-current Linus head from
git.git, placed only my commits and objects that are absent from
his tree to a public place, and asked pullers to pull from Linus
first and then from me to get a usable repository.  My
understanding is that you are formalizing and automating the
part "please pull from X, Y, Z and then from me to complete what
I have, making it usable".  If that is the case, I agree with
the intentions [*1*].

This is related to the reason Linus wanted to have .git/config,
something that records "this object database depends on these
other object databases to be complete", when we talked about
ALTERNATE_OBJECT_DIRECTORIES last time.  I am wondering if there
is a way to solve these two related problems in a unified way.

One minor problem is that ALTERNATE_OBJECT_DIRECTORIES is a
local thing and we do not want to be able to express URLs in
there, because we do not want to run rsync nor curl from inside
sha1_file.c.  The "partial repository" problem, on the other
hand, is to publish such a repository and you _do_ want to have
URLs, likely to be somewhere completely different from where
such a partial repository is hosted at, reachable from your
pullers.

Regardless of whatever we end up doing, I have one proposal to
make.  How about having .git/objects/info/ directory for housing
various "object database" specific (and not repository specific)
information?

The set of files I would see immediate benefits are:

    objects/info/ext  -- this is your .git/refs/ancestors file [*2*],
                         that lists external URLs that the objects
                         in this object database depends upon,
                         along with the set of head commits
                         there to start pulling from to complete
                         this partial object database [*3*].  This
                         _should_ name URLs accessible to
                         expected pullers from this repository.

    objects/info/alt  -- list of local alternate object
                         directories; probably we should
                         deprecate ALTERNATE_OBJECT_DIRECTORIES
                         environment variable with this, and
                         rewrite parts of sha1_file.c.  I'd
                         volunteer to do it if we have
                         consensus.

    objects/info/pack -- list of pack files in objects/pack/;
                         this would be useful for discovery
                         through really dumb web servers [*4*].

Using something like the above structure, pulling from this
"partial" repository at rsync://abc.xz/x.git would go this way:

   (1) Sync from rsync://abc.xz/x.git/objects/
      
   (2) Read objects/info/ext just slurped from there.  Run the
       procedure (1) thru (3) against the URLs listed in the
       file, recursively.

   (3) [*5*] Read objects/info/alt just slurped from there.  Say
       it contained ../a.git and ../b.git.  Run the procedure
       (1) thru (3) against rsync://abc.xz/a.git/objects/ and
       rsync://abc.xz/b.git/objects/ recursively.

   (4) Sync from rsync://abc.xz/x.git/refs/ as needed.

Non-rsync transfer can and should be done the same way.  In
either case, updating the puller's refs/ is done solely based on
the information from rsync://abc.xz/x.git/refs/ and not from
refs in the depended-upon repositories.

Am I basically on the same page as you are?


[Footnote]

*1* But you are conflating it something else.  I will not
comment on the part you talk about merges in this message,
because forward-porting your own changes to updated upstream is
orthogonal to the "partial object database" issue.  It needs be
taken care of independently even if you maintain a fully
populated object database for your development.

*2* Ancestry is an overused word, so I would propose to call
this "external dependency": your partial object database depends
on them to be complete and usable.

*3* I was wondering why you wanted to record the foreign head in
addition to the URLs first, but you need that information (and
probabaly that needs to be a set of heads, not just a single
head) because their head may move, and in the worst case may
even be rewound to something that is not a descendant of what
you depend upon.

*4* This is not related to the current topic.

*5* This part is optional, because some alternates used locally
at the partial repository site may not be exposed to the same
pullers, or even when exposed, the alternate site may be behind
a slow link and it is preferable to get the same information
from somewhere else listed in info/ext file.  On the other hand,
it is simpler to just maintain info/alt file to serve for both
local and remote purposes.  I don't offhand know the tradeoffs.
 
