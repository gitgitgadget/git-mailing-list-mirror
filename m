From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH qgit] Show remote branch in orange tag mark
Date: Sun, 4 Feb 2007 10:30:35 +0100
Message-ID: <e5bfff550702040130q220a86bcxc65e015b73f76733@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Pavel Roskin" <proski@gnu.org>
To: "GIT list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 04 10:30:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDdhn-00055d-J3
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 10:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178AbXBDJah (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 04:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbXBDJah
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 04:30:37 -0500
Received: from nz-out-0506.google.com ([64.233.162.238]:61189 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbXBDJag (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 04:30:36 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1327805nze
        for <git@vger.kernel.org>; Sun, 04 Feb 2007 01:30:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GJ76FGMW9R17NSaaiSLQszzQuHN/u1nIc3g0sWWIRAn9sVF5F8s6G4O1w1GMqC7iQhP6DjlD42sct7uzuOSRRzMkt9x9dbiYpv0QQjbjHb4sJsTkR2s5vfvuB1x8QVaVVZULaMiLGG3iDIWewyNNSrsCLEgXJ1qd3faTNqNJu7o=
Received: by 10.115.76.1 with SMTP id d1mr506857wal.1170581435355;
        Sun, 04 Feb 2007 01:30:35 -0800 (PST)
Received: by 10.114.61.6 with HTTP; Sun, 4 Feb 2007 01:30:35 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38670>

Teach qgit about remote branches and show them with an orange
background in tag mark indicator.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 src/git.cpp         |   12 ++++++++++++
 src/git.h           |   12 +++++++-----
 src/git_startup.cpp |    5 +++++
 src/listview.cpp    |    3 +++
 4 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/src/git.cpp b/src/git.cpp
index 33834d5..08b3309 100644
--- a/src/git.cpp
+++ b/src/git.cpp
@@ -182,6 +182,9 @@ const QStringList Git::getRefName(SCRef sha,
RefType type, QString* curBranch) c
 	else if (type == BRANCH)
 		return rf.branches;

+	else if (type == RMT_BRANCH)
+		return rf.remoteBranches;
+
 	else if (type == REF)
 		return rf.refs;

@@ -214,6 +217,9 @@ const QString Git::getRefSha(SCRef refName,
RefType type, bool askGit) {
 		else if ((any || type == BRANCH) && rf.branches.contains(refName))
 			return it.key();

+		else if ((any || type == RMT_BRANCH) && rf.remoteBranches.contains(refName))
+			return it.key();
+
 		else if ((any || type == REF) && rf.refs.contains(refName))
 			return it.key();

@@ -257,6 +263,9 @@ const QStringList Git::getAllRefNames(uint mask,
bool onlyLoaded) {
 		if (mask & BRANCH)
 			appendNamesWithId(names, it.key(), (*it).branches, onlyLoaded);

+		if (mask & RMT_BRANCH)
+			appendNamesWithId(names, it.key(), (*it).remoteBranches, onlyLoaded);
+
 		if (mask & REF)
 			appendNamesWithId(names, it.key(), (*it).refs, onlyLoaded);

@@ -283,6 +292,9 @@ const QString Git::getRevInfo(SCRef sha) {
 		const QString cap(type & CUR_BRANCH ? "Head: " : "Branch: ");
 		refsInfo =  cap + getRefName(sha, BRANCH).join(" ");
 	}
+	if (type & RMT_BRANCH)
+		refsInfo.append("   Remote branch: " + getRefName(sha,
RMT_BRANCH).join(" "));
+
 	if (type & TAG)
 		refsInfo.append("   Tag: " + getRefName(sha, TAG).join(" "));

diff --git a/src/git.h b/src/git.h
index 48f4e06..5b174ab 100644
--- a/src/git.h
+++ b/src/git.h
@@ -51,11 +51,12 @@ public:
 	enum RefType {
 		TAG        = 1,
 		BRANCH     = 2,
-		CUR_BRANCH = 4,
-		REF        = 8,
-		APPLIED    = 16,
-		UN_APPLIED = 32,
-		ANY_REF    = 63
+		RMT_BRANCH = 4,
+		CUR_BRANCH = 8,
+		REF        = 16,
+		APPLIED    = 32,
+		UN_APPLIED = 64,
+		ANY_REF    = 127
 	};

 	void checkEnvironment();
@@ -155,6 +156,7 @@ private:
 		Reference() : type(0) {}
 		uint type;
 		QStringList branches;
+		QStringList remoteBranches;
 		QString     currentBranch;
 		QStringList tags;
 		QStringList refs;
diff --git a/src/git_startup.cpp b/src/git_startup.cpp
index 6b34460..84e62a5 100644
--- a/src/git_startup.cpp
+++ b/src/git_startup.cpp
@@ -172,6 +172,11 @@ bool Git::getRefs() {
 				cur->type |= CUR_BRANCH;
 				cur->currentBranch = curBranchName;
 			}
+		} else if (refName.startsWith("refs/remotes/") &&
!refName.endsWith("HEAD")) {
+
+			cur->remoteBranches.append(refName.mid(13));
+			cur->type |= RMT_BRANCH;
+
 		} else if (!refName.endsWith("HEAD")) {

 			cur->refs.append(refName);
diff --git a/src/listview.cpp b/src/listview.cpp
index bfc2a7d..80043e9 100644
--- a/src/listview.cpp
+++ b/src/listview.cpp
@@ -635,6 +635,9 @@ void ListViewItem::paintTagMarks(int col) {
 	if (rt & Git::BRANCH)
 		addBranchPixmap(&newPm);

+	if (rt & Git::RMT_BRANCH)
+		addRefPixmap(&newPm, git->getRefName(_sha, Git::RMT_BRANCH), ORANGE);
+
 	if (rt & Git::TAG)
 		addRefPixmap(&newPm, git->getRefName(_sha, Git::TAG), Qt::yellow);

-- 
1.5.0-rc3.GIT
