Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D6EC3F2CD
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 23:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52AC4206A4
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 23:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbgB0Xyq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 18:54:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:56784 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729849AbgB0Xyq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 18:54:46 -0500
Received: (qmail 32618 invoked by uid 109); 27 Feb 2020 23:54:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Feb 2020 23:54:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11950 invoked by uid 111); 28 Feb 2020 00:03:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Feb 2020 19:03:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Feb 2020 18:54:45 -0500
From:   Jeff King <peff@peff.net>
To:     Ralf Thielow via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Alban Gruin <alban.gruin@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] config.mak.dev: re-enable -Wformat-zero-length
Message-ID: <20200227235445.GA1371170@coredump.intra.peff.net>
References: <pull.567.git.1582835130592.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.567.git.1582835130592.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 27, 2020 at 08:25:30PM +0000, Ralf Thielow via GitGitGadget wrote:

> Fixes the following warnings:
> 
> rebase-interactive.c: In function ‘edit_todo_list’:
> rebase-interactive.c:137:38: warning: zero-length gnu_printf format string [-Wformat-zero-length]
>     write_file(rebase_path_dropped(), "");
> rebase-interactive.c:144:37: warning: zero-length gnu_printf format string [-Wformat-zero-length]
>    write_file(rebase_path_dropped(), "");

Thanks, I think this is worth doing.

I had noticed them, too, but then they "went away" so I assumed they had
already been fixed. It turns out that it's the difference between a
build with and without the DEVELOPER Makefile knob set.

I think we should do this on top:

-- >8 --
Subject: [PATCH] config.mak.dev: re-enable -Wformat-zero-length

We recently triggered some -Wformat-zero-length warnings in the code,
but no developers noticed because we suppress that warning in builds
with the DEVELOPER=1 Makefile knob set. But we _don't_ suppress them in
a non-developer build (and they're part of -Wall). So even though
non-developers probably aren't using -Werror, they see the annoying
warnings when they build.

We've had back and forth discussion over the years on whether this
warning is useful or not. In most cases we've seen, it's not true that
the call is a mistake, since we're using its side effects (like adding a
newline status_printf_ln()) or writing an empty string to a destination
which is handled by the function (as in write_file()). And so we end up
working around it in the source by passing ("%s", "").

There's more discussion in the subthread starting at:

  https://lore.kernel.org/git/xmqqtwaod7ly.fsf@gitster.mtv.corp.google.com/

The short of it is that we probably can't just disable the warning for
everybody because of portability issues. And ignoring it for developers
puts us in the situation we're in now, where non-dev builds are annoyed.

Since the workaround is both rarely needed and fairly straight-forward,
let's just commit to doing it as necessary, and re-enable the warning.

Signed-off-by: Jeff King <peff@peff.net>
---
I had totally forgotten about that thread until researching the history
just now. There's another option there involving #pragma, but it was too
gross for me to even suggest now as an alternative in the commit
message. ;) I think this is the most practical improvement.

 config.mak.dev | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.dev b/config.mak.dev
index bf1f3fcdee..89b218d11a 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -9,7 +9,6 @@ endif
 DEVELOPER_CFLAGS += -Wall
 DEVELOPER_CFLAGS += -Wdeclaration-after-statement
 DEVELOPER_CFLAGS += -Wformat-security
-DEVELOPER_CFLAGS += -Wno-format-zero-length
 DEVELOPER_CFLAGS += -Wold-style-definition
 DEVELOPER_CFLAGS += -Woverflow
 DEVELOPER_CFLAGS += -Wpointer-arith
-- 
2.25.1.911.g022f5304bc

