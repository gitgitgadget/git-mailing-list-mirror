From: Michael Spang <spang@google.com>
Subject: [PATCH] Fix git rev-list --reverse --max-count=N
Date: Wed, 27 Jan 2010 15:03:20 -0500
Message-ID: <1264622600-20981-1-git-send-email-spang@google.com>
Cc: "Junio C. Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 21:04:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaE7B-0001uP-Vk
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 21:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529Ab0A0UDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 15:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753517Ab0A0UDp
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 15:03:45 -0500
Received: from smtp-out.google.com ([216.239.44.51]:48950 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217Ab0A0UDo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 15:03:44 -0500
Received: from wpaz33.hot.corp.google.com (wpaz33.hot.corp.google.com [172.24.198.97])
	by smtp-out.google.com with ESMTP id o0RK3LOs011356;
	Wed, 27 Jan 2010 12:03:21 -0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1264622601; bh=rSKDepPITyxZmZtAiJmKXZ/rt4Q=;
	h=From:To:Cc:Subject:Date:Message-Id;
	b=QS4MjvKUdtP2sJTTDHXO/OH7vz33s6WIryAOc0zZFoTUQEq2htwVd6yoNYcwJI9Va
	 Dds3ypGmLmdZoOzl5a44A==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=from:to:cc:subject:date:message-id:x-mailer:x-system-of-record;
	b=I1qBXOD1kDsjDPyOzMOaOnkDggkD3/lPYSqv5PJRaIQRkdR3xQV1psfU+V8TfcndM
	7ojPwjpvcKJGbQOWvca0A==
Received: from the-enemy.nyc.corp.google.com (the-enemy.nyc.corp.google.com [172.26.77.100])
	by wpaz33.hot.corp.google.com with ESMTP id o0RK3KqO029489;
	Wed, 27 Jan 2010 12:03:20 -0800
Received: by the-enemy.nyc.corp.google.com (Postfix, from userid 81778)
	id 34D2920E255; Wed, 27 Jan 2010 15:03:20 -0500 (EST)
X-Mailer: git-send-email 1.6.6
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138192>

Using --max-count with --reverse currently outputs the last N commits
in the final output rather than the first N commits. We want to
truncate the reversed list after the first few commits, rather than
truncating the initial list and reversing that.

Signed-off-by: Michael Spang <spang@google.com>
---
 revision.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index f54d43f..62135e0 100644
--- a/revision.c
+++ b/revision.c
@@ -1993,7 +1993,8 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 		c = NULL;
 		break;
 	default:
-		revs->max_count--;
+		if (!revs->reverse)
+			revs->max_count--;
 	}
 
 	if (c)
@@ -2055,8 +2056,21 @@ struct commit *get_revision(struct rev_info *revs)
 		revs->reverse_output_stage = 1;
 	}
 
-	if (revs->reverse_output_stage)
-		return pop_commit(&revs->commits);
+	if (revs->reverse_output_stage) {
+		c = pop_commit(&revs->commits);
+
+		switch (revs->max_count) {
+		case -1:
+			break;
+		case 0:
+			c = NULL;
+			break;
+		default:
+			revs->max_count--;
+		}
+
+		return c;
+	}
 
 	c = get_revision_internal(revs);
 	if (c && revs->graph)
-- 
1.6.6
