Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08ABCC7EE26
	for <git@archiver.kernel.org>; Mon, 15 May 2023 17:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242563AbjEORXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 13:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244058AbjEORW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 13:22:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374531208F
        for <git@vger.kernel.org>; Mon, 15 May 2023 10:21:07 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 079E21F5A14;
        Mon, 15 May 2023 13:20:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qNvyxCIYXtIjNE0+gW0cUpZFmRaITmwviHMgsu
        l+EhE=; b=MM2mSpuZ8IX5mbrJmSdxiGMoxWSyU+9m9wPggFx5MYpzydbLPQ/Yza
        xDBfCFUPp9LE3PbkPeEPx5PSSyn+YvQahtPYAq57zqXXxV9cbkfEM7lm3EfZv45l
        +Pb/dm6Hc16b5lxfzGuBHiwzBIfQrfcNI72t73TCHs2a8X/rtzU/s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 00B651F5A13;
        Mon, 15 May 2023 13:20:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2F3501F5A12;
        Mon, 15 May 2023 13:20:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v5 1/1] cat-file: quote-format name in error when using -z
References: <xmqqilfhctrr.fsf@gitster.g>
        <20230510190116.795641-1-toon@iotcl.com>
        <20230510190116.795641-2-toon@iotcl.com> <xmqqpm782be6.fsf@gitster.g>
        <87h6sh6f81.fsf@iotcl.com> <xmqqy1ltqygb.fsf@gitster.g>
        <ec139b78-1d36-f894-e39f-f29877a67b18@gmail.com>
Date:   Mon, 15 May 2023 10:20:51 -0700
In-Reply-To: <ec139b78-1d36-f894-e39f-f29877a67b18@gmail.com> (Phillip Wood's
        message of "Mon, 15 May 2023 09:47:38 +0100")
Message-ID: <xmqqmt25a4uk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7CB1A7A-F344-11ED-A39E-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 12/05/2023 17:57, Junio C Hamano wrote:
>> Toon Claes <toon@iotcl.com> writes:
>> Stepping back a bit, how big a problem is this in real life?  It
>> certainly is possible to create a pathname with funny byte values in
>> it, and in some environments,letters like single-quote that are
>> considered cumbersome to handle by those who are used to CLI
>> programs may be commonplace.  But a path with newline?  Or any
>> control character for that matter?  And this is not even the primary
>> output from the program but is an error message for consumption by
>> humans, no?
>> I am wondering if it is simpler to just declare that the paths
>> output in error messages have certain bytes, probably all control
>> characters other than HT, replaced with a dot, and tell the users
>> not to rely on the pathnames being intact if they contain funny
>> bytes in them.
>
> We could only c-quote the name when it contains a control character
> other that HT. That way names containing double quotes and backslashes
> are unchanged but it will still be possible to parse the path from the
> error message. If we're going to munge the name we might as well use
> our standard quoting rather than some ad-hoc scheme.

In the above suggestion, I gave up and no longer aim to do
"quoting".  A more appropriate word for the approach is "redacting".
The message essentially is: If you use truly problematic bytes in
your path, they are redacted (so do not use them if it hurts).

This is because I am not sure how "names containing dq and bs are
unchanged" can be done without ambiguity.  If I see a message that
comes out of this:

	printf("%s missing\n", obj_name);

and it looks like

	"a\nb" missing

how do I tell if it is complaining about the object the user named
with a three-byte string (i.e. lowercase-A, newline, lowercase-B),
or a six-byte string (i.e. dq, lowercase-A, bs, lowercase-N,
lowercase-B, dq)?

If we were forbidding '"' to appear in a refname, then we could take
advantage of the fact that the name of an object inside a tree at a
funny path would not start with '"', to disambiguate.  For the
three- and six-byte string cases above, the formatting function will
give these messages (referred to as "sample output" below):

	"master:a\nb" missing
	master:"a\nb" missing

because of your "we do not exactly do our standard c-quote; we
exempt dq and bs from the bytes to be quoted" rule.

But it still feels a bit misleading.  This codepath may have the
whole objectname as a single string so that c-quoting the entire
"<commit> <colon> <path>" inside a single c-quoted string that
begins with a dq is easy, but not all codepaths are lucky and some
may have to show <commit> and <path> separately, concatenated with
<colon> at the outermost output layer, which means that the second
one from the sample output may still mean the path with three-byte
name in the tree of 'master' commit.

And worse yet, because

	git branch '"master'

is possible (even though nobody sane would do that), so "treat the
string as c-quoted only if the object name as a whole begins with a
dq", this disambiguation idea would not work.  The first one from
the sample output could be the blob at the path with a five-byte
string name (i.e. lowercase-A, bs, lowercase-N, lowercase-B, dq)
in the tree of the commit at the tip of branch with seven-byte
string name (i.e. dq followed by 'master').

So, I dunno.
