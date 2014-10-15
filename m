From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/25] refs.c: call lock_ref_sha1_basic directly from commit
Date: Tue, 14 Oct 2014 17:49:27 -0700
Message-ID: <20141015004927.GM32245@google.com>
References: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 15 02:49:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeCmV-0001Br-WA
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 02:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbaJOAtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 20:49:32 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:47672 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755517AbaJOAtb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 20:49:31 -0400
Received: by mail-pd0-f176.google.com with SMTP id fp1so211931pdb.35
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 17:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zDz3zgPTke9ylixv5Ty/ljDTBdh5XeeoFjE0TccNhzg=;
        b=il7GhKxLggaYcEDJK3297jsg9tEL4SZ6JuANK9ETwfUlDb5dPlUQEjnMO2om8SToWK
         6n+xSO0lh3SBFnSozvsBZ78X7hyoqiodGgkNGBsT+itw7eIuDsa7YPhl4PYYDxzRic4P
         SR3bnSdb9yGq8o76mCPKq32A0yipQ4aKNW5G6Tr8yY3f07sZr4Mnh1wkAxfuaUshmMp7
         9dAyPC1yUT0molFImiqbSleGb7P2SOJjXF9SSs9ZqDFl3JmPGAp/qVtt8ChxAR7d8HiS
         fm8UlVpFYi0+dOzzaMPKOWCrVJlIcQvFwDpZ1xC4hqZJ9gsHvGJvZpvo8xPxU918gMtJ
         W6Zg==
X-Received: by 10.66.159.99 with SMTP id xb3mr8486325pab.98.1413334170941;
        Tue, 14 Oct 2014 17:49:30 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c43b:1934:40ef:9a07])
        by mx.google.com with ESMTPSA id i10sm4632381pdr.21.2014.10.14.17.49.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 17:49:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141015004522.GD32245@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Thu, 1 May 2014 10:43:39 -0700

Skip using the lock_any_ref_for_update wrapper and call lock_ref_sha1_basic
directly from the commit function.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 9c01623..b591b9c 100644
--- a/refs.c
+++ b/refs.c
@@ -3632,12 +3632,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
-		update->lock = lock_any_ref_for_update(update->refname,
-						       (update->have_old ?
-							update->old_sha1 :
-							NULL),
-						       update->flags,
-						       &update->type);
+		update->lock = lock_ref_sha1_basic(update->refname,
+						   (update->have_old ?
+						    update->old_sha1 :
+						    NULL),
+						   update->flags,
+						   &update->type);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
-- 
2.1.0.rc2.206.gedb03e5
