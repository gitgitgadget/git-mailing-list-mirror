Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ADDB1F859
	for <e@80x24.org>; Tue, 16 Aug 2016 16:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbcHPQ6r (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 12:58:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50604 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751861AbcHPQ6r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 12:58:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 967E2346A6;
	Tue, 16 Aug 2016 12:58:10 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZRA4O4F2ivrJRY7O5/a1SOvOkdU=; b=BgK+it
	GfkljJp4+OjbGUuDP69FZZKr6w4f5oKcpleg+Ju5UGlw4eBeL9osyv1/13kZ11Qj
	bIs4CHAPWZrOGbnSipglmuxf94tP02HnmGYM/3GOEJRBDsGLIts8xWO7nb3lUysc
	cPTNNznfOfn+7KZBWnklWeLzccljnEwXqjkJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P48r9/rB0mSUvVy/3vBOTlSoDo8Wpgqz
	dPy0rkNzpaEOz+ggLFzFblyCvGZKLLXv42aglIN4ViCswUlMphd/Drv5n8SLxEQV
	EFGbBSZtpLFJQh3fIAIQvLKiyNfhAL2GDdQlsjeZw8IjypaUFNQAR1RQScrc4Pz1
	uykRxIsVVOk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E868346A5;
	Tue, 16 Aug 2016 12:58:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1FAF7346A4;
	Tue, 16 Aug 2016 12:58:10 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	David Lang <david@lang.hm>
Cc:	Nikolaus Rath <Nikolaus@rath.org>, git@vger.kernel.org
Subject: Re: Working with zip files
References: <87y43wwujd.fsf@thinkpad.rath.org>
	<alpine.DEB.2.02.1608160926330.11774@nftneq.ynat.uz>
Date:	Tue, 16 Aug 2016 09:58:08 -0700
In-Reply-To: <alpine.DEB.2.02.1608160926330.11774@nftneq.ynat.uz> (David
	Lang's message of "Tue, 16 Aug 2016 09:27:55 -0700 (PDT)")
Message-ID: <xmqqeg5oejmn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C81DEC6-63D2-11E6-A682-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

David Lang <david@lang.hm> writes:

> you should be able to use clean/smudge to have git store the files
> uncompressed, which will help a lot.
>
> I think there's a way to tell it to do a xml aware diff/patch, but I
> don't remember how.

I do not know about "patch" (in the sense of "git apply"), but "git
diff" (and "git log -p") can take advantage of the clean/smudge
mechanism.  I used to deal with a file format that is gzipped xml so
my clean filter was "gzip -dc" while the smudge was "gzip -cn".
Essentially, this stors the xml before compression in the repository
so blobs delta well with each other and also the revisions are
made textually diff-able.

Nikolaus's case has one extra layer of complexity in that the "file"
is actually an archive of multiple files.  The clean/smudge pair he
writes need to be a filter that flattens the archive into a single
human-readable text byte stream and its reverse.
