Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1989C433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 20:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD66C206D7
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 20:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="onXRbW+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgFLUII (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 16:08:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64301 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgFLUII (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 16:08:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 017B279D02;
        Fri, 12 Jun 2020 16:08:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8BaQ7TDlldkhuwabRXJ+H7XIHa0=; b=onXRbW
        +ov7v4ZG0lU/scu18Jwr0VVberJQ0zX0proikYa0/Xi3ET8k/79SOMfh/vB0jGHe
        d0kXUUaE5wQObt92nqFM3JsC1evtCAeplM2h0qZwg2Zcl/shUYEckqcVKcd9wX9S
        joI0Aipg3acJZmIpLKDHL5ApmHgDUjczn/YXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PfvVyrO9ZiqP6j5fC3asueLfUWrA2uR0
        yDpDszD2GdzD/4qonRWEjs8wrxSe500565Pm0cEROvLbw1GQT33hcM1eZwmR8U7x
        5sczR4hgkWKUtREbRo714FmsBam+l6MBjvHc2D1HuidzGWX8IQJ91jlH68EIUnFd
        AgeQrhq9eoE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4B2B79D01;
        Fri, 12 Jun 2020 16:08:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DF6D879D00;
        Fri, 12 Jun 2020 16:08:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, jnareb@gmail.com
Subject: Re: [PATCH v3 1/4] alloc: introduce parsed_commits_count
References: <20200612184014.1226972-1-abhishekkumar8222@gmail.com>
        <20200612184014.1226972-2-abhishekkumar8222@gmail.com>
Date:   Fri, 12 Jun 2020 13:08:04 -0700
In-Reply-To: <20200612184014.1226972-2-abhishekkumar8222@gmail.com> (Abhishek
        Kumar's message of "Sat, 13 Jun 2020 00:10:11 +0530")
Message-ID: <xmqqtuzg11zv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D00340A-ACE8-11EA-8BDA-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

>  static unsigned int alloc_commit_index(struct repository *r)
>  {
> -	return r->parsed_objects->commit_count++;
> +	static unsigned int parsed_commits_count = 0;
> +	r->parsed_objects->commit_count++;
> +	return parsed_commits_count++;
>  }

Hmph, ugly.  

The need for this hack, which butchers the function that explicitly
takes a repository as its parameter so that parsed commits can be
counted per repository to not count commits per repository, makes
the whole thing smell fishy.

There shouldn't be a reason why a commit in the superproject and
another commit in the submodule need to be in the same commit graph
in the first place.

Instead of breaking the function like this, the right "fix" may be
to make the commit slab per repository, because the commit index are
taken from the separate namespace per repository.

