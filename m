Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3879C1FBB0
	for <e@80x24.org>; Mon,  5 Sep 2016 18:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934391AbcIES5S (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 14:57:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52567 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933659AbcIES5R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 14:57:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 74E7D3ABE6;
        Mon,  5 Sep 2016 14:57:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yOeUTQdqFznsNWORc/r6s2Tb7SU=; b=P4rEN7
        EGoZpNbFXh5+e/QIe12WNrIOc0Yik7xRdyNSE/X7xD5CBWiO5O99Cw8KyzFqdKiA
        jNqkpDCl7swdVBNd967Xw4QJm2ho2lMfuav+wgik8yoQsBnKRKNLz1btwe/xnvZe
        26a5psy0B6kIV93vov4lF2cCH150clhuuZ9xs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g7NH2Kf+cqhT8E+pELh1umd2/JX8SGCY
        HT3yeueRH2olntmxtdeEA9KZ1EKHyM2ZWuEjQjxLIQoj0hbf8A41qcFZkUQenQF/
        uh3rJ8FnIxH8K4Fhr8HvX7PALxAuly6n5DSg6BcjLe8ZFVOE1u6NRPxyjWfB9pKp
        66XyNhEMWoI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CFB63ABE5;
        Mon,  5 Sep 2016 14:57:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EC94B3ABE4;
        Mon,  5 Sep 2016 14:57:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <stefanbeller@gmail.com>
Cc:     git@vger.kernel.org, jnareb@gmail.com, jacob.keller@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: Re: [WIP PATCH v2] diff.c: emit moved lines with a different color
References: <20160904191435.14144-1-stefanbeller@gmail.com>
Date:   Mon, 05 Sep 2016 11:57:12 -0700
In-Reply-To: <20160904191435.14144-1-stefanbeller@gmail.com> (Stefan Beller's
        message of "Sun, 4 Sep 2016 12:14:35 -0700")
Message-ID: <xmqq1t0yqinr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F6D9F54-739A-11E6-9877-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <stefanbeller@gmail.com> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 0bcb679..f4f51c2 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -980,8 +980,9 @@ color.diff.<slot>::
>  	of `context` (context text - `plain` is a historical synonym),
>  	`meta` (metainformation), `frag`
>  	(hunk header), 'func' (function in hunk header), `old` (removed lines),
> -	`new` (added lines), `commit` (commit headers), or `whitespace`
> -	(highlighting whitespace errors).
> +	`new` (added lines), `commit` (commit headers), `whitespace`
> +	(highlighting whitespace errors), `moved-old` (removed lines that
> +	reappear), `moved-new` (added lines that were removed elsewhere).

Could we have a config to disable this rather costly new feature,
too?

Also the first and the third level configuration names (the <slot>
is at the third level) used by the core-git do not use dashed-words
format.  Please adhere to the current convention.

> diff --git a/diff.c b/diff.c
> index 534c12e..d37cb4f 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -18,6 +18,7 @@
>  #include "ll-merge.h"
>  #include "string-list.h"
>  #include "argv-array.h"
> +#include "git-compat-util.h"
>  
>  #ifdef NO_FAST_WORKING_DIRECTORY
>  #define FAST_WORKING_DIRECTORY 0
> @@ -42,6 +43,11 @@ static int diff_dirstat_permille_default = 30;
>  static struct diff_options default_diff_options;
>  static long diff_algorithm;
>  
> +static struct hashmap *duplicates_added;
> +static struct hashmap *duplicates_removed;
> +static int hash_previous_line_added;
> +static int hash_previous_line_removed;

I think these should be added as new fields to diff_options
structure.
