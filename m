From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: New diff-delta.c implementation
Date: Sat, 22 Apr 2006 10:03:36 -0700
Message-ID: <7v3bg5k0ev.fsf@assigned-by-dhcp.cox.net>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com>
	<Pine.LNX.4.64.0604212308080.2215@localhost.localdomain>
	<A856A2C5-2BD7-4DC5-9CCC-CD53E9A2623C@adacore.com>
	<7v7j5hkglq.fsf@assigned-by-dhcp.cox.net>
	<6794F5B2-A277-4CD9-9BA8-509F86378E68@adacore.com>
	<Pine.LNX.4.64.0604220846040.2215@localhost.localdomain>
	<81E2B4A6-3591-418D-9448-47648AF4A687@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 22 19:03:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXLWQ-0005Um-3I
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 19:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWDVRDj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 13:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWDVRDi
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 13:03:38 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:1978 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750723AbWDVRDi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Apr 2006 13:03:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060422170337.VMCU8660.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 22 Apr 2006 13:03:37 -0400
To: Geert Bosch <bosch@adacore.com>
In-Reply-To: <81E2B4A6-3591-418D-9448-47648AF4A687@adacore.com> (Geert Bosch's
	message of "Sat, 22 Apr 2006 09:39:05 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19035>

Geert Bosch <bosch@adacore.com> writes:

> On Apr 22, 2006, at 08:51, Nicolas Pitre wrote:
>> First, pack-objects tries to find the best object combinations
>> producing the smallest delta.  Then there is a second pass
>> where the best delta are actually written out.  When that
>> message appears that means the delta size for the same object
>> pair does not match between those two passes.
>
> OK, thanks for that info. There are very few comments in the
> code, or specs of either the file format used, or
> for function arguments. I'll look a the code again with this
> info.

Initially I thought it would be irrelevant to your work, but
generating packs is the only way to really exercise the diff-delta
code these days; Documentation/technical/pack-format.txt might
help.

> What is the exact role of the max_size parameter that is
> passed to diff_delta? I took it to mean return 0 if
> the size of the delta would be bigger than max_size and
> max_size is nonzero.

No, that is a _strong_ hint to tell diff_delta to quit early
without wasting cycles if the result exceeds the given size,
either because we already have a delta smaller than that, or
because we expect to get an undeltified representation
compressed down to that size.  So if your algorithm cannot
notice early stage of the processing if the result would exceed
that max_size, just code things to ignore it first.
