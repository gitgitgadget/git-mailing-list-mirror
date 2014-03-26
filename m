From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] log: do not segfault on gmtime errors
Date: Wed, 26 Mar 2014 14:01:21 -0700
Message-ID: <xmqqeh1oisim.fsf@gitster.dls.corp.google.com>
References: <20140224073348.GA20221@sigill.intra.peff.net>
	<20140224074905.GE9969@sigill.intra.peff.net>
	<20140326110559.GA32625@hashpling.org>
	<20140326182103.GB7087@sigill.intra.peff.net>
	<xmqqvbv0iy6u.fsf@gitster.dls.corp.google.com>
	<20140326190157.GB12912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 26 22:01:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSux3-0002fJ-0G
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 22:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274AbaCZVB1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 17:01:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51368 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753544AbaCZVBZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2014 17:01:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2ACA78A94;
	Wed, 26 Mar 2014 17:01:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=j3oMPGed+Iq4
	0vtQTIzzoMRPQIc=; b=yLjYVD2Mwp8oobGoQBbfeKAEnIa5mtDdVzJa1dZcrc5c
	OueFRB9YoMZvuIRmRBiQPphrYd4+gyF7fcNwsNzmdT1PlW3+HP5pxs7vKLzC0loU
	x8gCN9iMF0SnubpB3O/TcYTXqn7D+HXKG6KdJMRwMOXaB4unAe+pXzNKwAm98Aw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oXFy7Z
	vC7u2jVOKW9h8EJLQ7FMDMFbK2a5t6xlXyjqPAPQYXPj3FzQcJ06r92Fd+DnjIGC
	3t7T+hwDqIq7cMIuC+CbvjS37HQAksxz4/hIzICjJRCHG3pCxyxAVpGBYyoGmbf3
	PQ/MnPtPMrFSOnaMk9L9KiyNotQIcJ/SYZ/lk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7B6078A93;
	Wed, 26 Mar 2014 17:01:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6E5878A92;
	Wed, 26 Mar 2014 17:01:23 -0400 (EDT)
In-Reply-To: <20140326190157.GB12912@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 26 Mar 2014 15:01:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CA05E554-B529-11E3-9777-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245226>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 26, 2014 at 11:58:49AM -0700, Junio C Hamano wrote:
>
>> > Unlike the FreeBSD thing that Ren=C3=A9 brought up, this is not a =
problem in
>> > the code, but just in the test. So I think our options are basical=
ly:
>> >
>> >   1. Scrap the test as unportable.
>> >
>> >   2. Hard-code a few expected values. I'd be unsurprised if some o=
ther
>> >      system comes up with a slightly different date in 162396404, =
so we
>> >      may end up needing several of these.
>> >
>> > I think I'd lean towards (2), just because it is testing an actual
>> > feature of the code, and I'd like to continue doing so. And while =
we may
>> > end up with a handful of values, there's probably not _that_ many
>> > independent implementations of gmtime in the wild.
>>=20
>> Or "3. Just make sure that 'git log' does not segfault"?
>
> That would not test the FreeBSD case, which does not segfault, but
> returns a bogus sentinel value.
>
> I don't know how important that is. This is such a minor feature that=
 it
> is not worth a lot of maintenance headache in the test. But I also do
> not know if this is going to be the last report, or we will have a bu=
nch
> of other systems that need their own special values put into the test=
=2E

I didn't quite realize that your objective of the change was to
signal the failure of gmtime for all implementations, i.e. both (1)
the ones that signal an error by giving NULL back to us and (2) the
ones that fail to signal an error but leave bogus result (FreeBSD,
but it appears AIX might be also giving us another bogus value), by
using a single sane sentinel value.  If we can do that consistently
on every platform, that would indeed be great.

But if that is the case, we should not have to maintain special case
values in the test code, I would think.  The test instead should
expect the output to have that single sentinel value, and if the
workaround code fails to detect a breakage in the platform gmtime(),
the special case logic to catch these platform-specific breakages
should go that "timestamp that cannot be grokked by gmtime---replace
it with a sentinel" logic, no?
