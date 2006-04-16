From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] reading $GIT_DIR/info/graft - skip comments correctly.
Date: Sun, 16 Apr 2006 14:26:30 -0700
Message-ID: <7v64l9qkjd.fsf@assigned-by-dhcp.cox.net>
References: <20060416123535.GT12638@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 23:26:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVEla-0007Tr-Rr
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 23:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWDPV0f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 17:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWDPV0f
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 17:26:35 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:39870 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750804AbWDPV0f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Apr 2006 17:26:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060416212632.KCCB18224.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 16 Apr 2006 17:26:32 -0400
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20060416123535.GT12638@nowhere.earth> (Yann Dirson's message of
	"Sun, 16 Apr 2006 14:35:35 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18805>

Noticed by Yann Dirson.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

  Yann Dirson <ydirson@altern.org> writes:

  > While looking at allowing empty lines in grafts files, I discovered
  > that comments had already been implemented.  However, current
  > git-read-tree segfaults when there is a comment line in info/grafts:
  >
  > dwitch@gandelf:/export/work/yann/git/git$ cat .git/info/grafts 
  > c118c026e44f02c3dbad00d924285eef2340f700
  > # foo
  > dwitch@gandelf:/export/work/yann/git/git$ git-read-tree master
  > Segmentation fault

  Thanks for noticing.

 commit.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

5bc4ce589646faf72c7a77a5d32d9496ccc8d456
diff --git a/commit.c b/commit.c
index ca25574..05c4c92 100644
--- a/commit.c
+++ b/commit.c
@@ -161,7 +161,7 @@ struct commit_graft *read_graft_line(cha
 	if (buf[len-1] == '\n')
 		buf[--len] = 0;
 	if (buf[0] == '#')
-		return 0;
+		return NULL;
 	if ((len + 1) % 41) {
 	bad_graft_data:
 		error("bad graft data: %s", buf);
@@ -192,6 +192,8 @@ int read_graft_file(const char *graft_fi
 		/* The format is just "Commit Parent1 Parent2 ...\n" */
 		int len = strlen(buf);
 		struct commit_graft *graft = read_graft_line(buf, len);
+		if (!graft)
+			continue;
 		if (register_commit_graft(graft, 1))
 			error("duplicate graft data: %s", buf);
 	}
-- 
1.3.0.rc4.g4024
