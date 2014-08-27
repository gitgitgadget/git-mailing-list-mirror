From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/20] refs.c: change update_ref to use a transaction
Date: Tue, 26 Aug 2014 17:33:03 -0700
Message-ID: <20140827003302.GL20185@google.com>
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
X-From: git-owner@vger.kernel.org Wed Aug 27 02:33:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMRAn-0006gd-CS
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 02:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756328AbaH0AdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 20:33:09 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:44164 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755957AbaH0AdI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 20:33:08 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so23484724pdj.30
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 17:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8eJLbyf+rm+tg2QwAnRSAGx/1ASsTrO9dpQgbpfh9u8=;
        b=pvn5vxsfagz2lZpUoPMz1jfk/R3LR/gv9hbfx4ZzN+INIXEmw0F7fjeRMT/4JxeZry
         BTPDIS8h5U6DD0z3Coe07aKmcRbHNgdRI3QdcZoHY79pf9dVXLtAbG9PpUbU7qyeRrIn
         WZvQz+Bnb/bPd/bI5qjcFkAwBWfB8mW1SpnJO2ypEfY/V0L/sVBbbGf95TqNfdu7KO7i
         nTbY57+c3SMDIBDPTZuZLA8T/xUe4k+rOrHOpVfCBNQUj2JtskInhVWxIPhv+pT6RpbE
         unzaTL4At8ghqayVJPiTsukwbZOVggShJOT+6s0M/S6b7GB7oNNSqqrIsl5rGfnfoc4T
         Voew==
X-Received: by 10.70.30.132 with SMTP id s4mr40821158pdh.96.1409099587156;
        Tue, 26 Aug 2014 17:33:07 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:4ba:9bd4:148:77e4])
        by mx.google.com with ESMTPSA id fp6sm6965364pdb.4.2014.08.26.17.33.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 Aug 2014 17:33:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140827002804.GA20185@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255967>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Thu, 24 Apr 2014 16:36:55 -0700

Change the update_ref helper function to use a ref transaction internally.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index cc63056..dcc877b 100644
--- a/refs.c
+++ b/refs.c
@@ -3519,11 +3519,32 @@ int update_ref(const char *action, const char *refname,
 	       const unsigned char *sha1, const unsigned char *oldval,
 	       int flags, enum action_on_err onerr)
 {
-	struct ref_lock *lock;
-	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
-	if (!lock)
+	struct ref_transaction *t;
+	struct strbuf err = STRBUF_INIT;
+
+	t = ref_transaction_begin(&err);
+	if (!t ||
+	    ref_transaction_update(t, refname, sha1, oldval, flags,
+				   !!oldval, &err) ||
+	    ref_transaction_commit(t, action, &err)) {
+		const char *str = "update_ref failed for ref '%s': %s";
+
+		ref_transaction_free(t);
+		switch (onerr) {
+		case UPDATE_REFS_MSG_ON_ERR:
+			error(str, refname, err.buf);
+			break;
+		case UPDATE_REFS_DIE_ON_ERR:
+			die(str, refname, err.buf);
+			break;
+		case UPDATE_REFS_QUIET_ON_ERR:
+			break;
+		}
+		strbuf_release(&err);
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
+	}
+	strbuf_release(&err);
+	return 0;
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
-- 
2.1.0.rc2.206.gedb03e5
