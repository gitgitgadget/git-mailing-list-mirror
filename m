From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] rerere: error out on autoupdate failure
Date: Tue, 2 Dec 2014 20:20:49 -0800
Message-ID: <20141203042049.GI6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 05:20:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw1Qu-0003Ey-DJ
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 05:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbaLCEUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 23:20:52 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:54650 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbaLCEUw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 23:20:52 -0500
Received: by mail-ig0-f176.google.com with SMTP id l13so17331252iga.9
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 20:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=GduuUC5pmyV/1Q/vJjL1j6jCLMe08RpIAuUMdz6KRN0=;
        b=EXuhKY5OiJk5EugZzpuOCILRY05+wUq6aXmriaWkSvAdF4oF2CgbrJoBmr65M0Uf6r
         VgthWaUl+kaADg+2akO0ESW3jabC5r4an758mmBKfcaZx0lpwXusHdMJ4LuiaGkIykLW
         GjG879hcC2KOqz/deJjc2DrcSc5GYvc1TVi12LG1YPvARyfzGwyObvordrKVdaCIa4gm
         TqckP7DPp3g83Bb6p4jFvD1J/3/rQV4NzbTg/ZgNWkD8hs4yEL29Xnzzvsarr949Infd
         zMVsuk2BudWK/TmIPo+Ew9SSIcbKyQva0x3tThY0gkm0SE1OH1oyrT7kNAVNI8GvG/EO
         gYhA==
X-Received: by 10.107.155.196 with SMTP id d187mr3045363ioe.14.1417580451539;
        Tue, 02 Dec 2014 20:20:51 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id f16sm1297828iof.37.2014.12.02.20.20.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Dec 2014 20:20:51 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260623>

We have been silently tolerating errors by returning early with an
error that the caller ignores since rerere.autoupdate was introduced
in v1.6.0-rc0~120^2 (2008-06-22).  So on error (for example if the
index is already locked), rerere can return success silently without
updating the index or with only some items in the index updated.

Better to treat such failures as a fatal error so the operator can
figure out what is wrong and fix it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I ran into this while auditing hold_locked_index callers.  Tests
still pass after this change.  Sensible?

 rerere.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/rerere.c b/rerere.c
index 1b0555f..195f663 100644
--- a/rerere.c
+++ b/rerere.c
@@ -477,27 +477,23 @@ out:
 
 static struct lock_file index_lock;
 
-static int update_paths(struct string_list *update)
+static void update_paths(struct string_list *update)
 {
 	int i;
-	int fd = hold_locked_index(&index_lock, 0);
-	int status = 0;
 
-	if (fd < 0)
-		return -1;
+	hold_locked_index(&index_lock, 1);
 
 	for (i = 0; i < update->nr; i++) {
 		struct string_list_item *item = &update->items[i];
 		if (add_file_to_cache(item->string, ADD_CACHE_IGNORE_ERRORS))
-			status = -1;
+			die("staging updated %s failed", item->string);
 	}
 
-	if (!status && active_cache_changed) {
+	if (active_cache_changed) {
 		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
 			die("Unable to write new index file");
-	} else if (fd >= 0)
+	} else
 		rollback_lock_file(&index_lock);
-	return status;
 }
 
 static int do_plain_rerere(struct string_list *rr, int fd)
