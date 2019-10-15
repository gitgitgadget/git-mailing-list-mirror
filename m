Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81C191F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 01:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfJOBIM (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 21:08:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43758 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727250AbfJOBIL (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 14 Oct 2019 21:08:11 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6421960424;
        Tue, 15 Oct 2019 01:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1571101689;
        bh=+zsyzQH2lnnX34NMQwob4POfe8hjCfcM5kOTtA0/En8=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=tejer/3B4J9yp+r4xknAWdP1Ho0mEe9Pu+TeqlIyAqQwozGNQ4YBBTICR2WStAkzP
         JbtGLnwoFqjgxXr5PiNXwtxR4q6lqss56NUkk+qtMyraiCNeTrbYJ00xwO9P53lxHw
         5eV5mIRfwtf1YjtltXYUZjo5Qs/0uzVjKUDtk2wowP7hGhVPpDSyCPfQV4GOlhN7Yv
         yhuv2XA96lRTFpf2uugOCxI+ZTPDtIFu0IvdLATR2ckUWWwls+upcPuCAt7aBNfvHH
         4mYRzJlyxms9bsZbZv2IVdkOS9sVVOQbDoqWY7NTPJmkuzoy6Oe6AI9fb9DRd/qmKU
         7lh/K6w/aIp1Yv32QtioYehNowNe/KZWxbCMMzi6UHk00RTrQygFOjrPjhhpfDWGGl
         DNfpMBnpVln25hkZDOBT1qKR/cACg8MP7QE2JgL2QNxECfgdHtf+7fI1GO+tkj+RXh
         jYmsza5r0f/RCVnea1l7VbcoLiGVHEl/yydaxwuDYNtFt4T9cUk
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH] remote-curl: pass on atomic capability to remote side
Date:   Tue, 15 Oct 2019 01:07:59 +0000
Message-Id: <20191015010759.2259-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When pushing more than one reference with the --atomic option, the
server is supposed to perform a single atomic transaction to update the
references, leaving them either all to succeed or all to fail.  This
works fine when pushing locally or over SSH, but when pushing over HTTP,
we fail to pass the atomic capability to the remote side.  In fact, we
have not reported this capability to any remote helpers during the life
of the feature.

Now normally, things happen to work nevertheless, since we actually
check for most types of failures, such as non-fast-forward updates, on
the client side, and just abort the entire attempt.  However, if the
server side reports a problem, such as the inability to lock a ref, the
transaction isn't atomic, because we haven't passed the appropriate
capability over and the remote side has no way of knowing that we wanted
atomic behavior.

Fix this by passing the option from the transport code through to remote
helpers, and from the HTTP remote helper down to send-pack.  With this
change, we can detect if the server side rejects the push and report
back appropriately.  Note the difference in the messages: the remote
side reports "atomic transaction failed", while our own checking rejects
pushes with the message "atomic push failed".

Document the atomic option in the remote helper documentation, so other
implementers can implement it if they like.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
I discovered this at work when implementing support for atomic pushes.
Our equivalent of the pre-receive hook is not all-or-nothing, and
passing the atomic capability through to our backend worked for SSH, but
not HTTP.  I discovered with GIT_TRACE_PACKET=1 that we didn't pass the
atomic capability through during HTTP, so I thought I'd send a patch.

As I mentioned in the commit message, to my knowledge, this
functionality has been broken since the atomic capability was introduced
circa 2.4.0.

 Documentation/gitremote-helpers.txt |  5 ++++
 remote-curl.c                       | 13 +++++++++-
 t/t5541-http-push-smart.sh          | 40 +++++++++++++++++++++++++++--
 transport-helper.c                  |  4 +++
 transport.h                         |  3 +++
 5 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index a5c3c04371..670d72c174 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -509,6 +509,11 @@ set by Git if the remote helper has the 'option' capability.
 	Indicate that only the objects wanted need to be fetched, not
 	their dependents.
 
+'option atomic' {'true'|'false'}::
+  When pushing, request the remote server to update refs in a single atomic
+  transaction.  If successful, all refs will be updated, or none will.  If the
+  remote side does not support this capability, the push will fail.
+
 SEE ALSO
 --------
 linkgit:git-remote[1]
diff --git a/remote-curl.c b/remote-curl.c
index 051f26629d..5232ed84b6 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -40,7 +40,8 @@ struct options {
 		push_cert : 2,
 		deepen_relative : 1,
 		from_promisor : 1,
-		no_dependents : 1;
+		no_dependents : 1,
+		atomic : 1;
 };
 static struct options options;
 static struct string_list cas_options = STRING_LIST_INIT_DUP;
@@ -148,6 +149,14 @@ static int set_option(const char *name, const char *value)
 		else
 			return -1;
 		return 0;
+	} else if (!strcmp(name, "atomic")) {
+		if (!strcmp(value, "true"))
+			options.atomic = 1;
+		else if (!strcmp(value, "false"))
+			options.atomic = 0;
+		else
+			return -1;
+		return 0;
 	} else if (!strcmp(name, "push-option")) {
 		if (*value != '"')
 			string_list_append(&options.push_options, value);
@@ -1196,6 +1205,8 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
 		argv_array_push(&args, "--signed=yes");
 	else if (options.push_cert == SEND_PACK_PUSH_CERT_IF_ASKED)
 		argv_array_push(&args, "--signed=if-asked");
+	if (options.atomic)
+		argv_array_push(&args, "--atomic");
 	if (options.verbosity == 0)
 		argv_array_push(&args, "--quiet");
 	else if (options.verbosity > 1)
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 92bac43257..4c970787b0 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -184,11 +184,12 @@ test_expect_success 'push --atomic also prevents branch creation, reports collat
 	test_config -C "$d" http.receivepack true &&
 	up="$HTTPD_URL"/smart/atomic-branches.git &&
 
-	# Tell "$up" about two branches for now
+	# Tell "$up" about three branches for now
 	test_commit atomic1 &&
 	test_commit atomic2 &&
 	git branch collateral &&
-	git push "$up" master collateral &&
+	git branch other &&
+	git push "$up" master collateral other &&
 
 	# collateral is a valid push, but should be failed by atomic push
 	git checkout collateral &&
@@ -226,6 +227,41 @@ test_expect_success 'push --atomic also prevents branch creation, reports collat
 	grep "^ ! .*rejected.* collateral -> collateral .*atomic push failed" output
 '
 
+test_expect_success 'push --atomic fails on server-side errors' '
+	# Use previously set up repository
+	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-branches.git &&
+	test_config -C "$d" http.receivepack true &&
+	up="$HTTPD_URL"/smart/atomic-branches.git &&
+
+	# break ref updates for other on the remote site
+	mkdir "$d/refs/heads/other.lock" &&
+
+	# add the new commit to other
+	git branch -f other collateral &&
+
+	# --atomic should cause entire push to be rejected
+	test_must_fail git push --atomic "$up" atomic other 2>output  &&
+
+	# the new branch should not have been created upstream
+	test_must_fail git -C "$d" show-ref --verify refs/heads/atomic &&
+
+	# upstream should still reflect atomic2, the last thing we pushed
+	# successfully
+	git rev-parse atomic2 >expected &&
+	# ...to other.
+	git -C "$d" rev-parse refs/heads/other >actual &&
+	test_cmp expected actual &&
+
+	# the new branch should not have been created upstream
+	test_must_fail git -C "$d" show-ref --verify refs/heads/atomic &&
+
+	# the failed refs should be indicated to the user
+	grep "^ ! .*rejected.* other -> other .*atomic transaction failed" output &&
+
+	# the collateral failure refs should be indicated to the user
+	grep "^ ! .*rejected.* atomic -> atomic .*atomic transaction failed" output
+'
+
 test_expect_success 'push --all can push to empty repo' '
 	d=$HTTPD_DOCUMENT_ROOT_PATH/empty-all.git &&
 	git init --bare "$d" &&
diff --git a/transport-helper.c b/transport-helper.c
index 9e1279b928..a9d690297e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -854,6 +854,10 @@ static void set_common_push_options(struct transport *transport,
 			die(_("helper %s does not support --signed=if-asked"), name);
 	}
 
+	if (flags & TRANSPORT_PUSH_ATOMIC)
+		if (set_helper_option(transport, TRANS_OPT_ATOMIC, "true") != 0)
+			die(_("helper %s does not support --atomic"), name);
+
 	if (flags & TRANSPORT_PUSH_OPTIONS) {
 		struct string_list_item *item;
 		for_each_string_list_item(item, transport->push_options)
diff --git a/transport.h b/transport.h
index 0b5f7806f6..e0131daab9 100644
--- a/transport.h
+++ b/transport.h
@@ -208,6 +208,9 @@ void transport_check_allowed(const char *type);
 /* Filter objects for partial clone and fetch */
 #define TRANS_OPT_LIST_OBJECTS_FILTER "filter"
 
+/* Request atomic (all-or-nothing) updates when pushing */
+#define TRANS_OPT_ATOMIC "atomic"
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
