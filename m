From: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
Subject: [PATCH] branch.c: delete size check of newly tracked branch names
Date: Fri, 28 Feb 2014 12:09:04 +0100
Message-ID: <1393585744-2569-1-git-send-email-jacopo.notarstefano@gmail.com>
Cc: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>,
	mhagger@alum.mit.edu, christian.couder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 12:09:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJLJe-0001xJ-TY
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 12:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbaB1LJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 06:09:14 -0500
Received: from mail-ee0-f41.google.com ([74.125.83.41]:38625 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbaB1LJN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 06:09:13 -0500
Received: by mail-ee0-f41.google.com with SMTP id b15so2190438eek.0
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 03:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=9j5c/0Mm1Ny+aGFZ2rHzSEYUUus9ekZFXRJrC08yAzQ=;
        b=cwQPSPOy8zlJayQ5EUoI8CASPbnhqt2emFN66ja7LXgEvFS7TfiWYBhbbgc+ubm3m9
         ZSdeGsWA8GseAEAV3A3yP4wfgBHPJdWNtXcwVAMTSezavm0CVqzWsylA5o0i6YNkWrB4
         2Vmn6zUpe+pjx+rGXKpOV5TX28X2Q+H0qaib6oHFhRO2Vtg/zeXgsSjkasG+b+PAPdzI
         ssvhU5fiekgd0eRSjM+gmi/NGYJBaeMfBTaONFNpdY8SgjT1fLeH0qkt87ZULlwFJCeO
         +N39bbYAhnlEMsPa5TkijbE0CuC1MUgztT3tv0yYANXJfjYbXuwH1Zo6o/Q8EHYmBsZn
         aiug==
X-Received: by 10.15.73.134 with SMTP id h6mr20754622eey.15.1393585752536;
        Fri, 28 Feb 2014 03:09:12 -0800 (PST)
Received: from localhost.localdomain (dynamic-adsl-78-13-118-34.clienti.tiscali.it. [78.13.118.34])
        by mx.google.com with ESMTPSA id j41sm9120683eey.15.2014.02.28.03.09.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 28 Feb 2014 03:09:11 -0800 (PST)
X-Mailer: git-send-email 1.9.0.1.g5abca64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242941>

Since commit 6f084a56 the length of a newly tracked branch name was limited
to 1019 = 1024 - 7 - 7 - 1 characters, a bound derived by having to store
this name in a char[1024] called key with two strings of length at most 7
and a '\0' character.

This was no longer necessary as of commit a9f2c136, which uses a strbuf
(documented in Documentation/technical/api-strbuf.txt) to store this value.

This patch removes this unneeded check and thus allows for branch names
longer than 1019 characters.

Signed-off-by: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
---

Submitted as GSoC microproject #3.

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
1.9.0.1.g5abca64
