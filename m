From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/2] merge-trees script for Linus git
Date: Fri, 15 Apr 2005 21:10:05 -0700
Message-ID: <7v7jj3fjky.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	<7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
	<20050414121624.GZ25711@pasky.ji.cz>
	<7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	<20050414193507.GA22699@pasky.ji.cz>
	<7vmzs1osv1.fsf@assigned-by-dhcp.cox.net>
	<20050414233159.GX22699@pasky.ji.cz>
	<7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net>
	<20050414223039.GB28082@64m.dyndns.org>
	<7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net>
	<20050415062807.GA29841@64m.dyndns.org>
	<7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net>
	<7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org>
	<7vmzrzhkd3.fsf@assigned-by-dhcp.cox.net>
	<7vfyxrhfsw.fsf_-_@assigned-by-dhcp.cox.net>
	<7vmzrzfwe4.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504151755590.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 06:06:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMeZz-0003Oe-SY
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 06:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbVDPEKT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 00:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbVDPEKT
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 00:10:19 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:35207 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262625AbVDPEKH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 00:10:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050416041006.RXER1497.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Apr 2005 00:10:06 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504151755590.7211@ppc970.osdl.org> (Linus
 Torvalds's message of "Fri, 15 Apr 2005 18:02:07 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Just a heads-up - I'd really want to do the same thing to "merge-tree.c" 
LT> too, but since you said that you were working on extending that to do 
LT> recursion etc, I decided to hold off. So if you're working on it, maybe 
LT> you can add the "-z" flag there too? 

Sent as a separate patch already.

LT> I'm actually holding off merging the perl version exactly because you 
LT> seemed to be working on the C version. I don't mind perl per se, but if 
LT> there's a real solution coming down the line..

I'd take the hint, but I would say the current Perl version
would be far more usable than the C version I would come up with
by the end of this weekend because:

 - the Perl version creates a new temporary directory and leaves
   a ready-to-use dircache there---the only thing needed from
   that point for you is to fix it up any conflicts and do
   update-cache on that dircache.  In that sense it is already
   usable (Linus-usable, but probably not Pasky-usable due to
   differences in phylosophy).

 - the enhancement I am planning on the C version does not do
   the real work itself, as you have originally written (the
   workings and the output from it are outlined in [*R1*]).
   Somebody has to write the executor part that does read-tree
   the base, update-cache --cacheinfo --add for the selects,
   runs 3-way merge on conflicting files and runs update-cache
   for the merges, update-cache --remove for the deletes, before
   it matches the usability of the Perl version.  I do not
   expect to have enough time this weekend to finish this.

I know of one case in Perl version I need to see if it does the
right thing but other than that it would be far better than the
C version I'm toying with.

Just to let you know, here is the plan I have for my part.

 1. I am currently writing some test cases.  The plan is first
    to make sure the Perl version works OK with the test cases
    to flush initial problems out.

 2. After that I'll see if a dumb but recursive C version I
    already have spits out the right instructions.  This step is
    to make sure that the test cases are sane, and by making
    that sure, we will be able to say that we have something
    usable in extremely short run (i.e. the Perl version) after
    this step.

 3. After that is done, I'll add the fourth argument to
    merge-tree.c to specify the base so that it can cut down 90%
    of trivial selects.  Only after this happens the executioner
    script would be useful performance wise.

[References]

*R1* <7vr7hbhky9.fsf@assigned-by-dhcp.cox.net>

