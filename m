Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC27C47082
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 01:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53320613FE
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 01:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhFDBiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 21:38:01 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62347 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhFDBiB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 21:38:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 21FD712B637;
        Thu,  3 Jun 2021 21:36:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y7anFPGAz+YiSLy6Q2Eya5m2LLgdpmcQjJdIis
        zO1IU=; b=YL/ysSJIXu7vYHsCcL8A32ST0dJHtv9TNUVe4NyHEwfeZ098Q0rIJr
        uhBa5k7dAfPlweTK7wFgp21NJHhQj/4xppDQ6mQxsNkUCP1F2j2oqCfzz5dK1lbp
        YUvMtdtvo9g6+pCp3qAFIm4m0eb6BwB6f4bFIVTh3LkeJc9BkfdmU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D6F612B636;
        Thu,  3 Jun 2021 21:36:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3FB0C12B634;
        Thu,  3 Jun 2021 21:36:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.32.0-rc3 - t5300 Still Broken on NonStop
 ia64/x86
References: <002701d757d8$1a8d9dc0$4fa8d940$@nexbridge.com>
        <YLfc2+Te7Y3UY+Sm@nand.local>
        <YLfgy94sbmStC0mR@coredump.intra.peff.net>
        <YLfl4jkuwSCiNrrS@nand.local>
        <YLfm8cqY6EjQuhcO@coredump.intra.peff.net>
Date:   Fri, 04 Jun 2021 10:36:11 +0900
In-Reply-To: <YLfm8cqY6EjQuhcO@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 2 Jun 2021 16:15:45 -0400")
Message-ID: <xmqqk0na2yyc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F39D52A-C4D5-11EB-9E08-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This looks as I'd expect. But after seeing Eric's response, we perhaps
> want to do away with the knob entirely.

Thanks.  I was hoping somebody in the thread would tie the loose
ends, but upon inspection of the output from

    $ git grep -e fsync\( maint seen -- \*.[ch]

it turns out that fsync_or_die() is the only place that calls
fsync(), so perhaps doing it in a way that is quite different from
what has been discussed may be even a better alternative.

If any new callers care about the return value of fsync(), I'd
expect that they would be calling this wrapper, and the "best
effort" callers that do not check the returned value by definition
do not care if fsync() does not complete due to an interrupt, so I
am hoping that the current "we only call it from this wrapper" is
not just "the code currently happens to be this way", but it is
sensible that the code will stay that way in the future.

Obviously I appreciate reviews and possibly tests, but sanity
checking my observation that fsync() is called only from here is a
good thing to have.

-- >8 --
Subject: fsync(): be prepared to see EINTR

Some platforms, like NonStop do not automatically restart fsync()
when interrupted by a signal, even when that signal is setup with
SA_RESTART.

This can lead to test breakage, e.g., where "--progress" is used,
thus SIGALRM is sent often, and can interrupt an fsync() syscall.

Make sure we deal with such a case by retrying the syscall
ourselves.  Luckily, we call fsync() fron a single wrapper,
fsync_or_die(), so the fix is fairly isolated.
    
Reported-by: Randall S. Becker <randall.becker@nexbridge.ca>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Taylor Blau <me@ttaylorr.com>
[jc: the above two did most of the work---I just tied the loose end]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 write-or-die.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git i/write-or-die.c w/write-or-die.c
index eab8c8d0b9..534b2f5cba 100644
--- i/write-or-die.c
+++ w/write-or-die.c
@@ -57,7 +57,11 @@ void fprintf_or_die(FILE *f, const char *fmt, ...)
 
 void fsync_or_die(int fd, const char *msg)
 {
-	if (fsync(fd) < 0) {
+	int status;
+
+	while ((status = fsync(fd)) < 0 && errno == EINTR)
+		; /* try again */
+	if (status < 0) {
 		die_errno("fsync error on '%s'", msg);
 	}
 }
