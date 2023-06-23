Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C000EB64DA
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 00:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjFWAdb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 20:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjFWAda (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 20:33:30 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D9C2680
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 17:33:07 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 11F2C1A2895;
        Thu, 22 Jun 2023 20:33:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RGJeJyA66mjScIZwFSufsj5Uju52oxMXRBSCHr
        TOT9Q=; b=haOEmMPvfz0ycJaxC6+xSgYd0R7UdGYrx0D7QHSvqnJXxC0v34/p4t
        AVM/LFP31UxeVLEd5TP4ngieEBw0vrYhsgiu0mwlukwYWvBVka+BSyePThiKmi+j
        Nk7n7e+5G2DT8i7INwqNyIDxWbfRlGE7zJEdBe3S5+On+d9FJp1HM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0922C1A2894;
        Thu, 22 Jun 2023 20:33:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 425051A2893;
        Thu, 22 Jun 2023 20:33:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Joshua Hudson <jhudson@cedaron.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH] ll-merge: killing the external merge driver aborts the merge
References: <6e1b9ce4-e86d-fe30-e5de-27a3be57eefd@cedaron.com>
        <xmqqttuze2fh.fsf@gitster.g>
Date:   Thu, 22 Jun 2023 17:33:01 -0700
In-Reply-To: <xmqqttuze2fh.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        22 Jun 2023 12:12:50 -0700")
Message-ID: <xmqq4jmzc91e.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 839E8DBA-115D-11EE-90E0-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When an external merge driver dies with a signal, we should not
expect that the result left on the filesystem is in any useful
state.  However, because the current code uses the return value from
run_command() and declares any positive value as a sign that the
driver successfully left conflicts in the result, and because the
return value from run_command() for a subprocess that died upon a
signal is positive, we end up treating whatever garbage left on the
filesystem as the result the merge driver wanted to leave us.

run_command() returns larger than 128 (WTERMSIG(status) + 128, to be
exact) when it notices that the subprocess died with a signal, so
detect such a case and return LL_MERGE_ERROR from ll_ext_merge().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This time with an updated title, a minimal documentation, and an
   additional test.

 Documentation/gitattributes.txt |  5 ++++-
 ll-merge.c                      |  9 ++++++++-
 t/t6406-merge-attr.sh           | 23 +++++++++++++++++++++++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 02a3ec83e4..6deb89a296 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -1132,7 +1132,10 @@ size (see below).
 The merge driver is expected to leave the result of the merge in
 the file named with `%A` by overwriting it, and exit with zero
 status if it managed to merge them cleanly, or non-zero if there
-were conflicts.
+were conflicts.  When the driver crashes (e.g. killed by SEGV),
+it is expected to exit with non-zero status that are higher than
+128, and in such a case, the merge results in a failure (which is
+different from producing a conflict).
 
 The `merge.*.recursive` variable specifies what other merge
 driver to use when the merge driver is called for an internal
diff --git a/ll-merge.c b/ll-merge.c
index 07ec16e8e5..ba45aa2f79 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -243,7 +243,14 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 		unlink_or_warn(temp[i]);
 	strbuf_release(&cmd);
 	strbuf_release(&path_sq);
-	ret = (status > 0) ? LL_MERGE_CONFLICT : status;
+
+	if (!status)
+		ret = LL_MERGE_OK;
+	else if (status <= 128)
+		ret = LL_MERGE_CONFLICT;
+	else
+		/* died due to a signal: WTERMSIG(status) + 128 */
+		ret = LL_MERGE_ERROR;
 	return ret;
 }
 
diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
index 5e4e4dd6d9..b50aedbc00 100755
--- a/t/t6406-merge-attr.sh
+++ b/t/t6406-merge-attr.sh
@@ -56,6 +56,12 @@ test_expect_success setup '
 	) >"$ours+"
 	cat "$ours+" >"$ours"
 	rm -f "$ours+"
+
+	if test -f ./please-abort
+	then
+		echo >>./please-abort killing myself
+		kill -9 $$
+	fi
 	exit "$exit"
 	EOF
 	chmod +x ./custom-merge
@@ -162,6 +168,23 @@ test_expect_success 'custom merge backend' '
 	rm -f $o $a $b
 '
 
+test_expect_success 'custom merge driver that is killed with a signal' '
+	test_when_finished "rm -f output please-abort" &&
+
+	git reset --hard anchor &&
+	git config --replace-all \
+	merge.custom.driver "./custom-merge %O %A %B 0 %P" &&
+	git config --replace-all \
+	merge.custom.name "custom merge driver for testing" &&
+
+	>./please-abort &&
+	echo "* merge=custom" >.gitattributes &&
+	test_must_fail git merge main &&
+	git ls-files -u >output &&
+	git diff --name-only HEAD >>output &&
+	test_must_be_empty output
+'
+
 test_expect_success 'up-to-date merge without common ancestor' '
 	git init repo1 &&
 	git init repo2 &&
-- 
2.41.0-159-g0bfa463d37

