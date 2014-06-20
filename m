From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 24/48] tag.c: use ref transactions when doing updates
Date: Fri, 20 Jun 2014 07:43:05 -0700
Message-ID: <1403275409-28173-25-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:46:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy05V-000410-F7
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228AbaFTOqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:46:20 -0400
Received: from mail-yk0-f202.google.com ([209.85.160.202]:39514 "EHLO
	mail-yk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209AbaFTOne (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:34 -0400
Received: by mail-yk0-f202.google.com with SMTP id 19so168306ykq.3
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vu98emqRo/sxNJolTqvVcJ2Z3OwIzN887tna1Rnk17s=;
        b=Sc6gyK3br/c9AWbwo9+qXlG7BYkXTGDttVR03L2IHUQcMBIWQaiKIKIDLfis0YrmyY
         tSHOEMaOmiAE2U7LaUR6cIhvXjbPTWFsnF44l2qj2GzSQw0GfZ4Ow9LKUv34Pc1MBxWY
         I0sDZn8bzNQb1I3k+qZQ6Iw5PKNDfMwMXl53wJ1T5uqiq5sCu4C0hdvN4a6joHEgbmYg
         9+Kx0eMEztTp8vxCjUUtCphQFcZT0a75DmGhXGMJvHgBs62hyADUcLGpczANxddFpCfd
         OBRbyrDr16ExDaXAaKJGVXmb5D2kL7fk6XXrgmqcxZlGhwKw91T0MZmt0qu8OCnESfxx
         //Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vu98emqRo/sxNJolTqvVcJ2Z3OwIzN887tna1Rnk17s=;
        b=JBZbQ3nzuZ1wUcXBM4Ttb7AjUHp1MWrVTbqwWDU+oulckW59nt3s4IRIAdhMZrFUSO
         VGYJ6r8f/KRat+NVaX+YMIthFHsiDnZDZRh4KJNiXUWNyTDGZWySKELv9ONyPJ0Hygt+
         vjAkZcvYaEFzzTeApZOvD0KjxEd2wL2Cp43cHet06CyjopEi3n6SwsMElyE9Hu1S/NF8
         um7st+M1vcu15e/AcfPsfgiIn2jWk6HoIfly8W7E1myrJtweibrxjrGGu1vkb8ZcnXu3
         XlzTk538lZsFH5ZhhWUt+MoeEq5HNB4hs4LcCLRxqYA7roS83zt0WQ9m8meaiPCac07J
         X7pw==
X-Gm-Message-State: ALoCoQl7T6LdqJF1aSIiOtrtIJHby2QQVCORJSA8Zu81Aubk/TE6f+0KxvAeLodgyJmAqxRvq/vY
X-Received: by 10.236.92.69 with SMTP id i45mr1330413yhf.20.1403275412919;
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o69si663695yhp.6.2014.06.20.07.43.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id C416431C6B5;
	Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A09FFE0769; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252263>

Change tag.c to use ref transactions for all ref updates.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/tag.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index c6e8a71..c9bfc9a 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -548,7 +548,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct strbuf ref = STRBUF_INIT;
 	unsigned char object[20], prev[20];
 	const char *object_ref, *tag;
-	struct ref_lock *lock;
 	struct create_tag_options opt;
 	char *cleanup_arg = NULL;
 	int annotate = 0, force = 0, lines = -1;
@@ -556,6 +555,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct commit_list *with_commit = NULL;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 	struct option options[] = {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
 		{ OPTION_INTEGER, 'n', NULL, &lines, N_("n"),
@@ -701,11 +702,13 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (annotate)
 		create_tag(object, tag, &buf, &opt, prev, object);
 
-	lock = lock_any_ref_for_update(ref.buf, prev, 0, NULL);
-	if (!lock)
-		die(_("%s: cannot lock the ref"), ref.buf);
-	if (write_ref_sha1(lock, object, NULL) < 0)
-		die(_("%s: cannot update the ref"), ref.buf);
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref.buf, object, prev,
+				   0, !is_null_sha1(prev), &err) ||
+	    ref_transaction_commit(transaction, NULL, &err))
+		die("%s", err.buf);
+	ref_transaction_free(transaction);
 	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
 
-- 
2.0.0.420.g181e020.dirty
