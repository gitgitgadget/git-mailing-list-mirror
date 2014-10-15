From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 05/25] refs.c: add an err argument to delete_ref_loose
Date: Tue, 14 Oct 2014 17:47:56 -0700
Message-ID: <20141015004756.GI32245@google.com>
References: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 15 02:48:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeCl3-00007V-EY
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 02:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbaJOAsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 20:48:00 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:59101 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269AbaJOAsA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 20:48:00 -0400
Received: by mail-pd0-f178.google.com with SMTP id y10so226606pdj.9
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 17:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ht+3k1IZdjkdqSkGy3PEpDrieKavV9C3yXwNhR4es0E=;
        b=QX1dhSUrrz/tb7zxPRi6onI3XJmVQ1fPD75Ow+i/UEU9RaujpXMuhCm/nfAVlPh/fG
         b6LepSnVWeNCUYc5G3J5VPU7tDkrpnZUtfhq3f+6jdgN06Y7uJgSQzZNgnkAP8Jjz032
         mowv0eRxCw0PnnDBu1Yy5M5c+Pu+IjANUShIp0y1UXGo2lj/vsr5jKG8+v42xju1Djkf
         KfB2DncRQqlSAnn6z3pXJy1puTLTP++EskVhxX8L2vwzCZ8py1LxuCgBuA/q4X5nCaxn
         h+HcQPjIrrpAxzkaET2ZCI0Kz10LuF+ixRWamzKdQFC18NedvI15uAUQsEcF4/BVvHx6
         URjQ==
X-Received: by 10.68.134.230 with SMTP id pn6mr8946487pbb.88.1413334079644;
        Tue, 14 Oct 2014 17:47:59 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c43b:1934:40ef:9a07])
        by mx.google.com with ESMTPSA id ty8sm15489020pab.26.2014.10.14.17.47.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 17:47:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141015004522.GD32245@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Thu, 15 May 2014 08:25:23 -0700

Add an err argument to delete_ref_loose so that we can pass a descriptive
error string back to the caller. Pass the err argument from transaction
commit to this function so that transaction users will have a nice error
string if the transaction failed due to delete_ref_loose.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 4f2564d..430857b 100644
--- a/refs.c
+++ b/refs.c
@@ -2597,7 +2597,7 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	return ret;
 }
 
-static int delete_ref_loose(struct ref_lock *lock, int flag)
+static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 {
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
 		/*
@@ -2605,9 +2605,9 @@ static int delete_ref_loose(struct ref_lock *lock, int flag)
 		 * lockfile name, minus ".lock":
 		 */
 		char *loose_filename = get_locked_file_path(lock->lk);
-		int err = unlink_or_warn(loose_filename);
+		int res = unlink_or_msg(loose_filename, err);
 		free(loose_filename);
-		if (err)
+		if (res)
 			return 1;
 	}
 	return 0;
@@ -3658,7 +3658,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
