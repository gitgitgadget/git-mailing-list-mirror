Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C05C433F5
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 22:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiB0WNb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 17:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbiB0WNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 17:13:25 -0500
X-Greylist: delayed 200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Feb 2022 14:12:47 PST
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BD41A82A
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 14:12:46 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BBD21F9A24;
        Sun, 27 Feb 2022 17:09:25 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=AprpThhjVaXL4x2Txgyp1gt8g
        5Q1/YZb2q9ZjVhVfoM=; b=S/NToVH6uUNMCd2Hd8dv6YvNiLnWQ/JQZJf+da+mr
        9FNLAJqJcu2l6o/lX/FhcCJarB9M5AQx8Ok+i4OPCXgRqDJjzplZ7RkYCABbYtBG
        KaKoXCv+kuUpZMXMWfXcy8Ktg+eZ1rXzV68bRo3bM8cEj1eC9YnbfORjUyVGS2a8
        a0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B3DEBF9A23;
        Sun, 27 Feb 2022 17:09:25 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 21706F9A22;
        Sun, 27 Feb 2022 17:09:25 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2] rerere-train: two fixes to the use of "git show -s"
Date:   Sun, 27 Feb 2022 14:09:24 -0800
Message-Id: <20220227220924.2144325-1-gitster@pobox.com>
X-Mailer: git-send-email 2.35.1-354-g715d08a9e5
In-Reply-To: <xmqqsfsjuw8m.fsf@gitster.g>
References: <xmqqsfsjuw8m.fsf@gitster.g>
MIME-Version: 1.0
X-Pobox-Relay-ID: EC8726B6-9819-11EC-9C14-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The script uses "git show -s" to display the title of the merge
commit being studied, without explicitly disabling the pager, which
is not a safe thing to do in a script.

For example, when the pager is set to "less" with "-SF" options (-S
tells the pager not to fold lines but allow horizontal scrolling to
show the overly long lines, -F tells the pager not to wait if the
output in its entirety is shown on a single page), and the title of
the merge commit is longer than the width of the terminal, the pager
will wait until the end-user tells it to quit after showing the
single line.

Explicitly disable the pager with this "git show" invocation to fix
this.

The command uses the "--pretty=3Dformat:..." format, which adds LF in
between each pair of commits it outputs, which means that the label
for the merge being learned from will be followed by the next
message on the same line.  "--pretty=3Dtformat:..." is what we should
instead, which adds LF after each commit, or a more modern way to
spell it, i.e. "--format=3D...".  This existing breakage becomes
easier to see, now we no longer use the pager.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Relative to the initial version, the "--no-merges" change has
   been removed because the end user can still give --merges from
   the command line and the filtering of merges done by the script
   is still needed for correctness.

 contrib/rerere-train.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/rerere-train.sh b/contrib/rerere-train.sh
index 75125d6ae0..26b724c8c6 100755
--- a/contrib/rerere-train.sh
+++ b/contrib/rerere-train.sh
@@ -86,7 +86,7 @@ do
 	fi
 	if test -s "$GIT_DIR/MERGE_RR"
 	then
-		git show -s --pretty=3Dformat:"Learning from %h %s" "$commit"
+		git --no-pager show -s --format=3D"Learning from %h %s" "$commit"
 		git rerere
 		git checkout -q $commit -- .
 		git rerere
--=20
2.35.1-354-g715d08a9e5

