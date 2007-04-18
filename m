From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] Custom low-level merge driver support.
Date: Wed, 18 Apr 2007 10:10:18 -0700
Message-ID: <7vslaxhamd.fsf@assigned-by-dhcp.cox.net>
References: <11768880622402-git-send-email-junkio@cox.net>
	<Pine.LNX.4.64.0704181247410.12094@racer.site>
	<20070418153445.GC12888@admingilde.org>
	<alpine.LFD.0.98.0704180910120.2828@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Waitz <tali@admingilde.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 19:10:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeDfk-0006QU-2t
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 19:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139AbXDRRKV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 13:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754143AbXDRRKV
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 13:10:21 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:39890 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754139AbXDRRKU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 13:10:20 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070418171018.FVFI1257.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Apr 2007 13:10:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ohAJ1W00i1kojtg0000000; Wed, 18 Apr 2007 13:10:19 -0400
In-Reply-To: <alpine.LFD.0.98.0704180910120.2828@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 18 Apr 2007 09:16:31 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44916>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 18 Apr 2007, Martin Waitz wrote:
>>
>> > 	[merge.driver]
>> > 		ancient = merge %A %O %B
>> 
>> or
>> 
>> [merge "ancient"]
>> 	driver = merge %A %O %B
>
> Much better. That format also allows you to add extra flags if you want. 
>
> For example, it might be useful to add something like
>
> 	[merge "ancient"]
> 		name = external three-way merge
> 		driver = merge %A %O %B
>
> so that you could make the merge process actually say what it is doing 
> when it's merging things. Wouldn't it be nice to see
>
> 	merging file xyzzy using external three-way merge
> 	merging file fax.doc using word file merge
> 	..
>
> when these things trigger?
>
> So even if we do *not* care about the name, this kind of config structure 
> is just more flexible. 

Yes.

While I agree with all of the above, I am currently fighting
with a back-to-drawing-board design problem.

The series made the low-level 3-way merge machinery
customizable, which is a progress, but I think merge-recursive
needs a hook to affect middle-level merge decision, similar to
what git-merge-one-file does.

I wanted to use 'ours' merge for RelNotes, which typically
points at the release notes being prepared for the next release
from the branch (Documentation/RelNotes-1.5.1.1.txt for 'maint',
and Documentation/RelNotes-1.5.2.txt for 'master').  As I never
merge 'master' into 'maint', using 'ours' merge for that path is
the right thing to do in this case.

But merge-recursive has a built-in middle-level decision that
makes a conflicting symlink modification never go through the
low-level 3-way merge codepath.

This was originally not a problem, as the low-level 3-way merge
used to be always "textual merge" that would never make sense
for symbolic links, but once we allow low-level merge driver
that could be "pick one of branches", it becomes needless
constraints.

For now, I'd stop at pointing this issue in this message, and
finish up the configurability of low-level merge driver first
and merge that to 'next'.

But I *think* we would end up revising the driver definition to
take more than %A %O %B and allow it to do more than the
low-level decision.

Perhaps...

	(in .gitattributes)

	RelNotes	merge=ours

	(in .git/config)
        [merge "ours"]
        	name = middle level 'ours' merge driver
                driver = exit 0
                middlelevel

when "merge.$name.middlelevel" boolean is set, it would forbid
process_entry() to make the 'git-merge-one-file' policy decision
and always call the driver with these in addition to the %O %A
%B:

	%OSHA1	object name for ancestor version (or 0{40} for missing)
        %OMODE	mode bits for ancestor version (or 0{6} for missing)

The driver should be able to express the merge cleanliness via
exit status, and the resulting (potentially partial) merge
result blob via %A as the low-level driver, but in addition to
them it needs to be able to say "the merge result is to remove
that path".  I haven't figured out what that interface should
be; we could designate one special exit code to signal that,
perhaps "exit 42", but that feels hacky.

In any case, making [merge "driver-name"] section with 'driver'
variable leaves the door open for such extension in a backward
compatible way by leaving room to add 'middlelevel' boolean like
the above outline, so I'd stop worrying about this for now,
without doing anything further.
