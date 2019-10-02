Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48A511F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 05:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfJBFfh (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 01:35:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56740 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfJBFfh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 01:35:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CE72336F0;
        Wed,  2 Oct 2019 01:35:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IJ61OgXH9DcHuW4XxPI/WZx+M9U=; b=L9mLok
        cOSdYdPqPeliFGV2ZfYiqj8Cs4lHBIk36uorKbtNRCK/+8U3Z/V2xnWkQUYiLnuw
        mS4PMzcBmv1P0o3Cl3UFQgSJ3gTIou6EJ67h1cnvYlvNb+M8AIin4ub07mogch+J
        Qtxr/TLLWqtfY6TjL3+t92N6aUnffjpBWTvRw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LwDMx50/niLquI/LeQ5omdWKRjOzoB8g
        YxD0lISYU798gTHtyTeqzYNMbPUfZAcxs3L3aKSF4uHql+4qw69dti/QAR7LeJLb
        3GhS4aZ2IPsn84Q+Y25VJ/9ToMOPIORgDr2SXGGW9n+sCliRRq8vv3aZornP48Zc
        BsMQjL1/ddw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14F10336EF;
        Wed,  2 Oct 2019 01:35:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 74413336EE;
        Wed,  2 Oct 2019 01:35:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     git@vger.kernel.org
Subject: Re: git mailinfo with patch parser
References: <87imp77o5k.fsf@mid.deneb.enyo.de>
Date:   Wed, 02 Oct 2019 14:35:33 +0900
In-Reply-To: <87imp77o5k.fsf@mid.deneb.enyo.de> (Florian Weimer's message of
        "Wed, 02 Oct 2019 06:43:35 +0200")
Message-ID: <xmqq1rvvhfq2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74C83AD2-E4D6-11E9-8316-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Florian Weimer <fw@deneb.enyo.de> writes:

> git mailinfo splits a message into headers, commit message, and patch
> text, but does not actually parse the patch text.  As a result, the
> patch portion produced by git mailinfo can contain something that
> looks like a patch, but actually isn't.

Yes, mailinfo is about splitting the header, log message and the
remainder, and parsing the remainder to use it as a patch text is
left to the consumer of the "patch" file it produces.

> Is there a way to get the patch data, as parsed by git apply or git
> am, and dump it back in patch format, without actually applying the
> patch to a working tree?

So, "the patch data as used by apply" is what you get from mailinfo.
If it is a patch that applies to what you have in the working tree
and/or the index is something you can/must ask "git apply".  IOW,
when "git mailinfo" stored in $GIT_DIR/rebase-apply/patch the
"remainder" of the message, you could

	git apply --check [--index] $GIT_DIR/rebase-apply/patch

to see if it is an OK patch.  If it is, then there is no need to
further "dump it back in patch format"; what you just fed to "apply
--check" is already in the patch format.



