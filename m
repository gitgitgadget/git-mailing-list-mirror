Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134E9C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 17:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57ED2053B
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 17:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UsYanr4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfL3Rmp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 12:42:45 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60855 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfL3Rmo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 12:42:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5BD7D30F53;
        Mon, 30 Dec 2019 12:42:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EHKZPvpDsA+ZFm9fsAl0Qd8HA44=; b=UsYanr
        4WkA8isP7YizwBTQTmglzKeWkiNxEvwk5iMgryrhsznrgGup0NvMf8fViKUk37sy
        6OApIKRmnsZ4FJ0mX2BeJ5BoRSwZVEYEDb7deTqsKHQ3SGqlu4bQ2k0FXOado/xD
        WAsjU9r/GM303KbNCZnlaCpZAEZgoLu9ALPPc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EjqVyacelorrNwke0UQXz572IO2GJv6D
        fhk3yc3zhDCcOEVb8iFGMnzMODhPYf0zBNDrz3YOqJEHJbOuqLzr06nAB0ojuIWI
        s2ov9tsQNnQi+pn9LBtJgWVJA1PcZeJL96tEQM4AFmingjkdC4Ud/WKmxgd4qCbV
        /3Kh7Ut+vQc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 549E930F52;
        Mon, 30 Dec 2019 12:42:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B9F3E30F51;
        Mon, 30 Dec 2019 12:42:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: ERANGE strikes again on my Windows build; RFH
References: <6eb02a73-9dcb-f1fc-f015-80e71e9910d6@kdbg.org>
Date:   Mon, 30 Dec 2019 09:42:40 -0800
In-Reply-To: <6eb02a73-9dcb-f1fc-f015-80e71e9910d6@kdbg.org> (Johannes Sixt's
        message of "Sat, 28 Dec 2019 16:41:42 +0100")
Message-ID: <xmqqh81hhfqn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C76F3E84-2B2B-11EA-8862-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> In sha1-file.c:read_object_file_extended() we have the following pattern:
>
> 	errno = 0;
> 	data = read_object(r, repl, type, size);
> 	if (data)
> 		return data;
>
> 	if (errno && errno != ENOENT)
> 		die_errno(_("failed to read object %s"), oid_to_hex(oid));
>
> That is, it is expected that read_object() does not change the value of
> errno in the non-error case. I find it intriguing that we expect a quite
> large call graph that is behind read_object() to behave this way.

Yeah, that is somewhat unfortunate and dubious, but as long as it
works (i.e. various system library calls the codepaths involved
behave sensibly), ...

> What if a subordinate callee starts doing
>
> 	if (some_syscall(...) < 0) {
> 		if (errno == EEXIST) {
> 			/* never mind, that's OK */
> 			...
> 		}
> 	}
>
> Would it be required to reset errno to its previous value in this
> failure-is-not-an-error case?

... that would be the logical conclusion, I think.

As a longer term fix for better portability (i.e. system libraries
may not behave exactly the way how the codepaths and POSIX expects
wrt to the errors detected), it may become necessary to change the
function to yield "how the call failed" information in addition to
"here is the block of bytes I read for the object", without relying
on particular errno.  But as a shorter term solution, ...

> The problem in my Windows build is that one of these subordinate
> syscalls is vsnprintf() (as part of a strbuf_add variant, I presume),
> and it fails with ERANGE when the buffer is too short. Do I have to
> modify the vsnprintf emulation to restore errno?

... I think this is a reasonable thing to do regardless.

Thanks.
