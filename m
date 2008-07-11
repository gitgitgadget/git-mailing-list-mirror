From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: test merge base if good rev is not an ancestor
 of bad rev
Date: Thu, 10 Jul 2008 23:51:41 -0700
Message-ID: <7vabgolxqa.fsf@gitster.siamese.dyndns.org>
References: <20080710054152.b051989c.chriscool@tuxfamily.org>
 <200807102126.37567.chriscool@tuxfamily.org>
 <7vd4llpkxq.fsf@gitster.siamese.dyndns.org>
 <200807110036.17504.chriscool@tuxfamily.org>
 <alpine.DEB.1.00.0807110035180.3279@eeepc-johanness>
 <7v7ibtnx09.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807110155040.3279@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 11 08:53:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHCUv-0000Ya-2f
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 08:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753743AbYGKGvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 02:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753622AbYGKGvw
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 02:51:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62920 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330AbYGKGvv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 02:51:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ED969311F0;
	Fri, 11 Jul 2008 02:51:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 00664311ED; Fri, 11 Jul 2008 02:51:43 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807110155040.3279@eeepc-johanness> (Johannes
 Schindelin's message of "Fri, 11 Jul 2008 01:59:58 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D65248B4-4F15-11DD-8F90-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88085>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 10 Jul 2008, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
> Of course it can be that the user commits a pilot error and says "but that 
> unrelated version was good", while the fork point(s) between good and bad 
> was bad (and this might be even the intention of the user, to find _one_ 
> commit that introduced the bug).
>
> Speaking of plural, what if some of the merge bases are good, some are 
> bad?
>
> Without carefully thinking it through, you might even _break_ the tool.

And you think it is better to make all of your _users_ think it through
every time?  Isn't it more error prone?

> All I was proposing is keeping the current semantics, keeping the 
> mechanism simple, and therefore reliable.

What I suggested to Christian (sorry, I've been busy and I still haven't
checked if that is what was implemented in the patch -- that is why I
suggested you to read the original thread) was:

	- check good and bad to see if they are forked

        - iff they are,

          - have the user check merge bases and make sure they are all
            good.  otherwise, the initial good/bad pair is unsuitable for
            bisection, so explain the situation and quit [*1*];

	  - otherwise, keep these good markers.

	- do the usual bisection --- from this point on it is "simple and
          reliable as it has always been".

And I do not think adding the "pre-check" stage before going into the main
part of the processing that we have always done is against "keeping the
mechanism simple and reliable".

[Footnote]

*1* We _could_ make things more complex by offering to swap good and bad
at this point and then continue bisecting to find a commit to cherry-pick
to forward port the fix.  Arguably, that step would be a new code and
could start out to be buggy --- it _could_ be called destabilizing what
has been reliable, but even then, it would be a separate codepath and a
new bug will be something that triggers only when the user accepts that
offer.  I do not see what the big deal is that you seem to be worried
about.
