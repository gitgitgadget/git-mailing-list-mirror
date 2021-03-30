Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE7DC433E4
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 18:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74BA261987
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 18:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbhC3S7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 14:59:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61225 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbhC3S6q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 14:58:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 14EA6119C59;
        Tue, 30 Mar 2021 14:58:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L7Q4DsAgv7VvY4HTLUOMQXY8Eno=; b=eEYPGr
        Zef+uA4TlD+KKdL1Tap8RYp/WgFI75CDBnQXE2XZPjEaEwg97Ib0NJtnsjabD892
        C2z1PSe0uaJWa8Fd9mjEQ1R2AaUeYz6qQh2OcD4O5blYJL4I2vF0Z1mLolCFQ1xG
        HGzS2pcA4a2/07rnR9qD4XZzM6cqVjJWlxcqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q4hUBVC7efM2KH8RvJ2pdrxyaWIlWsLS
        QZSA1Dmpn5Lh5aASUuKJ/582n2v1jsP/3JFeu+wcNw/V9LiEiC4SoTZKLItPdHxX
        1qPweQu3K9yB/hHWmlprbkFdESbz0HpvDuivK8TCIS38wxiIzx49kcSimKFr55Ui
        RlY/lb5/mz4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E357119C58;
        Tue, 30 Mar 2021 14:58:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 46503119C57;
        Tue, 30 Mar 2021 14:58:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug report: git branch behaves as if --no-replace-objects is
 passed
References: <CABPp-BEAbN05+hCtK=xhGg5uZFqbUvH9hMcCNMcBWp5JWLqzPw@mail.gmail.com>
        <YGLNBFJv8NKmrbvz@coredump.intra.peff.net>
Date:   Tue, 30 Mar 2021 11:58:41 -0700
In-Reply-To: <YGLNBFJv8NKmrbvz@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 30 Mar 2021 03:02:28 -0400")
Message-ID: <xmqq35wceae6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2AF277E-9189-11EB-ACAE-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... though if we go that route, I suspect we ought to be adding both the
> original _and_ the replacement.

So "branch --contains X" would ask "which of these branches reach X
or its replacement?" and "branch --no-contains X" would ask "which
of these do not reach X nor its replacement?" --- I guess the result
is still internally consistent (meaning: any and all branches fall
into either "--contains X" or "--no-contains X" camp).

> I'm not entirely sure this is a good direction, though.
>
>> and possibly worse, if I create a new branch based on it and use it:
>> 
>>     $ git branch foobar deadbeefdeadbeefdeadbeefdeadbeefdeadbeef
>>     $ git checkout foobar
>>     $ echo stuff >empty
>>     $ git add empty
>>     $ git commit -m more
>> 
>> then it's clear that branch created foobar pointing to the replaced
>> object rather than the replacement object -- despite the fact that the
>> replaced object doesn't even exist within this repo:
>> 
>>     $ git cat-file -p HEAD
>>     tree 18108bae26dc91af2055bc66cc9fea278012dbd3
>>     parent deadbeefdeadbeefdeadbeefdeadbeefdeadbeef
>>     author Elijah Newren <newren@gmail.com> 1617083739 -0700
>>     committer Elijah Newren <newren@gmail.com> 1617083739 -0700
>> 
>>     more
>
> Yeah, that's pretty horrible.

I am not sure.  As you analize below, the replace mechanism is about
telling Git: when anybody refers to deadbeef, use its replacement if
defined instead.

And one of the points in the mechanism is to allow to do so even
retroactively, so the HEAD object there may be referring to deadbeef
that may not exist does not matter, as long as the object that is to
replace deadbeef is available.  If not, that is a repository
corruption.  After all, the commit object you cat-file'ed may have
been created by somebody else in a separate repository that had
deadbeef before they were told by Elijah that the object is obsolete
and to be replaced by something else (Git supports distributed
development) and then pulled into Elijah's repository, and we should
be prepared to seeing "parent deadbeef" in such a commit.  As long as
replacement happens when accessing the contents, that would be OK.

So, I do not see it as "pretty horrible", but I may be missing
something.



