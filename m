From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 09/19] fsck: Handle multiple authors in commits specially
Date: Wed, 21 Jan 2015 20:25:30 +0100
Organization: gmx
Message-ID: <8e23b0f08f9aef7b57716587f2573d8b381b4594.1421868116.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421868116.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 21 20:25:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE0uP-0002b7-Sn
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 20:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbbAUTZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 14:25:42 -0500
Received: from mout.gmx.net ([212.227.15.15]:51291 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753743AbbAUTZl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 14:25:41 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M86jp-1XrW4x2Rd3-00veTH; Wed, 21 Jan 2015 20:25:30
 +0100
In-Reply-To: <cover.1421868116.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:C1CfUeGg72nAkPVOW/THyCn2+Iq3wfJBT5qfMpt6P4lySKC8/eC
 goLEfN822Gkv8ndDoa83RaZueNZSA0lztis14AXeRZ6c4JaimKmzFfrrF472ppznkIDGSak
 5Z/pWRCRRYjEfiy9iXcrgi8gFpy/bKF4LnsAUhjy4M6I5Hxi2XMnWEOnjy5bgASfy2wbfEV
 cvWB/1P/lyalr4VBQKyCg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262754>

This problem has been detected in the wild, and is the primary reason
to introduce an option to demote certain fsck errors to warnings. Let's
offer to ignore this particular problem specifically.

Technically, we could handle such repositories by setting
receive.fsck.warn = missing-committer, but that could hide missing tree
objects in the same commit because we cannot continue verifying any
commit object after encountering a missing committer line, while we can
continue in the case of multiple author lines.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fsck.c b/fsck.c
index 8979357..3118db1 100644
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
@@ -545,6 +546,14 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
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
