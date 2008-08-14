From: Charles O'Farrell <charleso@charleso.org>
Subject: [PATCH 7/7] jgit: Added branch deletion to jgit command
Date: Thu, 14 Aug 2008 20:13:49 +1000
Message-ID: <1218708829-8175-8-git-send-email-charleso@charleso.org>
References: <1218708829-8175-1-git-send-email-charleso@charleso.org>
 <1218708829-8175-2-git-send-email-charleso@charleso.org>
 <1218708829-8175-3-git-send-email-charleso@charleso.org>
 <1218708829-8175-4-git-send-email-charleso@charleso.org>
 <1218708829-8175-5-git-send-email-charleso@charleso.org>
 <1218708829-8175-6-git-send-email-charleso@charleso.org>
 <1218708829-8175-7-git-send-email-charleso@charleso.org>
Cc: Charles O'Farrell <charleso@charleso.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 12:16:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTZsB-0003J8-Oq
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 12:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937AbYHNKOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 06:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753894AbYHNKOk
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 06:14:40 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:44651 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889AbYHNKOj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 06:14:39 -0400
Received: by rv-out-0506.google.com with SMTP id k40so333673rvb.1
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 03:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender;
        bh=uMCg2Lj0mZYJTKDKYdpGS2eAx9hERd+ul27J4XUX2z8=;
        b=bC0J6W1xf/7ef1suM7CVpVHZg9ZfqUgVnHm510OkxIyNwkV01LtPrtlxcmVKfjiMWR
         I/JxcOALAP3uLak2SHJ6Grk7ScMbUBQFJNFqMIp1EhF82zyTGb2bJOyrTpccQ7zaNHLT
         33Vy+NFGvGu5DPoEGrSh1WA4rAOlhyyjDFmSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :sender;
        b=a//aTOb2Z5Acr6GrnVlveR7JS54YGDrZQ3C03x7GPEg/S3/bYYWGftsVMzG0CjQ0qt
         UjcZTG6d04uVthhTbW3S9jUCNYs/wOq13ULSn76tCnCLYDqBjRdd/3UOza6SwO+/KxZu
         yE/Q6aJnqYp7ckAHjA7siWMRyzB50FQiOjlVw=
Received: by 10.114.81.1 with SMTP id e1mr949044wab.11.1218708878923;
        Thu, 14 Aug 2008 03:14:38 -0700 (PDT)
Received: from localhost.localdomain ( [123.200.240.102])
        by mx.google.com with ESMTPS id a8sm2909044poa.12.2008.08.14.03.14.35
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 03:14:37 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc2.35.g04c6e
In-Reply-To: <1218708829-8175-7-git-send-email-charleso@charleso.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92348>

Signed-off-by: Charles O'Farrell <charleso@charleso.org>
---
 .../src/org/spearce/jgit/pgm/Branch.java           |   57 +++++++++++++++++++-
 1 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
index 8415fe2..c89f510 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
@@ -37,24 +37,50 @@
 
 package org.spearce.jgit.pgm;
 
+import java.io.IOException;
+import java.util.ArrayList;
+import java.util.List;
 import java.util.Map;
 import java.util.TreeSet;
 
+import org.kohsuke.args4j.Argument;
 import org.kohsuke.args4j.Option;
 import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.lib.RefUpdate;
+import org.spearce.jgit.lib.RefUpdate.Result;
 
 @Command(common = true, usage = "List, create, or delete branches")
 class Branch extends TextBuiltin {
 
 	@Option(name = "--remote", aliases = { "-r" }, usage = "act on remote-tracking branches")
-	boolean remote = false;
+	private boolean remote = false;
 
 	@Option(name = "--all", aliases = { "-a" }, usage = "list both remote-tracking and local branches")
-	boolean all = false;
+	private boolean all = false;
+
+	@Option(name = "--delete", aliases = { "-d" }, usage = "delete fully merged branch")
+	private boolean delete = false;
+
+	@Option(name = "--delete-force", aliases = { "-D" }, usage = "delete branch (even if not merged)")
+	private boolean deleteForce = false;
+
+	@Option(name = "--verbose", aliases = { "-v" }, usage = "be verbose")
+	private boolean verbose = false;
+
+	@Argument
+	private List<String> branches = new ArrayList<String>();
 
 	@Override
 	protected void run() throws Exception {
+		if (delete || deleteForce)
+			delete(deleteForce);
+		else
+			list();
+	}
+
+	private void list() {
 		Map<String, Ref> refs = db.getAllRefs();
 		Ref head = refs.get(Constants.HEAD);
 		// This can happen if HEAD is stillborn
@@ -80,4 +106,31 @@ class Branch extends TextBuiltin {
 		ref = ref.substring(ref.indexOf('/', 5) + 1);
 		out.println(ref);
 	}
+
+	private void delete(boolean force) throws IOException {
+		String current = db.getBranch();
+		ObjectId head = db.resolve(Constants.HEAD);
+		for (String branch : branches) {
+			if (current.equals(branch)) {
+				String err = "Cannot delete the branch '%s' which you are currently on.";
+				throw die(String.format(err, branch));
+			}
+			RefUpdate update = db.updateRef((remote ? Constants.REMOTES_PREFIX
+					: Constants.HEADS_PREFIX)
+					+ '/' + branch);
+			update.setNewObjectId(head);
+			update.setForceUpdate(force || remote);
+			Result result = update.delete();
+			if (result == Result.REJECTED) {
+				String err = "The branch '%s' is not an ancestor of your current HEAD.\n"
+						+ "If you are sure you want to delete it, run 'jgit branch -D %1$s'.";
+				throw die(String.format(err, branch));
+			} else if (result == Result.NEW)
+				throw die(String.format("branch '%s' not found.", branch));
+			if (remote)
+				out.println(String.format("Deleted remote branch %s", branch));
+			else if (verbose)
+				out.println(String.format("Deleted branch %s", branch));
+		}
+	}
 }
-- 
1.6.0.rc2.35.g04c6e
