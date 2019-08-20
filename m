Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D8961F461
	for <e@80x24.org>; Tue, 20 Aug 2019 17:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbfHTRm3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 13:42:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62312 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730222AbfHTRm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 13:42:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A828C173D0C;
        Tue, 20 Aug 2019 13:42:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rjMHDQLDn84dDz7Do6hGSnj+zG4=; b=t9M8Oe
        sYRh27pwDN1SaPB1I4UvQRZJOjMuXV58f9JGIgHr6bDTJM1tW35o7s9sCmHt2RGt
        fwgNsl0iouFhnqg4r9Ne6OcT17H+5Eo/jr7XQgd1G51QVwj5HHMmlTIGr5OPAkfB
        7X05C0KsUrJiQ/HxnJo9dkxo0wv68pDXjZxqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pUmgaj5OEGtEzWB9TzWFJq2GACU4ffwP
        DdaNMtpJ9giYHA6dReqxr+2uaUJMmOT3+zybaQhtPrrglrci2PF6cpa5KodCl33Q
        PSy0IMrDxr2cGrMqv+ovnYgQCkEwTxYjLhpZr5PlwSXjrbbVz1C9dXyjsVEfXZbS
        k1/sXOBNV+w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E336173D0B;
        Tue, 20 Aug 2019 13:42:26 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 11558173D0A;
        Tue, 20 Aug 2019 13:42:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: Re: [PATCH v3 5/6] rebase -i: support --ignore-date
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
        <20190820034536.13071-1-rohit.ashiwal265@gmail.com>
        <20190820034536.13071-6-rohit.ashiwal265@gmail.com>
Date:   Tue, 20 Aug 2019 10:42:25 -0700
In-Reply-To: <20190820034536.13071-6-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Tue, 20 Aug 2019 09:15:34 +0530")
Message-ID: <xmqqwof7vim6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF8ECA24-C371-11E9-BDD1-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

> +/* Construct a free()able author string with current time as the author date */
> +static char *ignore_author_date(const char *author)
> +{
> +	int len = strlen(author);

Mental note: ignore_author_date() would not allow author==NULL as its input.

> @@ -1020,10 +1047,20 @@ static int run_git_commit(struct repository *r,
>  
>  		if (res <= 0)
>  			res = error_errno(_("could not read '%s'"), defmsg);
> -		else
> +		else {
> +			if (opts->ignore_date) {
> +				char *new_author = ignore_author_date(author);
> +				if (!author)
> +					BUG("ignore-date can only be used with "
> +					    "rebase, which must set the author "
> +					    "before committing the tree");

Yet, author is used and then checked for NULL-ness, which is
backwards.  Before we have a chance to issue this BUG(), we would
already have segfaulted inside ignore_author_date().

