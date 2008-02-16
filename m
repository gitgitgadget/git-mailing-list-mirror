From: Jay Soffian <jaysoffian@gmail.com>
Subject: [RFC PATCH 1/2] git-branch: allow --track to work w/local branches
Date: Fri, 15 Feb 2008 22:45:56 -0500
Message-ID: <1203133557-50013-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 04:46:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQE0h-00008B-U3
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 04:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758363AbYBPDqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 22:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758453AbYBPDqG
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 22:46:06 -0500
Received: from an-out-0708.google.com ([209.85.132.249]:22792 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758363AbYBPDqC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 22:46:02 -0500
Received: by an-out-0708.google.com with SMTP id d31so204330and.103
        for <git@vger.kernel.org>; Fri, 15 Feb 2008 19:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=b2CrCYzHbCfVSTkQbksLYFkUqZUB43PT926TYGjqaF0=;
        b=tyyKnKlT5Sy7dSdKpC5UKHiA26hYZ6xnP+GbV7IsqQQisf8l14BBVQMYCpvG7oEwwqNKo96zR+/gIGnvmwwrEdmbXKa/9Ejegoddp8DP1mZ0Jr5yBeqC/aRcV9vJQj6unQH3Xc3uPGZmA9DB9bqWNMRU5FjX8YjfgueZTstp4wE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Rbt/G0g5Qos7eNC0UawtRbIE7TROmiROR1W7HbJTuUpZDIv5hTF1VRrnWpwvLeQtR4MSCMwcfMjxPZBxQav3mKEoWG4iogclAMyDJCA+8Ezs0dUfiYb6Kb92VFnWkXxC/MHlRM4NuhIhMhMICRoY6Lk6HAIffW+7TKZhOWzlj0k=
Received: by 10.100.4.1 with SMTP id 1mr5295056and.103.1203133559952;
        Fri, 15 Feb 2008 19:45:59 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id d24sm9406128and.12.2008.02.15.19.45.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Feb 2008 19:45:59 -0800 (PST)
X-Mailer: git-send-email 1.5.4.1.1281.g75df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74003>

When given --track (or if branch.autosetupmerge is true) and basing off
a local branch, set branch.<newbranch>.remote to "." and
branch.<newbranch>.merge to the local branch. This allows us to use "git
pull" (w/o options) on the new branch.

Previously --track was silently ignored when basing off a local branch.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-branch.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index e414c88..94ab195 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -402,6 +402,16 @@ static int setup_tracking(const char *new_ref, const char *orig_ref)
 		return error("Tracking not set up: name too long: %s",
 				new_ref);
 
+	if (!prefixcmp(orig_ref, "refs/heads/")) {
+		sprintf(key, "branch.%s.remote", new_ref);
+		git_config_set(key, ".");
+		sprintf(key, "branch.%s.merge", new_ref);
+		git_config_set(key, orig_ref);
+		printf("Branch %s set up to track local branch %s.\n",
+			       new_ref, orig_ref);
+		return 0;
+	}
+
 	memset(&tracking, 0, sizeof(tracking));
 	tracking.spec.dst = (char *)orig_ref;
 	if (for_each_remote(find_tracked_branch, &tracking) ||
-- 
1.5.4.1.1281.g75df
