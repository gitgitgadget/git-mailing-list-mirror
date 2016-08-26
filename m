Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABDD71FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 23:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754114AbcHZXHO (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 19:07:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53323 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752161AbcHZXHN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 19:07:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A1843A645;
        Fri, 26 Aug 2016 19:07:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J+MrDttGvMOUy8kNcQIgC0hjr/k=; b=h64kSA
        04bigOmL5HOwljm1mYj9FG7Uk1Irp7iOp31M+vvVp8FuY2jsGWTOXFwZbMo4SUfe
        wc7fBTUv5IYGtE93FUGXZYTWHHomGMapI4xtbuX0Ro4m2yinnI+EP8jEJUgnOtSg
        yRcIoewEGWVq7LQL22cCfpz8yToqmD3y4OoTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xTNsvsdJu/ylRdlB6F5uibugeWVj/Gvu
        /ItSbOcTteundid3ktxL3hMSte8yh2B18W4Ovbvme645DivY4w3bN81e6HyAfvO5
        laMTXp7W51k7VM/ROUU1wQYen1SIUenPgtC2ipWQrMX3FWzQ8d1BVc0Gv/25NPg6
        V/tIHFKSO0Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 334873A644;
        Fri, 26 Aug 2016 19:07:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A5B253A643;
        Fri, 26 Aug 2016 19:07:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v14 21/27] bisect--helper: `bisect_log` shell function in C
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
        <01020156b73fe6d5-6a363195-eb91-48a0-9a3c-3159fba6d327-000000@eu-west-1.amazonses.com>
Date:   Fri, 26 Aug 2016 16:07:09 -0700
In-Reply-To: <01020156b73fe6d5-6a363195-eb91-48a0-9a3c-3159fba6d327-000000@eu-west-1.amazonses.com>
        (Pranit Bauva's message of "Tue, 23 Aug 2016 11:53:53 +0000")
Message-ID: <xmqqbn0fdt9e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D207F082-6BE1-11E6-B261-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> +static int bisect_log(void)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	if (strbuf_read_file(&buf, git_path_bisect_log(), 256) < 0) {
> +		strbuf_release(&buf);
> +		return error(_("We are not bisecting.\n"));
> +	}
> +
> +	printf("%s", buf.buf);
> +	strbuf_release(&buf);
> +
> +	return 0;
> +}

Hmph, is it really necessary to slurp everything in a strbuf before
sending it out to the standard output?  Wouldn't it be sufficient to
open a file descriptor for reading on the log file and then hand it
over to copy.c::copy_fd()?

