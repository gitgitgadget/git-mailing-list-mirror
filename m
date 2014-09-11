From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/19] refs.c: call lock_ref_sha1_basic directly from commit
Date: Wed, 10 Sep 2014 20:07:39 -0700
Message-ID: <20140911030739.GL18279@google.com>
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
X-From: git-owner@vger.kernel.org Thu Sep 11 05:07:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRuja-0001Sj-Rm
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 05:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbaIKDHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 23:07:43 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:58486 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbaIKDHm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 23:07:42 -0400
Received: by mail-pa0-f43.google.com with SMTP id fa1so8384805pad.30
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 20:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TZJTN1l88h6KUvAwXPfRoY9eaY1+ZiinMcx63rHr/6Q=;
        b=ASz8w/qoMFLumk1sfrelRpdZcWa169HNsvqC5ffIpU1b/aBe1fXCR6qVyheEG313LR
         dLnWKTFpffTunAwrHemGMIPV/3XIYjBnrTD1Zolpm8GhzgTx4uNfTc37Oxru9ZqBQ8sN
         y3/ZJpBTzRVRDwTqGzUZ9uQWsZmxozmEylq7IVAi37PnCuZprIMfRLI2Go77rcDKpVNe
         HXhuqoYyM6jei93fGs13kT89zBfNhHr5nsFY/za8ZKmESwqp34OYZZCNa9MRbRBZ0lZh
         4z8U0viqrxGO40szCUglXLjWwHJ3UMp7SNKh0J7ziZihXT9OTNfemdHq+P6X7psHzAZ1
         lLNA==
X-Received: by 10.66.157.231 with SMTP id wp7mr1408319pab.151.1410404862356;
        Wed, 10 Sep 2014 20:07:42 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id pd7sm16679158pac.33.2014.09.10.20.07.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Sep 2014 20:07:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140911030318.GD18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256820>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Thu, 1 May 2014 10:43:39 -0700

Skip using the lock_any_ref_for_update wrapper and call lock_ref_sha1_basic
directly from the commit function.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
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
