From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 08/17] refs.c: rollback the lockfile before we die() in repack_without_refs
Date: Mon,  3 Nov 2014 11:02:10 -0800
Message-ID: <1415041339-18450-9-git-send-email-sahlberg@google.com>
References: <1415041339-18450-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 20:08:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlMzb-0004Lf-3n
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871AbaKCTIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:08:39 -0500
Received: from mail-pd0-f201.google.com ([209.85.192.201]:63925 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283AbaKCTIg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:08:36 -0500
Received: by mail-pd0-f201.google.com with SMTP id r10so1998377pdi.2
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 11:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ixiEtrcwTmmIkMfJ2QlydY9FTqZMHUdhqaXL9Rcpigo=;
        b=N/P53eau/o9g5wj+VPctGyVg81p4UPCzoml+kvOyTxxWqleX9k42cSdnso5ZG+zFmb
         ePVchXs//NhH52WcPNRbDB2UezrMCJFwOyTRtHrf/8ONWZI6YGNCeOYvtd+TcRDko9mw
         0nkVyOp0VV3mXfnfUT5FgLk9/Tn6e+MeAxiY3CQHgZn3QkgUhIPPXrU7r06y6DypNjDR
         4PCcBD2AAPjLulRIJpVFZGhgi2GtRGVrAtSkAlhmicS9BfASU6sSHjo5lQ/qB+9Oa8+s
         ysIwQS8aT/XCPNAx/SbP3R2nVzsfF0HqI3kRZOMBV8FyXGiXiWeb3pvzqE7AcMizg1LR
         TfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ixiEtrcwTmmIkMfJ2QlydY9FTqZMHUdhqaXL9Rcpigo=;
        b=Fur1f/Tblaaz8yWfZREOAn1cUCPtFgpYrYnXqbKPE+3D0bXK3N99cZFuQQbPMtcif7
         trpHqCAIjBF1V2hwAUPUOMemBcZhi76EEfWgVGA8W+vjJY7IE8f5U851Ca0oPGD9Vp/r
         Ie1F1U7r2SC+6Q0OvkdAdynLZcVmyaWWh5IoqosZQy3ivuI2eXCsEwMpfCsL+xgBmuZ3
         avMdv0QWs+7tEEYCSm+9wG1XFYygC1ULU4GMVkn66OW2pxGmve+vzFM7iEdoLEfXowzM
         Ik4aAYida3a7N35y/1ck5kZf1q7OUrua7BtrBms3NdJidDhay6Aq/m8qxdbcgyqd95bL
         geUw==
X-Gm-Message-State: ALoCoQkwpDxqn734HmMLZJBIi+Cw4Khs9CQp2h/57R5ALrikHh1eef0BHDZCZsirj5/VZdVkdyAi
X-Received: by 10.66.248.229 with SMTP id yp5mr33488705pac.12.1415041716085;
        Mon, 03 Nov 2014 11:08:36 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id n63si974859yho.5.2014.11.03.11.08.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 11:08:36 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id m8c1uCBN.1; Mon, 03 Nov 2014 11:08:35 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 18C23E10A1; Mon,  3 Nov 2014 11:02:22 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415041339-18450-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 44d38ab..becf188 100644
--- a/refs.c
+++ b/refs.c
@@ -2707,8 +2707,10 @@ int repack_without_refs(struct string_list *without, struct strbuf *err)
 	/* Remove any other accumulated cruft */
 	do_for_each_entry_in_dir(packed, 0, curate_packed_ref_fn, &refs_to_delete);
 	for_each_string_list_item(ref_to_delete, &refs_to_delete) {
-		if (remove_entry(packed, ref_to_delete->string) == -1)
+		if (remove_entry(packed, ref_to_delete->string) == -1) {
+			rollback_packed_refs();
 			die("internal error");
+		}
 	}
 
 	/* Write what remains */
-- 
2.1.0.rc2.206.gedb03e5
