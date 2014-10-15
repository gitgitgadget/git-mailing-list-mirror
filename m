From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 25/25] ref_transaction_commit: bail out on failure to remove
 a ref
Date: Tue, 14 Oct 2014 17:55:41 -0700
Message-ID: <20141015005540.GC32245@google.com>
References: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 15 02:55:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeCsW-0004qN-5f
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 02:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932687AbaJOAzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 20:55:44 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:62674 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932479AbaJOAzo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 20:55:44 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb1so225475pad.39
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 17:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=f3HV1N2JTnLwTmUlRFKHXOTUmAB47/oneKlv+Kp5jHk=;
        b=amSYGhZJW3kOgmvZMXRrk47AnT707SguFBb46L16zEQ0BMbZEkG16syI560SxVOkLr
         T9FTlWHpTOKYJsYcnaNLoMj6Vb5kVlOj3B40YaMpUAKhNnAj+Hg3kszkSVcSFeFDoigK
         Ycingroe5+0VtWb2aaUQFaw8AanqGoHTFecvEHTzwpyc9iaJlDU5/cKher02HB0iSJ/R
         hkQdUJlTfdV/cRZbs6jY9CynzTeF1/Ad9u1bgKBEWI9pIhcbsOxhcqX3RF79G2kI/jzu
         nu7cy5rpHcx3xr3OJIl801dYjiYRWp65gQXhgycihPOwq1SCtsbK+0WUc0HPxE6Emi4L
         IVcA==
X-Received: by 10.66.189.163 with SMTP id gj3mr8276947pac.91.1413334543641;
        Tue, 14 Oct 2014 17:55:43 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c43b:1934:40ef:9a07])
        by mx.google.com with ESMTPSA id h4sm15510956pat.11.2014.10.14.17.55.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 17:55:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141015004522.GD32245@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
Thanks for reading.

 refs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 097fb4b..0368ed4 100644
--- a/refs.c
+++ b/refs.c
@@ -3809,16 +3809,20 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
