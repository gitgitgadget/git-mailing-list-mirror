From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 08/27] refs.c: change ref_transaction_update() to do error checking and return status
Date: Mon, 28 Apr 2014 15:54:23 -0700
Message-ID: <1398725682-30782-9-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 00:56:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuSz-0006zr-H4
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591AbaD1Wyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:54:51 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:38350 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024AbaD1Wyt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:54:49 -0400
Received: by mail-qa0-f73.google.com with SMTP id m5so330372qaj.2
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 15:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ufkWRSFMe1iRn5jrpRuOgAjFsfI/HV8rREDuvE+VK5U=;
        b=BMLd0p4YL3r/0ugoVjNmUixto4dHxrhvgZmADCn5vgtgRizPegpXEnQJCwC6DsQcyt
         imm008FOZeajUDwAV0xz4c2oI7+ybVqa56xqYJ4pjm/pORp5BXPvT1OHW21MU0eFoWPO
         fm0PW3cOsFyz6rrTHzFcVW1inrsb5nCByE+gZN53zj7YlSHMur6/sMzAAi8UzMd9Z7RX
         296YW8Vw1Ec6yqpt10OAwlIDw9smM+W8DVEv6/wn7tvv92yCobxQS1FYfNoBxE70BQvX
         XKNT3nBkDx/G4oER3WgYF15kuPB1sGun1op9FHzwn2xl+RQzpHYDebYIkJ57tTsHUKax
         HFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ufkWRSFMe1iRn5jrpRuOgAjFsfI/HV8rREDuvE+VK5U=;
        b=YpxWdEuY82HPHRbfwuxrIJaWSXY7YmksSKy9YFqK5EIp9I5uGOIu5JtAATrvdYXGcw
         sc/6iEurqLMLccmxhQQXen0ae+2ygY4urCI+iW1n1cwEO1taDtgn8Ohfx+wHJViBLKxj
         eLtPi0VkK6UYd7WBb0q6+p9o7BmCgPPen4Td4krSEolW1NHJuNQNhAzMbuYdTos6DPw9
         pxitR9nVncSCS7uyKrU9eY8zfP8YWm6rheMt2nL4tGUKKxNcwzJrQn5ILufWP2D5gaLE
         P5I/RS31VVnUev7ND6MsVrZ4/TrQS9o1ORw5VxFFK9DTuNFhU8/9IBlB4FKSy/NdAzSD
         g/YQ==
X-Gm-Message-State: ALoCoQm+pVIIApSXAMzeFqBtkZe9xi4C1b8kl6pEsEC/w0tw22xNXdlInwYXov/AQTVJcd7fLAJ0C7L4/xE1i6G5UMslrTDyQbrpxTZrwWnjPA890pGopmB2gBzYZH7TNGraibnaPUH0zDh5BDwHOgPv3ydHKJEQs+26PoBsXOgKMTJLUiN2K0kya+vJZ+7exWi23epuUGdH
X-Received: by 10.236.141.11 with SMTP id f11mr4070658yhj.54.1398725688958;
        Mon, 28 Apr 2014 15:54:48 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r79si1917559yhj.2.2014.04.28.15.54.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:48 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B337731C20B;
	Mon, 28 Apr 2014 15:54:48 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6CEABE080D; Mon, 28 Apr 2014 15:54:48 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247476>

Update ref_transaction_update() do some basic error checking and return
true on error. Update all callers to check ref_transaction_update() for error.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 10 ++++++----
 refs.c               |  9 +++++++--
 refs.h               | 10 +++++-----
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 2bef2a0..59c4d6b 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -197,8 +197,9 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("update %s: extra input: %s", refname, next);
 
-	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
+				   update_flags, have_old))
+		die("update %s: failed", refname);
 
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
index 308e13e..1a903fb 100644
--- a/refs.c
+++ b/refs.c
@@ -3333,19 +3333,24 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
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
index bc7715e..0364a3e 100644
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
1.9.1.528.g98b8868.dirty
