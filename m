From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH qgit] Add support for --early-output option of git log command
Date: Sun, 4 Nov 2007 11:25:41 +0100
Message-ID: <e5bfff550711040225ne67c907r2023b1354c35f35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 11:26:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iocg4-0000dY-Nt
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 11:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122AbXKDKZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 05:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755059AbXKDKZo
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 05:25:44 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:23079 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658AbXKDKZm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 05:25:42 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1229747rvb
        for <git@vger.kernel.org>; Sun, 04 Nov 2007 02:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=RALmvTFvwXJPbB7cq8SggTNtPzLEfDwKmM9twbCZWeI=;
        b=L35DLlzscD94MHLRBlkBBnUCJLBqMvzA/eVY3kpolpZGXgZms+2VQsG+1rd3B2VsfJa+4Pj6vtSzL2YV/Yqm7DlDGVWHyYISwxciGnn+P/fMAmOnRRPGmMFHEVzkFiFbRh19r2Oyeii1j4pt/El2pcK1b9aOFChzB/zdykHcB0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tidreD3HzYERCb4panEi4CMiRJFXUNUGcAOeW9Dv4wUmyYC8VTHUakVNFhDxOXF6595KajU0AFUNHBXTWoE6d+ITfwQKBImBqLvGS6FXK/X0w9Ri8kzA5YjQZpEtsubnDGtwCR4eN8dIPFdaOuwx7BmOcrzSOMhf3WxF3EDqQFg=
Received: by 10.141.19.16 with SMTP id w16mr1792111rvi.1194171941530;
        Sun, 04 Nov 2007 02:25:41 -0800 (PST)
Received: by 10.141.203.3 with HTTP; Sun, 4 Nov 2007 02:25:41 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63375>

With this option 'git log' outputs the first commits
as soon as they are ready in order to be able to show at
least something quickly, even if the full output may take
longer to generate.

At the end of the reordering correct revisions are re-sent.

This avoid the user to wait in front a blank screen for
several seconds in case of big repos and cold chaches.

STGit repositories are still not correctly handled, and
file history (annotation) does not uses, still, this new
--early-output feature.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---

Patch to apply on top of current qgit-2.0 at

git://git.kernel.org/pub/scm/qgit/qgit4.git


 src/common.h        |    2 +-
 src/git.cpp         |   12 ++++++++----
 src/git.h           |    3 ++-
 src/git_startup.cpp |   39 +++++++++++++++----
 4 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/src/common.h b/src/common.h
index 198348e..de3cb7d 100644
--- a/src/common.h
+++ b/src/common.h
@@ -289,7 +289,7 @@ namespace QGit {
 class Rev {
 	// prevent implicit C++ compiler defaults
 	Rev();
-	Rev(const Rev&);
+// 	Rev(const Rev&);
 	Rev& operator=(const Rev&);
 public:
 	Rev(const QByteArray& b, uint s, int idx, int* next, bool withDiff)
diff --git a/src/git.cpp b/src/git.cpp
index d273c60..ef9b627 100644
--- a/src/git.cpp
+++ b/src/git.cpp
@@ -73,9 +73,11 @@ const QString FileHistory::sha(int row) const {
 	return (row < 0 || row >= _rowCnt ? "" : revOrder.at(row));
 }

-void FileHistory::clear() {
+void FileHistory::clear(bool earlyOutput) {
+
+	if (!earlyOutput)
+		git->cancelDataLoading(this);

-	git->cancelDataLoading(this);
 	qDeleteAll(revs);
 	revs.clear();
 	revOrder.clear();
@@ -83,9 +85,11 @@ void FileHistory::clear() {
 	lns->clear();
 	fNames.clear();
 	curFNames.clear();
-	qDeleteAll(rowData);
-	rowData.clear();

+	if (!earlyOutput) {
+		qDeleteAll(rowData);
+		rowData.clear();
+	}
 	if (testFlag(REL_DATE_F)) {
 		_secs = QDateTime::currentDateTime().toTime_t();
 		_headerInfo[4] = "Last Change";
diff --git a/src/git.h b/src/git.h
index de014e0..92879fb 100644
--- a/src/git.h
+++ b/src/git.h
@@ -27,7 +27,7 @@ Q_OBJECT
 public:
 	FileHistory(QObject* parent, Git* git);
 	~FileHistory();
-	void clear();
+	void clear(bool earlyOutput = false);
 	const QString sha(int row) const;
 	int row(SCRef sha) const;
 	const QStringList fileNames() const { return fNames; }
@@ -251,6 +251,7 @@ private:
 	bool startParseProc(SCList initCmd, FileHistory* fh, SCRef buf);
 	bool tryFollowRenames(FileHistory* fh);
 	bool populateRenamedPatches(SCRef sha, SCList nn, FileHistory* fh,
QStringList* on, bool bt);
+	void doEarlyOutput(Rev* rev, int* start);
 	int addChunk(FileHistory* fh, const QByteArray& ba, int ofs);
 	void parseDiffFormat(RevFile& rf, SCRef buf);
 	void parseDiffFormatLine(RevFile& rf, SCRef line, int parNum);
diff --git a/src/git_startup.cpp b/src/git_startup.cpp
index 3faa059..df272fc 100644
--- a/src/git_startup.cpp
+++ b/src/git_startup.cpp
@@ -492,7 +492,9 @@ bool Git::startRevList(SCList args, FileHistory* fh) {
 	   the file deletion revision.
 	*/
 		initCmd << QString("-r -m -p --full-index").split(' ');
-	}
+	} else
+		initCmd << QString("--early-output");
+
 	return startParseProc(initCmd + args, fh, QString());
 }

@@ -839,13 +841,38 @@ void Git::loadFileNames() {
 	indexTree();
 }

+void Git::doEarlyOutput(Rev* rev, int* start) {
+
+	delete rev;
+	*start += QString("Final output:\n").length();
+
+	Rev* cl = NULL;
+	const Rev* r = revLookup(ZERO_SHA);
+	if (r)
+		cl = new Rev(*r); // copy working dir revision
+
+	revData->clear(true); // keep row QByteArray data
+
+	if (cl) { // re-add working dir revision
+		revData->revs.insert(ZERO_SHA, cl);
+		revData->revOrder.append(ZERO_SHA);
+	}
+}
+
 int Git::addChunk(FileHistory* fh, const QByteArray& ba, int start) {

 	RevMap& r = fh->revs;
 	int nextStart;
+	Rev* rev;

-	// only here we create a new rev
-	Rev* rev = new Rev(ba, start, fh->revOrder.count(), &nextStart,
!isMainHistory(fh));
+	do {
+		// only here we create a new rev
+		rev = new Rev(ba, start, fh->revOrder.count(), &nextStart,
!isMainHistory(fh));
+
+		if (nextStart == -2)
+			doEarlyOutput(rev, &start);
+
+	} while (nextStart == -2);

 	if (nextStart == -1) { // half chunk detected
 		delete rev;
@@ -1331,6 +1358,7 @@ int Rev::indexData(bool quick, bool withDiff) const {
 /*
   This is what 'git log' produces:

+	- a possible one line with "Final output:\n" in case of --early-output option
 	- one line with "commit" + sha + an arbitrary amount of parent's sha, in case
 	  of a merge in file history the line terminates with "(from <sha of parent>)"
 	- one line with "log size" + len of this record
@@ -1346,9 +1374,12 @@ int Rev::indexData(bool quick, bool withDiff) const {
 	- a terminating '\0'
 */
 	int last = ba.size() - 1;
-	if (start > last)
+	if (start > last) // offset 'start' points to the char after "commit "
 		return -1;

+	if (uint(ba.at(start) == 'u'))
+		return -2; // "Final output:", let caller handle this
+
 	// take in account --boundary and --left-right options
 	startOfs = uint(ba.at(start) == '-' || ba.at(start) == '<' ||
ba.at(start) == '>');
 	boundary = startOfs && ba.at(start) == '-';
-- 
1.5.3.5.532.g5c38-dirty
