Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3516C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 18:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA72760F01
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 18:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhG0SWb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 14:22:31 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64496 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhG0SW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 14:22:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 347F91405E6;
        Tue, 27 Jul 2021 14:22:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sntBhtxzMKhNSbE9NGmJZAoCL++q013jx6H6lE
        HUeyw=; b=aLyIIXITms3dRLbLSubrgF9GB4r57EfHlrW79HjQYS1jf/u2/InJkz
        hKYxOqqpNnd/+texHfZrTThfQMGzwrIvyZjERoK9+jCUTtZyfrKUlyM5Vet62j3c
        8ixar+FZVWWmcWCiXJrbYcl/U7KGgsHeuLdDugtTgfkmT6AcZjZmw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D6F71405E5;
        Tue, 27 Jul 2021 14:22:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6D2551405E4;
        Tue, 27 Jul 2021 14:22:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     "Oded S via GitGitGadget" <gitgitgadget@gmail.com>,
        Oded S <oded@istraresearch.com>
Subject: Re: [PATCH] Fix git-bisect when show-branch is configured to run
 with pager
References: <pull.1003.git.1627311659384.gitgitgadget@gmail.com>
        <xmqq4kcgkjhk.fsf@gitster.g>
Date:   Tue, 27 Jul 2021 11:22:18 -0700
In-Reply-To: <xmqq4kcgkjhk.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        26 Jul 2021 11:39:19 -0700")
Message-ID: <xmqq7dhbehwl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94C40DF6-EF07-11EB-A597-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Also, in the longer term, I suspect that we probably should stop
> calling show-branch from this codepath and here is why.

I wonder if it is just a simple matter of a few lines of code, like
this?

---- >8 ------- >8 ------- >8 ------- >8 ------- >8 ----
Subject: [PATCH] bisect: do not run show-branch just to show the current  commit

In scripted versions of "git bisect", we used "git show-branch" to
describe single commit in the bisect log and also to the interactive
user after checking out the next version to be tested.  

The former use of "git show-branch" was lost when the helper
function that wrote bisect log entries was rewritten at 0f30233a
(bisect--helper: `bisect_write` shell function in C, 2019-01-02) in
C

But we've kept the latter ever since 0871984d (bisect: make "git
bisect" use new "--next-all" bisect-helper function, 2009-05-09)
started using the faithful C-rewrite introduced at ef24c7ca
(bisect--helper: add "--next-exit" to output bisect results,
2009-04-19).

Showing "[<full hex>] <subject>" is simple enough with our helper
pretty.c::format_commit_message() and spawning show-branch is an
overkill.  Let's lose one external process.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 bisect.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/bisect.c b/bisect.c
index af2863d044..2b8b6546e9 100644
--- a/bisect.c
+++ b/bisect.c
@@ -23,7 +23,6 @@ static struct oid_array skipped_revs;
 static struct object_id *current_bad_oid;
 
 static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
-static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
 
 static const char *term_bad;
 static const char *term_good;
@@ -729,6 +728,9 @@ static enum bisect_error bisect_checkout(const struct object_id *bisect_rev, int
 {
 	char bisect_rev_hex[GIT_MAX_HEXSZ + 1];
 	enum bisect_error res = BISECT_OK;
+	struct commit *commit;
+	struct pretty_print_context pp = {0};
+	struct strbuf commit_msg = STRBUF_INIT;
 
 	oid_to_hex_r(bisect_rev_hex, bisect_rev);
 	update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
@@ -748,13 +750,11 @@ static enum bisect_error bisect_checkout(const struct object_id *bisect_rev, int
 			return -abs(res);
 	}
 
-	argv_show_branch[1] = bisect_rev_hex;
-	res = run_command_v_opt(argv_show_branch, RUN_GIT_CMD);
-	/*
-	 * Errors in `run_command()` itself, signaled by res < 0,
-	 * and errors in the child process, signaled by res > 0
-	 * can both be treated as regular BISECT_FAILURE (-1).
-	 */
+	commit = lookup_commit_reference(the_repository, bisect_rev);
+	format_commit_message(commit, "[%H] %s%n", &commit_msg, &pp);
+	fputs(commit_msg.buf, stdout);
+	strbuf_release(&commit_msg);
+
 	return -abs(res);
 }
 
-- 
2.32.0-555-g350b5add0b

