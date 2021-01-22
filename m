Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77C8C433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 21:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9399623B42
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 21:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbhAVVE6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 16:04:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:35748 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731038AbhAVVEd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 16:04:33 -0500
Received: (qmail 13960 invoked by uid 109); 22 Jan 2021 21:03:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 Jan 2021 21:03:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18643 invoked by uid 111); 22 Jan 2021 21:03:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Jan 2021 16:03:34 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 22 Jan 2021 16:03:33 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: [PATCH] run-command: document use_shell option
Message-ID: <YAs9pTBsdskC8CPN@coredump.intra.peff.net>
References: <20210122142137.21161-1-jacob@gitlab.com>
 <20210122142137.21161-2-jacob@gitlab.com>
 <YAs2RMT1rEH/2LSp@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAs2RMT1rEH/2LSp@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 22, 2021 at 03:32:04PM -0500, Jeff King wrote:

> Yeah, that is exactly right. "use_shell" just means that the command is
> (possibly) run with a shell. Quoting for any extra arguments is handled
> automatically.
> 
> I think you're correct that this was broken from the start in 10ac85c785
> (upload-pack: add object filtering for partial clone, 2017-12-08).
> That's even before the use_shell was added, and then later it was pushed
> into that conditional by 0b6069fe0a (fetch-pack: test support excluding
> large blobs, 2017-12-08). Presumably because the non-hook path would not
> have worked at all, and that was the first time any of it was actually
> tested. ;)
> 
> (I've cc'd authors of those commits as an FYI; I think both were
> relatively new to the project at the time so misunderstanding this
> subtlety of run-command is not too surprising).

While we're thinking about it, let's beef up the documentation a bit.

-- >8 --
Subject: [PATCH] run-command: document use_shell option

It's unclear how run-command's use_shell option should impact the
arguments fed to a command. Plausibly it could mean that we glue all of
the arguments together into a string to pass to the shell, in which case
that opens the question of whether the caller needs to quote them.

But in fact we don't implement it that way (and even if we did, we'd
probably auto-quote the arguments as part of the glue step). And we must
not receive quoted arguments, because we might actually optimize out the
shell entirely (i.e., the caller does not even know if a shell will be
involved in the end or not).

Since this ambiguity may have been the cause of a recent bug, let's
document the option a bit.

Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/run-command.h b/run-command.h
index 6472b38bde..d08414a92e 100644
--- a/run-command.h
+++ b/run-command.h
@@ -126,8 +126,15 @@ struct child_process {
 	 */
 	unsigned silent_exec_failure:1;
 
-	unsigned stdout_to_stderr:1;
+	/**
+	 * Run the command from argv[0] using a shell (but note that we may
+	 * still optimize out the shell call if the command contains no
+	 * metacharacters). Note that further arguments to the command in
+	 * argv[1], etc, do not need to be shell-quoted.
+	 */
 	unsigned use_shell:1;
+
+	unsigned stdout_to_stderr:1;
 	unsigned clean_on_exit:1;
 	unsigned wait_after_clean:1;
 	void (*clean_on_exit_handler)(struct child_process *process);
-- 
2.30.0.664.g35e6628185

