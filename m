From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 03/31] Fix Repository.resolve() to not throw runtime exceptions
Date: Sun, 17 Aug 2008 22:43:44 +0200
Message-ID: <1219005852-21496-4-git-send-email-marek.zawirski@gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-2-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-3-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:45:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUp8K-0002uV-A6
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbYHQUoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbYHQUoa
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:44:30 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:31899 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042AbYHQUo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:44:28 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1489141fgg.17
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=vunPHZlkQtOxjtSZgZkQOYJWPon2twGIexWhNHf2x9c=;
        b=EEV+VKDZE6reVVF4zRuwkx0rEabV1AjYAI2jOsgr0maEk7oUQplSxq/nV5hqXhuNns
         D/1wpJ9l6jAxkZ+hNOfesyR8VjtNn9rmr/sHaz/XOHZr5CuSycrxT79KmoSWWOl821IS
         WMxjnaSmShs5ChKDiYMm3GZXH4i7d+UShKl1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=apaR7p12UAA91tgV5qcf3MvFMagUtapMAR37+Vx/l0Ode/XY8mpAXppfDm8zt0c3VY
         s2o58PeLHAb/4VVZ33TbGGWZHz61jp7HioNd5Gvk9+ht/C4XJwXoQJ5m+GUxaIzQj5fG
         5Iohu5kbHuBhpjh9n0JKycgvhn6KRihyMOzTo=
Received: by 10.86.96.18 with SMTP id t18mr4023262fgb.29.1219005866846;
        Sun, 17 Aug 2008 13:44:26 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id d6sm10376640fga.2.2008.08.17.13.44.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:44:25 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-3-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92635>

resolve() was throwing undocumented runtime exceptions.
ArrayIndexOutOfBoundsException was thrown when it couldn't find commit's
parents and NumberFormatException when it couldn't parse parents number.

Now it returns null when it can't find appropriate commit's parents
and (already checked) RevisionSyntaxException when it can't parse number.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/lib/Repository.java       |   56 ++++++++++++++++----
 1 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 17cdb40..756e3b9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -569,9 +569,22 @@ public class Repository {
 								break;
 						}
 						String parentnum = new String(rev, i+1, j-i-1);
-						int pnum = Integer.parseInt(parentnum);
-						if (pnum != 0)
-							refId = ((Commit)ref).getParentIds()[pnum - 1];
+						int pnum;
+						try {
+							pnum = Integer.parseInt(parentnum);
+						} catch (NumberFormatException e) {
+							throw new RevisionSyntaxException(
+									"Invalid commit parent number",
+									revstr);
+						}
+						if (pnum != 0) {
+							final ObjectId parents[] = ((Commit) ref)
+									.getParentIds();
+							if (pnum > parents.length)
+								refId = null;
+							else
+								refId = parents[pnum - 1];
+						}
 						i = j - 1;
 						break;
 					case '{':
@@ -632,17 +645,27 @@ public class Repository {
 						break;
 					default:
 						ref = mapObject(refId, null);
-						if (ref instanceof Commit)
-							refId = ((Commit)ref).getParentIds()[0];
-						else
+						if (ref instanceof Commit) {
+							final ObjectId parents[] = ((Commit) ref)
+									.getParentIds();
+							if (parents.length == 0)
+								refId = null;
+							else
+								refId = parents[0];
+						} else
 							throw new IncorrectObjectTypeException(refId,  Constants.TYPE_COMMIT);
 						
 					}
 				} else {
 					ref = mapObject(refId, null);
-					if (ref instanceof Commit)
-						refId = ((Commit)ref).getParentIds()[0];
-					else
+					if (ref instanceof Commit) {
+						final ObjectId parents[] = ((Commit) ref)
+								.getParentIds();
+						if (parents.length == 0)
+							refId = null;
+						else
+							refId = parents[0];
+					} else
 						throw new IncorrectObjectTypeException(refId,  Constants.TYPE_COMMIT);
 				}
 				break;
@@ -658,9 +681,20 @@ public class Repository {
 						break;
 				}
 				String distnum = new String(rev, i+1, l-i-1);
-				int dist = Integer.parseInt(distnum);
+				int dist;
+				try {
+					dist = Integer.parseInt(distnum);
+				} catch (NumberFormatException e) {
+					throw new RevisionSyntaxException(
+							"Invalid ancestry length", revstr);
+				}
 				while (dist >= 0) {
-					refId = ((Commit)ref).getParentIds()[0];
+					final ObjectId[] parents = ((Commit) ref).getParentIds();
+					if (parents.length == 0) {
+						refId = null;
+						break;
+					}
+					refId = parents[0];
 					ref = mapCommit(refId);
 					--dist;
 				}
-- 
1.5.6.3
