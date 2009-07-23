From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Performance issue of 'git branch'
Date: Wed, 22 Jul 2009 22:52:17 -0700
Message-ID: <7veis83q0e.fsf@alter.siamese.dyndns.org>
References: <20090722235914.GA13150@Pilar.aei.mpg.de>
 <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain>
 <20090723012207.GA9368@Pilar.aei.mpg.de>
 <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain>
 <7vtz146mgr.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907222204310.21520@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Carlos R. Mafra" <crmafra2@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 23 07:52:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTrEH-0006pX-7U
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 07:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbZGWFw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 01:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbZGWFwZ
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 01:52:25 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57597 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbZGWFwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 01:52:25 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CE14A10A58;
	Thu, 23 Jul 2009 01:52:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0BB5210A54; Thu,
 23 Jul 2009 01:52:19 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0907222204310.21520@localhost.localdomain>
 (Linus Torvalds's message of "Wed\, 22 Jul 2009 22\:36\:09 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FE79EFD0-774C-11DE-9764-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123845>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 22 Jul 2009, Junio C Hamano wrote:
>> 
>> Hmm, we now have to remember what this patch did, if we ever wanted to
>> introduce negative refs later (see ef06b91 do_for_each_ref: perform the
>> same sanity check for leftovers., 2006-11-18).  Not exactly nice to spread
>> the codepaths that need to be updated.
> ...
> And since git branch will do something _better_ than the 'has_sha1_file()' 
> check (by virtue of actually looking up the commit), I don't think that 
> part is an issue. So the only issue is the is_null_sha1() thing.

Exactly.

That is_null_sha1() thing was a remnant of your idea to represent deleted
ref that has a packed counterpart by storing 0{40} in a loose ref, so that
we can implement deletion efficiently.

Since we currently implement deletion by repacking packed refs if the ref
has a packed (possibly stale) one, we do not use such a "negative ref",
and skipping 0{40} done by the normal (i.e. non-raw) for_each_ref() family
is not necessary.

I was inclined to say that, because I never saw anybody complained that
deleting refs was too slow, we declare that we would forever stick to the
current implementation of ref deletion, and remove the is_null_sha1()
check from the do_one_ref() function, even for include-broken case.

But after thinking about it again, I'd say "if null, then skip" should be
outside the DO_FOR_EACH_INCLUDE_BROKEN anyway, because the null check is
not about brokenness of the ref, but is about a possible future expansion
to represent deleted ref with such a "negative ref" entry.

If we remove is_null_sha1() from do_one_ref(), or if we move it out of the
"include broken" thing, my "Not exactly nice" comment can be rescinded, as
doing the former (i.e. removal of is_null_sha1() check) is a promise that
we will never have to worry about negative refs, and doing the latter will
still protect callers of do_for_each_rawref() from negative refs if we
ever introduce them in some future.
