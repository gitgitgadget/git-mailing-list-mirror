From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH qgit] Add 'Remote branches' context sub menu
Date: Sun, 4 Feb 2007 11:02:53 +0100
Message-ID: <e5bfff550702040202n419ce550sddb920bc2db7ea48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Pavel Roskin" <proski@gnu.org>
To: "GIT list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 04 11:02:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDeD3-0002KT-I3
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 11:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbXBDKCz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 05:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752234AbXBDKCz
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 05:02:55 -0500
Received: from nz-out-0506.google.com ([64.233.162.233]:3825 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbXBDKCy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 05:02:54 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1330966nze
        for <git@vger.kernel.org>; Sun, 04 Feb 2007 02:02:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qQCCYLS+1rwcUgQhBcQIlsM3PsSkBpnuE4ubNmiKFJ6dEySodFOovFXsT7CYfBSiHx+K2fQwzYV2A9O5bORHaXJ02CD9+Y02c/Da9SAB/naKz3YTLaDfT28DJ6i/A9h7qG2O7df5Lr2DmHgR+NtcNzivf87CycU36HwXSMIPfxM=
Received: by 10.114.173.15 with SMTP id v15mr510119wae.1170583373308;
        Sun, 04 Feb 2007 02:02:53 -0800 (PST)
Received: by 10.114.61.6 with HTTP; Sun, 4 Feb 2007 02:02:53 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38677>

It is now possible to jump to a remote branch from context (right click)
sub menu in main view.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 src/mainimpl.cpp |   22 ++++++++++++++++------
 src/mainimpl.h   |    1 +
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/src/mainimpl.cpp b/src/mainimpl.cpp
index 694dde5..ead7e0b 100644
--- a/src/mainimpl.cpp
+++ b/src/mainimpl.cpp
@@ -1054,10 +1054,13 @@ void MainImpl::doContexPopup(SCRef sha) {
 	// global scope because we use a signal/slot connection
 	delete contextMenu;
 	delete contextSubMenu;
+	delete contextRmtMenu;
 	contextMenu = new QPopupMenu(this);
 	contextSubMenu = new QPopupMenu(this);
+	contextRmtMenu = new QPopupMenu(this);
 	connect(contextMenu, SIGNAL(activated(int)), this,
SLOT(on_goRef_activated(int)));
 	connect(contextSubMenu, SIGNAL(activated(int)), this,
SLOT(on_goRef_activated(int)));
+	connect(contextRmtMenu, SIGNAL(activated(int)), this,
SLOT(on_goRef_activated(int)));

 	Domain* t;
 	int tt = currentTabType(&t);
@@ -1096,18 +1099,26 @@ void MainImpl::doContexPopup(SCRef sha) {
 			ActPop->addTo(contextMenu);

 		const QStringList& bn(git->getAllRefNames(Git::BRANCH, Git::optOnlyLoaded));
+		const QStringList& rbn(git->getAllRefNames(Git::RMT_BRANCH,
Git::optOnlyLoaded));
 		const QStringList& tn(git->getAllRefNames(Git::TAG, Git::optOnlyLoaded));
-		if (bn.empty() && tn.empty()) {
+		if (bn.empty() && rbn.empty() && tn.empty()) {
 			contextMenu->exec(QCursor::pos());
 			return;
 		}
-		int id = 1;
+		int id = 1; // ref names have id > 0 to disambiguate from actions
+		if (!rbn.empty()) {
+			QStringList::const_iterator it = rbn.constBegin();
+			for ( ; it != rbn.constEnd(); ++it, id++)
+				contextRmtMenu->insertItem(*it, id);
+		}
+		if (contextRmtMenu->count() > 0)
+			contextMenu->insertItem("Remote branches", contextRmtMenu);
+
 		if (!bn.empty()) {
 			contextMenu->insertSeparator();
 			QStringList::const_iterator it = bn.constBegin();
 			for ( ; it != bn.constEnd(); ++it, id++) {
-				// branch names have id > 0 to disambiguate them from actions,
-				// Qt assigns negative id as default
+
 				if (id < MAX_MENU_ENTRIES)
 					contextMenu->insertItem(*it, id);
 				else
@@ -1118,8 +1129,7 @@ void MainImpl::doContexPopup(SCRef sha) {
 			contextMenu->insertSeparator();
 			QStringList::const_iterator it = tn.constBegin();
 			for ( ; it != tn.constEnd(); ++it, id++) {
-				// tag names have id > 0 to disambiguate them from actions,
-				// Qt assigns negative id as default
+
 				if (id < MAX_MENU_ENTRIES)
 					contextMenu->insertItem(*it, id);
 				else
diff --git a/src/mainimpl.h b/src/mainimpl.h
index e455cb9..4be6ced 100644
--- a/src/mainimpl.h
+++ b/src/mainimpl.h
@@ -151,6 +151,7 @@ private:
 	QRegExp longLogRE;
 	QGuardedPtr<QPopupMenu> contextMenu;
 	QGuardedPtr<QPopupMenu> contextSubMenu;
+	QGuardedPtr<QPopupMenu> contextRmtMenu;
 	QString startUpDir;
 	QString textToFind;
 	QFont listViewFont;
-- 
1.5.0-rc3.GIT
