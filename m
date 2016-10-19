Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8941D20986
	for <e@80x24.org>; Wed, 19 Oct 2016 21:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753566AbcJSVee (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 17:34:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50013 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753543AbcJSVed (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 17:34:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E63C646CDF;
        Wed, 19 Oct 2016 17:34:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=NXtkQEWl97Ro6widBbPmo/CZ7rY=; b=UilQNxVDDH9RhDQKAevW
        0OUI+PmYCc0zkhBO8CZXgSXjFx1d417DuCSpQpQ4erV16CE63c5vK3yv0CgURwfv
        ENHHUSGfcUegLFnBvFSrcvd3kHVO/UtXHvVxkuXvyZ42w4FSZ4TePigLMQYInUz5
        9bH9F/T/YDHhFGtZYNFFg7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:date:message-id:mime-version:content-type; q=dns; s=
        sasl; b=NX8lCyMncDv+/TKE1ikdt9HcR+Mg4dw+BAnX49ErZ5mCQSbixyVqCt8I
        0C399jl9LJQyQT3sZtn25egmfGYzcSwIh4QIeSoLzMri1jxMNEOLKpbXXwD2t0Su
        SwxzPsp4dUNf82THfpxfbmjlj/6S+WJ1ptc3Qct3iyNr5Jg+TB4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DE89146CDE;
        Wed, 19 Oct 2016 17:34:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6B7E646CDC;
        Wed, 19 Oct 2016 17:34:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH 0/7] Rejecting useless merge bases
References: <xmqqmvi2sj8f.fsf@gitster.mtv.corp.google.com>
        <20161019042345.29766-1-gitster@pobox.com>
Date:   Wed, 19 Oct 2016 14:34:29 -0700
Message-ID: <xmqqr37cja56.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D22D2BFE-9643-11E6-AC64-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> This is a continuation of
>
>     http://public-inbox.org/git/xmqqmvi2sj8f.fsf@gitster.mtv.corp.google.com

I scanned all two-parent merges in git.git leading to 'next' and
'pu' and reproduced them with or without the new --fp-base-only
option.  I also did the same experiment in linux.git, but only for
the latest 10,000 merges.

This exercise yielded some interesting numbers.

Among the total 10,995 merges, 10,487 merges had only one merge base
and that merge base was on the first-parent chain, i.e. the result
of reproduction is the same with or without "--fp-base-only".

There were 65 merges with multiple merge-bases but all of these
merge bases were on the first-parent chain, i.e. again the result is
the same with or without "--fp-base-only".

The remaining 443 merges had merge bases that are not on the
first-parent chain.  These merges, when recreated with
"--fp-base-only", would use different/reduced set of merge bases to
drive merge-recursive machinery and could produce different results.

Among these 443, "git merge" with or without the "--fp-base-only"
option successfully auto-resolved and produced the same result as
recorded in the real history for 214 of them.  They stopped in
conflicts but "git ls-files -s" output in their conflicted states
were the same, i.e. they left the identical conflicts, for 221 of
them.

The remaining 8 merges were auto-resolved the same way with or
without the "--fp-base-only" option, but they were different from
the merge in the real history (i.e. the real history had an evil
merge there to adjust for non-textual conflicts).

The most important numbers was 0.  There was no merges whose
reproduction with and without "--fp-base-only" produced different
results.


For linux.git the numbers are:

 - total merges looked at:                         10,000
 - single merge base:                               9,705
 - multi merge base all on the first parent chain:    123
 - fp-base-only eligible:                             172
 - cleanly resolved the same way w/ or w/o fp-only:   118
 - conflicted the same way w/ or w/o fp-only:          54
 - evil merges among fp-base-only eligible merges:      0
 - fp-base-only mismerges:                              0
