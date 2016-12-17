Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4645E1FF40
	for <e@80x24.org>; Sat, 17 Dec 2016 01:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759173AbcLQBbB (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 20:31:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53618 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758725AbcLQBbA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 20:31:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C10E757544;
        Fri, 16 Dec 2016 20:30:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C5626TjSs1ntDPkKmw00ediqanA=; b=hSMAZw
        RWWm6jR6RrPR7O3eJFmJY6cwd58aNVRe9xpYjCqgXAYGUXnUE5mKLoPlQtLJ7RJ2
        hTZoyRtHI6NEgrlbMM7IVfVjjDwnfdxrPv4GoJycjoHwirpO2xPoxgJTX9VQ9zbW
        hZGF8m5Tw1nadYXLKQiZt9575/WMPrURDRfMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DDdnlHOhxTyFTKjlzZJ7I7pBKvlw/+S2
        /ik+Ka/8JlnNpLFHNsqX/2os0X+GO7E79QfEd5DZo/wDxWenY1b6WEU+kI+3NOaZ
        u/WHBnfGfPyrlin4Od9LB9gfatzRBqiZc8XQPGG7H0yF99dOM/ebvjTIoZTjn1N0
        JXxQfkh0zss=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B85EA57542;
        Fri, 16 Dec 2016 20:30:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 35F3D57541;
        Fri, 16 Dec 2016 20:30:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Norbert Kiesel <nkiesel@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] diff: prefer indent heuristic over compaction heuristic
References: <20161217005442.5866-1-jacob.e.keller@intel.com>
Date:   Fri, 16 Dec 2016 17:30:57 -0800
In-Reply-To: <20161217005442.5866-1-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Fri, 16 Dec 2016 16:54:42 -0800")
Message-ID: <xmqq7f6zqr3i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 761E20D8-C3F8-11E6-AD8A-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> The current configuration code for enabling experimental heuristics
> prefers the last-set heuristic in the configuration. However, it is not
> necessarily easy to see what order the configuration will be read. This
> means that it is possible for a user to have accidentally enabled both
> heuristics, and end up only enabling the older compaction heuristic.
>
> Modify the code so that we do not clear the other heuristic when we set
> each heuristic enabled. Then, during diff_setup() when we check the
> configuration, we will first check the newer indent heuristic. This
> ensures that we only enable the newer heuristic if both have been
> enabled.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  diff.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Although I do not think we should spend too much braincycles on this
one (we should rather just removing the older one soonish), I think
this patch is going in a wrong direction.  I agree that "the last
one wins" is a bit hard to see (until you check with "git config -l"
perhaps) but it at least is predictable.  With this patch, you need
to KNOW that indent wins over compaction, perhaps by knowing the
order they were developed, which demands a lot more from the users.

We probably should just keep one and remove the other.

> diff --git a/diff.c b/diff.c
> index ec8728362dae..48a5b2797e3d 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -223,16 +223,10 @@ void init_diff_ui_defaults(void)
>  
>  int git_diff_heuristic_config(const char *var, const char *value, void *cb)
>  {
> +	if (!strcmp(var, "diff.indentheuristic"))
>  		diff_indent_heuristic = git_config_bool(var, value);
> +	if (!strcmp(var, "diff.compactionheuristic"))
>  		diff_compaction_heuristic = git_config_bool(var, value);
>  	return 0;
>  }
