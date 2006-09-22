From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-push of new, tiny branch doing more work than necessary?
Date: Thu, 21 Sep 2006 19:31:52 -0700
Message-ID: <7vveng7ht3.fsf@assigned-by-dhcp.cox.net>
References: <87fyekkg5r.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 22 04:31:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQapa-0002qM-74
	for gcvg-git@gmane.org; Fri, 22 Sep 2006 04:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWIVCby (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 22:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWIVCby
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 22:31:54 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:31406 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932218AbWIVCbx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 22:31:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060922023152.WGKD2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Thu, 21 Sep 2006 22:31:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id REXu1V00E1kojtg0000000
	Thu, 21 Sep 2006 22:31:54 -0400
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87fyekkg5r.wl%cworth@cworth.org> (Carl Worth's message of "Thu,
	21 Sep 2006 15:29:04 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27516>

Carl Worth <cworth@cworth.org> writes:

> I've run through something quite like the following scenario a few
> times lately:
>
> 	git pull origin
> 	git checkout -b experiment
> 	# hack a file or two
> 	git commit -a -m "new experiment"
> 	git push origin experiment
>
> What I expect at this point is for git to push the few newly created
> objects out to the repository. Instead it talks about generating,
> deltifying, transferring, and unpacking thousands of objects (see
> below).
>
> Shouldn't the same WANT/HAVE hand shaking that makes git-fetch
> efficient be doing something similar here? Or am I just doing
> something wrong?

Depending on the version of git you are running, there are two
possibilities.

There has been a change to send-pack last week pushed out to
"master", in which Andy Whitcroft fixed a problem when there are
tons of refs on either end.  Earlier we were limiting ourselves
to use 900 or so refs when generating the pack, but the new code
uses all refs it knows about (so it excludes commits pointed by
all remote refs, not just the ones that fits in the arbitrary
900 limit).

If you are seeing problem in a pair of repository with tons of
refs, it may be the problem Andy fixed with the above change, so
using the recent "master" version would help you.

If you are on the other han seeing the problem to start after
installing the recent "master", it could be that the above
change broke things for you.  If you do not see the problem with
v1.4.2.1 but do see the problem with the current "master" that
would be an indication this is the case.

Another thing to watch out for is that send-pack/receive-pack
protocol does NOT do the full "want/have" conversation like
fetch-pack/upload-pack protocol does.  It merely say "receiving
end has these at tips of branches and tags", "sending side has
these at tips of branches and tags", and does not ask about
what's befind the tips.  So if you are in this situation, with
or without Andy's fix I can imagine you would see some redundant
sending of things.

 - The origin repository has an ancient tag and the master
   branch.  Nothing else.

 - Clone origin to victim repository. The victim repository
   would now have origin and master (the same), and the tag.

 - Somebody creates a commit in the "origin" repository on the
   master branch.

 - You create a commit on the "master" in the victim
   repository.

 - You run send-pack in the victim repository and try to push
   your master to the master in the origin repository.

In this case, the update is not a fast forward, so you may need
to force it.  When you do force, send-pack running on your end
learns from the other end about the ancient tag and its
"master", the latter of which it does not know about at all
(because you haven't pulled from the origin).  So all it has to
work with as the common commit is the ancient tag -- which means
you would end up sending everything since that ancient tag til
your tip of "master".

I do not know if that is what is happening to you in this case,
though.  While I think not doing the discovery harder like
upload-pack is a bug in send-pack, it is not an issue when you
are not forcing a non-fast forward, so it probably is a lower
priority bug than other things.  To fix it properly I think we
would need a minor protocol update.
