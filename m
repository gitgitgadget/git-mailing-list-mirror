From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 14/20] Add hasRevSort() in RevWalk for faster sorting strategy checking
Date: Sun, 15 Jun 2008 23:45:43 +0200
Message-ID: <1213566349-25395-15-git-send-email-marek.zawirski@gmail.com>
References: <1213566349-25395-1-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-2-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-3-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-4-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-5-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-6-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-7-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-8-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-9-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-10-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-11-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-12-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-13-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-14-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 15 23:48:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K805c-00020y-4W
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736AbYFOVrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 17:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753706AbYFOVrg
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:47:36 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:31273 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677AbYFOVrf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:47:35 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2958696ywe.1
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 14:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=zkNrsX1WR/TMlSYjdEOOEiKbiKNn/y+z9Ospw6bwcQw=;
        b=k6DeK7pg8JHxLeYZOzEH3fR18eZyWoLEsHxFutF1ErmUWYnULc5z5onurj9W/+D/NE
         x/gQ6xTADDxguCVBPiy2hDsT4GzIhmYLfMYLWywgVRPvQjrh+bLGqftP3hl+GW0B+01C
         suSDxrylVf9QAlACVohbfHEDP5zBDvbAUcf3s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IAGIlG3+7X0Je6/zYXmQ/vUe8d7O6FoeEPceOVy66XvzVvnGodjGtYiOpzupV52DhV
         g7OVyhI/BMsRVz9/aitjhKpZtWatrgTGjOCT6G8St/nFBPQ70//9+QydS0L2+YKQ5K5q
         9NOLyZ69FwtDjgZjy/Zpxv773iSQL1+zBs60M=
Received: by 10.151.108.19 with SMTP id k19mr9390820ybm.112.1213566455334;
        Sun, 15 Jun 2008 14:47:35 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id k8sm15686499qba.5.2008.06.15.14.47.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 14:47:34 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1213566349-25395-14-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85140>

Direct calls to this method let us avoid unnecessary cloning of
getRevSort() output just for checking existance of some strategy.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/revwalk/RevWalk.java      |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
index 4cb75ec..fc757a5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
@@ -389,6 +389,17 @@ public class RevWalk implements Iterable<RevCommit> {
 	}
 
 	/**
+	 * Check whether the provided sorting strategy is enabled.
+	 * 
+	 * @param sort
+	 *            a sorting strategy to look for.
+	 * @return true if this strategy is enabled, false otherwise
+	 */
+	public boolean hasRevSort(RevSort sort) {
+		return sorting.contains(sort);
+	}
+
+	/**
 	 * Select a single sorting strategy for the returned commits.
 	 * <p>
 	 * Disables all sorting strategies, then enables only the single strategy
-- 
1.5.5.1
