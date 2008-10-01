From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/3] Move AWTPlotRenderer to its own file.
Date: Wed,  1 Oct 2008 21:31:32 +0200
Message-ID: <1222889493-12736-3-git-send-email-robin.rosenberg@dewire.com>
References: <20081001143815.GV21310@spearce.org>
 <1222889493-12736-1-git-send-email-robin.rosenberg@dewire.com>
 <1222889493-12736-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Oct 01 21:34:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl7Si-0007Lh-W3
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 21:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817AbYJATcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 15:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753758AbYJATcr
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 15:32:47 -0400
Received: from av6-2-sn3.vrr.skanova.net ([81.228.9.180]:49673 "EHLO
	av6-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201AbYJATcl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 15:32:41 -0400
Received: by av6-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 48A653843F; Wed,  1 Oct 2008 21:32:39 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av6-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id E2CE6386CD; Wed,  1 Oct 2008 21:32:38 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id B2AD637E43;
	Wed,  1 Oct 2008 21:32:38 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.310.gf789d0.dirty
In-Reply-To: <1222889493-12736-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97256>

This is mostly a convenience issue as it allows the
use of the JVM hotswap feature while debugging.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../org/spearce/jgit/awtui/AWTPlotRenderer.java    |  137 ++++++++++++++++++++
 .../org/spearce/jgit/awtui/CommitGraphPane.java    |   92 -------------
 2 files changed, 137 insertions(+), 92 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/awtui/AWTPlotRenderer.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/awtui/AWTPlotRenderer.java b/org.spearce.jgit/src/org/spearce/jgit/awtui/AWTPlotRenderer.java
new file mode 100644
index 0000000..dc785ec
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/awtui/AWTPlotRenderer.java
@@ -0,0 +1,137 @@
+/*
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
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
+package org.spearce.jgit.awtui;
+
+import java.awt.Color;
+import java.awt.Graphics;
+import java.awt.Graphics2D;
+import java.awt.Polygon;
+
+import org.spearce.jgit.awtui.CommitGraphPane.GraphCellRender;
+import org.spearce.jgit.awtui.SwingCommitList.SwingLane;
+import org.spearce.jgit.revplot.AbstractPlotRenderer;
+import org.spearce.jgit.revplot.PlotCommit;
+
+final class AWTPlotRenderer extends AbstractPlotRenderer<SwingLane, Color> {
+
+	final GraphCellRender cell;
+
+	Graphics2D g;
+
+	AWTPlotRenderer(final GraphCellRender c) {
+		cell = c;
+	}
+
+	void paint(final Graphics in, final PlotCommit<SwingLane> commit) {
+		g = (Graphics2D) in.create();
+		try {
+			final int h = cell.getHeight();
+			g.setColor(cell.getBackground());
+			g.fillRect(0, 0, cell.getWidth(), h);
+			if (commit != null)
+				paintCommit(commit, h);
+		} finally {
+			g.dispose();
+			g = null;
+		}
+	}
+
+	@Override
+	protected void drawLine(final Color color, int x1, int y1, int x2,
+			int y2, int width) {
+		if (y1 == y2) {
+			x1 -= width / 2;
+			x2 -= width / 2;
+		} else if (x1 == x2) {
+			y1 -= width / 2;
+			y2 -= width / 2;
+		}
+
+		g.setColor(color);
+		g.setStroke(CommitGraphPane.stroke(width));
+		g.drawLine(x1, y1, x2, y2);
+	}
+
+	@Override
+	protected void drawCommitDot(final int x, final int y, final int w,
+			final int h) {
+		g.setColor(Color.blue);
+		g.setStroke(CommitGraphPane.strokeCache[1]);
+		g.fillOval(x, y, w, h);
+		g.setColor(Color.black);
+		g.drawOval(x, y, w, h);
+	}
+
+	@Override
+	protected void drawBoundaryDot(final int x, final int y, final int w,
+			final int h) {
+		g.setColor(cell.getBackground());
+		g.setStroke(CommitGraphPane.strokeCache[1]);
+		g.fillOval(x, y, w, h);
+		g.setColor(Color.black);
+		g.drawOval(x, y, w, h);
+	}
+
+	@Override
+	protected void drawText(final String msg, final int x, final int y) {
+		final int texty = g.getFontMetrics().getHeight()
+				- g.getFontMetrics().getDescent();
+		g.setColor(cell.getForeground());
+		g.drawString(msg, x, texty - (cell.getHeight() - y * 2));
+	}
+
+	@Override
+	protected Color laneColor(final SwingLane myLane) {
+		return myLane != null ? myLane.color : Color.black;
+	}
+
+	void paintTriangleDown(final int cx, final int y, final int h) {
+		final int tipX = cx;
+		final int tipY = y + h;
+		final int baseX1 = cx - 10 / 2;
+		final int baseX2 = tipX + 10 / 2;
+		final int baseY = y;
+		final Polygon triangle = new Polygon();
+		triangle.addPoint(tipX, tipY);
+		triangle.addPoint(baseX1, baseY);
+		triangle.addPoint(baseX2, baseY);
+		g.fillPolygon(triangle);
+		g.drawPolygon(triangle);
+	}
+
+}
\ No newline at end of file
diff --git a/org.spearce.jgit/src/org/spearce/jgit/awtui/CommitGraphPane.java b/org.spearce.jgit/src/org/spearce/jgit/awtui/CommitGraphPane.java
index d778821..c8c5a06 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/awtui/CommitGraphPane.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/awtui/CommitGraphPane.java
@@ -38,11 +38,8 @@
 package org.spearce.jgit.awtui;
 
 import java.awt.BasicStroke;
-import java.awt.Color;
 import java.awt.Component;
 import java.awt.Graphics;
-import java.awt.Graphics2D;
-import java.awt.Polygon;
 import java.awt.Stroke;
 import java.text.DateFormat;
 import java.text.SimpleDateFormat;
@@ -59,7 +56,6 @@
 
 import org.spearce.jgit.awtui.SwingCommitList.SwingLane;
 import org.spearce.jgit.lib.PersonIdent;
-import org.spearce.jgit.revplot.AbstractPlotRenderer;
 import org.spearce.jgit.revplot.PlotCommit;
 import org.spearce.jgit.revplot.PlotCommitList;
 
@@ -251,92 +247,4 @@ static Stroke stroke(final int width) {
 		return new BasicStroke(width);
 	}
 
-	final class AWTPlotRenderer extends AbstractPlotRenderer<SwingLane, Color> {
-
-		final GraphCellRender cell;
-
-		Graphics2D g;
-
-		AWTPlotRenderer(final GraphCellRender c) {
-			cell = c;
-		}
-
-		void paint(final Graphics in, final PlotCommit<SwingLane> commit) {
-			g = (Graphics2D) in.create();
-			try {
-				final int h = cell.getHeight();
-				g.setColor(cell.getBackground());
-				g.fillRect(0, 0, cell.getWidth(), h);
-				if (commit != null)
-					paintCommit(commit, h);
-			} finally {
-				g.dispose();
-				g = null;
-			}
-		}
-
-		@Override
-		protected void drawLine(final Color color, int x1, int y1, int x2,
-				int y2, int width) {
-			if (y1 == y2) {
-				x1 -= width / 2;
-				x2 -= width / 2;
-			} else if (x1 == x2) {
-				y1 -= width / 2;
-				y2 -= width / 2;
-			}
-
-			g.setColor(color);
-			g.setStroke(stroke(width));
-			g.drawLine(x1, y1, x2, y2);
-		}
-
-		@Override
-		protected void drawCommitDot(final int x, final int y, final int w,
-				final int h) {
-			g.setColor(Color.blue);
-			g.setStroke(strokeCache[1]);
-			g.fillOval(x, y, w, h);
-			g.setColor(Color.black);
-			g.drawOval(x, y, w, h);
-		}
-
-		@Override
-		protected void drawBoundaryDot(final int x, final int y, final int w,
-				final int h) {
-			g.setColor(cell.getBackground());
-			g.setStroke(strokeCache[1]);
-			g.fillOval(x, y, w, h);
-			g.setColor(Color.black);
-			g.drawOval(x, y, w, h);
-		}
-
-		@Override
-		protected void drawText(final String msg, final int x, final int y) {
-			final int texty = g.getFontMetrics().getHeight()
-					- g.getFontMetrics().getDescent();
-			g.setColor(cell.getForeground());
-			g.drawString(msg, x, texty - (cell.getHeight() - y * 2));
-		}
-
-		@Override
-		protected Color laneColor(final SwingLane myLane) {
-			return myLane != null ? myLane.color : Color.black;
-		}
-
-		void paintTriangleDown(final int cx, final int y, final int h) {
-			final int tipX = cx;
-			final int tipY = y + h;
-			final int baseX1 = cx - 10 / 2;
-			final int baseX2 = tipX + 10 / 2;
-			final int baseY = y;
-			final Polygon triangle = new Polygon();
-			triangle.addPoint(tipX, tipY);
-			triangle.addPoint(baseX1, baseY);
-			triangle.addPoint(baseX2, baseY);
-			g.fillPolygon(triangle);
-			g.drawPolygon(triangle);
-		}
-	}
-
 }
-- 
1.6.0.1.310.gf789d0.dirty
