From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 03/13] refs.c: change ref_transaction_update() to do error checking and return status
Date: Mon, 21 Apr 2014 15:53:21 -0700
Message-ID: <1398120811-20284-4-git-send-email-sahlberg@google.com>
References: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 00:54:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcN6O-000864-3Q
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 00:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892AbaDUWyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 18:54:08 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:48288 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754734AbaDUWxk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 18:53:40 -0400
Received: by mail-pd0-f201.google.com with SMTP id x10so613464pdj.4
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 15:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tOWwfCNvW4/2lmIKSDxpYwkB4zb5PkisGiqWmP3vCwo=;
        b=EKjx1HKICKn3jN/93TMwjY/FDVbo4A+Eigzj90Annp9cEd1Zi4HcpMaw4V5msF/Scp
         lL1vom0XNOpam55+MCdrCNX7NMMEA/oYQPwV8QDo8Vonymdq/PnZOdq9893lA5hvBM+d
         z7obToNP5iEgfSkEe55tHbCVB3X/7irQa2uPiMUB3huhkyVW8UWt3C6WGQ9Kwf760dph
         xhw94uCADOUtunYddhvwUjQXJEpuvfRRcWkSqdRymi5gMxlgZWHoSlSXo3jk94gwu4yD
         heXTZPMx0XcLQ+j8RhLbtBqwWtBputKPVCk+YHn08DBOwmm0oCkQNu2u4gvWUmQRAmR5
         +KXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tOWwfCNvW4/2lmIKSDxpYwkB4zb5PkisGiqWmP3vCwo=;
        b=aCq6SggXAPy1i0WHXJe9XRwyIjXIBNNGlM8fL8AUUMyhc92sWNS5Ut75JW+ILwXVsK
         0bf39GNz6ZiRBMLShIij9P+wpjg9Lotv8igCFoEmGm1sKymzD2t70pU5TsW5W68B5Gwx
         v5afKIckFR+NnkPER1mm3PghCAT2ySOysqJicE+Sd952ss4lt7w4KEiLNYsUavemo8uw
         lJUn3YbOHFqZP7aGCc+x6AiW2DPFF6G0C7t4N58xkgBrosg0tJSv0nWtlcSMiZ9gyyy9
         88aQdUX/u/Om7z++hlLeNSNHnR0ByFi+F5OUpOs+2RYhczLQTSOEJNEnwDH7TwhAfTMq
         Py8Q==
X-Gm-Message-State: ALoCoQmiEQh3qRbs6w3ZJQhSdYPeDTOQF+nDGcb+bHE+dPAMa7kSadYzzmApQFpXdpuB4YqvezOdOdfviOob3eCcCYDSllGpPlNtTa6kS48qsDPTUZ0drEKwrakBQsO4GDpKKi98A98se9m+5+XHW//bbUi5kvVCL/YXGOaWHk2wNCOgjfSNrK69OTK7BCBlFoCTFYERTdSp
X-Received: by 10.66.232.38 with SMTP id tl6mr21231829pac.33.1398120819449;
        Mon, 21 Apr 2014 15:53:39 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id x22si5367141yhd.5.2014.04.21.15.53.39
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Apr 2014 15:53:39 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 3DBB55A4207;
	Mon, 21 Apr 2014 15:53:39 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id F245EE06AA; Mon, 21 Apr 2014 15:53:38 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.515.g3b87021
In-Reply-To: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246665>

Update ref_transaction_update() do some basic error checking and return
true on error. Update all callers to check ref_transaction_update() for error.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 10 ++++++----
 refs.c               |  9 +++++++--
 refs.h               | 10 +++++-----
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 405267f..811e0b0 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -197,8 +197,9 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("update %s: extra input: %s", refname, next);
 
-	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
+				   update_flags, have_old))
+		die("failed transaction update for %s", refname);
 
 	update_flags = 0;
 	free(refname);
@@ -286,8 +287,9 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("verify %s: extra input: %s", refname, next);
 
-	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
+				   update_flags, have_old))
+		die("failed transaction update for %s", refname);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index 9daf89e..8c02779 100644
--- a/refs.c
+++ b/refs.c
@@ -3327,19 +3327,24 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 	return update;
 }
 
-void ref_transaction_update(struct ref_transaction *transaction,
+int ref_transaction_update(struct ref_transaction *transaction,
 			    const char *refname,
 			    const unsigned char *new_sha1,
 			    const unsigned char *old_sha1,
 			    int flags, int have_old)
 {
-	struct ref_update *update = add_update(transaction, refname);
+	struct ref_update *update;
+
+	if (have_old && !old_sha1)
+		die("have_old is true but old_sha1 is NULL");
 
+	update = add_update(transaction, refname);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
 	update->have_old = have_old;
 	if (have_old)
 		hashcpy(update->old_sha1, old_sha1);
+	return 0;
 }
 
 void ref_transaction_create(struct ref_transaction *transaction,
diff --git a/refs.h b/refs.h
index 892c5b6..00e4f7b 100644
--- a/refs.h
+++ b/refs.h
@@ -237,11 +237,11 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
  * that the reference should have had before the update, or zeros if
  * it must not have existed beforehand.
  */
-void ref_transaction_update(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old);
+int ref_transaction_update(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old);
 
 /*
  * Add a reference creation to transaction.  new_sha1 is the value
-- 
1.9.1.515.g3b87021
