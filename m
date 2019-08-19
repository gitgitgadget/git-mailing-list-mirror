Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 439511F461
	for <e@80x24.org>; Mon, 19 Aug 2019 09:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfHSJIH (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 05:08:07 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:20658 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726211AbfHSJIG (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Aug 2019 05:08:06 -0400
X-IronPort-AV: E=Sophos;i="5.64,403,1559512800"; 
   d="scan'208";a="395728705"
Received: from dhcp-13-233.lip.ens-lyon.fr (HELO moylip) ([140.77.13.233])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2019 11:08:05 +0200
From:   Matthieu Moy <Matthieu.Moy@matthieu-moy.fr>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Matthieu Moy <git@matthieu-moy.fr>, git@vger.kernel.org,
        corentin.bompard@etu.univ-lyon1.fr, gitster@pobox.com,
        nathan.berbezier@etu.univ-lyon1.fr,
        pablo.chabanne@etu.univ-lyon1.fr
Subject: Re: [PATCH] pull, fetch: add --set-upstream option
References: <86zhoil3yw.fsf@univ-lyon1.fr>
        <20190814134629.21096-1-git@matthieu-moy.fr>
        <20190814171404.zqtd4xctjobgpzby@localhost.localdomain>
Date:   Mon, 19 Aug 2019 11:08:05 +0200
In-Reply-To: <20190814171404.zqtd4xctjobgpzby@localhost.localdomain> (Pratyush
        Yadav's message of "Wed, 14 Aug 2019 22:44:04 +0530")
Message-ID: <86a7c5cykq.fsf@matthieu-moy.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> This is not really a review. Just some minor nitpicks I spotted while 
> reading through.

Thanks for the comments.

>> -static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity, deepen_relative;
>> +static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity, deepen_relative, set_upstream;
>
> This line is getting pretty long. I think it is a good idea to split it 
> into two.

Indeed, and it was already >80 characters, I've split it.

>> +	if (set_upstream) {
>> +		struct branch *branch = branch_get("HEAD");
>> +		struct ref *rm;
>> +		struct ref *source_ref = NULL;
>> +
>> +		/*
>> +		 * We're setting the upstream configuration for the current branch. The
>> +		 * relevent upstream is the fetched branch that is meant to be merged with
>> +		 * the current one, i.e. the one fetched to FETCH_HEAD.
>> +		 *
>> +		 * When there are several such branches, consider the request ambiguous and
>> +		 * err on the safe side by doing nothing and just emit a warning.
>> +		 */
>
> The comment lines cross the 80 column boundary. The usual convention in 
> this project is to try to keep lines below 80 columns. For strings IMO 
> an exception can be allowed because breaking them up makes it harder to 
> grep for them. But comments are the easiest to format.
>
> Are you using a tab size of 4?

I'm not, but it's possible that the original authors had. Anyway, I've
wrapped it.

>> +		for (rm = ref_map; rm; rm = rm->next) {
>> +			if (!rm->peer_ref) {
>> +				if (source_ref) {
>> +					warning(_("multiple branch detected, incompatible with --set-upstream"));
>> +					goto skip;
>> +				} else {
>> +					source_ref = rm;
>> +				}
>> +			}
>> +		}
>> +		if (source_ref) {
>> +			if (!strcmp(source_ref->name, "HEAD") || 
>
> This line has a trailing space.

Fixed.

> So this should change to something like:
>
> 				install_branch_config(0, branch->name,
> 						      transport->remote->name,
> 						      source_ref->name);

I've added a newline after the comma, I don't like mixing "several
arguments on the same line" and "one argument per line".

>  
> Maybe this discrepancy is because you are using the wrong tab size?
>
>> +			} else if (starts_with(source_ref->name, "refs/remotes/")) {
>> +				warning(_("not setting upstream for a remote remote-tracking branch"));
>> +			} else if (starts_with(source_ref->name, "refs/tags/")) {
>> +				warning(_("not setting upstream for a remote tag"));
>> +			} else {
>> +				warning(_("unknown branch type"));
>> +			}
>
> No need to wrap single line if statements in braces.

Fixed.

>> +#tests for fetch --set-upstream
>
> Add a space after the '#'. Same in other comments below.

Fixed.

Thanks. Version 2 fixing all these follows.

-- 
Matthieu Moy
https://matthieu-moy.fr/
