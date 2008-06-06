From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/10] Introduce get_octopus_merge_bases() in commit.c
Date: Fri, 06 Jun 2008 08:36:15 -0700
Message-ID: <7vy75ivamo.fsf@gitster.siamese.dyndns.org>
References: <cover.1212698317.git.vmiklos@frugalware.org>
 <0a2c2130f9fd87e98192ab0fe0d23e16c902997c.1212698317.git.vmiklos@frugalware.org> <9867fa302ce1c28f4bd8534a70bda19786c75971.1212698317.git.vmiklos@frugalware.org> <5aca216074b88d68f97b8223ebf6272dfe6bddeb.1212698317.git.vmiklos@frugalware.org> <3168647573b1325f47ab16f9ee3cae5abaaee473.1212698317.git.vmiklos@frugalware.org> <01dd116d05eedba51578935e39f679a8747380d6.1212698317.git.vmiklos@frugalware.org> <514d4184569ab033cad97be9afbd88c767bfb484.1212698317.git.vmiklos@frugalware.org> <2e4b20178405cf993ce9e0f1ffe4ac402a96fd03.1212698317.git.vmiklos@frugalware.org> <cbafb7e632b176658fe84e1eb9926f0a8d3c96b4.1212698317.git.vmiklos@frugalware.org> <e13c0c2e9c8b0ebef84ac062bf05c05f729b3b20.1212698317.git.vmiklos@frugalware.org> <7vk5h3xlt9.fsf@gitster.siamese.dyndns.org> <7vmylzw1l4.fsf@gitster.si
 amese.dyndns.org> <alpine.DEB.1.00.0806061316350.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 17:37:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4e0K-0003oa-Sv
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 17:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757675AbYFFPgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 11:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756683AbYFFPgc
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 11:36:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39608 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbYFFPgb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 11:36:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1473E5C49;
	Fri,  6 Jun 2008 11:36:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 33E465C42; Fri,  6 Jun 2008 11:36:26 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5578C576-33DE-11DD-8037-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84080>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Clever, but for performance reasons I think it might be better to use a 
> commit list here.

Why?  We do not iterate this that many times, and you do not gain much
from extra allocations of commit_list structure you would need to do.

>>  	one->object.flags |= PARENT1;
>> -	two->object.flags |= PARENT2;
>>  	insert_by_date(one, &list);
>> -	insert_by_date(two, &list);
>> +	for (i = 0; i < n; i++) {
>> +		twos[i]->object.flags |= PARENT2;
>> +		insert_by_date(twos[i], &list);
>> +	}
>
> Ah, now that is clever: I thought we would get into a lot of problems 
> because we would need a bit for every initial commit.

That's not coming from being _clever_, but from solving a different
problem than what you thought we are solving.  This is _not_ computing the
"base of all of them" as "git-show-branch --merge-base" computes.

Instead, this is "compute '2' given C and A+B", without actually having to
have a commit T(A,B), for a merge to create T(A,B,C).

>           o---o---A
>          /         .
>     ----1---2---B...T(A,B)
>              \       .
>               o---C...T(A,B,C)

Instead of fabricating a commit T(A,B) and drop it as "two", you
drop "A" and "B" both marked as PARENT2 into the list and have the logic
traverse as before.

The purpose of this exercise is not doing the merge base computation for
an octopus in one round.  In fact, you do _not_ want to compute it
upfront.  Re-read the original message the above picture comes from to
remind you of why (and the loop with a big comment at the bottom of
git-merge-octopus).  This is for a better computation of $MRC in each
round there.
.
