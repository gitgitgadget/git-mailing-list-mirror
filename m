From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 09/40] refs.c: make update_ref_write update a strbuf on failure
Date: Fri,  6 Jun 2014 15:28:47 -0700
Message-ID: <1402093758-3162-10-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:29:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2dm-0002Hb-3c
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbaFFW3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:29:33 -0400
Received: from mail-qg0-f74.google.com ([209.85.192.74]:44240 "EHLO
	mail-qg0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467AbaFFW3W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:22 -0400
Received: by mail-qg0-f74.google.com with SMTP id i50so225792qgf.5
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Og0ZjM9aVGUJxju4+YhtBx/h1MOGcf50KdioW0tLXsE=;
        b=j5UalvJQn70wUDxVq+5M/sX6I5VEdaLXrT5mwSCEoX0QMA/Z/4Uu8/546rLXKzJ1nx
         g/wGGj+fSvnwFWGCCD75d8BnK0iezbS476/Pr+lVZKkYsJQhNoGW4dIUaNk9J1Wyp3Ks
         mpmUuH9yXhZMwE8yusctQSuyVC0ctPBrezlbvYd8UWHApyCfocMHgOcxnmkaHBfwTXHx
         KI+D0sNDumuqGnM1o2IeAfAbsPeTJv0QuGvWnNVG3hfiOmvL3zDm3SsxXkAyiFzNB+up
         +02PNMHED8o32weInDhn61I7ROVcNVEGBWIYyoCJcf+KsNUuNOO8QoJTGngBja+MhNxc
         HtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Og0ZjM9aVGUJxju4+YhtBx/h1MOGcf50KdioW0tLXsE=;
        b=dMDunQmTM0Kwu5T2gkCqEDC6aN6gWi2CJ1LtybefLHHhd9pwdSPfUPImKG4qf6hQMR
         17KC6Wfw0J/8x+Vb42Y93Jcb1vFneIXwue51XfD4aNDFDFls11GiSM+wUbqiInKnsU8L
         jmk7ncCmrJs88AZ9mhrXy3qPwChLW4MqgUnirIkiGXMp8PsBTTYABwlWuIqwx8mHF2Og
         xbXWnJfkv6jXZd5ls3mo/0KfELtI0byDBadCvGC6oOxr2KWUx+iAnmArMpvmwQ2QyrZp
         tRX3KFPaUwTAIgwB+YUW8ThnCKVlcBUklwV9TGGqPobjgLXtXB7MPPz5iQJlBPYwQ8Y5
         VNmQ==
X-Gm-Message-State: ALoCoQmtEVxViUn9L8Gwl6xgsla6+3awLhltyGYZyVsp6UdtmYEEJ0Lh5tiE09wTHNsU7CZqD+Wd
X-Received: by 10.58.67.193 with SMTP id p1mr5351425vet.36.1402093762082;
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id xn6si751075vdc.2.2014.06.06.15.29.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id CFB565A44FE;
	Fri,  6 Jun 2014 15:29:21 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 90930E1084; Fri,  6 Jun 2014 15:29:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250975>

Change update_ref_write to also update an error strbuf on failure.
This makes the error available to ref_transaction_commit callers if the
transaction failed due to update_ref_sha1/write_ref_sha1 failures.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index dd498cf..6696082 100644
--- a/refs.c
+++ b/refs.c
@@ -3343,10 +3343,13 @@ static struct ref_lock *update_ref_lock(const char *refname,
 
 static int update_ref_write(const char *action, const char *refname,
 			    const unsigned char *sha1, struct ref_lock *lock,
-			    enum action_on_err onerr)
+			    struct strbuf *err, enum action_on_err onerr)
 {
 	if (write_ref_sha1(lock, sha1, action) < 0) {
 		const char *str = "Cannot update the ref '%s'.";
+		if (err)
+			strbuf_addf(err, str, refname);
+
 		switch (onerr) {
 		case UPDATE_REFS_MSG_ON_ERR: error(str, refname); break;
 		case UPDATE_REFS_DIE_ON_ERR: die(str, refname); break;
@@ -3467,7 +3470,7 @@ int update_ref(const char *action, const char *refname,
 	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
 	if (!lock)
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, onerr);
+	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
@@ -3549,7 +3552,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			ret = update_ref_write(msg,
 					       update->refname,
 					       update->new_sha1,
-					       update->lock, onerr);
+					       update->lock, err, onerr);
 			update->lock = NULL; /* freed by update_ref_write */
 			if (ret)
 				goto cleanup;
-- 
2.0.0.582.ge25c160
