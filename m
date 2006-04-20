From: Junio C Hamano <junkio@cox.net>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 11:49:16 -0700
Message-ID: <7v8xq0yteb.fsf@assigned-by-dhcp.cox.net>
References: <20060420133640.GA31198@spearce.org>
	<Pine.LNX.4.64.0604200745550.3701@g5.osdl.org>
	<20060420150315.GB31198@spearce.org>
	<Pine.LNX.4.64.0604200857460.3701@g5.osdl.org>
	<20060420164351.GB31738@spearce.org>
	<Pine.LNX.4.64.0604200954440.3701@g5.osdl.org>
	<20060420175554.GH31738@spearce.org>
	<Pine.LNX.4.64.0604201414490.2215@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 20:49:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWeDT-0001CW-4l
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 20:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWDTStS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 14:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWDTStS
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 14:49:18 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:27269 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751171AbWDTStS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 14:49:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060420184917.TDXH18566.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 20 Apr 2006 14:49:17 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0604201414490.2215@localhost.localdomain> (Nicolas
	Pitre's message of "Thu, 20 Apr 2006 14:24:34 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18989>

Nicolas Pitre <nico@cam.org> writes:

> On Thu, 20 Apr 2006, Shawn Pearce wrote:
>
>> The more that I think about it the more it seems possible that the
>> pathname hashing is what may be causing the problem.  Not only did
>> bisect point to 1d6b38cc76c348e2477506ca9759fc241e3d0d46 but the
>> directory which contains the bulk of the space has many files with
>> the same name located in different directories:
> [...]
>
> But the bad commit according to your bisection talks about "thin" packs 
> which are not involved in your case.  So something looks fishy with that 
> commit which should not have touched path hashing in the non-thin pack 
> case...  I think...

I think this explains it.  The new code hashes full-path, but
places bins for the paths with the same basename next to each
other, so before Makefile and doc/Makefile and t/Makefile were
all in the same bin, but now they are in three different bins
next to each other.

I originally thought, with one single notable exception of
Makefile, having the identically named file in many different
directories is not common nor sane, and the new code favors to
delta with the exact same path for deeper history over wasting
delta window for making delta with objects with the same name in
different places in more recent history.  I think I benched this
with kernel repository (git.git was too small for that).

But I suspect we have a built-in "we sort bigger to smaller, and
we cut off when we switch bins" somewhere in find_delta() loop,
which I do not recall touching when I did that change, so that
may be interfering and preventing 0-11-AdjLite.deg from all over
the place to delta against each other.
