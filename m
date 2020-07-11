Return-Path: <SRS0=UM1m=AW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A1AC433DF
	for <git@archiver.kernel.org>; Sat, 11 Jul 2020 21:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50FB120725
	for <git@archiver.kernel.org>; Sat, 11 Jul 2020 21:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ycehrsqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgGKVHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jul 2020 17:07:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55669 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgGKVHH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jul 2020 17:07:07 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 17214DB72B;
        Sat, 11 Jul 2020 17:07:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/qtm3l+BUkeybAIIWsemv2+izbo=; b=Ycehrs
        qkwlrASUsEEqB6WU+VgmY5XD+EO3Jj4SNh7xi2EsU3rmRmMabB8fbymjd6aiIS/O
        iZQOWf4gKTpD8mFB67eRXT4AKyC2GpvOntEwb81mRNz4jv7Qm47dPHBjYBOw3F6/
        U7aHxXRhUHh2Xhx5y+2v9qgIDCzYGt9qMLpVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ioZXR1c7Sw1kVumBZRdA02hwBa1EmF3a
        LTmoMsBK/mcAvh6303yUGKuNmD/XL2EXhbbo1NQr0r5tOsu+ly1g8QfsjhrMIIzo
        SpTeANk1OBsOA22V77hFsaRyLhUFn1kPgFH1n2oRB+1aqAoNsu+06ptALb4IWr4u
        acW5z6M328s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0FF5EDB72A;
        Sat, 11 Jul 2020 17:07:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5A820DB728;
        Sat, 11 Jul 2020 17:07:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: FETCH_HEAD files and mirrored repos
References: <20200711204849.khfbyundun7ujqzw@chatter.i7.local>
Date:   Sat, 11 Jul 2020 14:07:01 -0700
In-Reply-To: <20200711204849.khfbyundun7ujqzw@chatter.i7.local> (Konstantin
        Ryabitsev's message of "Sat, 11 Jul 2020 16:48:49 -0400")
Message-ID: <xmqqimetrcay.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 780FFC02-C3BA-11EA-8489-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> Are there any downsides to deleting FETCH_HEAD after performing "git 
> remote update" in repos that are only used for mirrored hosting?

The only time Git itself uses FETCH_HEAD is during "git pull".

"git pull" is a two step process---it first calls "git fetch" and
then calls "git merge" (or "git rebase") to integrate the fetched
history with the history of your current branch.  "git fetch" leaves
what it got in that file, and "git pull" figures out what parameters
and message to use to drive the second step.  After that, FETCH_HEAD
is not used by Git.  If you call "git fetch" yourself, FETCH_HEAD
left by that process is not used by Git itself, but you can use what
is in it to manually execute the second step of what "git pull"
would do.

So, unless your script depends on the presence and/or the contents
of FETCH_HEAD, you can safely remove it.

