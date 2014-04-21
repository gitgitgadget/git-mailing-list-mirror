From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 06/13] tag.c: use ref transactions when doing updates
Date: Mon, 21 Apr 2014 15:53:24 -0700
Message-ID: <1398120811-20284-7-git-send-email-sahlberg@google.com>
References: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 00:54:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcN6a-0008HG-Vu
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 00:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754969AbaDUWyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 18:54:24 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:65310 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756AbaDUWxm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 18:53:42 -0400
Received: by mail-ie0-f202.google.com with SMTP id lx4so1012813iec.1
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 15:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bacrWEzSnjNdaVQ9cMlANU0uzCLviOrTasflYVtewz0=;
        b=mASIM5wHVhvheMOaHKrPxNsLBBroVw2y+NJdl1g4RxKrUqo2wyM5UboqEMK5eP0/Px
         eJ1wEO+6L7Yid1arS9z7pfPiF2+vMHtRGzV+xDGeu+DG3jELX9DDpEhVG6VBZktaeZMf
         sEwhNeAqCySIpwx7XDX1cpmMVKBjisAPXU+5Zc69WGCb8n9WBR5EPRqEbipPrYkob8z6
         Wba9KWS+LjbDCAwQ2PgI5J6Qi3SuWTP+EQZgj4opu+XODsJDArLjXcYYUjXd7b8pGHJK
         xByrAj4w78kxp+z+yaW2hgtMMVwWeBw/vnFNSzL8eS7yi5rLvHU5Z6HwbeEPFSI3yOKU
         sZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bacrWEzSnjNdaVQ9cMlANU0uzCLviOrTasflYVtewz0=;
        b=f4J4qoZ8Dlt252DfYi1AaxhCG+7m1gRQVAiQ2vmAe4M4+IWm0d1gwcPIvi4EXnjN1B
         il9h9/iMzL/kC9OUr80itzKCc/wt2DNagakAnn7hWCXSYgluRoK0dHU63tgggPNMOloP
         IoUVvGnYfc1FLAtoay825miJKghrtrQYTE+BJLQ/ReFO1g2YNXS9sU8BPQDP+GcPBiLN
         HvV8Wm1/4M4NzSgYzuhiGWv+e0rJl+0C/bN4Dsff/9xJz5R/2tHZPhJelCWm3355F8Ca
         lSHubRaUYF4NBSpnA5PFAr5eivSfZ2xt4lcvVLdsZeCGgRppGgEicujohXpSOlOHicHA
         pP/w==
X-Gm-Message-State: ALoCoQmNlpKGaReDFb3rQrveUnSCTWryykCNxJYzlCkW/fWqLDixW/94oqX9IOobJAyo1lqGNQ+kVSZIaxcJnT/SzGhMFGJbv87axP/Wm/WOaQV7z2AjV1lF9ayP+U2M134iY9kLibUj2YO/rKa/Ldz9T/1MNxSdXnmuV66y0DhRBL2q5J3aXDxZ9fOwt7H+HUEsa7DdlytJ
X-Received: by 10.50.51.68 with SMTP id i4mr11813719igo.5.1398120821636;
        Mon, 21 Apr 2014 15:53:41 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si1894195yhk.4.2014.04.21.15.53.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Apr 2014 15:53:41 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 596485A4207;
	Mon, 21 Apr 2014 15:53:41 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1DA00E06AA; Mon, 21 Apr 2014 15:53:41 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.515.g3b87021
In-Reply-To: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246669>

Change tag.c to use ref transactions for all ref updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/tag.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 40356e3..3c40957 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -488,7 +488,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct strbuf ref = STRBUF_INIT;
 	unsigned char object[20], prev[20];
 	const char *object_ref, *tag;
-	struct ref_lock *lock;
 	struct create_tag_options opt;
 	char *cleanup_arg = NULL;
 	int annotate = 0, force = 0, lines = -1;
@@ -496,6 +495,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct commit_list *with_commit = NULL;
+	struct ref_transaction *transaction;
 	struct option options[] = {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
 		{ OPTION_INTEGER, 'n', NULL, &lines, N_("n"),
@@ -641,10 +641,11 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (annotate)
 		create_tag(object, tag, &buf, &opt, prev, object);
 
-	lock = lock_any_ref_for_update(ref.buf, prev, 0, NULL);
-	if (!lock)
-		die(_("%s: cannot lock the ref"), ref.buf);
-	if (write_ref_sha1(lock, object, NULL) < 0)
+	transaction = ref_transaction_begin();
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref.buf, object, prev,
+				   0, !is_null_sha1(prev)) ||
+	    ref_transaction_commit(transaction, NULL, UPDATE_REFS_DIE_ON_ERR))
 		die(_("%s: cannot update the ref"), ref.buf);
 	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
-- 
1.9.1.515.g3b87021
