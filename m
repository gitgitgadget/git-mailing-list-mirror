Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C548CC433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 21:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A48206C0
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 21:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YHfvTGjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgICVAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:00:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64597 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgICVAP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 17:00:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5ADE57540C;
        Thu,  3 Sep 2020 17:00:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E3pUj0lh2YGDDMGcy0JtZhCSNu0=; b=YHfvTG
        jmyZefaIg0NOjFpF60hWNaIlcAsm9MSx5bUw8TIcUvSD4em/EtFVdTndgOjIdwfQ
        Ro8FJjMmbDzxykGLbR+dsDQs/1ikYRwLbCcDKAeu17S0JU7wqRsa6sa2QObU8xlA
        TrSOoO1/2yjsinrm/wA3UQ26A376nFhpE0JWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vLqXa0RDSOJVIoGSd3aGZvxdhGA3LqU5
        vlaUIHPy+CGdYo+qP6hmMoAH73aju1TukUEUNkGi2bj0njOt3gtXEsSbemCYvcc2
        3OjD3kP55RkEpJMDlJfAloEFtTb/LAtx393fnb3iLSpWf9h0w590s44/ozVk0Pg4
        ViWcTKXaB8w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ECDC67540B;
        Thu,  3 Sep 2020 17:00:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9641C75403;
        Thu,  3 Sep 2020 17:00:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v3] fetch: no FETCH_HEAD display if --no-write-fetch-head
References: <xmqqo8mnaa6k.fsf@gitster.c.googlers.com>
        <20200903194148.2738968-1-jonathantanmy@google.com>
Date:   Thu, 03 Sep 2020 14:00:05 -0700
In-Reply-To: <20200903194148.2738968-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 3 Sep 2020 12:41:48 -0700")
Message-ID: <xmqqy2lq8tka.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71FDE75A-EE28-11EA-8DBB-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> OK - updated the code, added a test for the "--dry-run
> --no-write-fetch-head" case, and updated commit message and code
> comment.

Unfortunately our actions crossed X-< and the previous one that was
good enough is already in 'master', together with the lazy fetch
topic.

Let's turn this into an incremental fix only for "Ouch, we still say
FETCH_HEAD when both --dry-run and --no-write-fetch-head are given"
bug.

Thanks.

-- >8 --
Subject: [PATCH] fetch: fix --dry-run --no-write-fetch-head interaction
From: Jonathan Tan <jonathantanmy@google.com>

Recently we introduced "--[no-]-write-fetch-head" option to tell
"git fetch" not to write FETCH_HEAD file.  The command reported that
FETCH_HEAD file is written, even with the "--no-write-fetch-head"
option.

db3c293e (fetch: no FETCH_HEAD display if --no-write-fetch-head,
2020-09-02) tried to squelch this, but the fix was not sufficient.
Because we never write the FETCH_HEAD file when "--dry-run" is
given, the addition of "--[no-]write-fetch-head" option was made by
directly fliping the internal variable 'write_fetch_head' (which
defaults to 'on') to 'off' upon seeing "--dry-run", which allowed
the condition to decide if we write FETCH_HEAD to be a simple
reference to the variable.  But now, we need to tell if the user
explicitly asked "--no-write-fetch-head" with "--dry-run" to
decide when to show the report about FETCH_HEAD correctly.

Introduce an extra 'user_specified_write_fetch_head' variable, which
is 'on' by default and is turned 'off' with '--no-write-fetch-head'.
The 'write_fetch_head' variable that decides if we actually write
FETCH_HEAD remains there, retaining its meaning, but use this new
variable and 'dry_run' to decide if we report about FETCH_HEAD.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---

 builtin/fetch.c  | 21 ++++++++++++++-------
 t/t5510-fetch.sh |  7 +++++++
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git c/builtin/fetch.c w/builtin/fetch.c
index c6c4689250..9addd1f2d4 100644
--- c/builtin/fetch.c
+++ w/builtin/fetch.c
@@ -56,6 +56,7 @@ static int prune_tags = -1; /* unspecified */
 #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
 
 static int all, append, dry_run, force, keep, multiple, update_head_ok;
+static int user_specified_write_fetch_head = 1;
 static int write_fetch_head = 1;
 static int verbosity, deepen_relative, set_upstream;
 static int progress = -1;
@@ -164,7 +165,7 @@ static struct option builtin_fetch_options[] = {
 		    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
 	OPT_BOOL(0, "dry-run", &dry_run,
 		 N_("dry run")),
-	OPT_BOOL(0, "write-fetch-head", &write_fetch_head,
+	OPT_BOOL(0, "write-fetch-head", &user_specified_write_fetch_head,
 		 N_("write fetched references to the FETCH_HEAD file")),
 	OPT_BOOL('k', "keep", &keep, N_("keep downloaded pack")),
 	OPT_BOOL('u', "update-head-ok", &update_head_ok,
@@ -1023,11 +1024,14 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				rc |= update_local_ref(ref, what, rm, &note,
 						       summary_width);
 				free(ref);
-			} else if (write_fetch_head || dry_run) {
+			} else if (user_specified_write_fetch_head) {
 				/*
-				 * Display fetches written to FETCH_HEAD (or
-				 * would be written to FETCH_HEAD, if --dry-run
-				 * is set).
+				 * If the user specified --write-fetch-head
+				 * (or, equivalently, did not specify
+				 * --no-write-fetch-head), inform the user that
+				 * this ref was written to FETCH_HEAD (or, if
+				 * --dry-run was specified, would have been
+				 *  written).
 				 */
 				format_display(&note, '*',
 					       *kind ? kind : "branch", NULL,
@@ -1828,8 +1832,11 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (depth || deepen_since || deepen_not.nr)
 		deepen = 1;
 
-	/* FETCH_HEAD never gets updated in --dry-run mode */
-	if (dry_run)
+	/*
+	 * FETCH_HEAD never gets updated in --dry-run mode, nor if user passed
+	 * --no-write-fetch-head
+	 */
+	if (dry_run || !user_specified_write_fetch_head)
 		write_fetch_head = 0;
 
 	if (all) {
diff --git c/t/t5510-fetch.sh w/t/t5510-fetch.sh
index 759aec9305..83b2504519 100755
--- c/t/t5510-fetch.sh
+++ w/t/t5510-fetch.sh
@@ -557,6 +557,13 @@ test_expect_success '--no-write-fetch-head does not touch FETCH_HEAD, and does n
 	! grep FETCH_HEAD err
 '
 
+test_expect_success '--no-write-fetch-head and --dry-run does not touch FETCH_HEAD, and does not print what would be written' '
+	rm -f .git/FETCH_HEAD err &&
+	git fetch --dry-run --no-write-fetch-head . 2>err &&
+	! test -f .git/FETCH_HEAD &&
+	! grep FETCH_HEAD err
+'
+
 test_expect_success '--write-fetch-head gets defeated by --dry-run' '
 	rm -f .git/FETCH_HEAD &&
 	git fetch --dry-run --write-fetch-head . &&
