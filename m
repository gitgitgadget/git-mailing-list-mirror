From: Charles O'Farrell <charleso@charleso.org>
Subject: [JGIT PATCH v2 2/3] Cleanup of Branch command ready for verbose mode
Date: Wed, 20 Aug 2008 21:00:40 +1000
Message-ID: <1219230041-7998-3-git-send-email-charleso@charleso.org>
References: <1219230041-7998-1-git-send-email-charleso@charleso.org>
 <1219230041-7998-2-git-send-email-charleso@charleso.org>
Cc: Charles O'Farrell <charleso@charleso.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 13:03:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVlSs-0005xs-UI
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 13:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074AbYHTLBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 07:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753169AbYHTLBp
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 07:01:45 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:50528 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927AbYHTLBo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 07:01:44 -0400
Received: by yx-out-2324.google.com with SMTP id 8so181959yxm.1
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 04:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender;
        bh=/0MVc/pG0sZ6ltplwrpgH2t2/oMZxRB7vPEF0XGzuBE=;
        b=FA983Y6kGjcmh8lcHxMJ9AubvOuqHL5jNtfdoUO2f9RFX5AdgUxrcka+AGIeYSi0c5
         2lrN9Z/xtX18ZQTmFdvNGMruHOTr+FaC5j8MZcr+aric0ne83xP3UVV+PpkVH39tyY6L
         s2du8CJHCVWq5V+feGVxBwfxyaJ3HiegxISB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :sender;
        b=mplr0/asWk4I1SYQWCv4arQCbHIRNTkDO8GBaooMdwgMQYVi1apsm5uW5rODFKn45+
         S+yc5TjRju7vs7IoOxS1LdZtggfYgTAsN50shzLe0FVqqIQNI6Yi1lqy+3wx/f26/fJO
         hCmVVl5nHuCUH5fUp7tc2czjhhzaV7u9FOxhg=
Received: by 10.114.46.11 with SMTP id t11mr7732689wat.211.1219230102577;
        Wed, 20 Aug 2008 04:01:42 -0700 (PDT)
Received: from localhost.localdomain ( [123.200.197.247])
        by mx.google.com with ESMTPS id n22sm2340253pof.3.2008.08.20.04.01.36
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 20 Aug 2008 04:01:39 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.2.g2ebc0
In-Reply-To: <1219230041-7998-2-git-send-email-charleso@charleso.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92978>

Signed-off-by: Charles O'Farrell <charleso@charleso.org>
---
 .../src/org/spearce/jgit/pgm/Branch.java           |   31 ++++++++++++++-----
 1 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
index c89f510..7958be4 100644
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
 
+	private final Map<String, Ref> printRefs = new LinkedHashMap<String, Ref>();
+
 	@Override
 	protected void run() throws Exception {
 		if (delete || deleteForce)
@@ -87,17 +91,28 @@ private void list() {
 		if (head != null) {
 			String current = head.getName();
 			if (current.equals(Constants.HEAD))
-				printHead("(no branch)", true);
-			for (String ref : new TreeSet<String>(refs.keySet())) {
-				if (isHead(ref))
-					printHead(ref, current.equals(ref));
+				addRef("(no branch)", head);
+			addRefs(refs, Constants.HEADS_PREFIX + '/', !remote);
+			addRefs(refs, Constants.REMOTES_PREFIX + '/', remote);
+			for (final Entry<String, Ref> e : printRefs.entrySet()) {
+				printHead(e.getKey(), current.equals(e.getValue().getName()));
+			}
+		}
+	}
+
+	private void addRefs(final Map<String, Ref> allRefs, final String prefix,
+			final boolean add) {
+		if (all || add) {
+			for (final Ref ref : RefComparator.sort(allRefs.values())) {
+				final String name = ref.getName();
+				if (name.startsWith(prefix))
+					addRef(name, ref);
 			}
 		}
 	}
 
-	private boolean isHead(String key) {
-		return (all || !remote) && key.startsWith(Constants.HEADS_PREFIX)
-				|| (all || remote) && key.startsWith(Constants.REMOTES_PREFIX);
+	private void addRef(final String name, final Ref ref) {
+		printRefs.put(name, ref);
 	}
 
 	private void printHead(String ref, boolean isCurrent) {
-- 
1.6.0.2.g2ebc0
