From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 24/24] ref_transaction_commit: bail out on failure to remove
 a ref
Date: Wed, 1 Oct 2014 19:35:10 -0700
Message-ID: <20141002023510.GQ1175@google.com>
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
X-From: git-owner@vger.kernel.org Thu Oct 02 04:35:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZWEi-0003Bt-1N
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 04:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbaJBCfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 22:35:14 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:62284 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbaJBCfN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 22:35:13 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so1369687pab.16
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 19:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LLmvUkPLgyV60elobxh2x3A/YLQ9Xb8Lt3lzFox9GTY=;
        b=shs7vPgwqJjagMqddvgkXtajl8YyhUnhvRB8bG0nx3NOZk65gpboG8SUtNtJWslW2S
         bEw7swYrk1egnDaqHXj6rmbC4A0fnlbElPzGUX/+yAzLNSeGXjPANwCzI8zZlSiNKNoP
         +aofWyzr3zldACpNnPD8V/3cidut/+Ul7IBecw4rzZVEpPX43hBpwF1deSQ7gpCK1Vw1
         m+1Yo2QhMCIykKEiJ5LhD72gbsOx8zVIwisPeovDwWllmhztRQX15cbIeaRvV1ursGub
         O9kCS/agLjTwXJX4lRqajyIXWs8YfiUnRxiIkPP13X8Cqfbr7XOf6IuHaFeERUSX1pxI
         41/w==
X-Received: by 10.68.217.137 with SMTP id oy9mr24031050pbc.4.1412217312781;
        Wed, 01 Oct 2014 19:35:12 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id bo17sm2133692pdb.57.2014.10.01.19.35.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Oct 2014 19:35:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141002014817.GS1175@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257795>

Date: Thu, 28 Aug 2014 17:01:35 -0700

When removal of a loose or packed ref fails, bail out instead of
trying to finish the transaction.  This way, a single error message
can be printed (instead of multiple messages being concatenated by
mistake) and the operator can try to solve the underlying problem
before there is a chance to muck things up even more.

In particular, when git fails to remove a ref, git goes on to try to
delete the reflog.  Exiting early lets us keep the reflog.

When git succeeds in deleting a ref A and fails to remove a ref B, it
goes on to try to delete both reflogs.  It would be better to just
remove the reflog for A, but that would be a more invasive change.
Failing early means we keep both reflogs, which puts the operator in a
good position to understand the problem and recover.

A long term goal is to avoid these problems altogether and roll back
the transaction on failure.  That kind of transactionality will have
to wait for a later series (the plan for which is to make all
destructive work happen in a single update of the packed-refs file).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>
---
That's the end of the series.  Thanks for reading.

 refs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index e13f843..d9d327d 100644
--- a/refs.c
+++ b/refs.c
@@ -3753,16 +3753,20 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (update->lock) {
-			if (delete_ref_loose(update->lock, update->type, err))
+			if (delete_ref_loose(update->lock, update->type, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
+				goto cleanup;
+			}
 
 			if (!(update->flags & REF_ISPRUNING))
 				delnames[delnum++] = update->lock->ref_name;
 		}
 	}
 
-	if (repack_without_refs(delnames, delnum, err))
+	if (repack_without_refs(delnames, delnum, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
+		goto cleanup;
+	}
 	for (i = 0; i < delnum; i++)
 		unlink_or_warn(git_path("logs/%s", delnames[i]));
 	clear_loose_ref_cache(&ref_cache);
-- 
2.1.0.rc2.206.gedb03e5
