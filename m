From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Define a version of lstat(2) specially for copy
 operation
Date: Wed, 18 Mar 2009 11:56:31 -0700
Message-ID: <7vprgeek2o.fsf@gitster.siamese.dyndns.org>
References: <81b0412b0903170926p4f2d536el2b96a71c79c0159e@mail.gmail.com>
 <7vprggqeh2.fsf@gitster.siamese.dyndns.org> <49BFD6DD.1010800@viscovery.net>
 <20090317202818.GA13458@blimp.localdomain>
 <7v63i7ridk.fsf@gitster.siamese.dyndns.org>
 <20090317213820.GC13458@blimp.localdomain>
 <7vmybjl1l6.fsf@gitster.siamese.dyndns.org> <49C0A919.7070606@viscovery.net>
 <7v8wn3i3ee.fsf@gitster.siamese.dyndns.org> <49C0C983.5060602@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, Jeff King <peff@peff.net>,
	layer <layer@known.net>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 18 19:58:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk0xv-00015T-TH
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 19:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557AbZCRS4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 14:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752844AbZCRS4m
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 14:56:42 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57816 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbZCRS4l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 14:56:41 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C32AC7E78;
	Wed, 18 Mar 2009 14:56:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CB0717E77; Wed,
 18 Mar 2009 14:56:32 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 82F47A22-13EE-11DE-945C-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113652>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Sorry that I skip your elaboration on this. First, I barely understand
> read-cache.c; and second, I have the feeling that this is
> over-engineering: It introduces a genericity that we don't need in
> practice.

That's Ok.  The whole speculation depended on your answer to (2) being
"yes", and because it is not the case, you can safely skip it.

I just wanted to see if we can sprinkle a handful of lstat_remainder()
calls that disappear on POSIX side without changing anything else, which
would be the least impact solution from my point of view.

> But that wouldn't be different in principle from Alex's patch that
> introduced lstat_for_copy(), would it? Since it would be used in exactly
> the same strategic places.

Hm, I sort of agree.

If you imagine somebody with POSIX background who is new to git's codebase
and is trying understand the resulting code, I thought lstat() followed by
lstat_remainder() is conceptually slightly easier to explain ("'remainder'
is needed on platforms whose lstat() do not get the x-bit right, and we
use it only where it matters"), but I do not think the difference is that
great.

You need to explain when to add the "remainder" one after an existing
lstat() call in this API, or you need to explain when to replace an
existing lstat() with "for copy" in the Alex's API.  Either way you need
to contaminate the generic codepath with the distasteful concept that "On
some platforms, you lstat() may not do what you asked it to do".

And that was what I was unhappy about Alex's patch to begin with.  Not the
"patch" nor "Alex", but the fact that we have to deal with the "issue".

And lstat() followed by lstat_remainder() does not solve that issue at
all.  So let's scrap this lstat_fast()/lstat_remainder().
