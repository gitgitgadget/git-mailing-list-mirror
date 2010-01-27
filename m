From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t1506: more test for @{upstream} syntax
Date: Wed, 27 Jan 2010 11:10:21 -0800
Message-ID: <7veilbqs82.fsf@alter.siamese.dyndns.org>
References: <1263980322-4142-1-git-send-email-gitster@pobox.com>
 <1263980322-4142-2-git-send-email-gitster@pobox.com>
 <20100126130745.GB28179@coredump.intra.peff.net>
 <7vpr4wy2lk.fsf@alter.siamese.dyndns.org>
 <20100127114009.GE6262@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 27 20:12:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaDHt-0005ok-K4
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 20:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941Ab0A0TKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 14:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755884Ab0A0TKd
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 14:10:33 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47092 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755860Ab0A0TKc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 14:10:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CABE94FF3;
	Wed, 27 Jan 2010 14:10:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oR4IhDWAMNXsMS/VZKLrJBKOlRo=; b=ipZ5PD
	OF85tUDzdGPA26HoYolc16HZPHUT53+44n7xJ4IwoMt3WG8fkCzkJswYvdIYyRtz
	Ao66se79jFRAkNS1SX6hptxXsHvnEwTLjuIl4q8TubIGcAc7lbk7aBUbwyca1J8P
	cVxCSclFhJR8W3Xj6dvykcBo86Y9wjHjsVZEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oqW0Q1BrddpPKJKSu7p/R0DeD+icYBTv
	eA4yH+eNAO4pSgH0E3LuCmRfz7qPvWTuPQAW55RC8EMiZAw8RIKbG7lxBxqHpszH
	ajra2Wyg0aFo+4aR+JFP/Loc11Cm8BQtVp360M2IEndgl94/v/K7671KZSVYDFW8
	iOlKzNZHoFI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CFDE94FF0;
	Wed, 27 Jan 2010 14:10:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6305994FE6; Wed, 27 Jan
 2010 14:10:23 -0500 (EST)
In-Reply-To: <20100127114009.GE6262@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 27 Jan 2010 06\:40\:09 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A0D26B86-0B77-11DF-9523-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Using "git show @{-1}@{u}" is still broken, though.
>
> I tried tracing the parsing through get_sha1_basic and
> interpret_branch_name, but it's pretty confusing. Especially as we seem
> to deal with @{upstream}, @{now}, and @{-1} at different places.
>
> I think the patch below does what we want, but the whole thing feels
> overly complicated to me, especially with the split of parsing @{...}
> between get_sha1_basic and interpret_branch_name. I guess we have spots
> that don't take reflogs but do take branch names, but I think the code
> would be much simpler if the syntax were parsed in one place, and then
> we threw out or complained about bogus semantics (like "checkout
> @{now}").

I wanted to do something like what your patch does by iterating over the
input inside get_sha1_basic() while we still see @{...}, parsing pieces
from the beginning, not from the end like the original "do we have the
reflog indicator at the end?  If so strip it and deal with what we have at
the front".  Your patch to i-b-n does that by recursing inside, which is a
nice solution.

Care to roll a patch with additional tests, to build on top of 105e473
(Fix log -g this@{upstream}, 2010-01-26)?
