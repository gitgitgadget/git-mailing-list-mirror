Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81625C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 18:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A43720781
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 18:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kyxQvA6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHLS2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 14:28:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51129 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgHLS2L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 14:28:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D9176C54E;
        Wed, 12 Aug 2020 14:28:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mcPoTfyZcdylkjWwDEDcZz/gnXk=; b=kyxQvA
        6jtR4aQKSdrGVzbN+X5QO7pJn/+LkBP97QUqRIz9zU7TCK68Db6RiidRk5GVrsUF
        Myfml2Ldl84pO6ZSO8ckU6vCQskMcCWqrnrqke114mJg5WM5GtJtLY1IGEaomX2r
        3Gg7NWbcgHfGlg6P9zifjKMSESInwvZw4gQvM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a/Enpl8aMrZUZymcbiGn0KZAJt3lveOr
        ZuyLBTKF1TaBYL1PcquSMUgwrW50vXbNC0e9L+kqT4BN/Gr9EBkdD4eJoNG00tkH
        q+OLxtvzTUxjS3cLwiW3D1r9br5Su/q6kCmHtK1adYV4AZMTPotGWlXqGPM90Nbf
        PpVSRN/uPeU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54E946C54D;
        Wed, 12 Aug 2020 14:28:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8AC0D6C54C;
        Wed, 12 Aug 2020 14:28:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 6/7] promisor-remote: lazy-fetch objects in subprocess
References: <20200724223844.2723397-1-jonathantanmy@google.com>
        <cover.1597184948.git.jonathantanmy@google.com>
        <55d2e5a4cccee0ae719f4210c2cbeeb6a691cf2f.1597184949.git.jonathantanmy@google.com>
Date:   Wed, 12 Aug 2020 11:28:07 -0700
In-Reply-To: <55d2e5a4cccee0ae719f4210c2cbeeb6a691cf2f.1597184949.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 11 Aug 2020 15:52:21 -0700")
Message-ID: <xmqqbljf7m88.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92192F9C-DCC9-11EA-9F36-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Teach Git to lazy-fetch missing objects in a subprocess instead of doing
> it in-process. This allows any fatal errors that occur during the fetch
> to be isolated and converted into an error return value, instead of
> causing the current command being run to terminate.
>
> ...
>  static int fetch_objects(const char *remote_name,
>  			 const struct object_id *oids,
>  			 int oid_nr)
>  {
> -	struct ref *ref = NULL;
> +	struct child_process child = CHILD_PROCESS_INIT;
>  	int i;
> +	FILE *child_in;
> +
> +	child.git_cmd = 1;
> +	child.in = -1;
> +	argv_array_pushl(&child.args, "-c", "fetch.negotiationAlgorithm=null",
> +			 "fetch", remote_name, "--no-tags",
> +			 "--no-write-fetch-head", "--recurse-submodules=no",
> +			 "--filter=blob:none", "--stdin", NULL);

Finally we get to use the new negotiator introduced earlier.  Nice.

> +	if (start_command(&child))
> +		die(_("promisor-remote: unable to fork off fetch subprocess"));
> +	child_in = xfdopen(child.in, "w");
