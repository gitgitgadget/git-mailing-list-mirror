From: Jeff King <peff@peff.net>
Subject: [PATCH] shallow: verify shallow file after taking lock
Date: Thu, 27 Feb 2014 04:10:13 -0500
Message-ID: <20140227091012.GB21892@sigill.intra.peff.net>
References: <1393485183-20100-1-git-send-email-pclouds@gmail.com>
 <20140227090426.GA21892@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 10:11:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIwzE-0006VG-JG
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 10:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbaB0JKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 04:10:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:57890 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750742AbaB0JKO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 04:10:14 -0500
Received: (qmail 11719 invoked by uid 102); 27 Feb 2014 09:10:15 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Feb 2014 03:10:15 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Feb 2014 04:10:13 -0500
Content-Disposition: inline
In-Reply-To: <20140227090426.GA21892@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242795>

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
On Thu, Feb 27, 2014 at 04:04:26AM -0500, Jeff King wrote:

> by the way, shouldn't we do that check under the lock? I think
> setup_alternate_shallow has a race condition).

Here is the fix. I didn't actually reproduce the race experimentally,
but it seems pretty straightforward.

I also notice that check_shallow_file_for_update returns early if
!is_shallow. Is that safe? Is it possible for another process to have
made us shallow since the program began? In that case, we would have to
stat() the file always, then complain if it exists and !is_shallow.

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
1.8.5.2.500.g8060133
