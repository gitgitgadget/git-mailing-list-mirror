Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37203C636CC
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 16:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjBHQof (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 11:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjBHQo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 11:44:26 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B151835A0
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 08:44:11 -0800 (PST)
Received: (qmail 25203 invoked by uid 109); 8 Feb 2023 16:43:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Feb 2023 16:43:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 746 invoked by uid 111); 8 Feb 2023 16:43:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Feb 2023 11:43:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Feb 2023 11:43:57 -0500
From:   Jeff King <peff@peff.net>
To:     Max Gautier <max.gautier@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: git rev-list fails to verify ssh-signed commits (but git log
 works)
Message-ID: <Y+PRTYtFDoE73XEM@coredump.intra.peff.net>
References: <Y+PGRaiTTaZ/DtlJ@work-laptop-max>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+PGRaiTTaZ/DtlJ@work-laptop-max>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 08, 2023 at 04:56:53PM +0100, Max Gautier wrote:

> I was trying to implement a pre-push hook to verify my commits are
> properly signed before pushing them, and stumbled upon the following
> output (which looks like a bug to me):
> 
> $ git rev-list @{u}..HEAD --format='%G? %H'
> commit 9497d347b048dbea7f527624f815f7926594c4bc
> error: gpg.ssh.allowedSignersFile needs to be configured and exist for ssh signature verification
>
> [...]
>
> While git log works and is able to retrieve the signatures

Yeah, I think this is a bug. The issue is that not every command loads
the config callback for every config option. This is how we
traditionally implemented the split between porcelain and plumbing
(e.g., user-facing "git diff" will parse and respect "color.diff", but
the scriptable "git diff-files" would not).

In this case, the gpg config has been pushed to its own handler, and a
few specific commands (like git-log) call it. I don't know if there is a
good reason to avoid loading the config in plumbing, or if it was simply
cargo-culted.

I didn't test, but I suspect the patch below would fix your problem:

diff --git a/config.c b/config.c
index 00090a32fc..7ac9f1f5bc 100644
--- a/config.c
+++ b/config.c
@@ -1881,6 +1881,14 @@ int git_default_config(const char *var, const char *value, void *cb)
 	if (starts_with(var, "core."))
 		return git_default_core_config(var, value, cb);
 
+	/*
+	 * yikes, this needs to come early in the function because it
+	 * also handles user.signingkey, which would otherwise get
+	 * shunted to git_ident_config() below
+	 */
+	if (git_gpg_config(var, value, cb) < 0)
+		return -1;
+
 	if (starts_with(var, "user.") ||
 	    starts_with(var, "author.") ||
 	    starts_with(var, "committer."))

but it would need a bit more work:

  1. Somebody would need to dig into the reasons, if any, for not
     calling git_gpg_config() everywhere. It might be fine, but there
     may be a good reason which we're now violating. Digging in the
     history and looking at the code might yield some hints.

  2. The individual calls to git_gpg_config() in other programs should
     go away.

  3. It's possible some refactoring may let us avoid the "yikes" comment
     above (e.g., should user.signingkey just go into the normal ident
     config handler?).

-Peff
