Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28A49203E2
	for <e@80x24.org>; Fri, 19 Aug 2016 01:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754533AbcHSBOG (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 21:14:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52483 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754072AbcHSBEv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 21:04:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EE2533097;
        Thu, 18 Aug 2016 13:08:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wk6lWDuUonJQivbc3Ze/QxH6+Ig=; b=db2WBk
        gw3KfGfXWa3EFXvF52l9CuuNlGREjGXP8pfbCkF1NPJ85zG0lsuLyJPgu6e4mF86
        mTpvOKCUqww8WrEXQwrnqSmoj0ilQCw6X0mU/76p9TRj+RrMLfVHsqUqg+MeaQu4
        cH3A3Q7/zoQSBDttZdFeLTbDk2v/2xIg3CFso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d08jJR5fOXj2lsTWcRuFSJnpXzC7Y+bG
        RptPCHZO2gA/qBHEqB55MZQqexsBPS411oKz1Jc6+eJkB32B5vX8GL5cjqE/wicS
        Kc+6/uZO+km9+eDrryYZNAkdLPqzbCaYMxV0hZiVJiSIewlDKkMPyv8bpPg2sB5I
        iDLfSfyg7Ds=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9875A33096;
        Thu, 18 Aug 2016 13:08:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3553733094;
        Thu, 18 Aug 2016 13:08:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] cat-file: support --textconv/--filters in batch mode
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
        <2315ae5ab6918a7c1567f11a64093a860983bc20.1471524357.git.johannes.schindelin@gmx.de>
Date:   Thu, 18 Aug 2016 10:08:00 -0700
In-Reply-To: <2315ae5ab6918a7c1567f11a64093a860983bc20.1471524357.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 18 Aug 2016 14:46:28 +0200
        (CEST)")
Message-ID: <xmqqbn0q6m4v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 523EB344-6566-11E6-A96F-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> With this patch, --batch can be combined with --textconv or --filters.
> For this to work, the input needs to have the form
>
> 	<object name><single white space><path>
>
> so that the filters can be chosen appropriately.
>  --batch::
>  --batch=<format>::
>  	Print object information and contents for each object provided
> -	on stdin.  May not be combined with any other options or arguments.
> -	See the section `BATCH OUTPUT` below for details.
> +	on stdin.  May not be combined with any other options or arguments
> +	except `--textconv` or `--filters`, in which case the input lines
> +	also need to specify the path, separated by white space.  See the
> +	section `BATCH OUTPUT` below for details.

Makes sense.  This format still allows

	HEAD:<path2> <path1>

i.e. the object name is taken from path2 but we forget it and
pretend that the blob sits at path2, which is a good feature.

If I am not mistaken, your cover letter alluded that it might be
ideal to take "HEAD:<path>" (nothing else) as input, grab "<path>"
and feed that to the filtering machinery, but you decided to stop
short of doing that.  I actually think that it is the right thing to
do for this feature to ignore the trailing :<path> in the object
name, iow, I agree with the result from the feature design POV.

The only thing that somewhat is worrysome is what would happen to
%(rest).  I guess [*1*] it is OK to declare that you cannot use %(rest) in
your output format when --filter/--textconv is in use, but if that
is the direction we are going, that limitation needs to be
documented.


[Footnote]

*1* This is just a "guess", because I do not know what people are
using %(rest) for.  It is plausible that their use case do not need
--filter/--textconv at all, and if that is the case, having this
limitation is perfectly fine.
