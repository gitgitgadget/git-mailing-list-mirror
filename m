From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] bisect: squelch "fatal: ref HEAD not a symref" misleading
 message
Date: Wed, 16 Apr 2008 04:09:49 +0200
Message-ID: <20080416040949.26623e13.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Apr 16 07:48:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlx1y-0001dH-SI
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 04:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746AbYDPCEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 22:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753728AbYDPCEf
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 22:04:35 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:50206 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753667AbYDPCEe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 22:04:34 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 14D5C1AB2B9;
	Wed, 16 Apr 2008 04:04:33 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id B0A461AB2B8;
	Wed, 16 Apr 2008 04:04:32 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79667>

To get the current HEAD when we start bisecting using for example
"git bisect start", we first try "git symbolic-ref HEAD" to get a
nice name, and if it fails, we fall back to "git rev-parse
--verify HEAD".

The problem is that when "git symbolic-ref HEAD" fails, it
displays "fatal: ref HEAD not a symref", so it looks like "git
bisect start" failed and does not accept detached HEAD, even if
in fact it worked fine.

This patch adds "-q" option to the "git symbolic-ref" call to
get rid of the misleading error message.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

	Junio C Hamano wrote:
	> Ingo Molnar <mingo@elte.hu> writes:
	> >  dione:~/linux-tmp4> git-bisect start
	> >  fatal: ref HEAD is not a symbolic ref
	> >  won't bisect on seeked tree
	> >
	> >  #
	> >  # Hm. It's not a symbolic ref, and git-bisect just wont do it.
	>
	> Enough people were unhappy with this historical wart and we stopped
	> refusing to "bisect on seeked tree" since b577bb9 (Eliminate confusing
	> "won't bisect on seeked tree" failure, 2008-02-23); you should find it as
	> part of the 1.5.5 release.
	>
	> The disturbing "fatal: ref HEAD not a symref" is still there even though
	> it should be harmless.  The message should be squelched.

	Here is a patch to do that.

diff --git a/git-bisect.sh b/git-bisect.sh
index 408775a..a36778d 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -66,7 +66,7 @@ bisect_start() {
 	# Verify HEAD. If we were bisecting before this, reset to the
 	# top-of-line master first!
 	#
-	head=$(GIT_DIR="$GIT_DIR" git symbolic-ref HEAD) ||
+	head=$(GIT_DIR="$GIT_DIR" git symbolic-ref -q HEAD) ||
 	head=$(GIT_DIR="$GIT_DIR" git rev-parse --verify HEAD) ||
 	die "Bad HEAD - I need a HEAD"
 	case "$head" in
-- 
1.5.5.52.g4aa8
