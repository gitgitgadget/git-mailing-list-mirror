From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 09/18] fsck: handle multiple authors in commits specially
Date: Mon, 8 Dec 2014 17:15:00 +0100 (CET)
Message-ID: <43faa41d4cc98d6c40a393ec590af73ec5c94246.1418055173.git.johannes.schindelin@gmx.de>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 08 17:15:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy0xs-00069V-K1
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 17:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755880AbaLHQPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 11:15:05 -0500
Received: from mout.gmx.net ([212.227.15.19]:52481 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755806AbaLHQPD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 11:15:03 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0LpcBS-1XSXUx0yuM-00fUzy;
 Mon, 08 Dec 2014 17:15:01 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1418055173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:SPBps6tpelbNp46pEacLieYOgeNdsko5xwm8U12MwW6Z4IpMQ4R
 SR3swmiLrA3BO7t3aYwGdXaiEu53MqziaeICfhp/DQ1/dco75tdUz5w0Y49CiKSBzbPPdSS
 HMTExlGYCdPqIclv2g3XcIMiHo5gZXhTQzaRsim+BpyqTTubPyDC/iKz5vz/9zdDCeBdwcA
 SH4X4srbHUEjNZgUobVIw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261060>

This problem has been detected in the wild, and is the primary reason
to introduce an option to demote certain fsck errors to warnings. Let's
offer to ignore this particular problem specifically.

Technically, we could handle such repositories by setting
missing-committer = warn, but that could hide missing tree objects in the
same commit because we cannot continue verifying any commit object after
encountering a missing committer line, while we can continue in the case
of multiple author lines.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fsck.c b/fsck.c
index a63654c..21ff35b 100644
--- a/fsck.c
+++ b/fsck.c
@@ -37,6 +37,7 @@
 	FUNC(MISSING_TREE) \
 	FUNC(MISSING_TYPE) \
 	FUNC(MISSING_TYPE_ENTRY) \
+	FUNC(MULTIPLE_AUTHORS) \
 	FUNC(NOT_SORTED) \
 	FUNC(NUL_IN_HEADER) \
 	FUNC(TAG_OBJECT_NOT_TAG) \
@@ -536,6 +537,13 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 	err = fsck_ident(&buffer, &commit->object, options);
 	if (err)
 		return err;
+	while (skip_prefix(buffer, "author ", &buffer)) {
+		err = report(options, &commit->object, FSCK_MSG_MULTIPLE_AUTHORS, "invalid format - multiple 'author' lines");
+		if (err)
+			return err;
+		/* require_end_of_header() ensured that there is a newline */
+		buffer = strchr(buffer, '\n') + 1;
+	}
 	if (!skip_prefix(buffer, "committer ", &buffer))
 		return report(options, &commit->object, FSCK_MSG_MISSING_COMMITTER, "invalid format - expected 'committer' line");
 	err = fsck_ident(&buffer, &commit->object, options);
-- 
2.0.0.rc3.9669.g840d1f9
