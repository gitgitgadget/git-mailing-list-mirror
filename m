Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D8A71F859
	for <e@80x24.org>; Fri, 12 Aug 2016 18:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbcHLSLN (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 14:11:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59897 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751022AbcHLSLM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 14:11:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B7FDF34C1E;
	Fri, 12 Aug 2016 14:11:11 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=34I+SCJCc3pvDnjew76S/uPa8uo=; b=AcP5OG
	Pe62TsUWlxJ5j3S/fNBMMma/MxsN881Yy3wxINj5s+ysz19pb6Z5833Dxd8xaKlE
	ZAG6sCammG0d7qnpYnDvWtRi2D1X1ni0HF4+rUHpoksXQ1WgwYpkq2/0xLiR2Mr0
	3W/fNVyAe01ueiWUs4bjIw43+1X4k3Gv4Owgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oWvSZhDhP6vhpCdJtzCpg1BdtVuxitV2
	cUC3h7nNeDyWz8JXVenMRW8QmSVBl5jLY3cdHJvvkAOD1+opU6R5P4OlKcWZa0hM
	/FwKY0iKZFJ0y+dtnnDSU7oRcN3DviZvQtTKg7rqcbZeNZErP2lHtPoFYD8k0BYM
	eRgnmSStwEU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AEBAD34C1D;
	Fri, 12 Aug 2016 14:11:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2924E34C1C;
	Fri, 12 Aug 2016 14:11:11 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v12 11/13] bisect--helper: `bisect_next_check` & bisect_voc shell function in C
References: <010201567675adc1-17e27495-6b36-40d1-836d-814da029fcc4-000000@eu-west-1.amazonses.com>
	<010201567675ae68-15d79b9a-83fc-44ee-8607-07c2d0191c59-000000@eu-west-1.amazonses.com>
Date:	Fri, 12 Aug 2016 11:11:08 -0700
In-Reply-To: <010201567675ae68-15d79b9a-83fc-44ee-8607-07c2d0191c59-000000@eu-west-1.amazonses.com>
	(Pranit Bauva's message of "Wed, 10 Aug 2016 21:57:19 +0000")
Message-ID: <xmqq1t1tyi0z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 262802F4-60B8-11E6-A205-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> +static char *bisect_voc(char *revision_type)
> +{
> +	if (!strcmp(revision_type, "bad"))
> +		return "bad|new";
> +	if (!strcmp(revision_type, "good"))
> +		return "good|old";
> +
> +	return NULL;
> +}

I think you can return "const char *" from the above function.  Then
you do not have to do xstrdup() on the return values to store in
bad_syn and good_syn, and you do not have to free(3) them.

> +static int bisect_next_check(const struct bisect_terms *terms,
> +			     const char *current_term)
> +{
> + ....
> +		fprintf(stderr, N_("Warning: bisecting only with a %s commit\n"),
> +			terms->term_bad.buf);

Hmph, is this N_() and not _()?

> + ....
> +	}
> +	bad_syn = xstrdup(bisect_voc("bad"));
> +	good_syn = xstrdup(bisect_voc("good"));
> + ....
> +	free(bad_syn);
> +	free(good_syn);

