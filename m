From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] replace: add --graft option
Date: Thu, 05 Jun 2014 14:49:50 -0700
Message-ID: <xmqqfvjjrpq9.fsf@gitster.dls.corp.google.com>
References: <20140604194118.23903.3019.chriscool@tuxfamily.org>
	<20140604194353.23903.89933.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Jun 05 23:50:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsfYA-0000dv-VS
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 23:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbaFEVt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 17:49:58 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62583 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751354AbaFEVt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 17:49:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E790F1EFEA;
	Thu,  5 Jun 2014 17:49:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8abtZIKSxqfdTcWTSOdMxN1FIgY=; b=p07j0G
	Ighin2AiGI8RMsN38JSoQilmT5lzoPtdB+9nv4dqEYy4j/yRuHpeP6phONYXFT7T
	vmTBqnsaG7AzUtESCRqKCcz/tCTzZBLjJeCd/wo8udRbjsGdaG54IDfUUIpEDOLP
	sU5EX9iavskA03WyZbbD92OOYMoFqAUuuqdjY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mf1f6m+y2wKN8limqvNnTbSvJB3I4Rje
	2OAZCQLIc7tac2WgA/dIflgcuIbLM6E5O1Vvn4DkSpqYoTPm9Zyqrbww0z22XS/8
	A5lIFzW+nsjTTYB1/dOV3b3ZORfiIdsXo9qn/PdcrPqhzJEZyfqagtLZE0e8PdDW
	DUNvsyblv3c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DE16C1EFE9;
	Thu,  5 Jun 2014 17:49:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2EA0A1EFE8;
	Thu,  5 Jun 2014 17:49:52 -0400 (EDT)
In-Reply-To: <20140604194353.23903.89933.chriscool@tuxfamily.org> (Christian
	Couder's message of "Wed, 04 Jun 2014 21:43:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 52E1BA20-ECFB-11E3-9B81-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250867>

Christian Couder <chriscool@tuxfamily.org> writes:

> +static int create_graft(int argc, const char **argv, int force)
> +{
> +	unsigned char old[20], new[20];
> +	const char *old_ref = argv[0];
> +	struct commit *commit;
> +	struct strbuf buf = STRBUF_INIT;
> +	struct strbuf new_parents = STRBUF_INIT;
> +	const char *parent_start, *parent_end;
> +	int i;
> +
> +	if (get_sha1(old_ref, old) < 0)
> +		die(_("Not a valid object name: '%s'"), old_ref);
> +	commit = lookup_commit_or_die(old, old_ref);

Not a problem with this patch, but the above sequence somehow makes
me wonder if lookup-commit-or-die is a good API for this sort of
thing.  Wouldn't it be more natural if it took not "unsigned char
old[20]" but anything that would be understood by get_sha1()?

It could be that this particular caller is peculiar and all the
existing callers are happy, though.  I didn't "git grep" to spot
patterns in existing callers.

> +	if (read_sha1_commit(old, &buf))
> +		die(_("Invalid commit: '%s'"), old_ref);
> +	/* make sure the commit is not corrupt */
> +	if (parse_commit_buffer(commit, buf.buf, buf.len))
> +		die(_("Could not parse commit: '%s'"), old_ref);

It is unclear to me what you are trying to achieve with these two.
If the earlier lookup-commit has returned a commit object that has
already been parsed, parse_commit_buffer() would not check anything,
would it?

A typical sequence would look more like this:

    commit = lookup_commit(...);
    if (parse_commit(commit))
	oops there is an error;
    /* otherwise */
    use(commit->buffer);

without reading a commit object using low-level read-sha1-file
interface yourself, no?
