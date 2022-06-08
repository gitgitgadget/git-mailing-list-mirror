Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D60C433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 21:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbiFHVFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 17:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiFHVFn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 17:05:43 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9083B227192
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 14:05:41 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id u67-20020a627946000000b0051b9c1256b0so11361836pfc.9
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 14:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1q2TDbMQLPRwDN8hBWOkbg2/2jb6LVgZmwfg6gMmSZo=;
        b=LsjP+T+9DpHSdbZ7WL10qOrVCnZneRXMxvhHvBg8ofOvjGB6tplSqocFVCI2tG8ixb
         iZfdrDSeSvQ6Y5TC7BxTrD3wOD7qntjvsP3VtYA00V8LDpfUPQiTQQsGqeHn/mW3yfTN
         5bfJe0jAmcMCv6OX5h5ghix2oUiNSwunwAhDqJhdpOSNHsvGdEcGypToerq+Q1R6xCVa
         mT3wd6UAAZb76QLFdvqA9Ud+6v2+6gYDknjNLvvteYjzwYtxSKMYugH352Hh0q4b2aVt
         ZxnzH1pcpHHwi/skq+EbCn6k5YrTqE9ytDcI2mBRv2uTqR+5cF62JZtIZRbNAOpNLxcg
         OMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1q2TDbMQLPRwDN8hBWOkbg2/2jb6LVgZmwfg6gMmSZo=;
        b=bUbmOLEV9u6HFfQytNfHM3hkoCpwEYloNDlaDMZt5p1tW2tHXmTjFZUfqUJREIV+Br
         JDFslHD81XXyGsV4PZAcoD3JIpyzrWFOmvvf5j5wSmJelTfexn6zZhjRev8hwF8Mdz+M
         Ja2k4lJ7wFdVq2OstHkFfnhxaWA9aouNvNo4JV5zXnC9X7wt1ugvWls5QTH1brqi0KzW
         2JBFcf892OUl3vpYvOQoKPAT+B3lZey9eQ6vamBXHRpgJfcVBrhqtR/v7fKjn0vUIaZT
         tcCGlwXwJf6cRYZN9S77jdC9adWlsjkpA+vgxsGahsAeT/pQsJ7sEYUamMjCiW9JrkVO
         ni7g==
X-Gm-Message-State: AOAM532c0i9Dvvn5veHEwTMzdg3HvNPynbyC1o4bs8IIPXVKvL44rUa6
        psX+lf1ndohZ+XVhMmVA+G25nwr8ZiUdGqmKhSwp4SSSZi6ZoS7Adi3zAX/QGgxNbzT816jvPaN
        bfjt3Y060bS7Z0uHRBVYbJwVKhj5GjzTwuAWS3ZvN/aAQy5RVEX5IjCjLOKoS/179HQx+lUzTVY
        NS
X-Google-Smtp-Source: ABdhPJxIBAff+V34fOzcH3WuW7DWNXeiOvWP7EfQKJL3GFZdh8tHp8U2343luIAkobnVKXJfAwVMBmyFgRqoaVN94oh5
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:758a:b0:15e:ef4f:fed5 with
 SMTP id j10-20020a170902758a00b0015eef4ffed5mr35995844pll.1.1654722340868;
 Wed, 08 Jun 2022 14:05:40 -0700 (PDT)
Date:   Wed,  8 Jun 2022 14:05:37 -0700
Message-Id: <20220608210537.185094-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH] connected: distinguish local/remote bad objects
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the connectivity check after a fetch fails, an error message
"<remote> did not send all necessary objects" is printed. That error
message is printed regardless of the reason of failure: in particular,
that message may be printed if the connectivity check fails because a
local object is missing. (The connectivity check reads local objects too
because it compares the set of objects that the remote claims to send
against the set of objects that our refs directly or indirectly
reference.)

The connectivity check passes, to "git rev-list", remote objects
directly and local objects through "--not". And internally, the latter
are marked with the UNINTERESTING flag. When reading a commit during the
commit walk, we know whether the commit came from an UNINTERESTING
commit or not. Therefore, use this flag to produce a clearer error
message when a bad object is read.

This necessitates changes in revision.c which is used by components
other than the connectivity check and may have different meanings for
objects passe with and without "--not", so guard the extra diagnostics
behind a CLI argument.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
We noticed, at $DAYJOB, some of these messages that were likely caused
by missing objects in the local repository instead, so here is a patch
that will make it easier to diagnose such issues.
---
 builtin/fetch.c              |  2 +-
 connected.c                  |  1 +
 revision.c                   | 16 ++++++++++++--
 revision.h                   |  3 +++
 t/t5518-fetch-exit-status.sh | 43 ++++++++++++++++++++++++++++++++++++
 5 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ac29c2b1ae..6f43b2bf8d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1133,7 +1133,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 
 		rm = ref_map;
 		if (check_connected(iterate_ref_map, &rm, &opt)) {
-			rc = error(_("%s did not send all necessary objects\n"), url);
+			rc = error(_("connectivity check failed for %s\n"), url);
 			goto abort;
 		}
 	}
diff --git a/connected.c b/connected.c
index ed3025e7a2..ea773f25db 100644
--- a/connected.c
+++ b/connected.c
@@ -94,6 +94,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		strvec_push(&rev_list.args, opt->shallow_file);
 	}
 	strvec_push(&rev_list.args,"rev-list");
+	strvec_push(&rev_list.args, "--detailed-bad-object");
 	strvec_push(&rev_list.args, "--objects");
 	strvec_push(&rev_list.args, "--stdin");
 	if (has_promisor_remote())
diff --git a/revision.c b/revision.c
index 090a967bf4..777e762373 100644
--- a/revision.c
+++ b/revision.c
@@ -367,6 +367,16 @@ void add_head_to_pending(struct rev_info *revs)
 	add_pending_object(revs, obj, "HEAD");
 }
 
+static void NORETURN bad_object(struct rev_info *revs, const char *name,
+				unsigned int flags)
+{
+	if (!revs->detailed_bad_object)
+		die("bad object %s", name);
+	if (flags & UNINTERESTING)
+		die("bad object %s (from local object store)", name);
+	die("bad object %s (from remote)", name);
+}
+
 static struct object *get_reference(struct rev_info *revs, const char *name,
 				    const struct object_id *oid,
 				    unsigned int flags)
@@ -390,7 +400,7 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 			return object;
 		if (revs->exclude_promisor_objects && is_promisor_object(oid))
 			return NULL;
-		die("bad object %s", name);
+		bad_object(revs, name, flags);
 	}
 	object->flags |= flags;
 	return object;
@@ -426,7 +436,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 			if (revs->exclude_promisor_objects &&
 			    is_promisor_object(&tag->tagged->oid))
 				return NULL;
-			die("bad object %s", oid_to_hex(&tag->tagged->oid));
+			bad_object(revs, oid_to_hex(&tag->tagged->oid), flags);
 		}
 		object->flags |= flags;
 		/*
@@ -2537,6 +2547,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		if (fetch_if_missing)
 			BUG("exclude_promisor_objects can only be used when fetch_if_missing is 0");
 		revs->exclude_promisor_objects = 1;
+	} else if (!strcmp(arg, "--detailed-bad-object")) {
+		revs->detailed_bad_object = 1;
 	} else {
 		int opts = diff_opt_parse(&revs->diffopt, argv, argc, revs->prefix);
 		if (!opts)
diff --git a/revision.h b/revision.h
index e80c148b19..7f685dd5bb 100644
--- a/revision.h
+++ b/revision.h
@@ -328,6 +328,9 @@ struct rev_info {
 
 	/* Location where temporary objects for remerge-diff are written. */
 	struct tmp_objdir *remerge_objdir;
+
+	/* Error reporting info */
+	unsigned detailed_bad_object : 1;
 };
 
 int ref_excluded(struct string_list *, const char *path);
diff --git a/t/t5518-fetch-exit-status.sh b/t/t5518-fetch-exit-status.sh
index 5c4ac2556e..f1adac1dd6 100755
--- a/t/t5518-fetch-exit-status.sh
+++ b/t/t5518-fetch-exit-status.sh
@@ -37,4 +37,47 @@ test_expect_success 'forced update' '
 
 '
 
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'connectivity check failure due to missing local object' '
+	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
+	test_when_finished "rm -rf \"$SERVER\" client" &&
+	test_create_repo "$SERVER" &&
+	test_commit -C "$SERVER" foo &&
+
+	test_create_repo client &&
+	test_commit -C client bar &&
+
+	# Simulate missing client objects.
+	rm -rf client/.git/objects/* &&
+	test_must_fail git -C client fetch $HTTPD_URL/smart/server 2>err &&
+	grep "(from local object store)" err &&
+	! grep "(from remote)" err &&
+	grep "error: connectivity check failed for" err
+'
+
+test_expect_success 'connectivity check failure due to missing remote object' '
+	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
+	test_when_finished "rm -rf \"$SERVER\" client" &&
+	test_create_repo "$SERVER" &&
+	test_commit -C "$SERVER" foo &&
+	git -C "$SERVER" config uploadpack.allowRefInWant true &&
+	SERVER_HEAD=$(git -C "$SERVER" rev-parse HEAD) &&
+	SERVER_FAKE_HEAD=$(echo $SERVER_HEAD | tr "0123456789abcdef" "123456789abcdef0") &&
+
+	test_create_repo client &&
+
+	# Make the server claim that it has $SERVER_FAKE_HEAD as
+	# refs/heads/main. The server still sends $SERVER_HEAD in the packfile,
+	# so the client will see $SERVER_FAKE_HEAD as missing.
+	echo "s=$SERVER_HEAD refs/heads/main=$SERVER_FAKE_HEAD refs/heads/main= if /wanted-refs/../packfile/" >"$HTTPD_ROOT_PATH/one-time-perl" &&
+
+	test_must_fail git -C client fetch $HTTPD_URL/one_time_perl/server refs/heads/main 2>err &&
+	grep "(from remote)" err &&
+	! grep "(from local object store)" err &&
+	grep "error: connectivity check failed for" err
+'
+
 test_done
+
-- 
2.36.1.255.ge46751e96f-goog

