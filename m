From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 3/6] cogito: try harder to find gnu stat
Date: Sun, 17 Jul 2005 22:51:02 -0400
Message-ID: <20050718025057.11198.96144.sendpatchset@bryan-larsens-ibook-g4.local>
References: <20050718025024.11198.10556.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 04:51:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuLit-0008Fe-88
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 04:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVGRCvF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 22:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVGRCvF
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 22:51:05 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:22653 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261494AbVGRCvC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2005 22:51:02 -0400
Received: (qmail 60654 invoked from network); 18 Jul 2005 02:51:01 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=dp4Y2F4S95fCOvh95jF3OpeIhWcKC+UjB25MgL0MT46LClFk+xA082bbhA9y/3RwyqBwbqJhTsVF9GIm9Isfx+smgyt9j3Gs4s8CvGkZO3XX/tQzEtH0lbberbSspOGak48qSqjTtWC8WT99fj4F5q0uvzM4MhrLHSirggr6dpM=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@70.26.43.137 with plain)
  by smtp015.mail.yahoo.com with SMTP; 18 Jul 2005 02:51:01 -0000
To: bryan.larsen@gmail.com
In-Reply-To: <20050718025024.11198.10556.sendpatchset@bryan-larsens-ibook-g4.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Look harder for gnu stat.

Cogito has code to use awk if gnu stat is missing.  Look harder 
for gnu stat under alternate names such as gstat and gnustat, avoiding
the use of awk if possible.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 cg-Xlib |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/cg-Xlib b/cg-Xlib
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -229,11 +229,16 @@ fi
 
 
 # Compatibility hacks:
-# Fortunately none as of now.
-
 
 export BROKEN_MKTEMP=1
 del=$($(which mktemp) -t 2>/dev/null) && { rm $del; export BROKEN_MKTEMP=; }
-has_stat=$(which stat 2>/dev/null)
-[ "$has_stat" ] && $has_stat -c %s / 2>/dev/null >&2 || has_stat=
+
+has_stat=
+for stat in "$(which gnustat)" "$(which gstat)" "$(which stat)" ; do
+    if ( [ $stat ] && $stat -c %s / 2> /dev/null >&2 ) ; then
+	has_stat=$stat
+	break
+    fi
+done
+
 has_gnudate=$(date -Rud "1970-01-01 UTC" 2>/dev/null)
