Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53AC82055E
	for <e@80x24.org>; Thu, 26 Oct 2017 03:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932273AbdJZDrj (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 23:47:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55924 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932205AbdJZDri (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 23:47:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A7259A9F6;
        Wed, 25 Oct 2017 23:47:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yTTfToxvdlK/vOZmPbydk+w2kYI=; b=vb5yS4
        6zJRkodHxiIWP66fdJleXsO8ntl5089SqSL0YKbhvFIJD4oq6PXfTCQsyflrgwNi
        2ydHwrmTynUk01pLgmvdr48ChYVW+CRIL2GTgER0Qlf0M12UCiTuBPu7xcKK9oJg
        rhs7fncs5kt20cbivfgtk2Z61dDFHj6l7Z06s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UMRqFawoiq4SESFM0PTinPO7HHPmdcJ5
        ubg5x4nqaOLS2XVIQ55vBHLEHWJV89zi/y3Az2yL7uN7H2sjYqeTyZO3hfppQaD0
        Lf8C3OsNuoi6+1u1gcWxwkIWhJymZdvW7rGH5wI38a68i2ithFWFI056WtG+eTVo
        0hn8JFIaXWM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7175A9A9F5;
        Wed, 25 Oct 2017 23:47:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D96A39A9F4;
        Wed, 25 Oct 2017 23:47:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 01/13] dir: allow exclusions from blob in addition to file
References: <20171024185332.57261-1-git@jeffhostetler.com>
        <20171024185332.57261-2-git@jeffhostetler.com>
        <xmqq60b3iv79.fsf@gitster.mtv.corp.google.com>
        <b063dec4-b9c4-7145-9b57-7df22ccbc655@jeffhostetler.com>
Date:   Thu, 26 Oct 2017 12:47:35 +0900
In-Reply-To: <b063dec4-b9c4-7145-9b57-7df22ccbc655@jeffhostetler.com> (Jeff
        Hostetler's message of "Wed, 25 Oct 2017 10:54:34 -0400")
Message-ID: <xmqqpo9afu3s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6833B93E-BA00-11E7-98EA-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> The existing code handles use cases where you want to read the
> exclusion list from a pathname in the worktree -- or from blob
> named in the index when the pathname is not populated (presumably
> because of the skip-worktree bit).
>
> I was wanting to add a more general case (and perhaps my commit
> message should be improved).  I want to be able to read it from
> a blob not necessarily associated with the current commit or
> not necessarily available on the local client, but yet known to
> exist.  

Oh, I understand the above two paragraphs perfectly well, and I
agree with you that such a helper to read from an arbitrary blob is
a worthy thing to have.  I was merely commenting on the fact that
such a helper that is meant to be able to handle more general cases
is not used to help the more specific case that we already have,
which was a bit curious.

I guess the reason why it is not done is (besides expediency)
because the model the new helper operates in would not fit well with
the existing logic flow, where everything is loaded into core
(either from the filesystem or from a blob) and then a common code
parses and registers; the helper wants to do the reading (only) from
the blob, the parsing and the registration all by itself, so there
is not much that can be shared even if the existing code wanted to
reuse what the helper offers.

The new helper mimicks the read_skip_worktree_file_from_index()
codepath to massage the data it reads from the blob to buf[] but not
really (e.g. even though it copies and pastes a lot, it forgets to
call skip_utf8_bom(), for example).  We may still want to see if we
can share more so that we do not have to worry about these tiny
differences between codepaths.

> With my "add_excludes_from_blob_to_list()", we can request a
> blob-ish expression, such as "master:enlistments/foo".  In my
> later commits associated with clone and fetch, we can use this
> mechanism to let the client ask the server to filter using the
> blob associated with this blob-ish.  If the client has the blob
> (such as during a later fetch) and can resolve it, then it can
> and send the server the OID, but it can also send the blob-ish
> to the server and let it resolve it.

Security-minded people may want to keep an eye or two open for these
later patches---extended SHA-1 expressions is a new attack surface
we would want to carefully polish and protect.
