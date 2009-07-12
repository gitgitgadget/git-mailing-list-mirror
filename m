From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [JGIT PATCH 3/3] Introduce the command 'jgit gui'
Date: Sun, 12 Jul 2009 16:47:06 +0200 (CEST)
Message-ID: <3966c8049c37155b2d09d3b4d2997d9e289d1e7a.1247408350u.git.johannes.schindelin@gmx.de>
References: <cover.1247408350u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: spearce@spearce.org, robin.rosenberg@dewire.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 12 16:45:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQ0Iq-0002r3-FN
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 16:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567AbZGLOpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2009 10:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753370AbZGLOpQ
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 10:45:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:43958 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753346AbZGLOpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2009 10:45:09 -0400
Received: (qmail invoked by alias); 12 Jul 2009 14:45:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp023) with SMTP; 12 Jul 2009 16:45:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+hWuRHrjWhXltuQgJeo2+h74+qfVDHowNxqiKY+Q
	OFd52N8MGmB/Zi
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1247408350u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123152>

Expose the graph-based user interface to the user.  This command takes
the same arguments as 'jgit log'.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .../services/org.spearce.jgit.pgm.TextBuiltin      |    1 +
 .../src/org/spearce/jgit/pgm/Gui.java              |  100 ++++++++++++++++++++
 2 files changed, 101 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Gui.java

diff --git a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
index 3a8cc09..335a643 100644
--- a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
+++ b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
@@ -4,6 +4,7 @@ org.spearce.jgit.pgm.Daemon
 org.spearce.jgit.pgm.DiffTree
 org.spearce.jgit.pgm.Fetch
 org.spearce.jgit.pgm.Glog
+org.spearce.jgit.pgm.Gui
 org.spearce.jgit.pgm.IndexPack
 org.spearce.jgit.pgm.Init
 org.spearce.jgit.pgm.Log
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Gui.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Gui.java
new file mode 100644
index 0000000..59904a7
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Gui.java
@@ -0,0 +1,100 @@
+/*
+ * Copyright (C) 2009, Shawn O. Pearce <spearce@spearce.org>,
+ *                     Johannes E. Schindelin <johannes.schindelin@gmx.de>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.pgm;
+
+import java.awt.event.WindowAdapter;
+import java.awt.event.WindowEvent;
+
+import java.io.File;
+
+import javax.swing.JFrame;
+
+import org.spearce.jgit.gui.CommitGraph;
+import org.spearce.jgit.gui.GraphWalk;
+
+import org.spearce.jgit.revwalk.RevCommit;
+import org.spearce.jgit.revwalk.RevWalk;
+
+class Gui extends RevWalkTextBuiltin {
+	final JFrame frame;
+
+	CommitGraph graph;
+
+	Gui() {
+		frame = new JFrame();
+		frame.addWindowListener(new WindowAdapter() {
+			@Override
+			public void windowClosing(final WindowEvent e) {
+				frame.dispose();
+			}
+		});
+	}
+
+	@Override
+	protected int walkLoop() throws Exception {
+		graph = new CommitGraph((GraphWalk)walk);
+		frame.getContentPane().add(graph);
+
+		frame.setTitle("[" + repoName() + "]");
+		frame.pack();
+		frame.setVisible(true);
+		return 0;
+	}
+
+	@Override
+	protected void show(final RevCommit c) throws Exception {
+		throw new UnsupportedOperationException();
+	}
+
+	@Override
+	protected RevWalk createWalk() {
+		if (objects)
+			throw die("Cannot use --objects with gui");
+		final GraphWalk w = new GraphWalk(db);
+		return w;
+	}
+
+	private String repoName() {
+		final File f = db.getDirectory();
+		String n = f.getName();
+		if (".git".equals(n))
+			n = f.getParentFile().getName();
+		return n;
+	}
+}
-- 
1.6.3.3.644.g82c56
