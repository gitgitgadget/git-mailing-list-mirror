From: Charles O'Farrell <charleso@charleso.org>
Subject: [JGIT PATCH 3/3] Verbose branch command
Date: Mon, 18 Aug 2008 21:01:45 +1000
Message-ID: <1219057305-9284-4-git-send-email-charleso@charleso.org>
References: <1219057305-9284-1-git-send-email-charleso@charleso.org>
 <1219057305-9284-2-git-send-email-charleso@charleso.org>
 <1219057305-9284-3-git-send-email-charleso@charleso.org>
Cc: Charles O'Farrell <charleso@charleso.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 13:03:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV2W9-0003yB-Oa
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 13:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbYHRLCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 07:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752693AbYHRLCN
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 07:02:13 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:60016 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593AbYHRLCK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 07:02:10 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1218265waf.23
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 04:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender;
        bh=0N+/ID1HcivxkcoKZu2JX36T5MNKqOjIzxCHXiDaChw=;
        b=eyGHNkyEndhXbb71vGS6B7jOjaSCIsOPrv51st2xQPJAbUaTdaCgcI6J9A0s9E76ej
         MOaYraqgi5GZ6uexqO/KtjkvoefI+QLsoMInB0CEfTilkpBmF5WRK0xYJuw6BrriRN33
         /HXS2dagLIAtACmCS2ODB2crwCI7EbjeRchME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :sender;
        b=QMJH2HDUIsHIzIeEpz8jqnux8biKDRsDi7g8xofyJtAPoPBkdSg+9dmEz78YYam4j2
         M/dIN8olWeWrfFlbl62F/4wqKuPgYwa7xbnlUiDYLkDWjFNDw+dVg++00AvM9Hg/BkGA
         WWqPllNKvs5+up6W3sgpxNyJRMMxVOYT+cwag=
Received: by 10.114.192.3 with SMTP id p3mr4846679waf.112.1219057329853;
        Mon, 18 Aug 2008 04:02:09 -0700 (PDT)
Received: from localhost.localdomain ( [123.200.197.247])
        by mx.google.com with ESMTPS id m28sm1842154poh.10.2008.08.18.04.02.06
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 18 Aug 2008 04:02:08 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.2.g2ebc0
In-Reply-To: <1219057305-9284-3-git-send-email-charleso@charleso.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92698>

Signed-off-by: Charles O'Farrell <charleso@charleso.org>
---
 .../src/org/spearce/jgit/pgm/Branch.java           |   34 +++++++++++++++----
 1 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
index 9141be0..ba8ffde 100644
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
 
 	private Map<String, Ref> printRefs = new LinkedHashMap<String, Ref>();
 
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
 			addRefs(refs, Constants.HEADS_PREFIX, !remote);
 			addRefs(refs, Constants.REMOTES_PREFIX, remote);
 			for (Entry<String, Ref> e : printRefs.entrySet()) {
-				printHead(e.getKey(), current.equals(e.getValue().getName()));
+				Ref ref = e.getValue();
+				printHead(e.getKey(), current.equals(ref.getName()), ref);
 			}
 		}
 	}
@@ -105,20 +115,30 @@ private void addRefs(Map<String, Ref> allRefs, String prefix, boolean add) {
 			for (Ref ref : RefComparator.sort(allRefs.values())) {
 				String name = ref.getName();
 				if (name.startsWith(prefix))
-					addRef(name, ref);
+					addRef(name.substring(name.indexOf('/', 5) + 1), ref);
 			}
 		}
 	}
 
 	private void addRef(String name, Ref ref) {
 		printRefs.put(name, ref);
+		maxNameLength = Math.max(maxNameLength, name.length());
 	}
 
-	private void printHead(String ref, boolean isCurrent) {
+	private void printHead(String ref, boolean isCurrent, Ref refObj)
+			throws Exception {
 		out.print(isCurrent ? '*' : ' ');
 		out.print(' ');
-		ref = ref.substring(ref.indexOf('/', 5) + 1);
-		out.println(ref);
+		out.print(ref);
+		if (verbose) {
+			int spaces = maxNameLength - ref.length() + 1;
+			out.print(String.format("%" + spaces + "s", ""));
+			ObjectId objectId = refObj.getObjectId();
+			out.print(objectId.toString().substring(0, 7));
+			out.print(' ');
+			out.print(rw.parseCommit(objectId).getShortMessage());
+		}
+		out.println();
 	}
 
 	private void delete(boolean force) throws IOException {
-- 
1.6.0.2.g2ebc0
