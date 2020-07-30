Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0D3C433DF
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 18:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 667AA20809
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 18:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="s20noWb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbgG3SCt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 14:02:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58733 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730363AbgG3SCt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 14:02:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E8F926C4BE;
        Thu, 30 Jul 2020 14:02:42 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=lRNiC1dDRxOqjbUhKcgA75zKV
        I8=; b=s20noWb5aVHGOmtF9Kkeaolzsypr1E1h3szx8lvbtQsBX8qOb2h5s2luf
        Bi/VGpFk3bg3UjGxt2ZPU6oi2nv2NASe0ROpx1RFA15HTzUlUgLVVZaMsBIJGnRh
        DO2INDPURMVmJjj3iqioNZjmuXE4yIqTjS7PNCezfjPd93FHxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=Q9aHOguXJCeE9llApfq
        Q6yixpT2gDMYCW9baZb5BLW/ayrKWSMfHe7JWfqzrIICZSjhEh47GJo9p2cBQQTD
        guiIo4SiMktNS1Aoer3A+04B5Rcun1AucNk5oayGIsKny4SQR3PMrSRLEaTqmWKc
        q+8p+SC507qVm0GYmUd/uuBc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD57B6C4BD;
        Thu, 30 Jul 2020 14:02:42 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 598BE6C4BC;
        Thu, 30 Jul 2020 14:02:42 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 2/2] fmt-merge-msg: allow merge destination to be omitted again
Date:   Thu, 30 Jul 2020 11:02:37 -0700
Message-Id: <20200730180237.1392480-3-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730180237.1392480-1-gitster@pobox.com>
References: <xmqq5za596uo.fsf@gitster.c.googlers.com>
 <20200730180237.1392480-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: DD09D24E-D28E-11EA-ACCD-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In Git 2.28, we stopped special casing 'master' when producing the
default merge message by just removing the code to squelch "into
'master'" at the end of the message.

Introduce multi-valued merge.suppressDest configuration variable
that gives a set of globs to match against the name of the branch
into which the merge is being made, to let users specify for which
branch fmt-merge-msg's output should be shortened.  When it is not
set, 'master' is used as the sole value of the variable by default.

The above move mostly reverts the pre-2.28 default in repositories
that have no relevant configuration.

Add a few tests to protect the behaviour with the new configuration
variable from future regression.

Helped-by: Linus Torvalds <torvalds@linux-foundation.org>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/fmt-merge-msg.txt | 12 ++++++++
 fmt-merge-msg.c                        | 38 +++++++++++++++++++++++---
 t/t6200-fmt-merge-msg.sh               | 20 ++++++++++++++
 3 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/fmt-merge-msg.txt b/Documentation/confi=
g/fmt-merge-msg.txt
index c73cfa90b7..a8e8f74d0a 100644
--- a/Documentation/config/fmt-merge-msg.txt
+++ b/Documentation/config/fmt-merge-msg.txt
@@ -8,3 +8,15 @@ merge.log::
 	most the specified number of one-line descriptions from the
 	actual commits that are being merged.  Defaults to false, and
 	true is a synonym for 20.
+
+merge.suppressDest::
+	By adding a glob that matches the names of integration
+	branches to this multi-valued configuration variable, the
+	default merge message computed for merges into these
+	integration branches will omit " into <branch name>" from
+	its title.
++
+An element with an empty value can be used to clear the list
+of globs accumulated from previous configuration entries.
+When there is no `merge.suppressDest` variable defined, the
+default value of `master` is used for backward compatibility.
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 72d32bd73b..bd22e1ea88 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -10,6 +10,8 @@
 #include "commit-reach.h"
=20
 static int use_branch_desc;
+static int suppress_dest_pattern_seen;
+static struct string_list suppress_dest_patterns =3D STRING_LIST_INIT_DU=
P;
=20
 int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 {
@@ -22,6 +24,14 @@ int fmt_merge_msg_config(const char *key, const char *=
value, void *cb)
 			merge_log_config =3D DEFAULT_MERGE_LOG_LEN;
 	} else if (!strcmp(key, "merge.branchdesc")) {
 		use_branch_desc =3D git_config_bool(key, value);
+	} else if (!strcmp(key, "merge.suppressdest")) {
+		if (!value)
+			return config_error_nonbool(key);
+		if (!*value)
+			string_list_clear(&suppress_dest_patterns, 0);
+		else
+			string_list_append(&suppress_dest_patterns, value);
+		suppress_dest_pattern_seen =3D 1;
 	} else {
 		return git_default_config(key, value, cb);
 	}
@@ -403,6 +413,24 @@ static void shortlog(const char *name,
 	string_list_clear(&subjects, 0);
 }
=20
+/*
+ * See if dest_branch matches with any glob pattern on the
+ * suppress_dest_patterns list.
+ *
+ * We may want to also allow negative matches e.g. ":!glob" like we do
+ * for pathspec, but for now, let's keep it simple and stupid.
+ */
+static int dest_suppressed(const char *dest_branch)
+{
+	struct string_list_item *item;
+
+	for_each_string_list_item(item, &suppress_dest_patterns) {
+		if (!wildmatch(item->string, dest_branch, WM_PATHNAME))
+			return 1;
+	}
+	return 0;
+}
+
 static void fmt_merge_msg_title(struct strbuf *out,
 				const char *current_branch)
 {
@@ -451,10 +479,9 @@ static void fmt_merge_msg_title(struct strbuf *out,
 			strbuf_addf(out, " of %s", srcs.items[i].string);
 	}
=20
-	if (!strcmp("master", current_branch))
-		strbuf_addch(out, '\n');
-	else
-		strbuf_addf(out, " into %s\n", current_branch);
+	if (!dest_suppressed(current_branch))
+		strbuf_addf(out, " into %s", current_branch);
+	strbuf_addch(out, '\n');
 }
=20
 static void fmt_tag_signature(struct strbuf *tagbuf,
@@ -599,6 +626,9 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *o=
ut,
 	void *current_branch_to_free;
 	struct merge_parents merge_parents;
=20
+	if (!suppress_dest_pattern_seen)
+		string_list_append(&suppress_dest_patterns, "master");
+
 	memset(&merge_parents, 0, sizeof(merge_parents));
=20
 	/* get current branch */
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index e4c2a6eca4..7d549748ef 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -542,4 +542,24 @@ test_expect_success 'merge-msg with "merging" an ann=
otated tag' '
 	test_cmp expected .git/MERGE_MSG
 '
=20
+test_expect_success 'merge.suppressDest configuration' '
+	git checkout -B side master &&
+	git commit --allow-empty -m "One step ahead" &&
+	git checkout master &&
+	git fetch . side &&
+
+	git -c merge.suppressDest=3D"" fmt-merge-msg <.git/FETCH_HEAD >full.1 &=
&
+	head -n1 full.1 >actual &&
+	grep -e "Merge branch .side. into master" actual &&
+
+	git -c merge.suppressDest=3D"mast" fmt-merge-msg <.git/FETCH_HEAD >full=
.2 &&
+	head -n1 full.2 >actual &&
+	grep -e "Merge branch .side. into master$" actual &&
+
+	git -c merge.suppressDest=3D"ma??er" fmt-merge-msg <.git/FETCH_HEAD >fu=
ll.3 &&
+	head -n1 full.3 >actual &&
+	grep -e "Merge branch .side." actual &&
+	! grep -e " into master$" actual
+'
+
 test_done
--=20
2.28.0

