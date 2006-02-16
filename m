From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pack-objects: reuse data from existing pack.
Date: Wed, 15 Feb 2006 19:59:46 -0800
Message-ID: <7v4q30kl71.fsf@assigned-by-dhcp.cox.net>
References: <7vd5hpm2x0.fsf@assigned-by-dhcp.cox.net>
	<7vbqx8m62q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602152226130.5606@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 04:59:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9aJ6-0003wP-9m
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 04:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWBPD7t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 22:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWBPD7t
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 22:59:49 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:26544 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932261AbWBPD7t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 22:59:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060216035816.MZAC6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 15 Feb 2006 22:58:16 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0602152226130.5606@localhost.localdomain> (Nicolas
	Pitre's message of "Wed, 15 Feb 2006 22:41:24 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16268>

Nicolas Pitre <nico@cam.org> writes:

> On Wed, 15 Feb 2006, Junio C Hamano wrote:
>
>>     Generating pack...
>>     Done counting 12233 objects.
>>     Packing 12233 objects.....................
>>     60a88b3979df41e22d1edc3967095e897f720192
>>     Total 12233, written 12233, reused 12177
>> ...
> In fact, the resulting pack should be identical with or without this 
> patch, shouldn't it?

Not necessarily.  The delta-depth limitation is currently lifted
when reusing deltified objects (finding out the current depth is
not so expensive compared to uncompress-delta-recompress cycle,
but still costs somewhat, and the objective of this exercise is
to gain performance).

Notice the numbers 'written' and 'reused' in the output?
The difference in that example comes from the fact that I am
omitting some objects from the set of objects to be packed
(v1.0.0 is ancient) in a repository where some newer objects are
packed.  Since packing-delta goes backwards, what is in v1.0.0
but not in my tip tends to be delitified in the original pack,
but the resulting pack needs to have them expanded -- that is
where the difference comes from.

A cleaned-up patch will be in "pu" branch tonight.  I considered
putting it in "next", but decided against it.  I have not spent
enough time really beating on it, although I haven't seen major
breakage.
