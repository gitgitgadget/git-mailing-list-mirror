From: Mark Struberg <struberg@yahoo.de>
Subject: [EGIT PATCH1/2] fix-CommitTimeRevFilter-by-adding-a-Between-filter
Date: Mon, 15 Jun 2009 21:35:16 +0000 (GMT)
Message-ID: <79030.47302.qm@web27808.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 15 23:35:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGJpz-0004HO-Vj
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 23:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761950AbZFOVfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 17:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755190AbZFOVfR
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 17:35:17 -0400
Received: from web27808.mail.ukl.yahoo.com ([217.146.182.13]:48473 "HELO
	web27808.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757998AbZFOVfQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 17:35:16 -0400
Received: (qmail 47762 invoked by uid 60001); 15 Jun 2009 21:35:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1245101717; bh=ImPMNV2KiYRNNZGjyXShBOkGmTXXduuvC3DqNbJAWeU=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=1JeEnQsffMXgmyz+bs79hYWh2y2Jo8nBdST7HXZTuEILU27DODqUpRg7xSfl4xAQeEJo/3D86ArDufWksWILr38iIa76D+88VeqUNwRa8KLgSH0Y7mW4eds1A+GMwLsC7c4+gYYdAjtY/bb+a9vCR69Tn3t5iw7dsFPaDh8qaV4=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=0FPfUMT2cGYeWfuUkmEcqCPTiM9QvbrS/bDml1YvbPan8L/cm5ZYvekz8QIt+Y9zv6HX8+JUcdqArCSfcUKO88+hCWdCD4NIXIerNHI2KE/G/1XJzFmGk2bC3jDQ9U1+253wZR3UTCXRjf4++DsmrP9DF1iRMUP1c5MuaTVFGyQ=;
X-YMail-OSG: 6PvyzI8VM1nLOxMzGGOxWQiZ_E_YTXjygkkJe4OZP.vd4eMq0F61yNct
Received: from [62.47.149.57] by web27808.mail.ukl.yahoo.com via HTTP; Mon, 15 Jun 2009 21:35:16 GMT
X-Mailer: YahooMailClassic/5.4.12 YahooMailWebService/0.7.289.15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121629>


>From 0a5e2d469972791cdc2e1db00602142980050af8 Mon Sep 17 00:00:00 2001
From: Mark Struberg <struberg@yahoo.de>
Date: Mon, 15 Jun 2009 01:25:25 +0200
Subject: [PATCH] fix CommitTimeRevFilter by adding a Between filter subclass

---
 .../jgit/revwalk/filter/CommitTimeRevFilter.java   |   29 ++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/filter/CommitTimeRevFilter.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/filter/CommitTimeRevFilter.java
index a3751b8..0aaa78d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/filter/CommitTimeRevFilter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/filter/CommitTimeRevFilter.java
@@ -70,6 +70,18 @@ public static final RevFilter after(final Date ts) {
 		return new After(ts.getTime());
 	}
 
+	/**
+	 * Create a new filter to select commits after or equal a given date/time <code>since</code> 
+	 * and before or equal a given date/time <code>until</code>.
+	 * 
+	 * @param since the point in time to cut on.
+	 * @param until the point in time to cut off.
+	 * @return a new filter to select commits between the given date/times.
+	 */
+	public static final RevFilter between(final Date since, final Date until) {
+		return new Between(since.getTime(), until.getTime());
+	}
+
 	final int when;
 
 	CommitTimeRevFilter(final long ts) {
@@ -117,4 +129,21 @@ public boolean include(final RevWalk walker, final RevCommit cmit)
 			return true;
 		}
 	}
+
+	private static class Between extends CommitTimeRevFilter {
+		private final int until;
+
+		Between(final long since, final long until) {
+			super(since);
+			this.until = (int) (until / 1000); 
+		}
+
+		@Override
+		public boolean include(final RevWalk walker, final RevCommit cmit)
+				throws StopWalkException, MissingObjectException,
+				IncorrectObjectTypeException, IOException {
+			return cmit.getCommitTime() <= until && cmit.getCommitTime() >= when;
+		}
+	}
+
 }
-- 
1.6.0.6



      
