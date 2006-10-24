From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH qgit] Change also tag marks when changing graph size
Date: Tue, 24 Oct 2006 18:47:38 +0200
Message-ID: <e5bfff550610240947i30bc3fc0x49710e4cbb0f0556@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 24 18:52:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcPUU-0008JT-V5
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 18:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161106AbWJXQu6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 12:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030435AbWJXQu6
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 12:50:58 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:58263 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030431AbWJXQu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 12:50:57 -0400
Received: by py-out-1112.google.com with SMTP id z74so96392pyg
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 09:50:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AV9Pz/cTJqpwUGQ1v1C9bSeXJXyv/StlDZPS+GdlC04V7lZcCdI7BCqJCTPisDs9iFTtxKwnUlCeha3W0pFSyJju/Kv+dsxI/+KzTt1OwaunWjiLv9/e5PxA7GGiZpx18gmC27xJlH2DCBEQ5E+2SLF1vIsrB+gxgvIYTtp57Eo=
Received: by 10.35.113.12 with SMTP id q12mr9194660pym;
        Tue, 24 Oct 2006 09:47:39 -0700 (PDT)
Received: by 10.35.42.4 with HTTP; Tue, 24 Oct 2006 09:47:38 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29988>

When changing graph size with CTRL+ and CTRL-
update also tag/branch marks.

Also little cleanup.
---

Hi Josef,

  please tell me if you are working on the same files, in this case I
will step back and wait you to finish your patch series and eventually
resubmit this one at the end.

   Marco


  src/listview.cpp |  116 ++++++++++++++++++++++++++++-------------------------
  src/listview.h   |   11 ++---
 2 files changed, 66 insertions(+), 61 deletions(-)

diff --git a/src/listview.cpp b/src/listview.cpp
index 7251b97..1e33ac0 100644
--- a/src/listview.cpp
+++ b/src/listview.cpp
@@ -224,8 +224,7 @@ void ListView::on_newRevsAdded(const Fil

  	for (uint i = lv->childCount(); i < shaVec.count(); i++) {
  		lastItem = new ListViewItem(lv, lastItem, git, shaVec[i],
-		                            d->m()->gm.laneWidth,
-					    evenLine, secs, fh);
+		                            d->m()->gm.laneWidth, evenLine, secs, fh);
  		evenLine = !evenLine;
 	}
 }
@@ -539,24 +538,23 @@ #undef R_CENTER

 }

-
  void ListViewItem::paintGraph(const Rev& c, QPainter* p,
-			      const QColorGroup& cg, int width) {
+                              const QColorGroup& cg, int width) {

-        static QColor colors[COLORS_NUM] = {Qt::black, Qt::red, DARK_GREEN,
-					    Qt::blue,  Qt::darkGray, BROWN,
-					    Qt::magenta, ORANGE};
+	static QColor colors[COLORS_NUM] = { Qt::black, Qt::red, DARK_GREEN,
+	                                     Qt::blue,  Qt::darkGray, BROWN,
+	                                     Qt::magenta, ORANGE };

  	QListView* lv = listView();
  	if (!lv)
 		return;

  	QColorGroup::ColorRole crole = QColorGroup::Base;
-	if ( isSelected() && lv->allColumnsShowFocus() )
-	    crole = QColorGroup::Highlight;
+	if (isSelected() && lv->allColumnsShowFocus())
+		crole = QColorGroup::Highlight;

-	QBrush back = cg.brush( crole );
-	p->fillRect( 0, 0, width, height(), back );
+	QBrush back = cg.brush(crole);
+	p->fillRect(0, 0, width, height(), back);

  	const QValueVector<int>& lanes(c.lanes);
  	uint laneNum = lanes.count();
@@ -567,27 +565,24 @@ void ListViewItem::paintGraph(const Rev&
 			break;
 		}

-	int x1 = 0, x2;
-	for (uint i = 0; i < laneNum && x1 < width; i++, x1 = x2) {
-	        x2 = x1 + laneWidth;
+	int x1 = 0, x2 = 0;
+	for (uint i = 0; i < laneNum && x1 < width; i++) {
+
+		x1 = x2;
+		x2 += laneWidth;

 		int ln = lanes[i];
 		if (ln == EMPTY)
-		    continue;
-
-		int type = ln;
-		if (ln == CROSS)
-		    type = NOT_ACTIVE;
+			continue;

 		int col = (   isHead(ln) || isTail(ln) || isJoin(ln)
-			      || ln == CROSS_EMPTY) ? mergeLane : i;
-
-		paintGraphLane(p, type, x1, x2,
-			       colors[col % COLORS_NUM], back);
+		           || ln == CROSS_EMPTY) ? mergeLane : i;

-		if (ln == CROSS)
-		    paintGraphLane(p, CROSS, x1, x2,
-				   colors[mergeLane % COLORS_NUM], back);
+		if (ln == CROSS) {
+			paintGraphLane(p, NOT_ACTIVE, x1, x2, colors[col % COLORS_NUM], back);
+			paintGraphLane(p, CROSS, x1, x2, colors[mergeLane % COLORS_NUM], back);
+		} else
+			paintGraphLane(p, ln, x1, x2, colors[col % COLORS_NUM], back);
 	}
 }

@@ -601,7 +596,7 @@ void ListViewItem::paintCell(QPainter* p
  		setupData(c);

 	if (column == GRAPH_COL) {
-	        paintGraph(c, p, _cg, width);
+		paintGraph(c, p, _cg, width);
 		return;
 	}

@@ -615,6 +610,8 @@ void ListViewItem::paintCell(QPainter* p
 	// tags, heads, refs and working dir colouring
 	if (mycolumn == LOG_COL) {

+		paintTagMarks(column, c);
+
 		if (isHighlighted) {
  			QFont f(p->font());
  			f.setBold(true);
@@ -638,37 +635,56 @@ void ListViewItem::paintCell(QPainter* p
 		p->restore();
 }

-void ListViewItem::addTextPixmap(SCRef text, const QColor& color, bool bold) {
+void ListViewItem::paintTagMarks(int col, const Rev& c) {

-	int col = LOG_COL + (fh ? 0 : -1);
-	QStringList sl = QStringList::split('\n', text);
-	loopList(it, sl) {
-		QPixmap* pm = doAddTextPixmap(*it, color, col, bold);
-		setPixmap(col, *pm);
-		delete pm;
+	if (!pixmap(col) && !c.isBranch && !c.isCurrentBranch && !c.isTag && !c.isRef)
+		return; // common case
+
+	QPixmap* newPm = new QPixmap();
+
+	if (c.isBranch || c.isCurrentBranch) {
+		QColor color(c.isCurrentBranch ? Qt::green : DARK_GREEN);
+		addTextPixmap(&newPm, c.branch, color, c.isCurrentBranch);
 	}
+	if (c.isTag)
+		addTextPixmap(&newPm, c.tag, Qt::yellow);
+
+	if (c.isRef)
+		addTextPixmap(&newPm, c.ref, PURPLE);
+
+	if (!pixmap(col) || (newPm->rect() != pixmap(col)->rect()))
+		setPixmap(col, *newPm);
+
+	delete newPm;
+}
+
+void ListViewItem::addTextPixmap(QPixmap** pp, SCRef text, const
QColor& color, bool bold) {
+
+	QStringList sl = QStringList::split('\n', text);
+	loopList(it, sl)
+		doAddTextPixmap(pp, *it, color, bold);
 }

-QPixmap* ListViewItem::doAddTextPixmap(SCRef text, const QColor&
color, int col, bool bold) {
+void ListViewItem::doAddTextPixmap(QPixmap** pp, SCRef text, const
QColor& color, bool bold) {

-	const QPixmap* oldPm = pixmap(col);
  	QFont fnt(listView()->font());
 	if (bold)
  		fnt.setBold(true);

  	QFontMetrics fm(fnt);
+	QPixmap* pm = *pp;
+	int ofs = pm->isNull() ? 0 : pm->width() + 2;
 	int spacing = 2;
  	int pw = fm.boundingRect(text).width() + 2 * (spacing + int(bold));
  	int ph = fm.height() + 1;
-	int ofs = oldPm ? oldPm->width() + 2 : 0;

-	QPixmap* pm = new QPixmap(ofs + pw, ph);
+	QPixmap* newPm = new QPixmap(ofs + pw, ph);

  	QPainter p;
-	p.begin(pm);
-	if (oldPm) {
-		pm->fill(isEvenLine ? EVEN_LINE_COL : ODD_LINE_COL);
-		p.drawPixmap(0, 0, *oldPm);
+	p.begin(newPm);
+	if (!pm->isNull()) {
+		newPm->fill(isEvenLine ? EVEN_LINE_COL : ODD_LINE_COL);
+		p.drawPixmap(0, 0, *pm);
 	}
  	p.setPen(Qt::black);
  	p.setBrush(color);
@@ -676,7 +692,9 @@ QPixmap* ListViewItem::doAddTextPixmap(S
  	p.drawRect(ofs, 0, pw, ph);
  	p.drawText(ofs + spacing, fm.ascent(), text);
 	p.end();
-	return pm;
+
+	delete pm;
+	*pp = newPm;
 }

  bool ListViewItem::changedFiles(SCRef c) {
@@ -708,16 +726,6 @@ void ListViewItem::setupData(const Rev&
 	}
  	setText(LOG_COL + adj, c.shortLog());
  	setText(AUTH_COL + adj, c.author());
-
-	if (c.isBranch || c.isCurrentBranch) {
-		QColor color(c.isCurrentBranch ? Qt::green : DARK_GREEN);
-		addTextPixmap(c.branch, color, c.isCurrentBranch);
-	}
-	if (c.isTag)
-		addTextPixmap(c.tag, Qt::yellow);
-
-	if (c.isRef)
-		addTextPixmap(c.ref, PURPLE);
 }

  const QString ListViewItem::timeDiff(unsigned long secs) const {
@@ -739,5 +747,3 @@ const QString ListViewItem::timeDiff(uns
  	tmp.append(QString::number(sec) + "s");
  	return tmp;
 }
-
-
diff --git a/src/listview.h b/src/listview.h
index eafb7c2..b1f1011 100644
--- a/src/listview.h
+++ b/src/listview.h
@@ -33,12 +33,11 @@ public:

 private:
  	void setupData(const Rev& c);
-	void paintGraphLane(QPainter* p, int type, int x1, int x2,
-			    const QColor& col, const QBrush& back);
-	void paintGraph(const Rev& c, QPainter *p,
-			const QColorGroup& cg, int width);
-	void addTextPixmap(SCRef text, const QColor& color, bool bold = false);
-	QPixmap* doAddTextPixmap(SCRef text, const QColor& color, int col, bool bold);
+	void paintGraphLane(QPainter* p, int t, int x1, int x2, const
QColor& c, const QBrush& b);
+	void paintGraph(const Rev& c, QPainter *p, const QColorGroup& cg, int width);
+	void paintTagMarks(int col, const Rev& c);
+	void addTextPixmap(QPixmap** pp, SCRef text, const QColor& color,
bool bold = false);
+	void doAddTextPixmap(QPixmap** pp, SCRef text, const QColor& color,
bool bold);
 	const QString timeDiff(unsigned long secs) const;
 	bool changedFiles(SCRef c);

-- 
1.4.3.GIT
