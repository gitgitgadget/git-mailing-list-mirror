From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Thu, 09 Feb 2006 02:55:52 -0800
Message-ID: <7vr76cby2v.fsf@assigned-by-dhcp.cox.net>
References: <7vslqtf2p1.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP1142DA49F5BC7B7B42B22FAE030@CEZ.ICE>
	<43EB05B5.20307@op5.se> <7vk6c4etzy.fsf@assigned-by-dhcp.cox.net>
	<43EB1984.3040602@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 11:56:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F79Sv-0006yn-G0
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 11:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422650AbWBIKzz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 05:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422652AbWBIKzz
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 05:55:55 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:10418 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1422650AbWBIKzy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 05:55:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060209105559.UXUR25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 05:55:59 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43EB1984.3040602@op5.se> (Andreas Ericsson's message of "Thu, 09
	Feb 2006 11:29:24 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15804>

Andreas Ericsson <ae@op5.se> writes:

> This is exactly what I do when I improve upon things in master, and
> according to numerous emails this is the recommended workflow.

Yes.

> Do you mean
> 	$ git pull git://git.kernel.org/pub/scm/git/git +pu:my-pu

I do mean "+pu:pu".  In my illustration, "pu" is used in your
repository to track "pu" retrieved from me, and "my-pu" is a
fork you created from it and you build your changes upon.

	$ git pull $URL +pu:my-pu

is a shorthand for:

	$ git fetch $URL +pu:my-pu
        $ git merge "auto merge message" HEAD my-pu

and you definitely do not want to _fetch_ into my-pu when you
are on my-pu.

> ? Otherwise, I don't see how I can end up with merge-conflicts.

The problem is exactly why you need the plus sign when you fetch,
i.e. "+pu:pu".  My "pu" rebases.

Suppose I had this:

             o--o--o
            /      "pu"
	o--o
           "master"     

You do fetch +pu:pu, branch my-pu, and build on top of it:

                     o--o--o--o--o--o--o
                    /                  "my-pu"
             o--o--o
            /      "pu"
	o--o
           "master"

I add some to my "master" and rebuild "pu", maybe while adding
another commit on "pu".  You fetch +pu:pu again:

                     o--o--o--o--o--o--o
                    /                  "my-pu"
             o--o--o        o--o--o--o
            /              /         "pu" 
	o--o--o--o--o--o--o
                          "master"

Now, what happens when you merge "pu" into "my-pu"?  The three
commits I had on my previous "pu" are not part of the history of
the updated "pu" anymore, but is considered to be part of your
development trail.  If these had an addition of a file, and if
your development on top of the previous "pu" modified it, the
merge would result in:

 * originally the file did not exist.
 * "pu" adds it one way.
 * "my-pu" adds it in another way.

This requires a hand merge.  What should be done is for me to
instead of rebasing "pu", merge the updated master to "pu".

                     o--o--o--o--o--o--o
                    /                  "my-pu"
             o--o--o--------*--o
            /              /   "pu" 
	o--o--o--o--o--o--o
                          "master"

Then merge between "my-pu" and "pu" become easier.  You do not
have to worry about the earlier three commits, because the point
you forked from the previous "pu" becomes the merge base.

The reason I have not done it that way so far is primarily I am
lazy and also I do not like to see too many merges in the log.
Also "pu" tends to have really wacky stuff, so separating out
only usable bits, excluding wacky ones is slightly easier if I
rebuild it from scratch.

The new "next" aka "not too close to bleeding or broken edge"
branch will be managed like the last picture above, in order to
make working with it easier to manage.  This is only usable if I
do not include too bleeding-edge topic branch in it.
