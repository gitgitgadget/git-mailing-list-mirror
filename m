Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB89EC433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 17:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8700361053
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 17:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhJNRTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 13:19:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64928 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbhJNRTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 13:19:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E0E0015641C;
        Thu, 14 Oct 2021 13:17:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=5IzOQEm/hFgdjri/Swq2flzFhK5yYllq6CRpdhzHcOQ=; b=MPM6
        FyLtG33ubAjCf2xAOYqrcQTcOXf1IS4Nmu+Cfsx3rTyHhmiZJqCgX90tmrmrlGH6
        H5AKiDcOtQpKsfy4dgkHRv8IzFWhDMDr2CPS73gxEawUtNfIeGZoBf6kENFm3JAa
        unf9/jGH4Bcp0BIdVuYI9/p8Z9atrwnVY+EoCu4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D9D6215641B;
        Thu, 14 Oct 2021 13:17:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3DC6A156416;
        Thu, 14 Oct 2021 13:17:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rob Browning <rlb@defaultvalue.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] signature-format.txt: explain and illustrate multi-line
 headers
References: <20211009163338.2175170-1-rlb@defaultvalue.org>
        <YWRpPw4eTwTmgVvC@coredump.intra.peff.net>
        <xmqq4k9ncopr.fsf@gitster.g>
        <YWTuAOjqK6fy9ZRT@coredump.intra.peff.net>
        <xmqqzgre5glb.fsf@gitster.g> <xmqqtuhlisqe.fsf_-_@gitster.g>
        <87zgrcgpez.fsf@trouble.defaultvalue.org>
Date:   Thu, 14 Oct 2021 10:17:01 -0700
Message-ID: <xmqq5ytzcyr6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8BF91768-2D12-11EC-A624-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rob Browning <rlb@defaultvalue.org> writes:

> One question I had was whether git's requirement was strictly a space,
> or if it was following the rfc-822 convention where (if I remember
> correctly) a tab is equivalent, i.e. the LWSP production in the grammar.

We use a single SP when writing and we accept a single SP when
reading.  See commit.c::add_extra_header() for the writing side, and
commit.c::read_commit_extra_header_lines() for the reading side.

Unlike in RFC-822 style e-mail headers, 

 * keywords in our object headers are not followed by a colon;

 * the value carried on our object header is not a "logically a
   single line of characters".  

 * our headers do not go through their "unfolding" (i.e. removal of
   CRLF eol markers to form a single long line, while preserving the
   WSP that immediately followed the CRLF).  We instead remove the
   SP that signalled the line as a continuation of the previous line
   to keep the original line structure.

With so little similarity, there is no reason for us to mimick their
"folding" rule.

We limit to the SP and not LWP for another reason.  Because the
exact byte sequence in the object (including the header part of
"commit" and "tag" objects) determines the name of the object, it
avoids ambiguity to make sure we do not allow unnecessary
"flexibility" in the way the same thing can be expressed.  If the
same signature is attached to a pair of otherwise identical commits
in their headers, one with SP signaling continued lines, the other
using HT (or random permutations of choice between SP/HT---making
2^N variants for a N line signature block), we would needlessly
create many variants of the "same" commit, which is not ideal.
