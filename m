From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [JGIT PATCH 1/3] Add a rudimentary graph-based user interface
Date: Sun, 12 Jul 2009 16:46:55 +0200 (CEST)
Message-ID: <6f63336b3517387304f5f3b3ed298d6dcab7cd47.1247408350u.git.johannes.schindelin@gmx.de>
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
	id 1MQ0Io-0002r3-Cp
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 16:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbZGLOpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2009 10:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752948AbZGLOpA
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 10:45:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:36411 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752904AbZGLOo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2009 10:44:59 -0400
Received: (qmail invoked by alias); 12 Jul 2009 14:44:57 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp041) with SMTP; 12 Jul 2009 16:44:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+38fornNa3WWTN4ttJSkwv3yoruLOmiz3amPAqrM
	crxEoUMlfRZBlq
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1247408350u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123151>

The idea for a graph-based user interface cropped up during the Google
Summer of Code 2009.  Unfortunately, the project failed, but the idea
is too good to let it go to waste.

This commit introduces a very basic Swing component which shows a graph
of the commits in the repository, newest on top, older on the bottom.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .../src/org/spearce/jgit/gui/CommitGraph.java      |   27 ++++
 .../src/org/spearce/jgit/gui/CommitGrid.java       |  147 ++++++++++++++++++++
 .../src/org/spearce/jgit/gui/CommitPainter.java    |   43 ++++++
 .../src/org/spearce/jgit/gui/CommitRow.java        |   32 +++++
 .../src/org/spearce/jgit/gui/GraphCommit.java      |   41 ++++++
 .../src/org/spearce/jgit/gui/GraphWalk.java        |   36 +++++
 6 files changed, 326 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/gui/CommitGraph.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/gui/CommitGrid.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/gui/CommitPainter.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/gui/CommitRow.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/gui/GraphCommit.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/gui/GraphWalk.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/gui/CommitGraph.java b/org.spearce.jgit/src/org/spearce/jgit/gui/CommitGraph.java
new file mode 100644
index 0000000..0d94865
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/gui/CommitGraph.java
@@ -0,0 +1,27 @@
+package org.spearce.jgit.gui;
+
+import java.awt.Dimension;
+import java.awt.Rectangle;
+
+import java.io.IOException;
+
+import javax.swing.JPanel;
+import javax.swing.JScrollPane;
+
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.errors.MissingObjectException;
+
+public class CommitGraph extends JScrollPane {
+
+	protected GraphWalk walk;
+	protected CommitGrid grid;
+
+	public CommitGraph(GraphWalk walk)
+			throws IOException, MissingObjectException {
+		super(new CommitGrid(walk));
+	}
+
+	public Dimension getPreferredSize() {
+		return new Dimension(300, 600);
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/gui/CommitGrid.java b/org.spearce.jgit/src/org/spearce/jgit/gui/CommitGrid.java
new file mode 100644
index 0000000..77f56f6
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/gui/CommitGrid.java
@@ -0,0 +1,147 @@
+package org.spearce.jgit.gui;
+
+import java.awt.Dimension;
+import java.awt.Graphics;
+import java.awt.Graphics2D;
+import java.awt.Rectangle;
+
+import java.io.IOException;
+
+import java.util.ArrayList;
+import java.util.Iterator;
+import java.util.List;
+
+import javax.swing.JComponent;
+
+import org.spearce.jgit.lib.Repository;
+
+import org.spearce.jgit.revwalk.RevSort;
+
+public class CommitGrid extends JComponent {
+	protected GraphWalk walk;
+	protected List<CommitRow> rows;
+	protected CommitPainter painter;
+	protected Rectangle clip;
+
+	protected Dimension size;
+	protected int minColumn = 0, maxColumn = 0;
+
+	// commit dimensions
+	protected int w = 200;
+	protected int h = 30;
+	protected int spacing = 20;
+
+	public CommitGrid(GraphWalk walk) {
+		this.walk = walk;
+		rows = new ArrayList<CommitRow>();
+		painter = new CommitPainter();
+		clip = new Rectangle();
+		size = new Dimension(0, 0);
+	}
+
+	public Dimension getMinimumSize() {
+		return new Dimension((maxColumn - minColumn) * (w + spacing),
+			rows.size() * (h + spacing));
+	}
+
+	public Dimension getPreferredSize() {
+		return new Dimension((maxColumn - minColumn) * (w + spacing),
+			rows.size() * (h + spacing));
+	}
+
+	// TODO: public void resetWalk(Graphwalk walk)
+
+	protected void readCommits(int maxRow) {
+		if (rows.size() > maxRow)
+			return;
+		for (;;) {
+			GraphCommit commit;
+			try {
+				commit = (GraphCommit)walk.next();
+				if (commit == null)
+					return;
+			} catch (IOException e) {
+				// TODO: show error
+				continue;
+			}
+			commit.calculateColumn();
+			int row = commit.getRow();
+			while (row >= rows.size()) {
+				rows.add(new CommitRow());
+				size.height += h + spacing;
+				resize(getMinimumSize());
+				revalidate();
+			}
+			commit.column =
+				rows.get(row).add(commit, commit.getColumn());
+			commit.childrenCount = -1;
+			maxColumn = Math.max(maxColumn, commit.column);
+			minColumn = Math.min(minColumn, commit.column);
+		}
+	}
+
+	int x2column(int x) { return x / (w + spacing); }
+	int y2row(int y) { return y / (h + spacing); }
+	int column2x(int column) { return column * (w + spacing); }
+	int row2y(int row) { return row * (h + spacing); }
+
+	class CommitsInRectangle implements Iterator<GraphCommit> {
+		int minRow, maxRow, minColumn, maxColumn;
+		int row, column;
+
+		CommitsInRectangle(int minRow, int maxRow,
+				int minColumn, int maxColumn) {
+			this.minRow = minRow;
+			this.maxRow = maxRow;
+			this.minColumn = minColumn;
+			this.maxColumn = maxColumn;
+			row = minRow;
+			column = minColumn - 1;
+
+			readCommits(maxRow);
+			maxRow = Math.min(maxRow, rows.size());
+		}
+
+		CommitsInRectangle(Rectangle r) {
+			this(y2row(r.y), y2row(r.y + r.height - 1),
+				x2column(r.x), x2column(r.x + r.width - 1));
+		}
+
+		public boolean hasNext() {
+			for (; row <= maxRow; row++, column = minColumn - 1)
+				while (++column <= maxColumn)
+					if (rows.get(row).get(column) != null)
+						return true;
+			return false;
+		}
+
+		public GraphCommit next() {
+			return rows.get(row).get(column);
+		}
+
+		public void remove() throws UnsupportedOperationException {
+			throw new UnsupportedOperationException();
+		}
+	}
+
+	public void paintComponent(Graphics g) {
+		g.getClipBounds(clip);
+		CommitsInRectangle iter = new CommitsInRectangle(clip);
+		while (iter.hasNext()) {
+			GraphCommit commit = iter.next();
+			painter.paint((Graphics2D)g, commit,
+					column2x(iter.column), row2y(iter.row),
+					w, h);
+			for (int i = 0; i < commit.getParentCount(); i++) {
+				GraphCommit parent =
+					(GraphCommit)commit.getParent(i);
+				parent.calculateColumn();
+				g.setColor(painter.foreground);
+				g.drawLine(column2x(commit.column) + w / 2,
+					row2y(commit.row) + h,
+					column2x(parent.column) + w / 2,
+					row2y(parent.row));
+			}
+		}
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/gui/CommitPainter.java b/org.spearce.jgit/src/org/spearce/jgit/gui/CommitPainter.java
new file mode 100644
index 0000000..061cd2f
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/gui/CommitPainter.java
@@ -0,0 +1,43 @@
+package org.spearce.jgit.gui;
+
+import java.awt.Color;
+import java.awt.Dimension;
+import java.awt.Graphics2D;
+import java.awt.GradientPaint;
+import java.awt.Rectangle;
+import java.awt.Shape;
+
+import java.awt.geom.Area;
+
+class CommitPainter {
+
+	protected Color background1, background2, foreground;
+	protected int margin = 2;
+
+	public CommitPainter() {
+		background1 = Color.LIGHT_GRAY;
+		background2 = background1.darker();
+		foreground = Color.BLACK;
+	}
+
+	public void paint(Graphics2D g, GraphCommit commit,
+			int x, int y, int w, int h) {
+
+		GradientPaint gradient = new GradientPaint(x, y, background1,
+				x + w, y + h, background2);
+
+		g.setPaint(gradient);
+		g.fillRect(x, y, w, h);
+		g.setColor(foreground);
+		g.drawRect(x, y, w, h);
+
+		Shape clip = g.getClip();
+		Area area = new Area(new Rectangle(x + margin, y + margin,
+					w - 2 * margin, h - 2 * margin));
+		area.intersect(new Area(clip));
+		g.setClip(area);
+		g.drawString(commit.getShortMessage(),
+				x + margin, y + margin + h / 2);
+		g.setClip(clip);
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/gui/CommitRow.java b/org.spearce.jgit/src/org/spearce/jgit/gui/CommitRow.java
new file mode 100644
index 0000000..d110e89
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/gui/CommitRow.java
@@ -0,0 +1,32 @@
+package org.spearce.jgit.gui;
+
+import java.util.ArrayList;
+import java.util.List;
+
+public class CommitRow {
+	protected List<GraphCommit> left, right;
+
+	public CommitRow() {
+		left = new ArrayList<GraphCommit>();
+		right = new ArrayList<GraphCommit>();
+	}
+
+	public GraphCommit get(int index) {
+		if (index < 0) {
+			index = -1 - index;
+			return index < left.size() ? left.get(index) : null;
+		}
+		return index < right.size() ? right.get(index) : null;
+	}
+
+	public int add(GraphCommit commit, int desiredColumn) {
+		int leftIndex = -1 - desiredColumn;
+		if (Math.abs(-1 - desiredColumn - left.size()) <
+				Math.abs(desiredColumn - right.size())) {
+			left.add(commit);
+			return -left.size();
+		}
+		right.add(commit);
+		return right.size() - 1;
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/gui/GraphCommit.java b/org.spearce.jgit/src/org/spearce/jgit/gui/GraphCommit.java
new file mode 100644
index 0000000..13a5936
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/gui/GraphCommit.java
@@ -0,0 +1,41 @@
+package org.spearce.jgit.gui;
+
+import org.spearce.jgit.lib.AnyObjectId;
+import org.spearce.jgit.revwalk.RevCommit;
+
+public class GraphCommit extends RevCommit {
+
+	protected int column = 0, row = 0;
+
+	protected int childrenCount = 0;
+	protected int cumulatedChildColumn = 0;
+
+	protected GraphCommit(final AnyObjectId id) {
+		super(id);
+	}
+
+	public void addChild(GraphCommit child) {
+		cumulatedChildColumn += child.column;
+		this.row = Math.max(this.row, child.row + 1);
+		childrenCount++;
+	}
+
+	// TODO: CommitLayout argument
+	public void calculateColumn() {
+		if (childrenCount < 0)
+			return; // already assigned
+		if (childrenCount > 0)
+			column = cumulatedChildColumn / childrenCount;
+		else
+			column = 0;
+		// TODO: ask the layout for the position
+	}
+
+	public int getColumn() {
+		return column;
+	}
+
+	public int getRow() {
+		return row;
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/gui/GraphWalk.java b/org.spearce.jgit/src/org/spearce/jgit/gui/GraphWalk.java
new file mode 100644
index 0000000..fe98df3
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/gui/GraphWalk.java
@@ -0,0 +1,36 @@
+package org.spearce.jgit.gui;
+
+import java.io.IOException;
+
+import org.spearce.jgit.lib.AnyObjectId;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.revwalk.RevSort;
+import org.spearce.jgit.revwalk.RevWalk;
+import org.spearce.jgit.revwalk.RevCommit;
+import org.spearce.jgit.errors.IncorrectObjectTypeException;
+import org.spearce.jgit.errors.MissingObjectException;
+
+public class GraphWalk extends RevWalk {
+	public GraphWalk(final Repository repo)
+			/* throws IOException, MissingObjectException */ {
+		super(repo);
+		sort(RevSort.COMMIT_TIME_DESC, true);
+	}
+	
+	protected RevCommit createCommit(final AnyObjectId id) {
+		return new GraphCommit(id);
+	}
+
+	public RevCommit next() throws MissingObjectException,
+			IncorrectObjectTypeException, IOException {
+		GraphCommit commit = (GraphCommit)super.next();
+		if (commit == null)
+			return null;
+
+		// Update all parents
+		for (int i = 0; i < commit.getParentCount(); i++)
+			((GraphCommit)commit.getParent(i)).addChild(commit);
+
+		return commit;
+	}
+}
-- 
1.6.3.3.644.g82c56
