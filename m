From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 07/19] reset.c: extract function for updating {ORIG_,}HEAD
Date: Mon, 14 Jan 2013 21:47:39 -0800
Message-ID: <1358228871-7142-8-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Matt Kraai <kraai@ftbfs.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 06:55:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuzUe-0003zQ-Gj
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 06:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606Ab3AOFzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 00:55:06 -0500
Received: from mail-qa0-f74.google.com ([209.85.216.74]:60440 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156Ab3AOFzF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 00:55:05 -0500
Received: by mail-qa0-f74.google.com with SMTP id r4so345672qaq.1
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 21:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=KegPV22PZzYyF9FueLHXYOyiizLGSLlvKHg3ZwV6HQo=;
        b=Zc54I468fM+jtLJranaAjjY0glF6eKku/3vf7p2jNJj0PjnQ9MMoAK3hAwgT8/2Kz+
         sUgRafXrL7zdCtRT70zBlWANHN00Hez5nUEahCekoklGHNV6/vhOql4OTR/0oZyJy0OC
         lb87bgl1fp3504L+6lSQKnejQ6qx/OOdWiCcA95ZSsIChDl+mwCorSYFKIR6UOQPy0w9
         OV8/3adA32IohrU+w9JxIs3yKYFylr0Hlp8Oq+YXnqbJEn7TEQ9X1i59Vg64eV0xjzvF
         WfYL97jqR1HT5O9XFh6I2WxrWH6pUltGSLCjKpwJ0rEC1pafHXKYloOzN52PxLuW4wku
         sA8w==
X-Received: by 10.236.139.105 with SMTP id b69mr48288026yhj.31.1358228906659;
        Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id x63si231939yhl.2.2013.01.14.21.48.26
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 811F75A4173;
	Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 08B9F1012DC; Mon, 14 Jan 2013 21:48:25 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.454.gce43f05
In-Reply-To: <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQmreWldxXRVJ9qu4/yvZIVuSmtdQjAqmPvspT2nVHYMHNnL7NdU3ia7kztTnoGhs+QVdD6JtPzd7kO9bJN6OAwVNJXW9tvIgf8yzsxvCbGZZYkOuICcvgP80xsEi7L3M3sE5xT1t1ms0dnIWi5TbcBjD9YwFgxNRZGRRdxOZLpwjORFO5Vpqcp9etpAMBx9m8sZRDJV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213589>

By extracting the code for updating the HEAD and ORIG_HEAD symbolic
references to a separate function, we declutter cmd_reset() a bit and
we make it clear that e.g. the four variables {,sha1_}{,old_}orig are
only used by this code.

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
 builtin/reset.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index d89cf4d..2187d64 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -240,16 +240,35 @@ static const char **parse_args(const char **argv, const char *prefix, const char
 	return argv[0] ? get_pathspec(prefix, argv) : NULL;
 }
 
+static int update_refs(const char *rev, const unsigned char *sha1)
+{
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
+	} else if (old_orig)
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
@@ -333,17 +352,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
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
@@ -360,7 +369,5 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	remove_branch_state();
 
-	strbuf_release(&msg);
-
 	return update_ref_status;
 }
-- 
1.8.1.1.454.gce43f05
