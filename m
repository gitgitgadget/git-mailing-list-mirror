Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1061C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 19:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DA4D60E52
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 19:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhINTKl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:10:41 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58495 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhINTKk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 15:10:40 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BE3E4148674;
        Tue, 14 Sep 2021 15:09:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=/TJFTus2gwcYhf7FUciSgte9n9rinEPtp7bw2xEXPPc=; b=h0Ha
        iwcAwfM5NL+CmPAFfZR5hzV3TuZiv6W9rjPgjc6NlQ0ZavjrsYrnxq85XI1pxEvj
        rpJIeEEYhtfh6ISqsV4WQinv6OyaCknLw5Pa3kd6rR5FHCSzKTtsKmCG/8z6rgrM
        amFHuMM7rO5RmNVSRlmERrQf2rWy6fBxKxFJs5E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B54DF148673;
        Tue, 14 Sep 2021 15:09:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0EC1F148671;
        Tue, 14 Sep 2021 15:09:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Subject: What should happen in credential-cache on recoverable error without
 SPAWN option?
References: <20210913085600.35506-1-carenas@gmail.com>
        <20210914072600.11552-1-carenas@gmail.com>
        <20210914072600.11552-3-carenas@gmail.com>
Date:   Tue, 14 Sep 2021 12:09:18 -0700
Message-ID: <xmqqilz30yap.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43A0A98A-158F-11EC-9201-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While reviewing Carlo's "credential-cache: check for windows
specific errors", I noticed this piece of code, that came from
8ec6c8d7 (credential-cache: report more daemon connection errors,
2012-01-09):

	if (send_request(socket, &buf) < 0) {
		if (errno != ENOENT && errno != ECONNREFUSED)
			die_errno("unable to connect to cache daemon");
		if (flags & FLAG_SPAWN) {
			spawn_daemon(socket);
			if (send_request(socket, &buf) < 0)
				die_errno("unable to connect to cache daemon");
		}
	}

What would happen when we get a resumable error and then weren't
given the SPAWN flag?  It seems that do_cache() simply returns
without dying.  Shouldn't we get "unable to connect" in such a case?

This in turn came from 98c2924c (credentials: unable to connect to
cache daemon, 2012-01-07), before it, the code read like this:

	if (!send_request(socket, &buf))
		return;
	if (flags & FLAG_SPAWN) {
 		spawn_daemon(socket);
		send_request(socket, &buf);
 	}

so it looks to me that I am puzzled by an incomplete error handling
introduced by 98c2924c, and if we wanted to complete it, it may
perhaps look like this patch on top of Carlo's patch?

Or am I barking up a wrong tree and error checking in this command
does not really make a real-life difference?

Thanks.


 builtin/credential-cache.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git c/builtin/credential-cache.c w/builtin/credential-cache.c
index 78c02ad531..a41a17e58f 100644
--- c/builtin/credential-cache.c
+++ w/builtin/credential-cache.c
@@ -101,13 +101,11 @@ static void do_cache(const char *socket, const char *action, int timeout,
 	}
 
 	if (send_request(socket, &buf) < 0) {
-		if (connection_fatally_broken(errno))
+		if (connection_fatally_broken(errno) && !(flag & FLAG_SPAWN))
+			die_errno("unable to connect to cache daemon");
+		spawn_daemon(socket);
+		if (send_request(socket, &buf) < 0)
 			die_errno("unable to connect to cache daemon");
-		if (flags & FLAG_SPAWN) {
-			spawn_daemon(socket);
-			if (send_request(socket, &buf) < 0)
-				die_errno("unable to connect to cache daemon");
-		}
 	}
 	strbuf_release(&buf);
 }
