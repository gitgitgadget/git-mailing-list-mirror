From: Junio C Hamano <gitster@pobox.com>
Subject: Re: in_merge_bases() is too expensive for recent "pu" update
Date: Fri, 24 Aug 2012 09:15:56 -0700
Message-ID: <7vobm01d1f.fsf@alter.siamese.dyndns.org>
References: <CACsJy8C-VxzwigyUDHnUkXN7vhB+93X96pH9MvgB0ps7v-_NmQ@mail.gmail.com>
 <878vd5k7uu.fsf@thomas.inf.ethz.ch> <7vd32h4h1t.fsf@alter.siamese.dyndns.org>
 <7v393d49xs.fsf@alter.siamese.dyndns.org> <87393cbp6b.fsf@thomas.inf.ethz.ch>
 <20120824151511.GB15162@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 24 18:16:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4wYK-0007zs-P4
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 18:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759662Ab2HXQQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 12:16:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35541 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755090Ab2HXQP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 12:15:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 360738CA6;
	Fri, 24 Aug 2012 12:15:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ACWzfD7J5VK3ShiRxNPYyGchPjo=; b=wrLh3c
	lnDDRmMOIhk2TAMJZB51FqgzWKygUiGOcWgHy5Qk0QcxcdMuvRpwXOU5CKFaQ24j
	1ICOR4oISTpuA2KwLRa/OkiEWt7890cv6T+jpbXCL6wmtidcwXwA1ryG4rBpoXpc
	QkRyp+Rs3pXM7DNSlKDy1Nzr/D960luE5LypI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sH1DzOzMwbTr9ShEmC9eV4ETWFfAwXIB
	H2EmljCRpCpbZ9KPt3plmPHwoD6aw8PdCwX9dM36lMWoi1n2QHo8AIut9fvKPvQF
	/BIrUFYNZmnwg9QUbE7BeY/zfUiuRw/LVSgqopORJYFiws0RH/+aeERfkv0AEsxx
	VP3Qj5JddFw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 227118CA5;
	Fri, 24 Aug 2012 12:15:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C4688CA0; Fri, 24 Aug 2012
 12:15:57 -0400 (EDT)
In-Reply-To: <20120824151511.GB15162@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 24 Aug 2012 11:15:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FCBB4CA0-EE06-11E1-B8CF-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204219>

Jeff King <peff@peff.net> writes:

> I thought you were just interested in speeding up is_descendent_of. You
> should be able to do that without a generation number. Just start from A
> and B as above, do the two-color painting, and do not add the parents of
> any two-color commits (because you know they are ancestors of both, and
> therefore you cannot find either by looking backwards). If you paint "B"
> amber, then it is a descendent of "A" (and vice versa if you paint "A"
> blue).

Yes, that is what merge_bases_many() (the one without the post
processing to cull candidates) is primarily doing.  The function
also does the "STALE" bit processing that aims to reduce the number
of candidates in "no clock skew" cases with minimum effort, to
mimimize the cost of get_merge_bases_many() in the post-processing
phase, but removing the "STALE" bit processing shouldn't affect the
correctness of get_merge_bases_many() and would help performance of
merge_bases_many() proper, which is useful for is_descendant_of().

> The reason I did not do that for "tag --contains" is that I wanted to
> do a simultaneous walk for all tags. That would require N color bits for
> N tags, and we have a limited space in each commit object. I didn't time
> using a separate hash table to store those bits outside of the commit
> objects. That would have a higher constant, but should still yield good
> big-O complexity.

It may not be a bad idea to at least try and see the performance
implications of moving many users of object->flags to a new
implementation of per-purpose flag bits based on the decoration
infrastracture.
