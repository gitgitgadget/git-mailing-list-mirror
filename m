Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F2EC433E6
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D8EA64F51
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhBCVA6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 16:00:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:46560 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232096AbhBCVAm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 16:00:42 -0500
Received: (qmail 21612 invoked by uid 109); 3 Feb 2021 20:59:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Feb 2021 20:59:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4589 invoked by uid 111); 3 Feb 2021 20:59:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Feb 2021 15:59:59 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 3 Feb 2021 15:59:58 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Paul Jolly <paul@myitcv.io>,
        git@vger.kernel.org
Subject: [PATCH] completion: handle other variants of "branch -m"
Message-ID: <YBsOzixRy0ahWaLN@coredump.intra.peff.net>
References: <CACoUkn6+9C3+HVVQF905t1siAD9Sqo1JvRa0Whw-J6x7V7icyg@mail.gmail.com>
 <YBkVFTOP6K1//i6m@coredump.intra.peff.net>
 <YBkZnY8X5VyNkXkR@coredump.intra.peff.net>
 <xmqqpn1igznk.fsf@gitster.c.googlers.com>
 <20210203200047.GB1036595@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210203200047.GB1036595@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 03, 2021 at 09:00:47PM +0100, SZEDER Gábor wrote:

> On Tue, Feb 02, 2021 at 09:14:39AM -0800, Junio C Hamano wrote:
> > From: Jeff King <peff@peff.net>
> > Date: Tue Feb 2 04:02:13 2021 -0500
> > Subject: [PATCH] completion: treat "branch -D" the same way as "branch -d"
> > 
> > Paul Jolly noticed that the former offers not just branches but tags
> > as completion candidates.  Mimic how "branch -d" limits its suggestion
> > to branch names.
> 
> Uh-oh.  This is a bug from my second ever commit in Git! ;)
> 
> '-M' should be handled the same.

Oh, indeed. Maybe this?

-- >8 --
Subject: [PATCH] completion: handle other variants of "branch -m"

We didn't special-case "branch -M" (with a capital M) the same as
"branch -m", nor any of the "--copy" variants. As a result these offered
any ref as the next candidate, and not just branch names.

Note that I rewrapped case-arm line since it's now quite long, and
likewise the one below it for consistency. I also re-ordered the
existing "-D" to make it more obvious how the cases group together.

Signed-off-by: Jeff King <peff@peff.net>
---
We could also squash the whole thing together with the earlier "-D" as a
single fix, but it's all trivial enough that I'm not sure it's worth
spending a lot of time polishing.

 contrib/completion/git-completion.bash | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ba950a247d..567e73837a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1438,8 +1438,10 @@ _git_branch ()
 	while [ $c -lt $cword ]; do
 		i="${words[c]}"
 		case "$i" in
-		-d|--delete|-D|-m|--move)	only_local_ref="y" ;;
-		-r|--remotes)		has_r="y" ;;
+		-d|-D|--delete|-m|-M|--move|-c|-C|--copy)
+			only_local_ref="y" ;;
+		-r|--remotes)
+			has_r="y" ;;
 		esac
 		((c++))
 	done
-- 
2.30.0.882.gf229bd7cc9

