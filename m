From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/24] refs.c: add an err argument to delete_ref_loose
Date: Wed, 1 Oct 2014 18:58:19 -0700
Message-ID: <20141002015819.GW1175@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
 <20141002014817.GS1175@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 03:58:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZVf1-0006Cg-P2
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 03:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064AbaJBB6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 21:58:24 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:39954 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041AbaJBB6X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 21:58:23 -0400
Received: by mail-pd0-f180.google.com with SMTP id fp1so1195660pdb.11
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 18:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=IbwtiHdAqnic9bxOYotTbAUlYyWnUOnELLy7P2/V1lA=;
        b=eqSc5JY20fowV0kURoJqSL+6vvzCDUwt2yMVyC694XjyqgXn5JFeUNeMHQKO85nnYT
         Z7DY4tZAYJ7/XcgshAl6jyFE0Li4oGwMDYYV9t2YxIkfh2CG8vOnDmH2lk9GDBOutftw
         DyDyX6nGogmlRKcGEsiA21JGmPGfy+d3dln/fDlil0TjCy+JT9Dew6aWQHrj7lHr8lcd
         eVFIbip6U+n6n1rQRjhBytAK2wUuVaqJClL5GRYI6S7zdHN0dFEZJFgIwPHHVzV33izp
         bTmhRMnkLgQB+43GaRiphM6HmxCkGxFxTMIHJ3GqzbEM6I/Q9xB0A0LQej0noolNl8IF
         ns3Q==
X-Received: by 10.66.161.232 with SMTP id xv8mr81705078pab.81.1412215103047;
        Wed, 01 Oct 2014 18:58:23 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id ns9sm2056648pbb.70.2014.10.01.18.58.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Oct 2014 18:58:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141002014817.GS1175@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257775>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Thu, 15 May 2014 08:25:23 -0700

Add an err argument to delete_loose_ref so that we can pass a descriptive
error string back to the caller. Pass the err argument from transaction
commit to this function so that transaction users will have a nice error
string if the transaction failed due to delete_ref_loose.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Changes since v21:
- s/delete_loose_ref/delete_ref_loose/ once in commit message (but
  the other one still needs fixing)

 refs.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index d0565b1..5609622 100644
--- a/refs.c
+++ b/refs.c
@@ -2548,16 +2548,16 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	return ret;
 }
 
-static int delete_ref_loose(struct ref_lock *lock, int flag)
+static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 {
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
 		/* loose */
-		int err, i = strlen(lock->lk->filename) - 5; /* .lock */
+		int res, i = strlen(lock->lk->filename) - 5; /* .lock */
 
 		lock->lk->filename[i] = 0;
-		err = unlink_or_warn(lock->lk->filename);
+		res = unlink_or_msg(lock->lk->filename, err);
 		lock->lk->filename[i] = '.';
-		if (err)
+		if (res)
 			return 1;
 	}
 	return 0;
@@ -3604,7 +3604,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (update->lock) {
-			ret |= delete_ref_loose(update->lock, update->type);
+			ret |= delete_ref_loose(update->lock, update->type,
+						err);
 			if (!(update->flags & REF_ISPRUNING))
 				delnames[delnum++] = update->lock->ref_name;
 		}
-- 
2.1.0.rc2.206.gedb03e5
