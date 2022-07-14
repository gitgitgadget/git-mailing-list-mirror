Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A855C43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 21:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240982AbiGNVkP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 17:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240942AbiGNVkO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 17:40:14 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD10222BB
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 14:40:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 05F4419723A;
        Thu, 14 Jul 2022 17:40:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6Qx5c3aRoumhAHvayhBtRRPXy2jnKojx7X2Taj
        lg5x8=; b=mtd2NlyQoJ0o72ieIdkFDKssx6saHiUfD0HX0tQzaMlfyE/E4s5Hhy
        BdGn+xUNg1Nct190wJDwMDBvLRdW9wL+ECZ2HHhIGdJe+whpNMdypUj9GyyMqxnv
        42XwPftGQgxX3bC2i6yjZRmsJRT2e2CyT/DnuIzNYwB/o6zFqHqPI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F21CF197239;
        Thu, 14 Jul 2022 17:40:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7CCCD197235;
        Thu, 14 Jul 2022 17:40:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Allow debugging unsafe directories' ownership
References: <pull.1286.git.1657700238.gitgitgadget@gmail.com>
        <3480381b8b99142bcc0213957a43d68a962c52d9.1657700238.git.gitgitgadget@gmail.com>
        <xmqq5yk0dcvk.fsf@gitster.g>
Date:   Thu, 14 Jul 2022 14:40:04 -0700
In-Reply-To: <xmqq5yk0dcvk.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        13 Jul 2022 12:35:43 -0700")
Message-ID: <xmqqy1wv2x1n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 864D47EE-03BD-11ED-9151-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ... I am not sure about this part.  Do we have any other codepath to
> show "to debug, run the program with this" suggestion?  Adding it in
> the documentation is probably good, but this is an extra message
> that is much larger than the "owned by X but you are Y" message that
> would be shown.  With or without the environment set, the output
> will become noisier with this patch.  I wonder if we are better off
> giving the information that is given in the warning (in compat/ part
> of the patch) _unconditionally_ in the message, which would make it
> less noisy overall.

I am wondering if passing a struct to allow is_path_owned_by*()
helper(s) to report the detail of the failures they discover a
cleaner way to do this.  To illustrate what I meant, along the
lines of the following patch, with any additional code to actually
stuff messages in the strbuf report, in the is_path_owned_by*() 
implementation.

I am perfectly OK if we make it a debug-only option by hiding this
behind an environment variable, but if we were to do so, I do not
want to see us advertize the environment variable in the die()
message (a debug-only option can be documented, but not worth
surfacing in and contaminating the usual UI output).

Comments?

 compat/mingw.c    |  2 +-
 git-compat-util.h |  3 ++-
 setup.c           | 12 +++++++++---
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git c/compat/mingw.c w/compat/mingw.c
index 2607de93af..f12b7df16d 100644
--- c/compat/mingw.c
+++ w/compat/mingw.c
@@ -2673,7 +2673,7 @@ static PSID get_current_user_sid(void)
 	return result;
 }
 
-int is_path_owned_by_current_sid(const char *path)
+int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
 {
 	WCHAR wpath[MAX_PATH];
 	PSID sid = NULL;
diff --git c/git-compat-util.h w/git-compat-util.h
index 58d7708296..de34b0ea7e 100644
--- c/git-compat-util.h
+++ w/git-compat-util.h
@@ -487,7 +487,8 @@ static inline void extract_id_from_env(const char *env, uid_t *id)
 	}
 }
 
-static inline int is_path_owned_by_current_uid(const char *path)
+struct strbuf;
+static inline int is_path_owned_by_current_uid(const char *path, struct strbuf *report)
 {
 	struct stat st;
 	uid_t euid;
diff --git c/setup.c w/setup.c
index 09b6549ba9..ed823585f7 100644
--- c/setup.c
+++ w/setup.c
@@ -1143,12 +1143,18 @@ static int ensure_valid_ownership(const char *gitfile,
 	struct safe_directory_data data = {
 		.path = worktree ? worktree : gitdir
 	};
+	struct strbuf report = STRBUF_INIT;
 
 	if (!git_env_bool("GIT_TEST_ASSUME_DIFFERENT_OWNER", 0) &&
-	   (!gitfile || is_path_owned_by_current_user(gitfile)) &&
-	   (!worktree || is_path_owned_by_current_user(worktree)) &&
-	   (!gitdir || is_path_owned_by_current_user(gitdir)))
+	    (!gitfile || is_path_owned_by_current_user(gitfile, &report)) &&
+	    (!worktree || is_path_owned_by_current_user(worktree, &report)) &&
+	    (!gitdir || is_path_owned_by_current_user(gitdir, &report))) {
+		if (report.len) {
+			fputs(report.buf, stderr);
+			strbuf_release(&report);
+		}
 		return 1;
+	}
 
 	/*
 	 * data.path is the "path" that identifies the repository and it is
