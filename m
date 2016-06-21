Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28E4A1FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 21:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbcFUVPW (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 17:15:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63351 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750731AbcFUVPR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 17:15:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CB5225718;
	Tue, 21 Jun 2016 17:15:16 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LqWrtbWuMJWq1DkRywyrAPrdqOA=; b=TUvUeA
	gtSZtPXh+ax+shKM1VrpBUfRsLwYzdvDCL2t12x95N+OctgGWcvTaWFf+D8fV2Co
	Nnc9UD0QkShQm21UEcV9TPjMuzSqQ69VRdFIB+hRx0GuANiOPkfd9Aa94/D9+kx2
	pq+jKtwxC2BkzasXKTuhsJuyqOurKZxvtUb50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FgZ7wH1Tq4aYJZG7slr54UQRoeBQodi1
	iqrljaWnqpVeTeJqJ6c/ngiOI83pyDiAhT4uwGXgaLcstSTpmibumYXc1uCqgNrX
	rrH9cJ3aztEw199IwS68e1Q0MfnjjoJjRKAnFe2wxP33nRDW7vMiCJlzaCqm4qb+
	CeuH6orrA2A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 33A0225717;
	Tue, 21 Jun 2016 17:15:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AA5202570F;
	Tue, 21 Jun 2016 17:15:15 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] Make find_commit_subject() more robust
References: <34ef85eb4e2aef0b342ef5d3bce9e468c8339486.1466255489.git.johannes.schindelin@gmx.de>
	<xmqqeg7ru00i.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1606211402320.22630@virtualbox>
Date:	Tue, 21 Jun 2016 14:15:13 -0700
In-Reply-To: <alpine.DEB.2.20.1606211402320.22630@virtualbox> (Johannes
	Schindelin's message of "Tue, 21 Jun 2016 14:03:27 +0200 (CEST)")
Message-ID: <xmqqziqent0e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3FBA8232-37F5-11E6-B4C1-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 20 Jun 2016, Junio C Hamano wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>> > Just like the pretty printing machinery, we should simply ignore empty
>> > lines at the beginning of the commit messages.
>> >
>> > This discrepancy was noticed when an early version of the rebase--helper
>> > produced commit objects with more than one empty line between the header
>> > and the commit message.
>> >
>> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> > ---
>> > Published-As: https://github.com/dscho/git/releases/tag/leading-empty-lines-v1
>> >
>> > 	Aaaaand another patch from the rebase--helper front. I guess I'll
>> > 	call it a day with this one.
>> 
>> Makes sense.  This has a trivial textual conflict with cleanup
>> patches in flight, I think, but that is not a big problem.
>
> I will gladly resend rebased to `next`, if you wish.

No, I'd prefer a patch that applies to 'master' for a new feature;
there is no need to deliberately get taken hostage by other topics.

>> It does hint that we might want to find a library function that can
>> replace a hand-rolled while loop we are adding here, though ;-)
>
> Heh. I cannot help you with that ;-)

The reason it hints such a thing is because the line nearby that
does this:

  		for (eol = p; *eol && *eol != '\n'; eol++)
  			; /* do nothing */

gets rewritten to

		eol = strchrnul(p, '\n');

i.e. "give me the pointer to the first byte that is '\n', or EOS".

Your patch introduces a similar loop with similar (but different)
purpose:

		while (*p == '\n')
			p++;

which would have been helped if there were a helper with an
opposite function, i.e.

		p = strcchrnul(p, '\n');

i.e. "give me the pointer to the first byte that is not '\n', or EOS".

But there is no such thing.  Although p += strcspn(p, "\n") is a
possibility, that somehow feels a bit odd.  And that is why I did
not hint any existing function and said "might want to find".

HOWEVER.

Stepping back a bit, I think what we actually want is

		p = skip_blank_lines(p);

that skips any and all blank lines, including an empty line that
consists of all whitespace.

For example

	(
		# grab the header lines
		git cat-file commit HEAD | sed -e '/^$/q'
                # throw in random blank lines
		echo
                echo " "
                echo "  "
                echo "   "
                echo
                echo "Title line"
	) | git hash-object -w -t commit --stdin

would mint a commit object that has many blank lines in the front,
some have whitespace and are not empty.  If you give it to

	git show -s | cat -e
        git show -s --oneline | cat -e

I think you would see what I mean.
