Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62C071F453
	for <e@80x24.org>; Fri, 19 Oct 2018 23:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeJTHdY (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 03:33:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44266 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbeJTHdX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 03:33:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id r9-v6so17118014pff.11
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 16:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanocritical.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LUtkiN05eWb41h3rKOxsCbUyBGvUoWVsOPuL2fojoa0=;
        b=NwW9wCkxhXg8ejN52uYOmBcwAWEUUdRw7RztznGgPQWtTZDABemXb51uN3trabn0Uy
         93Y53+9ezIc8gnnAMHQG5uHQAO9NCj/OPZAAFT7VZ6LKpYnDzFMNDi55ghA4MFWUQj2Y
         fY3FRsRylOLufyCTcmKMjr5suBrJqhM/CmUfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LUtkiN05eWb41h3rKOxsCbUyBGvUoWVsOPuL2fojoa0=;
        b=SybOT/Y4h1WMQop1MlojnVobHVaRrhuK35BXJTgxSj4X31lP61WB98EbsQ+K4CO282
         gZkGzODUKC0hAzGmOB8CjOf9oJxfoJkEHF/2XGT3uIvkBqayKrfBsQ5dAURpc4mxO4ZP
         yY8+kkWyN3Elw+UnwLYJO8ELX9WE2jMA2W7JPBjiPOjK/ljr8RchSLVyR0l7lVc8f6B/
         2CNr2B5YrrMsO4S8dDztTbUf5lwAID0dT+qdYBd+QWu4ZaK3+7fkRi/aGuHbZWVEmUly
         NhL8SfK0Ye6zzI8hPyOGsokFRc1Y5DjcZpFcwSHjiBR5cqMjLoisqonejcZU+w6C+fzI
         LQZA==
X-Gm-Message-State: ABuFfogCsCrM6NQssIEjT415Szv+4a8UiLAEb10pVJG7W1TPQQa/Ondi
        19xPmVLgpE+qXiQZ8G6HP+2FkvwjNc4=
X-Google-Smtp-Source: ACcGV611SB+XJgfQW/XdEAFbZBw03QuC6b5aqmy7YB5NKT3LOGNQGRp/xFAvn+9B//LZIJPaNcNGCA==
X-Received: by 2002:a63:a357:: with SMTP id v23-v6mr13088594pgn.39.1539991513323;
        Fri, 19 Oct 2018 16:25:13 -0700 (PDT)
Received: from localhost (d23-16-56-237.bchsia.telus.net. [23.16.56.237])
        by smtp.gmail.com with ESMTPSA id j5-v6sm29258086pgm.79.2018.10.19.16.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 16:25:12 -0700 (PDT)
Received: by localhost (sSMTP sendmail emulation); Fri, 19 Oct 2018 16:25:10 -0700
From:   "Eric Rannaud" <e@nanocritical.com>
To:     git@vger.kernel.org
Cc:     jeremy.serror@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Eric Rannaud <e@nanocritical.com>
Subject: [PATCH 1/1] fast-import: checkpoint: only write out refs and tags if we changed them
Date:   Fri, 19 Oct 2018 16:25:08 -0700
Message-Id: <b3b6b36debe9190e31c70e8fe6d623fd1ba1266b.1539991203.git.e@nanocritical.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <2cc54cbb496404909b8600122b2c7e28164476fa.1539965934.git.e@nanocritical.com>
References: <2cc54cbb496404909b8600122b2c7e28164476fa.1539965934.git.e@nanocritical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At a checkpoint, fast-import resets all branches and tags on disk to the
OID that we have in memory. If --force is not given, only branch resets
that result in fast forwards with respect to the state on disk are
allowed.

With this approach, even for refs that fast-import has not been
commanded to change for a long time (or ever), at each checkpoint, we
will systematically reset them to the last state this process knows
about, a state which may have been set before the previous checkpoint.
Any changes made to these refs by a different process since the last
checkpoint will be overwritten.

1> is one process, 2> is another:

	1> $ git fast-import --force
	1> reset refs/heads/master
	1> from $A
	1> checkpoint
	2> $ git branch -f refs/heads/master $B
	1> reset refs/heads/tip
	1> from $C
	1> checkpoint

At this point master points again to $A.

This problem is mitigated somewhat for branches when --force is not
specified (the default), as requiring a fast forward means in practice
that concurrent external changes are likely to be preserved. But it's
not foolproof either:

	1> $ git fast-import
	1> reset refs/heads/master
	1> from $A
	1> checkpoint
	2> $ git branch -f refs/heads/master refs/heads/master~1
	1> reset refs/heads/tip
	1> from $C
	1> checkpoint

At this point, master points again to $A, not $A~1 as requested by the
second process.

We now keep track of whether branches and tags have been changed by this
fast-import process since our last checkpoint (or startup). At the next
checkpoint, only refs and tags that new commands have changed are
written to disk.
---
 fast-import.c          | 14 +++++++++++
 t/t9300-fast-import.sh | 55 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)


Changed since v1:

The testcases failed to enforce the new behavior.

- t9300: Fixed tests to properly interleave operations between the
  fast-import in the background and the concurrent "git branch" and "git
  tag" command.

  I misremembered how background_import_then_checkpoint() works: it
  return only after the whole set of commands provided in input_file
  (and now input_file2) are run by fast-import.

  In v2, the competing git commands are started first in the background
  and are run after a delay of 1 second. input_file is sent right away
  to fast-import, followed 2 seconds later by input_file2. That is:

    second 0: input_file
    second 1: git branch or git tag command
    second 2: input_file2

- t9300: Use --force for the branch testcase: without it, earlier
  versions of Git don't fail this testcase (as resetting V3 to U is not
  a FF, so the second checkpoint skips updating it in earlier versions
  of Git, failing to demonstrate the problematic behavior).

Checked that the new testcases do fail with earlier versions of Git.

TODO: The testcases still rely on sleep(1).


diff --git a/fast-import.c b/fast-import.c
index 95600c78e048..d25be5c83110 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -250,6 +250,7 @@ struct branch {
 	uintmax_t num_notes;
 	unsigned active : 1;
 	unsigned delete : 1;
+	unsigned changed : 1;
 	unsigned pack_id : PACK_ID_BITS;
 	struct object_id oid;
 };
@@ -257,6 +258,7 @@ struct branch {
 struct tag {
 	struct tag *next_tag;
 	const char *name;
+	unsigned changed : 1;
 	unsigned int pack_id;
 	struct object_id oid;
 };
@@ -728,6 +730,7 @@ static struct branch *new_branch(const char *name)
 	b->branch_tree.versions[1].mode = S_IFDIR;
 	b->num_notes = 0;
 	b->active = 0;
+	b->changed = 0;
 	b->pack_id = MAX_PACK_ID;
 	branch_table[hc] = b;
 	branch_count++;
@@ -1715,6 +1718,10 @@ static int update_branch(struct branch *b)
 	struct object_id old_oid;
 	struct strbuf err = STRBUF_INIT;
 
+	if (!b->changed)
+		return 0;
+	b->changed = 0;
+
 	if (is_null_oid(&b->oid)) {
 		if (b->delete)
 			delete_ref(NULL, b->name, NULL, 0);
@@ -1780,6 +1787,10 @@ static void dump_tags(void)
 		goto cleanup;
 	}
 	for (t = first_tag; t; t = t->next_tag) {
+		if (!t->changed)
+			continue;
+		t->changed = 0;
+
 		strbuf_reset(&ref_name);
 		strbuf_addf(&ref_name, "refs/tags/%s", t->name);
 
@@ -2813,6 +2824,7 @@ static void parse_new_commit(const char *arg)
 
 	if (!store_object(OBJ_COMMIT, &new_data, NULL, &b->oid, next_mark))
 		b->pack_id = pack_id;
+	b->changed = 1;
 	b->last_commit = object_count_by_type[OBJ_COMMIT];
 }
 
@@ -2894,6 +2906,7 @@ static void parse_new_tag(const char *arg)
 		t->pack_id = MAX_PACK_ID;
 	else
 		t->pack_id = pack_id;
+	t->changed = 1;
 }
 
 static void parse_reset_branch(const char *arg)
@@ -2914,6 +2927,7 @@ static void parse_reset_branch(const char *arg)
 		b = new_branch(arg);
 	read_next_command();
 	parse_from(b);
+	b->changed = 1;
 	if (command_buf.len > 0)
 		unread_command_buf = 1;
 }
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 40fe7e49767a..92e8c3d54112 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3123,6 +3123,9 @@ test_expect_success 'U: validate root delete result' '
 
 # The commands in input_file should not produce any output on the file
 # descriptor set with --cat-blob-fd (or stdout if unspecified).
+# 
+# If input_file2 is specified, sleep 2 seconds before writing it to fast-import
+# stdin.
 #
 # To make sure you're observing the side effects of checkpoint *before*
 # fast-import terminates (and thus writes out its state), check that the
@@ -3131,6 +3134,7 @@ test_expect_success 'U: validate root delete result' '
 background_import_then_checkpoint () {
 	options=$1
 	input_file=$2
+	input_file2=$3
 
 	mkfifo V.input
 	exec 8<>V.input
@@ -3155,6 +3159,7 @@ background_import_then_checkpoint () {
 	# because there is no reader on &9 yet.
 	(
 		cat "$input_file"
+		[ -n "$input_file2" ] && sleep 2 && cat "$input_file2"
 		echo "checkpoint"
 		echo "progress checkpoint"
 	) >&8 &
@@ -3262,4 +3267,54 @@ test_expect_success PIPE 'V: checkpoint updates tags after tag' '
 	background_import_still_running
 '
 
+background_delayed () {
+	(sleep 1 && exec "$@") &
+}
+
+test_expect_success PIPE 'V: checkpoint only resets changed branches' '
+	cat >input <<-INPUT_END &&
+	reset refs/heads/V3
+	from refs/heads/U
+
+	checkpoint
+
+	INPUT_END
+
+	cat >input2 <<-INPUT_END &&
+	reset refs/heads/V4
+	from refs/heads/U
+
+	INPUT_END
+
+	background_delayed git branch -f V3 V &&
+	background_import_then_checkpoint "--force" input input2 &&
+	test "$(git rev-parse --verify V3)" = "$(git rev-parse --verify V)" &&
+	background_import_still_running
+'
+
+test_expect_success PIPE 'V: checkpoint only updates changed tags' '
+	cat >input <<-INPUT_END &&
+	tag Vtag2
+	from refs/heads/U
+	tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 0
+
+	checkpoint
+
+	INPUT_END
+
+	cat >input2 <<-INPUT_END &&
+	tag Vtag3
+	from refs/heads/U
+	tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 0
+
+	INPUT_END
+
+	background_delayed git tag -f Vtag2 V &&
+	background_import_then_checkpoint "" input input2 &&
+	test "$(git show-ref -d Vtag2 |tail -1 |awk \{print\ \$1\})" = "$(git rev-parse --verify V)" &&
+	background_import_still_running
+'
+
 test_done
-- 
2.19.1

