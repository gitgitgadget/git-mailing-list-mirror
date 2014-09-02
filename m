From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 13/22] fast-import.c: use a ref transaction when dumping tags
Date: Tue, 2 Sep 2014 14:06:59 -0700
Message-ID: <20140902210659.GN18279@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140826000354.GW20185@google.com>
 <xmqqlhqbge3a.fsf@gitster.dls.corp.google.com>
 <20140826221448.GY20185@google.com>
 <20140827002804.GA20185@google.com>
 <20140902205841.GA18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 23:07:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOvIF-0004qC-0A
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 23:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203AbaIBVHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 17:07:04 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:40961 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183AbaIBVHD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 17:07:03 -0400
Received: by mail-pa0-f53.google.com with SMTP id fa1so15651178pad.40
        for <git@vger.kernel.org>; Tue, 02 Sep 2014 14:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SxB8KJe9wbZtc/0Bl+QsG6sAPdQhj//6ziDYibkXyZQ=;
        b=Y7iedFnMe2EHefI59iOKB91pa+jNpqIrMsrBDQy2y44tzSzxCO4yf1fDbZ/QYX6KQg
         h34wRqB9dj7uRS1fJcz5+Ml7uaqpuQ4I3UFVI8r2dLO1prcGS6SvdX3stk/ARj8sMnq9
         ZjjAX4ggiXjzCudCszR36Hj2kw1HSeTqYeK3ykYXErgq8Z47/ziG8W4cAorejVNOJ6/+
         xg21CeLoUT4VdcqBVpGrwYUqYtaTMeQYWXxle2kr+GPvLWnKl5gaNFIhU/FR7A0Y1UsP
         VVOmG3tTpO12W0so1WEZDAfkmR+FBPst+hUX8IXHLdEGMjNjOZFimjR6U0aPjke+3lGv
         BlKw==
X-Received: by 10.66.141.229 with SMTP id rr5mr49952805pab.24.1409692022638;
        Tue, 02 Sep 2014 14:07:02 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id xu4sm14164849pab.30.2014.09.02.14.07.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Sep 2014 14:07:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140902205841.GA18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256359>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Mon, 28 Apr 2014 15:23:58 -0700

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 fast-import.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 79160d5..e7f6e37 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1735,15 +1735,32 @@ static void dump_tags(void)
 {
 	static const char *msg = "fast-import";
 	struct tag *t;
-	struct ref_lock *lock;
-	char ref_name[PATH_MAX];
+	struct strbuf ref_name = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *transaction;
 
+	transaction = ref_transaction_begin(&err);
+	if (!transaction) {
+		failure |= error("%s", err.buf);
+		goto cleanup;
+	}
 	for (t = first_tag; t; t = t->next_tag) {
-		sprintf(ref_name, "tags/%s", t->name);
-		lock = lock_ref_sha1(ref_name, NULL);
-		if (!lock || write_ref_sha1(lock, t->sha1, msg) < 0)
-			failure |= error("Unable to update %s", ref_name);
+		strbuf_reset(&ref_name);
+		strbuf_addf(&ref_name, "refs/tags/%s", t->name);
+
+		if (ref_transaction_update(transaction, ref_name.buf, t->sha1,
+					   NULL, 0, 0, &err)) {
+			failure |= error("%s", err.buf);
+			goto cleanup;
+		}
 	}
+	if (ref_transaction_commit(transaction, msg, &err))
+		failure |= error("%s", err.buf);
+
+ cleanup:
+	ref_transaction_free(transaction);
+	strbuf_release(&ref_name);
+	strbuf_release(&err);
 }
 
 static void dump_marks_helper(FILE *f,
-- 
2.1.0.rc2.206.gedb03e5
