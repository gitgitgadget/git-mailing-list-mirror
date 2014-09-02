From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/22] fast-import.c: change update_branch to use ref
 transactions
Date: Tue, 2 Sep 2014 14:03:25 -0700
Message-ID: <20140902210325.GJ18279@google.com>
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
X-From: git-owner@vger.kernel.org Tue Sep 02 23:03:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOvEj-0002cJ-1g
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 23:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135AbaIBVD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 17:03:29 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:42682 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754875AbaIBVD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 17:03:28 -0400
Received: by mail-pa0-f42.google.com with SMTP id lf10so15663778pab.15
        for <git@vger.kernel.org>; Tue, 02 Sep 2014 14:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kzq9XV2piCobuouf5S6s/wr6lwjffeaoh6kEN1knXh0=;
        b=noG7J9b9SpGVDMM0FF2EPkXFe6wZyb8WRDSeTJiBaze1x5d5LQD4eDSVBp3D925GFO
         Xa05sww2pvsWu541I0eUkWhGvHvh2Rd/Bf6jv2z4Z4MrmawuH7cdEs2pHNAKEHn+xRJR
         hJY7Rf/jXWyshA2cXU6Gg7viCiIKzBUXA2/utboZbj8w72AEh9VtYYwg2ZdpMG7TQ9FC
         McrcTc2dSrGyAGgXdQvVVkvhUWTuCrLiFF4GdFFYVWn43TTDJEzeT2BEZ0ZT654arp/Q
         xY5khmqOWZ4VOyNH+Rjb47JRVF0Nasc2ePoaYC8tmrKtFFieN6A3nIM/rQFkK5Z1mHCs
         giDA==
X-Received: by 10.70.98.129 with SMTP id ei1mr50956674pdb.27.1409691808193;
        Tue, 02 Sep 2014 14:03:28 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id kq1sm6746340pdb.49.2014.09.02.14.03.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Sep 2014 14:03:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140902205841.GA18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256355>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Wed, 16 Apr 2014 16:21:13 -0700

Change update_branch() to use ref transactions for updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 fast-import.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 6707a66..79160d5 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1679,8 +1679,9 @@ found_entry:
 static int update_branch(struct branch *b)
 {
 	static const char *msg = "fast-import";
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
 	unsigned char old_sha1[20];
+	struct strbuf err = STRBUF_INIT;
 
 	if (read_ref(b->name, old_sha1))
 		hashclr(old_sha1);
@@ -1689,29 +1690,33 @@ static int update_branch(struct branch *b)
 			delete_ref(b->name, old_sha1, 0);
 		return 0;
 	}
-	lock = lock_any_ref_for_update(b->name, old_sha1, 0, NULL);
-	if (!lock)
-		return error("Unable to lock %s", b->name);
 	if (!force_update && !is_null_sha1(old_sha1)) {
 		struct commit *old_cmit, *new_cmit;
 
 		old_cmit = lookup_commit_reference_gently(old_sha1, 0);
 		new_cmit = lookup_commit_reference_gently(b->sha1, 0);
-		if (!old_cmit || !new_cmit) {
-			unlock_ref(lock);
+		if (!old_cmit || !new_cmit)
 			return error("Branch %s is missing commits.", b->name);
-		}
 
 		if (!in_merge_bases(old_cmit, new_cmit)) {
-			unlock_ref(lock);
 			warning("Not updating %s"
 				" (new tip %s does not contain %s)",
 				b->name, sha1_to_hex(b->sha1), sha1_to_hex(old_sha1));
 			return -1;
 		}
 	}
-	if (write_ref_sha1(lock, b->sha1, msg) < 0)
-		return error("Unable to update %s", b->name);
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
+				   0, 1, &err) ||
+	    ref_transaction_commit(transaction, msg, &err)) {
+		ref_transaction_free(transaction);
+		error("%s", err.buf);
+		strbuf_release(&err);
+		return -1;
+	}
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
 	return 0;
 }
 
-- 
2.1.0.rc2.206.gedb03e5
