From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/2] Use a UTC relative time zone for PersonIdent
Date: Mon, 15 Jun 2009 23:25:35 +0200
Message-ID: <1245101136-31874-1-git-send-email-robin.rosenberg@dewire.com>
References: <20090612195251.GQ16497@spearce.org>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Jun 15 23:26:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGJgi-0008Or-WE
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 23:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935440AbZFOVZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 17:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935443AbZFOVZo
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 17:25:44 -0400
Received: from mail.dewire.com ([83.140.172.130]:26380 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935437AbZFOVZm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 17:25:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 548D8147D71B;
	Mon, 15 Jun 2009 23:25:39 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lqQNbxSe518a; Mon, 15 Jun 2009 23:25:37 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id 8757B147D711;
	Mon, 15 Jun 2009 23:25:37 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.2.199.g7340d
In-Reply-To: <20090612195251.GQ16497@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121628>

The timezone used in Git objects is not the user's preferred
timezone, but rather a numeric form stating the offset relative to
UTC in hours and minuutes. Any special rules like daylight savings
is already accounted for and cannot be deduced from the time
zone part of the git timestamp.

As an example, a committer in Sweden will have +0100 as
his/her timezone in winter and +0200 in summer.

We hereby abandon the attempts to guess a real timezone
from the UTC offset. When creating a person ident a real
timezone can be used, but it's identifty will be lost when externalizing
and only the UTC offset will be left.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/PersonIdent.java      |   54 ++++++++++++-------
 1 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java
index 85435b5..4ed2f71 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java
@@ -39,7 +39,9 @@
 
 package org.spearce.jgit.lib;
 
+import java.text.SimpleDateFormat;
 import java.util.Date;
+import java.util.Locale;
 import java.util.TimeZone;
 
 /**
@@ -228,24 +230,24 @@ public String getEmailAddress() {
 	}
 
 	/**
-	 * @return timestamp
+	 * @return timestamp in the person's local time
 	 */
 	public Date getWhen() {
 		return new Date(when);
 	}
 
 	/**
-	 * @return this person's preferred time zone; null if time zone is unknown.
+	 * @return this person's declared time zone; null if time zone is unknown.
 	 */
 	public TimeZone getTimeZone() {
-		final String[] ids = TimeZone.getAvailableIDs(tzOffset * 60 * 1000);
-		if (ids.length == 0)
-			return null;
-		return TimeZone.getTimeZone(ids[0]);
+		StringBuffer tzId = new StringBuffer(8);
+		tzId.append("GMT");
+		appendTimezone(tzId);
+		return TimeZone.getTimeZone(tzId.toString());
 	}
 
 	/**
-	 * @return this person's preferred time zone as minutes east of UTC. If the
+	 * @return this person's declared time zone as minutes east of UTC. If the
 	 *         timezone is to the west of UTC it is negative.
 	 */
 	public int getTimeZoneOffset() {
@@ -273,6 +275,17 @@ public boolean equals(final Object o) {
 	 */
 	public String toExternalString() {
 		final StringBuffer r = new StringBuffer();
+		r.append(getName());
+		r.append(" <");
+		r.append(getEmailAddress());
+		r.append("> ");
+		r.append(when / 1000);
+		r.append(' ');
+		appendTimezone(r);
+		return r.toString();
+	}
+
+	private void appendTimezone(final StringBuffer r) {
 		int offset = tzOffset;
 		final char sign;
 		final int offsetHours;
@@ -288,12 +301,6 @@ public String toExternalString() {
 		offsetHours = offset / 60;
 		offsetMins = offset % 60;
 
-		r.append(getName());
-		r.append(" <");
-		r.append(getEmailAddress());
-		r.append("> ");
-		r.append(when / 1000);
-		r.append(' ');
 		r.append(sign);
 		if (offsetHours < 10) {
 			r.append('0');
@@ -303,25 +310,32 @@ public String toExternalString() {
 			r.append('0');
 		}
 		r.append(offsetMins);
-		return r.toString();
 	}
 
 	public String toString() {
 		final StringBuffer r = new StringBuffer();
-		int minutes;
-
-		minutes = tzOffset < 0 ? -tzOffset : tzOffset;
-		minutes = (minutes / 100) * 60 + (minutes % 100);
-		minutes = tzOffset < 0 ? -minutes : minutes;
 
 		r.append("PersonIdent[");
 		r.append(getName());
 		r.append(", ");
 		r.append(getEmailAddress());
 		r.append(", ");
-		r.append(new Date(when + minutes * 60));
+		r.append(formatTime(new SimpleDateFormat("EEE MMM d HH:mm:ss yyyy Z", Locale.US)));
 		r.append("]");
 
 		return r.toString();
 	}
+
+	/**
+	 * Format the time represented by this object using the give
+	 * SimpleDateFormat.
+	 * 
+	 * @param simpleDateFormat
+	 * @return a formatted time stamp.
+	 */
+	@SuppressWarnings("boxing")
+	public String formatTime(SimpleDateFormat simpleDateFormat) {
+		simpleDateFormat.setTimeZone(getTimeZone());
+		return simpleDateFormat.format(when);
+	}
 }
-- 
1.6.3.2.199.g7340d
