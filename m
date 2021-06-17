Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406BAC48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 02:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1291A613B9
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 02:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhFQCWc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 22:22:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62347 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhFQCWb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 22:22:31 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93013D88B0;
        Wed, 16 Jun 2021 22:20:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xNqZSQxLjYrINpcooychYLh46tB+2ebgydBL+G
        pG/cE=; b=qFR7zs34g+ZmvEmhLfj5pQKt6AzjgIzw4wbP/NYg05Kb1eLdUZh7Ls
        Eo7oGXPFT6n7d2aC/wAuoSQLDFkVumj8D1OXdephhm36GPbxPrGXRcHLnbaWOUfN
        yj9fiW/zJMeGHZlRs221JeOYYaphLAO1MZ1X64YdkHfikWQyeTA0s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7810FD88AE;
        Wed, 16 Jun 2021 22:20:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AD4C8D88AD;
        Wed, 16 Jun 2021 22:20:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] pager: do not unnecessarily set COLUMNS on Windows
References: <pull.982.git.1623701952823.gitgitgadget@gmail.com>
        <pull.982.v2.git.1623847092299.gitgitgadget@gmail.com>
Date:   Thu, 17 Jun 2021 11:20:22 +0900
In-Reply-To: <pull.982.v2.git.1623847092299.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 16 Jun 2021 12:38:11
        +0000")
Message-ID: <xmqqv96dmduh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9262ACDA-CF12-11EB-9F3B-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Since https://github.com/gwsw/less/commit/bb0ee4e76c2, `less` prefers
> the `COLUMNS` variable over asking ncurses itself.
>
> This is typically not a problem because we ask `TIOCGWINSZ` in Git, to
> determine the correct value for `COLUMNS`, and then set that environment
> variable.
>
> However, on Windows it _is_ a problem. The reason is that Git for
> Windows uses a version of `less` that relies on the MSYS2 runtime to
> interact with the pseudo terminal (typically inside a MinTTY window,
> which is also aware of the MSYS2 runtime). Both MinTTY and `less.exe`
> interact with that pseudo terminal via `ioctl()` calls (which the MSYS2
> runtime emulates even if there is no such thing on Windows).
>
> But `git.exe` itself is _not_ aware of the MSYS2 runtime, or for that
> matter of that pseudo terminal, and has no way to call `ioctl()` or
> `TIOCGWINSZ`.
>
> Therefore, `git.exe` will fall back to hard-coding 80 columns, no matter
> what the actual terminal size is.
>
> But `less.exe` is totally able to interact with the MSYS2 runtime and
> would not actually require Git's help (which actually makes things
> worse here). So let's not override `COLUMNS` on Windows.
>
> Note: we do this _only_ on Windows, and _only_ if `TIOCGWINSZ` is not
> defined, to reduce any potential undesired fall-out from this patch.
>
> This fixes https://github.com/git-for-windows/git/issues/3235
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     pager: do not unnecessarily set COLUMNS on Windows
>     
>     A recent upgrade of the "less" package in Git for Windows causes
>     problems. Here is a work-around.
>     
>     Changes since v1:
>     
>      * The commit message was reworded to clarify the underlying issue
>        better.

Thanks for an updated log message to clarify the problem
description.

I think treating this as "less" specific band-aid is OK, but I do
not think tying this to Windows is a good design choice.

The guiding principle for this change is more like "if we do not
know and cannot learn the true value, internally assuming 80-columns
as a last resort fallback may be OK, but do not export it for
consumption for other people---they cannot tell if COLUMNS=80 they
see us export is because we actually measured the terminal width and
know it to be 80, or we just punted and used a fallback default", I
think, and there is nothing Windows-specific in there, no?

In other words, if we use something like the attached as a "less
specific band-aid" for now (i.e. direct replacement of your patch to
fix the specific 'less' problem), and then later clean it up by
actually returning -1 (or -80) from term_columns() as "we do not
know" (or "we do not know---use the negation of this value as
default"), we can help not just this paticular caller you touched,
but all other callers of term_columns(), to make a more intelligent
decision in the future if they wanted to.  The root of the issue I
think is because term_columns() does not give callers to tell if its
returned value is merely a guess.

 pager.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git c/pager.c w/pager.c
index 3d37dd7ada..52f27a6765 100644
--- c/pager.c
+++ w/pager.c
@@ -11,6 +11,10 @@
 static struct child_process pager_process = CHILD_PROCESS_INIT;
 static const char *pager_program;
 
+/* Is the value coming back from term_columns() just a guess? */
+static int term_columns_guessed;
+
+
 static void close_pager_fds(void)
 {
 	/* signal EOF to pager */
@@ -114,7 +118,8 @@ void setup_pager(void)
 	{
 		char buf[64];
 		xsnprintf(buf, sizeof(buf), "%d", term_columns());
-		setenv("COLUMNS", buf, 0);
+		if (!term_columns_guessed)
+			setenv("COLUMNS", buf, 0);
 	}
 
 	setenv("GIT_PAGER_IN_USE", "true", 1);
@@ -158,15 +163,20 @@ int term_columns(void)
 		return term_columns_at_startup;
 
 	term_columns_at_startup = 80;
+	term_columns_guessed = 1;
 
 	col_string = getenv("COLUMNS");
-	if (col_string && (n_cols = atoi(col_string)) > 0)
+	if (col_string && (n_cols = atoi(col_string)) > 0) {
 		term_columns_at_startup = n_cols;
+		term_columns_guessed = 0;
+	}
 #ifdef TIOCGWINSZ
 	else {
 		struct winsize ws;
-		if (!ioctl(1, TIOCGWINSZ, &ws) && ws.ws_col)
+		if (!ioctl(1, TIOCGWINSZ, &ws) && ws.ws_col) {
 			term_columns_at_startup = ws.ws_col;
+			term_columns_guessed = 0;
+		}
 	}
 #endif
 
