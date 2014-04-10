From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 4/4] refs.c: sort the refs by new_sha1 and merge the two update/delete loops into one
Date: Thu, 10 Apr 2014 11:30:25 -0700
Message-ID: <1397154625-11884-5-git-send-email-sahlberg@google.com>
References: <1397154625-11884-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 20:37:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYJr5-0007RC-OT
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 20:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965147AbaDJShj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 14:37:39 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:50651 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933478AbaDJShi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 14:37:38 -0400
Received: by mail-ie0-f201.google.com with SMTP id rd18so896383iec.2
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 11:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hg5oAOK14HM2de1zKEceSlRlpdU/ocNsH4e5WkAtQko=;
        b=AT70Yc9c+rYiigmJ78cUmeSxydHrnq/80iz8QgoFdvMgPq+1XbgDsodsha3khLE4DK
         2ZoXUgKX2wk2k4oC1jdnHw1dt8f2KLqlwdjPq0R7yGssi9pEc0ka7uYGfmejOV1SN7jV
         v4cwBK1ZbCo6rYe7rCLF0rTHh4J9MDkersgRZDGKF4onQ9MKXDOCBnUCncGQckoFAFM9
         Da/ouuPY6xdpy7d430O92ztswswnRjcjfI/UGXiQUHyiNh9tg0nENrOAEVTVjntIopaA
         NWpob3fzMKWOfHFMUIl5BjquvrEdKBW7Guw7qt9RSBd8ZKwFkL7BEpIkAjvtk+NryIDR
         eu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hg5oAOK14HM2de1zKEceSlRlpdU/ocNsH4e5WkAtQko=;
        b=eODAFhYsY9o2YiVbLMgvlC9dZSkAxtdlIcNFqSHbf/nKk8CvRlbp71ul1ZrCkxRdAU
         zHeExefG9n7tm5W/1WpwlaYsIF4Vh2jMAFs16ekgxkYs34cFilVG6yOi6UnEltwdEltz
         0LqgwcMcUQds6y+0iMQt+UkKzsEn6kObXU1Yy3oqESkb58uBC4mxONgaSsfHE9YQL1Ym
         3IjHbLIpZFNAFJzKtu4LR5hfTyaKC4FTSKcaqiSjiSALYDojravE4Jcqc0dGtnLoMGmW
         k4teOL9AVS0iS29xBUMxGTuB8T2ixNVB8JskQ5OgrlImGlpoewNEeNzYVOba9LzOFt4N
         DhPg==
X-Gm-Message-State: ALoCoQlWmhZWY8WIvV0wbmE46qorRdwH40OYoCEgqsjzxQqOGXqRDZSovG+CQOj+fFJlbpTD63ggcU3O1Cv1pkLyFlCU2oD2Ih+6Ade8h2WYgSQHW6iNo3D3y+FWMScEw2PBMm6kAO9u0gF2y7+QrPP5ZqucdMsGL/IbIaXzLF5Q+HmWF6kaj2kofUnpFcc66zs8lNuYBNI8
X-Received: by 10.43.117.71 with SMTP id fl7mr2572960icc.24.1397154632074;
        Thu, 10 Apr 2014 11:30:32 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id x22si797740yhd.5.2014.04.10.11.30.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Apr 2014 11:30:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id E4C565A41AE;
	Thu, 10 Apr 2014 11:30:31 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id AA6D5E0591; Thu, 10 Apr 2014 11:30:31 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.478.ga5a8238.dirty
In-Reply-To: <1397154625-11884-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246030>

We want to make sure that we update all refs before we delete any refs
so that there is no point in time where the tips may not be reachable
from any ref in the system.
We currently acheive this by first looping over all updates and applying
them before we run a second loop and perform all the deletes.

If we sort the new sha1 for all the refs so that a deleted ref,
with sha1 0{40} comes at the end of the array, then we can just run
a single loop and still guarantee that all updates happen before
any deletes.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 1678e12..453318e 100644
--- a/refs.c
+++ b/refs.c
@@ -3309,6 +3309,15 @@ static int ref_update_compare(const void *r1, const void *r2)
 	return strcmp((*u1)->ref_name, (*u2)->ref_name);
 }
 
+static int ref_delete_compare(const void *r1, const void *r2)
+{
+	const struct ref_update * const *u1 = r1;
+	const struct ref_update * const *u2 = r2;
+
+	/* -strcmp so that 0{40} sorts to the end */
+	return -strcmp((*u1)->new_sha1, (*u2)->new_sha1);
+}
+
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 					enum action_on_err onerr)
 {
@@ -3388,13 +3397,8 @@ int update_refs(const char *action, const struct ref_update **updates_orig,
 		unlink_or_warn(git_path("logs/%s", delnames[i]));
 	clear_loose_ref_cache(&ref_cache);
 
-	/* Perform updates first so live commits remain referenced */
-	for (i = 0; i < n; i++)
-		if (locks[i] && !locks[i]->delete_ref) {
-			ret |= commit_ref_lock(locks[i]);
-			locks[i] = NULL;
-		}
-	/* And finally perform all deletes */
+	/* Sort the array so that we perform all updates before any deletes */
+	qsort(updates, n, sizeof(*updates), ref_delete_compare);
 	for (i = 0; i < n; i++)
 		if (locks[i]) {
 			ret |= commit_ref_lock(locks[i]);
-- 
1.9.1.478.ga5a8238.dirty
