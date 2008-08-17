From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 01/31] Fix Repository.mapObject() for missing objects
Date: Sun, 17 Aug 2008 22:43:42 +0200
Message-ID: <1219005852-21496-2-git-send-email-marek.zawirski@gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:45:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUp7s-0002oB-SM
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbYHQUoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbYHQUoX
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:44:23 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:48257 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbYHQUoW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:44:22 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2887049mue.1
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=q+BK9z4xYlBL9ibxlQCCmpsU7G2AL4BpGLZ2pgcSbdI=;
        b=fdDy1pw2Qb5XmN02WIO5e1xy/RpbTkEypmpV4UgvrnrnFbMDjWocukPkCF++vT4Zkz
         BwE/FIQmZzGKUvuWj2EnWu8jC14MyNAj3A9Lv+jWq+hD28kOKNukgrdwZptLKWJoB37w
         jOJaQjWpayZYmb8r62vj5DZ77v49sLwcM18hw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lL9+LXvpaJld1I93qn6Y8OX5/UUa5b60xJgrtvELMuVxkv+/Iw3Cm+KGzG/3Pkh0/5
         3pGrkCe5d+aGiPDDJXVvs5SZ7Y1CylipD0VOa1PFddG1V5ItO3oYcKqJ3FZ1e/A2QKiE
         NUpUO9D1ZHUV5d8gnP3+paZoNBitsjysxeRro=
Received: by 10.103.20.7 with SMTP id x7mr3467482mui.75.1219005860511;
        Sun, 17 Aug 2008 13:44:20 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id e8sm2714169muf.6.2008.08.17.13.44.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:44:19 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92631>

When object doesn't exist, instead of returning null as stated in javadoc
this method was throwing NullPointerException. Now it returns null.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/lib/Repository.java       |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 7679e53..a8591cc 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -385,6 +385,8 @@ public class Repository {
 	 */
 	public Object mapObject(final ObjectId id, final String refName) throws IOException {
 		final ObjectLoader or = openObject(id);
+		if (or == null)
+			return null;
 		final byte[] raw = or.getBytes();
 		if (or.getType() == Constants.OBJ_TREE)
 			return makeTree(id, raw);
@@ -394,7 +396,8 @@ public class Repository {
 			return makeTag(id, refName, raw);
 		if (or.getType() == Constants.OBJ_BLOB)
 			return raw;
-		return null;
+		throw new IncorrectObjectTypeException(id,
+				"COMMIT nor TREE nor BLOB nor TAG");
 	}
 
 	/**
-- 
1.5.6.3
