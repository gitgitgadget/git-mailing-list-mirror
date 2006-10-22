From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH qgit 1/2] Directly draw lanes in ListView::paintCell()
Date: Sun, 22 Oct 2006 22:42:45 +0200
Message-ID: <200610222242.45313.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 22:42:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbk9l-0003Br-KV
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 22:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWJVUmu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 16:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWJVUmu
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 16:42:50 -0400
Received: from mail.gmx.de ([213.165.64.20]:51166 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751401AbWJVUmt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 16:42:49 -0400
Received: (qmail invoked by alias); 22 Oct 2006 20:42:47 -0000
Received: from p5496923D.dip0.t-ipconnect.de (EHLO noname) [84.150.146.61]
  by mail.gmx.net (mp016) with SMTP; 22 Oct 2006 22:42:47 +0200
X-Authenticated: #352111
To: "Marco Costalba" <mcostalba@gmail.com>
User-Agent: KMail/1.9.3
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29786>

This gives much flexibility in contrast to previous fixed
pixmaps. E.g. lane symbols could overlap now, which was
not possible before.

However, this patch does not change any drawing aside
from fixing the ugly spaces in the lanes on commits with
tag/branch labels, and shows the selection even in the
graph background (not really sure if this is wanted;
however, easy to change).

This patch does not cleanup the old pixmap drawing; it even
uses the width of one pixmap as global lane width.
The new painting code regroups the drawing commands in
multiple switch-statements to prepare for far simpler code
with booleans for different elements, and not one type only.

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
---

Hi Marco,

the change looks bigger than it really is because of the
pure rearrangement of the drawing code.
I hope I used your indentation style.

Josef

 src/listview.cpp |  184 +++++++++++++++++++++++++++++++++++++++++++++++-------
 src/listview.h   |    5 +-
 2 files changed, 166 insertions(+), 23 deletions(-)

diff --git a/src/listview.cpp b/src/listview.cpp
index db19267..a947564 100644
--- a/src/listview.cpp
+++ b/src/listview.cpp
@@ -405,24 +405,162 @@ void ListViewItem::setDiffTarget(bool b)
 	repaint();
 }
 
-void ListViewItem::paintGraph(const Rev& c, QPainter* p, const QColorGroup& cg, int width) {
+/* Draw graph part for a lane
+ */
+void ListViewItem::paintGraphLane(QPainter* p, int type, int x1, int x2,
+				  const QColor& col, const QBrush& back) {
+
+        int h = height();
+	int r = (x2-x1)/3;
+
+#define P_CENTER  (x1+x2)/2, h/2
+#define P_0       x2,        h/2
+#define P_90      (x1+x2)/2, 0
+#define P_180     x1,        h/2
+#define P_270     (x1+x2)/2, h
+#define R_CENTER  (x1+x2)/2-r, h/2-r, 2*r, 2*r
+
+        p->setPen(QPen(col, 2));
+
+	// vertical line
+	switch (type) {
+		case ACTIVE:
+		case NOT_ACTIVE:
+		case MERGE_FORK:
+		case MERGE_FORK_R:
+		case MERGE_FORK_L:
+		case JOIN:
+		case JOIN_R:
+		case JOIN_L:
+			p->drawLine(P_90, P_270);
+			break;
+		case HEAD:
+		case HEAD_R:
+		case HEAD_L:
+		case BRANCH:
+			p->drawLine(P_CENTER, P_270);
+			break;
+		case TAIL:
+		case TAIL_R:
+		case TAIL_L:
+		case INITIAL:
+		case BOUNDARY:
+		case BOUNDARY_C:
+		case BOUNDARY_R:
+		case BOUNDARY_L:
+			p->drawLine(P_90, P_CENTER);
+			break;
+	        default:
+		        break;
+	}
+
+	// horizontal line
+	switch (type) {
+		case MERGE_FORK:
+		case JOIN:
+		case HEAD:
+	        case TAIL:
+		case CROSS:
+		case CROSS_EMPTY:
+		case BOUNDARY_C:
+			p->drawLine(P_180, P_0);
+			break;
+		case MERGE_FORK_R:
+		case JOIN_R:
+		case HEAD_R:
+	        case TAIL_R:
+		case BOUNDARY_R:
+			p->drawLine(P_180, P_CENTER);
+			break;
+		case MERGE_FORK_L:
+		case JOIN_L:
+		case HEAD_L:
+	        case TAIL_L:
+		case BOUNDARY_L:
+			p->drawLine(P_CENTER, P_0);
+			break;
+	        default:
+		        break;
+	}
+
+	// center symbol, e.g. rect or ellipse
+	switch (type) {
+		case ACTIVE:
+		case INITIAL:
+		case BRANCH:
+			p->setPen(Qt::NoPen);
+			p->setBrush(col);
+			p->drawEllipse(R_CENTER);
+			break;
+		case MERGE_FORK:
+		case MERGE_FORK_R:
+		case MERGE_FORK_L:
+			p->setPen(Qt::NoPen);
+			p->setBrush(col);
+			p->drawRect(R_CENTER);
+			break;
+
+		case UNAPPLIED:
+			// Red minus sign
+			p->setPen(Qt::NoPen);
+			p->setBrush(red);
+			p->drawRect( (x1+x2)/2-r, h/2 - 1, 2*r, 2);
+			break;
+
+		case APPLIED:
+			// Green plus sign
+			p->setPen(Qt::NoPen);
+			p->setBrush(DARK_GREEN);
+			p->drawRect( (x1+x2)/2-r, h/2 - 1, 2*r, 2);
+			p->drawRect( (x1+x2)/2-1, h/2-r, 2, 2*r);
+			break;
+
+		case BOUNDARY:
+			p->setBrush(back);
+			p->drawEllipse(R_CENTER);
+			break;
+
+		case BOUNDARY_C:
+		case BOUNDARY_R:
+		case BOUNDARY_L:
+			p->setBrush(back);
+			p->drawRect(R_CENTER);
+			break;
+
+	        default:
+		        break;
+	}
+
+#undef P_CENTER
+#undef P_0
+#undef P_90
+#undef P_180
+#undef P_270
+#undef R_CENTER
+
+}
+
+
+void ListViewItem::paintGraph(const Rev& c, QPainter* p,
+			      const QColorGroup& cg, int width) {
+
+        static QColor colors[COLORS_NUM] = {Qt::black, Qt::red, DARK_GREEN,
+					    Qt::blue,  Qt::darkGray, BROWN,
+					    Qt::magenta, ORANGE};
 
-	// Copied from QListViewItem::paintCell
 	QListView* lv = listView();
 	if (!lv)
 		return;
 
-	const BackgroundMode bgmode = lv->viewport()->backgroundMode();
-	const QColorGroup::ColorRole crole = QPalette::backgroundRoleFromMode(bgmode);
+	QColorGroup::ColorRole crole = QColorGroup::Base;
+	if ( isSelected() && lv->allColumnsShowFocus() )
+	    crole = QColorGroup::Highlight;
 
-	if (isSelected() && lv->allColumnsShowFocus())
-		p->fillRect(0, 0, width, height(), cg.brush(QColorGroup::Highlight));
-	else
-		p->fillRect(0, 0, width, height(), cg.brush(crole));
+	QBrush back = cg.brush( crole );
+	p->fillRect( 0, 0, width, height(), back );
 
 	const QValueVector<int>& lanes(c.lanes);
 	uint laneNum = lanes.count();
-	int pw = pms[0]->width();
 	int mergeLane = -1;
 	for (uint i = 0; i < laneNum; i++)
 		if (isMerge(lanes[i])) {
@@ -430,26 +568,28 @@ void ListViewItem::paintGraph(const Rev&
 			break;
 		}
 
-	for (uint i = 0; i < laneNum; i++) {
+	int laneWidth = pms[0]->width();
+	int x1 = 0, x2;
+	for (uint i = 0; i < laneNum && x1 < width; i++, x1 = x2) {
+	        x2 = x1 + laneWidth;
 
-		int ln = lanes[i], idx;
+		int ln = lanes[i];
 		if (ln == EMPTY)
-			continue;
+		    continue;
 
+		int type = ln;
 		if (ln == CROSS)
-			idx = COLORS_NUM * (NOT_ACTIVE - 1);
-		else
-			idx = COLORS_NUM * (ln - 1);
+		    type = NOT_ACTIVE;
 
 		int col = (   isHead(ln) || isTail(ln) || isJoin(ln)
-		           || ln == CROSS_EMPTY) ? mergeLane : i;
+			      || ln == CROSS_EMPTY) ? mergeLane : i;
 
-		idx += col % COLORS_NUM;
-		p->drawPixmap(i * pw, 0, *pms[idx]);
-		if (ln == CROSS) {
-			idx = COLORS_NUM * (CROSS - 1) + mergeLane % COLORS_NUM;
-			p->drawPixmap(i * pw, 0, *pms[idx]);
-		}
+		paintGraphLane(p, type, x1, x2,
+			       colors[col % COLORS_NUM], back);
+
+		if (ln == CROSS)
+		    paintGraphLane(p, CROSS, x1, x2,
+				   colors[mergeLane % COLORS_NUM], back);
 	}
 }
 
diff --git a/src/listview.h b/src/listview.h
index 8e78d71..7e52e9a 100644
--- a/src/listview.h
+++ b/src/listview.h
@@ -33,7 +33,10 @@ public:
 
 private:
 	void setupData(const Rev& c);
-	void paintGraph(const Rev& c, QPainter* p, const QColorGroup& cg, int width);
+	void paintGraphLane(QPainter* p, int type, int x1, int x2,
+			    const QColor& col, const QBrush& back);
+	void paintGraph(const Rev& c, QPainter *p,
+			const QColorGroup& cg, int width);
 	void addTextPixmap(SCRef text, const QColor& color, bool bold = false);
 	QPixmap* doAddTextPixmap(SCRef text, const QColor& color, int col, bool bold);
 	const QString timeDiff(unsigned long secs) const;
-- 
1.4.3.rc2.gf8ffb
