From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] commit: provide a fast multi-tip contains function
Date: Thu, 26 Jun 2014 12:19:52 -0700
Message-ID: <xmqqha374gx3.fsf@gitster.dls.corp.google.com>
References: <20140625233429.GA20457@sigill.intra.peff.net>
	<20140625234730.GF23146@sigill.intra.peff.net>
	<xmqqtx774i1r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 26 21:20:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0FDJ-0006Oo-H7
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 21:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbaFZTUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 15:20:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64953 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064AbaFZTT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 15:19:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6642B22B1D;
	Thu, 26 Jun 2014 15:19:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9+lijrMbx7+liMBqjybttDD3m5Y=; b=TaSrkM
	ztm179yargiNrjcMiOprG5w6+ZR4vgZ4AO329J8mzo1HN52yGrOF6iqLOBjt1X4a
	ee/PTk1MLVvjyqYoeNl4qwjRs3/ZEFmz1qj2eVY1FDvT8GbACN1ZwrzQQNKerbBo
	cBVhvMF7ZCW9qZuS5x0MyhNc2MTGOXHeG8YWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FgVS9JpV7WqcNY82u1VgC90y1bEMRubh
	lPhB+YrJIBdK6g/9DK8WcnsitIvnwM5pNFdYXX6xFG+Ky5Oz2NJrCnXt9TGriRRJ
	/kiVJqCRBI8VqVCeISX1RNvyRIFNkADyeRrZBdtJ0IyyV6uPnX0QBOYEDNsKLkpC
	flG+v+XgPnQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5DB2C22B1C;
	Thu, 26 Jun 2014 15:19:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9E1AD22B1B;
	Thu, 26 Jun 2014 15:19:47 -0400 (EDT)
In-Reply-To: <xmqqtx774i1r.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 26 Jun 2014 11:55:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D6634334-FD66-11E3-B018-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252519>

Junio C Hamano <gitster@pobox.com> writes:

> The only time you can say "Ah, we've seen this one and no need to
> dig further" is when you are propagating a colour C and the parent
> in question is already painted in C (it is OK to be painted as
> reachable from more tips), I would think, so shouldn't the loop be
> more like, after painting each tip and placing it in the queue:
>
>  * Dequeue one, check the L/R bits in it and call that C
>
>  * Iterate over its parents P:
>
>    * check the L/R bits in P and call that Cp.
>
>    * If Cp is already a superset of C, there is no point putting P
>      to the queue to be processed.
>
>    * If Cp is not a superset of C, then update L/R bits in P to mark
>      it reachable from tips represented by C and put P to the queue.
>
> until you ran out of queue?

Actually that will cause you to dig down to the root, so it won't be
nice.

If you are trying to do "branch --with $commit", what you would want
is not exactly "paint-down-to-common(all branches, $commit)", but
something that paints down to $commit from all branches, with an
optimization that cuts off the traversal at a commit that is
reachable from $commit.  If a traversal from branch B reached such a
commit that is reachable from $commit, you can stop the traversal
because propagating the bit for B further down to its parents will
not reach the $commit you are interested in.

So the termination condition for this a single Left (I'll use Left
for $commit and Right for "all branches") case is "if a commit is
already painted as reachable from $commit, do not propagate bits
further down".

What does it mean to look for "branch --with $commit1 $commit2"
(i.e. more than one in the Left set)?  If we are trying to see which
branches reach _both_ of these commits, then replace the ablve with
"if a commit is already painted as reachable from both $commit{1,2},
then painting it with any branch bits is futile---its parents will
never reach either $commit1 nor $commit2", so the additional
termination condition will be "If left bits are full, then stop".

I do not know how you can optimize the traversal if you are trying
to see which branches reach at least one of these commits, though.
