From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [JGIT PATCH 2/5] Add Myers' algorithm to generate diff scripts
Date: Thu, 3 Sep 2009 12:46:41 +0200 (CEST)
Message-ID: <71719b694f593f104537dd4c7246f4577d02125e.1251974493u.git.johannes.schindelin@gmx.de>
References: <alpine.DEB.1.00.0909030846230.8306@pacific.mpi-cbg.de> <cover.1251974493u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Sep 03 12:46:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mj9qD-00085E-BW
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 12:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982AbZICKqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 06:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753651AbZICKqq
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 06:46:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:54597 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753982AbZICKqp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 06:46:45 -0400
Received: (qmail invoked by alias); 03 Sep 2009 10:46:46 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp055) with SMTP; 03 Sep 2009 12:46:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Tmc5k7W+TEZWwg/10akfzaKVMQTLgZ7LCr8BoMn
	X/4zFoV1FWr+bt
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1251974493u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127646>

Myers' algorithm is the standard way to generate diff scripts in an
efficient manner (especially memory-wise).

The source contains extensive documentation about the principal
ideas of the algorithm.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .../src/org/spearce/jgit/diff/MyersDiff.java       |  515 ++++++++++++++++++++
 1 files changed, 515 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/diff/MyersDiff.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/diff/MyersDiff.java b/org.spearce.jgit/src/org/spearce/jgit/diff/MyersDiff.java
new file mode 100644
index 0000000..e19cea4
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/diff/MyersDiff.java
@@ -0,0 +1,515 @@
+/*
+ * Copyright (C) 2008-2009 Johannes E. Schindelin <johannes.schindelin@gmx.de>
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
+/**
+ * Diff algorithm, based on "An O(ND) Difference Algorithm and its
+ * Variations", by Eugene Myers.
+ *
+ * The basic idea is to put the line numbers of text A as columns ("x") and the
+ * lines of text B as rows ("y").  Now you try to find the shortest "edit path"
+ * from the upper left corner to the lower right corner, where you can
+ * always go horizontally or vertically, but diagonally from (x,y) to
+ * (x+1,y+1) only if line x in text A is identical to line y in text B.
+ *
+ * Myers' fundamental concept is the "furthest reaching D-path on diagonal k":
+ * a D-path is an edit path starting at the upper left corner and containing
+ * exactly D non-diagonal elements ("differences").  The furthest reaching
+ * D-path on diagonal k is the one that contains the most (diagonal) elements
+ * which ends on diagonal k (where k = y - x).
+ *
+ * Example:
+ *
+ *    H E L L O   W O R L D
+ *    ____
+ *  L     \___
+ *  O         \___
+ *  W             \________
+ *
+ * Since every D-path has exactly D horizontal or vertical elements, it can
+ * only end on the diagonals -D, -D+2, ..., D-2, D.
+ *
+ * Since every furthest reaching D-path contains at least one furthest
+ * reaching (D-1)-path (except for D=0), we can construct them recursively.
+ *
+ * Since we are really interested in the shortest edit path, we can start
+ * looking for a 0-path, then a 1-path, and so on, until we find a path that
+ * ends in the lower right corner.
+ *
+ * To save space, we do not need to store all paths (which has quadratic space
+ * requirements), but generate the D-paths simultaneously from both sides.
+ * When the ends meet, we will have found "the middle" of the path.  From the
+ * end points of that diagonal part, we can generate the rest recursively.
+ *
+ * This only requires linear space.
+ *
+ * The overall (runtime) complexity is
+ *
+ *	O(N * D^2 + 2 * N/2 * (D/2)^2 + 4 * N/4 * (D/4)^2 + ...)
+ *	= O(N * D^2 * 5 / 4) = O(N * D^2),
+ *
+ * (With each step, we have to find the middle parts of twice as many regions
+ * as before, but the regions (as well as the D) are halved.)
+ *
+ * So the overall runtime complexity stays the same with linear space,
+ * albeit with a larger constant factor.
+ */
+
+package org.spearce.jgit.diff;
+
+import java.util.ArrayList;
+import java.util.Iterator;
+import java.util.List;
+
+import org.spearce.jgit.util.IntList;
+
+public class MyersDiff {
+	protected EditList edits;
+	protected Sequence a, b;
+
+	public MyersDiff(Sequence a, Sequence b) {
+		this.a = a;
+		this.b = b;
+		calculateEdits();
+	}
+
+	public EditList getEdits() {
+		return edits;
+	}
+
+	// TODO: use ThreadLocal for future multi-threaded operations
+	MiddleEdit middle = new MiddleEdit();
+
+	protected void calculateEdits() {
+		edits = new EditList();
+
+		middle.initialize(0, a.size(), 0, b.size());
+		if (middle.beginA >= middle.endA &&
+				middle.beginB >= middle.endB)
+			return;
+
+		calculateEdits(middle.beginA, middle.endA,
+				middle.beginB, middle.endB);
+	}
+
+	protected void calculateEdits(int beginA, int endA,
+			int beginB, int endB) {
+		Edit edit = middle.calculate(beginA, endA, beginB, endB);
+
+		if (beginA < edit.beginA || beginB < edit.beginB) {
+			int k = edit.beginB - edit.beginA;
+			int x = middle.backward.snake(k, edit.beginA);
+			calculateEdits(beginA, x, beginB, k + x);
+		}
+
+		if (edit.getType() != Edit.Type.EMPTY)
+			edits.add(edits.size(), edit);
+
+		// after middle
+		if (endA > edit.endA || endB > edit.endB) {
+			int k = edit.endB - edit.endA;
+			int x = middle.forward.snake(k, edit.endA);
+			calculateEdits(x, endA, k + x, endB);
+		}
+	}
+
+	/**
+	 * A class to help bisecting the sequences a and b to find minimal
+	 * edit paths.
+	 *
+	 * As the arrays are reused for space efficiency, you will need one
+	 * instance per thread.
+	 *
+	 * The entry function is the calculate() method.
+	 */
+	class MiddleEdit {
+		void initialize(int beginA, int endA, int beginB, int endB) {
+			this.beginA = beginA; this.endA = endA;
+			this.beginB = beginB; this.endB = endB;
+
+			// strip common parts on either end
+			int k = beginB - beginA;
+			this.beginA = forward.snake(k, beginA);
+			this.beginB = k + this.beginA;
+
+			k = endB - endA;
+			this.endA = backward.snake(k, endA);
+			this.endB = k + this.endA;
+		}
+
+		/*
+		 * This function calculates the "middle" Edit of the shortest
+		 * edit path between the given subsequences of a and b.
+		 *
+		 * Once a forward path and a backward path meet, we found the
+		 * middle part.  From the last snake end point on both of them,
+		 * we construct the Edit.
+		 *
+		 * It is assumed that there is at least one edit in the range.
+		 */
+		// TODO: measure speed impact when this is synchronized
+		Edit calculate(int beginA, int endA, int beginB, int endB) {
+			if (beginA == endA || beginB == endB)
+				return new Edit(beginA, endA, beginB, endB);
+			this.beginA = beginA; this.endA = endA;
+			this.beginB = beginB; this.endB = endB;
+
+			/*
+			 * Following the conventions in Myers' paper, "k" is
+			 * the difference between the index into "b" and the
+			 * index into "a".
+			 */
+			int minK = beginB - endA;
+			int maxK = endB - beginA;
+
+			forward.initialize(beginB - beginA, beginA, minK, maxK);
+			backward.initialize(endB - endA, endA, minK, maxK);
+
+			for (int d = 1; ; d++)
+				if (forward.calculate(d) ||
+						backward.calculate(d))
+					return edit;
+		}
+
+		/*
+		 * For each d, we need to hold the d-paths for the diagonals
+		 * k = -d, -d + 2, ..., d - 2, d.  These are stored in the
+		 * forward (and backward) array.
+		 *
+		 * As we allow subsequences, too, this needs some refinement:
+		 * the forward paths start on the diagonal forwardK =
+		 * beginB - beginA, and backward paths start on the diagonal
+		 * backwardK = endB - endA.
+		 *
+		 * So, we need to hold the forward d-paths for the diagonals
+		 * k = forwardK - d, forwardK - d + 2, ..., forwardK + d and
+		 * the analogue for the backward d-paths.  This means that
+		 * we can turn (k, d) into the forward array index using this
+		 * formula:
+		 *
+		 *	i = (d + k - forwardK) / 2
+		 *
+		 * There is a further complication: the edit paths should not
+		 * leave the specified subsequences, so k is bounded by
+		 * minK = beginB - endA and maxK = endB - beginA.  However,
+		 * (k - forwardK) _must_ be odd whenever d is odd, and it
+		 * _must_ be even when d is even.
+		 *
+		 * The values in the "forward" and "backward" arrays are
+		 * positions ("x") in the sequence a, to get the corresponding
+		 * positions ("y") in the sequence b, you have to calculate
+		 * the appropriate k and then y:
+		 *
+		 *	k = forwardK - d + i * 2
+		 *	y = k + x
+		 *
+		 * (substitute backwardK for forwardK if you want to get the
+		 * y position for an entry in the "backward" array.
+		 */
+		EditPaths forward = new ForwardEditPaths();
+		EditPaths backward = new BackwardEditPaths();
+
+		/* Some variables which are shared between methods */
+		protected int beginA, endA, beginB, endB;
+		protected Edit edit;
+
+		abstract class EditPaths {
+			private IntList x = new IntList();
+			private IntList snake = new IntList();
+			int beginK, endK, middleK;
+			int prevBeginK, prevEndK;
+			/* if we hit one end early, no need to look further */
+			int minK, maxK; // TODO: better explanation
+
+			final int getIndex(int d, int k) {
+// TODO: remove
+if (((d + k - middleK) % 2) == 1)
+	throw new RuntimeException("odd: " + d + " + " + k + " - " + middleK);
+				return (d + k - middleK) / 2;
+			}
+
+			final int getX(int d, int k) {
+// TODO: remove
+if (k < beginK || k > endK)
+	throw new RuntimeException("k " + k + " not in " + beginK + " - " + endK);
+				return x.get(getIndex(d, k));
+			}
+
+			final int getSnake(int d, int k) {
+// TODO: remove
+if (k < beginK || k > endK)
+	throw new RuntimeException("k " + k + " not in " + beginK + " - " + endK);
+				return snake.get(getIndex(d, k));
+			}
+
+			private int forceKIntoRange(int k) {
+				/* if k is odd, so must be the result */
+				if (k < minK)
+					return minK + ((k ^ minK) & 1);
+				else if (k > maxK)
+					return maxK - ((k ^ maxK) & 1);
+				return k;
+			}
+
+			void initialize(int k, int x, int minK, int maxK) {
+				this.minK = minK;
+				this.maxK = maxK;
+				beginK = endK = middleK = k;
+				this.x.clear();
+				this.x.add(x);
+				snake.clear();
+				snake.add(newSnake(k, x));
+			}
+
+			abstract int snake(int k, int x);
+			abstract int getLeft(int x);
+			abstract int getRight(int x);
+			abstract boolean isBetter(int left, int right);
+			abstract void adjustMinMaxK(final int k, final int x);
+			abstract boolean meets(int d, int k, int x, int snake);
+
+			final int newSnake(int k, int x) {
+				int y = k + x;
+				return x + (endA + 1) * y;
+			}
+
+			final int snake2x(int snake) {
+				return snake % (endA + 1);
+			}
+
+			final int snake2y(int snake) {
+				return snake / (endA + 1);
+			}
+
+			final boolean makeEdit(int snake1, int snake2) {
+				int x1 = snake2x(snake1), x2 = snake2x(snake2);
+				int y1 = snake2y(snake1), y2 = snake2y(snake2);
+				/*
+				 * Check for incompatible partial edit paths:
+				 * when there are ambiguities, we might have
+				 * hit incompatible (i.e. non-overlapping)
+				 * forward/backward paths.
+				 *
+				 * In that case, just pretend that we have
+				 * an empty edit at the end of one snake; this
+				 * will force a decision which path to take
+				 * in the next recursion step.
+				 */
+				if (x1 > x2 || y1 > y2) {
+					x1 = x2;
+					y1 = y2;
+				}
+				edit = new Edit(x1, x2, y1, y2);
+				return true;
+			}
+
+			boolean calculate(int d) {
+				prevBeginK = beginK;
+				prevEndK = endK;
+				beginK = forceKIntoRange(middleK - d);
+				endK = forceKIntoRange(middleK + d);
+				// TODO: handle i more efficiently
+				// TODO: walk snake(k, getX(d, k)) only once per (d, k)
+				// TODO: move end points out of the loop to avoid conditionals inside the loop
+				// go backwards so that we can avoid temp vars
+				for (int k = endK; k >= beginK; k -= 2) {
+					int left = -1, right = -1;
+					int leftSnake = -1, rightSnake = -1;
+					// TODO: refactor into its own function
+					if (k > prevBeginK) {
+						int i = getIndex(d - 1, k - 1);
+						left = x.get(i);
+						int end = snake(k - 1, left);
+						leftSnake = left != end ?
+							newSnake(k - 1, end) :
+							snake.get(i);
+						if (meets(d, k - 1, end, leftSnake))
+							return true;
+						left = getLeft(end);
+					}
+					if (k < prevEndK) {
+						int i = getIndex(d - 1, k + 1);
+						right = x.get(i);
+						int end = snake(k + 1, right);
+						rightSnake = right != end ?
+							newSnake(k + 1, end) :
+							snake.get(i);
+						if (meets(d, k + 1, end, rightSnake))
+							return true;
+						right = getRight(end);
+					}
+					int newX, newSnake;
+					if (k >= prevEndK ||
+							(k > prevBeginK &&
+							 isBetter(left, right))) {
+						newX = left;
+						newSnake = leftSnake;
+					}
+					else {
+						newX = right;
+						newSnake = rightSnake;
+					}
+					if (meets(d, k, newX, newSnake))
+						return true;
+					adjustMinMaxK(k, newX);
+					int i = getIndex(d, k);
+					x.set(i, newX);
+					snake.set(i, newSnake);
+				}
+				return false;
+			}
+		}
+
+		class ForwardEditPaths extends EditPaths {
+			final int snake(int k, int x) {
+				for (; x < endA && k + x < endB; x++)
+					if (!a.equals(x, b, k + x))
+						break;
+				return x;
+			}
+
+			final int getLeft(final int x) {
+				return x;
+			}
+
+			final int getRight(final int x) {
+				return x + 1;
+			}
+
+			final boolean isBetter(final int left, final int right) {
+				return left > right;
+			}
+
+			final void adjustMinMaxK(final int k, final int x) {
+				if (x >= endA || k + x >= endB) {
+					if (k > backward.middleK)
+						maxK = k;
+					else
+						minK = k;
+				}
+			}
+
+			final boolean meets(int d, int k, int x, int snake) {
+				if (k < backward.beginK || k > backward.endK)
+					return false;
+				// TODO: move out of loop
+				if (((d - 1 + k - backward.middleK) % 2) == 1)
+					return false;
+				if (x < backward.getX(d - 1, k))
+					return false;
+				makeEdit(snake, backward.getSnake(d - 1, k));
+				return true;
+			}
+		}
+
+		class BackwardEditPaths extends EditPaths {
+			final int snake(int k, int x) {
+				for (; x > beginA && k + x > beginB; x--)
+					if (!a.equals(x - 1, b, k + x - 1))
+						break;
+				return x;
+			}
+
+			final int getLeft(final int x) {
+				return x - 1;
+			}
+
+			final int getRight(final int x) {
+				return x;
+			}
+
+			final boolean isBetter(final int left, final int right) {
+				return left < right;
+			}
+
+			final void adjustMinMaxK(final int k, final int x) {
+				if (x <= beginA || k + x <= beginB) {
+					if (k > forward.middleK)
+						maxK = k;
+					else
+						minK = k;
+				}
+			}
+
+			final boolean meets(int d, int k, int x, int snake) {
+				if (k < forward.beginK || k > forward.endK)
+					return false;
+				// TODO: move out of loop
+				if (((d + k - forward.middleK) % 2) == 1)
+					return false;
+				if (x > forward.getX(d, k))
+					return false;
+				makeEdit(forward.getSnake(d, k), snake);
+				return true;
+			}
+		}
+	}
+
+	// debugging (TODO: remove)
+	public void print(Sequence s, int begin, int end) {
+		RawText raw = (RawText)s;
+		try {
+			while (begin < end) {
+				System.err.print("" + begin + ": ");
+				raw.writeLine(System.err, begin++);
+				System.err.println("");
+			}
+		} catch (Exception e) { e.printStackTrace(); }
+	}
+
+	public void print(int beginA, int endA, int beginB, int endB) {
+		System.err.println("<<<<<<");
+		print(a, beginA, endA);
+		System.err.println("======");
+		print(b, beginB, endB);
+		System.err.println(">>>>>>");
+	}
+
+	public static void main(String[] args) {
+		if (args.length != 2) {
+			System.err.println("Need 2 arguments");
+			System.exit(1);
+		}
+		try {
+			RawText a = new RawText(new java.io.File(args[0]));
+			RawText b = new RawText(new java.io.File(args[1]));
+			MyersDiff diff = new MyersDiff(a, b);
+			System.out.println(diff.getEdits().toString());
+		} catch (Exception e) {
+			e.printStackTrace();
+		}
+	}
+}
-- 
1.6.4.297.gcb4cc
