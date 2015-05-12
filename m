From: Fredrik Medley <fredrik.medley@gmail.com>
Subject: [PATCH 3/3] upload-pack: Optionally allow fetching reachable sha1
Date: Tue, 12 May 2015 23:14:25 +0200
Message-ID: <1431465265-18486-3-git-send-email-fredrik.medley@gmail.com>
References: <xmqqy4l1sblq.fsf@gitster.dls.corp.google.com>
 <1431465265-18486-1-git-send-email-fredrik.medley@gmail.com>
Cc: Fredrik Medley <fredrik.medley@gmail.com>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 23:15:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsHWT-0003MN-90
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 23:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbbELVPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 17:15:25 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:36277 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472AbbELVPY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 17:15:24 -0400
Received: by lagv1 with SMTP id v1so15561442lag.3
        for <git@vger.kernel.org>; Tue, 12 May 2015 14:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qGuxhhQqNAoUEjMFz+hq/IuDb/MukjQCxeZcV5uFP8w=;
        b=bL5PXN+uvrUB9L2VqG+L2abtrm6Cl9uimknsn8z0ynavpZ3ygc9+AFAxUjQ99dKFyT
         sf0Mz/CbPxqs5Pe+fCC+MDGSGzZheIfe2sfEn1qxQXn7w/JiMW7Aguj9H+Dwfoe5Ia+n
         zlBJzLbt2bfBfBZqhSQvDgQr4i0VHX97RndwYfyz83KGsg8nAWBcB5um+rOoorZE4lVB
         B91aUMkUBIdnMxNjHjUYXchGgCdkl69CODCuPKQUN7r/9+gkF2FnSFDiRgF8c+2WlZH9
         K8wRC0RSZ9AJKKHWPlYzOvO2pQz5pAK0nCda141Df2uEkBVCe0Ex6Eh91vuXEIMTho+G
         9Jzw==
X-Received: by 10.152.43.110 with SMTP id v14mr13416882lal.4.1431465322916;
        Tue, 12 May 2015 14:15:22 -0700 (PDT)
Received: from localhost.localdomain (c83-252-232-146.bredband.comhem.se. [83.252.232.146])
        by mx.google.com with ESMTPSA id o8sm4242695lal.2.2015.05.12.14.15.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 May 2015 14:15:22 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1431465265-18486-1-git-send-email-fredrik.medley@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268887>

With uploadpack.allowReachableSHA1InWant configuration option set on the
server side, "git fetch" can make a request with a "want" line that names
an object that has not been advertised (likely to have been obtained out
of band or from a submodule pointer). Only objects reachable from the
branch tips, i.e. the union of advertised branches and branches hidden by
transfer.hideRefs, will be processed. Note that there is an associated
cost of having to walk back the hstory to check the reachability.

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
 fetch-pack.c                                      |  9 +++-
 t/t5516-fetch-push.sh                             | 55 +++++++++++++++++++++++
 upload-pack.c                                     | 20 +++++++--
 6 files changed, 94 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2b86fe6..ffc4cf4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2538,6 +2538,12 @@ uploadpack.allowTipSHA1InWant::
 	of a hidden ref (by default, such a request is rejected).
 	see also `uploadpack.hideRefs`.
 
+uploadpack.allowReachableSHA1InWant::
+	Allow `upload-pack` to accept a fetch request that asks for an
+	object that is reachable from any ref tip. However, note that
+	calculating	object reachability is computationally expensive.
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
index 77174f9..6c63d8e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -46,6 +46,8 @@ static struct prio_queue rev_list = { compare_commits_by_commit_date };
 static int non_common_revs, multi_ack, use_sideband;
 /* Allow specifying sha1 if it is a ref tip. */
 #define ALLOW_TIP	01
+/* Allow request of a sha1 if it is reachable from a ref (possibly hidden ref). */
+#define ALLOW_REACHABLE	02
 static int allow_request_with_bare_object_name;
 
 static void rev_list_push(struct commit *commit, int mark)
@@ -545,7 +547,7 @@ static void filter_refs(struct fetch_pack_args *args,
 	}
 
 	/* Append unmatched requests to the list */
-	if (allow_request_with_bare_object_name & ALLOW_TIP) {
+	if (allow_request_with_bare_object_name & (ALLOW_TIP | ALLOW_REACHABLE)) {
 		for (i = 0; i < nr_sought; i++) {
 			unsigned char sha1[20];
 
@@ -826,6 +828,11 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 			fprintf(stderr, "Server supports allow-tip-sha1-in-want\n");
 		allow_request_with_bare_object_name |= ALLOW_TIP;
 	}
+	if (server_supports("allow-reachable-sha1-in-want")) {
+		if (args->verbose)
+			fprintf(stderr, "Server supports allow-reachable-sha1-in-want\n");
+		allow_request_with_bare_object_name |= ALLOW_REACHABLE;
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
index 708a502..bd14a81 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -37,6 +37,8 @@ static int use_thin_pack, use_ofs_delta, use_include_tag;
 static int no_progress, daemon_mode;
 /* Allow specifying sha1 if it is a ref tip. */
 #define ALLOW_TIP	01
+/* Allow request of a sha1 if it is reachable from a ref (possibly hidden ref). */
+#define ALLOW_REACHABLE	02
 static int allow_request_with_bare_object_name;
 static int shallow_nr;
 static struct object_array have_obj;
@@ -444,7 +446,8 @@ static int get_common_commits(void)
 
 static int is_our_ref(struct object *o)
 {
-	int allow_hidden_ref = (allow_request_with_bare_object_name & ALLOW_TIP);
+	int allow_hidden_ref = (allow_request_with_bare_object_name &
+		(ALLOW_TIP | ALLOW_REACHABLE));
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
+	if (!stateless_rpc && !(allow_request_with_bare_object_name & ALLOW_REACHABLE))
 		goto error;
 
 	cmd.argv = argv;
@@ -726,11 +733,13 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 		struct strbuf symref_info = STRBUF_INIT;
 
 		format_symref_info(&symref_info, cb_data);
-		packet_write(1, "%s %s%c%s%s%s%s agent=%s\n",
+		packet_write(1, "%s %s%c%s%s%s%s%s agent=%s\n",
 			     sha1_to_hex(sha1), refname_nons,
 			     0, capabilities,
 			     (allow_request_with_bare_object_name & ALLOW_TIP) ?
 				     " allow-tip-sha1-in-want" : "",
+			     (allow_request_with_bare_object_name & ALLOW_REACHABLE) ?
+				     " allow-reachable-sha1-in-want" : "",
 			     stateless_rpc ? " no-done" : "",
 			     symref_info.buf,
 			     git_user_agent_sanitized());
@@ -793,6 +802,9 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 	if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
 		if (git_config_bool(var, value))
 			allow_request_with_bare_object_name |= ALLOW_TIP;
+	} else if (!strcmp("uploadpack.allowreachablesha1inwant", var)) {
+		if (git_config_bool(var, value))
+			allow_request_with_bare_object_name |= ALLOW_REACHABLE;
 	} else if (!strcmp("uploadpack.keepalive", var)) {
 		keepalive = git_config_int(var, value);
 		if (!keepalive)
-- 
1.9.1
