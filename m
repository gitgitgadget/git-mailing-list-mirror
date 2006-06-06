From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] revision limiter in git-rev-list
Date: Tue, 06 Jun 2006 11:29:13 -0700
Message-ID: <7vu06yp286.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550606060136l59143ef2mdb9dc68ab78e9ff1@mail.gmail.com>
	<7v7j3uvapa.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550606060446rc9160cbt948ceededeb22766@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 20:29:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FngIu-00053x-F5
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 20:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWFFS3P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 14:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbWFFS3P
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 14:29:15 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:40700 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750924AbWFFS3O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 14:29:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060606182914.DSQP14446.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Jun 2006 14:29:14 -0400
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550606060446rc9160cbt948ceededeb22766@mail.gmail.com>
	(Marco Costalba's message of "Tue, 6 Jun 2006 13:46:23 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21393>

"Marco Costalba" <mcostalba@gmail.com> writes:

> I was thinking at an extension of git-rev-list because
>
> 1) Current git-rev-list options are quite orthogonal with rev limiter.

Which means you have to think through what you want to happen
when the user uses various other existing features.

For example, let's say you want to make this work together with
path limiting.  I have not thought things through, especially
around merges and fork points, but I suspect that it could be
implemented by having a new postprocessing phase:

 - Get the list of commits we are interested in from the command
   line.

 - Teach revision.c::try_to_simplify_commit() not to drop the
   commit from the simplified ancestry chain when such a list
   exists.

   This would probably involve disabling the code to do merge
   simplification, which would make rev-list much less useful
   while working in this mode.

 - At the end of revision.c::limit_list(), before we compute
   boundary commits perhaps, look at the resulting list and drop
   single-parent commits from the ancestry chain that are not in
   the "interesting" set.

When viewed this way, this thing is not a "rev limiter", but
more like "I want you keep these even if they are usually
dropped otherwise" -- "rev keeper" perhaps.  That is why I said
I suspect what you want is a graph reduction and not necessarily
something that interacts with rev-list.

On the other hand, you may not mind (or you may even prefer) the
algorithm not to show commits in your "rev limiter" set if they
do not touch the specified paths.  You do not have to butcher
try_to_simplify_commit() but only need the postprocessing, if
that is the case.  I cannot tell which one you wanted.

By the way, I have become quite unsure about the extra inclusion
of merge and fork-point.  I said:

> I think you would want to see this as the result of graph
> reduction:
>
>               H
>              /
>         A---B---J
>
> That is, although e is a merge and c is a fork point, they do
> not bring anything interesting in the bird's eye view picture,
> and are filtered out.  However, b is a point where lines of
> development leading to H and J (two of the commits the user is
> interested in) forks, and it is interesting.

But I now think what is reasonable to give might be this instead:

          H
         /
	A---J

Often, the topic-branch workflow involves many merges between
topic and master.  I will depict just one criss-cross pair here,
but in practice there will be several, mostly merging "so far
this is good" part from topic to master:

          o---o---o---o---o---o---o---o "topic"      
         /     \         /
    o---o---o---o---o---o---o---o---o "master"

When I say I am interested in viewing a reduced topology around
"topic" and "master", I could end up getting:

          .---*-------*---* "topic"      
         /     \     /
     ---*-------*---*---* "master"

with many cross bridges.  I am not sure why I am interested in
these cross bridges more than I am interested in the commits
that do the real work to introduce changes to the topic and
master (i.e. single parent commits).  It is _interesting_ to
see, but I consider it is more of a curiosity than of a real
value in understanding what happened in the development
history.

On the other hand, if we say we are interested in seeing the
skeleton picture, I am not sure what is reasonable to draw when
your topic needed a merge from another topic because they are
somewhat related:


                o---o---o---o---o---o "another topic"
               /             \
              /   o---o---o---X---o---o---o---o "topic"
             /   /     \         /
        o---o---o---o---o---o---o---o---o---o "master"

Now, when you say "I am interested in seeing how topic and
master have evolved", what would you do with the merge X?
One possibility is to do this:

            .-------.
           /         \
          /   .---*---X---*---* "topic"      
         /   /     \     /
     ---Y---*-------*---*---* "master"

Between X and Y are all the interesting work that are omitted
from the bird's eye view, but nevertheless Y is a fake parent of
X.  Perhaps, this is useful, but I am not so convinced.

I am afraid this is going to be the last message from me on this
topic for now, since I'd like to concentrate on getting the
"master" branch in a good shape for 1.4.0 by this weekend and
would like to have everybody do the same, and I expect to be
mostly offline next week.  But I think this exchange is bringing
us closer to have a description of how the various bits in the
current rev-list are supposed to interact with this new feature,
making it a bit more concrete for us to visualize how it could
be made implementable.

There are other interactions with "existing bits" that need to
be thought through but I only gave an example and a half of path
limiter and merge/fork in this message.

Output filters (e.g. --max-count) would be easy, but I suspect
you would have even more interesting issues when you have
negative refs (^A ^B C).  I currently do not have any idea how
you would do --boundary for this either.
