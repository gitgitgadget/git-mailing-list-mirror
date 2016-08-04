Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8019F20193
	for <e@80x24.org>; Thu,  4 Aug 2016 19:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965650AbcHDTwn (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 15:52:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61900 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965424AbcHDTwm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 15:52:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A22731451;
	Thu,  4 Aug 2016 15:52:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KRO6ox7/jaG1Dqf52WKBK6RAaz0=; b=EEOT+q
	fiiSkFuJ6b1+R2iLdths+vBC4iRtXSAFadxKqL7RnG5xMO6PWY55AYQRMSHI/D3V
	QnzxFM6Onnnu8elEaUuhK1m2penA/PM25j6ux60gINsAkAVjdZUPtZmi7Rvy+r2+
	aGj9TM/JhIV/a/mm0afFrc4vuCAOqohPOGhsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GmM22GY/wamFAusfi7JFDuBjpYnIOILZ
	qPiK04rm5+WBzUAcWjy+KdqRG8MNBwM6MFhZK5Ag9GdS69gGotbeCDSrBP2zQ83T
	g92LpQ3vHpRWgyrSxA6cn4SXxez/JbXrnEYMobb2fVMvIIu1feZpESexjqjeKmmR
	MHie8vUGBf0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 811D531450;
	Thu,  4 Aug 2016 15:52:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 089A03144F;
	Thu,  4 Aug 2016 15:52:36 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Jeff King <peff@peff.net>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 8/8] diff: improve positioning of add/delete blocks in diffs
References: <cover.1470259583.git.mhagger@alum.mit.edu>
	<7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
Date:	Thu, 04 Aug 2016 12:52:33 -0700
In-Reply-To: <7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Thu, 4 Aug 2016 00:00:36 +0200")
Message-ID: <xmqq37mk2txa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FDC0A64A-5A7C-11E6-8B89-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

I agree with Peff about "comment on the voodoo upfront".

> +#define START_OF_FILE_BONUS 9
> +#define END_OF_FILE_BONUS 46
> +#define TOTAL_BLANK_WEIGHT 4
> +#define PRE_BLANK_WEIGHT 16
> +#define RELATIVE_INDENT_BONUS -1
> +#define RELATIVE_INDENT_HAS_BLANK_BONUS 15
> +#define RELATIVE_OUTDENT_BONUS -19
> +#define RELATIVE_OUTDENT_HAS_BLANK_BONUS 2

When I read up to here, I thought "Heh, isn't the opposite of INdent
DEdent?" and then saw this:

> +#define RELATIVE_DEDENT_BONUS -63
> +#define RELATIVE_DEDENT_HAS_BLANK_BONUS 50

It turns out that you mean by OUTdent a line that indents further
(if I am reading the code correctly).  Is that obvious to everybody?

> +	/* Bonuses based on the location of blank lines: */
> +        bonus += TOTAL_BLANK_WEIGHT * total_blanks;
> +	bonus += PRE_BLANK_WEIGHT * m->pre_blank;

This and ...

> +        } else if (indent > m->pre_indent) {
> +		/*
> +		 * The line is indented more than its predecessor. Score it based
> +		 * on the larger indent:
> +		 */
> +		score = indent;
> +		bonus += RELATIVE_INDENT_BONUS;
> +		bonus += RELATIVE_INDENT_HAS_BLANK_BONUS * any_blanks;
> +	} else if (indent < m->pre_indent) {

... this seems to be indented correctly even after getting quoted,
which in turn means most of the lines in the added code share
indent-with-non-tab badness.
