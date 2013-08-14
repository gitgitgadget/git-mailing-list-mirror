From: Junio C Hamano <gitster@pobox.com>
Subject: Re: duplicate objects in packfile
Date: Wed, 14 Aug 2013 11:39:34 -0700
Message-ID: <7vvc38ruah.fsf@alter.siamese.dyndns.org>
References: <20130814181718.GA7911@sigill.intra.peff.net>
	<7v4nast9bv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 14 20:39:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9fyw-0004iA-Dg
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 20:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760112Ab3HNSji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 14:39:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50350 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754579Ab3HNSjh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 14:39:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D30A37D92;
	Wed, 14 Aug 2013 18:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6BaFkU1JX5n+dsAw20BJhxVOZ9U=; b=kMbyzX
	yfZ2sO9cb+iwd/9PUlEVE+2GuSzSiyeQsUeN3Oz/PbT1EqlDLUyheVkIxN0P58VV
	wrBVTbr5p55+NxKk8pnLXKPei1DWiHxY4YCnBXJJFOOCDjPlGyG5+L2ng937Oixm
	EC4H/CoMG/6PU7+Cb6crzKUB6dCN30QGLAueQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zzrh0kJVI0iKhVrF9LBaUFDX60pB1b0L
	tELR8aBcQ+2mExder1+AtcLOcQQVeXgjtnM10/p0W6CtcOlszP/SVUHchaTKHaGn
	aMnFJnxlxC4a7z5/ipCuOpAVO8x3MjSUAiOxIfw/q2Duz+Z4wAC+ov8vdrd3o4n4
	1/oEmZNr0L8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D5E137D90;
	Wed, 14 Aug 2013 18:39:36 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BEC3037D8F;
	Wed, 14 Aug 2013 18:39:35 +0000 (UTC)
In-Reply-To: <7v4nast9bv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 14 Aug 2013 11:29:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DE44B82A-0510-11E3-B2EF-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232308>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> lookup does not.  It hits an assert() that can only be triggered in the
>> face of duplicate objects. For example:
>>
>>   $ git cat-file -t 4ea4acbcb0930ac42acc87a0d203864dec1a9697
>>   commit
>>
>>   $ GIT_USE_LOOKUP=1 git cat-file -t 4ea4acbcb0930ac42acc87a0d203864dec1a9697
>>   git: sha1-lookup.c:222: sha1_entry_pos: Assertion `lov < hiv' failed.
>>   Aborted
>
> Older versions of JGit used to put duplicate objects in a pack, and
> IIRC Shawn declared that a bug in the packer and fixed it, so from
> that point of view, I think rejecting is probably the right thing,
> even though I think warning and continuing is also acceptable and
> indeed may be better.

Also repacking may have a funny corner case. I do not recall the
details as the above was a long time ago, but when I was tracking it
down, a delta was made against one copy of the base object, and
referred to it using delta-offset, while there was another copy of
the base object which was found by the bisection search, and from
there on, the inconsistencies between these two (they represent the
same payload, but they are at different offsets in the same pack and
with different in-pack sizes) led to some funky behaviour.
