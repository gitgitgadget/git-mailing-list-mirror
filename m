Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D1991FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 19:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755673AbcH2TqE (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 15:46:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54867 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753566AbcH2TqD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 15:46:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DBF43996F;
        Mon, 29 Aug 2016 15:46:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nJdT3HG1nJdzcMOnTeyMuQWz4Pg=; b=FmYO2b
        BK0qChREyBRwaLqBkdxbNOUzr8MZ71+oG7vclXQEFLL4eHVTWpVIsIQKjjVACCRD
        6jwDwUs5J4W8wdSp15CGx7rV7bLst9fcA/yk9plEg/JDkTcDClhiifUlLnyzL7dR
        3hv/w6/tbxwT3J/NUv0C+CmactlyaZRZxwTtg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VJNZuG8ULD8sXsKiNL34d4fAl0K96ZcM
        ZaCZBUleO2/OynB2N14uiwrikvmDJ8K9SGeUirYC2DCX1JhuIBt+U0j4vFubeFOr
        O2F6lpEguxo4ryMdfGMb+J4A+/jCcMbX9GpsKJJWL6v8oaNF0uVRBTokYAODYBM+
        Sy52aAv+o4s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 061C93996E;
        Mon, 29 Aug 2016 15:46:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 72E9B3996C;
        Mon, 29 Aug 2016 15:46:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com
Subject: Re: [PATCH v6 13/13] read-cache: make sure file handles are not inherited by child processes
References: <20160825110752.31581-1-larsxschneider@gmail.com>
        <20160825110752.31581-14-larsxschneider@gmail.com>
        <xmqqy43fbgcj.fsf@gitster.mtv.corp.google.com>
        <4D9E5AED-7003-4707-8791-1C25432DB558@gmail.com>
Date:   Mon, 29 Aug 2016 12:45:59 -0700
In-Reply-To: <4D9E5AED-7003-4707-8791-1C25432DB558@gmail.com> (Lars
        Schneider's message of "Mon, 29 Aug 2016 21:03:09 +0200")
Message-ID: <xmqq37lnbbpk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36E7A77C-6E21-11E6-83E9-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> I see. Thanks for the explanation.

I expect the updated log message to explain the issue correctly
then.

>> And even on POSIX systems, if you are doing a long-running helper
>> any open file descriptor in the parent process when the long-running
>> helper is spawned will become leaked fd.  CLOEXEC is a possible
>> solution (but not necessarily the only or the best one) to the fd
>> leak in this case.
>> 
>> How much does the code that spawns these long-running helpers know
>> about the file descriptors that happen to be open?
>
> Nothing really.

OK.

>> The parent is
>> very likely to have pack windows open into .pack files and they need
>> to be closed on the child side after fork(2) starts the child
>> process but before execve(2) runs the helper, if we want to avoid
>> file descriptor leaks.
>
> I think I understand what you are saying. However, during my tests
> .pack file fd's were never a problem.

I do not expect during the lifetime of your long-running helper
anybody would try to unlink an existing packfile, so it is unlikely
that "cannot unlink an open file on Windows" issue to come up.  And
the cross-platform problem I pointed out is a fd leak; leaks would
not show up until you run out of the resource, just like you
wouldn't notice small memory leak here and there UNLESS you actively
look for them.  I would be surprised if your "tests" found anything.

> How would I find the open .pack file fd's?  Should I go through
> /proc/PID/fd? Why is this no problem for other longer running
> commands such as the git-credential-cache--daemon or git-daemon?

Nobody said this is "no problem for others".  While discussing the
patch that started this thread, we noticed that any open file
descriptor the main process has when the long-running clean/smudge
helper is spawned _is_ a problem.  Other helpers may share the same
problem, and if they do, that is all the more reason that fixing the
file descriptor leak is a good thing.

The primary thing I was wondering was if we should open the window
into packfiles with CLOEXEC, just like we recently started opening
the tempfiles and lockfiles with the flag.  The reason why I asked
if the site that spawns (i.e. run_command API) has an easy access to
the list of file descriptors that we opened ONLY for ourselves is
because that would make it possible to consider an alternative
approach close them before execve(2) in run_commands API.  That
would save us from having to sprinkle existing calls to open(2) with
CLOEXEC.  But if that is not the case, opening them with CLOEXEC is
a much better solution than going outside the program to "find" them
in non-portable ways.

Thanks.
