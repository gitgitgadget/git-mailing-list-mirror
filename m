Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 418231F71B
	for <e@80x24.org>; Tue,  2 Aug 2016 18:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932839AbcHBS4P (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 14:56:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62859 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754398AbcHBSyW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 14:54:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 042F1325C8;
	Tue,  2 Aug 2016 14:53:33 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JF+dZw+JSiQB+E4BLuy1dert3bo=; b=ZsVfUz
	bNsnbkpN9992FNnnIogjN4wD0oCT6VaZ9Do7SUJ8028AgPA6xyYnFDZ83HrLgOKv
	LriD/Z3ufBW4vCluWfdJdXd6QEGfSgNSc3zOPQEb6V5CtsLEMEngiSheR34oDRGS
	MeYq4KvZ9lmSCBeXF8Cqz4jFoh2ZmyJPUl+zo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iFOWsoJw7M55/WuKn3qpbywlAROmqcvZ
	c0jE1R3r+2nu1geoY0Qn6NKZXJg4vU0rPkFXKwdZgjn8CtQjTvn5kX04+BtuwYhl
	ogxJvr5oOD1oKXky0AIFgP25SMzI3vbNXqekjvdBJfgFiPbN+gPoeW0+DFEqiUvQ
	/hDei8FI88E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E770A325C7;
	Tue,  2 Aug 2016 14:53:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6051C325C5;
	Tue,  2 Aug 2016 14:53:32 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [RFC/PATCH v11 10/13] bisect--helper: `check_and_set_terms` shell function in C
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
	<0102015640423cfd-dbacb682-b6fe-4417-a3f2-2c2c6673263c-000000@eu-west-1.amazonses.com>
Date:	Tue, 02 Aug 2016 11:53:30 -0700
In-Reply-To: <0102015640423cfd-dbacb682-b6fe-4417-a3f2-2c2c6673263c-000000@eu-west-1.amazonses.com>
	(Pranit Bauva's message of "Sun, 31 Jul 2016 09:21:38 +0000")
Message-ID: <xmqqa8gvdmtx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68B718E0-58E2-11E6-A546-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> Reimplement the `check_and_set_terms` shell function in C and add
> `check-and-set-terms` subcommand to `git bisect--helper` to call it from
> git-bisect.sh
>
> Using `--check-and-set-terms` subcommand is a temporary measure to port
> shell function in C so as to use the existing test suite. As more
> functions are ported, this subcommand will be retired and will be called
> by some other methods.

I think "this subcommand will be retired but its implementation will
be called by ..." would clarify the direction.

> +	if (!no_term_file &&
> +	    strcmp(cmd, terms->term_bad.buf) &&
> +	    strcmp(cmd, terms->term_good.buf))
> +		return error(_("Invalid command: you're currently in a "
> +				"'%s' '%s' bisect"), terms->term_bad.buf,

This changes a message text, switching from "... good/bad bisect."
to "... 'good' 'bad' bisect".  Intended?

