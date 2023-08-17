Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA8EC678DC
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 22:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355742AbjHQWaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 18:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355732AbjHQW3z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 18:29:55 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AC43595
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 15:29:53 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF9E91A824D;
        Thu, 17 Aug 2023 18:29:52 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=H5/BOkdbStAc/BYk39dViL9QO
        aHXf/vMIGXnBlM23nM=; b=U6RX0uMPUXZzS1MArAec9OyItvM7SRCrQDboFvcso
        j0besz4+Y/3Hj/SlnFN/3Qp9fxDOWSiU1StG+SIoa09hXkJjpjJsvoV+My8wS+vy
        bEGUu2ohNUSdRzy3S4QMQJP1u5TxR7gljbiA447WXDQ7mRySPBSSlNYUzHS5PjlX
        zo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A776E1A824C;
        Thu, 17 Aug 2023 18:29:52 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1C5CC1A824B;
        Thu, 17 Aug 2023 18:29:52 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 1/5] diff: --dirstat leakfix
Date:   Thu, 17 Aug 2023 15:29:45 -0700
Message-ID: <20230817222949.3835424-2-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-rc2
In-Reply-To: <20230817222949.3835424-1-gitster@pobox.com>
References: <xmqqttsxbfyw.fsf@gitster.g>
 <20230817222949.3835424-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 9547C696-3D4D-11EE-B079-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The dirstat_dir structure holds a list of files that had "damages"
and is used to summarize the change by directory.  It was allocated,
used, and then left behind, leaking.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                  | 14 ++++++++++++--
 t/t4047-diff-dirstat.sh |  2 ++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 648f6717a5..03d0cfc700 100644
--- a/diff.c
+++ b/diff.c
@@ -2977,6 +2977,7 @@ static void show_dirstat(struct diff_options *optio=
ns)
 	unsigned long changed;
 	struct dirstat_dir dir;
 	struct diff_queue_struct *q =3D &diff_queued_diff;
+	struct dirstat_file *to_free;
=20
 	dir.files =3D NULL;
 	dir.alloc =3D 0;
@@ -3060,13 +3061,17 @@ static void show_dirstat(struct diff_options *opt=
ions)
 		dir.nr++;
 	}
=20
+	to_free =3D dir.files;
+
 	/* This can happen even with many files, if everything was renames */
 	if (!changed)
-		return;
+		goto free_return;
=20
 	/* Show all directories with more than x% of the changes */
 	QSORT(dir.files, dir.nr, dirstat_compare);
 	gather_dirstat(options, &dir, changed, "", 0);
+free_return:
+	free(to_free);
 }
=20
 static void show_dirstat_by_line(struct diffstat_t *data, struct diff_op=
tions *options)
@@ -3074,6 +3079,7 @@ static void show_dirstat_by_line(struct diffstat_t =
*data, struct diff_options *o
 	int i;
 	unsigned long changed;
 	struct dirstat_dir dir;
+	struct dirstat_file *to_free;
=20
 	if (data->nr =3D=3D 0)
 		return;
@@ -3104,13 +3110,17 @@ static void show_dirstat_by_line(struct diffstat_=
t *data, struct diff_options *o
 		dir.nr++;
 	}
=20
+	to_free =3D dir.files;
+
 	/* This can happen even with many files, if everything was renames */
 	if (!changed)
-		return;
+		goto free_return;
=20
 	/* Show all directories with more than x% of the changes */
 	QSORT(dir.files, dir.nr, dirstat_compare);
 	gather_dirstat(options, &dir, changed, "", 0);
+free_return:
+	free(to_free);
 }
=20
 static void free_diffstat_file(struct diffstat_file *f)
diff --git a/t/t4047-diff-dirstat.sh b/t/t4047-diff-dirstat.sh
index 7fec2cb9cd..70224c3da1 100755
--- a/t/t4047-diff-dirstat.sh
+++ b/t/t4047-diff-dirstat.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'diff --dirstat tests'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # set up two commits where the second commit has these files
--=20
2.42.0-rc2

