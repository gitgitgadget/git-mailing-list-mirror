From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 04/30] refs.c: make ref_update_reject_duplicates take a strbuf argument for errors
Date: Tue, 29 Apr 2014 15:18:49 -0700
Message-ID: <1398809955-32008-5-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:21:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGPO-00043Y-3f
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965250AbaD2WVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:21:31 -0400
Received: from mail-ig0-f201.google.com ([209.85.213.201]:53147 "EHLO
	mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965259AbaD2WTT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:19 -0400
Received: by mail-ig0-f201.google.com with SMTP id l13so76036iga.2
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yBTbrcLMXIicqluvuqj+/SVu1aYrCl0jDEzZa1cBTlA=;
        b=MWo9Fv3U0R5rdEL+TrfO6aiOkFq/hYo8a0XO9inBHeWgY7VZ9ARJPHB9AvGz+E3woI
         OgLRNl7NKffjnXSX9rbX0FQ/KNPECJORIT2Auoq+qmFTovDDomwUYZbgxofmC9uh+iYR
         zz1rswlQcBTxZWDzEhuAuD6lGK0GSq2nu2SkwSO+zonGEdUx3M6IolhC7AwTH/vnoPCV
         9/8MOa/+d7LpfTZc+rU+d4gyIbRyJYsUHd/IN2eL7ae8WKSp+u5Gj6eZDNOcNx4sjMtf
         /gc0jvn3AXfdvWM316KyZBIev678wZvQU4hnOKl/4jTNDpUyDSD6VZ+NTJRWr/XxAE8d
         C4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yBTbrcLMXIicqluvuqj+/SVu1aYrCl0jDEzZa1cBTlA=;
        b=MX0khYa+8ns/HTzmI1WwqqazoqerJlgwTVQ7ojzjas+HalNcLBXSd9ewFUhg1Qy27O
         3QaWCdSN1pRNH2vewOu9J736nL3zxYWyfhqwrZB0bx4EcYQfE7cFUb3iUOR8Jwcaktzd
         1+AxJXZWeJhQY1lBjwtTsarXj8pwxr1kmw4BCvMME0YrbA9wLqTpVh/KuKIBL0YDe8Ws
         XgD8AMID1LTKdMI9IRoHx1yVPuKIROXDc2PFvYuYBkvM6OwlPsryfRFZfBAouyF7Y42h
         28MJA3wBJt4fNioC678xdlQNj5rDtvbjrt5WpTZ4kPIz02uP31J/ivocjWnuSGJfNkC2
         I2CA==
X-Gm-Message-State: ALoCoQmfvhtfb56nIPsWmaln0e4xRQXDPGvNi92q6weMx8icUdP7l7Hwn/Pa5ZjXiUi4bzvQJ3vPNQdCictKzQvGv6lC3VP+NZVWhLdo2sldBYRFv3kv9f4g3LzkifgN8JA46LoAx8b+NQy4GXk0axgFljbQO+PZdteE+3i/3SJ4qHhD54LZ7UXz7XqJfD0JLDemrtLyhQXb
X-Received: by 10.182.213.5 with SMTP id no5mr291965obc.15.1398809959386;
        Tue, 29 Apr 2014 15:19:19 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si2739346yhk.4.2014.04.29.15.19.19
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:19 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 30C3631C1D2;
	Tue, 29 Apr 2014 15:19:19 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D869BE0B2F; Tue, 29 Apr 2014 15:19:18 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247654>

Make ref_update_reject_duplicates return any error that occurs through a
new strbuf argument.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 64e8feb..21a147b 100644
--- a/refs.c
+++ b/refs.c
@@ -3393,6 +3393,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
+					struct strbuf *err,
 					enum action_on_err onerr)
 {
 	int i;
@@ -3400,6 +3401,9 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
 			const char *str =
 				"Multiple updates for ref '%s' not allowed.";
+			if (err)
+				strbuf_addf(err, str, updates[i]->refname);
+
 			switch (onerr) {
 			case UPDATE_REFS_MSG_ON_ERR:
 				error(str, updates[i]->refname); break;
@@ -3430,7 +3434,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err, onerr);
 	if (ret)
 		goto cleanup;
 
-- 
1.9.1.532.gf8485a6
