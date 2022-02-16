Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAD4C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 07:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiBPHLf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 02:11:35 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiBPHLc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 02:11:32 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2097639B
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 23:11:02 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0732A12B7B1;
        Wed, 16 Feb 2022 02:05:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=f
        PqEVdlEgXRYDfvue0sNZ1HoEFivt3wUvUHNlMnQ+8E=; b=C/mFTgo8egW3ZuxE0
        hOzFt5UdkBwm3SelAd7F+Gfd97k67MWYUJynnJojQ4NQOy6DYPGqhJAf0BTun94s
        3TUOMzq+HrHAbFBp1Rp2jjkDmydlxni7ZDTnA1KST9KhCV9nzlxBpfh+ruZkRtFj
        0Uu/uuXBUyOSX7bXDoE2sWK7I8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F2A8D12B7B0;
        Wed, 16 Feb 2022 02:05:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5791712B7AF;
        Wed, 16 Feb 2022 02:05:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] rerere-train: modernise a bit
Date:   Tue, 15 Feb 2022 23:05:45 -0800
Message-ID: <xmqqsfsjuw8m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD12A132-8EF6-11EC-8CE4-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The script wants to create a list of merges using "rev-list" and
filters commits that do not have more than one parent, but if we
always pass "--merges" to "rev-list", there is no need to filter.

The command uses "git show --pretty=format:..." on a single commit
while generating progress reports, which means this title line is
left unterminated.  It should have used --pretty=tformat:...
instead, or better yet, use the more modern --format=... to ensure
that the title line is properly terminated.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/rerere-train.sh | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git c/contrib/rerere-train.sh w/contrib/rerere-train.sh
index 75125d6ae0..499b07e4a6 100755
--- c/contrib/rerere-train.sh
+++ w/contrib/rerere-train.sh
@@ -66,14 +66,9 @@ original_HEAD=$(git rev-parse --verify HEAD) || {
 
 mkdir -p "$GIT_DIR/rr-cache" || exit
 
-git rev-list --parents "$@" |
+git rev-list --parents --merges "$@" |
 while read commit parent1 other_parents
 do
-	if test -z "$other_parents"
-	then
-		# Skip non-merges
-		continue
-	fi
 	git checkout -q "$parent1^0"
 	if git merge $other_parents >/dev/null 2>&1
 	then
@@ -86,7 +81,7 @@ do
 	fi
 	if test -s "$GIT_DIR/MERGE_RR"
 	then
-		git show -s --pretty=format:"Learning from %h %s" "$commit"
+		git show -s --format="Learning from %h %s" "$commit"
 		git rerere
 		git checkout -q $commit -- .
 		git rerere
