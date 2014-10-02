From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/24] refs.c: call lock_ref_sha1_basic directly from commit
Date: Wed, 1 Oct 2014 19:02:07 -0700
Message-ID: <20141002020207.GA1175@google.com>
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
X-From: git-owner@vger.kernel.org Thu Oct 02 04:02:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZVii-0007Lu-CT
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 04:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196AbaJBCCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 22:02:11 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:42865 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300AbaJBCCK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 22:02:10 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so1365276pab.4
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 19:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=mNDmGe0QbV8GnBjfT3iu5OiLJZ36P257ISyxSdk/amA=;
        b=REXBULa+E1lTpB46bpQjbh/lco5ROqmZ8Isyr6jmILWMHuo9EmveAUp62/YLhKGl3j
         caA75aQFWThzKKFoxxftDy5Q1LMOJtu1DW4GNa6roG/0elPjDVcw2UTXtUcrW5LNmP14
         +Rh91my8hyGYeAxW0nrfINzcL1SAor5cNy2gnbUz8kaWfwKhTd8g0rBx/HsyVrx3OL5k
         m+V8YOz2uRkSGTx86kYdyToVPKynx1dZv4uGGMHRPuBAZoOkZLIfC48pIy7EswwxhR8N
         8L1Vr2gV835aEqOhJ402beApWnDYraRyEssRhHd+2MILYFjpwdZQ4mI6mPYcgkhzHjAY
         j6iw==
X-Received: by 10.68.135.35 with SMTP id pp3mr605529pbb.145.1412215330231;
        Wed, 01 Oct 2014 19:02:10 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id qf3sm2024287pbc.96.2014.10.01.19.02.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Oct 2014 19:02:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141002014817.GS1175@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257779>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Thu, 1 May 2014 10:43:39 -0700

Skip using the lock_any_ref_for_update wrapper and call lock_ref_sha1_basic
directly from the commit function.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
---
As before.

 refs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 3c2ce57..f124c2b 100644
--- a/refs.c
+++ b/refs.c
@@ -3578,12 +3578,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
