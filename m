From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 20/22] refs.c: make delete_ref use a transaction
Date: Tue, 2 Sep 2014 14:10:17 -0700
Message-ID: <20140902211017.GU18279@google.com>
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
X-From: git-owner@vger.kernel.org Tue Sep 02 23:10:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOvLN-0006lz-KW
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 23:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755258AbaIBVKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 17:10:22 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:61823 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754274AbaIBVKV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 17:10:21 -0400
Received: by mail-pa0-f46.google.com with SMTP id eu11so15677551pac.19
        for <git@vger.kernel.org>; Tue, 02 Sep 2014 14:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tmStpFFsu/XcHT7fsonUMitgeHj8p93cW7s8XG8/WqM=;
        b=KlgYX4eDz6Sohm0fEEowUvAtpkakVFz/el6/yTLf4JGjvk24no3c/oCTIbgO543RbO
         p5J7S8ZvC8HukJiz/6CctCB5F1549BqGXAsah76H6zsb6mA/Xua5WFDyPV4ZcKtdRQEr
         PL35DJLsJQZZHqKvbBaiaksdZDQ2pP+EaeqFBdTqBfIV8vdlWhfIp7upPQ81L52l1ORO
         1LY+V2WGolD2qFJOFyly159wI8v3bgi9mVRTOQm8mHgkRoyZUKjF8fZ7HLaSwFENX71a
         qIYoUU5j+ZedP2UWERuuxlUZ7Bwvn4EGQtDXrZz9RTLO0jX7/1U2XpN9Dxwtpf1EuHmY
         4NlQ==
X-Received: by 10.70.132.162 with SMTP id ov2mr34121486pdb.118.1409692220416;
        Tue, 02 Sep 2014 14:10:20 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id x1sm4867195pbt.65.2014.09.02.14.10.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Sep 2014 14:10:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140902205841.GA18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256366>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Wed, 30 Apr 2014 09:22:45 -0700

Change delete_ref to use a ref transaction for the deletion. At the same time
since we no longer have any callers of repack_without_ref we can now delete
this function.

Change delete_ref to return 0 on success and 1 on failure instead of the
previous 0 on success either 1 or -1 on failure.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index 22eb3dd..7235574 100644
--- a/refs.c
+++ b/refs.c
@@ -2548,11 +2548,6 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	return ret;
 }
 
-static int repack_without_ref(const char *refname)
-{
-	return repack_without_refs(&refname, 1, NULL);
-}
-
 static int delete_ref_loose(struct ref_lock *lock, int flag)
 {
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
@@ -2570,24 +2565,22 @@ static int delete_ref_loose(struct ref_lock *lock, int flag)
 
 int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 {
-	struct ref_lock *lock;
-	int ret = 0, flag = 0;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
-	lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
-	if (!lock)
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_delete(transaction, refname, sha1, delopt,
+				   sha1 && !is_null_sha1(sha1), &err) ||
+	    ref_transaction_commit(transaction, NULL, &err)) {
+		error("%s", err.buf);
+		ref_transaction_free(transaction);
+		strbuf_release(&err);
 		return 1;
-	ret |= delete_ref_loose(lock, flag);
-
-	/* removing the loose one could have resurrected an earlier
-	 * packed one.  Also, if it was not loose we need to repack
-	 * without it.
-	 */
-	ret |= repack_without_ref(lock->ref_name);
-
-	unlink_or_warn(git_path("logs/%s", lock->ref_name));
-	clear_loose_ref_cache(&ref_cache);
-	unlock_ref(lock);
-	return ret;
+	}
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
+	return 0;
 }
 
 /*
-- 
2.1.0.rc2.206.gedb03e5
