From: Charles O'Farrell <charleso@charleso.org>
Subject: [JGIT PATCH 2/4] Fixed bug where RefUpdate didn't delete identical HEAD branch
Date: Sat, 23 Aug 2008 08:45:45 +1000
Message-ID: <1219445147-6801-3-git-send-email-charleso@charleso.org>
References: <1219445147-6801-1-git-send-email-charleso@charleso.org>
 <1219445147-6801-2-git-send-email-charleso@charleso.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 00:47:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWfPq-0000Sb-4G
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 00:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbYHVWqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 18:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753504AbYHVWqH
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 18:46:07 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:5340 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373AbYHVWqF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 18:46:05 -0400
Received: by py-out-1112.google.com with SMTP id p76so472265pyb.10
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 15:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references:sender;
        bh=tYd3UKqSKS/GUXR+hkfpiVWIfAtzh+AJA86ZDPnQIEs=;
        b=FMqv7QnDUx47JXy4j4JBFH1KMMhxnPBzfnjuk37/w8OLgGcYltXI6Zotf6GzxYyDGK
         JrXm+WFvvCSWzAdA0NvO4sW5a4afJhQTFnzo2fZe8ZOPhD3lJ61BU4cKwhwGBguAGf3w
         lYfQT6P9X98xwX/lpV1J2mdiZ9vOlsY5Y3w8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references
         :sender;
        b=AkUH5+vLvBBNMwMAoQ0dnHZgFmLgvy42S1BNotshE/YJLRepJeSZN0pTQXis4tZJlx
         9oNUHdSBz/TlrzipYxYxPPb21m1WO7s9gp8t16M2PgbiQlMbIJmVVnGDUgLq1RY+wTP6
         U8sp5woCI0/A9P7PHW2gn6TK3d8tD3VrX0AOU=
Received: by 10.114.191.12 with SMTP id o12mr1585987waf.224.1219445164038;
        Fri, 22 Aug 2008 15:46:04 -0700 (PDT)
Received: from localhost.localdomain ( [123.200.197.247])
        by mx.google.com with ESMTPS id q18sm3549776pog.13.2008.08.22.15.46.01
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Aug 2008 15:46:03 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.49.gea35
In-Reply-To: <1219445147-6801-2-git-send-email-charleso@charleso.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93387>

Signed-off-by: Charles O'Farrell <charleso@charleso.org>
---
 .../src/org/spearce/jgit/lib/RefUpdate.java        |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
index aa2cecb..34a784b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
@@ -359,7 +359,7 @@ private Result updateImpl(final RevWalk walk, final Store store)
 			newObj = safeParse(walk, newValue);
 			oldObj = safeParse(walk, oldValue);
 			if (newObj == oldObj)
-				return Result.NO_CHANGE;
+				return store.store(lock, Result.NO_CHANGE);
 
 			if (newObj instanceof RevCommit && oldObj instanceof RevCommit) {
 				if (walk.isMergedInto((RevCommit) oldObj, (RevCommit) newObj))
@@ -390,6 +390,8 @@ private static RevObject safeParse(final RevWalk rw, final AnyObjectId id)
 
 	private Result updateStore(final LockFile lock, final Result status)
 			throws IOException {
+		if (status == Result.NO_CHANGE)
+			return status;
 		lock.setNeedStatInformation(true);
 		lock.write(newValue);
 		String msg = getRefLogMessage();
-- 
1.6.0.49.gea35
