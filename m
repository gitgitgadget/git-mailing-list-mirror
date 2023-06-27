Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6015BEB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 07:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjF0HGB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 03:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF0HGA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 03:06:00 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E819C198C
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 00:05:58 -0700 (PDT)
Received: (qmail 28827 invoked by uid 109); 27 Jun 2023 07:05:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Jun 2023 07:05:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14485 invoked by uid 111); 27 Jun 2023 07:06:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Jun 2023 03:06:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Jun 2023 03:05:57 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 6/7] var: add attributes files locations
Message-ID: <20230627070557.GB1226768@coredump.intra.peff.net>
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
 <20230626190008.644769-1-sandals@crustytoothpaste.net>
 <20230626190008.644769-7-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230626190008.644769-7-sandals@crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 26, 2023 at 07:00:07PM +0000, brian m. carlson wrote:

> @@ -51,6 +52,26 @@ static char *shell_path(int flag)
>  	return xstrdup(SHELL_PATH);
>  }
>  
> +static char *git_attr_val_system(int flag)
> +{
> +	if (git_attr_system_is_enabled()) {
> +		char *file = xstrdup(git_attr_system_file());
> +		normalize_path_copy(file, file);
> +		return file;
> +	}
> +	return NULL;
> +}

These new ones would ideally mark the "flag" variable with the UNUSED
attribute (in preparation for building with -Wunused-parameter).

I can also come through later and fix them up in a separate patch. It's
slightly awkward, just because I was about to post a patch that fixed
the existing functions in that file, and I'd have to either rebase on
top, or make a second pass once this is merged.

That said, I also renamed the "flag" variable in my patch because it's
super confusing (see my patch below for reference). So adjusting your
new callers to match (without my changes) would be a little weird. The
least-weird thing would be sticking my patch at the front of your
series, but I don't want to make you do extra work.

So I dunno. I'm mostly giving a heads-up, and seeing if you (or other
reviewers in the thread) have an idea to make this "flag" thing less
awful. I'm also happy to just do my topic separately, and then
eventually circle back after yours is merged.

-- >8 --
Subject: [PATCH] var: mark unused parameters in git_var callbacks

We abstract the set of variables into a table, with a "read" callback to
provide the value of each. Each callback takes a "flag" argument, but
most callbacks don't make use of it.

This flag is a bit odd. It may be set to IDENT_STRICT, which make sense
for ident-based callbacks, but is just confusing for things like
GIT_EDITOR.

At first glance, it seems like this is just a hack to let us directly
stick the generic git_committer_info() and git_author_info() functions
into our table. And we'd be better off to wrap them with local functions
which pass IDENT_STRICT, and have our callbacks take no option at all.

But that doesn't quite work. We pass IDENT_STRICT when the caller asks
for a specific variable, but otherwise do not (so that "git var -l" does
not bail if the committer ident cannot be formed).

So we really do need to pass in the flag to each invocation, even if the
individual callback doesn't care about it. Let's mark the unused ones so
that -Wunused-parameter does not complain. And while we're here, let's
rename them so that it's clear that the flag values we get will be from
the IDENT_* set. That may prevent confusion for future readers of the
code.

Another option would be to define our own local "strict" flag for the
callbacks, and then have wrappers that translate that to IDENT_STRICT
where it matters. But that would be more boilerplate for little gain
(most functions would still ignore the "strict" flag anyway).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/var.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/var.c b/builtin/var.c
index 2149998980..10ee62f84c 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -12,17 +12,17 @@
 
 static const char var_usage[] = "git var (-l | <variable>)";
 
-static const char *editor(int flag)
+static const char *editor(int ident_flag UNUSED)
 {
 	return git_editor();
 }
 
-static const char *sequence_editor(int flag)
+static const char *sequence_editor(int ident_flag UNUSED)
 {
 	return git_sequence_editor();
 }
 
-static const char *pager(int flag)
+static const char *pager(int ident_flag UNUSED)
 {
 	const char *pgm = git_pager(1);
 
@@ -31,7 +31,7 @@ static const char *pager(int flag)
 	return pgm;
 }
 
-static const char *default_branch(int flag)
+static const char *default_branch(int ident_flag UNUSED)
 {
 	return git_default_branch_name(1);
 }
-- 
2.41.0.490.g2678ffb796

