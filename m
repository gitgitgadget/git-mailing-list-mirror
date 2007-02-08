From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git log of all (modifying) commands run on a repo?
Date: Wed, 07 Feb 2007 16:26:46 -0800
Message-ID: <7v8xf94hq1.fsf@assigned-by-dhcp.cox.net>
References: <17866.20355.744025.133326@lisa.zopyra.com>
	<Pine.LNX.4.64.0702071441160.8424@woody.linux-foundation.org>
	<7vd54l60gg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702071525270.8424@woody.linux-foundation.org>
	<7vtzxx4k1c.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702071539390.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 01:27:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEx84-0001kA-Lm
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 01:27:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933348AbXBHA0t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 19:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933350AbXBHA0t
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 19:26:49 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:42037 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933348AbXBHA0s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 19:26:48 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070208002648.QTLF1349.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Feb 2007 19:26:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LoSn1W00R1kojtg0000000; Wed, 07 Feb 2007 19:26:47 -0500
In-Reply-To: <Pine.LNX.4.64.0702071539390.8424@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 7 Feb 2007 15:46:32 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39019>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> With "--pretty=oneline --abbrev-commit" I'll agree that it's actually 
> fairly pretty.
>
> Maybe we can make "-g" default to that? As it is, I'd otherwise still use 
> "less" just because there is less typing...
>
> 			Linus

Well, you would not know if the user gave you '-g' before you
ask setup_revisions() to parse the options, and once you let it
do its thing, you would not know if it also found an explicit
output format given by the end user, so your cannot sanely make
default depend on '-g'.

I suspect that it would have to be either somewhat involved or
outright hacky.  

---

 builtin-log.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 982d871..0221c76 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -22,8 +22,21 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 {
 	int i;
 
-	rev->abbrev = DEFAULT_ABBREV;
 	rev->commit_format = CMIT_FMT_DEFAULT;
+	if (!strcmp(argv[0], "log")) {
+		/* first see if there is "-g" */
+		for (i = 1; i < argc; i++) {
+			if (!strcmp("--", argv[i]))
+				break;
+			if (!strcmp("-g", argv[i]) ||
+			    !strcmp("--walk-reflogs", argv[i])) {
+				rev->abbrev_commit = 1;
+				rev->commit_format = CMIT_FMT_ONELINE;
+				break;
+			}
+		}
+	}
+	rev->abbrev = DEFAULT_ABBREV;
 	rev->verbose_header = 1;
 	rev->show_root_diff = default_show_root;
 	argc = setup_revisions(argc, argv, rev, "HEAD");
