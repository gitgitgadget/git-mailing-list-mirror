Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF3CEE49A2
	for <git@archiver.kernel.org>; Sat, 19 Aug 2023 00:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243043AbjHRX7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Aug 2023 19:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243137AbjHRX7n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2023 19:59:43 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0FB3AAE
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 16:59:42 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AAAEC1A3C91;
        Fri, 18 Aug 2023 19:59:41 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=VjJgijPc/v86MgoPQfgE5TFr6
        ncqjwK2vV40zXVIiBU=; b=QM5v4nexNJ+zYIwJepBvvqCBZs6z8euTd2U3VyYFm
        wQdKFOfBCWeliDyUjLFailj6BpHN1xIo7DkqUMa8QBUQREVIyciP0whNdjqaNPo8
        bFPpmSUzJlWQuCXbqzr6ofRfyimMMfIcCnwDo6oey3bA1sp7SH0wP+RlBXTWtYLc
        xk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A2E151A3C90;
        Fri, 18 Aug 2023 19:59:41 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1B14B1A3C8F;
        Fri, 18 Aug 2023 19:59:41 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 3/5] diff: teach "--stat -w --exit-code" to notice differences
Date:   Fri, 18 Aug 2023 16:59:30 -0700
Message-ID: <20230818235932.3253552-4-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-rc2-7-gf9972720e9
In-Reply-To: <20230818235932.3253552-1-gitster@pobox.com>
References: <20230817222949.3835424-1-gitster@pobox.com>
 <20230818235932.3253552-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 4BC809C8-3E23-11EE-979B-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When options like "-w" is used while "--exit-code" option is in
effect, instead of the usual "do we have any filepair whose preimage
and postimage have different <mode,object>?" check, we need to compare
the contents of the blobs, taking into account that certain changes
are considered no-op.

With the previous step, we taught "--patch" codepath to set the
.found_changes bit correctly, even for a change that only affects
the mode and not object.  The "--stat" codepath, however, did not
set the .found_changes bit at all.  This lead to

    $ git diff --stat -w --exit-code

for a change that does have an output to exit with status 0.

Set the bit by inspecting the list of paths the diffstat output is
given for (a mode-only change will still appear as a "0-line added
0-line deleted" change) to fix it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                     | 1 +
 t/t4015-diff-whitespace.sh | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 998d7ae20c..da965ff688 100644
--- a/diff.c
+++ b/diff.c
@@ -6901,6 +6901,7 @@ void compute_diffstat(struct diff_options *options,
 		if (check_pair_status(p))
 			diff_flush_stat(p, options, diffstat);
 	}
+	options->found_changes =3D !!diffstat->nr;
 }
=20
 void diff_addremove(struct diff_options *options,
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 02731dccb9..230a89b951 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -11,7 +11,7 @@ TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
=20
-for opts in --patch --quiet -s
+for opts in --patch --quiet -s --stat --shortstat --dirstat=3Dlines
 do
=20
 	test_expect_success "status with $opts (different)" '
--=20
2.42.0-rc2-7-gf9972720e9

