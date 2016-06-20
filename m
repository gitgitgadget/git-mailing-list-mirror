Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BF761FF40
	for <e@80x24.org>; Mon, 20 Jun 2016 16:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556AbcFTQEM (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 12:04:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50766 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754375AbcFTQDf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 12:03:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2764E24C6B;
	Mon, 20 Jun 2016 12:03:34 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pNyDNzDhW3uejsxj7R9amLttGkM=; b=OHIcTx
	P7SC9eCxEbTo5SG83ctnkrkHx5P5arMC9TKGwfMbm8eGJsG9vBryIDrbOrUMg6gW
	CGsRfgs0+iqZy3IvuIV0b20WWFP9bOOJxbx7KF1HkG7EHYvlp4qJ3gQkcgRQmFuQ
	ylWjZ999UuHoAYB/2wbYvMGXYy+LZlG2C+/Jo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ycntj2xYLATQwwpEqlAWM8R7PbQbA8ui
	wBct12wYntsyscNOjeAbjaq5pT7FYnPcke0Y0iMolb+ZjcGYYWJjrUdpH3ReRI7J
	p812+eRggQQjo976QtJ+Qdt8uvT2WfthsKC0cdT50mZlWUQuu6HctMNK9WgGCsrj
	L1F0qMnHbYk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F32C24C6A;
	Mon, 20 Jun 2016 12:03:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C3AB24C68;
	Mon, 20 Jun 2016 12:03:33 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] format-patch: avoid freopen()
References: <cover.1466244194.git.johannes.schindelin@gmx.de>
	<de218a6cc529b3f5c33dc4b8282f16fd8a5329a8.1466244194.git.johannes.schindelin@gmx.de>
	<CAPig+cTiexRhzS3MwMEntGYxKms-XQvtoc7HOnUGJvDaBSK7JA@mail.gmail.com>
	<alpine.DEB.2.20.1606200814510.22630@virtualbox>
Date:	Mon, 20 Jun 2016 09:03:31 -0700
In-Reply-To: <alpine.DEB.2.20.1606200814510.22630@virtualbox> (Johannes
	Schindelin's message of "Mon, 20 Jun 2016 08:26:01 +0200 (CEST)")
Message-ID: <xmqq4m8nvodo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A055678-3700-11E6-85C5-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When format-patch calls the diff machinery, want_color() is used to
> determine whether to use ANSI color sequences or not. If use_color is not
> set explicitly, isatty(1) is used to determine whether or not the user
> wants color. When stdout was freopen()ed, this isatty(1) call naturally
> looked at the file descriptor that was reopened, and determined correctly
> that no color was desired.
>
> With the freopen() call gone, stdout may very well be the terminal. But we
> still do not want color because the output is intended to go to a file (at
> least if output_directory is set).

How does this interact with --color=... that is given from the
command line at the same time?  Currently --color=always would
give you a coloured output.

I personally do not think of a sensible reason why anybody wants a
colored format-patch output, but Git's userbase has grown large
enough and you can no longer expect that only sensible people use it
;-)

You can probably sell "when giving out put to file, we will never
color the output" as an improved new world order, but if that is
what this change wants to do, it probably deserves a separate patch.

I however think you can avoid breaking expectations by people who
are not so sensible by overriding only when use_color is set to
GIT_COLOR_AUTO, perhaps?
