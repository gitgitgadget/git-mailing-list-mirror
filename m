From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/19] refs.c: add an err argument to delete_ref_loose
Date: Wed, 10 Sep 2014 20:06:02 -0700
Message-ID: <20140911030602.GH18279@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 05:06:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRui4-0000dg-BE
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 05:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366AbaIKDGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 23:06:08 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:37929 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbaIKDGG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 23:06:06 -0400
Received: by mail-pd0-f181.google.com with SMTP id w10so7513878pde.12
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 20:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=91y5rplwoeNr/nSP4x+ITSxmMG9Rukg0TZbJm8rY+Dw=;
        b=BmTxeDVwwnyURC5cK39uVLC5ctN7ta1skbAGJczH4wMB6daif1Zp0JKjv3av51wa/P
         TzF7G6rdiuIBYONE6gITE2dTYE9NeRKIUnoUx+I51SZTyGNYhj+ZSIl3ffDjhNTsIZ39
         4iDHBSupiz7WPpPfHLjA8IhGkgmX3t782zpfSfqqVD05RBRpg79jfC/MI5kx7FLvYxkB
         5/JEx47Ie/kaxoB4vTTUTUyI3tar0vSWkCEHgd6YW3AEedU0LaGuYKdbD0VTbI9KYXp9
         uqXvww6epHOa74bGbk3mxF9vLNY2zJ46uc8UEkqQQMmz0J2J6V4hBfUcaGjoorQOShlK
         1h5Q==
X-Received: by 10.68.94.196 with SMTP id de4mr42826013pbb.18.1410404766041;
        Wed, 10 Sep 2014 20:06:06 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id qp15sm15740263pbb.54.2014.09.10.20.06.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Sep 2014 20:06:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140911030318.GD18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256816>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Thu, 15 May 2014 08:25:23 -0700

Add an err argument to delete_loose_ref so that we can pass a descriptive
error string back to the caller. Pass the err argument from transaction
commit to this function so that transaction users will have a nice error
string if the transaction failed due to delete_loose_ref.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 7235574..5609622 100644
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
-		if (err && errno != ENOENT)
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
