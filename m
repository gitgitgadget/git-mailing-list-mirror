From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 32/48] receive-pack.c: use a reference transaction for updating the refs
Date: Tue, 10 Jun 2014 15:29:20 -0700
Message-ID: <1402439376-25839-33-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:37:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUaI-0006ZG-1a
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811AbaFJWbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:31:39 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:63108 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530AbaFJW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:42 -0400
Received: by mail-ve0-f202.google.com with SMTP id oz11so493864veb.5
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EUIr9L/Xy/KyqBIm1t5bC9Vc4M//WTKUKpiy+ReZ7f8=;
        b=kzQ6ZVyJ6WvQ58/iDm/VMopTyfwH4fWXBJvJnfQyWpAAvlmD3LVGBxDpsN28NPcOxn
         1iPSLukHsvQEhanREyFnoXECQn4VxmRQEB9VI3qr8uYFzZ9omCTkyUuZOKubxj2oIGv+
         MR345yZAdh6U6o3kvmlJ/E1DTYehqyd3/p3ZRB/Q83FtGpZeDe+lLmbuvuC6TvQWjVIj
         KNILZLZcgko9cpYvortxqDQ6sUsbuUNRoqwr1BvUJCdNmE7VO3ye8Is/M9V2nNtC/K3G
         AvCkQEcHd7Jrs4wVtmJ9UqhLWMoxhSI2tvGlaiZL/ul983dvS+iVqm4HPoYvhUJENO1D
         6i0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EUIr9L/Xy/KyqBIm1t5bC9Vc4M//WTKUKpiy+ReZ7f8=;
        b=OM3UdgxoPuPhPehi/5gud2RSnDPJuk8pzM9w5FAun67Zq8PhnYG9Jgn8/221j2CahH
         FAFKkawK//v24Fgp+dTrxe0aNnGiqUkktTygB3JOMINhpdP6/gVRUdowVjPbzvqX2fpy
         b/gu1AEiA/JI6FSPWedB1SCe+KJs5IJ4VAJ5xgfstqz5Ft/F4aNCRnuQh5t069mIPqTl
         hfUfx0HQdqoqZHL6aIP3DK0hMF8PDpWG7drJzGluKPxC2AJWMnhcT2UEruYgu9Df97yo
         9/n/m96hVx06EmGxZQr1DHKhaQqF8+7dF+oOAIkzMUxmic2YqWQLwOvqVuRGCpVcDuY6
         VFog==
X-Gm-Message-State: ALoCoQkSVmB8hIWZdxxBFjO/l5oHrp//WlsbDy52jXSmSkLcfEJNOzdGl6d8Cv2d4WLk6BjHEFPk
X-Received: by 10.236.134.49 with SMTP id r37mr6454711yhi.14.1402439381252;
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si1394553yhl.7.2014.06.10.15.29.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 2044B5A46F1;
	Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0117DE0616; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251277>

Wrap all the ref updates inside a transaction.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/receive-pack.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c323081..13f4a63 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -46,6 +46,7 @@ static void *head_name_to_free;
 static int sent_capabilities;
 static int shallow_update;
 static const char *alt_shallow_file;
+static struct string_list error_strings = STRING_LIST_INIT_DUP;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -475,7 +476,6 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	const char *namespaced_name;
 	unsigned char *old_sha1 = cmd->old_sha1;
 	unsigned char *new_sha1 = cmd->new_sha1;
-	struct ref_lock *lock;
 
 	/* only refs/... are allowed */
 	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
@@ -576,19 +576,31 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		return NULL; /* good */
 	}
 	else {
+		struct strbuf err = STRBUF_INIT;
+		struct ref_transaction *transaction;
+
 		if (shallow_update && si->shallow_ref[cmd->index] &&
 		    update_shallow_ref(cmd, si))
 			return "shallow error";
 
-		lock = lock_any_ref_for_update(namespaced_name, old_sha1,
-					       0, NULL);
-		if (!lock) {
-			rp_error("failed to lock %s", name);
-			return "failed to lock";
-		}
-		if (write_ref_sha1(lock, new_sha1, "push")) {
-			return "failed to write"; /* error() already called */
+		transaction = ref_transaction_begin(&err);
+		if (!transaction ||
+		    ref_transaction_update(transaction, namespaced_name,
+					   new_sha1, old_sha1, 0, 1, &err) ||
+		    ref_transaction_commit(transaction, "push", &err)) {
+
+			const char *str;
+			string_list_append(&error_strings, err.buf);
+			str = error_strings.items[error_strings.nr - 1].string;
+			strbuf_release(&err);
+
+			ref_transaction_free(transaction);
+			rp_error("%s", str);
+			return str;
 		}
+
+		ref_transaction_free(transaction);
+		strbuf_release(&err);
 		return NULL; /* good */
 	}
 }
@@ -1215,5 +1227,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		packet_flush(1);
 	sha1_array_clear(&shallow);
 	sha1_array_clear(&ref);
+	string_list_clear(&error_strings, 0);
 	return 0;
 }
-- 
2.0.0.574.g30c2c5e
