From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH qgit 2/2] Remove old drawing code for graph part pixmaps
Date: Sun, 22 Oct 2006 22:44:15 +0200
Message-ID: <200610222244.15156.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 22:44:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbkBC-0003QN-Cp
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 22:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWJVUoT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 16:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWJVUoT
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 16:44:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:16606 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751437AbWJVUoS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 16:44:18 -0400
Received: (qmail invoked by alias); 22 Oct 2006 20:44:16 -0000
Received: from p5496923D.dip0.t-ipconnect.de (EHLO noname) [84.150.146.61]
  by mail.gmx.net (mp030) with SMTP; 22 Oct 2006 22:44:16 +0200
X-Authenticated: #352111
To: "Marco Costalba" <mcostalba@gmail.com>
User-Agent: KMail/1.9.3
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29787>

The laneWidth is now explicitly set in GraphMetrics, and
shared with the ListViewItem's via reference.

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
---
 src/listview.cpp |  187 ++----------------------------------------------------
 src/listview.h   |    4 +-
 src/mainimpl.cpp |    3 +-
 src/mainimpl.h   |    6 +--
 4 files changed, 10 insertions(+), 190 deletions(-)

diff --git a/src/listview.cpp b/src/listview.cpp
index a947564..7251b97 100644
--- a/src/listview.cpp
+++ b/src/listview.cpp
@@ -222,11 +222,10 @@ void ListView::on_newRevsAdded(const Fil
 	if (lv->childCount() == 0)
 		lastItem = NULL;
 
-	const QPtrVector<QPixmap>& pm = d->m()->gm.pixmaps;
-
 	for (uint i = lv->childCount(); i < shaVec.count(); i++) {
-		lastItem = new ListViewItem(lv, lastItem, git, shaVec[i], pm,
-		                            evenLine, secs, fh);
+		lastItem = new ListViewItem(lv, lastItem, git, shaVec[i],
+		                            d->m()->gm.laneWidth,
+					    evenLine, secs, fh);
 		evenLine = !evenLine;
 	}
 }
@@ -344,7 +343,7 @@ bool ListView::filterRightButtonPressed(
 
 bool ListView::getLaneParentsChilds(ListViewItem* item, int x, SList p, SList c) {
 
-	uint lane = x / d->m()->gm.width();
+	uint lane = x / d->m()->gm.laneWidth;
 	int t = item->getLaneType(lane);
 	if (t == EMPTY || t == -1)
 		return false;
@@ -387,8 +386,8 @@ bool ListView::filterDropEvent(QDropEven
 // ****************************** ListViewItem *****************************
 
 ListViewItem::ListViewItem(QListView* p, ListViewItem* a, Git* g, SCRef s,
-              const QPtrVector<QPixmap>& pm, bool e, unsigned long t, FileHistory* f) :
-              QListViewItem(p, a), git(g), fh(f), sha_(s), pms(pm), secs(t), isEvenLine(e) {
+              const int& w, bool e, unsigned long t, FileHistory* f) :
+              QListViewItem(p, a), git(g), fh(f), sha_(s), laneWidth(w), secs(t), isEvenLine(e) {
 
 	populated = isDiffTarget = isHighlighted = false;
 }
@@ -568,7 +567,6 @@ void ListViewItem::paintGraph(const Rev&
 			break;
 		}
 
-	int laneWidth = pms[0]->width();
 	int x1 = 0, x2;
 	for (uint i = 0; i < laneNum && x1 < width; i++, x1 = x2) {
 	        x2 = x1 + laneWidth;
@@ -743,176 +741,3 @@ const QString ListViewItem::timeDiff(uns
 }
 
 
-// ***************** GraphMetrics related methods *********************
-
-#define P_OR  pw/2, ph/2
-#define P_0   pw,   ph/2
-#define P_90  pw/2, 0
-#define P_180 0,    ph/2
-#define P_270 pw/2, ph
-
-void MainImpl::GraphMetrics::setupPixmaps(int ph) {
-
-	// set dimensions
-	int pw = 3 * ph / 4;
-	int r = ph / 4; // radius of dots
-
-	// create cross line mask
-	QPixmap cm(pw, ph);
-	cm.fill();
-	QPainter p;
-	p.begin(&cm);
-	p.setPen(QPen(Qt::black, 2));
-	p.drawLine(P_180, P_0);
-	p.end();
-	QBitmap crossMask = cm.createHeuristicMask();
-
-	QBrush myWhiteBrush(ODD_LINE_COL, Qt::SolidPattern);
-	QColor colors[COLORS_NUM] = {Qt::black, Qt::red, DARK_GREEN, Qt::blue,
-	                             Qt::darkGray, BROWN, Qt::magenta, ORANGE};
-	pixmaps.clear();
-	pixmaps.resize(LANE_TYPES_NUM * COLORS_NUM);
-
-	for (int i = 0; i < LANE_TYPES_NUM * COLORS_NUM; i++) {
-
-		int type = (i / COLORS_NUM) + 1;
-		QColor myColorNum(colors[i % COLORS_NUM]);
-		QBrush myBrush(myColorNum, Qt::SolidPattern);
-
-		QPixmap* pm = new QPixmap(pw, ph);
-		pm->fill(ODD_LINE_COL);
-		p.begin(pm);
-		p.setPen(QPen(myColorNum, 2));
-
-		switch (type) {
-		case ACTIVE:
-			p.drawLine(P_90, P_270);
-			p.save();
-			p.setPen(Qt::NoPen);
-			p.setBrush(myBrush);
-			p.drawEllipse(pw/2 - r, ph/2 - r, 2*r, 2*r);
-			p.restore();
-			break;
-		case NOT_ACTIVE:
-			p.drawLine(P_90, P_270);
-			break;
-		case MERGE_FORK:
-			p.drawLine(P_90, P_270);
-			p.drawLine(P_180, P_0);
-			p.fillRect(pw/2 - r, ph/2 - r, 2*r, 2*r, myBrush);
-			break;
-		case MERGE_FORK_R:
-			p.drawLine(P_90, P_270);
-			p.drawLine(P_180, P_OR);
-			p.fillRect(pw/2 - r, ph/2 - r, 2*r, 2*r, myBrush);
-			break;
-		case MERGE_FORK_L:
-			p.drawLine(P_90, P_270);
-			p.drawLine(P_OR, P_0);
-			p.fillRect(pw/2 - r, ph/2 - r, 2*r, 2*r, myBrush);
-			break;
-		case JOIN:
-			p.drawLine(P_90, P_270);
-			p.drawLine(P_180, P_0);
-			break;
-		case JOIN_R:
-			p.drawLine(P_90, P_270);
-			p.drawLine(P_180, P_OR);
-			break;
-		case JOIN_L:
-			p.drawLine(P_90, P_270);
-			p.drawLine(P_OR, P_0);
-			break;
-		case HEAD:
-			p.drawLine(P_OR, P_270);
-			p.drawLine(P_180, P_0);
-			break;
-		case HEAD_R:
-			p.drawLine(P_OR, P_270);
-			p.drawLine(P_180, P_OR);
-			break;
-		case HEAD_L:
-			p.drawLine(P_OR, P_270);
-			p.drawLine(P_OR, P_0);
-			break;
-		case TAIL:
-			p.drawLine(P_90, P_OR);
-			p.drawLine(P_180, P_0);
-			break;
-		case TAIL_R:
-			p.drawLine(P_90, P_OR);
-			p.drawLine(P_180, P_OR);
-			break;
-		case TAIL_L:
-			p.drawLine(P_90, P_OR);
-			p.drawLine(P_OR, P_0);
-			break;
-		case CROSS:
-			pm->setMask(crossMask);
-			pm->fill(p.pen().color());
-			break;
-		case CROSS_EMPTY:
-			p.drawLine(P_180, P_0);
-			break;
-		case INITIAL:
-			p.drawLine(P_90, P_OR);
-			p.save();
-			p.setPen(Qt::NoPen);
-			p.setBrush(QBrush(myColorNum, Qt::SolidPattern));
-			p.drawEllipse(pw/2 - r, ph/2 - r, 2*r, 2*r);
-			p.restore();
-			break;
-		case BRANCH:
-			p.drawLine(P_OR, P_270);
-			p.save();
-			p.setPen(Qt::NoPen);
-			p.setBrush(QBrush(myColorNum, Qt::SolidPattern));
-			p.drawEllipse(pw/2 - r, ph/2 - r, 2*r, 2*r);
-			p.restore();
-			break;
-		case UNAPPLIED:
-			p.save();
-			p.setPen(Qt::NoPen);
-			p.setBrush(QBrush(Qt::red, Qt::SolidPattern));
-			p.drawRect(pw/2 - r, ph/2 - 1, 2*r, 2);
-			p.restore();
-			break;
-		case APPLIED:
-			p.save();
-			p.setPen(Qt::NoPen);
-			p.setBrush(QBrush(DARK_GREEN, Qt::SolidPattern));
-			p.drawRect(pw/2 - r, ph/2 - 1, 2*r, 2);
-			p.drawRect(pw/2 - 1, ph/2 - r, 2, 2*r);
-			p.restore();
-			break;
-		case BOUNDARY:
-			p.drawLine(P_90, P_OR);
-			p.save();
-			p.setBrush(myWhiteBrush);
-			p.drawEllipse(pw/2 - r, ph/2 - r, 2*r, 2*r);
-			p.restore();
-			p.drawEllipse(pw/2 - r, ph/2 - r, 2*r, 2*r);
-			break;
-		case BOUNDARY_C:
-			p.drawLine(P_90, P_OR);
-			p.drawLine(P_180, P_0);
-			p.fillRect(pw/2 - r, ph/2 - r, 2*r, 2*r, myWhiteBrush);
-			p.drawRect(pw/2 - r, ph/2 - r, 2*r, 2*r);
-			break;
-		case BOUNDARY_R:
-			p.drawLine(P_90, P_OR);
-			p.drawLine(P_180, P_OR);
-			p.fillRect(pw/2 - r, ph/2 - r, 2*r, 2*r, myWhiteBrush);
-			p.drawRect(pw/2 - r, ph/2 - r, 2*r, 2*r);
-			break;
-		case BOUNDARY_L:
-			p.drawLine(P_90, P_OR);
-			p.drawLine(P_OR, P_0);
-			p.fillRect(pw/2 - r, ph/2 - r, 2*r, 2*r, myWhiteBrush);
-			p.drawRect(pw/2 - r, ph/2 - r, 2*r, 2*r);
-			break;
-		}
-		p.end();
-		pixmaps.insert(i, pm); // pixmaps has autoDelete set
-	}
-}
diff --git a/src/listview.h b/src/listview.h
index 7e52e9a..eafb7c2 100644
--- a/src/listview.h
+++ b/src/listview.h
@@ -20,7 +20,7 @@ class FileHistory;
 class ListViewItem: public QListViewItem {
 public:
 	ListViewItem(QListView* p, ListViewItem* a, Git* g, SCRef sha,
-		     const QPtrVector<QPixmap>& pm, bool e, unsigned long t, FileHistory* f);
+		     const int& w, bool e, unsigned long t, FileHistory* f);
 
 	SCRef sha() const { return sha_; }
 	int getLaneType(uint pos) const;
@@ -45,7 +45,7 @@ private:
 	Git* git;
 	FileHistory* fh;
 	const QString sha_;
-	const QPtrVector<QPixmap>& pms;
+	const int& laneWidth;
 	unsigned long secs;
 	bool populated, isEvenLine, isHighlighted, isDiffTarget;
 };
diff --git a/src/mainimpl.cpp b/src/mainimpl.cpp
index 0a1efb4..620b3e8 100644
--- a/src/mainimpl.cpp
+++ b/src/mainimpl.cpp
@@ -109,7 +109,6 @@ MainImpl::MainImpl(const QString& cd, QW
 	lineEditSHA->setMinimumWidth(wd);
 
 	// gm is now set to application's default font
-	gm.pixmaps.setAutoDelete(true);
 	adjustFontSize(0); // create pixmaps
 
 	connect(git, SIGNAL(newRevsAdded(const FileHistory*, const QValueVector<QString>&)),
@@ -945,7 +944,7 @@ void MainImpl::adjustFontSize(int delta)
 	int h = item->height();
 	delete item;
 
-	gm.setupPixmaps(h); // (re)create the pixmaps
+	gm.laneWidth = 3 * h / 4;
 
 	emit repaintListViews(gm.font);
 }
diff --git a/src/mainimpl.h b/src/mainimpl.h
index 0dbc38a..3446806 100644
--- a/src/mainimpl.h
+++ b/src/mainimpl.h
@@ -155,11 +155,7 @@ private:
 	int recentRepoMenuPos;
 
 	struct GraphMetrics {
-		void setupPixmaps(int height);
-		int height() const { return pixmaps[0]->height(); }
-		int width () const { return pixmaps[0]->width(); }
-
-		QPtrVector<QPixmap> pixmaps;
+	        int laneWidth;
 		QFont font;
 	};
 	GraphMetrics gm;
-- 
1.4.3.rc2.gf8ffb
