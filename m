Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3570EC433E3
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 105122177B
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QT3UbE6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgH0Pep (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:34:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57468 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgH0Pek (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 11:34:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D19785FEF;
        Thu, 27 Aug 2020 11:34:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=twoPF+c74i4cEOI1hjvUA29x0Qk=; b=QT3UbE
        6VOjcronALRda/JVfWN3rMJTq7zirAFl2LgEDvmj4Y+cn4xwDOzcr6RMG3eEWNQy
        LnEo1TSJ7X5DlAnQFig5OH5KkYjP3rBjIhHiZeBIxMJ1YzVRUEg/f1xgZud0MqEm
        sxCXa+lgBgjar8J8lhFYTnsM59fkAvrTXCZ6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kQ97DV7387gcyvxRdIotXSNfAEPzTqNu
        K1GEVf+PS8/pY77uBehsViV92rUeOHlykspq9xT1d+XcAQZzjqQTiq20mAeg4Kiv
        JINMXCY4OW8MKvAI0NJtMPxslV5JET0G9v9rjML0jO4MhRQKThgxAFHKOO7G1oIX
        NJiNSc3zHSU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54EC485FEE;
        Thu, 27 Aug 2020 11:34:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C2F9F85FED;
        Thu, 27 Aug 2020 11:34:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/2] credential-cache: use child_process.args
References: <xmqqd03dwe2x.fsf@gitster.c.googlers.com>
        <20200826194650.4031087-1-gitster@pobox.com>
        <20200826194650.4031087-3-gitster@pobox.com>
        <xmqqzh6ht7fg.fsf_-_@gitster.c.googlers.com>
        <20200827041456.GB3346457@coredump.intra.peff.net>
Date:   Thu, 27 Aug 2020 08:34:34 -0700
In-Reply-To: <20200827041456.GB3346457@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 27 Aug 2020 00:14:56 -0400")
Message-ID: <xmqq4koortkl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF340B1A-E87A-11EA-A4CF-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Aug 26, 2020 at 02:37:39PM -0700, Junio C Hamano wrote:
>
>> As child_process structure has an embedded strvec args for
>> formulating the command line, let's use it instead of using
>> an out-of-line argv[] whose length needs to be maintained
>> correctly.
>
> I forgot to mention in my other reply: I think this fails to mention the
> actual functional change, which is switching from the dashed form to
> using the "git" wrapper.

True.  With an extra paragraph.

-- >8 --
Subject: [PATCH] credential-cache: use child_process.args

As child_process structure has an embedded strvec args for
formulating the command line, let's use it instead of using
an out-of-line argv[] whose length needs to be maintained
correctly.

Also, when spawning a git subcommand, omit it from the command list
and instead use the .git_cmd bit in the child_process structure.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 credential-cache.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/credential-cache.c b/credential-cache.c
index 1cccc3a0b9..04df61cf02 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -39,13 +39,13 @@ static int send_request(const char *socket, const struct strbuf *out)
 static void spawn_daemon(const char *socket)
 {
 	struct child_process daemon = CHILD_PROCESS_INIT;
-	const char *argv[] = { NULL, NULL, NULL };
 	char buf[128];
 	int r;
 
-	argv[0] = "git-credential-cache--daemon";
-	argv[1] = socket;
-	daemon.argv = argv;
+	strvec_pushl(&daemon.args,
+		     "credential-cache--daemon", socket,
+		     NULL);
+	daemon.git_cmd = 1;
 	daemon.no_stdin = 1;
 	daemon.out = -1;
 
-- 
2.28.0-462-gf84ddd074d

