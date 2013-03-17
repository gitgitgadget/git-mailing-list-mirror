From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] pack-refs: add fully-peeled trait
Date: Sun, 17 Mar 2013 13:01:44 -0700
Message-ID: <7vli9lre1j.fsf@alter.siamese.dyndns.org>
References: <20130317082139.GA29505@sigill.intra.peff.net>
 <20130317082829.GD29550@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 17 21:02:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHJmZ-0006Wa-9N
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 21:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318Ab3CQUBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 16:01:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56475 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756411Ab3CQUBs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 16:01:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8778BA120;
	Sun, 17 Mar 2013 16:01:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QewmjUN2i6IN/nqlyzmZCnxM2mg=; b=rR2V3w
	F+lD/+5dRSwVjjyBR8W/yUU1CFv0vC/sy/NkByIn15SdxFQyoSew4oV79ddyBL8i
	zUX58ouk8y8Zltlm43DB+eY4Tr+CPO1DRxU+/Lm/siipaCWS0dPm8LeTNjqsMSLQ
	tcsOGFtrDIHXgvCv2OdfT18e0dX6pBX9Vnwoc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YehtdrEki1/ss6vQKfZa9Vw9Z+/A5mZE
	jFRy5cHOYBDQqw6wk6SuCmZGTTeaC7svM/bjdjpaii10/XpTQW9gz3I9cRiI9HVg
	pPfXi+fVKJRi2FS3Ni8QuQrFmoqy8JnoM8dCry5LIUWnm3LTuRbdwuz5lywTuUPy
	AQ28QzMgIsY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C4D2A11F;
	Sun, 17 Mar 2013 16:01:47 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72AA6A11C; Sun, 17 Mar 2013
 16:01:46 -0400 (EDT)
In-Reply-To: <20130317082829.GD29550@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 17 Mar 2013 04:28:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7F39532A-8F3D-11E2-AF8A-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218369>

Jeff King <peff@peff.net> writes:

> From: Michael Haggerty <mhagger@alum.mit.edu>
>
> Older versions of pack-refs did not write peel lines for
> refs outside of refs/tags. This meant that on reading the
> pack-refs file, we might set the REF_KNOWS_PEELED flag for
> such a ref, even though we do not know anything about its
> peeled value.
>
> The previous commit updated the writer to always peel, no
> matter what the ref is. That means that packed-refs files
> written by newer versions of git are fine to be read by both
> old and new versions of git. However, we still have the
> problem of reading packed-refs files written by older
> versions of git, or by other implementations which have not
> yet learned the same trick.
>
> The simplest fix would be to always unset the
> REF_KNOWS_PEELED flag for refs outside of refs/tags that do
> not have a peel line (if it has a peel line, we know it is
> valid, but we cannot assume a missing peel line means
> anything). But that loses an important optimization, as
> upload-pack should not need to load the object pointed to by
> refs/heads/foo to determine that it is not a tag.
>
> Instead, we add a "fully-peeled" trait to the packed-refs
> file. If it is set, we know that we can trust a missing peel
> line to mean that a ref cannot be peeled. Otherwise, we fall
> back to assuming nothing.
>
> [commit message and tests by Jeff King <peff@peff.net>]
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This uses Michael's approach for managing the flags within
> read_packed_refs, which is more readable. As I picked up his
> code and comments, I realized that there was basically
> nothing of mine left, so I switched the authorship. But do
> note:
>
>   1. It should have Michael's signoff, which was not present
>      in the commit I lifted the code from.
>
>   2. I tweaked the big comment above read_packed_refs to
>      reduce some ambiguities. Please double-check that I am
>      not putting inaccurate words in your mouth. :)
>
>  pack-refs.c         |  2 +-
>  refs.c              | 43 +++++++++++++++++++++++++++++++++++++++++--
>  t/t3211-peel-ref.sh | 22 ++++++++++++++++++++++
>  3 files changed, 64 insertions(+), 3 deletions(-)
>
> diff --git a/pack-refs.c b/pack-refs.c
> index ebde785..4461f71 100644
> --- a/pack-refs.c
> +++ b/pack-refs.c
> @@ -128,7 +128,7 @@ int pack_refs(unsigned int flags)
>  		die_errno("unable to create ref-pack file structure");
>  
>  	/* perhaps other traits later as well */
> -	fprintf(cbdata.refs_file, "# pack-refs with: peeled \n");
> +	fprintf(cbdata.refs_file, "# pack-refs with: peeled fully-peeled \n");
>  
>  	for_each_ref(handle_one_ref, &cbdata);
>  	if (ferror(cbdata.refs_file))
> diff --git a/refs.c b/refs.c
> index 175b9fc..bdeac28 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -803,11 +803,39 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
>  	return line;
>  }
>  
> +/*
> + * Read f, which is a packed-refs file, into dir.
> + *
> + * A comment line of the form "# pack-refs with: " may contain zero or
> + * more traits. We interpret the traits as follows:
> + *
> + *   No traits:
> + *
> + *	Probably no references are peeled. But if the file contains a
> + *	peeled value for a reference, we will use it.
> + *
> + *   peeled:
> + *
> + *      References under "refs/tags/", if they *can* be peeled, *are*
> + *      peeled in this file. References outside of "refs/tags/" are
> + *      probably not peeled even if they could have been, but if we find
> + *      a peeled value for such a reference we will use it.
> + *
> + *   fully-peeled:
> + *
> + *      All references in the file that can be peeled are peeled.
> + *      Inversely (and this is more important, any references in the

A missing closing paren after "more important".  Also the e-mail
quote reveals there is some inconsistent indentation (HTs vs runs of
SPs) here.

> + *      file for which no peeled value is recorded is not peelable. This
> + *      trait should typically be written alongside "fully-peeled" for

Alongside "peeled", no?

> @@ -816,8 +844,10 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
>  
>  		if (!strncmp(refline, header, sizeof(header)-1)) {
>  			const char *traits = refline + sizeof(header) - 1;
> -			if (strstr(traits, " peeled "))
> +			if (strstr(traits, " fully-peeled "))
>  				flag |= REF_KNOWS_PEELED;
> +			else if (strstr(traits, " peeled "))
> +				refs_tags_peeled = 1;
>  			/* perhaps other traits later as well */
>  			continue;
>  		}
> @@ -825,6 +855,8 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
>  		refname = parse_ref_line(refline, sha1);
>  		if (refname) {
>  			last = create_ref_entry(refname, sha1, flag, 1);
> +			if (refs_tags_peeled && !prefixcmp(refname, "refs/tags/"))
> +				last->flag |= REF_KNOWS_PEELED;

I am not sure why you find this any more readable.

The "flag" is set earlier to contain REF_KNOWS_PEELED only when we
have fully-peeled trait, and peeled trait is recorded as a separate
local variable.  The fully-peeled case sets the flag by passing the
flag to create_ref_entry() but the peeled case adds it to last->flag
manually after the fact.

If you set two local variables when you read the traits (iow, no
futzing with "flag" there), this part would become either:

	last = create_ref_entry(refname, sha1, REF_ISPACKED, 1);
	if (refs_fully_peeled ||
            (refs_tags_peeled && !prefixcmp(refname, "refs/tags/")))
	    last->flag |= REF_KNOWS_PEELED;

or

	flag = REF_ISPACKED;
	if (refs_fully_peeled ||
            (refs_tags_peeled && !prefixcmp(refname, "refs/tags/")))
	    flag |= REF_KNOWS_PEELED;
	last = create_ref_entry(refname, sha1, flag, 1);

either of which would be much more readable at least to me.
