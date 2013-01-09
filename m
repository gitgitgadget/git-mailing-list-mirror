From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH 07/19] reset.c: extract function for updating {ORIG,}HEAD
Date: Wed,  9 Jan 2013 00:16:04 -0800
Message-ID: <1357719376-16406-8-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 09:25:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsqy7-0002mI-Pj
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 09:25:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757405Ab3AIIYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 03:24:45 -0500
Received: from mail-vb0-f74.google.com ([209.85.212.74]:58050 "EHLO
	mail-vb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757273Ab3AIIYo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 03:24:44 -0500
Received: by mail-vb0-f74.google.com with SMTP id s24so191470vbi.3
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 00:24:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=s7b6tF9Cdkau6Cvt2UEcui155jFXeP4KX0hhBtHesD0=;
        b=O/i409RoH+vDg+zSycjDLmmBydaCubWWCJ/2iuo+W14+//Nzpxd27DuldDI7/+gKz9
         yWBbkg0N9zLVm9zmspsc9mD9820J9NnpL2typq2a4DStvKuquVfv2esJqXibKVjhW4y0
         8UmgTQk28OSZOcU1usDt5VePKPyh9mNy+3dHsTcpV4v6IJ1CaR+xcLCWFyvpo/JNr5Qb
         qDPbTXj791fLwtgiK4RoJCjz6zcqvC+wTsGEer0XB17fAwmhphAGMpXlUPcTyiWhtMBh
         Q57gMvK9wSSL5cWIWqP1p0nVawV9H1kbJhd4ITXQGXyFUsL2EkLTBlN33IyCMZ7yfYYB
         g/Ig==
X-Received: by 10.236.116.10 with SMTP id f10mr37512629yhh.9.1357719424689;
        Wed, 09 Jan 2013 00:17:04 -0800 (PST)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id r10si2900953ann.1.2013.01.09.00.17.04
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 09 Jan 2013 00:17:04 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 9331782004A;
	Wed,  9 Jan 2013 00:17:04 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 19E94102FBC; Wed,  9 Jan 2013 00:17:04 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.331.g1ef2165
In-Reply-To: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQlcSHU8piFo4Uqq9HiaMMLhjQDz1irH0ZIYgF4RmUORvjYuR7mssU9hye83SOgPr4p9B4bIP8BtUa9KOOeskuCDbipqAipL8cmkV5RNI7HEQ1VkTWepyosI37YhwGH26rIe73ev0ayHJyxGlBOYgO0MYOkSMxfF+LlK3Z/VB/R/w2u/8rHMPwia1ZSGa4ivzh4Aq88v
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213045>

By extracting the code for updating the HEAD and ORIG_HEAD symbolic
references to a separate function, we declutter cmd_reset() a bit and
we make it clear that e.g. the four variables {,sha1_}{,old_}orig are
only used by this code.
---
 builtin/reset.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 68be05c..4d556e7 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -239,16 +239,35 @@ const char **parse_args(int argc, const char **argv, const char *prefix, const c
 	return *argv ? get_pathspec(prefix, argv) : NULL;
 }
 
+static int update_refs(const char *rev, const unsigned char *sha1) {
+	int update_ref_status;
+	struct strbuf msg = STRBUF_INIT;
+	unsigned char *orig = NULL, sha1_orig[20],
+		*old_orig = NULL, sha1_old_orig[20];
+
+	if (!get_sha1("ORIG_HEAD", sha1_old_orig))
+		old_orig = sha1_old_orig;
+	if (!get_sha1("HEAD", sha1_orig)) {
+		orig = sha1_orig;
+		set_reflog_message(&msg, "updating ORIG_HEAD", NULL);
+		update_ref(msg.buf, "ORIG_HEAD", orig, old_orig, 0, MSG_ON_ERR);
+	}
+	else if (old_orig)
+		delete_ref("ORIG_HEAD", old_orig, 0);
+	set_reflog_message(&msg, "updating HEAD", rev);
+	update_ref_status = update_ref(msg.buf, "HEAD", sha1, orig, 0, MSG_ON_ERR);
+	strbuf_release(&msg);
+	return update_ref_status;
+}
+
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int reset_type = NONE, update_ref_status = 0, quiet = 0;
 	int patch_mode = 0;
 	const char *rev;
-	unsigned char sha1[20], *orig = NULL, sha1_orig[20],
-				*old_orig = NULL, sha1_old_orig[20];
+	unsigned char sha1[20];
 	const char **pathspec = NULL;
 	struct commit *commit;
-	struct strbuf msg = STRBUF_INIT;
 	const struct option options[] = {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
 		OPT_SET_INT(0, "mixed", &reset_type,
@@ -332,17 +351,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	/* Any resets update HEAD to the head being switched to,
 	 * saving the previous head in ORIG_HEAD before. */
-	if (!get_sha1("ORIG_HEAD", sha1_old_orig))
-		old_orig = sha1_old_orig;
-	if (!get_sha1("HEAD", sha1_orig)) {
-		orig = sha1_orig;
-		set_reflog_message(&msg, "updating ORIG_HEAD", NULL);
-		update_ref(msg.buf, "ORIG_HEAD", orig, old_orig, 0, MSG_ON_ERR);
-	}
-	else if (old_orig)
-		delete_ref("ORIG_HEAD", old_orig, 0);
-	set_reflog_message(&msg, "updating HEAD", rev);
-	update_ref_status = update_ref(msg.buf, "HEAD", sha1, orig, 0, MSG_ON_ERR);
+	update_ref_status = update_refs(rev, sha1);
 
 	switch (reset_type) {
 	case HARD:
@@ -359,7 +368,5 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	remove_branch_state();
 
-	strbuf_release(&msg);
-
 	return update_ref_status;
 }
-- 
1.8.1.rc3.331.g1ef2165
