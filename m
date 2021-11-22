Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88B7C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 23:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhKVXL7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 18:11:59 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64651 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbhKVXL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 18:11:56 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 233661560CD;
        Mon, 22 Nov 2021 18:08:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a+XMe73abUA9OZmMtkUJ/rq+eFzPkN7MQq/XOv
        IZ/Xg=; b=cf7nwFpw7tZHB1LlvUy5CjkJ3Cmnlz79VUo3WPX/4gMyQTP1KPfPj7
        zhg7AC0UzINe1+rw/I0UV22HoBsWwR36TJP8KMeJBGt9KgfZW4Nv+8wxNT0HRJMA
        V8lRU57NHreLtL7QGKj12W546luJIYK1/bhWgNjenRZUT1wG4Z71k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1B3A41560CC;
        Mon, 22 Nov 2021 18:08:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7D8DF1560CB;
        Mon, 22 Nov 2021 18:08:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        thomas.wolf@paranor.ch, Alexander Veit <alexander.veit@gmx.net>
Subject: Re: [PATCH] editor: only save (and restore) the terminal if using a
 tty
References: <04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com>
        <20211122222850.674-1-carenas@gmail.com> <xmqqa6hvbxob.fsf@gitster.g>
Date:   Mon, 22 Nov 2021 15:08:45 -0800
In-Reply-To: <xmqqa6hvbxob.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        22 Nov 2021 15:03:32 -0800")
Message-ID: <xmqq5ysjbxfm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25348C6A-4BE9-11EC-BA95-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> In any case, I am quite tempted to just revert the offending topic
> for now, but later accept a resurrection patch with this isatty
> check rolled in (either at this caller, or inside save_term) when
> the dust settles.

So, here is that first step, to be hopefully mergeable to 'master'
and also to 'maint' for 2.34.1

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] Revert "editor: save and reset terminal after calling EDITOR"

This reverts commit 3d411afabc9a96f41d47c07d6af6edda3d29ec92,
blindly opening /dev/tty and calling tcsetattr() seems to be causing
problems.

cf. https://bugs.eclipse.org/bugs/show_bug.cgi?id=577358
cf. https://lore.kernel.org/git/04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com/

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 editor.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/editor.c b/editor.c
index be7441e7e0..6303ae0ab0 100644
--- a/editor.c
+++ b/editor.c
@@ -3,7 +3,6 @@
 #include "strbuf.h"
 #include "run-command.h"
 #include "sigchain.h"
-#include "compat/terminal.h"
 
 #ifndef DEFAULT_EDITOR
 #define DEFAULT_EDITOR "vi"
@@ -51,8 +50,6 @@ const char *git_sequence_editor(void)
 static int launch_specified_editor(const char *editor, const char *path,
 				   struct strbuf *buffer, const char *const *env)
 {
-	int term_fail;
-
 	if (!editor)
 		return error("Terminal is dumb, but EDITOR unset");
 
@@ -86,10 +83,7 @@ static int launch_specified_editor(const char *editor, const char *path,
 		p.env = env;
 		p.use_shell = 1;
 		p.trace2_child_class = "editor";
-		term_fail = save_term(1);
 		if (start_command(&p) < 0) {
-			if (!term_fail)
-				restore_term();
 			strbuf_release(&realpath);
 			return error("unable to start editor '%s'", editor);
 		}
@@ -97,8 +91,6 @@ static int launch_specified_editor(const char *editor, const char *path,
 		sigchain_push(SIGINT, SIG_IGN);
 		sigchain_push(SIGQUIT, SIG_IGN);
 		ret = finish_command(&p);
-		if (!term_fail)
-			restore_term();
 		strbuf_release(&realpath);
 		sig = ret - 128;
 		sigchain_pop(SIGINT);
-- 
2.34.0-222-gceadac38b1

