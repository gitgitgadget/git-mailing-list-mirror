From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] add functions for memory-efficient bitmaps
Date: Tue, 01 Jul 2014 09:57:13 -0700
Message-ID: <xmqqegy5xbiu.fsf@gitster.dls.corp.google.com>
References: <20140625233429.GA20457@sigill.intra.peff.net>
	<20140625234000.GD23146@sigill.intra.peff.net>
	<CAPig+cSc=A=+PR7oF43yeLpcd4n=Bd1KU1AHPfMKXEu5wAF4Ug@mail.gmail.com>
	<20140630170732.GA16747@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 01 18:57:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X21N6-0005L4-Je
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 18:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758413AbaGAQ52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 12:57:28 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61271 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758349AbaGAQ51 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 12:57:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9920023B36;
	Tue,  1 Jul 2014 12:57:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mzox70M1xAI4w8npW+Iu/MMppKk=; b=EpgfQv
	oH4KeldHlkvneKTI2/pXwQL7XoRV3HgrNbEPCM0LnZhNldNbRoPj9QkmnerVcS7g
	oZTeVxbVsZbF3IWLOGmXUvNwuSpooPzB3gvRC96yZNjsF8jhyHDkuSAbRep2W/Ei
	i1PYx8EfQ7PHQVx5sugUhFeWKJTfHZJQN/2qE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=okggJ33xmxg32VwNE7u8/66kD/YplTWr
	2KP3RobiXJ7fvLI1njylz7d4bk5GVAZ/F6jTgLhdj2WjgJH6ROYQdM5jA2hjR6Y5
	CKETycHnKuhVj5HU6pfMFP6BfJgybvrukUlCcNakMWGynw+d9V+AaDKsUZ9nkHKl
	JZGIX9qtwEw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8E08523B35;
	Tue,  1 Jul 2014 12:57:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0073523B1E;
	Tue,  1 Jul 2014 12:57:09 -0400 (EDT)
In-Reply-To: <20140630170732.GA16747@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 30 Jun 2014 13:07:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BDB319BC-0140-11E4-99D2-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252724>

Jeff King <peff@peff.net> writes:

> On Sun, Jun 29, 2014 at 03:41:37AM -0400, Eric Sunshine wrote:
>
>> > +static inline void bitset_set(unsigned char *bits, int n)
>> > +{
>> > +       bits[n / CHAR_BIT] |= 1 << (n % CHAR_BIT);
>> > +}
>> 
>> Is it intentional or an oversight that there is no way to clear a bit
>> in the set?
>
> Intentional in the sense that I had no need for it in my series, and I
> didn't think about it. I doubt many callers would want it, since commit
> traversals tend to propagate bits through the graph, and then clean them
> up all at once. And the right way to clean up slabbed data like this is
> to just clear the slab.
>
> Of course somebody may use the code for something besides commit
> traversals. But I'd rather avoid adding dead code on the off chance that
> somebody uses it later (and then gets to find out whether it even works
> or not!).

Another thing I noticed was that the definition of and the
commentary on bitset_equal() and bitset_empty() sounded somewhat
"undecided".  These functions take "max" that is deliberately named
differently from "num_bits" (the width of the bitsets involved),
inviting to use them for testing only earlier bits in the bitset as
long as the caller understands the caveat, but the caveat requires
that the partial bitset to test must be byte-aligned, which makes it
not very useful in practice, which means we probably do not want
them to be used for any "max" other than "num_bits".

They probably would want either:

 * be made to truly honor max < num_bits case, by special casing the
   last byte that has max-th bit, to officially allow them to be
   used for partial bitset test; or

 * take "num_bits", not "max", to clarify that callers must use them
   only on the full bitset.

In either case, there needs another item in the "caller's responsibility"
list at the beginning of bitset.h:

    4. Ensure that padding bits at the end of the bitset array are
       initialized to 0.

In the description of bitset_sizeof(), the comment hints it by using
xcalloc() in the example, but a careless user may be tempted to
implement bitset_clr() and then do:

        int i;
        unsigned char *bits = malloc(bitset_sizeof(nr));
        for (i = 0; i < nr; i++)
        	bitset_clr(bits, i);
	assert(bitset_empty(bits, nr));

and the implementation of bitset_empty(), even if we rename
s/max/num_bits/, will choke if (nr % CHAR_BIT) and malloc() gave us
non-zero bit in the padding.

For the sake of simplicity, I am inclined to vote for not allowing
their use on a partial-sub-bitset.
