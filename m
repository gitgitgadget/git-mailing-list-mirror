From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2 3/3] strbuf: allow to use preallocated memory
Date: Mon, 06 Jun 2016 15:44:07 -0700
Message-ID: <xmqqfusquedk.fsf@gitster.mtv.corp.google.com>
References: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr>
	<20160606151340.22424-4-william.duclot@ensimag.grenoble-inp.fr>
	<xmqqvb1mxmk4.fsf@gitster.mtv.corp.google.com>
	<20160606203901.GA7667@Messiaen>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, mhagger@alum.mit.edu,
	Johannes.Schindelin@gmx.de, peff@peff.net, mh@glandium.org
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 07 00:44:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA3Fu-000529-3R
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 00:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753617AbcFFWoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 18:44:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58812 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753612AbcFFWoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 18:44:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D16CA22271;
	Mon,  6 Jun 2016 18:44:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QHj98kTnwRrhKHeXLgS10HmUA8o=; b=ZKCfqS
	xOKck+w5+bq+6NRSV85YdfLP1oVz8IcbP+Tht/RJaSpIYZBvCEUZ8IjQHiadrAKL
	hM1k3XtADnLcOOxtRmogbsykssheDz5F40SOYoEgp8IBum5FLiu3X99TwW7vvtU4
	ylQu0FdD2IxOpuAQvpdYUCxuUpqB462+NhjK8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xSp/57Q1YRV3/tJJ5b2Tf/kRl0umWYOn
	SaHieW8VkAyrNmJl4Lh820euolIBG5VVhhlOXVLfVY8zpgqnbraHcGbVHezWaM+N
	g7NgDZB09YhfRN/fvKPhYltd+t4U6t4T5wynFDIADOy9/yi1FbTHQf30ql/ZNqTt
	libe+0Ryb0M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C8A8C22270;
	Mon,  6 Jun 2016 18:44:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D4472226F;
	Mon,  6 Jun 2016 18:44:09 -0400 (EDT)
In-Reply-To: <20160606203901.GA7667@Messiaen> (William Duclot's message of
	"Mon, 6 Jun 2016 22:39:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2EA82D6E-2C38-11E6-AA7A-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296569>

William Duclot <william.duclot@ensimag.grenoble-inp.fr> writes:

> I'm not sure to follow you. I agree that the "fixed strbuf" feature is
> flawed by the presence of this `die()`. But (unless misunderstanding)
> the "owns_memory" bit you talk about does exist in this patch, and allow
> the exact behavior you describe.

Imagine that I know most of my input lines are shorter than 80 bytes
and definitely shorter than 128 bytes.  I may want to say:

	/* allocate initial buffer ch[128] and attach it to line */
	struct strbuf line = STRBUF_INIT_ON_STACK(128);

	while (!strbuf_getline(&line, stdin)) {
		... use contents of &line ...
	}
        strbuf_release(&line);

knowing that I won't waste too much cycles and memory from heap most
of the time.  Further imagine that one line in the input happened to
be 200 bytes long.  After processing that line, the next call to
strbuf_getline() will call strbuf_reset(&line).

I think that call should reset line.buf to the original buffer on
the stack, instead of saying "Ok, I'll ignore the original memory
not owned by us and instead keep pointing at the allocated memory",
as the allocation was done as a fallback measure.  The reason why
strbuf_reset() is different from strbuf_release() is because we
anticipate that a buffer that is reset is going to be used again
very soon and want to avoid freeing only to call another alloc
immediately.  We just set its logical length to 0 without shrinking
what has already been allocated in the heap, because there is no
good hint that tells us what the optimal size of an empty
buffer in the particular caller that is waiting to be used before
this "improve API" effort.

But that "lack of hint" no longer is true with this "imporve API"
thing.  We _know_ that the caller thinks the anticipated typical
workload should fit well within the 128 bytes buffer that it
originally gave us.  That is what I'd expect from an "initialize a
reasonably sized piece of memory on stack and use it most of the
time in strbuf" feature.

> The patch allow to use a preallocated strbuf OR a preallocated-and-fixed
> strbuf. Does the "fixed" part is useful, that's very debatable.

"Fixed and non-extendable" is useless; there is no room for
debating.
