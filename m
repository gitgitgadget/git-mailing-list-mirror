From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/22] refs.c: change update_ref to use a transaction
Date: Tue, 2 Sep 2014 14:04:38 -0700
Message-ID: <20140902210438.GL18279@google.com>
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
X-From: git-owner@vger.kernel.org Tue Sep 02 23:04:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOvFv-0003L2-Ox
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 23:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754979AbaIBVEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 17:04:44 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:36755 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692AbaIBVEn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 17:04:43 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so9406710pdj.4
        for <git@vger.kernel.org>; Tue, 02 Sep 2014 14:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=87Eom41qIBMSito5QO/vFZ+wDWGowZxO1QHyIv29S/w=;
        b=Fi5ig4zVFvZuPnGliZwqHSN4LJWFxXC9yxU1yOWe272P9WAwR4ce7SVznNygVlUv8r
         vNLbYlyM6T7Fo8MLMqoltLlyuUU0RIU3nwqjxGNKMwcmiHjOETWkIXzlgGno42RClSh3
         5q1dVbljCoO0jTiWPoZqepIOaw/W/wxZcq3iPRyYj5ArOVAl7JDrRdNJiiHB3+xgpwWS
         lftmAxBdUL0IPyC/BtSpOZ0xRgieD10nJ4EpZq7apaeKlnD71pNPIkBI5BQCMA1le7YP
         pxZWb0OR2XFyeRyRp9co61MClJhTodyWZkkii5VmhcDRV0YvMzMcntspPrPJs8xMzjlL
         GGMA==
X-Received: by 10.67.5.68 with SMTP id ck4mr51536503pad.6.1409691883399;
        Tue, 02 Sep 2014 14:04:43 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id ms12sm4880120pbc.51.2014.09.02.14.04.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Sep 2014 14:04:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140902205841.GA18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256357>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Thu, 24 Apr 2014 16:36:55 -0700

Change the update_ref helper function to use a ref transaction internally.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index cc63056..a3532ab 100644
--- a/refs.c
+++ b/refs.c
@@ -3519,11 +3519,33 @@ int update_ref(const char *action, const char *refname,
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
+	ref_transaction_free(t);
+	return 0;
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
-- 
2.1.0.rc2.206.gedb03e5
