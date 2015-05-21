From: Fredrik Medley <fredrik.medley@gmail.com>
Subject: [PATCH v5 2/3] upload-pack: prepare to extend allow-tip-sha1-in-want
Date: Thu, 21 May 2015 22:23:38 +0200
Message-ID: <1432239819-21794-2-git-send-email-fredrik.medley@gmail.com>
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
X-From: git-owner@vger.kernel.org Thu May 21 22:24:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvX0o-0007Fl-IX
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 22:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756466AbbEUUYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 16:24:11 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:34133 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756418AbbEUUYI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 16:24:08 -0400
Received: by laat2 with SMTP id t2so110905565laa.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 13:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oYJheoC3hdx2j53/C2Iy0c5lQByXTGhdeDgbGJhTVlY=;
        b=v1rTpMGTUNcIi0xR8OG3sc9ADnMwbQeL4VcYxbjQzMxdXiJvA4c0/12TSv6Qb+xIy0
         Os628svXwePzwr3KnkVM+22qnIpK537BMnIPrvNHJNYu1gyi/bYEgJZ5j/pbbrft1frH
         mVOr5rogS/xlaMd7w6Akf2zw2O73mBXS56LIxIFeeqNyxQU70G5tNdBawvfFuc37y7i6
         GSF6WWrtxPB1dcPbUXf8N08ZwEkIaLs/ucalB1VmrWPmtz6ZcSzzWkR48TKDnlOP9wAx
         FSc8VczpbXRv7mZYvLNDeR6Xq1q3+2wpfip350MqP3+fo7OBi6z1ij07ZDbQz6Zmj470
         vbeA==
X-Received: by 10.152.234.233 with SMTP id uh9mr3688491lac.64.1432239846524;
        Thu, 21 May 2015 13:24:06 -0700 (PDT)
Received: from localhost.localdomain (c83-252-232-146.bredband.comhem.se. [83.252.232.146])
        by mx.google.com with ESMTPSA id ba4sm5500565lab.31.2015.05.21.13.24.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 May 2015 13:24:05 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.GIT
In-Reply-To: <1432239819-21794-1-git-send-email-fredrik.medley@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269654>

To allow future extensions, e.g. allowing non-tip sha1, replace the
boolean allow_tip_sha1_in_want variable with the flag-style
allow_request_with_bare_object_name variable.

Signed-off-by: Fredrik Medley <fredrik.medley@gmail.com>
---
 fetch-pack.c  |  9 ++++++---
 upload-pack.c | 20 +++++++++++++-------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 48526aa..699f586 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -43,7 +43,10 @@ static int marked;
 #define MAX_IN_VAIN 256
 
 static struct prio_queue rev_list = { compare_commits_by_commit_date };
-static int non_common_revs, multi_ack, use_sideband, allow_tip_sha1_in_want;
+static int non_common_revs, multi_ack, use_sideband;
+/* Allow specifying sha1 if it is a ref tip. */
+#define ALLOW_TIP_SHA1	01
+static int allow_unadvertised_object_request;
 
 static void rev_list_push(struct commit *commit, int mark)
 {
@@ -542,7 +545,7 @@ static void filter_refs(struct fetch_pack_args *args,
 	}
 
 	/* Append unmatched requests to the list */
-	if (allow_tip_sha1_in_want) {
+	if ((allow_unadvertised_object_request & ALLOW_TIP_SHA1)) {
 		for (i = 0; i < nr_sought; i++) {
 			unsigned char sha1[20];
 
@@ -821,7 +824,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	if (server_supports("allow-tip-sha1-in-want")) {
 		if (args->verbose)
 			fprintf(stderr, "Server supports allow-tip-sha1-in-want\n");
-		allow_tip_sha1_in_want = 1;
+		allow_unadvertised_object_request |= ALLOW_TIP_SHA1;
 	}
 	if (!server_supports("thin-pack"))
 		args->use_thin_pack = 0;
diff --git a/upload-pack.c b/upload-pack.c
index 745fda8..726486b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -35,7 +35,9 @@ static int multi_ack;
 static int no_done;
 static int use_thin_pack, use_ofs_delta, use_include_tag;
 static int no_progress, daemon_mode;
-static int allow_tip_sha1_in_want;
+/* Allow specifying sha1 if it is a ref tip. */
+#define ALLOW_TIP_SHA1	01
+static int allow_unadvertised_object_request;
 static int shallow_nr;
 static struct object_array have_obj;
 static struct object_array want_obj;
@@ -442,8 +444,8 @@ static int get_common_commits(void)
 
 static int is_our_ref(struct object *o)
 {
-	return o->flags &
-		((allow_tip_sha1_in_want ? HIDDEN_REF : 0) | OUR_REF);
+	int allow_hidden_ref = (allow_unadvertised_object_request & ALLOW_TIP_SHA1);
+	return o->flags & ((allow_hidden_ref ? HIDDEN_REF : 0) | OUR_REF);
 }
 
 static void check_non_tip(void)
@@ -727,7 +729,8 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 		packet_write(1, "%s %s%c%s%s%s%s agent=%s\n",
 			     sha1_to_hex(sha1), refname_nons,
 			     0, capabilities,
-			     allow_tip_sha1_in_want ? " allow-tip-sha1-in-want" : "",
+			     (allow_unadvertised_object_request & ALLOW_TIP_SHA1) ?
+				     " allow-tip-sha1-in-want" : "",
 			     stateless_rpc ? " no-done" : "",
 			     symref_info.buf,
 			     git_user_agent_sanitized());
@@ -787,9 +790,12 @@ static void upload_pack(void)
 
 static int upload_pack_config(const char *var, const char *value, void *unused)
 {
-	if (!strcmp("uploadpack.allowtipsha1inwant", var))
-		allow_tip_sha1_in_want = git_config_bool(var, value);
-	else if (!strcmp("uploadpack.keepalive", var)) {
+	if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
+		if (git_config_bool(var, value))
+			allow_unadvertised_object_request |= ALLOW_TIP_SHA1;
+		else
+			allow_unadvertised_object_request &= ~ALLOW_TIP_SHA1;
+	} else if (!strcmp("uploadpack.keepalive", var)) {
 		keepalive = git_config_int(var, value);
 		if (!keepalive)
 			keepalive = -1;
-- 
1.9.1
