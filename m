From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/8] checkout-index: work from subdirectory.
Date: Sat, 26 Nov 2005 01:56:58 -0800
Message-ID: <7v1x1368b9.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0511200935081.13959@g5.osdl.org>
	<200511210026.30280.Josef.Weidendorfer@gmx.de>
	<200511221831.03954.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
	<438371E8.2030701@op5.se>
	<Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
	<7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
	<Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
	<43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 26 10:57:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Efwnn-0002Pe-F3
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 10:57:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVKZJ5A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 04:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVKZJ5A
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 04:57:00 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:2224 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750824AbVKZJ47 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2005 04:56:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051126095631.ZPZP3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 26 Nov 2005 04:56:31 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12773>

With this, git-checkout-index from a subdirectory works as
expected.  Note that "git-checkout-index -a" checks out files
only in the current directory and under.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 checkout-index.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

applies-to: 5609c84ffd98e1b253c4cb46523245c3be553624
556dc2ebd6566fc032444224a145d3cb422eecc4
diff --git a/checkout-index.c b/checkout-index.c
index dab3778..f1e716d 100644
--- a/checkout-index.c
+++ b/checkout-index.c
@@ -34,6 +34,9 @@
  */
 #include "cache.h"
 
+static const char *prefix;
+static int prefix_length;
+
 static struct checkout state = {
 	.base_dir = "",
 	.base_dir_len = 0,
@@ -69,6 +72,10 @@ static int checkout_all(void)
 		struct cache_entry *ce = active_cache[i];
 		if (ce_stage(ce))
 			continue;
+		if (prefix && *prefix &&
+		    ( ce_namelen(ce) <= prefix_length ||
+		      memcmp(prefix, ce->name, prefix_length) ))
+			continue;
 		if (checkout_entry(ce, &state) < 0)
 			errs++;
 	}
@@ -91,6 +98,9 @@ int main(int argc, char **argv)
 	int newfd = -1;
 	int all = 0;
 
+	prefix = setup_git_directory();
+	prefix_length = prefix ? strlen(prefix) : 0;
+
 	if (read_cache() < 0) {
 		die("invalid cache");
 	}
@@ -155,7 +165,7 @@ int main(int argc, char **argv)
 
 		if (all)
 			die("git-checkout-index: don't mix '--all' and explicit filenames");
-		checkout_file(arg);
+		checkout_file(prefix_path(prefix, prefix_length, arg));
 	}
 
 	if (all)
---
0.99.9.GIT
