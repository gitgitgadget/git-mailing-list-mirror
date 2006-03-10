From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-rev-list bug?
Date: Fri, 10 Mar 2006 00:20:40 -0800
Message-ID: <7vmzfy1zjb.fsf@assigned-by-dhcp.cox.net>
References: <b0943d9e0603080819i227c637fo@mail.gmail.com>
	<7vacc0iten.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Mar 10 09:21:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHcrc-0004A4-Ry
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 09:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWCJIUm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 03:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbWCJIUm
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 03:20:42 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:13499 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932328AbWCJIUl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 03:20:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060310081747.BHSI17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Mar 2006 03:17:47 -0500
To: "Catalin Marinas" <catalin.marinas@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17460>

Junio C Hamano <junkio@cox.net> writes:

> "Catalin Marinas" <catalin.marinas@gmail.com> writes:
>
>> Sorry if this was previously discussed. I ran git-rev-list on a linear
>> graph and tried to filter the results by a file name:
>>
>>   git rev-list since.. path/to/file
>>
>> but it always shows the child commit of "since" even if it didn't
>> touch the file. The same behaviour is for git-log (since it uses
>> git-rev-list) but git-whatchanged seems to be fine.
>>
>> Is this the intended behaviour? The "stg patches" command based on
>> git-rev-list used to work fine a few weeks ago but now it is always
>> reporting the bottom patch in the stack as modifying a given file.
>
> I can confirm that this is a recent breakage, but since it is
> unfortunately my day-job day the more detailed analysis and fix
> needs to wait.  Sorry.

To my surprise, it turns out that this regression was not very
recent.  Bisecting points at this commite:

diff-tree 461cf59... (from 6b94f1e...)
Author: Linus Torvalds <torvalds@osdl.org>
Date:   Wed Jan 18 14:47:30 2006 -0800

    rev-list: stop when the file disappears
    
    The one thing I've considered doing (I really should) is to add a "stop
    when you don't find the file" option to "git-rev-list". This patch does
    some of the work towards that: it removes the "parent" thing when the
    file disappears, so a "git annotate" could do do something like
    
    	git-rev-list --remove-empty --parents HEAD -- "$filename"
    
    and it would get a good graph that stops when the filename disappears
    (it's not perfect though: it won't remove all the unintersting commits).
    
    It also simplifies the logic of finding tree differences a bit, at the
    cost of making it a tad less efficient.
    
    The old logic was two-phase: it would first simplify _only_ merges tree as
    it traversed the tree, and then simplify the linear parts of the remainder
    independently. That was pretty optimal from an efficiency standpoint
    because it avoids doing any comparisons that we can see are unnecessary,
    but it made it much harder to understand than it really needed to be.
    
    The new logic is a lot more straightforward, and compares the trees as it
    traverses the graph (ie everything is a single phase). That makes it much
    easier to stop graph traversal at any point where a file disappears.
    

I haven't had time to dig into this deeper yet...
