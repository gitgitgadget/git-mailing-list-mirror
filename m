Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBA0E20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 19:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754313AbdASTCo (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 14:02:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59495 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754045AbdASTCe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 14:02:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8168B5F5D7;
        Thu, 19 Jan 2017 13:54:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IMBSg3zdyzYLEDisx24g83OC0x0=; b=rlTPWP
        SCJmp2FUJE752gyDS3FLvy+viTxRN+aTGVmQln8kYcpLKHbXQrOXXGQSR5yBEgCI
        mGZ4z920q6rMpn7AMS7xvo70O/SA3Ikjov3DoE0AkVdIRVjW6W7mEa7pSVd0GlSq
        KW5CNHoDTPAZesPYHsKPQb5wohqT/1D9bA1c8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K5KfOPo0T9m/yjQX0xMAhYw1G7uktfDB
        WBUYElG/QfRAnLm79mXKZ8Eh6CoL8V98UEg/tnVzki34aWDPL8L6CpEQqmVmKiV3
        qjjo2RXiLDalHjg6k1HHVQx6orR6p1lje5LfGaXiBoZerzv0EomV91P3REmZEXNC
        a2zVxVHk/Js=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78D9B5F5D6;
        Thu, 19 Jan 2017 13:54:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D7D4D5F5D4;
        Thu, 19 Jan 2017 13:54:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC 2/2] grep: use '/' delimiter for paths
References: <20170119150347.3484-1-stefanha@redhat.com>
        <20170119150347.3484-3-stefanha@redhat.com>
Date:   Thu, 19 Jan 2017 10:54:02 -0800
In-Reply-To: <20170119150347.3484-3-stefanha@redhat.com> (Stefan Hajnoczi's
        message of "Thu, 19 Jan 2017 15:03:47 +0000")
Message-ID: <xmqqpoji2851.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5B62BC0-DE78-11E6-BE10-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Hajnoczi <stefanha@redhat.com> writes:

> If the tree contains a sub-directory then git-grep(1) output contains a
> colon character instead of a path separator:
>
>   $ git grep malloc v2.9.3:t
>   v2.9.3:t:test-lib.sh:	setup_malloc_check () {
>   $ git show v2.9.3:t:test-lib.sh
>   fatal: Path 't:test-lib.sh' does not exist in 'v2.9.3'

I am slightly less negative on this compared to 1/2, but not by a
big margin.  The user wanted to feed a subtree to the command,
instead of doing the more natural

    $ git grep -e malloc v2.9.3 -- t

So again, "contains a colon character" is not coming from what Git
does, but the user gave Git "a colon character" when she didn't have
to.

Having said that, if we wanted to start ignoring what the end-user
said in the initial input like 1/2 and 2/2 does (i.e. "this specific
tree object" as an input), I think the approach to solve for 1/2 and
2/2 should be the same.  I think we should decide to do a slash
instead of a colon, not because v2.9.3: has colon at the end and
v2.9.3:t has colon in it, but because both of these are both bare
tree objects.  The patches presented does not seem to base their
decision on the actual object type but on the textual input, which
seems wrong.
