From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 17/22] refs.c: remove the update_ref_write function
Date: Tue, 2 Sep 2014 14:08:43 -0700
Message-ID: <20140902210843.GR18279@google.com>
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
X-From: git-owner@vger.kernel.org Tue Sep 02 23:08:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOvJt-0005rj-BH
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 23:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255AbaIBVIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 17:08:47 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:63166 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755177AbaIBVIq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 17:08:46 -0400
Received: by mail-pa0-f48.google.com with SMTP id ey11so15566438pad.7
        for <git@vger.kernel.org>; Tue, 02 Sep 2014 14:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wtBUUc5UnrgrwjCVpgORqqArkRMV0+Eb/sD0/fgMpzs=;
        b=y/hqv+rJTTXg2NnE1T2HVq2bhGNGxmRk+xhteOYO8jLjOza2KyQg7JfHDLxvrrtrOq
         8Kr2KIp+V7GgAVeFy0zH1Ezh2UqJBi9pMMt63knt5xFYAIJA2QJg584ivNPBxSxBZWsM
         uk/htPk5sHqIha+bi9FVAEaxkdjOrjQwnUT1yGf66EDpzwVVAIsm+MS1ClJZUfP1DXH8
         3YymKDmKGBMyUydQ95K4pRn1OvWG99erA6Lsaydh7Q7/pDYC5hP0abyzhNQoMRkqXLuW
         MB5Td8sA2Ke+BASFbDJf+U3NuW2lItJynZCs99t5uvKE/NjWh0NF0kamAdKI7gWNlf3d
         i1ZA==
X-Received: by 10.66.156.42 with SMTP id wb10mr6660362pab.155.1409692126437;
        Tue, 02 Sep 2014 14:08:46 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id qy1sm4920170pbc.27.2014.09.02.14.08.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Sep 2014 14:08:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140902205841.GA18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256363>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Tue, 29 Apr 2014 13:42:07 -0700

Since we only call update_ref_write from a single place and we only call it
with onerr==QUIET_ON_ERR we can just as well get rid of it and just call
write_ref_sha1 directly. This changes the return status for _commit from
1 to -1 on failures when writing to the ref. Eventually we will want
_commit to start returning more detailed error conditions than the current
simple success/failure.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/refs.c b/refs.c
index a4445a1..a6b39ec 100644
--- a/refs.c
+++ b/refs.c
@@ -3336,25 +3336,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 	return retval;
 }
 
-static int update_ref_write(const char *action, const char *refname,
-			    const unsigned char *sha1, struct ref_lock *lock,
-			    struct strbuf *err, enum action_on_err onerr)
-{
-	if (write_ref_sha1(lock, sha1, action) < 0) {
-		const char *str = "Cannot update the ref '%s'.";
-		if (err)
-			strbuf_addf(err, str, refname);
-
-		switch (onerr) {
-		case UPDATE_REFS_MSG_ON_ERR: error(str, refname); break;
-		case UPDATE_REFS_DIE_ON_ERR: die(str, refname); break;
-		case UPDATE_REFS_QUIET_ON_ERR: break;
-		}
-		return 1;
-	}
-	return 0;
-}
-
 /**
  * Information needed for a single ref update.  Set new_sha1 to the
  * new value or to zero to delete the ref.  To check the old value
@@ -3605,14 +3586,15 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (!is_null_sha1(update->new_sha1)) {
-			ret = update_ref_write(msg,
-					       update->refname,
-					       update->new_sha1,
-					       update->lock, err,
-					       UPDATE_REFS_QUIET_ON_ERR);
-			update->lock = NULL; /* freed by update_ref_write */
-			if (ret)
+			ret = write_ref_sha1(update->lock, update->new_sha1,
+					     msg);
+			update->lock = NULL; /* freed by write_ref_sha1 */
+			if (ret) {
+				if (err)
+					strbuf_addf(err, "Cannot update the ref '%s'.",
+						    update->refname);
 				goto cleanup;
+			}
 		}
 	}
 
-- 
2.1.0.rc2.206.gedb03e5
