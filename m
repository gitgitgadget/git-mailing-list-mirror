Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86C562018A
	for <e@80x24.org>; Fri,  1 Jul 2016 22:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbcGAWTm (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 18:19:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61139 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752102AbcGAWTl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 18:19:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 60E1C29D1D;
	Fri,  1 Jul 2016 18:19:40 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7q0170/Zb3cGmrUwranEhBC8CcY=; b=YIv8qt
	tKp4KiWvDZN5ip07XPlpV+vNazxO1gjUaLLx2ks5JdRnD1qcNBwTwnpjKIoTjZav
	JwF5FfCiIhuHgypAnjjCm2piOwZQKCZX75IkQBpt/sldb+OPmD4Z8Px79h3YXNd+
	Xl6XAhRSh+JGq4MqrFkck5DkCY9jpdHrXBdXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Oo5w6r+Xcd/TtU5dtMsIJwvqdMZRNbtD
	E9qrTAowfxAXbe20I+UoG9xeZIR38gUFpm2Af/o6WhC6AaQtuddb71kwpDchzr6r
	04FuOvIXRePvzWwxBJ96qel0c4BwtwSDwcgMlZtfY5BUFJdz4/891iaeg2rN0Jx2
	cHOQGIjkQBM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5973529D1C;
	Fri,  1 Jul 2016 18:19:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D441F29D1A;
	Fri,  1 Jul 2016 18:19:39 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	"dmh\@ucar.edu" <dmh@ucar.edu>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] consistent setup code for external commands
References: <7210bce6-093b-9fdf-9a9b-94059ad0d4e3@ucar.edu>
	<20160701040715.GB4832@sigill.intra.peff.net>
	<20160701055532.GA4488@sigill.intra.peff.net>
Date:	Fri, 01 Jul 2016 15:19:37 -0700
In-Reply-To: <20160701055532.GA4488@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 1 Jul 2016 01:55:32 -0400")
Message-ID: <xmqq4m89vw5i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E715A41C-3FD9-11E6-8947-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jul 01, 2016 at 12:07:15AM -0400, Jeff King wrote:
>
>> Interesting. It's failing on the assert(argv0_path) in system_path().
>> 
>> That's part of the RUNTIME_PREFIX code which is built only on Windows,
>> so this is a Windows-specific issue.
>> 
>> I can guess the reason that argv0_path is not set is that
>> credential-store has its own main() function and does not call
>> git_extract_argv0_path(). It never mattered before, but as of v2.8.0,
>> one of the library functions it calls wants to use system_path(), which
>> assumes that the argv0 stuff has been set up.
>> 
>> I'm preparing some patches to fix this case (and some other related
>> ones).
>
> Here they are:
>
>   [1/5]: add an extra level of indirection to main()
>   [2/5]: common-main: call git_extract_argv0_path()
>   [3/5]: common-main: call sanitize_stdfds()
>   [4/5]: common-main: call restore_sigpipe_to_default()
>   [5/5]: common-main: call git_setup_gettext()

As this is also a fix to maint-2.8 track, I tweaked them to ensure
that they apply there, and queued the result as jk/common-main.  I
double checked the result by comparing the result of applying these
five patches directly on top of master, and the result of merging
that jk/common-main (based on maint-2.8) into master, and they seem
to match.

Thanks.
