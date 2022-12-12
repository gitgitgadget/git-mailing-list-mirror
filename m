Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0016CC4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 12:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiLLM2h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 07:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiLLM2g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 07:28:36 -0500
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6706386
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 04:28:33 -0800 (PST)
References: <20221209150048.2400648-1-toon@iotcl.com>
 <20221209150048.2400648-2-toon@iotcl.com>
 <93d61412-3786-b2b3-3fe8-4574336b08fb@dunelm.org.uk>
 <xmqq5yekyvrh.fsf@gitster.g>
 <ddae1940-f58f-e410-7606-d0bcf8d06cd3@dunelm.org.uk>
 <xmqq8rjdv5um.fsf@gitster.g>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1670848112;
        bh=OLBpWlp8oRgxibg4dBjHY75yaURLUhVajhQd/oLjT9E=;
        h=References:From:To:Subject:Date:In-reply-to:Message-ID:
         Mime-Version:Content-Type:From:Subject:To:Date:Sender:Content-Type:
         Content-Transfer-Encoding:Content-Disposition:Mime-Version:
         Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=cfYvwTVnWTAjDeujs7HNVOKVnzdQsPqvQAeRNW3BZ7drTSbqlPb3irNmZhTHAI9RC
         TxsDsRLsxYDM4mP6vGvJRgHRG0bitX4s193A9MURrXYxc4BkghXEmKAgESbRs6AdWS
         HGKw035ZTeL40+kAP7PmwULN6QT2yGvJ2lJLT6fcfm8VMR/EFoi1hN3TTSJvNU3JhP
         2ZBuNBLzP7WMJah/JFQL1frmjcQgCknQ/cCXQ+xj4zJbviLm59af53toVrZrOWpWfB
         zd7pv4V1iKAPxdUFFQhVc+lsGTwmXfiYIaDohYja/Cb+ABCXG+rvFRlMPKmqpMJTBB
         aniiBPE+HGudA==
From:   Toon Claes <toon@to1.studio>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] cat-file: quote-format name in error when using -z
Date:   Mon, 12 Dec 2022 12:34:46 +0100
In-reply-to: <xmqq8rjdv5um.fsf@gitster.g>
Message-ID: <87cz8ohklt.fsf@to1.studio>
Mime-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> writes:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> Without "-z" you cannot pass object names that contain newlines so not
>> quoting the output does not cause a problem. We could start quoting
>> the object name without "-z" but we'd be changing the output without a
>> huge benefit.
>
> That's fair.  The next question is from a devil's advocate:
> is switching to the full cquote the best thing to do?
>
> If we were using the full cquote from the very beginning, of course
> it is, simply because that is what is used in all other places in
> Git.  Using the full cquote does mean a LF byte will be protected
> (i.e. instead of shown literally in the middle of other letters
> around LF, "other\nletters around LF" would be shown), but pathnames
> with backslashes and double quotes in them that have been shown
> without problems would be shown differently and will break existing
> parsers, which are written lazily with the assumption that they are
> perfectly happy to be "simple" thans to not having to deal with LF
> (because in their environment a path with LF in it do not matter).
>
> A bit safer thing to do is to replace LF (and not any other bytes
> that would be quoted with full cquote) in the path given in these
> messages with something else (like NUL to truncate the output
> there).

So object name "HEAD:other\nletters around LF" would give the error
message "other missing"? That error message would also occur when the
user does not provide -z. I think that might be confusing.

> As these answers are given in order, the object names are
> not absolutely needed to identify and match up the input and the
> output, and properly written parsers would be prepared to see a
> response with an object name that it did not request and handle it
> sanely, such a change may not break such a parser for a path with
> any byte that are modified with full cquote.

Yes, the answers are returned in order, so personally I don't care too
much about the returned object name format. I even would be fine with a
generic error message that omits the input name, for example "object
missing". As long as it's clear that the requested object is not found.

For your information, there is an extreme edge case a user could fake an
object, and that's what we want to avoid as well. For example the
command (line break included):

printf "aabbccddeeff00112233445566778899aabbccdd blob 26
this object is not" | git cat-file --batch -z

Would print:

aabbccddeeff00112233445566778899aabbccdd blob 26
this object is not missing

This is perfectly valid git-cat-file output. Luckily I don't see any way
how this can be abused. Generally I think it's a good idea to not return
the input as-is in any situation. We could only replace newlines, but
cquoting already sanitizes the input, so why not use that?

> The above is with a devil's adovocate hat on, and I do not care too
> much, as I do not think butchering backslash with full cquote would
> not hurt even existing Windows users (if "HEAD:t\README.txt" named
> the same blob as "HEAD:t/README.txt" on a platform, doubling the
> backslashes in the output would have made quite a lot of damage, but
> I do not think we allow backslashes to name tree paths).

> By the way, there is another use of obj_name in batch_object_write()
> that can show whatever byte in it literally to the output.

Ah thanks! I will include in the next version, when we reach a consensus
on when or what to cquote.

--
Toon
