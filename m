Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DA2B2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 15:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161634AbcHEPwy (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 11:52:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64569 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161523AbcHEPwx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 11:52:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C47930BEA;
	Fri,  5 Aug 2016 11:52:52 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jXwxwju2jKwqGQZ/eKWHrG/7Vkc=; b=jH58K7
	Y7GLPT2rZdEHm1s6PXu60ShLgZVyMWrs9qhR2wmL6B50x/idKQZ7XMdMfV1Kz6Iy
	XRYq9VqtGi39jpzhmf5sP7UNT/CJzxjZ5FUR1RWyzvDhlUjAFD2Z5+L2MRWe5GYX
	XCh9ESrUOSUIYZHHRz6acOroRmxu3ebnz/42A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b45V7YJbvQU9aeFN8OG9GYjlv0jLa1qr
	jXcI0cLAN2aJ18GoZ+UE286kuyHHJWoyWGSsWv0PpcvBKv5qZ8wRRHiLAP3nQbZ6
	GCSaUVacPA7SSBoncFhi5xke/7byvwnvH9q/Y5teHhKDMczievPgt3Fr2G3ubBNj
	6KJ12rHlw0g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0426330BE9;
	Fri,  5 Aug 2016 11:52:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 68FF230BE8;
	Fri,  5 Aug 2016 11:52:51 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] git mv: do not keep slash in `git mv dir non-existing-dir/`
References: <e0415c55e9bc651e7fa9f5f7717b4f6e44eb9ce1.1470407827.git.johannes.schindelin@gmx.de>
Date:	Fri, 05 Aug 2016 08:52:49 -0700
In-Reply-To: <e0415c55e9bc651e7fa9f5f7717b4f6e44eb9ce1.1470407827.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 5 Aug 2016 16:41:12 +0200
	(CEST)")
Message-ID: <xmqqtwezxlf2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA3C99D6-5B24-11E6-BA94-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> When calling `rename("dir", "non-existing-dir/")` on Linux, it silently
> succeeds, stripping the trailing slash of the second argument.
>
> This is all good and dandy but this behavior disagrees with the specs at
>
> http://pubs.opengroup.org/onlinepubs/9699919799/functions/rename.html
>
> that state clearly regarding the 2nd parameter (called `new`):
>
> 	If the `new` argument does not resolve to an existing directory
> 	entry for a file of type directory and the `new` argument
> 	contains at least one non- <slash> character and ends with one
> 	or more trailing <slash> characters after all symbolic links
> 	have been processed, `rename()` shall fail.

I agree with all of the above.  But

> Of course, we would like `git mv dir non-existing-dir/` to succeed (and
> rename the directory "dir" to "non-existing-dir").

I do not think I want that.  When I say "mv A B/", I want it to fail
if I made a typo for B; the trailing slash after B is an explicit
statement "I expect B to exist and I want A to appear at B/A".

Current Git behaviour on Linux seems to allow "git mv dir no-such-dir/"
but "dir" is renamed to "no-such-dir", which fails two expectations,
and I think this is broken.  If Windows port does not share this
breakage, that is a good thing.  We should fix Git behaviour on Linux
instead, I would think.
