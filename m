Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0252020984
	for <e@80x24.org>; Tue, 13 Sep 2016 22:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758882AbcIMW4T (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 18:56:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54113 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755632AbcIMW4T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 18:56:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09CD13ED4F;
        Tue, 13 Sep 2016 18:56:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e3kULBtimkR6CQzSFPyvXSzMC7E=; b=Tjmzd8
        8I13VtwoTiDji6JRk4lp9uv38+pLlbdXjm3ibySoaZ8r2u1hSBM31PHYYX67yI2F
        9oU5xhmZab69wbt3w323gYlAyXKwd6DgIh2vbPhipPXqNFoPtc/eSNZf9ToVozhd
        S8LgiF1/68CdNEd+NW5pcNWkzztINNfAX7280=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R8lW+/hO/WaOxKfgiwD/R2ZaMaWIbSE1
        tRSWnTm/TPBqm6fC0XvXLwlzpKSqFB3dGgsDzdWWFt197uSBbKSotoKLrxnGtSRW
        gFGyq3U66I8pWPq+xU6rA71cL1oGuKZOZ+b3JCjNdn5NmxVNn3OGYSEsOOpYSgF8
        tlt+zEXn0Ew=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 005543ED4E;
        Tue, 13 Sep 2016 18:56:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7230A3ED4D;
        Tue, 13 Sep 2016 18:56:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     peff@peff.net, chriscool@tuxfamily.org, git@vger.kernel.org
Subject: Re: [RFC/PATCH 06/17] diff.c: convert fn_out_consume to use emit_line_*
References: <20160913044613.1037-1-sbeller@google.com>
        <20160913044613.1037-7-sbeller@google.com>
Date:   Tue, 13 Sep 2016 15:56:15 -0700
In-Reply-To: <20160913044613.1037-7-sbeller@google.com> (Stefan Beller's
        message of "Mon, 12 Sep 2016 21:46:02 -0700")
Message-ID: <xmqqtwdjtnn4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47867A28-7A05-11E6-BC0D-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> In a later patch, I want to propose an option to detect&color
> moved lines in a diff, which cannot be done in a one-pass over
> the diff. Instead we need to go over the whole diff twice,
> because we cannot detect the first line of the two corresponding
> lines (+ and -) that got moved.
>
> So to prepare the diff machinery for two pass algorithms
> (i.e. buffer it all up and then operate on the result),
> move all emissions to places, such that the only emitting
> function is emit_line_0.
>
> This covers the remaining parts of fn_out_consume.

name_x_tab are colored as before, which you are already aware of and
we'd need to find a way to handle, but other than that, this is a
no-op conversion, getting us closer to the goal of making everything
go through a single funnel.

>  		name_a_tab = strchr(ecbdata->label_path[0], ' ') ? "\t" : "";
>  		name_b_tab = strchr(ecbdata->label_path[1], ' ') ? "\t" : "";
> -
> -		fprintf(o->file, "%s%s--- %s%s%s\n",
> -			line_prefix, meta, ecbdata->label_path[0], reset, name_a_tab);
> -		fprintf(o->file, "%s%s+++ %s%s%s\n",
> -			line_prefix, meta, ecbdata->label_path[1], reset, name_b_tab);
> +		emit_line_fmt(o, meta, reset, "--- %s%s\n",
> +			      ecbdata->label_path[0], name_a_tab);
> +		emit_line_fmt(o, meta, reset, "+++ %s%s\n",
> +			      ecbdata->label_path[1], name_b_tab);
>  		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
>  	}
