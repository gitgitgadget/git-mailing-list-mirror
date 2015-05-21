From: Fredrik Medley <fredrik.medley@gmail.com>
Subject: [PATCH v5 3/3] upload-pack: optionally allow fetching reachable sha1
Date: Thu, 21 May 2015 22:23:39 +0200
Message-ID: <1432239819-21794-3-git-send-email-fredrik.medley@gmail.com>
References: <1432068269-14895-1-git-send-email-fredrik.medley@gmail.com>
 <1432239819-21794-1-git-send-email-fredrik.medley@gmail.com>
Cc: Fredrik Medley <fredrik.medley@gmail.com>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 22:27:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvX44-0000vt-4i
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 22:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbbEUU1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 16:27:16 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:36164 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756468AbbEUUYO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 16:24:14 -0400
Received: by lagv1 with SMTP id v1so111590746lag.3
        for <git@vger.kernel.org>; Thu, 21 May 2015 13:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EXOscMrO7wi+/NLDY8lBusCBqF4EVxLqeOCqkiPJbjM=;
        b=GAi5i2/HLQe18e3q7oa58UCsALrIy8jjcjjxb6tWkafnuzavvmqEmh50eBz8D3K+og
         l/9Oj8hz6H/TuShw5r11ROacCipyoZXuyfyzlz8+a1ORtikgmH72qj783Ude0YRYr7xb
         dILAx4+k2QiCTKWSsNSfYMjkeQ58YzgVr0pYpYtnvr9BNIOricxW29laaxARb/DhwH31
         a+c0L2ipP8Uf6fmfbNNP1Y9OT4+6HjcKrTp/zm0RYigAqtGCydIb4e5vU3jKEtV77AWQ
         rl4bMilkjcYEmecAV8renvLbancyNxqcjVPN4+6J76LxcUa5hclI/DCyZ8a91Td65MGa
         Ot2g==
X-Received: by 10.152.204.7 with SMTP id ku7mr3665885lac.38.1432239852773;
        Thu, 21 May 2015 13:24:12 -0700 (PDT)
Received: from localhost.localdomain (c83-252-232-146.bredband.comhem.se. [83.252.232.146])
        by mx.google.com with ESMTPSA id ba4sm5500565lab.31.2015.05.21.13.24.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 May 2015 13:24:12 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.GIT
In-Reply-To: <1432239819-21794-1-git-send-email-fredrik.medley@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269655>

With uploadpack.allowReachableSHA1InWant configuration option set on the
server side, "git fetch" can make a request with a "want" line that names
an object that has not been advertised (likely to have been obtained out
of band or from a submodule pointer). Only objects reachable from the
branch tips, i.e. the union of advertised branches and branches hidden by
transfer.hideRefs, will be processed. Note that there is an associated
cost of having to walk back the history to check the reachability.

This feature can be used when obtaining the content of a certain commit,
for which the sha1 is known, without the need of cloning the whole
repository, especially if a shallow fetch is used. Useful cases are e.g.
repositories containing large files in the history, fetching only the
needed data for a submodule checkout, when sharing a sha1 without telling
which exact branch it belongs to and in Gerrit, if you think in terms of
commits instead of change numbers. (The Gerrit case has already been
solved through allowTipSHA1InWant as every Gerrit change has a ref.)

Signed-off-by: Fredrik Medley <fredrik.medley@gmail.com>
---
 Documentation/config.txt                          |  6 +++
 Documentation/technical/http-protocol.txt         |  3 +-
 Documentation/technical/protocol-capabilities.txt |  7 +++
 fetch-pack.c                                      | 10 ++++-
 t/t5516-fetch-push.sh                             | 55 +++++++++++++++++++++++
 upload-pack.c                                     | 22 +++++++--
 6 files changed, 97 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1311383..b8215ba 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2547,6 +2547,12 @@ uploadpack.allowTipSHA1InWant::
 	of a hidden ref (by default, such a request is rejected).
 	see also `uploadpack.hideRefs`.
 
+uploadpack.allowReachableSHA1InWant::
+	Allow `upload-pack` to accept a fetch request that asks for an
+	object that is reachable from any ref tip. However, note that
+	calculating object reachability is computationally expensive.
+	Defaults to `false`.
+
 uploadpack.keepAlive::
 	When `upload-pack` has started `pack-objects`, there may be a
 	quiet period while `pack-objects` prepares the pack. Normally
diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index 229f845..1c561bd 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -319,7 +319,8 @@ Servers SHOULD support all capabilities defined here.
 Clients MUST send at least one "want" command in the request body.
 Clients MUST NOT reference an id in a "want" command which did not
 appear in the response obtained through ref discovery unless the
-server advertises capability `allow-tip-sha1-in-want`.
+server advertises capability `allow-tip-sha1-in-want` or
+`allow-reachable-sha1-in-want`.
 
   compute_request   =  want_list
 		       have_list
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 4f8a7bf..265fcab 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -260,6 +260,13 @@ If the upload-pack server advertises this capability, fetch-pack may
 send "want" lines with SHA-1s that exist at the server but are not
 advertised by upload-pack.
 
+allow-reachable-sha1-in-want
+----------------------
+
+If the upload-pack server advertises this capability, fetch-pack may
+send "want" lines with SHA-1s that exist at the server but are not
+advertised by upload-pack.
+
 push-cert=<nonce>
 -----------------
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 699f586..0d83d47 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -46,6 +46,8 @@ static struct prio_queue rev_list = { compare_commits_by_commit_date };
 static int non_common_revs, multi_ack, use_sideband;
 /* Allow specifying sha1 if it is a ref tip. */
 #define ALLOW_TIP_SHA1	01
+/* Allow request of a sha1 if it is reachable from a ref (possibly hidden ref). */
+#define ALLOW_REACHABLE_SHA1	02
 static int allow_unadvertised_object_request;
 
 static void rev_list_push(struct commit *commit, int mark)
@@ -545,7 +547,8 @@ static void filter_refs(struct fetch_pack_args *args,
 	}
 
 	/* Append unmatched requests to the list */
-	if ((allow_unadvertised_object_request & ALLOW_TIP_SHA1)) {
+	if ((allow_unadvertised_object_request &
+	    (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1))) {
 		for (i = 0; i < nr_sought; i++) {
 			unsigned char sha1[20];
 
@@ -826,6 +829,11 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 			fprintf(stderr, "Server supports allow-tip-sha1-in-want\n");
 		allow_unadvertised_object_request |= ALLOW_TIP_SHA1;
 	}
+	if (server_supports("allow-reachable-sha1-in-want")) {
+		if (args->verbose)
+			fprintf(stderr, "Server supports allow-reachable-sha1-in-want\n");
+		allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
+	}
 	if (!server_supports("thin-pack"))
 		args->use_thin_pack = 0;
 	if (!server_supports("no-progress"))
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 8a5f236..fdcc114 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1120,6 +1120,61 @@ test_expect_success 'fetch exact SHA1' '
 	)
 '
 
+for configallowtipsha1inwant in true false
+do
+	test_expect_success "shallow fetch reachable SHA1 (but not a ref), allowtipsha1inwant=$configallowtipsha1inwant" '
+		mk_empty testrepo &&
+		(
+			cd testrepo &&
+			git config uploadpack.allowtipsha1inwant $configallowtipsha1inwant &&
+			git commit --allow-empty -m foo &&
+			git commit --allow-empty -m bar
+		) &&
+		SHA1=$(git --git-dir=testrepo/.git rev-parse HEAD^) &&
+		mk_empty shallow &&
+		(
+			cd shallow &&
+			test_must_fail git fetch --depth=1 ../testrepo/.git $SHA1 &&
+			git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
+			git fetch --depth=1 ../testrepo/.git $SHA1 &&
+			git cat-file commit $SHA1 >/dev/null
+		)
+	'
+
+	test_expect_success "deny fetch unreachable SHA1, allowtipsha1inwant=$configallowtipsha1inwant" '
+		mk_empty testrepo &&
+		(
+			cd testrepo &&
+			git config uploadpack.allowtipsha1inwant $configallowtipsha1inwant &&
+			git commit --allow-empty -m foo &&
+			git commit --allow-empty -m bar &&
+			git commit --allow-empty -m xyz
+		)
+		SHA1_1=$(git --git-dir=testrepo/.git rev-parse HEAD^^) &&
+		SHA1_2=$(git --git-dir=testrepo/.git rev-parse HEAD^) &&
+		SHA1_3=$(git --git-dir=testrepo/.git rev-parse HEAD) &&
+		(
+			cd testrepo &&
+			git reset --hard $SHA1_2 &&
+			git cat-file commit $SHA1_3 >/dev/null &&
+			git cat-file commit $SHA1_3 >/dev/null
+		) &&
+		mk_empty shallow &&
+		(
+			cd shallow &&
+			test_must_fail git fetch ../testrepo/.git $SHA1_3 &&
+			test_must_fail git fetch ../testrepo/.git $SHA1_1 &&
+			git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
+			git fetch ../testrepo/.git $SHA1_1 &&
+			git cat-file commit $SHA1_1 >/dev/null &&
+			test_must_fail git cat-file commit $SHA1_2 >/dev/null &&
+			git fetch ../testrepo/.git $SHA1_2 &&
+			git cat-file commit $SHA1_2 >/dev/null &&
+			test_must_fail git fetch ../testrepo/.git $SHA1_3
+		)
+	'
+done
+
 test_expect_success 'fetch follows tags by default' '
 	mk_test testrepo heads/master &&
 	rm -fr src dst &&
diff --git a/upload-pack.c b/upload-pack.c
index 726486b..15571d7 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -37,6 +37,8 @@ static int use_thin_pack, use_ofs_delta, use_include_tag;
 static int no_progress, daemon_mode;
 /* Allow specifying sha1 if it is a ref tip. */
 #define ALLOW_TIP_SHA1	01
+/* Allow request of a sha1 if it is reachable from a ref (possibly hidden ref). */
+#define ALLOW_REACHABLE_SHA1	02
 static int allow_unadvertised_object_request;
 static int shallow_nr;
 static struct object_array have_obj;
@@ -444,7 +446,8 @@ static int get_common_commits(void)
 
 static int is_our_ref(struct object *o)
 {
-	int allow_hidden_ref = (allow_unadvertised_object_request & ALLOW_TIP_SHA1);
+	int allow_hidden_ref = (allow_unadvertised_object_request &
+			(ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1));
 	return o->flags & ((allow_hidden_ref ? HIDDEN_REF : 0) | OUR_REF);
 }
 
@@ -458,8 +461,12 @@ static void check_non_tip(void)
 	char namebuf[42]; /* ^ + SHA-1 + LF */
 	int i;
 
-	/* In the normal in-process case non-tip request can never happen */
-	if (!stateless_rpc)
+	/*
+	 * In the normal in-process case without
+	 * uploadpack.allowReachableSHA1InWant,
+	 * non-tip requests can never happen.
+	 */
+	if (!stateless_rpc && !(allow_unadvertised_object_request & ALLOW_REACHABLE_SHA1))
 		goto error;
 
 	cmd.argv = argv;
@@ -726,11 +733,13 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 		struct strbuf symref_info = STRBUF_INIT;
 
 		format_symref_info(&symref_info, cb_data);
-		packet_write(1, "%s %s%c%s%s%s%s agent=%s\n",
+		packet_write(1, "%s %s%c%s%s%s%s%s agent=%s\n",
 			     sha1_to_hex(sha1), refname_nons,
 			     0, capabilities,
 			     (allow_unadvertised_object_request & ALLOW_TIP_SHA1) ?
 				     " allow-tip-sha1-in-want" : "",
+			     (allow_unadvertised_object_request & ALLOW_REACHABLE_SHA1) ?
+				     " allow-reachable-sha1-in-want" : "",
 			     stateless_rpc ? " no-done" : "",
 			     symref_info.buf,
 			     git_user_agent_sanitized());
@@ -795,6 +804,11 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 			allow_unadvertised_object_request |= ALLOW_TIP_SHA1;
 		else
 			allow_unadvertised_object_request &= ~ALLOW_TIP_SHA1;
+	} else if (!strcmp("uploadpack.allowreachablesha1inwant", var)) {
+		if (git_config_bool(var, value))
+			allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
+		else
+			allow_unadvertised_object_request &= ~ALLOW_REACHABLE_SHA1;
 	} else if (!strcmp("uploadpack.keepalive", var)) {
 		keepalive = git_config_int(var, value);
 		if (!keepalive)
-- 
1.9.1
