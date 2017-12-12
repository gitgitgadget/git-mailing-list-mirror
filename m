Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97E571F406
	for <e@80x24.org>; Tue, 12 Dec 2017 23:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752830AbdLLX5o (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 18:57:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63211 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752750AbdLLX5n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 18:57:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D7D2C4C26;
        Tue, 12 Dec 2017 18:57:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BRqVGpFY/W8/H38pBBLoKA3h9aU=; b=gFimRU
        lprbZD5hlFtReVAdSLFOtecJgTZMW9cevsOL+v9Kbsng2fWdI/QuCtALYRYCzPqf
        EQIcEpOoYJHLkDP2+yJhQPAsTfVubCkpE06Qrwmnq6YoxkTZ9seUGpearQ43EgD5
        b+EsRjjHYmrtm6kc6OOme18cTRsgVLA811dyA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nmk+6cJpa2CkS/0e2xXL0m9UDT8+szTC
        bZiN1qWhhd/hFyL5U4LFG8wsaeJUHxEY/RZxrkHPNkis6c5pSdOG1biUdj4JqKkE
        F8Z1itjNAv5zSx4in6ZnUku2GJqjLTZEH0Zwus3dlTPlgX43uTmzdAF6P4ib4Foh
        OaycjG7sgSg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 31F48C4C25;
        Tue, 12 Dec 2017 18:57:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8FDFFC4C24;
        Tue, 12 Dec 2017 18:57:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Jeff Hostetler" <git@jeffhostetler.com>, <git@vger.kernel.org>,
        <peff@peff.net>, <jonathantanmy@google.com>,
        "Jeff Hostetler" <jeffhost@microsoft.com>
Subject: Re: [PATCH] partial-clone: design doc
References: <20171208192636.13678-1-git@jeffhostetler.com>
        <20171208192636.13678-2-git@jeffhostetler.com>
        <46D2661C19CD4ADE81699FE7E99712EE@PhilipOakley>
Date:   Tue, 12 Dec 2017 15:57:41 -0800
In-Reply-To: <46D2661C19CD4ADE81699FE7E99712EE@PhilipOakley> (Philip Oakley's
        message of "Tue, 12 Dec 2017 23:31:22 -0000")
Message-ID: <xmqqlgi7xzwq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E06AA3C-DF98-11E7-8767-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

>> +  These filtered packfiles are incomplete in the traditional sense
>> because
>> +  they may contain trees that reference blobs that the client does
>> not have.
>
> Is a comment needed here noting that currently, IIUC, the complete
> trees are fetched in the packfiles, it's just the un-necessary blobs
> that are omitted ?

I probably am misreading what you meant to say, but the above
statement with "currently" taken literally to mean the system
without JeffH's changes, is false.

When the receiver says it has commit A and the sender wants to send
a commit B (because the receiver said it does not have it, and it
wants it), trees in A are not sent in the pack the sender sends to
give objects sufficient to complete B, which the receiver wanted to
have, even if B also has those trees.  If you fetch from me twice
and between that time Documentation/ directory did not change, the
second fetch will not have the tree object that corresponds to that
hierarchy (and of course no blobs and sub trees inside it).

So "the complete trees are fetched" is not true.  What is true (and
what matters more in JeffH's document) is that fetching is done in
such a way that objects resulting in the receiving repository are
complete in the current system that does not allow promised objects.
If some objects resulting in the receiving repository are incomplete,
the current system considers that we corrupted the repository.

The promise mechanism says that it is fine for the receiving end to
lack blobs, trees or commits, as long as the promisor repository
tells it that these "missing" objects can be obtained from it later.
The way the receiving end which notices that it does not have an
otherwise required blob, tree or commit is one promised by the
promisor repository is to see if it is referenced by a pack that
came from such a promisor repository.


