From: Jan Hudec <bulb@ucw.cz>
Subject: [Qgit PATCH] Add ability to commit --amend
Date: Thu, 20 Mar 2008 20:39:57 +0100
Message-ID: <20080320193957.GA12119@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 20:41:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcQdG-0006aY-3j
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 20:40:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002AbYCTTkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 15:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbYCTTkP
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 15:40:15 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:53919 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752510AbYCTTkM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 15:40:12 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 265DC8E98E;
	Thu, 20 Mar 2008 20:40:08 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id v1XpBpbfVbai; Thu, 20 Mar 2008 20:39:59 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id F018D7EC17;
	Thu, 20 Mar 2008 20:39:58 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1JcQcH-0003Jk-H4; Thu, 20 Mar 2008 20:39:57 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77683>

Introduces separate menu entry to commit --amend. The dialog is the same, but
calls commit --amend rather than just commit in the end. The stg refresh is
moved here. The menu entry is always available, because user might just want
to change the commit message.

Signed-off-by: Jan Hudec <bulb@ucw.cz>
---

Last summer I tried to add ability to commit --amend to qgit -- and failed
because git commit didn't support --amend and -F together and rewrite using
lower level plumbing started to get really ugly. Now that there is git 1.5.4
with builtin commit, which does not have this quirk, I resurrected the patch
and here it is.

It seems to work for me. I didn't try any particularly nasty cases, but on
the other hand I didn't change the commit logic itself, so it should not have
effect on this. Please review and apply if it looks OK.

---

I have to say I don't like one thing on it---the way if(isStGITStack())
appears all over the place. Besides there is actually a bug in the
detection of the stgit stack. A tree is considered to have stgit if any
branch has stgit stack, even if that branch is currently checked out.

So what I'd like to look into now is introducing two classes, one for plain
git core branches and one for stgit repositories. They will create the
actions that depend on repository type (so they would no longer be designed,
but QActions are quite simple, so I don't think it's critical). They will
share code as appropriate via inheritance or delegation to current Git class.
This should make the code a little more modular and make it possible if some
day someone decides to add support for guilt or other git extension.

Regards,

Jan

PS: Is this the right way to submit QGit patches, or should I be using some
other channel (like sf.net patch tracker or something)?

--->8---

 README             |    8 +++-
 src/commit.ui      |   16 -------
 src/commitimpl.cpp |  118 ++++++++++++++++++++++++++++++++++++++--------------
 src/commitimpl.h   |    9 +++-
 src/git.cpp        |   44 ++++++++++++++-----
 src/git.h          |    6 ++-
 src/mainimpl.cpp   |   23 +++++-----
 src/mainimpl.h     |    1 +
 src/mainview.ui    |   37 ++++++++++++++---
 9 files changed, 177 insertions(+), 85 deletions(-)

diff --git a/README b/README
index aa3c799..1fb221b 100644
--- a/README
+++ b/README
@@ -227,6 +227,10 @@ In commit dialog select the files to commit or, simply, to sync with index
 (call 'git update-index' on them). A proper commit message may be entered and,
 after confirmation, changes are committed and a new revision is created.
 +
+It is also possible to amend last commit. The Edit->Amend commit opens the
+same dialog, but changes are added to the head commit instead of creating new
+commit.
++
 The core commit function is performed by 'git commit'.
 +
 TIP: It is possible to use a template for commit message, use
@@ -381,8 +385,8 @@ Integration with StGIT is implemented both by new and modified functions.
 
 .Existing functions change behavior:
 
- - Commit dialog refreshes top stack patch with modified files instead
-   of sync the cache.
+ - Amend commit dialog refreshes top stack patch with modified files instead
+   of amending the commit. It is appropriately renamed in the menu.
  - Commit dialog creates a new patch on the top of the stack filled with
    modified working directory content instead of commit a new revision to
    git repository.
diff --git a/src/commit.ui b/src/commit.ui
index 253ac07..3b85187 100644
--- a/src/commit.ui
+++ b/src/commit.ui
@@ -286,22 +286,6 @@
  </resources>
  <connections>
   <connection>
-   <sender>pushButtonOk</sender>
-   <signal>clicked()</signal>
-   <receiver>CommitBase</receiver>
-   <slot>pushButtonOk_clicked()</slot>
-   <hints>
-    <hint type="sourcelabel" >
-     <x>20</x>
-     <y>20</y>
-    </hint>
-    <hint type="destinationlabel" >
-     <x>20</x>
-     <y>20</y>
-    </hint>
-   </hints>
-  </connection>
-  <connection>
    <sender>pushButtonCancel</sender>
    <signal>clicked()</signal>
    <receiver>CommitBase</receiver>
diff --git a/src/commitimpl.cpp b/src/commitimpl.cpp
index f628c70..a6612b8 100644
--- a/src/commitimpl.cpp
+++ b/src/commitimpl.cpp
@@ -22,7 +22,7 @@
 
 using namespace QGit;
 
-CommitImpl::CommitImpl(Git* g) : git(g) {
+CommitImpl::CommitImpl(Git* g, bool amend) : git(g) {
 
 	// adjust GUI
 	setAttribute(Qt::WA_DeleteOnClose);
@@ -77,8 +77,8 @@ CommitImpl::CommitImpl(Git* g) : git(g) {
 	textEditMsg_cursorPositionChanged();
 
 	// setup textEditMsg with default value
-	QString status(git->getDefCommitMsg());
-	status.prepend('\n').replace(QRegExp("\\n([^#])"), "\n#\\1"); // comment all the lines
+	QString status;
+	status = amend ? git->getLastCommitMsg() : git->getNewCommitMsg();
 	msg.append(status.trimmed());
 	textEditMsg->setPlainText(msg);
 
@@ -87,13 +87,26 @@ CommitImpl::CommitImpl(Git* g) : git(g) {
 	origMsg = msg;
 
 	// setup button functions
-	if (git->isStGITStack()) {
-		pushButtonOk->setText("&New patch");
-		pushButtonOk->setShortcut(QKeySequence("Alt+N"));
-		pushButtonOk->setToolTip("Create a new patch");
-		pushButtonUpdateCache->setText("&Add to top");
-		pushButtonOk->setShortcut(QKeySequence("Alt+A"));
-		pushButtonUpdateCache->setToolTip("Refresh top stack patch");
+	if (amend) {
+		if (git->isStGITStack()) {
+			pushButtonOk->setText("&Add to top");
+			pushButtonOk->setShortcut(QKeySequence("Alt+A"));
+			pushButtonOk->setToolTip("Refresh top stack patch");
+		} else {
+			pushButtonOk->setText("&Amend");
+			pushButtonOk->setShortcut(QKeySequence("Alt+A"));
+			pushButtonOk->setToolTip("Amend latest commit");
+		}
+		connect(pushButtonOk, SIGNAL(clicked()),
+			this, SLOT(pushButtonAmend_clicked()));
+	} else {
+		if (git->isStGITStack()) {
+			pushButtonOk->setText("&New patch");
+			pushButtonOk->setShortcut(QKeySequence("Alt+N"));
+			pushButtonOk->setToolTip("Create a new patch");
+		}
+		connect(pushButtonOk, SIGNAL(clicked()),
+			this, SLOT(pushButtonCommit_clicked()));
 	}
 	connect(treeWidgetFiles, SIGNAL(customContextMenuRequested(const QPoint&)),
 	        this, SLOT(contextMenuPopup(const QPoint&)));
@@ -129,7 +142,7 @@ void CommitImpl::checkUncheck(bool checkAll) {
 	}
 }
 
-bool CommitImpl::checkFiles(SList selFiles) {
+bool CommitImpl::getFiles(SList selFiles) {
 
 	// check for files to commit
 	selFiles.clear();
@@ -139,13 +152,26 @@ bool CommitImpl::checkFiles(SList selFiles) {
 			selFiles.append((*it)->text(0));
 		++it;
 	}
-	if (selFiles.isEmpty())
-		QMessageBox::warning(this, "Commit changes - QGit",
-		                     "Sorry, no files are selected for updating.",
-		                     QMessageBox::Ok, QMessageBox::NoButton);
+
 	return !selFiles.isEmpty();
 }
 
+void CommitImpl::warnNoFiles() {
+
+	QMessageBox::warning(this, "Commit changes - QGit",
+			     "Sorry, no files are selected for updating.",
+			     QMessageBox::Ok, QMessageBox::NoButton);
+}
+
+bool CommitImpl::checkFiles(SList selFiles) {
+
+	if (getFiles(selFiles))
+		return true;
+
+	warnNoFiles();
+	return false;
+}
+
 bool CommitImpl::checkMsg(QString& msg) {
 
 	msg = textEditMsg->toPlainText();
@@ -189,12 +215,16 @@ bool CommitImpl::checkPatchName(QString& patchName) {
 	return false;
 }
 
-bool CommitImpl::checkConfirm(SCRef msg, SCRef patchName, SCList selFiles) {
+bool CommitImpl::checkConfirm(SCRef msg, SCRef patchName, SCList selFiles, bool amend) {
 
 	QTextCodec* tc = QTextCodec::codecForCStrings();
 	QTextCodec::setCodecForCStrings(0); // set temporary Latin-1
 
-	QString whatToDo = (git->isStGITStack() ? "create a new patch with" : "commit");
+	// NOTEME: i18n-ugly
+	QString whatToDo = amend ? 
+	    (git->isStGITStack() ? "refresh top patch with" :
+	     			   "amend last commit with") :
+	    (git->isStGITStack() ? "create a new patch with" : "commit");
 	QString text("Do you want to " + whatToDo + " the following file(s)?\n\n" +
 	             selFiles.join("\n") + "\n\nwith the message:\n\n");
 	text.append(msg);
@@ -219,7 +249,7 @@ void CommitImpl::pushButtonCancel_clicked() {
 	close();
 }
 
-void CommitImpl::pushButtonOk_clicked() {
+void CommitImpl::pushButtonCommit_clicked() {
 
 	QStringList selFiles; // retrieve selected files
 	if (!checkFiles(selFiles))
@@ -233,7 +263,8 @@ void CommitImpl::pushButtonOk_clicked() {
 	if (git->isStGITStack() && !checkPatchName(patchName))
 		return;
 
-	if (!checkConfirm(msg, patchName, selFiles)) // ask for confirmation
+	// ask for confirmation
+	if (!checkConfirm(msg, patchName, selFiles, !Git::optAmend))
 		return;
 
 	// ok, let's go
@@ -243,7 +274,7 @@ void CommitImpl::pushButtonOk_clicked() {
 	if (git->isStGITStack())
 		ok = git->stgCommit(selFiles, msg, patchName, !Git::optFold);
 	else
-		ok = git->commitFiles(selFiles, msg);
+		ok = git->commitFiles(selFiles, msg, !Git::optAmend);
 
 	QApplication::restoreOverrideCursor();
 	hide();
@@ -251,29 +282,52 @@ void CommitImpl::pushButtonOk_clicked() {
 	close();
 }
 
-void CommitImpl::pushButtonUpdateCache_clicked() {
+void CommitImpl::pushButtonAmend_clicked() {
 
-	QStringList selFiles;
-	if (!checkFiles(selFiles))
+	QStringList selFiles; // retrieve selected files
+	getFiles(selFiles);
+	// FIXME: If there are no files AND no changes to message, we should not
+	// commit. Disabling the commit button in such case might be preferable.
+
+	QString msg(textEditMsg->toPlainText());
+	if (msg == origMsg && selFiles.isEmpty()) {
+		warnNoFiles();
 		return;
+	}
 
-	if (git->isStGITStack())
-		if (QMessageBox::question(this, "Refresh stack - QGit",
-			"Do you want to refresh current top stack patch?",
-			"&Yes", "&No", QString(), 0, 1) == 1)
-			return;
+	if (msg == origMsg && git->isStGITStack())
+		msg = "";
+	else if (!checkMsg(msg))
+		// We are going to replace the message, so it better isn't empty
+		return;
 
-	QString msg(textEditMsg->toPlainText());
-	if (msg == origMsg)
-		msg = ""; // to tell stgCommit() not to refresh patch name
+	// ask for confirmation
+	// FIXME: We don't need patch name for refresh, do we?
+	if (!checkConfirm(msg, "", selFiles, Git::optAmend))
+		return;
 
+	// ok, let's go
 	QApplication::setOverrideCursor(QCursor(Qt::WaitCursor));
 	EM_PROCESS_EVENTS; // to close message box
 	bool ok;
 	if (git->isStGITStack())
 		ok = git->stgCommit(selFiles, msg, "", Git::optFold);
 	else
-		ok = git->updateIndex(selFiles);
+		ok = git->commitFiles(selFiles, msg, Git::optAmend);
+
+	QApplication::restoreOverrideCursor();
+	hide();
+	emit changesCommitted(ok);
+	close();
+}
+
+void CommitImpl::pushButtonUpdateCache_clicked() {
+
+	QStringList selFiles;
+	if (!checkFiles(selFiles))
+		return;
+
+	bool ok = git->updateIndex(selFiles);
 
 	QApplication::restoreOverrideCursor();
 	emit changesCommitted(ok);
diff --git a/src/commitimpl.h b/src/commitimpl.h
index 19cb156..d9e9649 100644
--- a/src/commitimpl.h
+++ b/src/commitimpl.h
@@ -15,14 +15,15 @@ class Git;
 class CommitImpl : public QWidget, public Ui_CommitBase {
 Q_OBJECT
 public:
-	explicit CommitImpl(Git* git);
+	explicit CommitImpl(Git* g, bool amend);
 
 signals:
 	void changesCommitted(bool);
 
 public slots:
 	virtual void closeEvent(QCloseEvent*);
-	void pushButtonOk_clicked();
+	void pushButtonCommit_clicked();
+	void pushButtonAmend_clicked();
 	void pushButtonCancel_clicked();
 	void pushButtonUpdateCache_clicked();
 	void pushButtonSettings_clicked();
@@ -35,10 +36,12 @@ private slots:
 
 private:
 	void checkUncheck(bool checkAll);
+	bool getFiles(SList selFiles);
+	void warnNoFiles();
 	bool checkFiles(SList selFiles);
 	bool checkMsg(QString& msg);
 	bool checkPatchName(QString& patchName);
-	bool checkConfirm(SCRef msg, SCRef patchName, SCList selFiles);
+	bool checkConfirm(SCRef msg, SCRef patchName, SCList selFiles, bool amend);
 	void computePosition(int &col_pos, int &line_pos);
 
 	Git* git;
diff --git a/src/git.cpp b/src/git.cpp
index f6df035..7fc4164 100755
--- a/src/git.cpp
+++ b/src/git.cpp
@@ -1135,23 +1135,40 @@ const QStringList Git::getNearTags(bool goDown, SCRef sha) {
 	return tl;
 }
 
-const QString Git::getDefCommitMsg() {
-
-	QString sha(ZERO_SHA);
-	if (isStGIT && !getAllRefSha(APPLIED).isEmpty()) {
-		QString top;
-		if (run("stg top", &top))
-			sha = getRefSha(top.trimmed(), APPLIED, false);
+const QString Git::getLastCommitMsg() {
+
+	// FIXME: Make sure the amend action is not called when there is
+	// nothing to amend. That is in empty repository or over stgit stack
+	// with nothing applied.
+	QString sha;
+	QString top;
+	if (run("git rev-parse --verify HEAD", &top))
+	    sha = top.trimmed();
+	else {
+		dbs("ASSERT: getLastCommitMsg head is not valid");
+		return "";
 	}
+	
 	const Rev* c = revLookup(sha);
 	if (!c) {
-		dbp("ASSERT: getDefCommitMsg sha <%1> not found", sha);
+		dbp("ASSERT: getLastCommitMsg sha <%1> not found", sha);
 		return "";
 	}
-	if (sha == ZERO_SHA)
-		return c->longLog();
 
-	return c->shortLog() + '\n' + c->longLog().trimmed();
+	return c->shortLog() + '\n' + c->longLog().trimmed() + getNewCommitMsg();
+}
+
+const QString Git::getNewCommitMsg() {
+
+	const Rev* c = revLookup(ZERO_SHA);
+	if (!c) {
+		dbs("ASSERT: getNewCommitMsg zero_sha not found");
+		return "";
+	}
+
+	QString status = c->longLog();
+	status.prepend('\n').replace(QRegExp("\\n([^#])"), "\n#\\1"); // comment all the lines
+	return status;
 }
 
 const QString Git::colorMatch(SCRef txt, QRegExp& regExp) {
@@ -1545,7 +1562,7 @@ bool Git::updateIndex(SCList selFiles) {
 	return true;
 }
 
-bool Git::commitFiles(SCList selFiles, SCRef msg) {
+bool Git::commitFiles(SCList selFiles, SCRef msg, bool amend) {
 
 	const QString msgFile(gitDir + "/qgit_cmt_msg.txt");
 	if (!writeToFile(msgFile, msg)) // early skip
@@ -1565,6 +1582,9 @@ bool Git::commitFiles(SCList selFiles, SCRef msg) {
 	if (testFlag(VERIFY_CMT_F))
 		cmtOptions.append(" -v");
 
+	if (amend)
+		cmtOptions.append(" --amend");
+
 	bool ret = false;
 
 	// get not selected files but updated in index to restore at the end
diff --git a/src/git.h b/src/git.h
index e795cee..d1c8b72 100644
--- a/src/git.h
+++ b/src/git.h
@@ -105,6 +105,7 @@ public:
 	static const bool optOnlyLoaded  = true;
 	static const bool optDragDrop    = true;
 	static const bool optFold        = true;
+	static const bool optAmend       = true;
 	static const bool optOnlyInIndex = true;
 	static const bool optCreate      = true;
 
@@ -165,7 +166,8 @@ public:
 	bool getTree(SCRef ts, TreeInfo& ti, bool wd, SCRef treePath);
 	static const QString getLocalDate(SCRef gitDate);
 	const QString getDesc(SCRef sha, QRegExp& slogRE, QRegExp& lLogRE, bool showH, FileHistory* fh);
-	const QString getDefCommitMsg();
+	const QString getLastCommitMsg();
+	const QString getNewCommitMsg();
 	const QString getLaneParent(SCRef fromSHA, int laneNum);
 	const QStringList getChilds(SCRef parent);
 	const QStringList getNearTags(bool goDown, SCRef sha);
@@ -185,7 +187,7 @@ public:
 	QTextCodec* getTextCodec(bool* isGitArchive);
 	bool formatPatch(SCList shaList, SCRef dirPath, SCRef remoteDir = "");
 	bool updateIndex(SCList selFiles);
-	bool commitFiles(SCList files, SCRef msg);
+	bool commitFiles(SCList files, SCRef msg, bool amend);
 	bool makeTag(SCRef sha, SCRef tag, SCRef msg);
 	bool deleteTag(SCRef sha);
 	bool applyPatchFile(SCRef patchPath, bool fold, bool sign);
diff --git a/src/mainimpl.cpp b/src/mainimpl.cpp
index 1edb9e6..b3439d2 100644
--- a/src/mainimpl.cpp
+++ b/src/mainimpl.cpp
@@ -1024,17 +1024,8 @@ void MainImpl::fileNamesLoad(int status, int value) {
 
 void MainImpl::updateCommitMenu(bool isStGITStack) {
 
-	QAction* act = NULL;
-	QList<QAction*> al(Edit->actions());
-	FOREACH (QList<QAction*>, it, al) {
-		SCRef txt = (*it)->text();
-		if (txt == "&Commit..." || txt == "Commit St&GIT patch...") {
-			act = *it;
-			break;
-		}
-	}
-	if (act)
-		act->setText(isStGITStack ? "Commit St&GIT patch..." : "&Commit...");
+	ActCommit->setText(isStGITStack ? "Commit St&GIT patch..." : "&Commit...");
+	ActAmend->setText(isStGITStack ? "Refresh St&GIT patch..." : "&Amend commit...");
 }
 
 void MainImpl::updateRecentRepoMenu(SCRef newEntry) {
@@ -1506,7 +1497,15 @@ void MainImpl::customAction_exited(const QString& name) {
 
 void MainImpl::ActCommit_activated() {
 
-	CommitImpl* c = new CommitImpl(git); // has Qt::WA_DeleteOnClose attribute
+	CommitImpl* c = new CommitImpl(git, false); // has Qt::WA_DeleteOnClose attribute
+	connect(this, SIGNAL(closeAllWindows()), c, SLOT(close()));
+	connect(c, SIGNAL(changesCommitted(bool)), this, SLOT(changesCommitted(bool)));
+	c->show();
+}
+
+void MainImpl::ActAmend_activated() {
+
+	CommitImpl* c = new CommitImpl(git, true); // has Qt::WA_DeleteOnClose attribute
 	connect(this, SIGNAL(closeAllWindows()), c, SLOT(close()));
 	connect(c, SIGNAL(changesCommitted(bool)), this, SLOT(changesCommitted(bool)));
 	c->show();
diff --git a/src/mainimpl.h b/src/mainimpl.h
index fd682ec..dd28f23 100644
--- a/src/mainimpl.h
+++ b/src/mainimpl.h
@@ -101,6 +101,7 @@ protected slots:
 	void ActMailApplyPatch_activated();
 	void ActSettings_activated();
 	void ActCommit_activated();
+	void ActAmend_activated();
 	void ActTag_activated();
 	void ActTagDelete_activated();
 	void ActPush_activated();
diff --git a/src/mainview.ui b/src/mainview.ui
index ffa8fe1..93f1d0b 100644
--- a/src/mainview.ui
+++ b/src/mainview.ui
@@ -133,17 +133,12 @@
     <addaction name="ActExit" />
     <addaction name="separator" />
    </widget>
-   <widget class="QMenu" name="Actions" >
-    <property name="title" >
-     <string>&amp;Actions</string>
-    </property>
-    <addaction name="ActCustomActionSetup" />
-   </widget>
    <widget class="QMenu" name="Edit" >
     <property name="title" >
      <string>&amp;Edit</string>
     </property>
     <addaction name="ActCommit" />
+    <addaction name="ActAmend" />
     <addaction name="ActTag" />
     <addaction name="ActTagDelete" />
     <addaction name="ActPush" />
@@ -154,6 +149,12 @@
     <addaction name="separator" />
     <addaction name="ActSettings" />
    </widget>
+   <widget class="QMenu" name="Actions" >
+    <property name="title" >
+     <string>&amp;Actions</string>
+    </property>
+    <addaction name="ActCustomActionSetup" />
+   </widget>
    <widget class="QMenu" name="View" >
     <property name="title" >
      <string>&amp;View</string>
@@ -721,6 +722,14 @@
     <string>Show 'Select range' dialog</string>
    </property>
   </action>
+  <action name="ActAmend" >
+   <property name="text" >
+    <string>Amend comit...</string>
+   </property>
+   <property name="toolTip" >
+    <string>Amend previous comit</string>
+   </property>
+  </action>
  </widget>
  <layoutdefault spacing="6" margin="11" />
  <customwidgets>
@@ -1326,5 +1335,21 @@
     </hint>
    </hints>
   </connection>
+  <connection>
+   <sender>ActAmend</sender>
+   <signal>triggered()</signal>
+   <receiver>MainBase</receiver>
+   <slot>ActAmend_activated()</slot>
+   <hints>
+    <hint type="sourcelabel" >
+     <x>-1</x>
+     <y>-1</y>
+    </hint>
+    <hint type="destinationlabel" >
+     <x>452</x>
+     <y>238</y>
+    </hint>
+   </hints>
+  </connection>
  </connections>
 </ui>
-- 
1.5.4.4
