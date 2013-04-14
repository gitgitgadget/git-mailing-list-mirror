From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] commit-slab: avoid large realloc
Date: Sun, 14 Apr 2013 11:51:40 -0700
Message-ID: <7vk3o554jn.fsf@alter.siamese.dyndns.org>
References: <1365919489-17553-1-git-send-email-gitster@pobox.com>
 <1365919489-17553-3-git-send-email-gitster@pobox.com>
 <20130414152842.GB1544@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 20:51:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URS1t-0003T4-4i
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 20:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342Ab3DNSvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 14:51:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35285 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753159Ab3DNSvm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 14:51:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4480916C99;
	Sun, 14 Apr 2013 18:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A9HqgOK8dp8wa4rUvLbe9ZBaSKI=; b=tiQAcV
	82jTLKPW2Chu5ywXUtVaniW2rsU1GHhF0/z0DZjVmjdWH0QUbXi2i1UpCTxOoNHN
	16dEL1wYB4LmVTChny40NypYFIU8rPgkZo2YWU7hUd3lTD6nFFKjSGf+8yMl/ses
	Z7izPHMUFTGlaw2kDiZAzBtMgbGUrrHfBVhSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eL9zGaOpZm4medvHqXazxUf5JUCOWFfP
	+hFuK8j+sr2YFksSi4P6/kAwaN7deQMwy5JU6uiM7gr3QdHO6qku6rbcsgA8Vh98
	/7hfmLvRGdFRSQwOvQbdls87pH8oUUp327iT6JEbf+8o2PRlVr5QSMAA98xKsVx7
	oScIx0ORSCA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C77D16C97;
	Sun, 14 Apr 2013 18:51:42 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B289116C95; Sun, 14 Apr
 2013 18:51:41 +0000 (UTC)
In-Reply-To: <20130414152842.GB1544@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 14 Apr 2013 11:28:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5892576E-A534-11E2-B507-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221148>

Jeff King <peff@peff.net> writes:

> On Sat, Apr 13, 2013 at 11:04:48PM -0700, Junio C Hamano wrote:
>
>> Instead of using a single "slab" and keep reallocating it as we find
>> that we need to deal with commits with larger values of commit->index,
>> make a "slab" an array of many "slab_piece"s. Each access may need
>> two levels of indirections, but we only need to reallocate the first
>> level array of pointers when we have to grow the table this way.
>
> I don't know if shrinking the size of the realloc is all that big a
> deal. We are doubling, so the allocation cost is already amortized
> constant time.

I was more disturbed about copying the actual bytes. One of the
envisioned use of the mechanism is to give us unbound number of flag
bits to paint the history, and also this could be later used to
store larger structures per commit.

Also "you can now take a pointer" you illustrated (but I snipped
from here) is a good point.

>>  struct commit_slab {
>> -	int *buf;
>> -	int alloc;
>> +	int piece_size;
>> +	int piece_count;
>> +	struct commit_slab_piece **piece;
>>  };
>
> Is there a reason to make piece_size a struct member? It must be
> constant after any pieces are allocated. Is the intent that callers
> could do:
>
>   slab_init(&s);
>   /* I know ahead of time we are going to need N of these. */
>   s.piece_size = n;

The piece_size (later slab_size) is to hold the number of commits
each slice (i.e. the piece of memory s->slab[nth_slab] points at)
handles.
