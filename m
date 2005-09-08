From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] A new merge algorithm, take 3
Date: Thu, 08 Sep 2005 09:51:34 -0700
Message-ID: <7v7jdrwlih.fsf@assigned-by-dhcp.cox.net>
References: <20050907164734.GA20198@c165.ib.student.liu.se>
	<7v1x407min.fsf@assigned-by-dhcp.cox.net>
	<431F34FF.5050301@citi.umich.edu>
	<7vvf1cz64l.fsf@assigned-by-dhcp.cox.net>
	<4320536D.2010706@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 18:55:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDPch-0002MU-GU
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 18:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbVIHQvh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 12:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbVIHQvg
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 12:51:36 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:17130 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932533AbVIHQvg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2005 12:51:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050908165135.DMUZ24420.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 8 Sep 2005 12:51:35 -0400
To: cel@citi.umich.edu
In-Reply-To: <4320536D.2010706@citi.umich.edu> (Chuck Lever's message of "Thu,
	08 Sep 2005 11:06:21 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8203>

Chuck Lever <cel@citi.umich.edu> writes:

> Junio C Hamano wrote:
>> Chuck Lever <cel@citi.umich.edu> writes:
>>
> once the list implementation is working well, i plan to go back and 
> replace it with something more sophisticated which can perform 
> insertion, deletion, and searching efficiently.

Well, what I wanted to see was if we can get away without
introducing more sophisticated data structures, which would add
complexity.

>> I haven't timed it like you did, but my gut feeling is that the
>> most wastage during the merge is coming from having to move
>> entries because we "insert into" or "remove from" the same
>> active-cache array.
>
> the merge actually replaces entries in place, so it is already fairly 
> efficient.  the wastage in the merge case arises from the many list 
> insertions done by read_cache, all of which involve moving some of the 
> active cache array.

Yes, the reading of three trees upfront is probably the culprit
in your case, and I think that is something Daniel's read-tree
rewrite can help.  I still see some remove_cache_entry_at()
there because it works on the active_cache in place, but the
structure of the new code should be much easier to make the kind
of modification we are talking about.

>> I think what Daniel
>> did to read-tree recently, still in the proposed updates branch,
>> would make this kind of change far easier to implement.
>
> as i'm new to git development, i wasn't aware of the proposed branch.  i 
> will see if i can take a look (or send me a pointer to the list archives 
> if he has posted them here).

If you already have a local copy of git.git repository you work in:

	git fetch http://kernel.org/pub/scm/git/git.git +pu:refs/heads/ko-pu
        git checkout -f ko-pu

Otherwise

	git clone http://kernel.org/pub/scm/git/git.git peek
        cd peek
        git checkout -f pu

The interesting change from the mainline is in read-tree.c

You can browse http://kernel.org/git/ and see commitdiffs in the
"pu" branch if you are not interested in slurping the whole
proposed updates branch.
