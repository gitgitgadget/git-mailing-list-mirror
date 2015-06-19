From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v6 09/19] fsck: Handle multiple authors in commits specially
Date: Fri, 19 Jun 2015 15:34:07 +0200
Organization: gmx
Message-ID: <eb82bbfc658e8af1db03f7197b38aaaec33fd4ad.1434720655.git.johannes.schindelin@gmx.de>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 19 15:34:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5wQz-00007L-VH
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 15:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371AbbFSNeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 09:34:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:51042 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753309AbbFSNeM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 09:34:12 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LbMb0-1YiSFp3LII-00kvPn; Fri, 19 Jun 2015 15:34:07
 +0200
In-Reply-To: <cover.1434720655.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:u09LBLmO9EqqpotrFf9Tn8q5W6SQVBUDtWS3DmlOLlr5egkpj4i
 4vvZMN0dzMeJbR4suCIlwBGSHBTR45pH75+iveILhbfzUUvShIzgPcAzQpcBuVJo5FqVvD3
 RpGwKkzr/LOO/f6sqDWO7Kh97H1706nsgsjhqesY1ke6Y34eO16j9YH76Ljy0efFxDGvp0g
 /YH0Q5AUhRWDP9lE5qkWw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272145>

This problem has been detected in the wild, and is the primary reason
to introduce an option to demote certain fsck errors to warnings. Let's
offer to ignore this particular problem specifically.

Technically, we could handle such repositories by setting
receive.fsck.<msg-id> to missingcommitter=warn, but that could hide
missing tree objects in the same commit because we cannot continue
verifying any commit object after encountering a missing committer line,
while we can continue in the case of multiple author lines.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fsck.c b/fsck.c
index 9fe9f48..0cfa4d0 100644
--- a/fsck.c
+++ b/fsck.c
@@ -38,6 +38,7 @@
 	FUNC(MISSING_TREE, ERROR) \
 	FUNC(MISSING_TYPE, ERROR) \
 	FUNC(MISSING_TYPE_ENTRY, ERROR) \
+	FUNC(MULTIPLE_AUTHORS, ERROR) \
 	FUNC(NUL_IN_HEADER, ERROR) \
 	FUNC(TAG_OBJECT_NOT_TAG, ERROR) \
 	FUNC(TREE_NOT_SORTED, ERROR) \
@@ -571,6 +572,14 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
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
2.3.1.windows.1.9.g8c01ab4
