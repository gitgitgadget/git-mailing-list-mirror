From: thomas <trast@student.ethz.ch>
Subject: Re: [PATCH] sha1_file: remove recursion in packed_object_info
Date: Mon, 25 Mar 2013 10:27:16 +0100
Message-ID: <87620faky3.fsf@linux-k42r.v.cablecom.net>
References: <7v1ubbjmq7.fsf@alter.siamese.dyndns.org>
	<c5fc1d2040544965ad3cc09e7b82b6013f06b7fa.1363729774.git.trast@student.ethz.ch>
	<7vtxo6f27l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Zager <szager@google.com>, <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 10:28:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK3hC-0006ed-Er
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 10:28:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758161Ab3CYJ1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 05:27:30 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:46269 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757860Ab3CYJ1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 05:27:24 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 25 Mar
 2013 10:27:20 +0100
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.210.229) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 25 Mar 2013 10:27:20 +0100
In-Reply-To: <7vtxo6f27l.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 20 Mar 2013 09:47:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.210.229]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219022>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> So here's a nonrecursive version.  Dijkstra is probably turning over
>> in his grave as we speak.
>>
>> I *think* I actually got it right.
>
> You seem to have lost the "if we cannot get delta base, this object
> is BAD" check where you measure the size of a deltified object,
> which would correspond to this check:
>
>> -static int packed_delta_info(struct packed_git *p,
>> -			     struct pack_window **w_curs,
>> -			     off_t curpos,
>> -			     enum object_type type,
>> -			     off_t obj_offset,
>> -			     unsigned long *sizep)
>> -{
>> -	off_t base_offset;
>> -
>> -	base_offset = get_delta_base(p, w_curs, &curpos, type, obj_offset);
>> -	if (!base_offset)
>> -		return OBJ_BAD;

True, I'll think about this.

> The following comment is also lost but...
>
>> -	/* We choose to only get the type of the base object and
>> -	 * ignore potentially corrupt pack file that expects the delta
>> -	 * based on a base with a wrong size.  This saves tons of
>> -	 * inflate() calls.
>> -	 */
>> -	if (sizep) {
>> -		*sizep = get_size_from_delta(p, w_curs, curpos);
>> -		if (*sizep == 0)
>> -			type = OBJ_BAD;
>
> ... is this check correct?  There is an equivalent check at the
> beginning of the new packed_object_info() to error out a deltified
> result.  Why is an object whose size is 0 bad?

Cc'ing Nicolas, but I think there are several reasons:

If it's a delta, then according to docs[1] it starts with the SHA1 of
the base object, plus the deflated data.  So it is at least 20 bytes.

If it's not a delta, then it must start with '<type> <size>\0', which
even after compression cannot possibly be 0 bytes.

Either way, get_size_from_delta() also uses 0 as the error return.

> The stack/recursion is used _only_ for error recovery, no?  If we do
> not care about retrying with a different copy of an object we find
> in the delta chain, we can just update obj_offset with base_offset
> and keep digging.  It almost makes me wonder if a logical follow-up
> to this patch may be to do so, and rewrite the error recovery
> codepath to just mark the bad copy and jump back to the very top,
> retrying everything from scratch.

I totally agree.  I'll try this again -- my last attempt just didn't
work out...



[1]  Documentation/technical/pack-format.txt

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
