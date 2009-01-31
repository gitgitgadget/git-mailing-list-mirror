From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [PATCH JGIT] simplify loop with if and do while
Date: Sat, 31 Jan 2009 15:25:09 +0100
Message-ID: <1233411909.8213.0.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jan 31 15:26:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTGo0-0000oz-6N
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 15:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbZAaOZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 09:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbZAaOZT
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 09:25:19 -0500
Received: from mu-out-0910.google.com ([209.85.134.191]:12455 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbZAaOZS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 09:25:18 -0500
Received: by mu-out-0910.google.com with SMTP id g7so647157muf.1
        for <git@vger.kernel.org>; Sat, 31 Jan 2009 06:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=grTA51ynFS5nyF1cczehp+XazUnXdchqi5aUG4UKOn0=;
        b=Y7YhxLLY1+sNIdNZbirLgjWDvROqG1kOZZGd14s7PzWtBlYX2Re77BzCu6H0+qayZs
         XQR6jX2WFa7KLIzv1DYEvOSKoLIcdMmisuaTBB9McVcMCSuCAfAT0/gg3ksNkTVBrkAE
         0N+SOAGvbeEE9vZdooD8+feC+bEobMIpWRPkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        b=h2iiHF9cO+A59Zpr7tbxHKn4RVo8CGyLav2d2O8vKxXsYMvCfEW2WTSL0VZKeXfuac
         hkx/K5p/YokdluMFTmhsGgLUtKKQPsJhPjG472zmEryQRb5w9XdCIwaEdzLxhihWqMKY
         /U7nvH8jDD2sVFrPJUNBehsfA/XKKqyB4GMMQ=
Received: by 10.103.214.13 with SMTP id r13mr1056859muq.37.1233411914989;
        Sat, 31 Jan 2009 06:25:14 -0800 (PST)
Received: from ?85.178.76.63? (e178076063.adsl.alicedsl.de [85.178.76.63])
        by mx.google.com with ESMTPS id e10sm527890muf.48.2009.01.31.06.25.13
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 31 Jan 2009 06:25:14 -0800 (PST)
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107925>

replace if(condition) { do { } while (condition) } by while (condition)
{ }
Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
---
 .../src/org/spearce/jgit/lib/Repository.java       |   18
+++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 038a869..b6efac1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -247,11 +247,9 @@ public File toFile(final AnyObjectId objectId) {
 	public boolean hasObject(final AnyObjectId objectId) {
 		final PackFile[] packs = packs();
 		int k = packs.length;
-		if (k > 0) {
-			do {
-				if (packs[--k].hasObject(objectId))
-					return true;
-			} while (k > 0);
+		while (k > 0) {
+			if (packs[--k].hasObject(objectId))
+				return true;
 		}
 		return toFile(objectId).isFile();
 	}
@@ -288,12 +286,10 @@ public ObjectLoader openObject(final WindowCursor
curs, final AnyObjectId id)
 			throws IOException {
 		final PackFile[] packs = packs();
 		int k = packs.length;
-		if (k > 0) {
-			do {
-				final ObjectLoader ol = packs[--k].get(curs, id);
-				if (ol != null)
-					return ol;
-			} while (k > 0);
+		while (k > 0) {
+			final ObjectLoader ol = packs[--k].get(curs, id);
+			if (ol != null)
+				return ol;
 		}
 		try {
 			return new UnpackedObjectLoader(this, id);
-- 
1.6.0.6
