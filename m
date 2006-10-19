From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH 1/2] Simpler way to draw commit graph
Date: Thu, 19 Oct 2006 16:13:30 +0200
Message-ID: <200610191613.31119.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 16:17:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaYeu-0001Ec-8s
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 16:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161432AbWJSONg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 10:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945926AbWJSONg
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 10:13:36 -0400
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:36547 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1161432AbWJSONe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 10:13:34 -0400
Received: from dhcp-3s-61.lrr.in.tum.de (dhcp-3s-61.lrr.in.tum.de [131.159.35.61])
	by mail.in.tum.de (Postfix) with ESMTP id 401912819;
	Thu, 19 Oct 2006 16:13:33 +0200 (MEST)
To: "Marco Costalba" <mcostalba@gmail.com>
User-Agent: KMail/1.9.3
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29349>

For drawing the commit graph, previously every item got a
pixmap created and set with item->setPixmap(), which is
drawn by the standard implementation of QListView::paintCell().

Instead, this commit implements drawing of the graph
directly in our own ListView::paintCell(). This gets rid of
a lot of complex code to reset the pixmap of invisible items
which was needed in large repositories before to not allocate
huge amounts of memory.

As we directly draw only the visible cells, it has no
influence on performance (especially, as we got rid of
pixmaps of invisible items before, and most often had
to draw the graph anyway).

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
---

Hi Marco,

currently, when drawing branch/tag labels in the commit graph,
QGit shows in the graph small white spaces. This is because
these lines are a little higher than the rest, and the
pregenerated graph pixmaps only have a given height.

In order to solve this, I looked at the code, and do not understand
one thing: Why are you creating pixmaps for the graph, and do
draw directly in paintCell() ?

This patch does exactly this, and the next one does cleanup
of code which is not used afterwards.

If you like, I can comeup with a patch to directly draw the lines
which would get rid of the original problem.

Josef

 src/listview.cpp |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/listview.h   |    1 +
 2 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/src/listview.cpp b/src/listview.cpp
index cef1c2a..418836b 100644
--- a/src/listview.cpp
+++ b/src/listview.cpp
@@ -448,6 +448,56 @@ void ListViewItem::setDiffTarget(bool b)
 	repaint();
 }
 
+void ListViewItem::paintGraph(const Rev& c, QPainter *p, const QColorGroup &cg, int width)
+{
+    // Copied from QListViewItem::paintCell
+    QListView *lv = listView();
+    if ( !lv ) return;
+
+    const BackgroundMode bgmode = lv->viewport()->backgroundMode();
+    const QColorGroup::ColorRole crole
+	= QPalette::backgroundRoleFromMode( bgmode );
+    
+    if ( isSelected() && lv->allColumnsShowFocus() )
+	p->fillRect( 0, 0, width, height(), cg.brush( QColorGroup::Highlight ) );
+    else
+	p->fillRect( 0, 0, width, height(), cg.brush( crole ) );
+	
+    // Copy from getGraph(), modified to directly draw into cell
+    const QValueVector<int>& lanes(c.lanes);
+    uint laneNum = lanes.count();
+    int pw = pms[0]->width();
+    int mergeLane = -1;
+    for (uint i = 0; i < laneNum; i++)
+	if (isMerge(lanes[i])) {
+	    mergeLane = i;
+	    break;
+	}
+
+    for (uint i = 0; i < laneNum; i++) {
+	
+	int ln = lanes[i], idx;
+	if (ln == EMPTY)
+	    continue;
+	
+	if (ln == CROSS)
+	    idx = COLORS_NUM * (NOT_ACTIVE - 1);
+	else
+	    idx = COLORS_NUM * (ln - 1);
+	
+	int col = (   isHead(ln) || isTail(ln) || isJoin(ln)
+		      || ln == CROSS_EMPTY) ? mergeLane : i;
+	
+	idx += col % COLORS_NUM;
+	p->drawPixmap(i * pw, 0, *pms[idx]);
+	if (ln == CROSS) {
+	    idx = COLORS_NUM * (CROSS - 1) + mergeLane % COLORS_NUM;
+	    p->drawPixmap(i * pw, 0, *pms[idx]);
+	}
+    }
+}
+
+
 void ListViewItem::paintCell(QPainter* p, const QColorGroup& cg,
                              int column, int width, int alignment) {
 	QColorGroup _cg(cg);
@@ -457,12 +507,19 @@ void ListViewItem::paintCell(QPainter* p
 	if (!populated)
 		setupData(c);
 
+#if 1
+	if (column == GRAPH_COL) {
+	        paintGraph(c, p, _cg, width);
+		return;
+	}
+#else
 	// pixmap graph, separated from setupData to allow deleting
 	if (!pixmap(GRAPH_COL)) {
 		QPixmap* pm = getGraph(c);
 		setPixmap(GRAPH_COL, *pm);
 		delete pm;
 	}
+#endif
 	// adjust for annotation id column presence
 	int mycolumn = (fh) ? column : column + 1;
 
diff --git a/src/listview.h b/src/listview.h
index 672ed7d..25de935 100644
--- a/src/listview.h
+++ b/src/listview.h
@@ -33,6 +33,7 @@ public:
 
 private:
 	void setupData(const Rev& c);
+	void paintGraph(const Rev& c, QPainter *p, const QColorGroup &cg, int width);
 	QPixmap* getGraph(const Rev& c);
 	void addTextPixmap(SCRef text, const QColor& color, bool bold = false);
 	QPixmap* doAddTextPixmap(SCRef text, const QColor& color, int col, bool bold);
-- 
1.4.3.rc2.gf8ffb
