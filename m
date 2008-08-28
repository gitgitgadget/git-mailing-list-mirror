From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [JGIT PATCH 2/3] Add another delete method in RefUpdate, reusing RevWalk
Date: Thu, 28 Aug 2008 04:32:48 +0200
Message-ID: <1219890769-20119-3-git-send-email-marek.zawirski@gmail.com>
References: <1219890769-20119-1-git-send-email-marek.zawirski@gmail.com>
 <1219890769-20119-2-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Aug 28 04:34:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYXKr-0007CB-OW
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 04:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbYH1CdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 22:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752762AbYH1CdF
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 22:33:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:4996 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbYH1CdD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 22:33:03 -0400
Received: by fg-out-1718.google.com with SMTP id 19so131302fgg.17
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 19:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2fBKfzcg0EcXK2qIsudwEmK7mt6I1mJuRlA2uc/txc0=;
        b=wV7uXlU/+DcHjjXnPy4SB4PHYJUM1wPEt3Zh1lK/rYCiM7DGWcNx60JEQJOZP7uFA5
         FWs4XSAeiKNqzVy7hfDcejT6Gbv2Gpg8hBJaTVW8YAfRluDkm4mQkQfeKS2B3J0YDxuW
         KIsblB/6yUejuZEIUQFXlRUg6TVJJ1QVngqms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LusSOjYlFhRRIcl7U06aNmRXtemxlKva3HSFgEgLNkjdbQdTVS6tl61f5Pt52vp77R
         Bfl1QGzE2fSssDnjGkZ9T/vSu0+aeELxoHyBudBfVYkbP3MTZzYf/6ZoBOKU/spRHvXA
         i4dDo6C9OCTjTj2P1hYoCW+mOUaD6DI3CVrtA=
Received: by 10.86.65.11 with SMTP id n11mr600583fga.64.1219890781196;
        Wed, 27 Aug 2008 19:33:01 -0700 (PDT)
Received: from localhost ( [62.21.4.140])
        by mx.google.com with ESMTPS id d4sm551662fga.5.2008.08.27.19.32.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Aug 2008 19:33:00 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219890769-20119-2-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94022>

This is similar to update() approach when caller has possiblity to
choose between providing RevWalk instance on its own or let RefUpdate
create one.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/lib/RefUpdate.java        |   22 ++++++++++++++++++-
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
index c6536e3..e9c0e77 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
@@ -325,11 +325,30 @@ public Result update(final RevWalk walk) throws IOException {
 
 	/**
 	 * Delete the ref.
+	 * <p>
+	 * This is the same as:
+	 * 
+	 * <pre>
+	 * return delete(new RevWalk(repository));
+	 * </pre>
 	 * 
 	 * @return the result status of the delete.
 	 * @throws IOException
 	 */
 	public Result delete() throws IOException {
+		return delete(new RevWalk(db.getRepository()));
+	}
+
+	/**
+	 * Delete the ref.
+	 * 
+	 * @param walk
+	 *            a RevWalk instance this delete command can borrow to perform
+	 *            the merge test. The walk will be reset to perform the test.
+	 * @return the result status of the delete.
+	 * @throws IOException
+	 */
+	public Result delete(final RevWalk walk) throws IOException {
 		if (name.startsWith(Constants.R_HEADS)) {
 			final Ref head = db.readRef(Constants.HEAD);
 			if (head != null && name.equals(head.getName()))
@@ -337,8 +356,7 @@ public Result delete() throws IOException {
 		}
 
 		try {
-			return updateImpl(new RevWalk(db.getRepository()),
-					new DeleteStore());
+			return updateImpl(walk, new DeleteStore());
 		} catch (IOException x) {
 			result = Result.IO_FAILURE;
 			throw x;
-- 
1.5.6.3
