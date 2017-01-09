Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 088CC1FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 21:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757543AbdAIV5y (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 16:57:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50815 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752484AbdAIV5x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 16:57:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 983645ED10;
        Mon,  9 Jan 2017 16:57:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vU/oibzQEb6qzigU07htNJ3hiXg=; b=xfF7Rd
        CXt6425rSS9qwrpZ8uVI9z62LB6RpQKBfJIwHcn/Pg8dtNQIIYXBykApsmrE0SLH
        89KAu9WyeHmpRZGxubxU/ZQI6zrepWSEXQ5PSEWhroV+DYDK4qTpnjq4oymP0XnG
        vRJUp8vA2HsjgjiWrnI3mXRDhew08pn1hhuUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ik23zHLvjGOHTnxalq0Vsy2SzkuYEcVn
        5+L0yXtOtQZylpCGjr8+vx+Ny6SZeV0C5cGyhqqqQeefFsf/o3G9BnhJIR2IUA+y
        eL2W5GMsGaUdOQ5AwcUoBODD622Gs4ynzTp+Y/K+pfyYSz2T+GsdWZ3jJMLfKlfg
        TGe/ZH2zp+g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8EA885ED0F;
        Mon,  9 Jan 2017 16:57:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 019C65ED0E;
        Mon,  9 Jan 2017 16:57:50 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] blame: output porcelain "previous" header for each file
References: <20170106041541.rjzzofal5hscv6yi@sigill.intra.peff.net>
        <20170106042051.nwjiuyyp7ljhs4sr@sigill.intra.peff.net>
Date:   Mon, 09 Jan 2017 13:57:49 -0800
In-Reply-To: <20170106042051.nwjiuyyp7ljhs4sr@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 5 Jan 2017 23:20:51 -0500")
Message-ID: <xmqqmvezuc9u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA41ED06-D6B6-11E6-A856-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>  /*
> + * Write out any suspect information which depends on the path. This must be
> + * handled separately from emit_one_suspect_detail(), because a given commit
> + * may have changes in multiple paths. So this needs to appear each time
> + * we mention a new group.
> + *
>   * To allow LF and other nonportable characters in pathnames,
>   * they are c-style quoted as needed.
>   */
> -static void write_filename_info(const char *path)
> +static void write_filename_info(struct origin *suspect)
>  {
> +	if (suspect->previous) {
> +		struct origin *prev = suspect->previous;
> +		printf("previous %s ", oid_to_hex(&prev->commit->object.oid));
> +		write_name_quoted(prev->path, stdout, '\n');
> +	}
>  	printf("filename ");
> -	write_name_quoted(path, stdout, '\n');
> +	write_name_quoted(suspect->path, stdout, '\n');
>  }

Yes, "previous" is not per commit but per "origin", and "origin" is
(commit, path) pair, so allowing this helper to examine the entire
suspect instead of just suspect->path makes sense.

Thanks for a fix.
