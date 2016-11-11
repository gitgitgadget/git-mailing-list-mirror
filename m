Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21F652035F
	for <e@80x24.org>; Fri, 11 Nov 2016 17:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934939AbcKKRXz (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 12:23:55 -0500
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:49451 "EHLO
        homiemail-a19.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934006AbcKKRXz (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 11 Nov 2016 12:23:55 -0500
Received: from homiemail-a19.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a19.g.dreamhost.com (Postfix) with ESMTP id 2CD8460407C;
        Fri, 11 Nov 2016 09:23:54 -0800 (PST)
Received: from localhost.localdomain (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a19.g.dreamhost.com (Postfix) with ESMTPSA id B9374604076;
        Fri, 11 Nov 2016 09:23:53 -0800 (PST)
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org, spearce@spearce.org
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH v2] upload-pack: Optionally allow fetching any sha1
Date:   Fri, 11 Nov 2016 12:23:48 -0500
Message-Id: <1478885028-30357-1-git-send-email-dturner@twosigma.com>
X-Mailer: git-send-email 2.8.0.rc4.22.g8ae061a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems a little silly to do a reachabilty check in the case where we
trust the user to access absolutely everything in the repository.

Also, it's racy in a distributed system -- perhaps one server
advertises a ref, but another has since had a force-push to that ref,
and perhaps the two HTTP requests end up directed to these different
servers.

Signed-off-by: David Turner <dturner@twosigma.com>
---

Actually, I realized as forgot the doco.  Sorry.

 Documentation/config.txt         |  5 +++++
 Documentation/git-fetch-pack.txt |  6 +++---
 t/t5551-http-fetch-smart.sh      | 22 ++++++++++++++++++++++
 upload-pack.c                    | 10 +++++++++-
 4 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a0ab66a..b7f9991 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2961,6 +2961,11 @@ uploadpack.allowReachableSHA1InWant::
 	calculating object reachability is computationally expensive.
 	Defaults to `false`.
 
+uploadpack.allowAnySHA1InWant::
+	Allow `upload-pack` to accept a fetch request that asks for any
+	object at all.
+	Defaults to `false`.
+
 uploadpack.keepAlive::
 	When `upload-pack` has started `pack-objects`, there may be a
 	quiet period while `pack-objects` prepares the pack. Normally
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index d45f6ad..f7ebe36 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -119,9 +119,9 @@ be in a separate packet, and the list must end with a flush packet.
 	$GIT_DIR (e.g. "HEAD", "refs/heads/master").  When
 	unspecified, update from all heads the remote side has.
 +
-If the remote has enabled the options `uploadpack.allowTipSHA1InWant` or
-`uploadpack.allowReachableSHA1InWant`, they may alternatively be 40-hex
-sha1s present on the remote.
+If the remote has enabled the options `uploadpack.allowTipSHA1InWant`,
+`uploadpack.allowReachableSHA1InWant`, or `uploadpack.allowAnySHA1InWant`,
+they may alternatively be 40-hex sha1s present on the remote.
 
 SEE ALSO
 --------
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 43665ab..8d3db40 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -306,6 +306,28 @@ test_expect_success 'test allowreachablesha1inwant with unreachable' '
 	test_must_fail git -C test_reachable.git fetch origin "$(git rev-parse HEAD)"
 '
 
+test_expect_success 'test allowanysha1inwant with unreachable' '
+	test_when_finished "rm -rf test_reachable.git; git reset --hard $(git rev-parse HEAD)" &&
+
+	#create unreachable sha
+	echo content >file2 &&
+	git add file2 &&
+	git commit -m two &&
+	git push public HEAD:refs/heads/doomed &&
+	git push public :refs/heads/doomed &&
+
+	server="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	master_sha=$(git -C "$server" rev-parse refs/heads/master) &&
+	git -C "$server" config uploadpack.allowreachablesha1inwant 1 &&
+
+	git init --bare test_reachable.git &&
+	git -C test_reachable.git remote add origin "$HTTPD_URL/smart/repo.git" &&
+	test_must_fail git -C test_reachable.git fetch origin "$(git rev-parse HEAD)" &&
+
+	git -C "$server" config uploadpack.allowanysha1inwant 1 &&
+	git -C test_reachable.git fetch origin "$(git rev-parse HEAD)"
+'
+
 test_expect_success EXPENSIVE 'http can handle enormous ref negotiation' '
 	(
 		cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
diff --git a/upload-pack.c b/upload-pack.c
index e0db8b4..7597ba3 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -46,6 +46,8 @@ static int no_progress, daemon_mode;
 #define ALLOW_TIP_SHA1	01
 /* Allow request of a sha1 if it is reachable from a ref (possibly hidden ref). */
 #define ALLOW_REACHABLE_SHA1	02
+/* Allow request of any sha1. Implies ALLOW_TIP_SHA1 and ALLOW_REACHABLE_SHA1. */
+#define ALLOW_ANY_SHA1	07
 static unsigned int allow_unadvertised_object_request;
 static int shallow_nr;
 static struct object_array have_obj;
@@ -825,7 +827,8 @@ static void receive_needs(void)
 			    sha1_to_hex(sha1_buf));
 		if (!(o->flags & WANTED)) {
 			o->flags |= WANTED;
-			if (!is_our_ref(o))
+			if (!((allow_unadvertised_object_request & ALLOW_ANY_SHA1) == ALLOW_ANY_SHA1
+			      || is_our_ref(o)))
 				has_non_tip = 1;
 			add_object_array(o, NULL, &want_obj);
 		}
@@ -1008,6 +1011,11 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 			allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
 		else
 			allow_unadvertised_object_request &= ~ALLOW_REACHABLE_SHA1;
+	} else if (!strcmp("uploadpack.allowanysha1inwant", var)) {
+		if (git_config_bool(var, value))
+			allow_unadvertised_object_request |= ALLOW_ANY_SHA1;
+		else
+			allow_unadvertised_object_request &= ~ALLOW_ANY_SHA1;
 	} else if (!strcmp("uploadpack.keepalive", var)) {
 		keepalive = git_config_int(var, value);
 		if (!keepalive)
-- 
2.8.0.rc4.22.g8ae061a

