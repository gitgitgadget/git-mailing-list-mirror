From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 15/41] refs.c: make ref_transaction_begin take an err argument
Date: Tue, 27 May 2014 13:25:34 -0700
Message-ID: <1401222360-21175-16-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:27:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNyK-0004MU-En
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497AbaE0U1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:27:39 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:64236 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911AbaE0U0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:05 -0400
Received: by mail-ve0-f202.google.com with SMTP id pa12so1645655veb.5
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F0k7fUoO1QUv1shjO+aAhbnCloQRBO6ZozdyJs1WkC8=;
        b=VaydhYG0NzyxEg1BpeTQKN44yO2zVz4yfdx5Qp8xrvfWtUtnPKtOdhJ+InXT8HG5AP
         xxVxGENeJQYbkPkaGlSPW5P1w/f+H61GqgcOLblrec7j1QfoXK2kVjW/UUpCM3nDLOzo
         FPopiMvWJxI2ZRaAP6CljGXTcbbhPkiu6Ulg5iqSPCA1hCTDjssaIDmCmvH6DENFGxga
         u6sLnX4dqPJ7qHBi+w4+pGcrsdejuNfh9sCw2unM13DncQk7JLOMSCHqzWh6aQbSJjTk
         k3Zc6hB8v9wmqhemgq8p3sWJYy6T8Bhgbw6SzPzQuyWzLjcURAwH+SR76pFNl1PFv81K
         xxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F0k7fUoO1QUv1shjO+aAhbnCloQRBO6ZozdyJs1WkC8=;
        b=eFqTEhBjpZfgUucHu6iBXGN6YTCTsDVMatOg30N8HEL7/2kKayO+OXZ5uhAKP8+dTa
         VLGjc6Z7fccEdwsj/fT1GgRr3ejoVrZOhsE+4FKaDhsgfXgwf9LfK5lPkCf+CVzz/S70
         9YNBM7uFcMwnyRIvni/LuW9otLx+xUdH5yWVAAD3g0GkuNwKlqDVUrsk/5Cv1jpJcNER
         xZjTxSfLYtSZhOrM64xKM3IuiyngWUiDnDXpRTzCIcRcUehbaZ8GBeEiv41IUqZY5FCv
         QHv/+A5nAfYEy3UsoTBn6+4GbI+LqZZCIhvuAIYDV1bH6BmR3XnEQeTG6zcyEJn6zxWZ
         5vmQ==
X-Gm-Message-State: ALoCoQkcsc0R2NwQSNpWryCd81DKR0s1NHUOIXWKBRhWvxpXckUWjUjNFWD0HQF11YT7XrEBN98u
X-Received: by 10.58.187.107 with SMTP id fr11mr15437913vec.34.1401222364310;
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si1574643yhj.5.2014.05.27.13.26.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 278FB2F4ACE;
	Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id EE044E0D62; Tue, 27 May 2014 13:26:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250222>

Add an err argument to _begin so that on non-fatal failures in future ref
backends we can report a nice error back to the caller.
While _begin can currently never fail for other reasons than OOM, in which
case we die() anyway, we may add other types of backends in the future.
For example, a hypothetical MySQL backend could fail in _being with
"Can not connect to MySQL server. No route to host".

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 2 +-
 refs.c               | 2 +-
 refs.h               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 7c9c248..c6ad0be 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -365,7 +365,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
-		transaction = ref_transaction_begin();
+		transaction = ref_transaction_begin(&err);
 		if (delete || no_deref || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
diff --git a/refs.c b/refs.c
index beddce0..1c660e0 100644
--- a/refs.c
+++ b/refs.c
@@ -3345,7 +3345,7 @@ struct ref_transaction {
 	size_t nr;
 };
 
-struct ref_transaction *ref_transaction_begin(void)
+struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 {
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
diff --git a/refs.h b/refs.h
index e0ab989..6c830f2 100644
--- a/refs.h
+++ b/refs.h
@@ -227,7 +227,7 @@ enum action_on_err {
  * Begin a reference transaction.  The reference transaction must
  * be freed by calling ref_transaction_free().
  */
-struct ref_transaction *ref_transaction_begin(void);
+struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 
 /*
  * The following functions add a reference check or update to a
-- 
2.0.0.rc3.474.g0203784
