From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 6/8] cherry-pick: add support to copy notes
Date: Tue, 28 May 2013 22:56:26 -0500
Message-ID: <1369799788-24803-7-git-send-email-felipe.contreras@gmail.com>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 05:58:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhXX3-00035O-VS
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 05:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934989Ab3E2D6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 23:58:30 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:60642 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934810Ab3E2D63 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 23:58:29 -0400
Received: by mail-oa0-f52.google.com with SMTP id h1so10799321oag.39
        for <git@vger.kernel.org>; Tue, 28 May 2013 20:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Niwu2St5gjYDf/3zow4KCl+tnZzJN2ZYM0PoJU9v80E=;
        b=mlzpZNT4/AT0mnuQxQWJXqACs8aP01PYJFy6TFlD8jcUAXl+hseWnMSDraAipI50C3
         zer4uNwtpU8/8FP8HrcPXy9eGjl1I5OirRhSKYKjHe3eRwWtnWAocNNh+YczNXiI3DqQ
         pRxwKeIv1RPJYWpJnC00FV5ZjSYN/xTh6QHMDuLQXkx5SRaWjn3IPPT7lrfcCbm9SBcX
         /Lbx47eyW6wAC8vFxQy/iin32TT1gS9TSLVlpMth5ql8ytsHGBBpIFhoeBmHVvbs7goc
         muiH8Fimw+d/JIi644Pq6uim3raoAXyy1lG7QXE4occdJUYmd0UiMIBCcQxjn2ZOF8Bv
         PoCA==
X-Received: by 10.60.65.38 with SMTP id u6mr506020oes.52.1369799906523;
        Tue, 28 May 2013 20:58:26 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id h4sm39274282oel.2.2013.05.28.20.58.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 20:58:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225720>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/revert.c  |  2 ++
 sequencer.c       | 33 ++++++++++++++++++++++++++++++++-
 sequencer.h       |  1 +
 t/t3500-cherry.sh | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 0e5ce71..b977124 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -119,6 +119,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
+		OPT_END(),
 	};
 
 	if (opts->action == REPLAY_PICK) {
@@ -129,6 +130,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 			OPT_BOOLEAN(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
 			OPT_BOOLEAN(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
 			OPT_BOOLEAN(0, "skip-empty", &opts->skip_empty, N_("skip empty commits")),
+			OPT_BOOLEAN(0, "copy-notes", &opts->copy_notes, N_("copy notes")),
 			OPT_END(),
 		};
 		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
diff --git a/sequencer.c b/sequencer.c
index 3aa480e..cc9c2bc 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -127,6 +127,27 @@ static void add_rewritten(unsigned char *from, unsigned char *to)
 	rewritten.nr++;
 }
 
+static void copy_notes(void)
+{
+	unsigned char note_commit[20];
+	struct strbuf buf = STRBUF_INIT;
+	struct notes_tree *t = &default_notes_tree;
+	int i;
+
+	init_notes(t, NULL, NULL, 0);
+
+	for (i = 0; i < rewritten.nr; i++) {
+		struct rewritten_list_item *item = &rewritten.items[i];
+		copy_note(t, item->from, item->to, 0, NULL);
+	}
+
+	strbuf_addstr(&buf, "Notes added by 'git cherry-pick'\n");
+	create_notes_commit(&default_notes_tree, NULL, &buf, note_commit);
+	strbuf_insert(&buf, 0, "notes: ", 7);
+	update_ref(buf.buf, t->ref, note_commit, NULL, 0, MSG_ON_ERR);
+	strbuf_release(&buf);
+}
+
 static void run_rewrite_hook(void)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -908,7 +929,10 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 	else if (!strcmp(key, "options.strategy-option")) {
 		ALLOC_GROW(opts->xopts, opts->xopts_nr + 1, opts->xopts_alloc);
 		opts->xopts[opts->xopts_nr++] = xstrdup(value);
-	} else
+	}
+	else if (!strcmp(key, "options.copy-notes"))
+		opts->copy_notes = git_config_bool_or_int(key, value, &error_flag);
+	else
 		return error(_("Invalid key: %s"), key);
 
 	if (!error_flag)
@@ -1108,6 +1132,8 @@ static void save_opts(struct replay_opts *opts)
 							"options.strategy-option",
 							opts->xopts[i], "^$", 0);
 	}
+	if (opts->copy_notes)
+		git_config_set_in_file(opts_file, "options.copy-notes", "true");
 }
 
 static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
@@ -1132,6 +1158,9 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 
 	run_rewrite_hook();
 
+	if (opts->copy_notes)
+		copy_notes();
+
 	/*
 	 * Sequence of picks finished successfully; cleanup by
 	 * removing the .git/sequencer directory
@@ -1186,6 +1215,8 @@ static int single_pick(struct commit *cmit, struct replay_opts *opts)
 	if (ret)
 		return ret;
 	run_rewrite_hook();
+	if (opts->copy_notes)
+		copy_notes();
 	return 0;
 }
 
diff --git a/sequencer.h b/sequencer.h
index 84b9957..6cc072c 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -36,6 +36,7 @@ struct replay_opts {
 	int allow_empty_message;
 	int keep_redundant_commits;
 	int skip_empty;
+	int copy_notes;
 
 	int mainline;
 
diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
index f038f34..79c1219 100755
--- a/t/t3500-cherry.sh
+++ b/t/t3500-cherry.sh
@@ -55,4 +55,36 @@ test_expect_success \
      expr "$(echo $(git cherry master my-topic-branch) )" : "+ [^ ]* - .*"
 '
 
+test_expect_success \
+    'copy notes' \
+    'git checkout master &&
+    echo notes > C &&
+    test_tick &&
+    git commit -a -m "Update C" &&
+    git notes add -m "a note" &&
+    git checkout -b note-test HEAD^ &&
+    git cherry-pick --copy-notes -x master &&
+    test "a note" = "$(git notes show HEAD)"
+'
+
+test_expect_success \
+    'copy multiple notes' \
+    'git checkout master &&
+    echo "multiple notes" > C &&
+    git commit -a -m "Update C again" &&
+    git notes add -m "another note" &&
+    git commit -a -m "Empty" --allow-empty &&
+    echo "more notes" > C &&
+    git commit -a -m "Update C once more" &&
+    git notes add -m "final note" &&
+    git checkout note-test &&
+    git reset --hard master~3 &&
+    test_expect_code 1 git cherry-pick --copy-notes -x HEAD..master &&
+    git reset --hard &&
+    git cherry-pick --continue
+    test "a note" = "$(git notes show HEAD~2)" &&
+    test "another note" = "$(git notes show HEAD~1)" &&
+    test "final note" = "$(git notes show HEAD)"
+'
+
 test_done
-- 
1.8.3.rc3.312.g47657de
