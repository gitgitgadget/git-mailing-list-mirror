From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: More gitweb queries..
Date: Mon, 30 May 2005 03:30:56 +0200
Message-ID: <20050530013056.GH12290@cip.informatik.uni-erlangen.de>
References: <7vhdgoxx8c.fsf@assigned-by-dhcp.cox.net> <20050527195552.GA6541@cip.informatik.uni-erlangen.de> <7vu0kowho9.fsf@assigned-by-dhcp.cox.net> <20050527203227.GA11139@cip.informatik.uni-erlangen.de> <20050529230240.GB12290@cip.informatik.uni-erlangen.de> <20050529231053.GD12290@cip.informatik.uni-erlangen.de> <20050529231621.GE12290@cip.informatik.uni-erlangen.de> <20050529234606.GF12290@cip.informatik.uni-erlangen.de> <20050529235630.GG12290@cip.informatik.uni-erlangen.de> <7vsm05bkps.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 03:29:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcZ5I-0002Dm-9K
	for gcvg-git@gmane.org; Mon, 30 May 2005 03:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVE3BbL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 21:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVE3BbL
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 21:31:11 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:7880 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261492AbVE3BbF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 21:31:05 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4U1UuS8016398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 30 May 2005 01:30:56 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4U1UuVG016397;
	Mon, 30 May 2005 03:30:56 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vsm05bkps.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,
okay let me try again.

I have a function merge which gets a sorted array of heads. Heads can be
unlimited at the time because some of the heads can be included into
other heads (they're a subset) and so they don't show up in the commit
object. I call this array MERGE_HEADS.

Note: If I pull into an empty tree (no HEAD) there is only one head in
this array which corresponds to the remote_head. Otherwise the first
element is *always* the local HEAD.

After that I am starting looping over MERGE_HEADS. The first thing I
have to do is getting the first element out of this array and safe it
for later reference I call this 'head'. Also I have to push this head in
a another array called COMMIT_HEADS which will be used to create the final
commit object later on. The latter will be done for every loop pass. next;

Note: If I left the the loop because there are no more MERGE_HEADS to
work on and my COMMIT_HEADS array consists only of *one* member I don't
create a COMMIT object, but save it as new HEAD because we're in a fast
forward condition (this could be pulling into an empty tree; having many
fast forward object (remote is ahead or included into the current
'head'). On the contrary if I have *more* than one object I call
commit-tree with the COMMIT_HEADS as arguments and save the new head
return from this call.

Now I start processing the second HEAD from MERGE_HEADS. I use
merge_base to find out the MERGE_BASE. If this MERGE_BASE ==
head than we have a (remote is fast forward condition) so our
CURRENT_HEAD becomes head and I delete the week of the last element of
COMMIT_HEADS (but leaving the CURRENT_HEAD in COMMIT_HEADS). next;
If MERGE_BASE == CURRENT_HEAD than CURRENT_HEAD is already included in
our history so no need to anything, but get it out of COMMIT_HEADS.
next; If it isn't a fast forward or already included case, we do
automatic/threeway/manual merge and save the resulting tree for the
maybe to come next automatic/threeway/manual merge. And of course also
leaving the CURRENT_HEAD in COMMIT_HEADS. FIXME: Do we need to update
our 'head' to the REMOTE_HEAD? next;

Oh and of course the sanity check: I can't commit-tree more than 16
parents at a time. (16 is of course the define mentioned by Linus
before).

That's it.

	Thomas
