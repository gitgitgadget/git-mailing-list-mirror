Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EDFE1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 16:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeJTAig (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 20:38:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39174 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbeJTAif (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 20:38:35 -0400
Received: by mail-pl1-f193.google.com with SMTP id e67-v6so7104056plb.6
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 09:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanocritical.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gazLDvQpKXOS13ea6nlgUJ1RI/juBdPGXeK7plS8nMg=;
        b=Xhy7ex6rAKahK7VHg04RQz/0+KqGwh/G1I8g8wgkzxR+rgeEwDZl+CyozMrhPikWQL
         LyzuH3a2gyRXaU3tPQ1jJPldZROXXOD7sWvEti1HFox2ytYQl0POanqseyrkyk3XNRS+
         KWv3z3NjxI9re9bu/d+AestD+2Ul9AJYQr/t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gazLDvQpKXOS13ea6nlgUJ1RI/juBdPGXeK7plS8nMg=;
        b=HRtAPf9G4iHFcewP5sYRqIHFR+wGxEs/6a/kuUKoG9c4PbdlNxEFVEDWhP/RhXUcl4
         1JrJn+ASlGSFkrxcTuwlRf27M/H44pyC5PQbGrQBi5gMhBuseSbT8jLdL6aUFw8ZHRIx
         Dp4cuijdcInOYyyTT2cm49JNbUnt7Oyl/li51hOcPm5w/RS+KuvwDFoCnBiD/EqlgHbV
         h1Ye28QI83TXonJBhi7V21BVzNPinB0u9W56dulRJWghzaIgKTzXIbhkFv2MWh89VoGE
         bCgciKlYTnuH7uYAjsI2EoiV9kdW4QDv/uc+SiMdtyxIC8acDL0KXM1/aKbbYk9HTmsa
         b3kg==
X-Gm-Message-State: ABuFfojMIC2XfuYh0nd4bBmp5NELs1r09IsqfeTd7iFTyvF6hH4q+Eos
        TlycuU89ODnFyEf0SjRmVG8Y02HeK+c=
X-Google-Smtp-Source: ACcGV6338vhsKTr0x/YXrbrvaAggoKkSRZqh8NbOkZ487i+AumEkwnXMq6iZx/MHSiQv+Zy+6S0r+Q==
X-Received: by 2002:a17:902:2f41:: with SMTP id s59-v6mr25357998plb.277.1539966705174;
        Fri, 19 Oct 2018 09:31:45 -0700 (PDT)
Received: from localhost (d23-16-56-237.bchsia.telus.net. [23.16.56.237])
        by smtp.gmail.com with ESMTPSA id t26-v6sm33248174pfa.158.2018.10.19.09.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 09:31:44 -0700 (PDT)
Received: by localhost (sSMTP sendmail emulation); Fri, 19 Oct 2018 09:31:42 -0700
From:   "Eric Rannaud" <e@nanocritical.com>
To:     git@vger.kernel.org
Cc:     jeremy.serror@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Eric Rannaud <e@nanocritical.com>
Subject: [PATCH 1/1] fast-import: checkpoint: only write out refs and tags if we changed them
Date:   Fri, 19 Oct 2018 09:31:40 -0700
Message-Id: <2cc54cbb496404909b8600122b2c7e28164476fa.1539965934.git.e@nanocritical.com>
X-Mailer: git-send-email 2.19.1
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
 t/t9300-fast-import.sh | 53 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)


Please let me know what you think of the change itself, before I spend
some quality time bashing out a way to avoid using sleep(1) in the
tests.

Thanks.


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
index 40fe7e49767a..548994dfbeb3 100755
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
@@ -3262,4 +3267,52 @@ test_expect_success PIPE 'V: checkpoint updates tags after tag' '
 	background_import_still_running
 '
 
+test_expect_success PIPE 'V: checkpoint only resets changed branches' '
+	cat >input <<-INPUT_END &&
+	reset refs/heads/V3
+	from refs/heads/U
+
+	checkpoint
+	INPUT_END
+
+	cat >input2 <<-INPUT_END &&
+	reset refs/heads/V4
+	from refs/heads/U
+
+	INPUT_END
+
+	background_import_then_checkpoint "" input input2 &&
+	sleep 1 &&
+	git branch -f V3 refs/heads/V &&
+	sleep 2 &&
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
+	background_import_then_checkpoint "" input input2 &&
+	sleep 1 &&
+	git tag -f Vtag2 refs/heads/V &&
+	sleep 2 &&
+	test "$(git rev-parse --verify Vtag2)" = "$(git rev-parse --verify V)" &&
+	background_import_still_running
+'
+
 test_done
-- 
2.19.1

