From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/20] sequencer.c: use ref transactions for all ref updates
Date: Tue, 26 Aug 2014 17:32:01 -0700
Message-ID: <20140827003201.GI20185@google.com>
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
X-From: git-owner@vger.kernel.org Wed Aug 27 02:32:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMR9o-0006HH-Mh
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 02:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756243AbaH0AcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 20:32:08 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:49755 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755066AbaH0AcH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 20:32:07 -0400
Received: by mail-pd0-f172.google.com with SMTP id y13so23203041pdi.31
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 17:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=oQ9kDn+1zfDIL0/QB4v7ovsUeonUN02vj0fLb2dBH7k=;
        b=QznhHSmqM9LssXtmN4gA7dsRRLMV3Pqrt4tY+1lDESrypKDK7v7P5AShiNKR3AN+Np
         duUHawIhy2cqgqoSalc7ERZlHEQ9VfaAdyb37nsa+813wcoKSC63L11Z49MNFBJPjMpE
         Svu9Xb4Bv5KhkQHj/6l4gYxhn0IUh9goFBnNAmczvXn/d86NqEiPNP2ZUijCGUvkuy7V
         IeRRBVfgn+6dYtFwpmBNVmfVmigFhQ6QJntaJ3oBjuYVt2bwPCzFN9PKZ89hb5ZdYENH
         pB/cytMWH2ICH7oUB3twBHnNdUQRFQICpjSxizJAZR3XT2NJC+EVPLxtM8LiHvMmfNrA
         TpQg==
X-Received: by 10.66.119.174 with SMTP id kv14mr41042542pab.52.1409099525947;
        Tue, 26 Aug 2014 17:32:05 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:4ba:9bd4:148:77e4])
        by mx.google.com with ESMTPSA id qn7sm4550510pbc.14.2014.08.26.17.32.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 Aug 2014 17:32:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140827002804.GA20185@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255964>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Wed, 16 Apr 2014 15:37:45 -0700

Change to use ref transactions for all updates to refs.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
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
