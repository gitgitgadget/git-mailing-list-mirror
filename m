From: Jeff King <peff@peff.net>
Subject: [PATCH] shallow: verify shallow file after taking lock
Date: Fri, 14 Mar 2014 23:47:06 -0400
Message-ID: <20140315034706.GA3931@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 15 04:47:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOfZ4-0000dF-MY
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 04:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755708AbaCODrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 23:47:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:39873 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754810AbaCODrI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 23:47:08 -0400
Received: (qmail 8230 invoked by uid 102); 15 Mar 2014 03:47:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Mar 2014 22:47:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Mar 2014 23:47:06 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244139>

Before writing the shallow file, we stat() the existing file
to make sure it has not been updated since our operation
began. However, we do not do so under a lock, so there is a
possible race:

  1. Process A takes the lock.

  2. Process B calls check_shallow_file_for_update and finds
     no update.

  3. Process A commits the lockfile.

  4. Process B takes the lock, then overwrite's process A's
     changes.

We can fix this by doing our check while we hold the lock.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a repost of:

  http://article.gmane.org/gmane.comp.version-control.git/242795

You picked up the other two related patches as jk/shallow-update-fix,
but I suspect this one just got lost in the noise because I didn't
format it as a proper series.

 shallow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/shallow.c b/shallow.c
index bbc98b5..75da07a 100644
--- a/shallow.c
+++ b/shallow.c
@@ -246,9 +246,9 @@ void setup_alternate_shallow(struct lock_file *shallow_lock,
 	struct strbuf sb = STRBUF_INIT;
 	int fd;
 
-	check_shallow_file_for_update();
 	fd = hold_lock_file_for_update(shallow_lock, git_path("shallow"),
 				       LOCK_DIE_ON_ERROR);
+	check_shallow_file_for_update();
 	if (write_shallow_commits(&sb, 0, extra)) {
 		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
 			die_errno("failed to write to %s",
@@ -293,9 +293,9 @@ void prune_shallow(int show_only)
 		strbuf_release(&sb);
 		return;
 	}
-	check_shallow_file_for_update();
 	fd = hold_lock_file_for_update(&shallow_lock, git_path("shallow"),
 				       LOCK_DIE_ON_ERROR);
+	check_shallow_file_for_update();
 	if (write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY)) {
 		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
 			die_errno("failed to write to %s",
-- 
1.9.0.532.g9ab8f58
