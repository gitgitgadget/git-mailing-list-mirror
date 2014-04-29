From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 10/30] refs.c: ref_transaction_delete to check for error and return status
Date: Tue, 29 Apr 2014 15:18:55 -0700
Message-ID: <1398809955-32008-11-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:20:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGOQ-000335-2A
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965345AbaD2WUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:20:37 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:45739 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965270AbaD2WTW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:22 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so140608qcz.2
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Sw0zmowZq2P3FwSTHUf7wvDPeq8L20Q59CsCMXs4L4=;
        b=b7lN+LN5wcR9KQ5fyYyli2Fi2L+NUnvigu6Wy66pnXg/NjyGYfATm5miR3sb3cLcH5
         UN4CSt1n2HrsPOTlCJbPyFBtwSSCLLKuE6RZtjCCYYIKbU6y1XjPZusUXJmTVuMfeZ6S
         5jpMGxssswxUJ3QuRxwyWEBfIkWlW6gYJ5yqfrqmO2UQamitsZUwh5oIYudAqKeToLEL
         haxvgwhmI06rokwMeZrLCXtub/qfx/tOePSQV+l9AxIKiLhCui44RLNocXQqenIiIzX9
         m7fo4a9ORu4qvPIpQ4nvYjl9KC85++ScFno/vDcngg3F4A73b1CWHke9b5aqMVnY2G9d
         IoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2Sw0zmowZq2P3FwSTHUf7wvDPeq8L20Q59CsCMXs4L4=;
        b=RbdHZXJy2z8Guv6qAzW7DsTFEj2ec/rL8XQcT5jHhvtEQyQBxzllKtMWGEjJ9iMCxP
         BaD/BWqVMGdLXySnWUIAMbj/NEv9y1Fjsl+oXUIYCnEweWA58hMpymvY7ocC9KNLAfoL
         +cNZmpbbfue1KTbMdp1KkHhIhmrBgrBDBij/4LJGY0HYSWT/DNJsP5sXQGmhBjxCgpwR
         QRHPThZXdo1rAJGgPAD71cuzOt6suxPn8hNaV2YsNmyJ5yCzMeRI41VJ2EU3MtQpnJGB
         e4Yubg6D3lDUjfEYdpxZ6KjRnKlNtlLXBBcY320L9GcAthtmWp9FZIR0lp5pFnnj6UfM
         zhCw==
X-Gm-Message-State: ALoCoQnZ1EFSQR3lLhp1s30Wxzh+JURv9FjAKoOGlzVth7CTz6m3WQK6gQdtqjunheeZAJ6f1yhAPTrnbXB/oZ/8nalET8Aq3V5EMvgZlkRITAy6Db9D0FRiAs7P9lyLFADGngrRuY1ga5QvcMnCKIFOmjhinSKaqiQr17CeDEVm6kMp0T0YL5yzQYUHnLhWbQgY+M5XEcMb
X-Received: by 10.58.195.202 with SMTP id ig10mr332530vec.38.1398809961826;
        Tue, 29 Apr 2014 15:19:21 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id x22si2738713yhd.5.2014.04.29.15.19.21
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:21 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A731D5A4121;
	Tue, 29 Apr 2014 15:19:21 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6C1EAE0A5B; Tue, 29 Apr 2014 15:19:21 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247644>

Change ref_transaction_delete() to do basic error checking and return
status. Update all callers to check the return for ref_transaction_delete()
There are currently no conditions in _update that will return error but there
will be in the future.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  5 +++--
 refs.c               | 15 ++++++++++-----
 refs.h               |  8 ++++----
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 3fab810..fc3512f 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -257,8 +257,9 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("delete %s: extra input: %s", refname, next);
 
-	ref_transaction_delete(transaction, refname, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_delete(transaction, refname, old_sha1,
+				   update_flags, have_old))
+		die("failed transaction delete for %s", refname);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index 27db737..0a4e28e 100644
--- a/refs.c
+++ b/refs.c
@@ -3372,19 +3372,24 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	return 0;
 }
 
-void ref_transaction_delete(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old)
+int ref_transaction_delete(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old)
 {
-	struct ref_update *update = add_update(transaction, refname);
+	struct ref_update *update;
 
+	if (have_old && !old_sha1)
+		die("have_old is true but old_sha1 is NULL");
+
+	update = add_update(transaction, refname);
 	update->flags = flags;
 	update->have_old = have_old;
 	if (have_old) {
 		assert(!is_null_sha1(old_sha1));
 		hashcpy(update->old_sha1, old_sha1);
 	}
+	return 0;
 }
 
 int update_ref(const char *action, const char *refname,
diff --git a/refs.h b/refs.h
index 01d773c..5eb500e 100644
--- a/refs.h
+++ b/refs.h
@@ -259,10 +259,10 @@ int ref_transaction_create(struct ref_transaction *transaction,
  * old_sha1 holds the value that the reference should have had before
  * the update (which must not be the null SHA-1).
  */
-void ref_transaction_delete(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old);
+int ref_transaction_delete(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old);
 
 /*
  * Commit all of the changes that have been queued in transaction, as
-- 
1.9.1.532.gf8485a6
