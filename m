Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5877CC433E0
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 18:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F4772083B
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 18:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KEwTpdHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbgG3SCw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 14:02:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60913 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3SCv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 14:02:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A7DD5DBD27;
        Thu, 30 Jul 2020 14:02:42 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=MlFLUYJdNBu8v/fYAf+9XKH09
        fI=; b=KEwTpdHeC6zf/mY+A+KB+c4gg6oYygtx+O16OJ+vBDSHi/A0Q20M/ebXb
        AV3sQYilUvZgzEjEhLSnBKRmpIAXXl6HK86CA9B2jtPfN9Y1SGE9KFp7cNJxDnZ6
        wZ3jZOSebApwlXCoAM4kUQzQKhC5M/av56vKTgFvNJVGD1O/II=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=d2/xvrj11Kp0UiyMGYp
        AXA572TJFAck8VfXOmbVvXcgQmifMc475vnaVEX4AMVbTalfiAG9JflyIpYLryPm
        O/zlYR/NRs/UA3aeWqdbc74Uyg7JT7AJPLNxBT2RxZSOAMAxILXbr8KPx/VP0UmF
        UGXOiIjTrwLAHB1FrJU2Z/D8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A0D47DBD26;
        Thu, 30 Jul 2020 14:02:42 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CA494DBD25;
        Thu, 30 Jul 2020 14:02:39 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 1/2] Revert "fmt-merge-msg: stop treating `master` specially"
Date:   Thu, 30 Jul 2020 11:02:36 -0700
Message-Id: <20200730180237.1392480-2-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730180237.1392480-1-gitster@pobox.com>
References: <xmqq5za596uo.fsf@gitster.c.googlers.com>
 <20200730180237.1392480-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: DB86060E-D28E-11EA-9808-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts commit 489947cee5095b168cbac111ff7bd1eadbbd90dd, which
stopped treating merges into the 'master' branch any specially when
preparing the default merge message.  As the goal was not to have
any single branch designated as special, it solved it by leaving the
"into <branchname>" at the end of the title of the default merge
message for any and all branches.  An obvious and easy alternative
to treat everybody equally could have been to remove it for every
branch, but that involves loss of information.

We'll introduce a new mechanism to let end-users specify merges into
which branches would omit the "into <branchname>" from the title of
the default merge message, and make the mechanism, when unconfigured,
treat the traditional 'master' special again, so all the changes to
the tests we made earlier will become unnecessary, as these tests
will be run with out configuring the said new mechanism.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 fmt-merge-msg.c                               |  5 +-
 t/t1507-rev-parse-upstream.sh                 |  2 +-
 t/t4013-diff-various.sh                       |  4 +-
 t/t4013/diff.log_--decorate=3Dfull_--all        |  2 +-
 t/t4013/diff.log_--decorate_--all             |  2 +-
 ...--patch-with-stat_--summary_master_--_dir_ |  2 +-
 t/t4013/diff.log_--patch-with-stat_master     |  2 +-
 .../diff.log_--patch-with-stat_master_--_dir_ |  2 +-
 ...ot_--cc_--patch-with-stat_--summary_master |  2 +-
 ..._--root_--patch-with-stat_--summary_master |  2 +-
 .../diff.log_--root_--patch-with-stat_master  |  2 +-
 ...root_-c_--patch-with-stat_--summary_master |  2 +-
 t/t4013/diff.log_--root_-p_master             |  2 +-
 t/t4013/diff.log_--root_master                |  2 +-
 t/t4013/diff.log_-m_-p_--first-parent_master  |  2 +-
 t/t4013/diff.log_-m_-p_master                 |  4 +-
 t/t4013/diff.log_-p_--first-parent_master     |  2 +-
 t/t4013/diff.log_-p_master                    |  2 +-
 t/t4013/diff.log_master                       |  2 +-
 t/t4013/diff.show_--first-parent_master       |  2 +-
 t/t4013/diff.show_-c_master                   |  2 +-
 t/t4013/diff.show_-m_master                   |  4 +-
 t/t4013/diff.show_master                      |  2 +-
 ...ot_--cc_--patch-with-stat_--summary_master |  2 +-
 ...root_-c_--patch-with-stat_--summary_master |  2 +-
 t/t4202-log.sh                                | 72 +++++++++----------
 t/t6200-fmt-merge-msg.sh                      | 36 +++++-----
 t/t7600-merge.sh                              | 14 ++--
 t/t7608-merge-messages.sh                     | 10 +--
 29 files changed, 97 insertions(+), 94 deletions(-)

diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index cfb8ff2f33..72d32bd73b 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -451,7 +451,10 @@ static void fmt_merge_msg_title(struct strbuf *out,
 			strbuf_addf(out, " of %s", srcs.items[i].string);
 	}
=20
-	strbuf_addf(out, " into %s\n", current_branch);
+	if (!strcmp("master", current_branch))
+		strbuf_addch(out, '\n');
+	else
+		strbuf_addf(out, " into %s\n", current_branch);
 }
=20
 static void fmt_tag_signature(struct strbuf *tagbuf,
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.s=
h
index f213aa8053..dfc0d96d8a 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -137,7 +137,7 @@ test_expect_success 'merge my-side@{u} records the co=
rrect name' '
 	git branch -t new my-side@{u} &&
 	git merge -s ours new@{u} &&
 	git show -s --pretty=3Dtformat:%s >actual &&
-	echo "Merge remote-tracking branch ${SQ}origin/side${SQ} into master" >=
expect &&
+	echo "Merge remote-tracking branch ${SQ}origin/side${SQ}" >expect &&
 	test_cmp expect actual
 )
 '
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 43267d6024..3f60f7d96c 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -117,12 +117,12 @@ test_expect_success setup '
=20
 : <<\EOF
 ! [initial] Initial
- * [master] Merge branch 'side' into master
+ * [master] Merge branch 'side'
   ! [rearrange] Rearranged lines in dir/sub
    ! [side] Side
 ----
   +  [rearrange] Rearranged lines in dir/sub
- -   [master] Merge branch 'side' into master
+ -   [master] Merge branch 'side'
  * + [side] Side
  *   [master^] Third
  *   [master~2] Second
diff --git a/t/t4013/diff.log_--decorate=3Dfull_--all b/t/t4013/diff.log_=
--decorate=3Dfull_--all
index c56783b985..3f9b872ece 100644
--- a/t/t4013/diff.log_--decorate=3Dfull_--all
+++ b/t/t4013/diff.log_--decorate=3Dfull_--all
@@ -31,7 +31,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
=20
-    Merge branch 'side' into master
+    Merge branch 'side'
=20
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (refs/heads/side)
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--decorate_--all b/t/t4013/diff.log_--decor=
ate_--all
index 1cbdc038f4..f5e20e1e14 100644
--- a/t/t4013/diff.log_--decorate_--all
+++ b/t/t4013/diff.log_--decorate_--all
@@ -31,7 +31,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
=20
-    Merge branch 'side' into master
+    Merge branch 'side'
=20
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (side)
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_ =
b/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
index f5b1b6516b..a18f1472a9 100644
--- a/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
+++ b/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
=20
-    Merge branch 'side' into master
+    Merge branch 'side'
=20
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--patch-with-stat_master b/t/t4013/diff.log=
_--patch-with-stat_master
index af23803cdc..ae425c4672 100644
--- a/t/t4013/diff.log_--patch-with-stat_master
+++ b/t/t4013/diff.log_--patch-with-stat_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
=20
-    Merge branch 'side' into master
+    Merge branch 'side'
=20
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--patch-with-stat_master_--_dir_ b/t/t4013/=
diff.log_--patch-with-stat_master_--_dir_
index 814098fbf8..d5207cadf4 100644
--- a/t/t4013/diff.log_--patch-with-stat_master_--_dir_
+++ b/t/t4013/diff.log_--patch-with-stat_master_--_dir_
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
=20
-    Merge branch 'side' into master
+    Merge branch 'side'
=20
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_mas=
ter b/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
index b927fe4a98..0fc1e8cd71 100644
--- a/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
=20
-    Merge branch 'side' into master
+    Merge branch 'side'
=20
  dir/sub | 2 ++
  file0   | 3 +++
diff --git a/t/t4013/diff.log_--root_--patch-with-stat_--summary_master b=
/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
index 6db3cea329..dffc09dde9 100644
--- a/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
=20
-    Merge branch 'side' into master
+    Merge branch 'side'
=20
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--root_--patch-with-stat_master b/t/t4013/d=
iff.log_--root_--patch-with-stat_master
index 98e9c320c3..55aa98012d 100644
--- a/t/t4013/diff.log_--root_--patch-with-stat_master
+++ b/t/t4013/diff.log_--root_--patch-with-stat_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
=20
-    Merge branch 'side' into master
+    Merge branch 'side'
=20
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_maste=
r b/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
index b61b1117ae..019d85f7de 100644
--- a/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
=20
-    Merge branch 'side' into master
+    Merge branch 'side'
=20
  dir/sub | 2 ++
  file0   | 3 +++
diff --git a/t/t4013/diff.log_--root_-p_master b/t/t4013/diff.log_--root_=
-p_master
index 345bd9e8a9..b42c334439 100644
--- a/t/t4013/diff.log_--root_-p_master
+++ b/t/t4013/diff.log_--root_-p_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
=20
-    Merge branch 'side' into master
+    Merge branch 'side'
=20
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--root_master b/t/t4013/diff.log_--root_mas=
ter
index db56b1fe6b..e8f46159da 100644
--- a/t/t4013/diff.log_--root_master
+++ b/t/t4013/diff.log_--root_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
=20
-    Merge branch 'side' into master
+    Merge branch 'side'
=20
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_-m_-p_--first-parent_master b/t/t4013/diff.=
log_-m_-p_--first-parent_master
index bcadb50e26..7a0073f529 100644
--- a/t/t4013/diff.log_-m_-p_--first-parent_master
+++ b/t/t4013/diff.log_-m_-p_--first-parent_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
=20
-    Merge branch 'side' into master
+    Merge branch 'side'
=20
 diff --git a/dir/sub b/dir/sub
 index cead32e..992913c 100644
diff --git a/t/t4013/diff.log_-m_-p_master b/t/t4013/diff.log_-m_-p_maste=
r
index 2acf43a9fb..9ca62a01ed 100644
--- a/t/t4013/diff.log_-m_-p_master
+++ b/t/t4013/diff.log_-m_-p_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
=20
-    Merge branch 'side' into master
+    Merge branch 'side'
=20
 diff --git a/dir/sub b/dir/sub
 index cead32e..992913c 100644
@@ -33,7 +33,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
=20
-    Merge branch 'side' into master
+    Merge branch 'side'
=20
 diff --git a/dir/sub b/dir/sub
 index 7289e35..992913c 100644
diff --git a/t/t4013/diff.log_-p_--first-parent_master b/t/t4013/diff.log=
_-p_--first-parent_master
index c6a5876d80..3fc896d424 100644
--- a/t/t4013/diff.log_-p_--first-parent_master
+++ b/t/t4013/diff.log_-p_--first-parent_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
=20
-    Merge branch 'side' into master
+    Merge branch 'side'
=20
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_-p_master b/t/t4013/diff.log_-p_master
index 1841cded94..bf1326dc36 100644
--- a/t/t4013/diff.log_-p_master
+++ b/t/t4013/diff.log_-p_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
=20
-    Merge branch 'side' into master
+    Merge branch 'side'
=20
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_master b/t/t4013/diff.log_master
index f8ec445eb3..a8f6ce5abd 100644
--- a/t/t4013/diff.log_master
+++ b/t/t4013/diff.log_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
=20
-    Merge branch 'side' into master
+    Merge branch 'side'
=20
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.show_--first-parent_master b/t/t4013/diff.show_=
--first-parent_master
index 94548f4598..3dcbe473a0 100644
--- a/t/t4013/diff.show_--first-parent_master
+++ b/t/t4013/diff.show_--first-parent_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
=20
-    Merge branch 'side' into master
+    Merge branch 'side'
=20
 diff --git a/dir/sub b/dir/sub
 index cead32e..992913c 100644
diff --git a/t/t4013/diff.show_-c_master b/t/t4013/diff.show_-c_master
index 1c46ed64fd..81aba8da96 100644
--- a/t/t4013/diff.show_-c_master
+++ b/t/t4013/diff.show_-c_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
=20
-    Merge branch 'side' into master
+    Merge branch 'side'
=20
 diff --combined dir/sub
 index cead32e,7289e35..992913c
diff --git a/t/t4013/diff.show_-m_master b/t/t4013/diff.show_-m_master
index 7559fc22f8..4ea2ee453d 100644
--- a/t/t4013/diff.show_-m_master
+++ b/t/t4013/diff.show_-m_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
=20
-    Merge branch 'side' into master
+    Merge branch 'side'
=20
 diff --git a/dir/sub b/dir/sub
 index cead32e..992913c 100644
@@ -33,7 +33,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
=20
-    Merge branch 'side' into master
+    Merge branch 'side'
=20
 diff --git a/dir/sub b/dir/sub
 index 7289e35..992913c 100644
diff --git a/t/t4013/diff.show_master b/t/t4013/diff.show_master
index 57091c5d90..fb08ce0e46 100644
--- a/t/t4013/diff.show_master
+++ b/t/t4013/diff.show_master
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
=20
-    Merge branch 'side' into master
+    Merge branch 'side'
=20
 diff --cc dir/sub
 index cead32e,7289e35..992913c
diff --git a/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--sum=
mary_master b/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--su=
mmary_master
index 5f13a71bb5..30aae7817b 100644
--- a/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_ma=
ster
+++ b/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_ma=
ster
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
=20
-    Merge branch 'side' into master
+    Merge branch 'side'
=20
  dir/sub | 2 ++
  file0   | 3 +++
diff --git a/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summa=
ry_master b/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summar=
y_master
index 8acb88267b..d1d32bd34c 100644
--- a/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_mast=
er
+++ b/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_mast=
er
@@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
=20
-    Merge branch 'side' into master
+    Merge branch 'side'
=20
  dir/sub | 2 ++
  file0   | 3 +++
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index fd9af658af..a0930599aa 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -483,7 +483,7 @@ test_expect_success 'set up merge history' '
 '
=20
 cat > expect <<\EOF
-*   Merge branch 'side' into master
+*   Merge branch 'side'
 |\
 | * side-2
 | * side-1
@@ -502,7 +502,7 @@ test_expect_success 'log --graph with merge' '
 '
=20
 cat > expect <<\EOF
-| | | *   Merge branch 'side' into master
+| | | *   Merge branch 'side'
 | | | |\
 | | | | * side-2
 | | | | * side-1
@@ -521,7 +521,7 @@ test_expect_success 'log --graph --line-prefix=3D"| |=
 | " with merge' '
 '
=20
 cat > expect.colors <<\EOF
-*   Merge branch 'side' into master
+*   Merge branch 'side'
 <BLUE>|<RESET><CYAN>\<RESET>
 <BLUE>|<RESET> * side-2
 <BLUE>|<RESET> * side-1
@@ -555,7 +555,7 @@ cat > expect <<\EOF
 |\  Merge: A B
 | | Author: A U Thor <author@example.com>
 | |
-| |     Merge branch 'side' into master
+| |     Merge branch 'side'
 | |
 | * commit tags/side-2
 | | Author: A U Thor <author@example.com>
@@ -632,11 +632,11 @@ test_expect_success 'set up more tangled history' '
 '
=20
 cat > expect <<\EOF
-*   Merge tag 'reach' into master
+*   Merge tag 'reach'
 |\
 | \
 |  \
-*-. \   Merge tags 'octopus-a' and 'octopus-b' into master
+*-. \   Merge tags 'octopus-a' and 'octopus-b'
 |\ \ \
 * | | | seventh
 | | * | octopus-b
@@ -646,14 +646,14 @@ cat > expect <<\EOF
 |/ /
 | * reach
 |/
-*   Merge branch 'tangle' into master
+*   Merge branch 'tangle'
 |\
 | *   Merge branch 'side' (early part) into tangle
 | |\
 | * \   Merge branch 'master' (early part) into tangle
 | |\ \
 | * | | tangle-a
-* | | |   Merge branch 'side' into master
+* | | |   Merge branch 'side'
 |\ \ \ \
 | * | | | side-2
 | | |_|/
@@ -735,16 +735,16 @@ test_expect_success 'log.decorate configuration' '
=20
 test_expect_success 'decorate-refs with glob' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach-into-master
-	Merge-tags-octopus-a-and-octopus-b-into-master
+	Merge-tag-reach
+	Merge-tags-octopus-a-and-octopus-b
 	seventh
 	octopus-b (octopus-b)
 	octopus-a (octopus-a)
 	reach
 	EOF
 	cat >expect.no-decorate <<-\EOF &&
-	Merge-tag-reach-into-master
-	Merge-tags-octopus-a-and-octopus-b-into-master
+	Merge-tag-reach
+	Merge-tags-octopus-a-and-octopus-b
 	seventh
 	octopus-b
 	octopus-a
@@ -765,8 +765,8 @@ test_expect_success 'decorate-refs with glob' '
=20
 test_expect_success 'decorate-refs without globs' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach-into-master
-	Merge-tags-octopus-a-and-octopus-b-into-master
+	Merge-tag-reach
+	Merge-tags-octopus-a-and-octopus-b
 	seventh
 	octopus-b
 	octopus-a
@@ -779,8 +779,8 @@ test_expect_success 'decorate-refs without globs' '
=20
 test_expect_success 'multiple decorate-refs' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach-into-master
-	Merge-tags-octopus-a-and-octopus-b-into-master
+	Merge-tag-reach
+	Merge-tags-octopus-a-and-octopus-b
 	seventh
 	octopus-b (octopus-b)
 	octopus-a (octopus-a)
@@ -794,8 +794,8 @@ test_expect_success 'multiple decorate-refs' '
=20
 test_expect_success 'decorate-refs-exclude with glob' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach-into-master (HEAD -> master)
-	Merge-tags-octopus-a-and-octopus-b-into-master
+	Merge-tag-reach (HEAD -> master)
+	Merge-tags-octopus-a-and-octopus-b
 	seventh (tag: seventh)
 	octopus-b (tag: octopus-b)
 	octopus-a (tag: octopus-a)
@@ -811,8 +811,8 @@ test_expect_success 'decorate-refs-exclude with glob'=
 '
=20
 test_expect_success 'decorate-refs-exclude without globs' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach-into-master (HEAD -> master)
-	Merge-tags-octopus-a-and-octopus-b-into-master
+	Merge-tag-reach (HEAD -> master)
+	Merge-tags-octopus-a-and-octopus-b
 	seventh (tag: seventh)
 	octopus-b (tag: octopus-b, octopus-b)
 	octopus-a (tag: octopus-a, octopus-a)
@@ -828,8 +828,8 @@ test_expect_success 'decorate-refs-exclude without gl=
obs' '
=20
 test_expect_success 'multiple decorate-refs-exclude' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach-into-master (HEAD -> master)
-	Merge-tags-octopus-a-and-octopus-b-into-master
+	Merge-tag-reach (HEAD -> master)
+	Merge-tags-octopus-a-and-octopus-b
 	seventh (tag: seventh)
 	octopus-b (tag: octopus-b)
 	octopus-a (tag: octopus-a)
@@ -851,8 +851,8 @@ test_expect_success 'multiple decorate-refs-exclude' =
'
=20
 test_expect_success 'decorate-refs and decorate-refs-exclude' '
 	cat >expect.no-decorate <<-\EOF &&
-	Merge-tag-reach-into-master (master)
-	Merge-tags-octopus-a-and-octopus-b-into-master
+	Merge-tag-reach (master)
+	Merge-tags-octopus-a-and-octopus-b
 	seventh
 	octopus-b
 	octopus-a
@@ -866,8 +866,8 @@ test_expect_success 'decorate-refs and decorate-refs-=
exclude' '
=20
 test_expect_success 'deocrate-refs and log.excludeDecoration' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach-into-master (master)
-	Merge-tags-octopus-a-and-octopus-b-into-master
+	Merge-tag-reach (master)
+	Merge-tags-octopus-a-and-octopus-b
 	seventh
 	octopus-b (octopus-b)
 	octopus-a (octopus-a)
@@ -881,10 +881,10 @@ test_expect_success 'deocrate-refs and log.excludeD=
ecoration' '
=20
 test_expect_success 'decorate-refs-exclude and simplify-by-decoration' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach-into-master (HEAD -> master)
+	Merge-tag-reach (HEAD -> master)
 	reach (tag: reach, reach)
 	seventh (tag: seventh)
-	Merge-branch-tangle-into-master
+	Merge-branch-tangle
 	Merge-branch-side-early-part-into-tangle (tangle)
 	tangle-a (tag: tangle-a)
 	EOF
@@ -1068,7 +1068,7 @@ cat >expect <<\EOF
 |\  Merge: MERGE_PARENTS
 | | Author: A U Thor <author@example.com>
 | |
-| |     Merge branch 'tangle' into master
+| |     Merge branch 'tangle'
 | |
 | *   commit COMMIT_OBJECT_NAME
 | |\  Merge: MERGE_PARENTS
@@ -1102,7 +1102,7 @@ cat >expect <<\EOF
 |\ \ \ \  Merge: MERGE_PARENTS
 | | | | | Author: A U Thor <author@example.com>
 | | | | |
-| | | | |     Merge branch 'side' into master
+| | | | |     Merge branch 'side'
 | | | | |
 | * | | | commit COMMIT_OBJECT_NAME
 | | |_|/  Author: A U Thor <author@example.com>
@@ -1343,7 +1343,7 @@ cat >expect <<\EOF
 *** |\  Merge: MERGE_PARENTS
 *** | | Author: A U Thor <author@example.com>
 *** | |
-*** | |     Merge branch 'tangle' into master
+*** | |     Merge branch 'tangle'
 *** | |
 *** | *   commit COMMIT_OBJECT_NAME
 *** | |\  Merge: MERGE_PARENTS
@@ -1377,7 +1377,7 @@ cat >expect <<\EOF
 *** |\ \ \ \  Merge: MERGE_PARENTS
 *** | | | | | Author: A U Thor <author@example.com>
 *** | | | | |
-*** | | | | |     Merge branch 'side' into master
+*** | | | | |     Merge branch 'side'
 *** | | | | |
 *** | * | | | commit COMMIT_OBJECT_NAME
 *** | | |_|/  Author: A U Thor <author@example.com>
@@ -1540,8 +1540,8 @@ cat >expect <<-\EOF
 * reach
 |
 | A	reach.t
-* Merge branch 'tangle' into master
-*   Merge branch 'side' into master
+* Merge branch 'tangle'
+*   Merge branch 'side'
 |\
 | * side-2
 |
@@ -1562,8 +1562,8 @@ cat >expect <<-\EOF
 * reach
 |
 | reach.t
-* Merge branch 'tangle' into master
-*   Merge branch 'side' into master
+* Merge branch 'tangle'
+*   Merge branch 'side'
 |\
 | * side-2
 |
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 2b3fd498d0..e4c2a6eca4 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -79,7 +79,7 @@ test_expect_success GPG 'set up a signed tag' '
 '
=20
 test_expect_success 'message for merging local branch' '
-	echo "Merge branch ${apos}left${apos} into master" >expected &&
+	echo "Merge branch ${apos}left${apos}" >expected &&
=20
 	git checkout master &&
 	git fetch . left &&
@@ -107,7 +107,7 @@ test_expect_success GPG 'message for merging local ta=
g signed by unknown key' '
 '
=20
 test_expect_success 'message for merging external branch' '
-	echo "Merge branch ${apos}left${apos} of $(pwd) into master" >expected =
&&
+	echo "Merge branch ${apos}left${apos} of $(pwd)" >expected &&
=20
 	git checkout master &&
 	git fetch "$(pwd)" left &&
@@ -118,7 +118,7 @@ test_expect_success 'message for merging external bra=
nch' '
=20
 test_expect_success '[merge] summary/log configuration' '
 	cat >expected <<-EOF &&
-	Merge branch ${apos}left${apos} into master
+	Merge branch ${apos}left${apos}
=20
 	# By Another Author (3) and A U Thor (2)
 	# Via Another Committer
@@ -160,7 +160,7 @@ test_expect_success 'setup FETCH_HEAD' '
=20
 test_expect_success 'merge.log=3D3 limits shortlog length' '
 	cat >expected <<-EOF &&
-	Merge branch ${apos}left${apos} into master
+	Merge branch ${apos}left${apos}
=20
 	# By Another Author (3) and A U Thor (2)
 	# Via Another Committer
@@ -177,7 +177,7 @@ test_expect_success 'merge.log=3D3 limits shortlog le=
ngth' '
=20
 test_expect_success 'merge.log=3D5 shows all 5 commits' '
 	cat >expected <<-EOF &&
-	Merge branch ${apos}left${apos} into master
+	Merge branch ${apos}left${apos}
=20
 	# By Another Author (3) and A U Thor (2)
 	# Via Another Committer
@@ -195,7 +195,7 @@ test_expect_success 'merge.log=3D5 shows all 5 commit=
s' '
=20
 test_expect_success '--log=3D5 with custom comment character' '
 	cat >expected <<-EOF &&
-	Merge branch ${apos}left${apos} into master
+	Merge branch ${apos}left${apos}
=20
 	x By Another Author (3) and A U Thor (2)
 	x Via Another Committer
@@ -212,14 +212,14 @@ test_expect_success '--log=3D5 with custom comment =
character' '
 '
=20
 test_expect_success 'merge.log=3D0 disables shortlog' '
-	echo "Merge branch ${apos}left${apos} into master" >expected &&
+	echo "Merge branch ${apos}left${apos}" >expected &&
 	git -c merge.log=3D0 fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	test_cmp expected actual
 '
=20
 test_expect_success '--log=3D3 limits shortlog length' '
 	cat >expected <<-EOF &&
-	Merge branch ${apos}left${apos} into master
+	Merge branch ${apos}left${apos}
=20
 	# By Another Author (3) and A U Thor (2)
 	# Via Another Committer
@@ -236,7 +236,7 @@ test_expect_success '--log=3D3 limits shortlog length=
' '
=20
 test_expect_success '--log=3D5 shows all 5 commits' '
 	cat >expected <<-EOF &&
-	Merge branch ${apos}left${apos} into master
+	Merge branch ${apos}left${apos}
=20
 	# By Another Author (3) and A U Thor (2)
 	# Via Another Committer
@@ -253,13 +253,13 @@ test_expect_success '--log=3D5 shows all 5 commits'=
 '
 '
=20
 test_expect_success '--no-log disables shortlog' '
-	echo "Merge branch ${apos}left${apos} into master" >expected &&
+	echo "Merge branch ${apos}left${apos}" >expected &&
 	git fmt-merge-msg --no-log <.git/FETCH_HEAD >actual &&
 	test_cmp expected actual
 '
=20
 test_expect_success '--log=3D0 disables shortlog' '
-	echo "Merge branch ${apos}left${apos} into master" >expected &&
+	echo "Merge branch ${apos}left${apos}" >expected &&
 	git fmt-merge-msg --no-log <.git/FETCH_HEAD >actual &&
 	test_cmp expected actual
 '
@@ -300,7 +300,7 @@ test_expect_success 'fmt-merge-msg -m' '
=20
 test_expect_success 'setup: expected shortlog for two branches' '
 	cat >expected <<-EOF
-	Merge branches ${apos}left${apos} and ${apos}right${apos} into master
+	Merge branches ${apos}left${apos} and ${apos}right${apos}
=20
 	# By Another Author (3) and A U Thor (2)
 	# Via Another Committer
@@ -397,7 +397,7 @@ test_expect_success 'merge-msg with nothing to merge'=
 '
=20
 test_expect_success 'merge-msg tag' '
 	cat >expected <<-EOF &&
-	Merge tag ${apos}tag-r3${apos} into master
+	Merge tag ${apos}tag-r3${apos}
=20
 	* tag ${apos}tag-r3${apos}:
 	  Right #3
@@ -418,7 +418,7 @@ test_expect_success 'merge-msg tag' '
=20
 test_expect_success 'merge-msg two tags' '
 	cat >expected <<-EOF &&
-	Merge tags ${apos}tag-r3${apos} and ${apos}tag-l5${apos} into master
+	Merge tags ${apos}tag-r3${apos} and ${apos}tag-l5${apos}
=20
 	* tag ${apos}tag-r3${apos}:
 	  Right #3
@@ -448,7 +448,7 @@ test_expect_success 'merge-msg two tags' '
=20
 test_expect_success 'merge-msg tag and branch' '
 	cat >expected <<-EOF &&
-	Merge branch ${apos}left${apos}, tag ${apos}tag-r3${apos} into master
+	Merge branch ${apos}left${apos}, tag ${apos}tag-r3${apos}
=20
 	* tag ${apos}tag-r3${apos}:
 	  Right #3
@@ -479,7 +479,7 @@ test_expect_success 'merge-msg tag and branch' '
 test_expect_success 'merge-msg lots of commits' '
 	{
 		cat <<-EOF &&
-		Merge branch ${apos}long${apos} into master
+		Merge branch ${apos}long${apos}
=20
 		* long: (35 commits)
 		EOF
@@ -516,7 +516,7 @@ test_expect_success 'merge-msg with "merging" an anno=
tated tag' '
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	{
 		cat <<-\EOF
-		Merge tag '\''annote'\'' into master
+		Merge tag '\''annote'\''
=20
 		An annotated one
=20
@@ -531,7 +531,7 @@ test_expect_success 'merge-msg with "merging" an anno=
tated tag' '
 	git merge --no-commit --no-ff $annote &&
 	{
 		cat <<-EOF
-		Merge tag '\''$annote'\'' into master
+		Merge tag '\''$annote'\''
=20
 		An annotated one
=20
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 1d45f9a4ed..5883a6adc3 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -14,9 +14,9 @@ Testing basic merge operations/option parsing.
     ! [c4] c4
      ! [c5] c5
       ! [c6] c6
-       * [master] Merge commit 'c1' into master
+       * [master] Merge commit 'c1'
 --------
-       - [master] Merge commit 'c1' into master
+       - [master] Merge commit 'c1'
  +     * [c1] commit 1
       +  [c6] c6
      +   [c5] c5
@@ -44,8 +44,8 @@ test_write_lines '1 X' 2 '3 X' 4 '5 X' 6 7 8 '9 X' >res=
ult.1-3-5-9
 test_write_lines 1 2 3 4 5 6 7 8 '9 Z' >result.9z
=20
 create_merge_msgs () {
-	echo "Merge tag 'c2' into master" >msg.1-5 &&
-	echo "Merge tags 'c2' and 'c3' into master" >msg.1-5-9 &&
+	echo "Merge tag 'c2'" >msg.1-5 &&
+	echo "Merge tags 'c2' and 'c3'" >msg.1-5-9 &&
 	{
 		echo "Squashed commit of the following:" &&
 		echo &&
@@ -258,7 +258,7 @@ test_expect_success 'merge c3 with c7 with commit.cle=
anup =3D scissors' '
 	git commit --no-edit -a &&
=20
 	cat >expect <<-\EOF &&
-	Merge tag '"'"'c7'"'"' into master
+	Merge tag '"'"'c7'"'"'
=20
 	# ------------------------ >8 ------------------------
 	# Do not modify or remove the line above.
@@ -808,10 +808,10 @@ test_expect_success 'merge with conflicted --autost=
ash changes' '
 '
=20
 cat >expected.branch <<\EOF
-Merge branch 'c5-branch' (early part) into master
+Merge branch 'c5-branch' (early part)
 EOF
 cat >expected.tag <<\EOF
-Merge commit 'c5~1' into master
+Merge commit 'c5~1'
 EOF
=20
 test_expect_success 'merge early part of c2' '
diff --git a/t/t7608-merge-messages.sh b/t/t7608-merge-messages.sh
index 2af33f195b..8e7e0a5865 100755
--- a/t/t7608-merge-messages.sh
+++ b/t/t7608-merge-messages.sh
@@ -16,7 +16,7 @@ test_expect_success 'merge local branch' '
 	git checkout master &&
 	test_commit master-2 &&
 	git merge local-branch &&
-	check_oneline "Merge branch Qlocal-branchQ into master"
+	check_oneline "Merge branch Qlocal-branchQ"
 '
=20
 test_expect_success 'merge octopus branches' '
@@ -26,7 +26,7 @@ test_expect_success 'merge octopus branches' '
 	test_commit octopus-2 &&
 	git checkout master &&
 	git merge octopus-a octopus-b &&
-	check_oneline "Merge branches Qoctopus-aQ and Qoctopus-bQ into master"
+	check_oneline "Merge branches Qoctopus-aQ and Qoctopus-bQ"
 '
=20
 test_expect_success 'merge tag' '
@@ -35,7 +35,7 @@ test_expect_success 'merge tag' '
 	git checkout master &&
 	test_commit master-3 &&
 	git merge tag-1 &&
-	check_oneline "Merge tag Qtag-1Q into master"
+	check_oneline "Merge tag Qtag-1Q"
 '
=20
 test_expect_success 'ambiguous tag' '
@@ -44,7 +44,7 @@ test_expect_success 'ambiguous tag' '
 	git checkout master &&
 	test_commit master-4 &&
 	git merge ambiguous &&
-	check_oneline "Merge tag QambiguousQ into master"
+	check_oneline "Merge tag QambiguousQ"
 '
=20
 test_expect_success 'remote-tracking branch' '
@@ -54,7 +54,7 @@ test_expect_success 'remote-tracking branch' '
 	git checkout master &&
 	test_commit master-5 &&
 	git merge origin/master &&
-	check_oneline "Merge remote-tracking branch Qorigin/masterQ into master=
"
+	check_oneline "Merge remote-tracking branch Qorigin/masterQ"
 '
=20
 test_done
--=20
2.28.0

