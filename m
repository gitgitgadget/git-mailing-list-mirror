From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] fix git-repack for use with GIT_TRACE
Date: Mon, 10 Jul 2006 15:12:54 +0200
Message-ID: <E1FzvZG-0002C1-UN@moooo.ath.cx>
References: <E1Fzta3-00066Z-8B@moooo.ath.cx> <7vwtalbqeo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 15:13:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzvZP-0001nd-8C
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 15:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWGJNNA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 09:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWGJNM7
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 09:12:59 -0400
Received: from moooo.ath.cx ([85.116.203.178]:40924 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S964880AbWGJNM7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 09:12:59 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vwtalbqeo.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23619>

---
Junio C Hamano <junkio@cox.net> wrote:
> This particular one is trying to catch an error condition from
> rev-list.  Shell reports the exit status from the last command
> in the pipeline, and when rev-list notices a corrupt repository,
> it wants to tell pack-objects to stop producing incorrect pack,
> but there is no way other than sending a garbage string (as an
> error message) to cause pack-object to notice there is garbage
> coming in.

Ok, this patch should fix this.  Instead of "echo abort" another more
meaningful message could be used.  I checked the other scripts which
redirect stderr and they should be fine.  In the tests I found
t/t1200-tutorial.sh:38 
t/t1300-repo-config.sh:276
t/t5500-fetch-pack.sh:66
redirecting stderr, which probably fail which GIT_TRACE.

git-cvsserver.perl:2138 has 2>&1 but uses an regexp to match for the
content, so the trace message should not make a problem.  Can someone
using git-cvsserver confirm this?  Perhaps this should be changed to
2>/dev/null anyway.

---

 git-repack.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 640ad8d..4dd7dad 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -43,7 +43,7 @@ case ",$all_into_one," in
 	;;
 esac
 pack_objects="$pack_objects $local $quiet $no_reuse_delta$extra"
-name=$(git-rev-list --objects --all $rev_list 2>&1 |
+name=$( (git-rev-list --objects --all $rev_list || echo abort) |
 	git-pack-objects --non-empty $pack_objects .tmp-pack) ||
 	exit 1
 if [ -z "$name" ]; then
-- 
1.4.1.gf157-dirty
