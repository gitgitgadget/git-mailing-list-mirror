From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/10] Introduce get_octopus_merge_bases() in commit.c
Date: Thu, 05 Jun 2008 20:51:46 -0700
Message-ID: <7vk5h3xlt9.fsf@gitster.siamese.dyndns.org>
References: <cover.1212698317.git.vmiklos@frugalware.org>
 <0a2c2130f9fd87e98192ab0fe0d23e16c902997c.1212698317.git.vmiklos@frugalware.org> <9867fa302ce1c28f4bd8534a70bda19786c75971.1212698317.git.vmiklos@frugalware.org> <5aca216074b88d68f97b8223ebf6272dfe6bddeb.1212698317.git.vmiklos@frugalware.org> <3168647573b1325f47ab16f9ee3cae5abaaee473.1212698317.git.vmiklos@frugalware.org> <01dd116d05eedba51578935e39f679a8747380d6.1212698317.git.vmiklos@frugalware.org> <514d4184569ab033cad97be9afbd88c767bfb484.1212698317.git.vmiklos@frugalware.org> <2e4b20178405cf993ce9e0f1ffe4ac402a96fd03.1212698317.git.vmiklos@frugalware.org> <cbafb7e632b176658fe84e1eb9926f0a8d3c96b4.1212698317.git.vmiklos@frugalware.org> <e13c0c2e9c8b0ebef84ac062bf05c05f729b3b20.1212698317.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jun 06 05:53:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4T0W-0003D7-O4
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 05:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806AbYFFDv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 23:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754709AbYFFDv7
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 23:51:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754557AbYFFDv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 23:51:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5CEC23756;
	Thu,  5 Jun 2008 23:51:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 796743753; Thu,  5 Jun 2008 23:51:54 -0400 (EDT)
In-Reply-To: <e13c0c2e9c8b0ebef84ac062bf05c05f729b3b20.1212698317.git.vmiklos@frugalware.org> (Miklos Vajna's message of "Thu, 5 Jun 2008 22:44:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E8FA262C-337B-11DD-982E-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84017>

Miklos Vajna <vmiklos@frugalware.org> writes:

> This is like get_merge_bases() but it works for multiple heads, like
> show-branch --merge-base.

In what sense is this "like show-branch --merge-base"?

The only similarlity I can spot is that it can take more than two heads,
but what it computes and the way it computes it seem to be different.  It
certainly looks much less efficient as it does not walk the ancestry chain
in one-go like show-branch does.

I haven't looked at [10/10] so I do not know yet how you intend to use
this value, but I am not sure if it makes sense to use the computed value
as the merge base when running an octopus.

When you want to merge A, B and C, because internally we always do
pairwise, you would first compute:

	T(A,B) == merge_3way(mb(A,B), A, B)

and then you would want to pick some merge base to merge that result with
C:

	T(A,B,C) == merge_3way(???, T(A,B), C)

I do not think using mb(mb(A,B),C) as ??? is necessary nor optimal.

          o---o---A
         /         .
    ----1---2---B...T(A,B)
             \       .
              o---C...T(A,B,C)

"1" above is mb(A,B) (i.e. the merge base between A and B) that you would
use when you merge A and B to compute an internal merge result T(A,B).
And "1" also is mb(mb(A,B),C).

But if you are doing 3-way merge to arrive at T(A,B,C) by merging T(A,B)
and C, don't you want to be using "2" as the merge base, not "1"?

The big comment on $MRC at the end of git-merge-octopus is about this
issue.  In earlier implementation, we used to use "1" to create T(A,B) and
then also used it to update the variable $MRC, which is used to compute
the merge base to use when the tentative tree T(A,B) is merged with the
other remote in the next round.  It was a mistake.

Ideally we should pick a better base between mb(A,C) and mb(B,C) (and if
we used mb(B,C) that's "2" and is a much better base than "1" when merging
T(A,B) and C).  Using mb(mb(A,B),C) means we are guaranteed to pick the
worst base for that last merge.
