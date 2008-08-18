From: Charles O'Farrell <charleso@charleso.org>
Subject: [JGIT PATCH 2/3] Cleanup of Branch command ready for verbose mode
Date: Mon, 18 Aug 2008 21:01:44 +1000
Message-ID: <1219057305-9284-3-git-send-email-charleso@charleso.org>
References: <1219057305-9284-1-git-send-email-charleso@charleso.org>
 <1219057305-9284-2-git-send-email-charleso@charleso.org>
Cc: Charles O'Farrell <charleso@charleso.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 13:03:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV2W9-0003yB-3T
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 13:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbYHRLCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 07:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbYHRLCK
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 07:02:10 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:57796 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbYHRLCH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 07:02:07 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1931661rvb.1
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 04:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender;
        bh=uZVxd1c4kXpCH4wleGvr4ZvLXZ1Yes4NO7TvgqBIqsw=;
        b=pcpzXlU8/tGQWL7bYxcjCE+cWYucWxFzJGQKbsAbQkkQzTWr6RcXJ5Zc7DOgoshFVY
         Z9zV5uA27yvxwv3antvtUuJXsBJZMhM5YG1ijfziqzdyd+DpIjJJMmz6SQjcIfbw11xU
         /NX7SPTpmnz6NzWybBgE0+1bCTn81s/EJxPZY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :sender;
        b=TTGPeZZRviTAnMsuJjPXHxVsltUWT0YiwVyQ4Gvll0uVy9J6TzuaF1ldF+LjuSsAxd
         xwOFPx6Zl8Shq2qL68dgOEjPFxJKD6jQDSpPvt/nzQIsq8BAAXIOSsDO0rBQWY/BG+rV
         ojOWlsb+3e6IrNis/xEIRQHAxZkujZ0QS9YFk=
Received: by 10.115.18.3 with SMTP id v3mr4827250wai.218.1219057326242;
        Mon, 18 Aug 2008 04:02:06 -0700 (PDT)
Received: from localhost.localdomain ( [123.200.197.247])
        by mx.google.com with ESMTPS id m28sm1842154poh.10.2008.08.18.04.02.01
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 18 Aug 2008 04:02:05 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.2.g2ebc0
In-Reply-To: <1219057305-9284-2-git-send-email-charleso@charleso.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92696>

Signed-off-by: Charles O'Farrell <charleso@charleso.org>
---
 .../src/org/spearce/jgit/pgm/Branch.java           |   30 ++++++++++++++-----
 1 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
index c89f510..9141be0 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
@@ -39,15 +39,17 @@
 
 import java.io.IOException;
 import java.util.ArrayList;
+import java.util.LinkedHashMap;
 import java.util.List;
 import java.util.Map;
-import java.util.TreeSet;
+import java.util.Map.Entry;
 
 import org.kohsuke.args4j.Argument;
 import org.kohsuke.args4j.Option;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.lib.RefComparator;
 import org.spearce.jgit.lib.RefUpdate;
 import org.spearce.jgit.lib.RefUpdate.Result;
 
@@ -72,6 +74,8 @@
 	@Argument
 	private List<String> branches = new ArrayList<String>();
 
+	private Map<String, Ref> printRefs = new LinkedHashMap<String, Ref>();
+
 	@Override
 	protected void run() throws Exception {
 		if (delete || deleteForce)
@@ -87,17 +91,27 @@ private void list() {
 		if (head != null) {
 			String current = head.getName();
 			if (current.equals(Constants.HEAD))
-				printHead("(no branch)", true);
-			for (String ref : new TreeSet<String>(refs.keySet())) {
-				if (isHead(ref))
-					printHead(ref, current.equals(ref));
+				addRef("(no branch)", head);
+			addRefs(refs, Constants.HEADS_PREFIX, !remote);
+			addRefs(refs, Constants.REMOTES_PREFIX, remote);
+			for (Entry<String, Ref> e : printRefs.entrySet()) {
+				printHead(e.getKey(), current.equals(e.getValue().getName()));
+			}
+		}
+	}
+
+	private void addRefs(Map<String, Ref> allRefs, String prefix, boolean add) {
+		if (all || add) {
+			for (Ref ref : RefComparator.sort(allRefs.values())) {
+				String name = ref.getName();
+				if (name.startsWith(prefix))
+					addRef(name, ref);
 			}
 		}
 	}
 
-	private boolean isHead(String key) {
-		return (all || !remote) && key.startsWith(Constants.HEADS_PREFIX)
-				|| (all || remote) && key.startsWith(Constants.REMOTES_PREFIX);
+	private void addRef(String name, Ref ref) {
+		printRefs.put(name, ref);
 	}
 
 	private void printHead(String ref, boolean isCurrent) {
-- 
1.6.0.2.g2ebc0
