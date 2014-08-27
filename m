From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 16/20] refs.c: remove the update_ref_lock function
Date: Tue, 26 Aug 2014 17:35:00 -0700
Message-ID: <20140827003500.GQ20185@google.com>
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
X-From: git-owner@vger.kernel.org Wed Aug 27 02:35:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMRCh-0007T6-Vo
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 02:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756483AbaH0AfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 20:35:05 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33036 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756160AbaH0AfE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 20:35:04 -0400
Received: by mail-pd0-f174.google.com with SMTP id fp1so23456976pdb.33
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 17:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=N19JyRHx+i5pqVuEUHtUjovGIYjzStiAVXTXsI+exeA=;
        b=Ut1VC6wjIoA9p4Lo8xliBEx1mOmKamcvvK3EeDT6M2ofSNhPai2vbsBkqJE2qyutlg
         6PU9Xun/hOZU4iP9B7tJ/hG1rVWWdyBX9fRpKWzXbqWlaMTeyWbLOx1Fl5auso3K6tBR
         fcvJ/Pe/YiUTUYiFRDbDb0d8WsQoUC1pHdndbihY/RY6UR+NN+IQUS4w1cn+wyHK8hsp
         TMfTTJ6CbAUt15PwQ0pL4fbl5y07DR8D9b/2ftD7Kdr6iN9BJz8IWwOa4j8r4Esf6f+J
         VgOt317Lmyz+JTkcA82DQm607CRdm6uAey9aQPyVD6KM2rAzC6mp4vn23qlSvzXuhBFe
         vpog==
X-Received: by 10.66.124.168 with SMTP id mj8mr41340511pab.78.1409099703852;
        Tue, 26 Aug 2014 17:35:03 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:4ba:9bd4:148:77e4])
        by mx.google.com with ESMTPSA id x7sm6912997pdj.36.2014.08.26.17.35.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 Aug 2014 17:35:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140827002804.GA20185@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255972>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Tue, 29 Apr 2014 12:14:47 -0700

Since we now only call update_ref_lock with onerr==QUIET_ON_ERR we no longer
need this function and can replace it with just calling lock_any_ref_for_update
directly.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/refs.c b/refs.c
index 0dc093c..de07791 100644
--- a/refs.c
+++ b/refs.c
@@ -3336,24 +3336,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 	return retval;
 }
 
-static struct ref_lock *update_ref_lock(const char *refname,
-					const unsigned char *oldval,
-					int flags, int *type_p,
-					enum action_on_err onerr)
-{
-	struct ref_lock *lock;
-	lock = lock_any_ref_for_update(refname, oldval, flags, type_p);
-	if (!lock) {
-		const char *str = "Cannot lock the ref '%s'.";
-		switch (onerr) {
-		case UPDATE_REFS_MSG_ON_ERR: error(str, refname); break;
-		case UPDATE_REFS_DIE_ON_ERR: die(str, refname); break;
-		case UPDATE_REFS_QUIET_ON_ERR: break;
-		}
-	}
-	return lock;
-}
-
 static int update_ref_write(const char *action, const char *refname,
 			    const unsigned char *sha1, struct ref_lock *lock,
 			    struct strbuf *err, enum action_on_err onerr)
@@ -3602,12 +3584,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
-		update->lock = update_ref_lock(update->refname,
-					       (update->have_old ?
-						update->old_sha1 : NULL),
-					       update->flags,
-					       &update->type,
-					       UPDATE_REFS_QUIET_ON_ERR);
+		update->lock = lock_any_ref_for_update(update->refname,
+						       (update->have_old ?
+							update->old_sha1 :
+							NULL),
+						       update->flags,
+						       &update->type);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
-- 
2.1.0.rc2.206.gedb03e5
