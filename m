Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F0C01F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 19:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfJBTpA (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 15:45:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57088 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfJBTo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 15:44:59 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C1AB319432;
        Wed,  2 Oct 2019 15:44:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DcKSwysWT90pqCi3UWpmBBa+xAY=; b=pjGMXc
        MQsNaM0g7Yf/EvPrnG2mys9Og4IT0fIZlvRk4U0I4JcDMGfApp7RwpnZ0afE5hES
        h3C0Mm5a98mPPjMohDGzWrAKDenSzuXzgWGo7Yuski+zBCAPeuAW2N08ysjz4DhO
        dj2/m93AWLi1IrXvZrbvbG1La846HSZactraU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rCraLNNfUWQ9puXo+Q4TQqBaG0heA00H
        apgcj61u5nKp4s1dwQgOjl4dVNTmYjmvdmiDl7979Wx1UCTfhGMWPyk8aR6y8JRr
        T3b8idtPRyAqdL9mG3E04pT4AHjCsmvDP3Dc2ogq/9NfU239lUlDAgvwHCW5q77s
        9F8rDsBEO9s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8D4019431;
        Wed,  2 Oct 2019 15:44:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1F46719430;
        Wed,  2 Oct 2019 15:44:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [BUG] incorrect line numbers reported in git am
References: <20191002184546.GA22174@generichostname>
Date:   Thu, 03 Oct 2019 04:44:55 +0900
In-Reply-To: <20191002184546.GA22174@generichostname> (Denton Liu's message of
        "Wed, 2 Oct 2019 11:45:46 -0700")
Message-ID: <xmqqd0ffdj9k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1CE3DEEE-E54D-11E9-B372-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> 	Applying: dir: special case check for the possibility that pathspec is NULL
> 	error: corrupt patch at line 87

This refers to line 87 of the input file, not a line that begins
with "@@ -87,count...", doesn't it?  If the sender hand edits a
patch without correcting the number of lines recorded in the hunk
header, the parser may not see the next hunk that begins with "@@"
or run out of the input before it reads the required number of lines
given the last hunk header.

We might be able to notice when the input file is shorter than the
last hunk wants it to be, in which case we should be able to say
'premature end of input at line 87' or something like that.


