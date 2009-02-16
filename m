From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH] format-patch: thread as reply to cover letter even with in-reply-to
Date: Mon, 16 Feb 2009 20:00:12 +0100
Message-ID: <1234810812-30499-1-git-send-email-trast@student.ethz.ch>
References: <cover.1234801852.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 20:02:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ8j6-0006g2-23
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 20:01:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbZBPTA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 14:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbZBPTA1
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 14:00:27 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:42357 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751688AbZBPTA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 14:00:26 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 16 Feb 2009 20:00:25 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 16 Feb 2009 20:00:24 +0100
X-Mailer: git-send-email 1.6.2.rc0.328.g2c702
In-Reply-To: <cover.1234801852.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 16 Feb 2009 19:00:24.0949 (UTC) FILETIME=[D31A6250:01C99068]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110229>

Currently, format-patch --thread --cover-letter --in-reply-to $parent
makes all mails, including the cover letter, a reply to $parent.
However, we would want the reader to consider the cover letter above
all the patches.

This changes the semantics so that only the cover letter is a reply to
$parent, while all the patches are formatted as replies to the cover
letter.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Thomas Rast wrote:
> Unrelated note regarding --thread usage:
> 
> Wouldn't it be better if format-patch made it so that the cover
> letter, if any, is the (only) reply to the --in-reply-to, and all
> actual patches are replies to the cover letter?

Maybe like this?


 builtin-log.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 2ae39af..ec11f95 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -1031,12 +1031,22 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			/* Have we already had a message ID? */
 			if (rev.message_id) {
 				/*
-				 * If we've got the ID to be a reply
-				 * to, discard the current ID;
-				 * otherwise, make everything a reply
-				 * to that.
+				 * Without --cover-letter and
+				 * --in-reply-to, make every mail a
+				 * reply to the one before.
+				 *
+				 * With --in-reply-to but no
+				 * --cover-letter, make every mail a
+				 * reply to the <reply-to>.
+				 *
+				 * With --cover-letter, make every
+				 * mail but the cover letter a reply
+				 * to the cover letter.  The cover
+				 * letter is a reply to the
+				 * --in-reply-to, if specified.
 				 */
-				if (rev.ref_message_id)
+				if (rev.ref_message_id
+				    && (!cover_letter || rev.nr > 1))
 					free(rev.message_id);
 				else
 					rev.ref_message_id = rev.message_id;
-- 
1.6.2.rc0.328.g2c702
