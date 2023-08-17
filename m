Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9434BC7112F
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 22:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355749AbjHQWaV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 18:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355738AbjHQWaH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 18:30:07 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA5030DA
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 15:30:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DAD6521588;
        Thu, 17 Aug 2023 18:30:02 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=d3jHmn1eL3Y5F+8rwj8DGJg4Y
        ACZBGRMycmuvYISa1Y=; b=sAz9inqusq13u00WWxvzqFBp8H9RU5vsC4VIfRQlM
        uOVWP/BP8xbURW1VgjCR1RsK5jLI5UcxPVkGJxWkvsWWErdOQ0yLPSNKIBc9p9wJ
        dpqlMC7ECZvJVp0OlYRjWfUdE2h4FyOJCXGU/TlhL415MxgOEV13yuRa0Y4ZipfO
        XY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D477E21587;
        Thu, 17 Aug 2023 18:30:02 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EE61621582;
        Thu, 17 Aug 2023 18:29:58 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 4/5] diff: teach "--stat -w --exit-code" to notice differences
Date:   Thu, 17 Aug 2023 15:29:48 -0700
Message-ID: <20230817222949.3835424-5-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-rc2
In-Reply-To: <20230817222949.3835424-1-gitster@pobox.com>
References: <xmqqttsxbfyw.fsf@gitster.g>
 <20230817222949.3835424-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 995DFE44-3D4D-11EE-95D2-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
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

for a change that does have an outout to exit with status 0.

Set the bit by inspecting the list of paths the diffstat output is
given for (a mode-only change will still appear as a "0-line added
0-line deleted" change) to fix it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                     | 1 +
 t/t4015-diff-whitespace.sh | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index de18364902..7213237675 100644
--- a/diff.c
+++ b/diff.c
@@ -6905,6 +6905,7 @@ void compute_diffstat(struct diff_options *options,
 		if (check_pair_status(p))
 			diff_flush_stat(p, options, diffstat);
 	}
+	options->found_changes =3D !!diffstat->nr;
 }
=20
 void diff_addremove(struct diff_options *options,
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 943ad252d4..355d96aa14 100755
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
2.42.0-rc2

