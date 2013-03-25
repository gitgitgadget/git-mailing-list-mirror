From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_file: remove recursion in packed_object_info
Date: Mon, 25 Mar 2013 11:17:38 -0700
Message-ID: <7vtxnzxs1p.fsf@alter.siamese.dyndns.org>
References: <7v1ubbjmq7.fsf@alter.siamese.dyndns.org>
 <c5fc1d2040544965ad3cc09e7b82b6013f06b7fa.1363729774.git.trast@student.ethz.ch> <7vtxo6f27l.fsf@alter.siamese.dyndns.org> <87620faky3.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Zager <szager@google.com>, <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: thomas <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 25 19:18:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKByE-0008U1-Ft
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 19:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521Ab3CYSRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 14:17:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54994 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932314Ab3CYSRl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 14:17:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4BC4BAA0;
	Mon, 25 Mar 2013 14:17:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7rMsrJ41WDI334mVjiHN5LPRmds=; b=iVSCXg
	hhjbOBcs+LeGuFb6ATv/Jcveze0VTpw3AIphuHfI1CNC3fceGt5LogpGBqN69OkW
	KoWsnRKnfN0vZWdEj8O8UwE1n3p5RqaYvAdfFQxvs6zEG/7SZs9D+nlkgA1BCeDV
	shwzZTIZLGjzwDksAe7MYnOw3X1w7Vb0rLUCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=otd4Cil168TR+M+94kBKt9CRvDPog5TO
	qdSUmy+hr9VY6E3Qh4Jb36OmHQL8UBFaMv2mGh4D8UbAHNQiUWZYPEFAtvUjQcI0
	YKbZXp9PZAYY2B+Ija+DO7/E508GXap7I1061UBH6EvtQxb/tBnty6bmWROWaxfq
	lG0r9PkK1Dc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9163BA9F;
	Mon, 25 Mar 2013 14:17:40 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 366DDBA9B; Mon, 25 Mar 2013
 14:17:40 -0400 (EDT)
In-Reply-To: <87620faky3.fsf@linux-k42r.v.cablecom.net> (thomas's message of
 "Mon, 25 Mar 2013 10:27:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 477E31BC-9578-11E2-A128-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219059>

thomas <trast@student.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> The following comment is also lost but...
>>
>>> -	/* We choose to only get the type of the base object and
>>> -	 * ignore potentially corrupt pack file that expects the delta
>>> -	 * based on a base with a wrong size.  This saves tons of
>>> -	 * inflate() calls.
>>> -	 */
>>> -	if (sizep) {
>>> -		*sizep = get_size_from_delta(p, w_curs, curpos);
>>> -		if (*sizep == 0)
>>> -			type = OBJ_BAD;
>>
>> ... is this check correct?  There is an equivalent check at the
>> beginning of the new packed_object_info() to error out a deltified
>> result.  Why is an object whose size is 0 bad?
>
> Cc'ing Nicolas, but I think there are several reasons:
>
> If it's a delta, then according to docs[1] it starts with the SHA1 of
> the base object, plus the deflated data.  So it is at least 20 bytes.

get_size_from_delta() grabs the size, the number you would get in
the third parameter of read_sha1_file(), of the result of applying
the delta we are looking at.  The part that stores this information
is called the "compressed delta data" in the document you are
looking at.

The function you want to look at is patch_delta(), where it grabs
two such sizes from the delta stream with get_delta_hdr_size().

A delta stream begins with:

    * preimage length, expressed as a 7-bit-per-byte varint;
    * postimage length, expressed as a 7-bit-per-byte varint;

followed by number of records, each prefixed by a command byte.

    * Command byte with its 8th bit set records source offset and
      size (max 32 and 24 bits, respectively---other 7 bits in the
      command byte tells us how large the offset and size are) and
      tells us to insert a copy of that region at the current point.

    * Command byte between 1-127 (inclusive) tells us to add that
      many bytes that follow the command byte from the delta stream
      at the current point.

    * Command byte 0 is an error.

And get_size_from_delta() skips the preimage length, grabs postimage
length and returns the latter.  It is how we decide how many bytes
we need to allocate to hold the result of applying the delta.

> If it's not a delta, then it must start with '<type> <size>\0', which
> even after compression cannot possibly be 0 bytes.
>
> Either way, get_size_from_delta() also uses 0 as the error return.

Yes, that is why I said "is this check correct?".  As I already
said, I think the only two things that protects us from creating a
delta whose postimage size is 0 are the fact that we do not even
attempt to deltify anything smaller than 50 bytes in pack-objects,
and create_delta() refuses to create a delta to produce an empty
postimage.
