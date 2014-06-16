From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 26/48] replace.c: use the ref transaction functions for updates
Date: Mon, 16 Jun 2014 11:03:57 -0700
Message-ID: <1402941859-29354-27-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:05:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbHl-0004PJ-SO
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932757AbaFPSFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:05:32 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:35377 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932649AbaFPSEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:25 -0400
Received: by mail-qa0-f74.google.com with SMTP id w8so852003qac.5
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pyJCGlpM8KFrYfpgoEEKGQNUIU5A3vnn5okV4fAF5VU=;
        b=NeKBh+BjjrWYMlHQ7OoV2F/+VwqMKZWbKVcOfAHV/w0deqmpA18AgA/4cr1AD8Rg3j
         Wrtqh8ZrcWPwzHhPOBZ4/WmD/2YHrFmjCSDeQj19+41YhcKOT6Xm/8LF5dqhxBUIRpqi
         qwnXuZVZn0U3B2bo0eTPrFBMfwizxMOtHaxU+4B/Ojxw0KcgIh5Ro15YCv0Q3XGXxAK8
         rnUt5G+dRueIyILttqKeby9iDfVrnyPQx+zxOx3vR50Ktjz17bD0d/T+e10OYtLuK+1s
         fY+sUa4pl63yhTILl4o4wkRj78COE8+HSGBWu/SU/E0W8VktzImBm+thyd/zuNWF7Xm4
         A+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pyJCGlpM8KFrYfpgoEEKGQNUIU5A3vnn5okV4fAF5VU=;
        b=BmgB95AsvTCKHfOz+SwfWVi0yvV6zRXh5I61/W4KMnexUTYk8EtY1LbvwhoU/t6GRw
         jy265MS/wCxQYzXTYYiEI4jEEkx5ME+tK2fLd0ebHw5sTr+F5TX5oWicyO14U7lPqJpP
         VCuIVoLDVAgd9Te+7OLgZNOb8HnqxepqNI2wcvgaq31LTNYo5B7gFgNal8TC+punifdF
         sINd8OB74b9pOgFhFxo+0vfNrroITcLjWG5WvEKCCNWc9zQ63cdyr/MD6Nje9u4Fru/V
         TjbayKVT4kDmngR1XmSivlgtiNzm9WGpgC4xM4P7P5BXYhL/5u24+InfPp7jWh6rGN+2
         H1Yw==
X-Gm-Message-State: ALoCoQlh69TeAB6HodWIluB56jRyEZuX+byK8vOgxuTCLkl1ZT0pwqM34FgfaS3EfoLG78YnsMEx
X-Received: by 10.58.94.166 with SMTP id dd6mr1235863veb.12.1402941863327;
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si996131yhl.7.2014.06.16.11.04.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 3164A5A490D;
	Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0FD87E05A0; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251750>

Update replace.c to use ref transactions for updates.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/replace.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index b62420a..24f0dc9 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -129,7 +129,8 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 	unsigned char object[20], prev[20], repl[20];
 	enum object_type obj_type, repl_type;
 	char ref[PATH_MAX];
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
 	if (get_sha1(object_ref, object))
 		die("Failed to resolve '%s' as a valid ref.", object_ref);
@@ -157,12 +158,14 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 	else if (!force)
 		die("replace ref '%s' already exists", ref);
 
-	lock = lock_any_ref_for_update(ref, prev, 0, NULL);
-	if (!lock)
-		die("%s: cannot lock the ref", ref);
-	if (write_ref_sha1(lock, repl, NULL) < 0)
-		die("%s: cannot update the ref", ref);
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref, repl, prev,
+				   0, !is_null_sha1(prev), &err) ||
+	    ref_transaction_commit(transaction, NULL, &err))
+		die("%s", err.buf);
 
+	ref_transaction_free(transaction);
 	return 0;
 }
 
-- 
2.0.0.282.g3799eda.dirty
