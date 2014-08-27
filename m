From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 17/20] refs.c: remove the update_ref_write function
Date: Tue, 26 Aug 2014 17:35:20 -0700
Message-ID: <20140827003520.GR20185@google.com>
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
X-From: git-owner@vger.kernel.org Wed Aug 27 02:35:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMRCy-0007aQ-Do
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 02:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756491AbaH0AfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 20:35:24 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:59881 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756225AbaH0AfX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 20:35:23 -0400
Received: by mail-pa0-f44.google.com with SMTP id eu11so24651465pac.17
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 17:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=D0Gq+ev61OLb2gKM35mj+JVT6/AHfRFDdXzcCUiQ/xI=;
        b=AIYlgeMK53GuVK9Q24WDB/y9yA8NiXRbeBd9sqr7XgJvB+f1JKBKEVFx77pYT46DVZ
         1lcaNyAWBwXTjL3WJEqImSfTl6X1nRJdCNINHlCZDgoI6nEdQJRhG5reDc+RdTeFnPeG
         QTZKBlcyX8VoUZE0hqVq51CwdONlXLXQZP7USQTZjlYnuWZ55Xg/NmoT/V+Rjn2foheH
         PO9foRPlXBXAlJ9TcNvQXhn1/eAiW/5syihhMT/MuLKJhNPNjvJ0X58PYbioEBvvmDEC
         j8JFUkNERWNHxlvxCa3ufQMKOiY0zw4m8otgLJLfgCLE84qJcSebFVJdN4yQf0S0rqpF
         rHEA==
X-Received: by 10.70.61.106 with SMTP id o10mr13950174pdr.16.1409099723469;
        Tue, 26 Aug 2014 17:35:23 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:4ba:9bd4:148:77e4])
        by mx.google.com with ESMTPSA id sf1sm4576928pbb.0.2014.08.26.17.35.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 Aug 2014 17:35:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140827002804.GA20185@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255973>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Tue, 29 Apr 2014 13:42:07 -0700

Since we only call update_ref_write from a single place and we only call it
with onerr==QUIET_ON_ERR we can just as well get rid of it and just call
write_ref_sha1 directly. This changes the return status for _commit from
1 to -1 on failures when writing to the ref. Eventually we will want
_commit to start returning more detailed error conditions than the current
simple success/failure.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/refs.c b/refs.c
index de07791..ef7660a 100644
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
@@ -3604,14 +3585,15 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
