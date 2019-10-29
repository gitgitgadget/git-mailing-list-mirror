Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A448C1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 01:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfJ2BcA (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 21:32:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59661 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfJ2BcA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 21:32:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 33A9E2CC43;
        Mon, 28 Oct 2019 21:31:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LCiPrNs+XNMN/FyI8OVM29yfnWQ=; b=GktTX2
        jlXLNp5FoLI8CR/fibcBmyJmV1rhI5dv4/p7pFbxCbTWrBXPM1GQPa/jkMiyDlFC
        1xIoePUnx/oSQKdUATWnsYM+UBqEaZVgC+OAAsisqYQX6Vcl9Yu19RGwdnVsu53w
        R85C+0Qt2EmrEaqTtUvRZ1UzfLkH3hY+pSZXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M79aXV4vQ5PUCNGMRL6fqKGCuMRT4cfJ
        D49n2HiMwcx7IkPg1wS3p+PkzXe4edNNkyp8xifueRiqiZHCQcXvPR1f8jLu4ypH
        spO5KlZ0ShyaDcDG236J2tr9j5yJlcLLFOugp1UhWl8a3SqgalKnOx3R356OYSal
        Ly91g7UqQZ8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2AE772CC42;
        Mon, 28 Oct 2019 21:31:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8CE192CC3E;
        Mon, 28 Oct 2019 21:31:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: conflict markers on recursive strategy with diff3 enabled
References: <CAOc6etaQvNChdRZ70xsYQxqtgmZVxaKV9K7_zZeET3JuQ4HEXg@mail.gmail.com>
        <e26d24b2-6fca-8546-f2b3-bf4660db8184@iee.email>
Date:   Tue, 29 Oct 2019 10:31:56 +0900
In-Reply-To: <e26d24b2-6fca-8546-f2b3-bf4660db8184@iee.email> (Philip Oakley's
        message of "Mon, 28 Oct 2019 22:13:02 +0000")
Message-ID: <xmqqlft48hgz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5955FEA-F9EB-11E9-8646-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> I believe this happens when no merge-base is found between the two
> lines of development that are being merged, so a fake merge-base is
> created to allow the regular 3-way merge to occur.

s/no merge-base is/more than one merge-base are/; then a synthetic
merge base is computed in order to perform the merge the end-user
requested first, and the computation of that synthetic merge base
may involve merge conflicts.  After that, the merge logic pretends
that the two versions being merged both derived from such a common
ancestor version _with_ conflict markers in it, and may conflict
with each other around that existing (inner) conflict markers to
leave a rather messy result.  It is particularly bad when both
branches did the same thing only on one side the inner merge
conflicted but not on the other side---one side of inner conflict
marker (say "<<<<<<<<") may disappear when the merged branches made
the same change (so "both side changed identically, resolve to their
same result" 3-way merge rule would apply) and around that area the
result will not have the conflict marker from the inner merge, and
the other side will say "one side made into this shape, the other
side made into that shape, from this common ancestor version" in the
diff3 format, which would mean that we would see conflict marker
lines from the inner merge between "|||||" and "=====" lines in the
outer merge (i.e. the common ancestor version).  The conflict
markers of the inner merge are longer than those of the outermost
merge, so you could sift them by careful eyeballing, but it is
rather hard to read.

