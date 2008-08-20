From: Charles O'Farrell <charleso@charleso.org>
Subject: [JGIT PATCH v2 3/3] Verbose branch command
Date: Wed, 20 Aug 2008 21:00:41 +1000
Message-ID: <1219230041-7998-4-git-send-email-charleso@charleso.org>
References: <1219230041-7998-1-git-send-email-charleso@charleso.org>
 <1219230041-7998-2-git-send-email-charleso@charleso.org>
 <1219230041-7998-3-git-send-email-charleso@charleso.org>
Cc: Charles O'Farrell <charleso@charleso.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 13:03:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVlSu-0005xs-6H
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 13:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbYHTLBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 07:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753390AbYHTLBt
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 07:01:49 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:1941 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380AbYHTLBs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 07:01:48 -0400
Received: by rv-out-0506.google.com with SMTP id k40so404578rvb.1
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 04:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender;
        bh=HBRYKYcU77J1GW6iE9zrUVwkuS0acr5vDIxa5zaGsoc=;
        b=BOUncAy5HPbJNQVLf8ZVcnmCN0RSsKPwo4ilc+vP2RrLJP1Olrbxglw02uwtDKwe7o
         n7nqyDiXp7K+MPrwh1b0CYJIMfGfc/MrYZxJfjbLyVz5e/9rvsrVSih4a9Mj6NQEKSV6
         9u6ml3QqPpmeGYJz+N7MFhl5Ntw5dL61ZLTxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :sender;
        b=GPN3Hz/+mtqT2rhAJJi/KVDmWbS6EHd3k1FayCgXkS9H1FMcdBQzJDHGJPBYt23kMR
         cCVTL55ORfbJQCdyyWu09WLE24rebl3FkojQFONVTsTHPmNczQzS9cRYO5Q8A2vfgKd4
         O3SWLjD2dol91f8jCpKICxtDOe1Ti/QGy/w90=
Received: by 10.114.159.5 with SMTP id h5mr7712796wae.222.1219230108092;
        Wed, 20 Aug 2008 04:01:48 -0700 (PDT)
Received: from localhost.localdomain ( [123.200.197.247])
        by mx.google.com with ESMTPS id n22sm2340253pof.3.2008.08.20.04.01.43
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 20 Aug 2008 04:01:47 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.2.g2ebc0
In-Reply-To: <1219230041-7998-3-git-send-email-charleso@charleso.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92977>

Signed-off-by: Charles O'Farrell <charleso@charleso.org>
---
 .../src/org/spearce/jgit/pgm/Branch.java           |   34 +++++++++++++++----
 1 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
index 7958be4..8123f89 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
@@ -52,6 +52,7 @@
 import org.spearce.jgit.lib.RefComparator;
 import org.spearce.jgit.lib.RefUpdate;
 import org.spearce.jgit.lib.RefUpdate.Result;
+import org.spearce.jgit.revwalk.RevWalk;
 
 @Command(common = true, usage = "List, create, or delete branches")
 class Branch extends TextBuiltin {
@@ -76,15 +77,23 @@
 
 	private final Map<String, Ref> printRefs = new LinkedHashMap<String, Ref>();
 
+	/** Only set for verbose branch listing at-the-moment */
+	private RevWalk rw;
+
+	private int maxNameLength;
+
 	@Override
 	protected void run() throws Exception {
 		if (delete || deleteForce)
 			delete(deleteForce);
-		else
+		else {
+			if (verbose)
+				rw = new RevWalk(db);
 			list();
+		}
 	}
 
-	private void list() {
+	private void list() throws Exception {
 		Map<String, Ref> refs = db.getAllRefs();
 		Ref head = refs.get(Constants.HEAD);
 		// This can happen if HEAD is stillborn
@@ -95,7 +104,8 @@ private void list() {
 			addRefs(refs, Constants.HEADS_PREFIX + '/', !remote);
 			addRefs(refs, Constants.REMOTES_PREFIX + '/', remote);
 			for (final Entry<String, Ref> e : printRefs.entrySet()) {
-				printHead(e.getKey(), current.equals(e.getValue().getName()));
+				final Ref ref = e.getValue();
+				printHead(e.getKey(), current.equals(ref.getName()), ref);
 			}
 		}
 	}
@@ -106,20 +116,30 @@ private void addRefs(final Map<String, Ref> allRefs, final String prefix,
 			for (final Ref ref : RefComparator.sort(allRefs.values())) {
 				final String name = ref.getName();
 				if (name.startsWith(prefix))
-					addRef(name, ref);
+					addRef(name.substring(name.indexOf('/', 5) + 1), ref);
 			}
 		}
 	}
 
 	private void addRef(final String name, final Ref ref) {
 		printRefs.put(name, ref);
+		maxNameLength = Math.max(maxNameLength, name.length());
 	}
 
-	private void printHead(String ref, boolean isCurrent) {
+	private void printHead(final String ref, final boolean isCurrent,
+			final Ref refObj) throws Exception {
 		out.print(isCurrent ? '*' : ' ');
 		out.print(' ');
-		ref = ref.substring(ref.indexOf('/', 5) + 1);
-		out.println(ref);
+		out.print(ref);
+		if (verbose) {
+			final int spaces = maxNameLength - ref.length() + 1;
+			out.print(String.format("%" + spaces + "s", ""));
+			final ObjectId objectId = refObj.getObjectId();
+			out.print(objectId.toString().substring(0, 7));
+			out.print(' ');
+			out.print(rw.parseCommit(objectId).getShortMessage());
+		}
+		out.println();
 	}
 
 	private void delete(boolean force) throws IOException {
-- 
1.6.0.2.g2ebc0
