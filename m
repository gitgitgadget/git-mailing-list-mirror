From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 14/22] walker.c: use ref transaction for ref updates
Date: Tue, 2 Sep 2014 14:07:33 -0700
Message-ID: <20140902210733.GO18279@google.com>
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
X-From: git-owner@vger.kernel.org Tue Sep 02 23:07:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOvIj-0005A3-OB
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 23:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755025AbaIBVHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 17:07:37 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:48627 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754603AbaIBVHh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 17:07:37 -0400
Received: by mail-pa0-f48.google.com with SMTP id ey11so15564340pad.7
        for <git@vger.kernel.org>; Tue, 02 Sep 2014 14:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Les6ReOJqi4J/l7g//jYDgij970qoHDW8UC7VbeGuhA=;
        b=UIaR3SuXnZ4Iblw3UQJHcgHUJkNuMEdiHy1IpMo506EKsssn/f2p0RyLrQZdAXPAK9
         2yKkwr4jgToUTQsAbEmbThMhfdpThle2HurizuLhPWOt70ll8K+N8wjt33fuPq/uTrrn
         HnMS0mDJ3xD4KEwDpiPbNfOZL6FobjU/zv5TEpFwLrP01zewVTDvRRiRv+bOdvYpojjo
         UxGuzB9pHxqcbwMaKjU2mUmtNyVdTS264vLgmEJ5IzLqYV/zwZT3vrVAJfrQ4q3VXVRc
         530zq6/I/YAhVtJ/ajmi+rw0IaexEj9uWOVrVQYGl76v1/fj6ucyE133U5cVrNwVLQns
         FJwg==
X-Received: by 10.68.95.196 with SMTP id dm4mr50602944pbb.95.1409692056725;
        Tue, 02 Sep 2014 14:07:36 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id gz1sm4850617pbd.74.2014.09.02.14.07.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Sep 2014 14:07:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140902205841.GA18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256360>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Thu, 17 Apr 2014 11:31:06 -0700

Switch to using ref transactions in walker_fetch(). As part of the refactoring
to use ref transactions we also fix a potential memory leak where in the
original code if write_ref_sha1() would fail we would end up returning from
the function without free()ing the msg string.

Note that this function is only called when fetching from a remote HTTP
repository onto the local (most of the time single-user) repository which
likely means that the type of collisions that the previous locking would
protect against and cause the fetch to fail for are even more rare.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 walker.c | 72 ++++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 41 insertions(+), 31 deletions(-)

diff --git a/walker.c b/walker.c
index 1dd86b8..b8a5441 100644
--- a/walker.c
+++ b/walker.c
@@ -251,40 +251,40 @@ void walker_targets_free(int targets, char **target, const char **write_ref)
 int walker_fetch(struct walker *walker, int targets, char **target,
 		 const char **write_ref, const char *write_ref_log_details)
 {
-	struct ref_lock **lock = xcalloc(targets, sizeof(struct ref_lock *));
+	struct strbuf refname = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *transaction = NULL;
 	unsigned char *sha1 = xmalloc(targets * 20);
-	char *msg;
-	int ret;
-	int i;
+	char *msg = NULL;
+	int i, ret = -1;
 
 	save_commit_buffer = 0;
 
-	for (i = 0; i < targets; i++) {
-		if (!write_ref || !write_ref[i])
-			continue;
-
-		lock[i] = lock_ref_sha1(write_ref[i], NULL);
-		if (!lock[i]) {
-			error("Can't lock ref %s", write_ref[i]);
-			goto unlock_and_fail;
+	if (write_ref) {
+		transaction = ref_transaction_begin(&err);
+		if (!transaction) {
+			error("%s", err.buf);
+			goto done;
 		}
 	}
-
 	if (!walker->get_recover)
 		for_each_ref(mark_complete, NULL);
 
 	for (i = 0; i < targets; i++) {
 		if (interpret_target(walker, target[i], &sha1[20 * i])) {
 			error("Could not interpret response from server '%s' as something to pull", target[i]);
-			goto unlock_and_fail;
+			goto done;
 		}
 		if (process(walker, lookup_unknown_object(&sha1[20 * i])))
-			goto unlock_and_fail;
+			goto done;
 	}
 
 	if (loop(walker))
-		goto unlock_and_fail;
-
+		goto done;
+	if (!write_ref) {
+		ret = 0;
+		goto done;
+	}
 	if (write_ref_log_details) {
 		msg = xmalloc(strlen(write_ref_log_details) + 12);
 		sprintf(msg, "fetch from %s", write_ref_log_details);
@@ -292,23 +292,33 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 		msg = NULL;
 	}
 	for (i = 0; i < targets; i++) {
-		if (!write_ref || !write_ref[i])
+		if (!write_ref[i])
 			continue;
-		ret = write_ref_sha1(lock[i], &sha1[20 * i], msg ? msg : "fetch (unknown)");
-		lock[i] = NULL;
-		if (ret)
-			goto unlock_and_fail;
+		strbuf_reset(&refname);
+		strbuf_addf(&refname, "refs/%s", write_ref[i]);
+		if (ref_transaction_update(transaction, refname.buf,
+					   &sha1[20 * i], NULL, 0, 0,
+					   &err)) {
+			error("%s", err.buf);
+			goto done;
+		}
 	}
+	if (ref_transaction_commit(transaction,
+				   msg ? msg : "fetch (unknown)",
+				   &err)) {
+		error("%s", err.buf);
+		goto done;
+	}
+
+	ret = 0;
+
+done:
+	ref_transaction_free(transaction);
 	free(msg);
-
-	return 0;
-
-unlock_and_fail:
-	for (i = 0; i < targets; i++)
-		if (lock[i])
-			unlock_ref(lock[i]);
-
-	return -1;
+	free(sha1);
+	strbuf_release(&err);
+	strbuf_release(&refname);
+	return ret;
 }
 
 void walker_free(struct walker *walker)
-- 
2.1.0.rc2.206.gedb03e5
