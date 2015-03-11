From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/10] Use a structure for object IDs.
Date: Wed, 11 Mar 2015 13:35:06 -0700
Message-ID: <xmqqk2yn5l39.fsf@gitster.dls.corp.google.com>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
	<5500689A.5090101@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 11 21:35:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVnLX-0005EM-G1
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 21:35:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbbCKUfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 16:35:10 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55339 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750964AbbCKUfI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 16:35:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D65F3EEFF;
	Wed, 11 Mar 2015 16:35:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KjZcfoK4Ez4pK/spBIEE6IfXdQo=; b=yi0vM4
	WDTtx4dZsjTDduG2/qkGEuTbRoaLX2xN75VIHJuh0cF7YWZVWFNNBtJLXfBGzgV5
	JgoCf5Myrvb7290PYEpI2bFZ9il0MmGgg7KAz1WUafRaEucBZfLFultdQ26F3I+a
	t2a6mrYBYGYwv+KX8DvYchooHmEqxV+3PVjUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tlSIsbrnxUV8/MXm+r6LBDZ/PMaoaGz+
	5uacIRAwL3nB7Q8AAVIFhReCNn/hBQbfc2Uj+4kGn7j/gqWf5e/iEvC8yjSxzHVP
	Hi2wQvGkvcQFpnOBBjov+c01C4uYx/nErcavJSK1JfL9Fp7DuEDjzvUijFc7G6/6
	Na0+H9LRhNc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E76CA3EEFE;
	Wed, 11 Mar 2015 16:35:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 502163EEFD;
	Wed, 11 Mar 2015 16:35:07 -0400 (EDT)
In-Reply-To: <5500689A.5090101@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 11 Mar 2015 17:08:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1AF2BE7A-C82E-11E4-AD06-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265337>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I think this is a really interesting project and I hope that it works out.

Count me in ;-)

> In my opinion, the biggest risk (aside from the sheer amount of work
> required) is the issue that was brought up on the mailing list when you
> submitted v1 [1]: Converting an arbitrary (unsigned char *) to a (struct
> object_id *) is not allowed, because the alignment requirements of the
> latter might be stricter than those of the former. This means that if,
> for example, we are reading some data from disk or from the network, and
> we expect the 20 bytes starting with byte number 17 to be a SHA-1 in
> binary format, we used to be able to do
>
>     unsigned char *sha1 = buf + 17;
>
> and use sha1 like any other SHA-1, without the need for any copying. But
> we can't do the analogous
>
>     struct object_id *oid = (struct object_id *)(buf + 17);
>
> because the alignment is not necessarily correct. So in a pure "struct
> object_id" world, I think we would be forced to change such code to
>
>     struct object_id oid;
>     hashcpy(oid.sha1, buf + 17);
>
> This uses additional memory and introduces copying overhead. Also, the
> lifetime of oid might exceed the scope of a function, so oid might have
> to be allocated on the heap and later freed. This adds more
> computational overhead, more memory overhead, and more programming
> effort to get it all right.

Because we use abstraction to reduce burden on programmers, the last
point is really what defeats this approach.

I wonder if there is any way to make the new "oid wrapped in a
struct" result in identical binary---that would be a reasonable
criterion to judge the goodness of a change line this.  Any
difference could be (1) compiler being (a) stupid and not taking
optimization opportunity it notices for a bare byte array but not
for a byte array in struct or (b) clever and taking optimization
opportunity the other way around, or (2) breakage in the conversion
causing new bugs, perhaps coming from the "alignment" worries you
cited above.  (1-a) may or may not be an acceptable price to pay for
a cleaner abstraction, but that depends on the extent of damage.
(1-b) may be unlikely but if there is such a gain, that's nice ;-).
And (2) is obviously a show-stopper X-<.

> So as much as I like the idea of wrapping SHA-1s in objects, I think it
> would be a good idea to first make sure that we can all agree on a plan
> for dealing with situations like this. I can think of the following
> possibilities:

These all look sensible to me.

> 4. We continue to support working with SHA-1s declared to be (unsigned
> char *) in some performance-critical code, even as we migrate most other
> code to using SHA-1s embedded within a (struct object_id). This will
> cost some duplication of code. To accept this approach, we would need an
> idea of *how much* code duplication would be needed. E.g., how many
> functions will need both (unsigned char *) versions and (struct
> object_id *) versions?

Ideally, only the ones that knows the underlying hash function is
SHA-1 (i.e. anybody who mentions git_SHA_CTX), moves bytes from/to
in-core object name field and raw range of bytes (e.g. sha1hash());
everybody else like hashcpy() and hashcmp() should be able to do its
thing only on structs and a generic-looking constant that denotes
how many bytes there are in the hash (or even sizeof(struct oid)).

I do not know what kind of code duplication you are worried about,
though.  If a callee needs "unsigned char *", the caller that has a
"struct object_id *o" should pass o->hash to the callee.  We should
not add another variant of the same callee that takes a pointer to
"struct object_id"---I think that leads to insanty, e.g.

    int hashcmp_o_o(struct object_id *, struct object_id *);
    int hashcmp_o_b(struct object_id *, unsigned char *);
    int hashcmp_b_o(unsigned char *, struct object_id *);
    int hashcmp_b_b(unsigned char *, unsigned char *);

And please do not suggest switching to C++; all it would do to
overload these into a single name is to make the callers harder to
read.
