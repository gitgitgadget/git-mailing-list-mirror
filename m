Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20386C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 00:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJKAmm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 20:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJKAml (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 20:42:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B884804B7
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:42:40 -0700 (PDT)
Received: (qmail 29818 invoked by uid 109); 11 Oct 2022 00:42:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Oct 2022 00:42:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15717 invoked by uid 111); 11 Oct 2022 00:42:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Oct 2022 20:42:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Oct 2022 20:42:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric DeCosta <edecosta@mathworks.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2022, #03; Mon, 10)
Message-ID: <Y0S7/jA5tNeoQ2Hm@coredump.intra.peff.net>
References: <xmqqlepnz1vu.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlepnz1vu.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 04:37:25PM -0700, Junio C Hamano wrote:

> * ed/fsmonitor-on-networked-macos (2022-10-05) 6 commits
>   (merged to 'next' on 2022-10-07 at fe9f182bde)
>  + fsmonitor: add documentation for allowRemote and socketDir options
>  + fsmonitor: check for compatability before communicating with fsmonitor
>  + fsmonitor: deal with synthetic firmlinks on macOS
>  + fsmonitor: avoid socket location check if using hook
>  + fsmonitor: relocate socket file if .git directory is remote
>  + fsmonitor: refactor filesystem checks to common interface
>  (this branch is used by ed/fsmonitor-inotify.)
> 
>  By default, use of fsmonitor on a repository on networked
>  filesystem is disabled. Add knobs to make it workable on macOS.
> 
>  Will merge to 'master'.
>  source: <pull.1326.v15.git.1664904751.gitgitgadget@gmail.com>

There's a tiny leak in this one. Here's a fix that can go on top.

-- >8 --
Subject: [PATCH] fsmonitor: fix leak of warning message

The fsm_settings__get_incompatible_msg() function returns an allocated
string.  So we can't pass its result directly to warning(); we must hold
on to the pointer and free it to avoid a leak.

The leak here is small and fixed size, but Coverity complained, and
presumably SANITIZE=leaks would eventually.

Signed-off-by: Jeff King <peff@peff.net>
---
 fsmonitor.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 540736b39f..08af00c738 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -309,8 +309,10 @@ void refresh_fsmonitor(struct index_state *istate)
 	enum fsmonitor_reason reason = fsm_settings__get_reason(r);
 
 	if (!warn_once && reason > FSMONITOR_REASON_OK) {
+		char *msg = fsm_settings__get_incompatible_msg(r, reason);
 		warn_once = 1;
-		warning("%s", fsm_settings__get_incompatible_msg(r, reason));
+		warning("%s", msg);
+		free(msg);
 	}
 
 	if (fsm_mode <= FSMONITOR_MODE_DISABLED ||
-- 
2.38.0.705.gfa933d7c31

