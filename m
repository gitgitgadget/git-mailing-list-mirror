From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 13/20] fast-import.c: use a ref transaction when dumping tags
Date: Tue, 26 Aug 2014 17:33:49 -0700
Message-ID: <20140827003349.GN20185@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140826000354.GW20185@google.com>
 <xmqqlhqbge3a.fsf@gitster.dls.corp.google.com>
 <20140826221448.GY20185@google.com>
 <20140827002804.GA20185@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 02:33:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMRBW-0006wz-0r
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 02:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756038AbaH0Ady (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 20:33:54 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:43252 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755994AbaH0Adx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 20:33:53 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so23630569pde.9
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 17:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SxB8KJe9wbZtc/0Bl+QsG6sAPdQhj//6ziDYibkXyZQ=;
        b=b+elscIHmGKjbDcrjCNF28LB+tgiEyqZDpGYfEZG8b8b1huHe6HpYUBMsHF9vGPLIc
         omY+EhKSWdXqHEj5HEQYUKZEpeqKluDfdyOniRImAZWyKhBTVb8f9NHX0+gpTdAmGj+F
         DKVKhBOS8noiUajJiPpzPIBBKb3aYfag50VewGAjhllff7EVgTyyfTQUq1Ft7EYNglRH
         pvam9l06yWplhgb/LK3zNnzuI8RN9kO42G3JnItzK46SR/qZZJ4646frkFjGR95+eTve
         MznxBXtuHYGhe2sX6txuSMwFO/i22lZV1K2rt7ZQVZImj5mg4wNIXWME/iR2rW02qZiH
         mSZg==
X-Received: by 10.67.22.37 with SMTP id hp5mr16826356pad.150.1409099633427;
        Tue, 26 Aug 2014 17:33:53 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:4ba:9bd4:148:77e4])
        by mx.google.com with ESMTPSA id qp15sm4501885pbb.54.2014.08.26.17.33.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 Aug 2014 17:33:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140827002804.GA20185@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255969>

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
