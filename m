From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] The diff-raw format updates.
Date: Sun, 22 May 2005 16:01:45 -0700
Message-ID: <7vis1adfvq.fsf@assigned-by-dhcp.cox.net>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net>
	<7v1x80dluj.fsf@assigned-by-dhcp.cox.net>
	<7vvf5cc779.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505221108000.2307@ppc970.osdl.org>
	<20050522184237.GG18500@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505221203410.2307@ppc970.osdl.org>
	<7v64xbdq4y.fsf@assigned-by-dhcp.cox.net>
	<7vy8a7cavf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505221259110.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 23 01:01:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZzQz-0000kM-VE
	for gcvg-git@gmane.org; Mon, 23 May 2005 01:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVEVXBw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 19:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVEVXBw
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 19:01:52 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:13784 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261724AbVEVXBr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 19:01:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050522230144.QBUS12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 22 May 2005 19:01:44 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505221259110.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 22 May 2005 13:24:17 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Sun, 22 May 2005, Junio C Hamano wrote:
>> 
>> I deliberatly chose not to record rename/copy distinction in diff-raw
>> --- it is to be inferred from which entry touches the src _last_.  
>> Everything but the last one to touch the same path is copy, and the last
>> one is rename.

LT> My counter-example: there is no rename at all, just a copy.

My wording was wrong.  If you do not use the helper, you should
be able to get copy and in-place edit or no-modification (I
collectively call them "stay" in diffcore-rename.c).  If it does
not work then you have spotted a bug in the implementation but
not the design.  Anyway, I should have said:

    Everything but the last are copies.  If the last one have
    different src and dst, then it is a rename.  Otherwise it
    is a "stay".

LT> Try it. I added in the "&& detect_rename < 2" thing to diff-tree.c, and I 
LT> get:

LT> 	git-whatchanged -C --root | git-diff-helper | less -S

LT> resulting in:

That's not a counter-example.  You are agreeing to what I said in
this message:

    To: Linus Torvalds <torvalds@osdl.org>
    Cc: git@vger.kernel.org
    Subject: [PATCH] Teach diff-tree to report unmodified paths for -C option.
    Date: Sat, 21 May 2005 03:11:49 -0700
    Message-ID: <7vpsvkj3bu.fsf_-_@assigned-by-dhcp.cox.net>

    ...

    Another useless comment.  For obvious reasons, there is nothing
    we can do about the diff-helper to add "the other half of copy
    detection information", because what it can tell diff-core is
    limited to its input, which usually is just differences prepared
    by somebody else, and it cannot know anything about unchanged
    files.  When I started pushing '-p' flag to diff-tree family, I
    remember that your reaction was neutral to moderately negative
    ("I'd tolerate, although I think it is redundant and you are not
    even generating diff yourself anyway" as opposed to "That's just
    great").  I think now you would thank me for shoving the diff
    interface into them ;-).

If you want the diff-helper to be able to the full scale copy
detection, you must _feed_ the full information including "stay"
entries to it.  Unfortunately, the current diffcore interface
does not let the callers (diff-tree family) to tell it to keep
the "stay" entries in its output.  I've been working on that
part this morning before this discussion started, so that
electively they can tell the diffcore layer not to do the "stay"
pruning ("stay pruning" will simply become another diffcore
transformation).

I have to leave again now, but I promise you'll hear back from
me on this one later tonight (or tomorrow evening at the latest
if things do not work out).

