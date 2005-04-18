From: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH] Pretty-print date in 'git log'
Date: Mon, 18 Apr 2005 15:46:59 +1000
Message-ID: <1113803220.11910.81.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 07:43:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNP2m-0005Dk-6W
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 07:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVDRFr2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 01:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVDRFr2
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 01:47:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33229 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261683AbVDRFrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 01:47:16 -0400
Received: from [150.203.247.9] (helo=[172.24.3.18])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DNP6G-0004Qj-Nw; Mon, 18 Apr 2005 06:47:16 +0100
To: Petr Baudis <pasky@ucw.cz>
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add tool to render git's "<utcseconds> <zone>" into an RFC2822-compliant
string, because I don't think date(1) can do it. Use same for 'git log'
output.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

--- Makefile
+++ Makefile	2005-04-18 15:40:43.000000000 +1000
@@ -14,7 +14,7 @@
 
 PROG=   update-cache show-diff init-db write-tree read-tree commit-tree \
 	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
-	check-files ls-tree merge-base
+	check-files ls-tree merge-base show-date
 
 SCRIPT=	parent-id tree-id git gitXnormid.sh gitadd.sh gitaddremote.sh \
 	gitcommit.sh gitdiff-do gitdiff.sh gitlog.sh gitls.sh gitlsobj.sh \
--- gitlog.sh
+++ gitlog.sh	2005-04-18 15:39:38.000000000 +1000
@@ -13,6 +13,23 @@
 
 rev-tree $base | sort -rn | while read time commit parents; do
 	echo commit ${commit%:*};
-	cat-file commit $commit
+	cat-file commit $commit | while read type rest ; do
+		case "$type" in
+		    "author"|"committer")
+		        DATESTAMP="`echo $rest | cut -f2 -d\>`"
+			RFC2822DATE="`show-date $DATESTAMP 2>/dev/null || echo $DATESTAMP`"
+			echo $type $rest | sed "s/$DATESTAMP\$/ $RFC2822DATE/"
+			;;
+
+		    "")
+			echo ""
+			cat
+			;;
+		    *)
+			echo $type $rest
+			;;
+		esac
+	    done
+		    
 	echo -e "\n--------------------------"
 done
--- show-date.c.orig	2005-04-18 15:43:06.000000000 +1000
+++ show-date.c	2005-04-18 15:42:15.000000000 +1000
@@ -0,0 +1,48 @@
+#include <time.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include "cache.h"
+
+static const char *month_names[] = {
+        "Jan", "Feb", "Mar", "Apr", "May", "Jun",
+        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
+};
+
+static const char *weekday_names[] = {
+        "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"
+};
+
+int main(int argc, char **argv)
+{
+	time_t t;
+	int offset;
+	char *p;
+	struct tm tm;
+
+	if (argc != 3)
+		usage("usage: show-date <seconds> <zone>");
+
+	t = strtol(argv[1], &p, 0);
+	if (*p || !t)
+		usage("usage: show-date <seconds> <zone>");
+
+	if (argv[2][0] != '-' && argv[2][0] != '+')
+		usage("usage: show-date <seconds> <zone>");
+
+	offset = strtol(argv[2]+1, &p, 10);
+	if (*p || p!= argv[2]+5)
+		usage("usage: show-date <seconds> <zone>");
+
+	if (argv[2][0] == '-')
+		offset = -offset;
+
+	offset = 60 * (offset % 100 + (offset / 100 * 60));
+
+	t += offset;
+	gmtime_r(&t, &tm);
+
+	printf("%s, %d %s %04d %02d:%02d:%02d %s\n",
+	       weekday_names[tm.tm_wday], tm.tm_mday, month_names[tm.tm_mon],
+	       tm.tm_year+1900, tm.tm_hour, tm.tm_min, tm.tm_sec, argv[2]);
+	return 0;
+}

-- 
dwmw2

