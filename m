From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH qgit] Update to latest --early-output git log patch
Date: Sun, 4 Nov 2007 21:50:35 +0100
Message-ID: <e5bfff550711041250p1c48910fqa631cd7fd3c505f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 21:50:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IomQr-0004bd-GM
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 21:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbXKDUug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 15:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbXKDUug
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 15:50:36 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:8383 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbXKDUuf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 15:50:35 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1332800rvb
        for <git@vger.kernel.org>; Sun, 04 Nov 2007 12:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=6n5FYawks47pavvwYPxhVHGA4DHG2UXy6cww6GsJa80=;
        b=N3671SBd7lF9T3mRAITpSewuq9Em7/VPcQ1xeCmtXMDT8q5RWDVWhZZWvVZpB0NowLqt0cP0ZJ6hgzaMZ3Dy1b9J40Jkmef1XglwGf1MEaNlm74X1HAI7hfA1HpjTXfFjwoRCNXseXMVrvfzvXTeIlDQdBRFGmQ+BAnCxiPV0c8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fnxff15sLjcOXoxx5RTiKtF26OKAdzI1vboHxw/iuBy3cm8zjSgmsGhXeJk0Pivkx6Kc7NlcmwFe74ufPSnNRK8ObbN+lULKot1WLIAiKte/hs6arQJzqnfPzByCJoRFfPDuIZXG0krxm9R0/YEtArn7isbSEOVlniugtncPT5s=
Received: by 10.141.123.4 with SMTP id a4mr31577rvn.1194209435280;
        Sun, 04 Nov 2007 12:50:35 -0800 (PST)
Received: by 10.141.203.3 with HTTP; Sun, 4 Nov 2007 12:50:35 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63440>

Fix broken implementation after Linus updated his
early output patch to version with improve output format.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 src/git.h           |    2 +-
 src/git_startup.cpp |   10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/git.h b/src/git.h
index 92879fb..789fea4 100644
--- a/src/git.h
+++ b/src/git.h
@@ -251,7 +251,7 @@ private:
 	bool startParseProc(SCList initCmd, FileHistory* fh, SCRef buf);
 	bool tryFollowRenames(FileHistory* fh);
 	bool populateRenamedPatches(SCRef sha, SCList nn, FileHistory* fh,
QStringList* on, bool bt);
-	void doEarlyOutput(Rev* rev, int* start);
+	void doEarlyOutput(Rev* rev, const QByteArray& ba, int* start);
 	int addChunk(FileHistory* fh, const QByteArray& ba, int ofs);
 	void parseDiffFormat(RevFile& rf, SCRef buf);
 	void parseDiffFormatLine(RevFile& rf, SCRef line, int parNum);
diff --git a/src/git_startup.cpp b/src/git_startup.cpp
index df272fc..090d5f9 100644
--- a/src/git_startup.cpp
+++ b/src/git_startup.cpp
@@ -841,10 +841,10 @@ void Git::loadFileNames() {
 	indexTree();
 }

-void Git::doEarlyOutput(Rev* rev, int* start) {
+void Git::doEarlyOutput(Rev* rev, const QByteArray& ba, int* start) {

 	delete rev;
-	*start += QString("Final output:\n").length();
+	*start = ba.indexOf('\n', *start) + 1;

 	Rev* cl = NULL;
 	const Rev* r = revLookup(ZERO_SHA);
@@ -870,7 +870,7 @@ int Git::addChunk(FileHistory* fh, const
QByteArray& ba, int start) {
 		rev = new Rev(ba, start, fh->revOrder.count(), &nextStart,
!isMainHistory(fh));

 		if (nextStart == -2)
-			doEarlyOutput(rev, &start);
+			doEarlyOutput(rev, ba, &start);

 	} while (nextStart == -2);

@@ -1377,8 +1377,8 @@ int Rev::indexData(bool quick, bool withDiff) const {
 	if (start > last) // offset 'start' points to the char after "commit "
 		return -1;

-	if (uint(ba.at(start) == 'u'))
-		return -2; // "Final output:", let caller handle this
+	if (uint(ba.at(start) == 'u')) // "Final output:", let caller handle this
+		return (ba.indexOf('\n', start) != -1 ? -2 : -1);

 	// take in account --boundary and --left-right options
 	startOfs = uint(ba.at(start) == '-' || ba.at(start) == '<' ||
ba.at(start) == '>');
-- 
1.5.3.5.565.g985b6
