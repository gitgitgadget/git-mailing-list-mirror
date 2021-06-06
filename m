Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC2EC47096
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 12:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7586B6124C
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 12:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhFFMcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 08:32:20 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50913 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhFFMcT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 08:32:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E353012B2AB;
        Sun,  6 Jun 2021 08:30:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=J
        pef77nXpAwXPfrjLE4jldq6B4uE0lqeRCdkE634Q7o=; b=x8BZTThm1vv8/qXVi
        X/dg/tMgl/S3ePI4LNUYVj/lpBTEscBHhFSn5toKscI4NNW1SszciKmZtW9wEn+l
        hSoCHHTWAeHidc7jA2lQP/UG76Q5/fH3Jd+Gw6YriuqHmsnEkxGxrcBX6ozpFB9N
        UtzyPu1ywHpvaYYPaszFA6vXv0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DBA6812B2A8;
        Sun,  6 Jun 2021 08:30:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0CD4712B2A7;
        Sun,  6 Jun 2021 08:30:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] rerere: enable by default
Date:   Sun, 06 Jun 2021 21:30:25 +0900
Message-ID: <xmqqfsxvxjj2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F922B2BA-C6C2-11EB-8541-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By default, the rerere machinery has been disabled since a bug in
the machinery could screw up the end user's data at the most
stressful time during the end user's workday (i.e. during conflict
resolution).

It however has been in wide use without causing much trouble (other
than, obviously, replaying a broken conflict resolution that was
recorded earlier when the user made a mismerge), and it is about
time to enable it by default.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/rerere.txt |  5 ++---
 rerere.c                        | 12 +++---------
 t/t2030-unresolve-info.sh       |  3 +++
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/Documentation/config/rerere.txt b/Documentation/config/rerere.txt
index 40abdf6a6b..45e97fc0fa 100644
--- a/Documentation/config/rerere.txt
+++ b/Documentation/config/rerere.txt
@@ -7,6 +7,5 @@ rerere.enabled::
 	Activate recording of resolved conflicts, so that identical
 	conflict hunks can be resolved automatically, should they be
 	encountered again.  By default, linkgit:git-rerere[1] is
-	enabled if there is an `rr-cache` directory under the
-	`$GIT_DIR`, e.g. if "rerere" was previously used in the
-	repository.
+	enabled, but this configuration can be set to 'false' to
+	turn it off.
diff --git a/rerere.c b/rerere.c
index d83d58df4f..83e740d730 100644
--- a/rerere.c
+++ b/rerere.c
@@ -18,8 +18,7 @@
 #define THREE_STAGED 2
 void *RERERE_RESOLVED = &RERERE_RESOLVED;
 
-/* if rerere_enabled == -1, fall back to detection of .git/rr-cache */
-static int rerere_enabled = -1;
+static int rerere_enabled = 1; /* default to true */
 
 /* automatically update cleanly resolved paths to the index */
 static int rerere_autoupdate;
@@ -852,16 +851,11 @@ static GIT_PATH_FUNC(git_path_rr_cache, "rr-cache")
 
 static int is_rerere_enabled(void)
 {
-	int rr_cache_exists;
-
 	if (!rerere_enabled)
 		return 0;
 
-	rr_cache_exists = is_directory(git_path_rr_cache());
-	if (rerere_enabled < 0)
-		return rr_cache_exists;
-
-	if (!rr_cache_exists && mkdir_in_gitdir(git_path_rr_cache()))
+	if (!is_directory(git_path_rr_cache()) &&
+	    mkdir_in_gitdir(git_path_rr_cache()))
 		die(_("could not create directory '%s'"), git_path_rr_cache());
 	return 1;
 }
diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index be6c84c52a..8c571ddf92 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -46,6 +46,7 @@ prime_resolve_undo () {
 }
 
 test_expect_success setup '
+	git config rerere.enabled false &&
 	mkdir fi &&
 	printf "a\0a" >binary &&
 	git add binary &&
@@ -127,6 +128,8 @@ test_expect_success 'unmerge with plumbing' '
 '
 
 test_expect_success 'rerere and rerere forget' '
+	# from here on, use rerere.
+	git config rerere.enabled true &&
 	mkdir .git/rr-cache &&
 	prime_resolve_undo &&
 	echo record the resolution &&
-- 
2.32.0-189-ge1556ffcec

