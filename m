From: Peter Baumann <waste.manager@gmx.de>
Subject: [PATCH] pack-refs: dereference .git/packed-refs if it is a symlink
Date: Wed, 18 Apr 2007 12:28:23 +0200
Message-ID: <20070418102823.GA5586@xp.machine.xx>
References: <20070417161720.GA3930@xp.machine.xx> <Pine.LNX.4.64.0704172253140.14155@beast.quantumfyre.co.uk> <20070418055215.GA32634@xp.machine.xx> <7v7isajfl1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 12:28:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He7Os-000444-EA
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 12:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbXDRK2X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 06:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbXDRK2X
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 06:28:23 -0400
Received: from magnum.hofmann.stw.uni-erlangen.de ([131.188.23.34]:54178 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1751739AbXDRK2W (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2007 06:28:22 -0400
Received: (qmail 7536 invoked by uid 0); 18 Apr 2007 10:28:20 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 18 Apr 2007 10:28:20 -0000
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v7isajfl1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.14+cvs20070403 (2007-04-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44881>

git-new-workdir creates a new working directory where everything
necessary, including .git/packed-refs, is symlinked to your master repo.
But git-pack-refs breaks the symlink, so you could accidentally loose some
refs. This fixes it to first dereference .git/packed-refs if it is a
symlink.

Signed-off-by: Peter Baumann <waste.manager@gmx.de>
---
 builtin-pack-refs.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index d080e30..afa9b5a 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -89,6 +89,8 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 {
 	int fd, i;
 	struct pack_refs_cb_data cbdata;
+	struct stat st;
+	char *ref_file_name;
 
 	memset(&cbdata, 0, sizeof(cbdata));
 
@@ -113,7 +115,18 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 	if (i != argc)
 		usage(builtin_pack_refs_usage);
 
-	fd = hold_lock_file_for_update(&packed, git_path("packed-refs"), 1);
+	ref_file_name = git_path("packed-refs");
+	if (!lstat(ref_file_name, &st) && S_ISLNK(st.st_mode)) {
+		char *buf = xmalloc(st.st_size + 1);
+		if (readlink(ref_file_name, buf, st.st_size + 1) != st.st_size) {
+			free(buf);
+			die("readlink failed\n");
+		}
+		buf[st.st_size] = '\0';
+		ref_file_name = buf;
+	}
+
+	fd = hold_lock_file_for_update(&packed, ref_file_name, 1);
 	cbdata.refs_file = fdopen(fd, "w");
 	if (!cbdata.refs_file)
 		die("unable to create ref-pack file structure (%s)",
-- 
1.5.1
