From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH 2/2] Remove dead code after direct graph drawing
Date: Thu, 19 Oct 2006 16:13:18 +0200
Message-ID: <200610191613.19142.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 16:17:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaYer-0001Ec-3L
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 16:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161431AbWJSONf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 10:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161434AbWJSONf
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 10:13:35 -0400
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:36035 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1161431AbWJSONe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 10:13:34 -0400
Received: from dhcp-3s-61.lrr.in.tum.de (dhcp-3s-61.lrr.in.tum.de [131.159.35.61])
	by mail.in.tum.de (Postfix) with ESMTP id E15862819;
	Thu, 19 Oct 2006 16:13:32 +0200 (MEST)
To: "Marco Costalba" <mcostalba@gmail.com>
User-Agent: KMail/1.9.3
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29350>

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
---

Sorry, I forgot: this is on top of your public master as of today.

Josef

 src/listview.cpp |   94 +-----------------------------------------------------
 src/listview.h   |    2 -
 2 files changed, 1 insertions(+), 95 deletions(-)

diff --git a/src/listview.cpp b/src/listview.cpp
index 418836b..84cbfe9 100644
--- a/src/listview.cpp
+++ b/src/listview.cpp
@@ -37,9 +37,6 @@ ListView::ListView(Domain* dm, Git* g, Q
 	connect(lv, SIGNAL(currentChanged(QListViewItem*)),
 	        this, SLOT(on_currentChanged(QListViewItem*)));
 
-	connect(lv, SIGNAL(contentsMoving(int,int)),
-	        this, SLOT(on_contentsMoving(int,int)));
-
 	connect(lv, SIGNAL(mouseButtonPressed(int,QListViewItem*,const QPoint&,int)),
 	        this, SLOT(on_mouseButtonPressed(int,QListViewItem*,const QPoint&,int)));
 
@@ -82,11 +79,6 @@ void ListView::setupListView() {
 
 void ListView::on_repaintListViews(QFont& f) {
 
-	QListViewItemIterator it(lv);
-	while (it.current()) {
-		it.current()->setPixmap(GRAPH_COL, NULL);
-		++it;
-	}
 	lv->setFont(f);
 	lv->ensureItemVisible(lv->currentItem());
 }
@@ -298,41 +290,6 @@ void ListView::on_contextMenuRequested(Q
 	emit contextMenu(((ListViewItem*)item)->sha(), POPUP_LIST_EV);
 }
 
-void ListView::on_contentsMoving(int, int newY) {
-// in case of very big archives pixmap memory can became huge.
-// so we free pixmap memory for not visible items, avoiding
-// traversing the list and using only the fast iterator
-// itemBelow() and NOT the slower itemAbove()
-
-	int ph = d->m()->gm.height();
-	int h = lv->visibleHeight();
-	if (lv->childCount() < h / ph + 10)
-		return;
-
-	int curY, dummy;
-	lv->viewportToContents(0, 0, dummy, curY);
-	int delta = newY - curY;
-	QListViewItem* item;
-	if (delta > 0)
-		item = lv->itemAt(QPoint(0, 0));
-	else {
-		item = lv->itemAt(QPoint(0, h + delta));
-		delta = -delta;
-		if (item)
-			item = item->itemBelow();
-	}
-	if (item == NULL)
-		return;
-
-	int cnt = 0;
-	delta /= ph;
-	while (cnt++ < delta) {
-		item->setPixmap(GRAPH_COL, NULL); // free pixmap memory
-		item = item->itemBelow();
-		if (item == NULL)
-			break;
-	}
-}
 
 bool ListView::eventFilter(QObject* obj, QEvent* ev) {
 // we need an event filter for:
@@ -463,7 +420,6 @@ void ListViewItem::paintGraph(const Rev&
     else
 	p->fillRect( 0, 0, width, height(), cg.brush( crole ) );
 	
-    // Copy from getGraph(), modified to directly draw into cell
     const QValueVector<int>& lanes(c.lanes);
     uint laneNum = lanes.count();
     int pw = pms[0]->width();
@@ -507,19 +463,11 @@ void ListViewItem::paintCell(QPainter* p
 	if (!populated)
 		setupData(c);
 
-#if 1
 	if (column == GRAPH_COL) {
 	        paintGraph(c, p, _cg, width);
 		return;
 	}
-#else
-	// pixmap graph, separated from setupData to allow deleting
-	if (!pixmap(GRAPH_COL)) {
-		QPixmap* pm = getGraph(c);
-		setPixmap(GRAPH_COL, *pm);
-		delete pm;
-	}
-#endif
+
 	// adjust for annotation id column presence
 	int mycolumn = (fh) ? column : column + 1;
 
@@ -655,46 +603,6 @@ const QString ListViewItem::timeDiff(uns
 	return tmp;
 }
 
-QPixmap* ListViewItem::getGraph(const Rev& c) {
-
-	const QValueVector<int>& lanes(c.lanes);
-	uint laneNum = lanes.count();
-	int pw = pms[0]->width();
-	int ph = pms[0]->height();
-	QPixmap* pm = new QPixmap(pw * laneNum, ph);
-	pm->fill(ODD_LINE_COL); // faster then drawRect()
-	int mergeLane = -1;
-	for (uint i = 0; i < laneNum; i++)
-		if (isMerge(lanes[i])) {
-			mergeLane = i;
-			break;
-		}
-	QPainter p;
-	p.begin(pm);
-	for (uint i = 0; i < laneNum; i++) {
-
-		int ln = lanes[i], idx;
-		if (ln == EMPTY)
-			continue;
-
-		if (ln == CROSS)
-			idx = COLORS_NUM * (NOT_ACTIVE - 1);
-		else
-			idx = COLORS_NUM * (ln - 1);
-
-		int col = (   isHead(ln) || isTail(ln) || isJoin(ln)
-		           || ln == CROSS_EMPTY) ? mergeLane : i;
-
-		idx += col % COLORS_NUM;
-		p.drawPixmap(i * pw, 0, *pms[idx]);
-		if (ln == CROSS) {
-			idx = COLORS_NUM * (CROSS - 1) + mergeLane % COLORS_NUM;
-			p.drawPixmap(i * pw, 0, *pms[idx]);
-		}
-	}
-	p.end();
-	return pm;
-}
 
 // ***************** GraphMetrics related methods *********************
 
diff --git a/src/listview.h b/src/listview.h
index 25de935..5a49512 100644
--- a/src/listview.h
+++ b/src/listview.h
@@ -34,7 +34,6 @@ public:
 private:
 	void setupData(const Rev& c);
 	void paintGraph(const Rev& c, QPainter *p, const QColorGroup &cg, int width);
-	QPixmap* getGraph(const Rev& c);
 	void addTextPixmap(SCRef text, const QColor& color, bool bold = false);
 	QPixmap* doAddTextPixmap(SCRef text, const QColor& color, int col, bool bold);
 	const QString timeDiff(unsigned long secs) const;
@@ -80,7 +79,6 @@ private slots:
 	void on_mouseButtonPressed(int, QListViewItem*, const QPoint&, int);
 	void on_clicked(QListViewItem*);
 	void on_onItem(QListViewItem*);
-	void on_contentsMoving(int, int newY);
 
 private:
 	void setupListView();
-- 
1.4.3.rc2.gf8ffb
