From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 09/19] fsck: Handle multiple authors in commits specially
Date: Sat, 31 Jan 2015 22:06:11 +0100
Organization: gmx
Message-ID: <cf00fd78964eac735fa87089d8c2ec451e827089.1422737997.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1422737997.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 31 22:06:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHfFO-0004uL-Qt
	for gcvg-git-2@plane.gmane.org; Sat, 31 Jan 2015 22:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756167AbbAaVGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2015 16:06:25 -0500
Received: from mout.gmx.net ([212.227.15.19]:53294 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755820AbbAaVGY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2015 16:06:24 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LyVpm-1Xdden3pws-015rnC; Sat, 31 Jan 2015 22:06:11
 +0100
In-Reply-To: <cover.1422737997.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:Gs4N3fZ2gLP+L645nV/YM+8pj4FdJL/i8G6BSmO9QOAPfj/nR7t
 rSs1MMDXmtzqpNyPfJIofpL0SQw5XmNWsiltS6A4sj7qYAkJBnA/yhQ+L/M1QOS4562rcZp
 KlidxyIBlrDleENQiP4385wG2qXAUYcbCRHOg9HX1XnCbCjAzo/MaKs0zwGPIb5Cxxucr7E
 XYl0zYktdWnCTfBiBxbuw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263223>

This problem has been detected in the wild, and is the primary reason
to introduce an option to demote certain fsck errors to warnings. Let's
offer to ignore this particular problem specifically.

Technically, we could handle such repositories by setting
receive.fsck.severity to missing-committer=warn, but that could hide
missing tree objects in the same commit because we cannot continue
verifying any commit object after encountering a missing committer line,
while we can continue in the case of multiple author lines.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fsck.c b/fsck.c
index 7ce7857..b92d8c4 100644
--- a/fsck.c
+++ b/fsck.c
@@ -38,6 +38,7 @@
 	FUNC(MISSING_TREE, ERROR) \
 	FUNC(MISSING_TYPE, ERROR) \
 	FUNC(MISSING_TYPE_ENTRY, ERROR) \
+	FUNC(MULTIPLE_AUTHORS, ERROR) \
 	FUNC(NOT_SORTED, ERROR) \
 	FUNC(NUL_IN_HEADER, ERROR) \
 	FUNC(TAG_OBJECT_NOT_TAG, ERROR) \
@@ -551,6 +552,14 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 	err = fsck_ident(&buffer, &commit->object, options);
 	if (err)
 		return err;
+	while (skip_prefix(buffer, "author ", &buffer)) {
+		err = report(options, &commit->object, FSCK_MSG_MULTIPLE_AUTHORS, "invalid format - multiple 'author' lines");
+		if (err)
+			return err;
+		err = fsck_ident(&buffer, &commit->object, options);
+		if (err)
+			return err;
+	}
 	if (!skip_prefix(buffer, "committer ", &buffer))
 		return report(options, &commit->object, FSCK_MSG_MISSING_COMMITTER, "invalid format - expected 'committer' line");
 	err = fsck_ident(&buffer, &commit->object, options);
-- 
2.2.0.33.gc18b867
