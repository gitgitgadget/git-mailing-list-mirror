From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix is_gitfile() for files larger than PATH_MAX
Date: Tue, 11 Oct 2011 14:25:32 -0500 (CDT)
Message-ID: <alpine.DEB.1.00.1110111424010.32316@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1784107012-2076357281-1318361134=:32316"
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Oct 11 21:25:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDhxO-0004sD-OX
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 21:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340Ab1JKTZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 15:25:37 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:47709 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754933Ab1JKTZh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 15:25:37 -0400
Received: (qmail invoked by alias); 11 Oct 2011 19:25:34 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp001) with SMTP; 11 Oct 2011 21:25:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19L2G1TZYhLpNsaHBZSkdPbr416jJ0vtmVznog1wv
	LcyPPadeVzAoyP
X-X-Sender: schindelin@s15462909.onlinehome-server.info
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183320>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1784107012-2076357281-1318361134=:32316
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT


The logic to check whether a file is a gitfile used the heuristics that
the file cannot be larger than PATH_MAX. But in that case it returned the
wrong value. Our test cases do not cover this, as the bundle files
produced are smaller than PATH_MAX. Except on Windows.

While at it, fix the faulty logic that the path stored in a gitfile cannot
be larger than PATH_MAX-sizeof("gitfile: ").

Problem identified by running the test suite in msysGit, offending commit
identified by Jörg Rosenkranz.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
	This patch should apply cleanly to 'next', which we track in
	msysgit/git.

	The task of adding a test case is something I leave to someone who
	wants to get involved with Git development and needs an easy way
	in.

 transport.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/transport.c b/transport.c
index f3195c0..57138d9 100644
--- a/transport.c
+++ b/transport.c
@@ -868,8 +868,8 @@ static int is_gitfile(const char *url)
 		return 0;
 	if (!S_ISREG(st.st_mode))
 		return 0;
-	if (st.st_size < 10 || st.st_size > PATH_MAX)
-		return 1;
+	if (st.st_size < 10 || st.st_size > 9 + PATH_MAX)
+		return 0;
 
 	fd = open(url, O_RDONLY);
 	if (fd < 0)
-- 
1.7.6.msysgit.0.584.g2cbf

--1784107012-2076357281-1318361134=:32316--
