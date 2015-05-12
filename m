From: Fredrik Medley <fredrik.medley@gmail.com>
Subject: [PATCH 2/3] upload-pack: Prepare to extend allow-tip-sha1-in-want
Date: Tue, 12 May 2015 23:14:24 +0200
Message-ID: <1431465265-18486-2-git-send-email-fredrik.medley@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 12 23:15:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsHW3-00039s-SF
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 23:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803AbbELVO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 17:14:58 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:34193 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbbELVO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 17:14:57 -0400
Received: by lbcga7 with SMTP id ga7so15661497lbc.1
        for <git@vger.kernel.org>; Tue, 12 May 2015 14:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2R0p+4d2AUDtBeQOnxjuSaEN0554QrdoIiPTPd2KP4E=;
        b=t6Rd1ctazU1swRJmVQ1fjVoBk6za9MxE7G9wnCAAtLVj4z5GPIQ0xKcZHBqrD+9Xzn
         fsCnOAkF+NqO+afKhQBKmPlZJw1zMv0hdrJ2xvzVJ3ZBomVIe7U+WYvrdts7CzEfID6K
         0WhdRNYjoStO/deRrS+ziLtsSDoI+7Dcjcm5t4WeTFkwA8L3EJiu/e/QLuVqCr8oTdu4
         hqVtpO7BnvBGKX4SfoDzcQHilv/9pFh4sYIMGB3OyqM2oWnjsanx0UQnsjnMCdA0eXLB
         q8WRcLvS7D0h8vnGqUFEABrTwOKCvtvNfTg4t49l6cqzPCdPmAaJAGpeKvRyP664r1Vu
         NUEw==
X-Received: by 10.152.115.173 with SMTP id jp13mr13293958lab.119.1431465296369;
        Tue, 12 May 2015 14:14:56 -0700 (PDT)
Received: from localhost.localdomain (c83-252-232-146.bredband.comhem.se. [83.252.232.146])
        by mx.google.com with ESMTPSA id o8sm4242695lal.2.2015.05.12.14.14.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 May 2015 14:14:55 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1431465265-18486-1-git-send-email-fredrik.medley@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268886>

Rename the allow_tip_sha1_in_want variable to
allow_request_with_bare_object_name to allow for future extensions, e.g.
allowing non-tip sha1.
---
 fetch-pack.c  |  9 ++++++---
 upload-pack.c | 18 +++++++++++-------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 48526aa..77174f9 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -43,7 +43,10 @@ static int marked;
 #define MAX_IN_VAIN 256
 
 static struct prio_queue rev_list = { compare_commits_by_commit_date };
-static int non_common_revs, multi_ack, use_sideband, allow_tip_sha1_in_want;
+static int non_common_revs, multi_ack, use_sideband;
+/* Allow specifying sha1 if it is a ref tip. */
+#define ALLOW_TIP	01
+static int allow_request_with_bare_object_name;
 
 static void rev_list_push(struct commit *commit, int mark)
 {
@@ -542,7 +545,7 @@ static void filter_refs(struct fetch_pack_args *args,
 	}
 
 	/* Append unmatched requests to the list */
-	if (allow_tip_sha1_in_want) {
+	if (allow_request_with_bare_object_name & ALLOW_TIP) {
 		for (i = 0; i < nr_sought; i++) {
 			unsigned char sha1[20];
 
@@ -821,7 +824,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	if (server_supports("allow-tip-sha1-in-want")) {
 		if (args->verbose)
 			fprintf(stderr, "Server supports allow-tip-sha1-in-want\n");
-		allow_tip_sha1_in_want = 1;
+		allow_request_with_bare_object_name |= ALLOW_TIP;
 	}
 	if (!server_supports("thin-pack"))
 		args->use_thin_pack = 0;
diff --git a/upload-pack.c b/upload-pack.c
index aa84576..708a502 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -35,7 +35,9 @@ static int multi_ack;
 static int no_done;
 static int use_thin_pack, use_ofs_delta, use_include_tag;
 static int no_progress, daemon_mode;
-static int allow_tip_sha1_in_want;
+/* Allow specifying sha1 if it is a ref tip. */
+#define ALLOW_TIP	01
+static int allow_request_with_bare_object_name;
 static int shallow_nr;
 static struct object_array have_obj;
 static struct object_array want_obj;
@@ -442,8 +444,8 @@ static int get_common_commits(void)
 
 static int is_our_ref(struct object *o)
 {
-	return o->flags &
-		((allow_tip_sha1_in_want ? HIDDEN_REF : 0) | OUR_REF);
+	int allow_hidden_ref = (allow_request_with_bare_object_name & ALLOW_TIP);
+	return o->flags & ((allow_hidden_ref ? HIDDEN_REF : 0) | OUR_REF);
 }
 
 static void check_non_tip(void)
@@ -727,7 +729,8 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 		packet_write(1, "%s %s%c%s%s%s%s agent=%s\n",
 			     sha1_to_hex(sha1), refname_nons,
 			     0, capabilities,
-			     allow_tip_sha1_in_want ? " allow-tip-sha1-in-want" : "",
+			     (allow_request_with_bare_object_name & ALLOW_TIP) ?
+				     " allow-tip-sha1-in-want" : "",
 			     stateless_rpc ? " no-done" : "",
 			     symref_info.buf,
 			     git_user_agent_sanitized());
@@ -787,9 +790,10 @@ static void upload_pack(void)
 
 static int upload_pack_config(const char *var, const char *value, void *unused)
 {
-	if (!strcmp("uploadpack.allowtipsha1inwant", var))
-		allow_tip_sha1_in_want = git_config_bool(var, value);
-	else if (!strcmp("uploadpack.keepalive", var)) {
+	if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
+		if (git_config_bool(var, value))
+			allow_request_with_bare_object_name |= ALLOW_TIP;
+	} else if (!strcmp("uploadpack.keepalive", var)) {
 		keepalive = git_config_int(var, value);
 		if (!keepalive)
 			keepalive = -1;
-- 
1.9.1
