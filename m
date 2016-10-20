Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BE181F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 20:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbcJTUWG (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 16:22:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50261 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751827AbcJTUWF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 16:22:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E32EF475D0;
        Thu, 20 Oct 2016 16:22:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SOayu+rswoez+Pt3SiWhppxcxxw=; b=dHKrGL
        CF7v19xiij33AsvyTlBD+Uq4d4RHlSIBS9eH3qrGOkmWbBfQEh1C975Il+RpWEKt
        bYbMiuC4HS84Y3t7S2fnJYj3zufl4m80m9VhE4retuDMwEiGARLdjUd8w/1Sh8F6
        AC2IrXme5N5XkW/B6e+/E/OWiI2oeDdAoN61U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eCpQKRe+U8cVNxFEwmFrj7bfPYk+oxov
        7aA4avgR+7bh0Zy/GUx//cLH3uwOLVoqKNgc0Pd8sTw5IXibyvGid6O54cfpZNVT
        cID9ivFxkGduZBc6sgZHE0oAI57pfs5261Mu33byNg+TQu0RnLjy+pdcoWT0SW8n
        CXrX9MLdStY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DAEA1475CF;
        Thu, 20 Oct 2016 16:22:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4ACF2475CE;
        Thu, 20 Oct 2016 16:22:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 20/25] sequencer: refactor write_message()
References: <cover.1476120229.git.johannes.schindelin@gmx.de>
        <cover.1476450940.git.johannes.schindelin@gmx.de>
        <9a66d53ebd86d35136597e534be03605bb1346bc.1476450940.git.johannes.schindelin@gmx.de>
Date:   Thu, 20 Oct 2016 13:22:01 -0700
In-Reply-To: <9a66d53ebd86d35136597e534be03605bb1346bc.1476450940.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 14 Oct 2016 15:18:37 +0200
        (CEST)")
Message-ID: <xmqqh986g49i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DCE76D2E-9702-11E6-8321-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The write_message() function safely writes an strbuf to a file.
> Sometimes it is inconvenient to require an strbuf, though: the text to
> be written may not be stored in a strbuf, or the strbuf should not be
> released after writing.
>
> Let's refactor "safely writing string to a file" into
> write_with_lock_file(), and make write_message() use it.
>
> The new function will make it easy to create a new convenience function
> write_file_gently() that does not die(); as some of the upcoming callers
> of this new function will want to append a newline character, we already
> add that flag as parameter to write_with_lock_file().
>
> While at it, roll back the locked files in case of failure, as pointed
> out by Hannes Sixt.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)

Once a helper function starts taking <buf, len> pair, not a strbuf,
it becomes obvious that it does not make much sense to calling
strbuf_release() from the helper.  It is caller's job to do the
memory management of the strbuf it uses to pass information to the
helper, and the current api into write_message() is klunky.

If I were doing this, I would make this into three separate steps:

    - move the strbuf_release(msgbuf) to the caller in
      do_pick_commit();

    - add the missing rollback_lock_file(), which is a bugfix; and
      then finally

    - allow the helper to take not a strbuf but <buf, len> pair as
      parameters.

The end result of this patch achieves two thirds of the above, but
especially given that write_message() only has two call sites in a
single function, I think it is OK and preferrable even to do all
three.
