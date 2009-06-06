From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH QGit 4/4] Create a separate submenu for tags
Date: Sat,  6 Jun 2009 13:57:51 +0200
Message-ID: <1244289471-698-5-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 13:58:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCuY0-0007Qq-6d
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 13:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753695AbZFFL60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 07:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753559AbZFFL6Y
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 07:58:24 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:38029 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463AbZFFL6U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 07:58:20 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id D54E6FEEC491;
	Sat,  6 Jun 2009 13:58:21 +0200 (CEST)
Received: from [89.59.108.98] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MCuXU-0006b6-01; Sat, 06 Jun 2009 13:58:20 +0200
X-Mailer: git-send-email 1.6.3.2.213.g30b07
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/JR8ISSJa+0fmAYsO0vk4OpOnhMma6pDnO9XEi
	8aY9omEnQYnqyELgIYMvvSBPVAxh9y1KkIWNSlZrsaYcq+HmWl
	r9ne5nwYZdnoajvRqfRg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120910>

It is more logical and hierarchical correct not to begin listing tags in
the existing submenu. The remaining space of the main context menu is
halved for the branches and tags to be displayed before the submenu has
to be created.

A little downside is that now you can get 2 "More..." submenus for
branches and tags instead of only 1.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 src/mainimpl.cpp |   38 ++++++++++++++++++++++++++------------
 1 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/src/mainimpl.cpp b/src/mainimpl.cpp
index 38bbfbe..9613fac 100644
--- a/src/mainimpl.cpp
+++ b/src/mainimpl.cpp
@@ -1138,7 +1138,8 @@ static int cntMenuEntries(const QMenu& menu) {
 void MainImpl::doContexPopup(SCRef sha) {
 
 	QMenu contextMenu(this);
-	QMenu contextSubMenu("More...", this);
+	QMenu contextBrnMenu("More branches...", this);
+	QMenu contextTagMenu("More tags...", this);
 	QMenu contextRmtMenu("Remote branches", this);
 
 	connect(&contextMenu, SIGNAL(triggered(QAction*)), this, SLOT(goRef_triggered(QAction*)));
@@ -1193,35 +1194,48 @@ void MainImpl::doContexPopup(SCRef sha) {
 		if (!contextRmtMenu.isEmpty())
 			contextMenu.addMenu(&contextRmtMenu);
 
+		// halve the possible remaining entries for branches and tags
+		int remainingEntries = (MAX_MENU_ENTRIES - cntMenuEntries(contextMenu));
+		int tagEntries = remainingEntries / 2;
+		int brnEntries = remainingEntries - tagEntries;
+
+		// display more branches, if there are few tags
+		if (tagEntries > tn.count())
+			tagEntries = tn.count();
+
+		// one branch less because of the "More branches..." submenu
+		if ((bn.count() > brnEntries) && tagEntries)
+			tagEntries++;
+
 		if (!bn.empty())
 			contextMenu.addSeparator();
 
 		FOREACH_SL (it, bn) {
-			if (cntMenuEntries(contextMenu) < MAX_MENU_ENTRIES
-					|| (*it == bn.last() && contextSubMenu.isEmpty() && tn.empty()))
+			if (cntMenuEntries(contextMenu) < MAX_MENU_ENTRIES - tagEntries
+					|| (*it == bn.last() && contextBrnMenu.isEmpty()))
 				act = contextMenu.addAction(*it);
 			else
-				act = contextSubMenu.addAction(*it);
+				act = contextBrnMenu.addAction(*it);
 
 			act->setData("Ref");
 		}
+		if (!contextBrnMenu.isEmpty())
+			contextMenu.addMenu(&contextBrnMenu);
+
 		if (!tn.empty())
-			if (!contextSubMenu.isEmpty())
-				contextSubMenu.addSeparator();
-			else
-				contextMenu.addSeparator();
+			contextMenu.addSeparator();
 
 		FOREACH_SL (it, tn) {
 			if (cntMenuEntries(contextMenu) < MAX_MENU_ENTRIES
-					|| (*it == tn.last() && contextSubMenu.isEmpty()))
+					|| (*it == tn.last() && contextTagMenu.isEmpty()))
 				act = contextMenu.addAction(*it);
 			else
-				act = contextSubMenu.addAction(*it);
+				act = contextTagMenu.addAction(*it);
 
 			act->setData("Ref");
 		}
-		if (!contextSubMenu.isEmpty())
-			contextMenu.addMenu(&contextSubMenu);
+		if (!contextTagMenu.isEmpty())
+			contextMenu.addMenu(&contextTagMenu);
 	}
 	contextMenu.exec(QCursor::pos());
 }
-- 
1.6.3.2.213.g30b07
