From: Sven Verdoolaege <skimo@kotnet.org>
Subject: [PATCH] lockfile.c: schedule remove_lock_file only once.
Date: Fri, 13 Jul 2007 16:14:50 +0200
Message-ID: <20070713141450.GA8392MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 16:15:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9LvE-00088i-3d
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 16:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757951AbXGMOOx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 10:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757573AbXGMOOw
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 10:14:52 -0400
Received: from smtp19.wxs.nl ([195.121.247.10]:53393 "EHLO smtp19.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757198AbXGMOOw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 10:14:52 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp19.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JL400FZIFKRM8@smtp19.wxs.nl> for git@vger.kernel.org; Fri,
 13 Jul 2007 16:14:51 +0200 (CEST)
Received: (qmail 3231 invoked by uid 500); Fri, 13 Jul 2007 14:14:50 +0000
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52395>

Removing a lockfile once should be enough.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
...unless we're running on VMS.

Anyway, it's not clear to me why we can't remove lk from
lock_file_list (and then free it) after we unlink it
in unlock_ref.

skimo

 lockfile.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 5ad2858..fb8f13b 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -31,16 +31,16 @@ static int lock_file(struct lock_file *lk, const char *path)
 	sprintf(lk->filename, "%s.lock", path);
 	fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (0 <= fd) {
+		if (!lock_file_list) {
+			signal(SIGINT, remove_lock_file_on_signal);
+			atexit(remove_lock_file);
+		}
 		lk->owner = getpid();
 		if (!lk->on_list) {
 			lk->next = lock_file_list;
 			lock_file_list = lk;
 			lk->on_list = 1;
 		}
-		if (lock_file_list) {
-			signal(SIGINT, remove_lock_file_on_signal);
-			atexit(remove_lock_file);
-		}
 		if (adjust_shared_perm(lk->filename))
 			return error("cannot fix permission bits on %s",
 				     lk->filename);
-- 
1.5.3.rc1.10.gae1ae
