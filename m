Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 991D1211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 21:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeLEVoG (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 16:44:06 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:35843 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeLEVoG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 16:44:06 -0500
Received: by mail-pg1-f201.google.com with SMTP id 143so12001659pgc.3
        for <git@vger.kernel.org>; Wed, 05 Dec 2018 13:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Fizo9dNFh683vfWkWN0iRTUjmbOh/2vF8/UFDvWYgfQ=;
        b=M+wMDBBpVk5nd0JMrDiOCU+MIZ5W7C0FzXqtZ7lCqfJauscXycQpNd2fUhpwoltk/X
         FNsWnUv2OcjlMQ9WydgJJmJ3OJRIvea5e+JB+ittbsptEuPpfWoSrWVzWDeL/YeLigGP
         Beep5A3Qe8Y+Xfc2sBiXzyHY09UY5cftQL2cThMzdVtrnNoKaKa4i0d++DmMp36JyAGx
         wZSaFZWysrJWsknaei1L7oxk/0XNyqKhuJDtlCvcmdV4lJFafF/g+9k3+I7ZY+Lf5k+A
         iTtTWIRwikXaET0CkhJJuyGiDP9rIQ53AzZKddqHWkwwknmwaRSo1M/7BY5NIz/+ZeFK
         W5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Fizo9dNFh683vfWkWN0iRTUjmbOh/2vF8/UFDvWYgfQ=;
        b=sVJIXXhjlzk06iVthYyg/Tf1/vqNyuOqOLcIh5ds/+lHaIogNJrbhlxoM3p1FF7MSN
         bDSgpyifJNGkjAoB5Bv2rRtXZxIL3BgpPX+hN4AR5sE3UShzjwCtaoxnXzzEEooYzy2J
         ThAAY0qRqvIw9b3jBV4E6CazBxyHDliRDo7PIqQD/ddaGntpTqWeI4ssKbFG7dffoysP
         lM6hAVeideD8QBdrT+JJ84ONODcXMoAqXcTupd+BybKcQEgSLpwa/PDF6yuY1BcXG78A
         UmMCLZYQyq41A+BbwdM/VaTjStngDZQxLqq0Z7KRdG2cvKHL+cJSgZnw0fclzsZTFQ/K
         p0Bw==
X-Gm-Message-State: AA+aEWY0eKFgdzdASLb9qgugFCNiLz1KlQuvjj/Xw3tPHR+9M9a+yXyS
        DdfVd8ZRn+rfVPg1oY544PiLGMIKwLLr8vqdt4+YEDpllKxr9iByf13Z23zREbDeoPXq6H4GExK
        uSDBywTDPzItdJstmPoqdBkObTogKTeBJBbwoe3UNBJtqTXMVnM4L1PgvNRg=
X-Google-Smtp-Source: AFSGD/VhMMq/HXE0s5/q4xiXwkSK21GoQJ6MqC6iH7RpbXJCjfLIPf5ktpB0Y2lrIq+qiMG6DZjsXsxuCxnu
X-Received: by 2002:a62:e210:: with SMTP id a16mr12632616pfi.63.1544046245435;
 Wed, 05 Dec 2018 13:44:05 -0800 (PST)
Date:   Wed,  5 Dec 2018 13:43:46 -0800
In-Reply-To: <20181023215745.245333-1-matvore@google.com>
Message-Id: <20181205214346.106217-1-matvore@google.com>
Mime-Version: 1.0
References: <20181023215745.245333-1-matvore@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
Subject: [PATCH v3] list-objects.c: don't segfault for missing cmdline objects
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, gitster@pobox.com,
        jonathantanmy@google.com, jeffhost@microsoft.com,
        ramsay@ramsayjones.plus.com, matvore@comcast.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a command is invoked with both --exclude-promisor-objects,
--objects-edge-aggressive, and a missing object on the command line,
the rev_info.cmdline array could get a NULL pointer for the value of
an 'item' field. Prevent dereferencing of a NULL pointer in that
situation.

Properly handle --ignore-missing. If it is not passed, die when an
object is missing. Otherwise, just silently ignore it.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 revision.c               |  2 ++
 t/t0410-partial-clone.sh | 16 ++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 13e0519c02..293303b67d 100644
--- a/revision.c
+++ b/revision.c
@@ -1729,6 +1729,8 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 	if (!cant_be_filename)
 		verify_non_filename(revs->prefix, arg);
 	object = get_reference(revs, arg, &oid, flags ^ local_flags);
+	if (!object)
+		return revs->ignore_missing ? 0 : -1;
 	add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local_flags);
 	add_pending_object_with_path(revs, object, arg, oc.mode, oc.path);
 	free(oc.path);
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index ba3887f178..169f7f10a7 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -349,7 +349,7 @@ test_expect_success 'rev-list stops traversal at promisor commit, tree, and blob
 	grep $(git -C repo rev-parse bar) out  # sanity check that some walking was done
 '
 
-test_expect_success 'rev-list accepts missing and promised objects on command line' '
+test_expect_success 'rev-list dies for missing objects on cmd line' '
 	rm -rf repo &&
 	test_create_repo repo &&
 	test_commit -C repo foo &&
@@ -366,7 +366,19 @@ test_expect_success 'rev-list accepts missing and promised objects on command li
 
 	git -C repo config core.repositoryformatversion 1 &&
 	git -C repo config extensions.partialclone "arbitrary string" &&
-	git -C repo rev-list --exclude-promisor-objects --objects "$COMMIT" "$TREE" "$BLOB"
+
+	for OBJ in "$COMMIT" "$TREE" "$BLOB"; do
+		test_must_fail git -C repo rev-list --objects \
+			--exclude-promisor-objects "$OBJ" &&
+		test_must_fail git -C repo rev-list --objects-edge-aggressive \
+			--exclude-promisor-objects "$OBJ" &&
+
+		# Do not die or crash when --ignore-missing is passed.
+		git -C repo rev-list --ignore-missing --objects \
+			--exclude-promisor-objects "$OBJ" &&
+		git -C repo rev-list --ignore-missing --objects-edge-aggressive \
+			--exclude-promisor-objects "$OBJ"
+	done
 '
 
 test_expect_success 'gc repacks promisor objects separately from non-promisor objects' '
-- 
2.20.0.rc1.387.gf8505762e3-goog

