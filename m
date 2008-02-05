From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] prune: heed --expire for stale packs, add a test
Date: Tue, 5 Feb 2008 20:06:41 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802052005200.8543@racer.site>
References: <Pine.GSO.4.63.0802051844220.15867@suma3> <alpine.LFD.1.00.0802051357420.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Steven Tweed <d.s.tweed@reading.ac.uk>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 21:08:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMU5V-0008CJ-EV
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 21:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760522AbYBEUHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 15:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759996AbYBEUHZ
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 15:07:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:44774 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759988AbYBEUHW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 15:07:22 -0500
Received: (qmail invoked by alias); 05 Feb 2008 20:07:20 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp047) with SMTP; 05 Feb 2008 21:07:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/fyU48N2zf9aPspEagHc7NtHFBeHqyMHHaMoCi46
	0TQSdrr6GLZ8c9
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0802051357420.2732@xanadu.home>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72687>


Follow the same logic as for loose objects when removing stale packs: they
might be in use (for example when fetching, or repacking in a cron job),
so give the user a chance to say (via --expire) what is considered too
young an age to die for stale packs.

Also add a simple test to verify that the stale packs are actually
expired.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---


	On Tue, 5 Feb 2008, Nicolas Pitre wrote:

	> On Tue, 5 Feb 2008, David Steven Tweed wrote:
	> 
	> > @@ -115,5 +139,6 @@ int cmd_prune(int argc, const char **argv, 
	> > const char *prefix)
	> > 
	> >  	sync();
	> >  	prune_packed_objects(show_only);
	> > +	remove_temporary_files();
	> 
	> Maybe you could implement the "show_only" mode for 
	> remove_temporary_files() as well?  Otherwise the -n option would 
	> not be respected.
	> 
	> Also you should consider honoring the --expire option as well.

	How about this on top of David's patch?

 builtin-prune.c  |    9 ++++++++-
 t/t5304-prune.sh |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletions(-)
 create mode 100644 t/t5304-prune.sh

diff --git a/builtin-prune.c b/builtin-prune.c
index 9152984..d5a3b60 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -100,7 +100,14 @@ static void remove_temporary_files(void)
 		if (strncmp(de->d_name, "tmp_", 4) == 0) {
 			char name[4096];
 			sprintf(name, "%s/%s", dirname, de->d_name);
-			printf("Removing abandoned pack %s\n", name);
+			if (expire) {
+				struct stat st;
+				if (stat(name, &st) || st.st_mtime >= expire)
+					continue;
+			}
+			printf("Removing stale pack %s\n", name);
+			if (show_only)
+				continue;
 			unlink(name);
 		}
 	}
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
new file mode 100644
index 0000000..6560af7
--- /dev/null
+++ b/t/t5304-prune.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Johannes E. Schindelin
+#
+
+test_description='prune'
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	: > file &&
+	git add file &&
+	test_tick &&
+	git commit -m initial &&
+	git gc
+
+'
+
+test_expect_success 'prune stale packs' '
+
+	orig_pack=$(echo .git/objects/pack/*.pack) &&
+	: > .git/objects/tmp_1.pack &&
+	: > .git/objects/tmp_2.pack &&
+	test-chmtime -86501 .git/objects/tmp_1.pack &&
+	git prune --expire 1.day &&
+	test -f $orig_pack &&
+	test -f .git/objects/tmp_2.pack &&
+	! test -f .git/objects/tmp_1.pack
+
+'
+
+test_done
-- 
1.5.4.1230.g4ecf8
