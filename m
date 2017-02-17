Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF7A6201A8
	for <e@80x24.org>; Fri, 17 Feb 2017 03:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755428AbdBQD7A (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 22:59:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60209 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754684AbdBQD65 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 22:58:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 55A926A024;
        Thu, 16 Feb 2017 22:58:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=ZANp
        +o3GhIeSkFAXL0Kid90ESGY=; b=prgjr89j/bIcN+vLYYvV6XwSAKA4r6uMNzq7
        hYXVL7vgUVFSFusNQwO2kuW7pspOXt0vJ/qYfx4P5wTcrwR9Whopw0OO0YAR72fC
        t/jxwQBVDOWsVRavNic6bPuWszprcA4Hc80NFu0T5mLWMSQezsF58MxQGYjtvqwE
        VQtD394=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E2726A022;
        Thu, 16 Feb 2017 22:58:56 -0500 (EST)
Received: from kmlap.hsd1.ct.comcast.net (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9F7E76A01E;
        Thu, 16 Feb 2017 22:58:54 -0500 (EST)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: [PATCH 3/3] rename_ref: replace empty deletion message in HEAD's log
Date:   Thu, 16 Feb 2017 22:58:00 -0500
Message-Id: <20170217035800.13214-4-kyle@kyleam.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170217035800.13214-1-kyle@kyleam.com>
References: <20170126211205.5gz3zsrptop7n34n@sigill.intra.peff.net>
 <20170217035800.13214-1-kyle@kyleam.com>
X-Pobox-Relay-ID: 67286B3A-F4C5-11E6-B218-A7617B1B28F4-24757444!pb-smtp2.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references; s=mesmtp;
 bh=ZANp+o3GhIeSkFAXL0Kid90ESGY=;
 b=lDIZfoHic/HcDERRCsR0vP56/OtU9v0zvDjIeTlOAr+qR5i0Kig6jIaeo+K17rtqZiwhraRc/u0PsF+R5y3KpQ/+TiJ5lxZkC3jig44cRrq2qVVL3muNLRhED2v7djNvM6PA7mtNMsfIiAaMRBvy542Yt94uxqtnr5xFtoYhxtc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the current branch is renamed, the deletion of the old ref is
recorded in HEAD's log with an empty message.  Now that delete_refs()
accepts a reflog message, provide a more descriptive message.  This
message will not be included in the reflog of the renamed branch, but
its log already covers the renaming event with a message of "Branch:
renamed ...".

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 refs/files-backend.c | 8 +++++++-
 t/t3200-branch.sh    | 4 ++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index ffa75d816..bb5df7ee6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2598,6 +2598,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 	struct stat loginfo;
 	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
 	struct strbuf err = STRBUF_INIT;
+	struct strbuf logmsg_del = STRBUF_INIT;
 
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
@@ -2616,10 +2617,15 @@ static int files_rename_ref(struct ref_store *ref_store,
 		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
 			oldrefname, strerror(errno));
 
-	if (delete_ref(oldrefname, orig_sha1, REF_NODEREF, NULL)) {
+	strbuf_addf(&logmsg_del, "Deleted %s", oldrefname);
+
+	if (delete_ref(oldrefname, orig_sha1, REF_NODEREF, logmsg_del.buf)) {
 		error("unable to delete old %s", oldrefname);
+		strbuf_release(&logmsg_del);
 		goto rollback;
 	}
+	strbuf_release(&logmsg_del);
+
 
 	/*
 	 * Since we are doing a shallow lookup, sha1 is not the
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 8a833f354..4af7cd2b7 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -139,6 +139,10 @@ test_expect_success 'git branch -M baz bam should succeed when baz is checked ou
 	test $(git rev-parse --abbrev-ref HEAD) = bam
 '
 
+test_expect_success 'git branch -M baz bam should add entry to .git/logs/HEAD' '
+	grep "Deleted refs/heads/baz$" .git/logs/HEAD >/dev/null
+'
+
 test_expect_success 'git branch -M baz bam should succeed when baz is checked out as linked working tree' '
 	git checkout master &&
 	git worktree add -b baz bazdir &&
-- 
2.11.1

