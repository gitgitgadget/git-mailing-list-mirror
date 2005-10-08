From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Try URI quoting for embedded TAB and LF in pathnames
Date: Sat, 08 Oct 2005 13:19:10 -0700
Message-ID: <7vu0frpxs1.fsf@assigned-by-dhcp.cox.net>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net>
	<20051007232909.GB8893@steel.home>
	<7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net>
	<20051008064555.GA3831@steel.home>
	<7vachks7aq.fsf@assigned-by-dhcp.cox.net>
	<20051008133032.GA32079@localhost>
	<7v64s7svya.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Sat Oct 08 22:20:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOLAz-0002qP-8I
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 22:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbVJHUTN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Oct 2005 16:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVJHUTN
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Oct 2005 16:19:13 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:20882 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751093AbVJHUTM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2005 16:19:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051008201912.QGZU9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 8 Oct 2005 16:19:12 -0400
To: Robert Fitzsimons <robfitz@273k.net>
cc: eggert@cs.ucla.edu
In-Reply-To: <7v64s7svya.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 08 Oct 2005 11:30:21 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9853>

Junio C Hamano <junkio@cox.net> writes:

> Robert Fitzsimons <robfitz@273k.net> writes:
>
>> '\t' becomes %09
>> '\n' becomes %10
>> '%' becomes %25
>>
>> Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
>
> This would break existing setup where people *has* per-cent
> letter in their pathname -- which I think is worse than the
> backslash proposal.

Having said that, I think something along the lines of backslash
or URI encoding is the cleanest way to go in the long run, with
one condition: diffs generated with git-diff should be
applicable with 'GNU patch', especially if there is no funnies
like renames and the recipient does not mind losing mode
information.

Although 'GNU patch' has --quoting-style flag, it seems to be
used only on its output side (i.e. reporting which file it is
patching, etc.).  If we can sell changes to teach the filename
encoding convention to its util.c::fetchname() upstream, we
could tell people that 'diff --git' can be applied with newer
'GNU patch' when the patch is about a file whose name contains
'%' character (which is not that unusual, compared to TAB and
LF).  While we are selling those changes to 'GNU patch', we
might be even be able to sell the other extended 'diff --git'
metainformation support.

The same filename quoting rules change should probably be sold
to 'GNU diff' as well, so that plain diff can natively quote
funny characters in its output without forcing us to fake it
by using the -L flag.

If all of the above is what we aim for, I would say that is a
good direction to go in the longer term.  The double-slash hack
was just to avoid all these hassles of having to muck with other
people's tools.
