From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 07/44] refs.c: make update_ref_write update a strbuf on failure
Date: Thu, 15 May 2014 16:15:04 -0700
Message-ID: <1400195741-22996-8-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:18:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4uW-0000Xk-03
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756368AbaEOXR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:17:56 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:62739 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755605AbaEOXPp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:45 -0400
Received: by mail-oa0-f73.google.com with SMTP id i4so389136oah.4
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xnLIuNLuaG0ersHxPW/QxPy+eT3b0SWNCF/1OkGQKnI=;
        b=i6BUt39Z2d/y8i6KB5g1WCisEnh6/RahZuehTLQ25jys2fgYcYBX9wIID1YKAunp85
         NUuze12czzTbaM2Pige7MG87rZnABpZTQ1vI66iCRO5m6g5sO2lx9zXYyJLDDzheVa9t
         /bCT442iORY2Pjsv/CEwjzvlPJQHGWsrAiyvrSxTUpO8yOo+2KBBdhp0VMyDFzkqrig3
         /gMe8CHMzrW6eDj/4i8IuYLf4sb8mXv6p4eQj8UuJ/uHLCQuL8zp/XosZIHzbBtj5aOH
         AF1RvxPFA/bBSjNQx/V0hi1oHcuXrq4BxEbZJSHYekh00l/5rlA9pbOfrwBZ5GAlHlLi
         FtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xnLIuNLuaG0ersHxPW/QxPy+eT3b0SWNCF/1OkGQKnI=;
        b=lcsNSpdeqXW/ikB3/IlsQzAgZfkMucp0UNBz88K/rDfcN8EztO79TsmCFqzIt18qiP
         Yju5vlEZOkY3usyTBf5r7K614bjg8Gqj3Y8tJG+suhBi4l2Gwkh8dOvfecNNAAcVcRee
         H0PNFpPkoMoiSfrEQc2EtX+8joF/D7vWrWM5vtfUS27Kp4ElTOg8W6TPYCM+mSX/MKQ3
         6G3cdX0yjWrICgpfPHl7Q1bRG05b148SaRgxXf5mbtebPqzCfmXPR+sKE9mmm3Qbx+Wr
         LqxyCMqHgvf+W6fcb2MkuqMzVqJpjIfPwDs4JCkbkVlIutFHgjyX4z1FiZDARmMDN0OB
         pzjw==
X-Gm-Message-State: ALoCoQk0xHQgVQfPqfLos8C/Ef7oTDT6xy8SZt+UR9Hsp3KFxECRg1/lsxEfBdR82Z008D9/6Khw
X-Received: by 10.42.50.9 with SMTP id y9mr5477383icf.1.1400195744790;
        Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r79si319189yhj.2.2014.05.15.16.15.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 97BAC31C2BF;
	Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 340DAE0C53; Thu, 15 May 2014 16:15:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249261>

Change update_ref_write to also update an error strbuf on failure.
This makes the error available to ref_transaction_commit callers if the
transaction failed due to update_ref_sha1/write_ref_sha1 failures.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index e4d35c9..e8756fd 100644
--- a/refs.c
+++ b/refs.c
@@ -3301,10 +3301,13 @@ static struct ref_lock *update_ref_lock(const char *refname,
 
 static int update_ref_write(const char *action, const char *refname,
 			    const unsigned char *sha1, struct ref_lock *lock,
-			    enum action_on_err onerr)
+			    struct strbuf *err, enum action_on_err onerr)
 {
 	if (write_ref_sha1(lock, sha1, action) < 0) {
 		const char *str = "Cannot update the ref '%s'.";
+		if (err)
+			strbuf_addf(err, str, refname);
+
 		switch (onerr) {
 		case UPDATE_REFS_MSG_ON_ERR: error(str, refname); break;
 		case UPDATE_REFS_DIE_ON_ERR: die(str, refname); break;
@@ -3430,7 +3433,7 @@ int update_ref(const char *action, const char *refname,
 	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
 	if (!lock)
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, onerr);
+	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
@@ -3512,7 +3515,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			ret = update_ref_write(msg,
 					       update->refname,
 					       update->new_sha1,
-					       update->lock, onerr);
+					       update->lock, err, onerr);
 			update->lock = NULL; /* freed by update_ref_write */
 			if (ret)
 				goto cleanup;
-- 
2.0.0.rc3.477.gffe78a2
