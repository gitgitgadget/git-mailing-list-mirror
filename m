From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/8] Move AWTPlotRenderer to its own file.
Date: Wed,  1 Oct 2008 01:53:41 +0200
Message-ID: <1222818823-22780-2-git-send-email-robin.rosenberg@dewire.com>
References: <1222818823-22780-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Oct 01 01:56:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkp4r-00047R-EA
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 01:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439AbYI3Xy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 19:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753242AbYI3Xy6
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 19:54:58 -0400
Received: from av8-1-sn3.vrr.skanova.net ([81.228.9.183]:45831 "EHLO
	av8-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588AbYI3Xyw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 19:54:52 -0400
Received: by av8-1-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 22AAF383FA; Wed,  1 Oct 2008 01:54:50 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av8-1-sn3.vrr.skanova.net (Postfix) with ESMTP
	id D4512382E2; Wed,  1 Oct 2008 01:54:49 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id EBD8C37E43;
	Wed,  1 Oct 2008 01:54:48 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.310.gf789d0.dirty
In-Reply-To: <1222818823-22780-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97176>

This is mostly a convenience issue as it allows the
use of the JVM hotswap feature while debugging.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../org/spearce/jgit/awtui/AWTPlotRenderer.java    |  104 ++++++++++++++++++++
 .../org/spearce/jgit/awtui/CommitGraphPane.java    |   92 -----------------
 2 files changed, 104 insertions(+), 92 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/awtui/AWTPlotRenderer.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/awtui/AWTPlotRenderer.java b/org.spearce.jgit/src/org/spearce/jgit/awtui/AWTPlotRenderer.java
new file mode 100644
index 0000000..a9933a4
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/awtui/AWTPlotRenderer.java
@@ -0,0 +1,104 @@
+/**
+ * 
+ */
+package org.spearce.jgit.awtui;
+
+import java.awt.Color;
+import java.awt.Graphics;
+import java.awt.Graphics2D;
+import java.awt.Polygon;
+
+import org.spearce.jgit.awtui.CommitGraphPane.GraphCellRender;
+import org.spearce.jgit.awtui.SwingCommitList.SwingLane;
+import org.spearce.jgit.lib.Ref;
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
index 4ab2136..d35bd5e 100644
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
