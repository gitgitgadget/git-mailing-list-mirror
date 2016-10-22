Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E0201F4F8
	for <e@80x24.org>; Sat, 22 Oct 2016 07:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753017AbcJVHdb (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 03:33:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62241 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752755AbcJVHda (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 03:33:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2431B3B1B3;
        Sat, 22 Oct 2016 03:33:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IS/UtT4SP3m7eHuo69IjjYOjQo8=; b=uJGJXX
        3l6wuD+aGmtI/j1T2Qk57TSXFmx/4jh3lijqr5eUl1TumTJfs7uEN6d4SCAeVDsa
        ptOQleBVz49eSCjTDGX6vxIU0ZZV5HrCDxcDPpYfYLsbGBtZvdeCPf20/s9nr149
        BHuY47BT1IeY8WexAodiRC5uHd9sYpVcZS9rI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LDMwo5SE5uSFF2o4ISplAmXBYBlR4bCW
        h+6gzb/voaVOH0DlKzLN9mmqK5QmGA8ZId5TJvnvjJmJQ0EVMDA/VHbGFgxPU+O8
        gCm0XVUFhvfiic3ohJi61qLNVt6xz2ughsNrY32yEOB5t10tK9fZohifNE+Wzldv
        /2uz0cIERoc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 17F6E3B1B1;
        Sat, 22 Oct 2016 03:33:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 765BC3B1AD;
        Sat, 22 Oct 2016 03:33:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Stefan Beller <sbeller@google.com>, Johannes.Schindelin@gmx.de,
        git@vger.kernel.org, venv21@gmail.com, dennis@kaarsemaker.net,
        jrnieder@gmail.com
Subject: Re: [PATCH 2/3] submodule tests: replace cloning from . by "$(pwd)"
References: <20161021235939.20792-1-sbeller@google.com>
        <20161021235939.20792-3-sbeller@google.com>
        <c6c5ce05-3511-a992-e079-316f0ce90ecd@kdbg.org>
Date:   Sat, 22 Oct 2016 00:33:26 -0700
In-Reply-To: <c6c5ce05-3511-a992-e079-316f0ce90ecd@kdbg.org> (Johannes Sixt's
        message of "Sat, 22 Oct 2016 09:09:25 +0200")
Message-ID: <xmqqh984aldl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D33135D0-9829-11E6-A1E1-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>> The logic to construct the relative urls is not smart enough to
>> detect that the ending /. is referring to the directory itself
>> but rather treats it like any other relative path, i.e.
>>
>>     path/to/dir/. + ../relative/path/to/submodule
>>
>> would result in
>>
>>     path/to/dir/relative/path/to/submodule
>>
>> and not omit the "dir" as you may expect.
>>
>> As in a later patch we'll normalize the remote url before the
>> computation of relative urls takes place, we need to first get our
>> test suite in a shape with normalized urls only, which is why we should
>> refrain from cloning from '.'
>
> But you are removing a valid use case from the tests. Aren't you
> sweeping something under the rug with this patch?

I share the same reaction.

If the primary problem being solved is that the combination of a
relative URL ../sub and the base URL for the superproject which is
set to /path/to/dir/. (due to "clone .") were incorrectly resolved
as /path/to/dir/sub (because the buggy relative path logic did not
know that removing "/." at the end does not take you to one level
up), and a topic that fixes the bug would make that relative URL
../sub to be resolved as /path/to/sub, of course.  Otherwise, the
topic did not fix the bug.  

Now if a test that wanted to have a clone of the superproject by
"clone .", which results in the base URL of /path/to/dir/., actually
wants to refer in its .gitmodules to /path/to/dir/sub (which after
all was where the submodule the test created with or without the
bugfix), I would think the right adjustment for the test that used
to rely on the buggy behaviour would be to stop using ../sub and
instead use ./sub as the relative URL, no?  After all, the bug forced
the original test writer to write ../sub but the submodule in this
case actually is at ./sub relative to its superproject, and that is
what the original test writer would have written if the bug weren't
there in the first place, no?

Another thing I do not quite understand is why this step comes
before the fix.  If the "clone ." is adjusted to avoid triggering
the buggy behaviour, i.e. making the base URL to /path/to/dir
(instead of /path/to/dir/.), wouldn't the relative URL ../sub that
was written to work around the bug that hasn't been fixed yet in
this step need to be adjusted anyway?  It would end up referring to
/path/to/sub and not /path/to/dir/sub until the fix is put in place.

Is the removal of remote.origin.url a wrong workaround for that
breakage, I wonder...  I do not understand that change at all, and I
do not think it was explained in the log message.

If we really wanted to update the test before fixing the bug, I
would understand if this step changed ../sub (or whatever relative
URL that has extra ../ only because the base URL has extra /. at the
end to compensate for the buggy resolution) to ./sub in the tests
and marked them to expect failure, and then a later step that fixes
the bug turns them to expect success without make any other change.


