Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B7C820FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 21:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbcF2VXV (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 17:23:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63017 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751722AbcF2VXT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 17:23:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 12C41286B9;
	Wed, 29 Jun 2016 17:23:17 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l5GgPIOgs+K5alrbV6T7Bgfe+L4=; b=f7d29X
	z9moWQGtmlX3K3drQqeBNY35idtWxQLKNu7MCSQnypsh6BDJg5DqTDgUhxbPLkaS
	k9VfYNMtSRuNrdDlAbq0nZ1mUP2fesCoqjyDZoXfJyjlghHQNXMfkkI8QLeJRdDx
	RbHRkzTKEg3hrinEhx5s1+xdxlft7wdrBk3+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pg+t5Md6ra2nz3YeoJCOwZYs0EkWu0g7
	pOtZ98p58PePjnsdheQuatOvj8nVOI4d+9S40Ovs0zvCp7VVA4vBUNMV821lXuUI
	NfeMEdZZ1bXi+AZJdJlpWofiQVAoQWGytC60So0RkEZcUTLP1RiJb+i+ixrNHnaR
	K0kjSS/dFps=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AA7A286B8;
	Wed, 29 Jun 2016 17:23:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 82BAA286B7;
	Wed, 29 Jun 2016 17:23:16 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 9/9] am: make a direct call to merge_recursive
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
	<dc58115e23c8d942b3ff6270b43719bc841becbb.1467199553.git.johannes.schindelin@gmx.de>
Date:	Wed, 29 Jun 2016 14:23:14 -0700
In-Reply-To: <dc58115e23c8d942b3ff6270b43719bc841becbb.1467199553.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 29 Jun 2016 13:38:27 +0200
	(CEST)")
Message-ID: <xmqq37nv3d19.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1A2B3E2-3E3F-11E6-98CE-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> -	cp.git_cmd = 1;
> +	init_merge_options(&o);
> +
> +	o.branch1 = "HEAD";
> +	his_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
> +	o.branch2 = his_tree_name;
>  
> -	argv_array_pushf(&cp.env_array, "GITHEAD_%s=%.*s",
> -			 sha1_to_hex(his_tree), linelen(state->msg), state->msg);
>  	if (state->quiet)
> -		argv_array_push(&cp.env_array, "GIT_MERGE_VERBOSITY=0");
> +		o.verbosity = 0;
>  
> -	argv_array_push(&cp.args, "merge-recursive");
> -	argv_array_push(&cp.args, sha1_to_hex(orig_tree));
> -	argv_array_push(&cp.args, "--");
> -	argv_array_push(&cp.args, sha1_to_hex(our_tree));
> -	argv_array_push(&cp.args, sha1_to_hex(his_tree));
> +	status = merge_recursive_generic(&o, our_tree, his_tree, 1, bases, &result);
> +	if (status < 0)
> +		exit(128);
> +	free(his_tree_name);
>  
> -	status = run_command(&cp) ? (-1) : 0;
> -	discard_cache();
> -	read_cache();
>  	return status;
>  }

Is this a correct conversion?

We used to prepare the command line and called run_command() and
without dying returned status with the error status from the
merge-recursive that was spawned by run_command().

The new code does not report failure to the caller and instead dies.

