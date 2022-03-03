Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB535C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 21:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbiCCV7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 16:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbiCCV7a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 16:59:30 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4124579B
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 13:58:43 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E9FE18BFCF;
        Thu,  3 Mar 2022 16:58:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8Q6vIGwbnCit8ykgTG+lwd6sVAaAsrd0MV8s9P
        auhEU=; b=VPFW6pKAZTM9RuAnt5qh3mqcg5xEfucqrD1eFy6DIeJhYcRnTQsR/n
        p1yF+WrwJJly0VjLwUkFEpjmu8kJDi96k1NZYnp1rXhtwc1y2ZFMMsMsVpxtimob
        4p5jvyvzZxjGZfkCrpjYcsfrHCFu5Gxrk1o64Kqe3uqFZ87e+etyo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3764F18BFCE;
        Thu,  3 Mar 2022 16:58:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A97C018BFCD;
        Thu,  3 Mar 2022 16:58:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git List Mailing <git@vger.kernel.org>
Subject: Re: Silly 'git am' UI issue
References: <CAHk-=wi2HkQ648sYe3BusCEh5tBYjJbQ9c5T-DrykfEdgRbi=g@mail.gmail.com>
Date:   Thu, 03 Mar 2022 13:58:39 -0800
In-Reply-To: <CAHk-=wi2HkQ648sYe3BusCEh5tBYjJbQ9c5T-DrykfEdgRbi=g@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 3 Mar 2022 12:31:05 -0800")
Message-ID: <xmqqlexq8zqo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 160FCBAC-9B3D-11EC-9C5A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So what happens is that "git am" decides that <filename> is the
> argument to the "--whitespace" option, then doesn't see an argument at
> all, and expects the input from stdin. So it "hangs", waiting for
> input. No error messages, no nothing.

Ouch.  I suspect there are other (e.g. "pull -> fetch") passthru
that share similar issues, but "am" may be quite special in that
it is prepared to read its input from the standard input stream.

I wonder if something like this would have helped.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
Subject: am/apply: warn if we end up reading patches from terminal

In an interactive session, "git am" without arguments, or even
worse, "git am --whitespace file", waits silently for the user to
feed the patches from the standard input (presumably by typing or
copy-pasting).  Give a feedback message to the user when this
happens, as it is unlikely that the user meant to do so.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailsplit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git c/builtin/mailsplit.c w/builtin/mailsplit.c
index 7baef30569..c45f542341 100644
--- c/builtin/mailsplit.c
+++ w/builtin/mailsplit.c
@@ -223,6 +223,9 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
 	FILE *f = !strcmp(file, "-") ? stdin : fopen(file, "r");
 	int file_done = 0;
 
+	if (isatty(fileno(f)))
+		warning(_("reading patches from stdin/tty..."));
+
 	if (!f) {
 		error_errno("cannot open mbox %s", file);
 		goto out;
