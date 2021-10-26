Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE63C433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 05:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 661B960EFE
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 05:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhJZF1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 01:27:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:46454 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230501AbhJZF1e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 01:27:34 -0400
Received: (qmail 8114 invoked by uid 109); 26 Oct 2021 05:25:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Oct 2021 05:25:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3245 invoked by uid 111); 26 Oct 2021 05:25:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Oct 2021 01:25:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Oct 2021 01:25:10 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2021, #06; Mon, 25)
Message-ID: <YXeRNkO8B4TP/cau@coredump.intra.peff.net>
References: <xmqq5ytkzbt7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5ytkzbt7.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 25, 2021 at 08:48:04PM -0700, Junio C Hamano wrote:

> * ks/submodule-add-message-fix (2021-10-23) 1 commit
>   (merged to 'next' on 2021-10-25 at 377e759528)
>  + submodule--helper: fix incorrect newlines in an error message
> 
>  Message regression fix.
> 
>  Will merge to 'master'.

This commit has an extra unused parameter in the helper function. I
think we'd want the patch below on top.

-- >8 --
Subject: submodule: drop unused sm_name parameter from append_fetch_remotes()

Commit c21fb4676f (submodule--helper: fix incorrect newlines in an error
message, 2021-10-23) accidentally added a new, unused parameter while
changing the name and signature of show_fetch_remotes() to
append_fetch_remotes(). We can drop this to keep things simpler (and
satisfy -Wunused-parameter).

The error is likely because c21fb4676f is fixing a problem from
8c8195e9c3 (submodule--helper: introduce add-clone subcommand,
2021-07-10). An earlier iteration of that second commit introduced the
same unused parameter (though it was dropped before it finally made it
to 'next'), and the fix on top accidentally carried forward the extra
parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
If this seems familiar, it's because the fixup for the earlier commit
was discussed in July:

  https://lore.kernel.org/git/YPqkHs47VDFBNZ0Z@coredump.intra.peff.net/

 builtin/submodule--helper.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5224283bd1..13a098305b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2776,7 +2776,7 @@ struct add_data {
 };
 #define ADD_DATA_INIT { .depth = -1 }
 
-static void append_fetch_remotes(struct strbuf *msg, const char *sm_name, const char *git_dir_path)
+static void append_fetch_remotes(struct strbuf *msg, const char *git_dir_path)
 {
 	struct child_process cp_remote = CHILD_PROCESS_INIT;
 	struct strbuf sb_remote_out = STRBUF_INIT;
@@ -2831,8 +2831,7 @@ static int add_submodule(const struct add_data *add_data)
 						    "locally with remote(s):\n"),
 					    add_data->sm_name);
 
-				append_fetch_remotes(&msg, add_data->sm_name,
-						     submod_gitdir_path);
+				append_fetch_remotes(&msg, submod_gitdir_path);
 				free(submod_gitdir_path);
 
 				strbuf_addf(&msg, _("If you want to reuse this local git "
-- 
2.33.1.1326.g74374c95d7

