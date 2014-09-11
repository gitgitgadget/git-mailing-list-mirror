From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 19/19] ref_transaction_commit: bail out on failure to remove
 a ref
Date: Wed, 10 Sep 2014 20:12:38 -0700
Message-ID: <20140911031238.GW18279@google.com>
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
X-From: git-owner@vger.kernel.org Thu Sep 11 05:12:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRuoT-0004EZ-34
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 05:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354AbaIKDMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 23:12:43 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:60644 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341AbaIKDMm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 23:12:42 -0400
Received: by mail-pa0-f54.google.com with SMTP id lj1so9778403pab.41
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 20:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5UrvA1A0qWynWQ+o8qEmEr3hJ3cy0e/eQRSAOCfEID8=;
        b=Xj/bQI8j7ButSqdOgjakCd4DTA7AFZj/7TJJz+O5KNIUMyCYM6dDJNwIjHsrXlBpz+
         XZruLZ7QieCxsgFWlS/daNE0huUX4T2NT7IvfoMn4VlUSqbX0L94TeGi8xsjnjpsdMpU
         mSeqhOteslq64h5IesEWSkHYrwxcQOgvRDED1i2D3RH+pdWFZ/9lis3L57VjoGuXSxzT
         JOK+hE+BHU7RIt9V2KIyv+WveEpPLnxJ8b/bFPceIjhMIGyZ700QXZcTaFzdwf5y35tV
         MxdsIdJST3ouzqAIQu/t1squw2C5AonJJZQD6DLUN3H6DrIPGafIFwNCcCnhqmHUXY0f
         Zyug==
X-Received: by 10.68.209.169 with SMTP id mn9mr42747503pbc.37.1410405161513;
        Wed, 10 Sep 2014 20:12:41 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id zr6sm15753267pbc.50.2014.09.10.20.12.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Sep 2014 20:12:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140911030318.GD18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256830>

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
Thanks for reading.

 refs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 550223c..3b27758 100644
--- a/refs.c
+++ b/refs.c
@@ -3714,16 +3714,20 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (update->lock) {
-			if (delete_ref_loose(update->lock, update->type, err))
+			if (delete_ref_loose(update->lock, update->type, err)) {
 				ret = -1;
+				goto cleanup;
+			}
 
 			if (!(update->flags & REF_ISPRUNING))
 				delnames[delnum++] = update->lock->ref_name;
 		}
 	}
 
-	if (repack_without_refs(delnames, delnum, err))
+	if (repack_without_refs(delnames, delnum, err)) {
 		ret = -1;
+		goto cleanup;
+	}
 	for (i = 0; i < delnum; i++)
 		unlink_or_warn(git_path("logs/%s", delnames[i]));
 	clear_loose_ref_cache(&ref_cache);
-- 
2.1.0.rc2.206.gedb03e5
