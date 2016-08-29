Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 653991FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 18:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756065AbcH2SFx (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 14:05:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61848 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755241AbcH2SFw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 14:05:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FC7C38832;
        Mon, 29 Aug 2016 14:05:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TW/kzwPMHbszZ8RQkQFTCCw5Avs=; b=apk5b7
        /IKrpw8FQBccaeWKukNqeU+zM5xEMOiufzJxufUnvkKSifaPMsmJMTYRZVF9Tz8/
        JzV5InWO7NC36+RB//qx82k7zlCY+4qBIpKOyk61H5UnvoOj+rbNbSWnd5PHzu4S
        rFOm7yWrNkJqlaJpvMQ5t1HMUCmdouRGzSJ20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dkkCIicGhCMqXJ7kPfKDQcL69eTBFBVM
        qh9WYmyc5aiye5FMXrewH0PMwwYFTWishLTRFq3mT+G6F7sc74kq8aKGmSsLOkn9
        VOggZ5XkR25ilaW0AvOQumAj4zTYvBO5+lYi5FSjbSYsNWfLi2NR5cQ7EzkEF/yx
        mIfN0+YPIGM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 485F238831;
        Mon, 29 Aug 2016 14:05:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C44A03882F;
        Mon, 29 Aug 2016 14:05:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com
Subject: Re: [PATCH v6 13/13] read-cache: make sure file handles are not inherited by child processes
References: <20160825110752.31581-1-larsxschneider@gmail.com>
        <20160825110752.31581-14-larsxschneider@gmail.com>
Date:   Mon, 29 Aug 2016 11:05:48 -0700
In-Reply-To: <20160825110752.31581-14-larsxschneider@gmail.com>
        (larsxschneider@gmail.com's message of "Thu, 25 Aug 2016 13:07:52
        +0200")
Message-ID: <xmqqy43fbgcj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3844DBB6-6E13-11E6-90CF-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> Consider the case of a file that requires filtering and is present in
> branch A but not in branch B. If A is the current HEAD and we checkout B
> then the following happens:
>
> 1. ce_compare_data() opens the file
> 2.   index_fd() detects that the file requires to run a clean filter and
>      calls index_stream_convert_blob()
> 4.     index_stream_convert_blob() calls convert_to_git_filter_fd()
> 5.       convert_to_git_filter_fd() calls apply_filter() which creates a
>          new long running filter process (in case it is the first file
>          of this kind to be filtered)
> 6.       The new filter process inherits all file handles. This is the
>          default on Linux/OSX and is explicitly defined in the
>          `CreateProcessW` call in `mingw.c` on Windows.
> 7. ce_compare_data() closes the file
> 8. Git unlinks the file as it is not present in B
>
> The unlink operation does not work on Windows because the filter process
> has still an open handle to the file. Apparently that is no problem on
> Linux/OSX. Probably because "[...] the two file descriptors share open
> file status flags" (see fork(2)).

Wait, a, minute.  "that is no problem" may be true as long as "that"
is "unlinking the now-gone file in the filesystem", but the reason
does not have anything to do with the "open-file status flags";
unlike Windows, you _can_ unlink file that has an open file
descriptor on it.

And even on POSIX systems, if you are doing a long-running helper
any open file descriptor in the parent process when the long-running
helper is spawned will become leaked fd.  CLOEXEC is a possible
solution (but not necessarily the only or the best one) to the fd
leak in this case.

How much does the code that spawns these long-running helpers know
about the file descriptors that happen to be open?  The parent is
very likely to have pack windows open into .pack files and they need
to be closed on the child side after fork(2) starts the child
process but before execve(2) runs the helper, if we want to avoid
file descriptor leaks.

> Fix this problem by opening files in read-cache with the `O_CLOEXEC`
> flag to ensure that the file descriptor does not remain open in a newly
> spawned process. `O_CLOEXEC` is defined as `O_NOINHERIT` on Windows. A
> similar fix for temporary file handles was applied on Git for Windows
> already:
> https://github.com/git-for-windows/git/commit/667b8b51ec850c3e1c7d75dee69dc13c29d1f162

After a few iterations, the final version of the same commit is now
in our tree as d5cb9cbd ("Git 2.10-rc2", 2016-08-26).
