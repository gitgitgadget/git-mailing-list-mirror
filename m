From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/22] sequencer.c: use ref transactions for all ref updates
Date: Tue, 2 Sep 2014 14:02:47 -0700
Message-ID: <20140902210247.GI18279@google.com>
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
X-From: git-owner@vger.kernel.org Tue Sep 02 23:02:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOvE6-0002FR-Oc
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 23:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137AbaIBVCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 17:02:51 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:40933 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754848AbaIBVCu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 17:02:50 -0400
Received: by mail-pd0-f170.google.com with SMTP id r10so9519320pdi.29
        for <git@vger.kernel.org>; Tue, 02 Sep 2014 14:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=HUMMziGP4q9Wlc4Ekwhs5cRPvhrDaXw1XlA3MIQOWtY=;
        b=GsA4ay2fIZPiWqJr6958iQ1NxEeZteRIjDNZ9RjNJSVWkAg93bKSBhJAzTLq1HbL/L
         H4cfkGcp4F9FLzvPXhK8FEbMlfktFCZUe/s435PPt3eYBuBYpN0CvfbnvzdF/nFvTbiQ
         7OViDuTloB8y4mU6MoaNVz9y8UA97lKSOghc5pH+W1Zdbs9H/Nggp5c7VrmDgOGm6EIf
         571IzQenBv275RbOyVqFYfJelTV8irTfdL2XRSZvZXIsPPXzF4KP0xCm6JsLfatK5xSb
         dGt23mGAE7t9UnphY19doc30g9wEGW7/6eDmoof0k1rVU4ewscgFmKQZBD1lXxGt+ujz
         5Bcg==
X-Received: by 10.66.249.34 with SMTP id yr2mr6649357pac.149.1409691770098;
        Tue, 02 Sep 2014 14:02:50 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id kp6sm4855346pbc.67.2014.09.02.14.02.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Sep 2014 14:02:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140902205841.GA18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256354>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Wed, 16 Apr 2014 15:37:45 -0700

Change to use ref transactions for all updates to refs.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sequencer.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0a80c58..5e93b6a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -272,23 +272,33 @@ static int error_dirty_index(struct replay_opts *opts)
 static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 			int unborn, struct replay_opts *opts)
 {
-	struct ref_lock *ref_lock;
+	struct ref_transaction *transaction;
 	struct strbuf sb = STRBUF_INIT;
-	int ret;
+	struct strbuf err = STRBUF_INIT;
 
 	read_cache();
 	if (checkout_fast_forward(from, to, 1))
 		exit(1); /* the callee should have complained already */
-	ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from,
-					   0, NULL);
-	if (!ref_lock)
-		return error(_("Failed to lock HEAD during fast_forward_to"));
 
 	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
-	ret = write_ref_sha1(ref_lock, to, sb.buf);
+
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, "HEAD",
+				   to, unborn ? null_sha1 : from,
+				   0, 1, &err) ||
+	    ref_transaction_commit(transaction, sb.buf, &err)) {
+		ref_transaction_free(transaction);
+		error("%s", err.buf);
+		strbuf_release(&sb);
+		strbuf_release(&err);
+		return -1;
+	}
 
 	strbuf_release(&sb);
-	return ret;
+	strbuf_release(&err);
+	ref_transaction_free(transaction);
+	return 0;
 }
 
 static int do_recursive_merge(struct commit *base, struct commit *next,
-- 
2.1.0.rc2.206.gedb03e5
