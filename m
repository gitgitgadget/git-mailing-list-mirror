From: Fredrik Medley <fredrik.medley@gmail.com>
Subject: [PATCH v2] upload-pack: Optionally allow fetching reachable sha1
Date: Tue,  5 May 2015 23:21:28 +0200
Message-ID: <1430860888-6146-1-git-send-email-fredrik.medley@gmail.com>
References: <1430604075-5951-1-git-send-email-fredrik.medley@gmail.com>
Cc: Fredrik Medley <fredrik.medley@gmail.com>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 05 23:22:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpkIc-0004ED-Lm
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 23:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031480AbbEEVWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 17:22:38 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:34577 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031448AbbEEVWg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 17:22:36 -0400
Received: by laat2 with SMTP id t2so137888123laa.1
        for <git@vger.kernel.org>; Tue, 05 May 2015 14:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j5h4YuNjFX41wCGI0eLKM7kHbptb9YqvdIZM6z90XDU=;
        b=v0JM7IEbqzrNKyR3Rc/eHu42wMO9iSC1TN+braHS+7IFFGUvAPtrLz7x3gN6Ico0gt
         Qc0TIq+mDhj/tntQsFifp8+z4jtMF+r8dZKym8uRmpPy5XIpxSuLULd57wDtYp1fouqe
         RKPA1ib1jEtL/xmJ2XUa09n1cKpEgNK1QFwxoDBc5BsuANdKLAHjBC54CP3icPkqQ9hy
         me7n15IRXEfm9DRLOAjlxkIU0yFwK37r/CsjSh19umHbQtID9bdeyY4K06qdDswNf/Fe
         3EftyYK78v2DjPVr6aklldbxYzjuhhiWm56xbNiiZm8f4h539WTNBuOb6BpMkt/7gMZ9
         bB9A==
X-Received: by 10.112.119.163 with SMTP id kv3mr26109921lbb.101.1430860955088;
        Tue, 05 May 2015 14:22:35 -0700 (PDT)
Received: from localhost.localdomain (c83-252-232-146.bredband.comhem.se. [83.252.232.146])
        by mx.google.com with ESMTPSA id p7sm4300710lae.47.2015.05.05.14.22.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 May 2015 14:22:34 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1430604075-5951-1-git-send-email-fredrik.medley@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268424>

With uploadpack.allowreachablesha1inwant configuration option set on the
server side, "git fetch" can make a request with a "want" line that names
an object that has not been advertised (likely to have been obtained out
of band or from a submodule pointer). Only objects reachable from the
branch tips, i.e. the union of advertised branches and branches hidden by
transfer.hiderefs, will be processed. Note that there is an associated
cost of having to walk back the hstory to check the reachability.

This feature can be used when obtaining the content of a certain commit,
for which the sha1 is known, without the need of cloning the whole
repository, especially if a shallow fetch is used. Useful cases are e.g.
repositories containing large files in the history, fetching only the
needed data for a submodule checkout, when sharing a sha1 without telling
which exact branch it belongs to and in Gerrit, if you think in terms of
commits instead of change numbers. (The Gerrit case has already been
solved through allow-tip-sha1-in-want as every change has a ref.)

Signed-off-by: Fredrik Medley <fredrik.medley@gmail.com>
---
 Documentation/config.txt |  6 ++++++
 fetch-pack.c             |  9 ++++++--
 t/t5516-fetch-push.sh    | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
 upload-pack.c            | 19 ++++++++++++-----
 4 files changed, 82 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2e5ceaf..76cd713 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2538,6 +2538,12 @@ uploadpack.allowtipsha1inwant::
 	of a hidden ref (by default, such a request is rejected).
 	see also `uploadpack.hideRefs`.
 
+uploadpack.allowreachablesha1inwant::
+	Allow `upload-pack` to accept a fetch request that asks for an
+	object that is reachable from any ref tip. However, note that
+	calculating	object reachability is computationally expensive.
+	Defaults to `false`.
+
 uploadpack.keepAlive::
 	When `upload-pack` has started `pack-objects`, there may be a
 	quiet period while `pack-objects` prepares the pack. Normally
diff --git a/fetch-pack.c b/fetch-pack.c
index 48526aa..fb01b6c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -43,7 +43,7 @@ static int marked;
 #define MAX_IN_VAIN 256
 
 static struct prio_queue rev_list = { compare_commits_by_commit_date };
-static int non_common_revs, multi_ack, use_sideband, allow_tip_sha1_in_want;
+static int non_common_revs, multi_ack, use_sideband, allow_tip_sha1_in_want, allow_reachable_sha1_in_want;
 
 static void rev_list_push(struct commit *commit, int mark)
 {
@@ -542,7 +542,7 @@ static void filter_refs(struct fetch_pack_args *args,
 	}
 
 	/* Append unmatched requests to the list */
-	if (allow_tip_sha1_in_want) {
+	if (allow_tip_sha1_in_want || allow_reachable_sha1_in_want) {
 		for (i = 0; i < nr_sought; i++) {
 			unsigned char sha1[20];
 
@@ -823,6 +823,11 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 			fprintf(stderr, "Server supports allow-tip-sha1-in-want\n");
 		allow_tip_sha1_in_want = 1;
 	}
+	if (server_supports("allow-reachable-sha1-in-want")) {
+		if (args->verbose)
+			fprintf(stderr, "Server supports allow-reachable-sha1-in-want\n");
+		allow_reachable_sha1_in_want = 1;
+	}
 	if (!server_supports("thin-pack"))
 		args->use_thin_pack = 0;
 	if (!server_supports("no-progress"))
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 8a5f236..01fabfb 100755
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
+		SHA1=`git --git-dir=testrepo/.git rev-parse HEAD^` &&
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
+		SHA1_1=`git --git-dir=testrepo/.git rev-parse HEAD^^` &&
+		SHA1_2=`git --git-dir=testrepo/.git rev-parse HEAD^` &&
+		SHA1_3=`git --git-dir=testrepo/.git rev-parse HEAD` &&
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
index aa84576..cea4c57 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -36,6 +36,7 @@ static int no_done;
 static int use_thin_pack, use_ofs_delta, use_include_tag;
 static int no_progress, daemon_mode;
 static int allow_tip_sha1_in_want;
+static int allow_reachable_sha1_in_want;
 static int shallow_nr;
 static struct object_array have_obj;
 static struct object_array want_obj;
@@ -442,8 +443,9 @@ static int get_common_commits(void)
 
 static int is_our_ref(struct object *o)
 {
-	return o->flags &
-		((allow_tip_sha1_in_want ? HIDDEN_REF : 0) | OUR_REF);
+	int allow_hidden_ref =
+		allow_tip_sha1_in_want || allow_reachable_sha1_in_want;
+	return o->flags & ((allow_hidden_ref ? HIDDEN_REF : 0) | OUR_REF);
 }
 
 static void check_non_tip(void)
@@ -456,8 +458,12 @@ static void check_non_tip(void)
 	char namebuf[42]; /* ^ + SHA-1 + LF */
 	int i;
 
-	/* In the normal in-process case non-tip request can never happen */
-	if (!stateless_rpc)
+	/*
+	 * In the normal in-process case without
+	 * uploadpack.allowreachablesha1inwant,
+	 * non-tip requests can never happen.
+	 */
+	if (!stateless_rpc && !allow_reachable_sha1_in_want)
 		goto error;
 
 	cmd.argv = argv;
@@ -724,10 +730,11 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 		struct strbuf symref_info = STRBUF_INIT;
 
 		format_symref_info(&symref_info, cb_data);
-		packet_write(1, "%s %s%c%s%s%s%s agent=%s\n",
+		packet_write(1, "%s %s%c%s%s%s%s%s agent=%s\n",
 			     sha1_to_hex(sha1), refname_nons,
 			     0, capabilities,
 			     allow_tip_sha1_in_want ? " allow-tip-sha1-in-want" : "",
+			     allow_reachable_sha1_in_want ? " allow-reachable-sha1-in-want" : "",
 			     stateless_rpc ? " no-done" : "",
 			     symref_info.buf,
 			     git_user_agent_sanitized());
@@ -789,6 +796,8 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 {
 	if (!strcmp("uploadpack.allowtipsha1inwant", var))
 		allow_tip_sha1_in_want = git_config_bool(var, value);
+	else if (!strcmp("uploadpack.allowreachablesha1inwant", var))
+		allow_reachable_sha1_in_want = git_config_bool(var, value);
 	else if (!strcmp("uploadpack.keepalive", var)) {
 		keepalive = git_config_int(var, value);
 		if (!keepalive)
-- 
1.9.1
