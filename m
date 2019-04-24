Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 636191F453
	for <e@80x24.org>; Wed, 24 Apr 2019 10:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfDXKot (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 06:44:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53811 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfDXKos (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 06:44:48 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A772014789B;
        Wed, 24 Apr 2019 06:44:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mG7f58OOgko2pA/baJ5LbtJUYT0=; b=iozN3A
        bfHXE7eZw1ms4luHXXtDoi2fIEKWZiPmKJbKmS/wFM5/pyer72yNrRkIjio1sFN5
        H9QPbzEmU8Pif5SmNgJNJ0drJ1mrGdw5pR2PVIYltXrZPM+lNON2uVoe0WNrYvzf
        gqeeU4mxOY30pVv7kImh6lqb/ylX1kuDNEmws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FfjwLRFwQeLpzSRFgAPTIogQ5tk3g5/W
        7PJ+WvYmLo6bs/ImQywwmWzh4xphMAeWW4BrIlyMwXvUKBP/Ydz+YAbEfmL2bFM/
        B9OEHuwNNicEXI4SFfq7U1QBz1xqT+vrJlb0NFXqYjbhr835I7dkHz9sidcy2mUg
        7ICXW0dolfc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EF3B14789A;
        Wed, 24 Apr 2019 06:44:46 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F2157147899;
        Wed, 24 Apr 2019 06:44:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     a@xkqr.org (Christoffer =?utf-8?Q?Stjernl=C3=B6f?=)
Cc:     git@vger.kernel.org
Subject: Re: Bug: git branch returns EXIT_SUCCESS when no branches found
References: <875zr3iucd.fsf@xkqr.org>
        <xmqqmukf1yh9.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 24 Apr 2019 19:44:44 +0900
In-Reply-To: <xmqqmukf1yh9.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 24 Apr 2019 19:36:34 +0900")
Message-ID: <xmqqimv31y3n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9D6B46A-667D-11E9-9C41-1646B3964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The list mode ...
> ... can
> also limit the branches whose tip commits can reach a named commit
> with the "--contains".
>
> 	$ DEV_BRANCH=cs/topic
> 	$ git branch --contains master "$DEV_BRANCH"
>
> asks the subcommand to show only the branches that can reach the
> commit at the tip of 'master', *AND* whose name match cs/topic.  So
> it may show the cs/topic branch (and nothing else, even there are
> cs/topic1 or cs/topic/2 branches) if and only if that branch
> can reach the tip of 'master'.

One crucial bit is missing from my response.  In general, a git
subcommand that shows zero or more things in response to a request
to list things that match criteria does *NOT* consider it an error
to make a request that happens to produce a zero result.  The above
command will exit with non-zero status if 'master' does not name a
commit.  But if cs/topic branch does not exist, of if the branch
does not contain 'master', the command will show "here are the
branches that match the criteria you gave me" by giving no lines in
its standard output, and exits with 0 to signal that what you see on
the screen indeed was computed correctly (as opposed to the command
internally crashing and failing to produce a result, in which case
you would want to be told with non-zero exit status).


