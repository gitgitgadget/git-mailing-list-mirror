From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [PATCH JGIT] use switch to avoid multiple ifs
Date: Sat, 31 Jan 2009 15:25:44 +0100
Message-ID: <1233411944.8213.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jan 31 15:27:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTGoV-0000zO-9p
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 15:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbZAaOZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 09:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752167AbZAaOZu
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 09:25:50 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:16827 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbZAaOZu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 09:25:50 -0500
Received: by fg-out-1718.google.com with SMTP id 16so237855fgg.17
        for <git@vger.kernel.org>; Sat, 31 Jan 2009 06:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=I5Is2GnhJ2DIRPgXtPIJEuczkXXdh57uAlLwjrYrhlg=;
        b=IAMwRaJp2/iDOjGcoWZ/Pohh8b208kAiV/+LRIbmLeL148dKKu6Or1SY8R3nW4MWjI
         n73tCu+G56Z5xXOJmLGo7X3H4Ze62dprQhf7iwIfaD7NOfx9K6FZkbkBIY1mdOuJkcCc
         zuf8kjyhUQfPlz0ljmDpQXTxYZ04viw/WI1Gk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        b=Bhc9mGS+FMK4oZR3WaGPSybAyBcAzwP3yxB2DPDMbP23z0Hy+9/Yx8CjFUwgRiW4ET
         Nt6n7GkUDdJX+zmD9kfDLGu6QbMO3k/ZFUZQPqgxT8P2JK7NkAr5Ftjo7LFzU67If75F
         Fkv2EOqLjUeKeX+QkqRsbeYmwReMWtroHGbaA=
Received: by 10.103.212.2 with SMTP id o2mr1050525muq.69.1233411948028;
        Sat, 31 Jan 2009 06:25:48 -0800 (PST)
Received: from ?85.178.76.63? (e178076063.adsl.alicedsl.de [85.178.76.63])
        by mx.google.com with ESMTPS id w5sm1813993mue.25.2009.01.31.06.25.46
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 31 Jan 2009 06:25:47 -0800 (PST)
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107926>

instead of using multiple ifs that will evaluate an expression x times,
use a switch with cases to evaluate the
expression only one time.
Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
---
 .../src/org/spearce/jgit/lib/Repository.java       |   29
+++++++++++++------
 1 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index b6efac1..f42bae5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -389,16 +389,23 @@ public Object mapObject(final ObjectId id, final
String refName) throws IOExcept
 		if (or == null)
 			return null;
 		final byte[] raw = or.getBytes();
-		if (or.getType() == Constants.OBJ_TREE)
+		switch (or.getType()) {
+		case Constants.OBJ_TREE:
 			return makeTree(id, raw);
-		if (or.getType() == Constants.OBJ_COMMIT)
+			
+		case Constants.OBJ_COMMIT:
 			return makeCommit(id, raw);
-		if (or.getType() == Constants.OBJ_TAG)
+			
+		case Constants.OBJ_TAG:
 			return makeTag(id, refName, raw);
-		if (or.getType() == Constants.OBJ_BLOB)
+			
+		case Constants.OBJ_BLOB:
 			return raw;
-		throw new IncorrectObjectTypeException(id,
+			
+		default:
+			throw new IncorrectObjectTypeException(id,
 				"COMMIT nor TREE nor BLOB nor TAG");
+		}
 	}
 
 	/**
@@ -449,12 +456,16 @@ public Tree mapTree(final ObjectId id) throws
IOException {
 		if (or == null)
 			return null;
 		final byte[] raw = or.getBytes();
-		if (Constants.OBJ_TREE == or.getType()) {
+		switch (or.getType()) {
+		case Constants.OBJ_TREE:
 			return new Tree(this, id, raw);
-		}
-		if (Constants.OBJ_COMMIT == or.getType())
+
+		case Constants.OBJ_COMMIT:
 			return mapTree(ObjectId.fromString(raw, 5));
-		throw new IncorrectObjectTypeException(id, Constants.TYPE_TREE);
+			
+		default:
+			throw new IncorrectObjectTypeException(id, Constants.TYPE_TREE);
+		}
 	}
 
 	private Tree makeTree(final ObjectId id, final byte[] raw) throws
IOException {
-- 
1.6.0.6
