From: Fredrik Medley <fredrik.medley@gmail.com>
Subject: [PATCH 2/3] upload-pack: prepare to extend allow-tip-sha1-in-want
Date: Tue, 19 May 2015 22:44:28 +0200
Message-ID: <1432068269-14895-2-git-send-email-fredrik.medley@gmail.com>
References: <CAPig+cQe3=Y15+RBZCxry7-78kbNL6H0PfdYs=OV_DMifOWxaA@mail.gmail.com>
 <1432068269-14895-1-git-send-email-fredrik.medley@gmail.com>
Cc: Fredrik Medley <fredrik.medley@gmail.com>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 22:45:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuoOP-0005Om-TQ
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 22:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbbESUpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 16:45:35 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:32805 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbbESUpc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 16:45:32 -0400
Received: by lagr1 with SMTP id r1so43172962lag.0
        for <git@vger.kernel.org>; Tue, 19 May 2015 13:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dXBvc0xvbvSoLaEomFRx2cBAhh7PFnjVmyvGyvJCSFk=;
        b=CJCsGVIIKsl2LKcYx6Zib/vAUqrfvD4jKyB/E3bh8d8eSZNe6zJF22hAP39aBhM/cr
         8npOsW4tUM3Bjfio3+NNtU5hUE9MqtcLwb/pbBxUuIYlI9TPm6ZdimNaAzBUAX4z7RQy
         B2enzwy2k42/WuE9sDr9RyA5MxDKQAA/PDxZWB/ffOI7+/FnujnaE1KW2c38JAr0QT2z
         KSZkTX/oMmmnAsTzi6YWHjw0SDTD9VP0Trrp3cICfM71Tlgi/6HR9J2psZ4pKDoMAXyN
         Q9KN6ZsNLcKGx7nsY/dFAxvcqxBmPT/45Lld4jWFUytvEexaXWEIuhAcf9UT+qoEUDn2
         uTHg==
X-Received: by 10.152.7.239 with SMTP id m15mr552658laa.95.1432068331441;
        Tue, 19 May 2015 13:45:31 -0700 (PDT)
Received: from localhost.localdomain (c83-252-232-146.bredband.comhem.se. [83.252.232.146])
        by mx.google.com with ESMTPSA id ln6sm4002256lac.45.2015.05.19.13.45.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 May 2015 13:45:30 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432068269-14895-1-git-send-email-fredrik.medley@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269400>

To allow future extensions, e.g. allowing non-tip sha1, replace the
boolean allow_tip_sha1_in_want variable with the flag-style
allow_request_with_bare_object_name variable.

Signed-off-by: Fredrik Medley <fredrik.medley@gmail.com>
---
 fetch-pack.c  |  9 ++++++---
 upload-pack.c | 18 +++++++++++-------
 2 files changed, 17 insertions(+), 10 deletions(-)

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
index aa84576..d443e58 100644
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
@@ -787,9 +790,10 @@ static void upload_pack(void)
 
 static int upload_pack_config(const char *var, const char *value, void *unused)
 {
-	if (!strcmp("uploadpack.allowtipsha1inwant", var))
-		allow_tip_sha1_in_want = git_config_bool(var, value);
-	else if (!strcmp("uploadpack.keepalive", var)) {
+	if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
+		if (git_config_bool(var, value))
+			allow_unadvertised_object_request |= ALLOW_TIP_SHA1;
+	} else if (!strcmp("uploadpack.keepalive", var)) {
 		keepalive = git_config_int(var, value);
 		if (!keepalive)
 			keepalive = -1;
-- 
1.9.1
