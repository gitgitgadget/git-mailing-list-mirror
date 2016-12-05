Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B29A51FF40
	for <e@80x24.org>; Mon,  5 Dec 2016 07:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751127AbcLEH0H (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 02:26:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50425 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751086AbcLEH0H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 02:26:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 15AAD4F24B;
        Mon,  5 Dec 2016 02:26:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3W+ce7epnOQq4fOXp4TQbWHqpYM=; b=a0FtlN
        17McPUzDDA+S9hPQDD7OmjbCIE2EAthDOM76jT+yDR//0zGX+MxsQAtPeznJgl2M
        SqN8qm5HLQnJxJV1teW82Behbl3VJV+jIjFy/+FVKp9McSdfP+or2JnXLvHP2wQD
        5XwB6zQvzjd8oLgzeNFMKpS33VsKfTDMOY+fc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lIfL5ILBIT9qxPQLSNZbvBsUmcbAg05z
        p3oXYbAVUx0rX5VPiyXE1IAqxJjFFRJ8/X2jMyV7LrKPdbpDO8ca1QAevLce/pNA
        M8P9S8M4CxEtoedxxJjfYarcw5BBuY/E5v4dFlvYU/Gq+Ysnel4OxnkIrNT64YlX
        vt6G7ov38dk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D5EF4F24A;
        Mon,  5 Dec 2016 02:26:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 79FDE4F249;
        Mon,  5 Dec 2016 02:26:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Mike Hommey <mh@glandium.org>, git@vger.kernel.org
Subject: Re: Should reset_revision_walk clear more flags?
References: <20161204230958.h3ilhueqqptv253u@glandium.org>
        <20161205054013.taosbwjamxiwzocn@sigill.intra.peff.net>
Date:   Sun, 04 Dec 2016 23:26:04 -0800
In-Reply-To: <20161205054013.taosbwjamxiwzocn@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 5 Dec 2016 00:40:13 -0500")
Message-ID: <xmqqmvga6dmb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1549778E-BABC-11E6-8989-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Which I think would include both of the flags you mentioned, along with
> others like SYMMETRIC_LEFT, PATCHSAME, etc. Probably really everything
> mentioned in revision.h, which should be summed up as ALL_REV_FLAGS.
> Some callsites already seem to feed that to clear_commit_marks().
>
> I doubt you can go too wrong by clearing more flags. 

This and ...

> It's possible that
> some caller is relying on a flag _not_ being cleared between two
> traversals, but in that case it should probably be using
> clear_commit_marks() or clear_object_flags() explicitly to make it clear
> what it expects to be saved.

... this are contradictory, no?  

A caller may use two sets of its own flags in addition to letting
the traversal machinery use the basic ones, and it may want to keep
one of its own two sets while clearing the other set.  It would
clear_commit_marks() to clear the latter.  And then it would let
that the next traversal to reset_revision_walk() clear the basic
ones.

So if you make reset_revision_walk() clear "more flags", that would
break such a caller that is using clear_commit_marks() to make it
clear what its expectations are, no?

I dunno.

