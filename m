From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix memleak and the implementation of remove_file in
	builtin-rm.c
Date: Thu, 25 Sep 2008 22:22:37 +0200
Message-ID: <20080925202237.GB18315@blimp.localhost>
References: <87k5d1v71l.fsf@cup.kalibalik.dk> <20080925201245.GB3959@blimp.localhost> <20080925201734.GA18315@blimp.localhost>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 22:24:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KixNW-0006fF-4h
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 22:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877AbYIYUWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 16:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753837AbYIYUWl
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 16:22:41 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:27013 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483AbYIYUWj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 16:22:39 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8AE81p7LJ
Received: from tigra.home (Fab79.f.strato-dslnet.de [195.4.171.121])
	by post.webmailer.de (mrclete mo13) (RZmta 17.4)
	with ESMTP id y0360dk8PJtbcP ; Thu, 25 Sep 2008 22:22:37 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 8F188277AE;
	Thu, 25 Sep 2008 22:22:37 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 83FBB36D1E; Thu, 25 Sep 2008 22:22:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080925201734.GA18315@blimp.localhost>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96793>

Actually, just replace it with the one from builtin-merge-recursive.c,
except for ignoring ENOENT error.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

It is the same as in merge-recursive, but they're so small so unless
we get a special file with such random routines there is no much point
exporting it. Actually, we do seem to have such a file: dir.c. It is
already plagued by file_exists kind of things, why not remove_path...

 builtin-rm.c |   24 ++++++++++--------------
 1 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/builtin-rm.c b/builtin-rm.c
index fdac34f..910a34d 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -31,22 +31,18 @@ static void add_list(const char *name)
 
 static int remove_file(const char *name)
 {
-	int ret;
-	char *slash;
-
-	ret = unlink(name);
-	if (ret && errno == ENOENT)
-		/* The user has removed it from the filesystem by hand */
-		ret = errno = 0;
-
-	if (!ret && (slash = strrchr(name, '/'))) {
-		char *n = xstrdup(name);
-		do {
-			n[slash - name] = 0;
-			name = n;
-		} while (!rmdir(name) && (slash = strrchr(name, '/')));
+	char *slash, *dirs;
+
+	if (unlink(name) && errno != ENOENT)
+		return -1;
+	dirs = xstrdup(name);
+	while ((slash = strrchr(name, '/'))) {
+		*slash = '\0';
+		if (rmdir(name) != 0)
+			break;
 	}
-	return ret;
+	free(dirs);
+	return 0;
 }
 
 static int check_local_mod(unsigned char *head, int index_only)
-- 
1.6.0.2.328.g14651
