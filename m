From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] ls-files: debugging aid for CE_VALID changes.
Date: Wed, 08 Feb 2006 21:50:18 -0800
Message-ID: <7vd5hxgjxh.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	<Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	<46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	<1138446030.9919.112.camel@evo.keithp.com>
	<7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	<1138529385.9919.185.camel@evo.keithp.com>
	<43DCA495.9040301@gorzow.mm.pl> <20060130225107.GA3857@limbo.home>
	<Pine.LNX.4.64.0601311314030.7301@g5.osdl.org>
	<20060131220148.GA19411@steel.home> <20060201013901.GA16832@mail.com>
	<Pine.LNX.4.64.0601311747360.7301@g5.osdl.org>
	<Pine.LNX.4.64.0601311807470.7301@g5.osdl.org>
	<7vek2di043.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>,
	Keith Packard <keithp@keithp.com>, cworth@cworth.org,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Feb 09 06:50:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F74hE-0000WO-0V
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 06:50:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422806AbWBIFuV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 00:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422809AbWBIFuV
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 00:50:21 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:52466 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1422806AbWBIFuV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 00:50:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060209054913.WAPW15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 00:49:13 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15791>

This is not really part of the proposed updates for CE_VALID,
but with this change, ls-files -t shows CE_VALID paths with
lowercase tag letters instead of the usual uppercase.  Useful
for checking out what is going on.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 ls-files.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

775ca05ee2ba7e1f54ec4db1fed7069014364f2c
diff --git a/ls-files.c b/ls-files.c
index 6af3b09..3f06ece 100644
--- a/ls-files.c
+++ b/ls-files.c
@@ -447,6 +447,22 @@ static void show_ce_entry(const char *ta
 	if (pathspec && !match(pathspec, ce->name, len))
 		return;
 
+	if (tag && *tag && (ce->ce_flags & htons(CE_VALID))) {
+		static char alttag[4];
+		memcpy(alttag, tag, 3);
+		if (isalpha(tag[0]))
+			alttag[0] = tolower(tag[0]);
+		else if (tag[0] == '?')
+			alttag[0] = '!';
+		else {
+			alttag[0] = 'v';
+			alttag[1] = tag[0];
+			alttag[2] = ' ';
+			alttag[3] = 0;
+		}
+		tag = alttag;
+	}
+
 	if (!show_stage) {
 		fputs(tag, stdout);
 		write_name_quoted("", 0, ce->name + offset,
@@ -503,7 +519,7 @@ static void show_files(void)
 			err = lstat(ce->name, &st);
 			if (show_deleted && err)
 				show_ce_entry(tag_removed, ce);
-			if (show_modified && ce_modified(ce, &st))
+			if (show_modified && ce_modified(ce, &st, 0))
 				show_ce_entry(tag_modified, ce);
 		}
 	}
-- 
1.1.6.gbb042
