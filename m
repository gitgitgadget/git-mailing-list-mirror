Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5507A1FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 17:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753428AbcHZRo5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 13:44:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63825 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753259AbcHZRoz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 13:44:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E1BC37742;
        Fri, 26 Aug 2016 13:44:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Zl3uj+sIg0m5nNDrgqwpIj5iljg=; b=knRHgV
        kDNb1xSLMwYLDbCJDnuLRXOFjvHGZ0hUtTHWh+DCr/7uWDIAo+HHOecEaNsQ4ESQ
        5pXqWX6H/ltmZDEy/CRXMLrotLfHJQwuBlgkv1Knafe0R6dgIi+dF4HCIKoaRLEu
        P4vUoCKEXYFV2kKc0SDDVZBKeQxdeshQVcDBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dSd9HS+buMLrUf036GcHy+/1vcQ12rR1
        hxz7Z/4VX4/+cN/HIDZCzFHM9D7JtrZmAUyKm+XEWX7bo8BdODanti604YI09IRf
        kfq3cFbKdO5+jFCXYhheMDwNlpBaXQ3Wt+k5rJyau1j82SpUCVJbYipOYS+2Q+q6
        +qSmDICTJdQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36B7437741;
        Fri, 26 Aug 2016 13:44:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C7E3837740;
        Fri, 26 Aug 2016 13:44:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 12/15] sequencer: lib'ify save_opts()
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
        <7768b55e65c771a5615a6f1209b40395dc705425.1471968378.git.johannes.schindelin@gmx.de>
Date:   Fri, 26 Aug 2016 10:44:51 -0700
In-Reply-To: <7768b55e65c771a5615a6f1209b40395dc705425.1471968378.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 23 Aug 2016 18:07:33 +0200
        (CEST)")
Message-ID: <xmqqwpj3h1bg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CBC4A21A-6BB4-11E6-8FD6-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>  static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
> @@ -1128,9 +1130,9 @@ int sequencer_pick_revisions(struct replay_opts *opts)
>  		return -1;
>  	if (get_sha1("HEAD", sha1) && (opts->action == REPLAY_REVERT))
>  		return error(_("Can't revert as initial commit"));
> -	if (save_head(sha1_to_hex(sha1)))
> +	if (save_head(sha1_to_hex(sha1)) ||
> +			save_opts(opts))
>  		return -1;
> -	save_opts(opts);

I think it is much easier to read to keep this on a single line.  It
would be more verbose but an even easier would be to keep these two
operations two separate steps, i.e.

        if (save_head())
                return -1;
        if (save_opts())
                return -1;
