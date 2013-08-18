From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 10/24] make sure partially read index is not changed
Date: Sun, 18 Aug 2013 21:41:59 +0200
Message-ID: <1376854933-31241-11-git-send-email-t.gummerer@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 21:48:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB8xz-0003xJ-AM
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 21:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855Ab3HRTsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 15:48:39 -0400
Received: from mail-we0-f182.google.com ([74.125.82.182]:47533 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647Ab3HRTsh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 15:48:37 -0400
Received: by mail-we0-f182.google.com with SMTP id q59so2837478wes.41
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 12:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QBI0GTFW05XysCwRGc4iYOjchhfi7opaZOW+5/w4zoU=;
        b=NLoP89uqUYzV92uvbbrFbYnQpqjbQ/gB9WTRNOGVdtTVWVqRn/dmV6M2dmAvBZ0Noi
         sQgNQbv3hY/RzgO3553MZCFfdnUFUsjUeDIPaIFOxmNFPz76VwD7gO3hDyYmGBA/oGIl
         h94BmX3f7Cbb4GTOYOFp1xbY/p+AYAqMXDkv8Y3qQkMxiavUgZm5pfyakeolD6u3Qym4
         Vd+W1su/hLTca4ts4hjyb3q3h+UuW2qzO3yWW/KBFNcsyXwMA0zKJXmqKeRr2pI5Rctt
         sMp0lB2AiLNcJbT4D3vjjGE77V86blXtg9rZHxSeoyYwZB964Sv8INg2ndSx5A6A4P3g
         /pkA==
X-Received: by 10.180.187.2 with SMTP id fo2mr5472677wic.65.1376855316680;
        Sun, 18 Aug 2013 12:48:36 -0700 (PDT)
Received: from localhost (host105-104-dynamic.0-79-r.retail.telecomitalia.it. [79.0.104.105])
        by mx.google.com with ESMTPSA id hb2sm13382779wib.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 12:48:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1231.g9fbf354.dirty
In-Reply-To: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232500>

A partially read index file currently cannot be written to disk.  Make
sure that never happens, by erroring out when a caller tries to write a
partially read index.  Do the same when trying to re-read a partially
read index without having discarded it first to avoid loosing any
information.

Forcing the caller to load the right part of the index file instead of
re-reading it when changing it, gives a bit of a performance advantage,
by avoiding to read parts of the index twice.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 38b9a04..7a27f9b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1332,6 +1332,8 @@ int read_index_filtered_from(struct index_state *istate, const char *path,
 	void *mmap;
 	size_t mmap_size;
 
+	if (istate->filter_opts)
+		die("BUG: Can't re-read partially read index");
 	errno = EBUSY;
 	if (istate->initialized)
 		return istate->cache_nr;
@@ -1455,6 +1457,8 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
 
 int write_index(struct index_state *istate, int newfd)
 {
+	if (istate->filter_opts)
+		die("BUG: index: cannot write a partially read index");
 	return istate->ops->write_index(istate, newfd);
 }
 
-- 
1.8.3.4.1231.g9fbf354.dirty
