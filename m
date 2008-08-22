From: Charles O'Farrell <charleso@charleso.org>
Subject: [JGIT PATCH 1/4] Ensured that RefUpdate cannot delete current branch
Date: Sat, 23 Aug 2008 08:45:44 +1000
Message-ID: <1219445147-6801-2-git-send-email-charleso@charleso.org>
References: <1219445147-6801-1-git-send-email-charleso@charleso.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 00:47:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWfPN-0000Gz-V4
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 00:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444AbYHVWqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 18:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753407AbYHVWqE
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 18:46:04 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:20203 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444AbYHVWqB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 18:46:01 -0400
Received: by rv-out-0506.google.com with SMTP id k40so632514rvb.1
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 15:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references:sender;
        bh=7OFavDaBNqf7s2i6Uh+Fy/bFvUQzg0TPRUA2nzHUJgw=;
        b=E+aTsEqvSvY0QjQYGd16GRD7lyS6VA5nC4UPPP5Gkmt51Tmd+xAfmhYzP2Cd+QIR4v
         uT3/U3pc2B6EJj0fMzt//KJrUL7Km6Pf95jnCIFVEJSgrX/m0mgl/4iZaUO97pQj4gbr
         jFEyn1G6G85UjpyjDuvZ2pKuFUe6GAbfJKRu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references
         :sender;
        b=rAqG8ML6jYR1DBKt4EAg1ZjzelhX36CR1Us+9HhgQ4Wj7W+ZA7wuEBiGY2vZG7c8Se
         bHd7PFpQHZDCY1n1peTqutdKx63RCTIyCy3Y6I/FyVs1H/QQ8ecQqUJJ2ncQdyBF2/ha
         YBkziQouprWKLcShpVbRVTxRe3v15j3ACX/GY=
Received: by 10.114.53.1 with SMTP id b1mr1604553waa.165.1219445161065;
        Fri, 22 Aug 2008 15:46:01 -0700 (PDT)
Received: from localhost.localdomain ( [123.200.197.247])
        by mx.google.com with ESMTPS id q18sm3549776pog.13.2008.08.22.15.45.56
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Aug 2008 15:46:00 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.49.gea35
In-Reply-To: <1219445147-6801-1-git-send-email-charleso@charleso.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93386>

If attempted it will return a REJECTED_CURRENT_BRANCH Result.

Signed-off-by: Charles O'Farrell <charleso@charleso.org>
---
 .../src/org/spearce/jgit/lib/RefUpdate.java        |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
index ca77b75..aa2cecb 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
@@ -110,6 +110,13 @@
 		REJECTED,
 
 		/**
+		 * Rejected because trying to delete the current branch.
+		 * <p>
+		 * Has no meaning for update.
+		 */
+		REJECTED_CURRENT_BRANCH,
+
+		/**
 		 * The ref was probably not updated because of I/O error.
 		 * <p>
 		 * Unexpected I/O error occurred when writing new ref. Such error may
@@ -323,6 +330,9 @@ public Result update(final RevWalk walk) throws IOException {
 	 * @throws IOException
 	 */
 	public Result delete() throws IOException {
+		if (name.substring(Constants.R_HEADS.length()).equals(
+				db.getRepository().getBranch()))
+			return Result.REJECTED_CURRENT_BRANCH;
 		try {
 			return updateImpl(new RevWalk(db.getRepository()),
 					new DeleteStore());
-- 
1.6.0.49.gea35
