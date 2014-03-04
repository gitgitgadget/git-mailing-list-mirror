From: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
Subject: [PATCH v2] branch.c: delete size check of newly tracked branch names
Date: Tue,  4 Mar 2014 22:29:17 +0100
Message-ID: <1393968557-22696-1-git-send-email-jacopo.notarstefano@gmail.com>
Cc: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>,
	mhagger@alum.mit.edu, christian.couder@gmail.com, pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 22:29:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKwuJ-0004fv-GH
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 22:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758197AbaCDV3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 16:29:43 -0500
Received: from mail-ea0-f181.google.com ([209.85.215.181]:52052 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758196AbaCDV3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 16:29:41 -0500
Received: by mail-ea0-f181.google.com with SMTP id k10so618317eaj.40
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 13:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=1s5066SPgn/JTzdzunESrvSaeQj61mInRSCfX5VM7gw=;
        b=QoUFafpLTuh0jU+gnmWuzj+LN/NcXskU4x9jN6e5g7Gh6vYK9kXAhgCcmLpkAGF8BI
         cP/RiClmSxnHQLumqfc7enrUStTdJboMl9W7V8CqAK4sn85Z64QSc0MgcQ7BRy6XM3vt
         3GsDJoCS3efJmjTUJu1GrIaqxSlqRvj882D7WnpyqQw1APJJari8f1s3zQK4qy4EpQj8
         oS1x+eMyLuNhRAnS28TydsWFhYU1XXAIRTeBDzWQAYqNinDSsxRVpfgbER7T2naIsWsm
         byiwfn4HGCSQ+2hBeYbOxMW7c5r9alASCigydecHoi4yqFLw5/VObxP+qo7hpmkjQlSy
         04YQ==
X-Received: by 10.15.52.66 with SMTP id o42mr1581319eew.89.1393968580382;
        Tue, 04 Mar 2014 13:29:40 -0800 (PST)
Received: from localhost.localdomain (dynamic-adsl-78-13-120-49.clienti.tiscali.it. [78.13.120.49])
        by mx.google.com with ESMTPSA id o5sm691944eeg.8.2014.03.04.13.29.36
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 04 Mar 2014 13:29:37 -0800 (PST)
X-Mailer: git-send-email 1.9.0.138.g2de3478
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243394>

Since commit 6f084a56 the length of a newly tracked branch name is limited
to 1009 = 1024 - 7 - 7 - 1 characters, a bound derived by having to store
this name in a char[1024] with two strings of length at most 7 and a '\0'
character.

This is no longer necessary as of commit a9f2c136, which uses a strbuf
(documented in Documentation/technical/api-strbuf.txt) to store this value.

Remove this unneeded check and thus allow for branch names longer than 1009
characters.

Signed-off-by: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
---
 branch.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/branch.c b/branch.c
index 723a36b..05feaff 100644
--- a/branch.c
+++ b/branch.c
@@ -114,10 +114,6 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 	struct tracking tracking;
 	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
 
-	if (strlen(new_ref) > 1024 - 7 - 7 - 1)
-		return error(_("Tracking not set up: name too long: %s"),
-				new_ref);
-
 	memset(&tracking, 0, sizeof(tracking));
 	tracking.spec.dst = (char *)orig_ref;
 	if (for_each_remote(find_tracked_branch, &tracking))
-- 
1.9.0.138.g2de3478
