From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_file: remove recursion in packed_object_info
Date: Wed, 20 Mar 2013 09:47:10 -0700
Message-ID: <7vtxo6f27l.fsf@alter.siamese.dyndns.org>
References: <7v1ubbjmq7.fsf@alter.siamese.dyndns.org>
 <c5fc1d2040544965ad3cc09e7b82b6013f06b7fa.1363729774.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Zager <szager@google.com>, <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Mar 20 17:47:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIMB0-0000Tg-Ne
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 17:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757837Ab3CTQrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 12:47:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52184 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207Ab3CTQrP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 12:47:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0A38ABDB;
	Wed, 20 Mar 2013 12:47:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JJlUH9fhOzxI6Cc5pEfKaIPpqGA=; b=UKurbY
	dXQiUj8eDFka675ZoHg7WVmT8zLhOXY8lTnSmOklYGVvHRdRaKnvnz17uzYP8Hn7
	YykdehzOBjCsCAk4la0SZSFuEC0hcSZsgYh7MJESsYkLy93hK0YEQiQ2jzwNYX3k
	RllbXv15I/azUGrw8T9vvb2Ih08SAHPWVI7ng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WlBEPGBRsvEX3FQBT1m50AtFPiahiblA
	TrmzqcEOKeqZkKyx+6f9m+r0fhRj/cG2upDqpBNQU7KJbxNBvZpEv1Gn6zW+CGQy
	14plsQOCVl7glvVjejCOHl8BCpEFUE9d0rFYjEsg7ZtLnCGJpggNNA/7AnD8kZjc
	pINXv3eSug0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4CB8ABD9;
	Wed, 20 Mar 2013 12:47:12 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4CA5FABD8; Wed, 20 Mar 2013
 12:47:12 -0400 (EDT)
In-Reply-To: <c5fc1d2040544965ad3cc09e7b82b6013f06b7fa.1363729774.git.trast@student.ethz.ch> (Thomas Rast's message of "Tue, 19 Mar 2013 23:08:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D01FDCA4-917D-11E2-B097-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218616>

Thomas Rast <trast@student.ethz.ch> writes:

> So here's a nonrecursive version.  Dijkstra is probably turning over
> in his grave as we speak.
>
> I *think* I actually got it right.

You seem to have lost the "if we cannot get delta base, this object
is BAD" check where you measure the size of a deltified object,
which would correspond to this check:

> -static int packed_delta_info(struct packed_git *p,
> -			     struct pack_window **w_curs,
> -			     off_t curpos,
> -			     enum object_type type,
> -			     off_t obj_offset,
> -			     unsigned long *sizep)
> -{
> -	off_t base_offset;
> -
> -	base_offset = get_delta_base(p, w_curs, &curpos, type, obj_offset);
> -	if (!base_offset)
> -		return OBJ_BAD;

The following comment is also lost but...

> -	/* We choose to only get the type of the base object and
> -	 * ignore potentially corrupt pack file that expects the delta
> -	 * based on a base with a wrong size.  This saves tons of
> -	 * inflate() calls.
> -	 */
> -	if (sizep) {
> -		*sizep = get_size_from_delta(p, w_curs, curpos);
> -		if (*sizep == 0)
> -			type = OBJ_BAD;

... is this check correct?  There is an equivalent check at the
beginning of the new packed_object_info() to error out a deltified
result.  Why is an object whose size is 0 bad?

This comes from 3d77d8774fc1 (make packed_object_info() resilient to
pack corruptions, 2008-10-29), and I tend to trust Nico more than I
do myself. I must be missing something obvious, but it appears to me
that the only thing that keeps us from triggering a false positive
is that we do not even attempt to deltify anything smaller than 50
bytes, and create_delta() refuses to create a delta to produce an
empty data.  But a hand-crafted packfile could certainly record such
a delta, no?

> The task of the two functions is not all that hard to describe without
> any recursion, however.  It proceeds in three steps:
>
> - determine the representation type and size, based on the outermost
>   object (delta or not)
>
> - follow through the delta chain, if any
>
> - determine the object type from what is found at the end of the delta
>   chain

The stack/recursion is used _only_ for error recovery, no?  If we do
not care about retrying with a different copy of an object we find
in the delta chain, we can just update obj_offset with base_offset
and keep digging.  It almost makes me wonder if a logical follow-up
to this patch may be to do so, and rewrite the error recovery
codepath to just mark the bad copy and jump back to the very top,
retrying everything from scratch.  Eventually we would run out
bad copies of the problematic object and would report an error, or
find a good copy and return the type.
