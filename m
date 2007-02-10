From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] git-runstatus --refresh
Date: Fri, 09 Feb 2007 18:51:55 -0800
Message-ID: <7vr6syohbo.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	<Pine.LNX.4.64.0702091148060.8424@woody.linux-foundation.org>
	<7vr6szt71j.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550702091235x74e44362gad5b9b6076a5ea53@mail.gmail.com>
	<Pine.LNX.4.64.0702091253120.8424@woody.linux-foundation.org>
	<7vmz3mq394.fsf@assigned-by-dhcp.cox.net>
	<7vejoyq330.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Feb 10 03:52:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFiLS-0005Gx-CL
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 03:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbXBJCv4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 21:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752905AbXBJCv4
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 21:51:56 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:51718 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbXBJCv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 21:51:56 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070210025154.BDKR21177.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 9 Feb 2007 21:51:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Meru1W00m1kojtg0000000; Fri, 09 Feb 2007 21:51:55 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39206>

This teaches git-runstatus a new option --refresh to refresh the
index in-core.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * If a cache has 20k+ paths, this could be rather expensive
   because git-status already have refreshed the entries for us,
   so I am reluctant to make this the default, but obviously
   then qgit needs to know if it has runstatus that knows about
   this option.

 builtin-runstatus.c |    4 +++-
 wt-status.c         |    2 ++
 wt-status.h         |    1 +
 3 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/builtin-runstatus.c b/builtin-runstatus.c
index 4b489b1..df66742 100644
--- a/builtin-runstatus.c
+++ b/builtin-runstatus.c
@@ -4,7 +4,7 @@
 extern int wt_status_use_color;
 
 static const char runstatus_usage[] =
-"git-runstatus [--color|--nocolor] [--amend] [--verbose] [--untracked]";
+"git-runstatus [--color|--nocolor] [--refresh] [--amend] [--verbose] [--untracked]";
 
 int cmd_runstatus(int argc, const char **argv, const char *prefix)
 {
@@ -17,6 +17,8 @@ int cmd_runstatus(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc; i++) {
 		if (!strcmp(argv[i], "--color"))
 			wt_status_use_color = 1;
+		else if (!strcmp(argv[i], "--refresh"))
+			s.refresh = 1;
 		else if (!strcmp(argv[i], "--nocolor"))
 			wt_status_use_color = 0;
 		else if (!strcmp(argv[i], "--amend")) {
diff --git a/wt-status.c b/wt-status.c
index e346511..27c228b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -195,6 +195,8 @@ static void wt_read_cache(struct wt_status *s)
 {
 	discard_cache();
 	read_cache();
+	if (s->refresh)
+		refresh_cache(REFRESH_QUIET);
 }
 
 void wt_status_print_initial(struct wt_status *s)
diff --git a/wt-status.h b/wt-status.h
index cfea4ae..680a0ca 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -15,6 +15,7 @@ struct wt_status {
 	int verbose;
 	int amend;
 	int untracked;
+	int refresh;
 	/* These are computed during processing of the individual sections */
 	int commitable;
 	int workdir_dirty;
-- 
1.5.0.rc4.26.gcc46
